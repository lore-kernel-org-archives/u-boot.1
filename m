Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B8AC7115A
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 01:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01C5688A3E;
	Thu, 29 Aug 2024 03:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="t1RzZmuW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="n4Ucyk+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C79D886A3; Thu, 29 Aug 2024 03:23:05 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1141C88A58
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 03:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WvNnf5vBPz9sjB;
 Thu, 29 Aug 2024 03:23:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724894582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ou1RjCH/IGLzGGeYpJ6mBsUGWAAFylSeA+9nzlDWFIk=;
 b=t1RzZmuW6DSgpFkWYR4LHembNwm9GVXBjShNTl4UrHnp5ns3XC06JQwxw45UbWAySuGV4Z
 EpHnh7omN+FvpnhYbCcTgwk2dPIaHpqLYL2GIneWcH0EIGzY0cRkCDyj/JGbzLLmLed1rU
 gxLtVFCy/CcOP1YtIDmpV2Tcj4JZts1j4DXZ+RcrMYyV7SceBZQ/O6sUvvtQMBm6gLb506
 qKt8EGNJO8kCpFKS8mYB5ERtMCxSJzEBjB7PrLAC2C0Mw5PifeEnrZ42x+1lDfmEuvKWD5
 Xxp5ntpa6D9gHOhQiXm3bAhKN+3YSNyLBxAfAsiB3MfZSRsBfkoUiY9yruh4BQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724894581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ou1RjCH/IGLzGGeYpJ6mBsUGWAAFylSeA+9nzlDWFIk=;
 b=n4Ucyk+5tpdPAWSsEEZ64HJJKATve7DXZtizBhraQfUyhlyoATmOKNI11syuj4TR8iAV47
 CvOwp3XB0U++MBusaHH/o/9Uzc0uFXiup7wyubK1JB22i+4DPqJJ/GvDwsCCy94FdS3WAL
 Lz44FVw6D1mv7np13PxeGqS7GSYXkxO3Y31DCmRCcT0iIpGOqnTp2pzeSd9XTl0I8ePHpR
 2zz2fdmVziE5mQZmRiI0EOTt52N8zYoZfQhjXst6bOCouCcTcVT3XziNPdS+Cf2d5uOgpx
 SBfaWf+y9Y8x7cJnJSDbVn7sMCnmfox9QizepB/ZkEx+Y8ce9sZwPYGpCtvavg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: imx: Wrap i.MX config options in HAVE_IMX
Date: Thu, 29 Aug 2024 03:22:29 +0200
Message-ID: <20240829012247.179471-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6f02b75051bf9b3efac
X-MBO-RS-META: 5o96effb7cdpbhcsdyc9mskt59hawots
X-Rspamd-Queue-Id: 4WvNnf5vBPz9sjB
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

Wrap all the i.MX specific options in HAVE_IMX, otherwise they keep
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

