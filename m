Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD17CF2562
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 23:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA756839AC;
	Wed, 19 Nov 2025 00:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Q4RLdEiS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EgI9Ha6t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DADA83A41; Wed, 19 Nov 2025 00:19:39 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F39183946
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 00:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dB0tw6Jbyz9vCF;
 Wed, 19 Nov 2025 00:19:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763507976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=okybwcElsdWAqbaZxs7FBhOzE6lXSfk5tjBX5/Z1iMo=;
 b=Q4RLdEiSb0wUxK54Zj1BYPWS37oXJcsHIw5zcul+0b1bFcc5EhgGhj4Wyeqb3gLjan8T0/
 KDGz6lUqh077mUKntVbXZTrpAv++7Od0wLREr2Yr/JnIpul654Kit85Zn9lLqNPF3wUZIa
 nBMqIGpDLpra+oQjLyGattz7xr7/t4tUniVPCe8GnPtY38eIYbswkLapRcl2ZbwQRNYsRZ
 N+/KpCpcX1vhXqGelZIMkBNr8CY9HD4QQLXUmLxyg/gVjc0tYETlBfVKfMGmL3Z+j+hUl4
 Cai7UziGrgfO3dT4oOdO1h8l0vig6H6/5vie+p/kqIG4oEiMhQv3DVlC6HgzqQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=EgI9Ha6t;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763507975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=okybwcElsdWAqbaZxs7FBhOzE6lXSfk5tjBX5/Z1iMo=;
 b=EgI9Ha6t3o5YB5svr3QZI24IrRUOCmtqgotg1VrCR51UAS/G0aPxmD7y+SS8Nr1uUGF6d+
 +jDQO20cxcHjR8+JMJQgsq7fL7JaY8xO1HD3qeB3bZDcDuskUW5vHufKRoHI+yuD0TlWfP
 Y3IaARHnoBH1eDYpz+4FGruX1pUakEKY5hZbDH58J5221sNO9eKXh75FPDGfHMH1sbCNVN
 CuPdIug3j8ieQINvJn+BGKWXX2qYmrj2y9YyXx6mgDmgBi2vayzi4N8CcEYKO/nIpZRN/D
 UUDz+nrJhv1WZrw36jXPo5XAkBMGSQHQK3Rwy+ZI5Ky+dMVPWIxBkdPWCcp3jQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: Fix 512 MiB DRAM settings for DH STM32MP13xx
 DHCOR SoM
Date: Wed, 19 Nov 2025 00:19:17 +0100
Message-ID: <20251118231933.577980-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: t7j4teuowg5p6fdj7imcamd68s5bz7gu
X-MBO-RS-ID: 6085fe16227dbdedc2d
X-Rspamd-Queue-Id: 4dB0tw6Jbyz9vCF
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

Update DRAM chip type and density comment for 512 MiB DRAM settings for
DH STM32MP13xx DHCOR DHSBC to match the chip on the SoM. No functional
change.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13-ddr3-dhsom-1x2Gb-1066-binG.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/stm32mp13-ddr3-dhsom-1x2Gb-1066-binG.dtsi b/arch/arm/dts/stm32mp13-ddr3-dhsom-1x2Gb-1066-binG.dtsi
index 7b344541c3e..b464c04aa2b 100644
--- a/arch/arm/dts/stm32mp13-ddr3-dhsom-1x2Gb-1066-binG.dtsi
+++ b/arch/arm/dts/stm32mp13-ddr3-dhsom-1x2Gb-1066-binG.dtsi
@@ -3,13 +3,13 @@
  * Copyright (C) 2025, DH electronics - All Rights Reserved
  *
  * STM32MP13xx DHSOM configuration
- * 1x DDR3L 1Gb, 16-bit, 533MHz, Single Die Package in flyby topology.
- * Reference used W631GU6MB15I from Winbond
+ * 1x DDR3L 4Gb, 16-bit, 533MHz, Single Die Package in flyby topology.
+ * Reference used W634GU6RB11I from Winbond
  *
  * DDR type / Platform	DDR3/3L
  * freq		533MHz
  * width	16
- * datasheet	0  = W631GU6MB15I / DDR3-1333
+ * datasheet	0  = W634GU6RB11I / DDR3-1866
  * DDR density	2
  * timing mode	optimized
  * address mapping : RBC
-- 
2.51.0

