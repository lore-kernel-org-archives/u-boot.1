Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C0ACD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 19:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45DAA8470E;
	Sun, 17 May 2026 21:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="laAzug/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03FB28460E; Sun, 17 May 2026 21:25:12 +0200 (CEST)
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EF0E8469A
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 21:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
 by forward102b.mail.yandex.net (Yandex) with ESMTPS id 94346C0084;
 Sun, 17 May 2026 22:25:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id mOVI2m4SD0U0-kykV7nM3; 
 Sun, 17 May 2026 22:25:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779045909; bh=UkeHgl1P4qF3YTavpPgeZPHDxQTShARaH8YuI4JQyow=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=laAzug/godx9toAgFIXH6ZOkZzj5DrYLCOdpqoriMrJ3butzFRPZ6sVl6N0xirv8I
 kNBfL/VOQgYeoE+Gzx6wABP1m2O38UUBD1xpcxvIP39nTo2lPjt0Z6jnc/4J2+mLIX
 TsSWXJMZN33jUl+Ta5r301KMhCn1FK+etBg506Oc=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
From: Pavel Golikov <paullo612@ya.ru>
Date: Sun, 17 May 2026 22:24:42 +0300
Subject: [PATCH RFC 16/18] rockchip: serial: Add driver alias for rk3568
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-rk3568-raminit-v1-16-a24e16302a13@ya.ru>
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
In-Reply-To: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yao Zi <me@ziyao.cc>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut%2Brenesas@mailbox.org>, 
 Pavel Golikov <paullo612@ya.ru>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sun, 17 May 2026 21:26:22 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

To fix warning when building with CONFIG_OF_PLATDATA enabled.

Signed-off-by: Pavel Golikov <paullo612@ya.ru>
---
 drivers/serial/serial_rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/serial/serial_rockchip.c b/drivers/serial/serial_rockchip.c
index 8a15173f238..98d4deac3c1 100644
--- a/drivers/serial/serial_rockchip.c
+++ b/drivers/serial/serial_rockchip.c
@@ -54,3 +54,4 @@ DM_DRIVER_ALIAS(rockchip_uart, rockchip_rk3188_uart)
 DM_DRIVER_ALIAS(rockchip_uart, rockchip_rk3288_uart)
 DM_DRIVER_ALIAS(rockchip_uart, rockchip_rk3328_uart)
 DM_DRIVER_ALIAS(rockchip_uart, rockchip_rk3368_uart)
+DM_DRIVER_ALIAS(rockchip_uart, rockchip_rk3568_uart)

-- 
2.25.1

