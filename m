Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB483CD3425
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 00:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 094BE88835;
	Sun,  1 Sep 2024 02:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ohD2BXsy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yJgwXUrA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66FEC88835; Sun,  1 Sep 2024 02:38:34 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0583D8876F
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 02:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WxCft5Wf1z9scL;
 Sun,  1 Sep 2024 02:38:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725151110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4A1Sj/StT60ESv8BeIMvJYm7VLqJv0tNGtyIWmSIz70=;
 b=ohD2BXsyMm59BZNzPpAi6BUzI9EBj/QnBDC66M+tO158xWY1cF7o/kQgjFHJR6Fq/rBPr/
 AvSPjc2CpTKiuTRaoZKk1jKCsFdlGGB0FQucz/0J6dXGV4afQmVCM0aFVvaNW7Fn9E31PW
 rCW6GJRKJgcbo/5zH8RiH0ZSwNx/ixr8tdwNrkARo4/IRA5PHe95f9En2qUG1R0L023ns1
 PpURAxkJhT18j9WzBDQZovCE4+8zj0MctUdmS/8aZwCPtUU/QttGvub9FyJjJit83j0AQi
 wNuQ85pt+N4/30Nt5HcI08chucRSlcrGP++7yBVlOqNQTikbqQOe3g5SJ8wMvw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725151108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4A1Sj/StT60ESv8BeIMvJYm7VLqJv0tNGtyIWmSIz70=;
 b=yJgwXUrAzv1GJKXFgj3BbCuYAEbzec2XGVdvkgsdB96ObRK6bPqS50vD3LfY5DA/oq3rB5
 j45P+q+wgEnH2PIDbhyKByZJ6XaAqMrDuhjqfYlY/A6xu/ozXXiEsDgKbHhGSP7Jgv0vc9
 A4hvgTFRsO+/pB6RXgG8G8/d3zHrBDJuGu18oyDNqt1Rnarcj7aQVI+IDwBdoMZryuEFF8
 8JHOMTuBn+MKWx9Jv0TZMSgf7wDjlVwadynS7kAQDJw3EBFTVAEv5ZsEL3C7bTRorB02KH
 V48wkz6xFUrIkfTGxkM98/fuLuKCPYyW1Fm4wjQsoOy052GdDBFoTJNi76hxuA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] ARM: imx: Wrap i.MX config options in MACH_IMX
Date: Sun,  1 Sep 2024 02:38:00 +0200
Message-ID: <20240901003813.674730-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: q5ob5s364zffx3onwbpey5eki6nh4pgw
X-MBO-RS-ID: ecd1402a1afc58b81da
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

Wrap all the i.MX specific options in MACH_IMX, otherwise they keep
showing up in other SoC vendor configurations. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: s@HAVE_IMX@MACH_IMX@g
---
 arch/arm/mach-imx/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c34bc25c0bf..134e42028c3 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,6 +1,8 @@
 config MACH_IMX
 	bool
 
+if MACH_IMX
+
 config HAS_CAAM
 	bool
 
@@ -200,3 +202,5 @@ config IOMUX_LPSR
 
 config IOMUX_SHARE_CONF_REG
 	bool
+
+endif
-- 
2.45.2

