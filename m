Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5059CCD4F48
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 19:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 450BD8469A;
	Sun, 17 May 2026 21:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="U7wedKk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBED684690; Sun, 17 May 2026 21:24:59 +0200 (CEST)
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE0D283EF9
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 21:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
 by forward103b.mail.yandex.net (Yandex) with ESMTPS id 122DBC0038;
 Sun, 17 May 2026 22:24:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id mOVI2m4SD0U0-55PbZCEl; 
 Sun, 17 May 2026 22:24:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779045895; bh=8vmHBKu6B7/nRBHGas4bpoOavUE98Xd6XHtMJzMF+9Q=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=U7wedKk28YkbCfw1SZqmU3Gi4/tQbP5Dln9gITrpZp/xAnfHkQCSV1Zqn2NGB8p2q
 nJ7g9SBbLsFdgiYlwgY3PlGZxBFPQ09/f2ZubdR2lqmFHx5ZkC9j9JsftDFResouxg
 yYvoWtyiTdBKBOfqP4QpMQUT2F2+tscQqT53wpZE=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
From: Pavel Golikov <paullo612@ya.ru>
Date: Sun, 17 May 2026 22:24:29 +0300
Subject: [PATCH RFC 03/18] rockchip: rk3568: syscon: Add PMUGRF support for
 OF_PLATDATA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-rk3568-raminit-v1-3-a24e16302a13@ya.ru>
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

The RK3568 has a limited TPL size, so, we expect RK3568 to always use
OF_PLATDATA for its TPL stage.

Add support for the PMUGRF register region in syscon, which is necessary
for RK3568's DRAM controller initialization.

Signed-off-by: Pavel Golikov <paullo612@ya.ru>
---
 arch/arm/mach-rockchip/rk3568/syscon_rk3568.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c b/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
index 255259eabfd..b9d59a4721e 100644
--- a/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
@@ -21,3 +21,20 @@ U_BOOT_DRIVER(syscon_rk3568) = {
 	.bind = dm_scan_fdt_dev,
 #endif
 };
+
+#if CONFIG_IS_ENABLED(OF_PLATDATA)
+static int rk3568_syscon_bind_of_plat(struct udevice *dev)
+{
+	dev->driver_data = dev->driver->of_match->data;
+	debug("syscon: %s %d\n", dev->name, (uint)dev->driver_data);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(rockchip_rk3568_pmugrf) = {
+	.name = "rockchip_rk3568_pmugrf",
+	.id = UCLASS_SYSCON,
+	.of_match = rk3568_syscon_ids + 1,
+	.bind = rk3568_syscon_bind_of_plat,
+};
+#endif

-- 
2.25.1

