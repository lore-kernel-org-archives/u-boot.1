Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCB7CD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 19:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB304846D3;
	Sun, 17 May 2026 21:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="oH0UgBL/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8E2E8466F; Sun, 17 May 2026 21:25:07 +0200 (CEST)
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7A208467A
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 21:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
 by forward103b.mail.yandex.net (Yandex) with ESMTPS id CD273C005C;
 Sun, 17 May 2026 22:25:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id mOVI2m4SD0U0-hlciowUS; 
 Sun, 17 May 2026 22:25:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779045902; bh=3k6KVwSO8s22nNwssIV4Dg/kqNgTzMjRPH5njY85fjw=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=oH0UgBL/7tHy6q68cczd7G3u41e/evAuQD3t4BHhv+gWbI18Ff7XE9cJ2gdTq9FG6
 m8KvXOWRHC734V+OlnnrkzlZONZjTe6BsfNd8pvhakYUnS2goSilACrlbM2D7/78BQ
 1d58UoGAe+lbGW++bHspM+KC6BKZkUFW/gRESOvo=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
From: Pavel Golikov <paullo612@ya.ru>
Date: Sun, 17 May 2026 22:24:35 +0300
Subject: [PATCH RFC 09/18] ram: rockchip: Add 4 ranks support to controller
 code for PX30
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-rk3568-raminit-v1-9-a24e16302a13@ya.ru>
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

RK3568 ram initialization code uses helper function from PX30
controller. RK3568 pctl supports 4 memory ranks. Handle this properly
when modifying pctl's PCTL2_MSTR register by clearing bits for all four
ranks before applying detected DRAM rank configuration.

Signed-off-by: Pavel Golikov <paullo612@ya.ru>
---
 drivers/ram/rockchip/sdram_pctl_px30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ram/rockchip/sdram_pctl_px30.c b/drivers/ram/rockchip/sdram_pctl_px30.c
index 3ec98af536e..0f42c191dc3 100644
--- a/drivers/ram/rockchip/sdram_pctl_px30.c
+++ b/drivers/ram/rockchip/sdram_pctl_px30.c
@@ -149,7 +149,7 @@ u32 pctl_remodify_sdram_params(struct ddr_pctl_regs *pctl_regs,
 		}
 	}
 
-	tmp &= ~((3ul << 30) | (3ul << 24) | (3ul << 12));
+	tmp &= ~((3ul << 30) | (0xful << 24) | (3ul << 12));
 
 	switch (cap_info->dbw) {
 	case 2:

-- 
2.25.1

