Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C92C3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 16:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42C5180C83;
	Mon, 12 May 2025 18:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gIxY1Xny";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="n34/+hDB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91F8981DD6; Mon, 12 May 2025 18:11:59 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73555805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 18:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Zx4P90vd8z9stB;
 Mon, 12 May 2025 18:11:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747066317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6GT4pVPGub7tDbc58g9+FPybqSJRKW5wJe3U8q8RXcU=;
 b=gIxY1Xnym2APo+KqHIjHKfyPvNBwn466iFweNRiPsalw9U2B+RDiGfrc3B+efsMNdGVE9F
 uWOKUHaVaphN2m9zQEkfORlqYEB1lDVI5LH9PRhHVnBhdyMI+5bLPmJIJci/AupcBzOORp
 flyL6cTcozPH2fABgJimAKFv1w8xo/F3SSej62u4IrINcJDC56KvyibljxfEN4GWhSvyaE
 MxZBF3q/R83yJPQd5SY0r+9Yv4Eej0xVNilBiwo8Rh5ATvQUf+XhyzlKaErISPN9GapxNR
 M4gzAEOL/1HtzHfhjVk8VEn5yZwLcL9I5qIHLWNI4tt2b4ACqiVx8htVaYhhZA==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747066315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6GT4pVPGub7tDbc58g9+FPybqSJRKW5wJe3U8q8RXcU=;
 b=n34/+hDB2rWIBC9Kbm2EvQYDvqIjobmGyOuv/+QDiucqS56stA4fIdoO2MBL4vkz6rbep+
 mQr+72OJW7rMcYdHrzaeiSfPHcaC7h/SaEtVJesbeP0LZEDBwVKNhmj/SAieNMr53wHK21
 S/3v1QSk+523M1ajKZS3X2Tajkk4pGP9hXc4lempGn++MyeK6UHpCgdNy35y1kQ5RMIG+a
 v4GDlL+ecCX5Kq1sCPHoMWCCdRX2ti/hTkU7PELp1te4yu7W8kPFs8zQJeS85iySTwUodD
 U9cnZ377X/XF/32EnJqRO/ziD2nmBhf9uRSR2Wiyax8f7h1SYSICBS0y6xXaSg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Drop unnecessary space
Date: Mon, 12 May 2025 18:11:37 +0200
Message-ID: <20250512161146.146658-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ebfkdpkztm9g8nukfibbxq3sfh5jos7u
X-MBO-RS-ID: 566b448db9e56e532bc
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

Drop a space after tab, no functional change.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
index 4f1d783649b..caeeeca863c 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
@@ -67,7 +67,7 @@
 #define BOOTROM_PARAM_ADDR	0x2FFC0078
 #define BOOTROM_MODE_MASK	GENMASK(15, 0)
 #define BOOTROM_MODE_SHIFT	0
-#define BOOTROM_INSTANCE_MASK	 GENMASK(31, 16)
+#define BOOTROM_INSTANCE_MASK	GENMASK(31, 16)
 #define BOOTROM_INSTANCE_SHIFT	16
 
 /* Device Part Number (RPN) = OTP_DATA1 lower 8 bits */
-- 
2.47.2

