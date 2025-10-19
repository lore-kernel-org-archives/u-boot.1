Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BF1CCD183
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 09:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 676B783849;
	Sun, 19 Oct 2025 11:24:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c4jVQWcA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBE48836D1; Sun, 19 Oct 2025 11:23:59 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D4B8386B
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 11:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-781010ff051so2549077b3a.0
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 02:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760865836; x=1761470636; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=H4FUeAMUzNZrglwNJ8tMUgowrhVHRjZhe24VNI5GSPc=;
 b=c4jVQWcARHTWg7ib22vbsj6br1cohqyJsPWIB7j/jOyxBmm9668Wf/dY/RDrWjPnxF
 eDF8UsbhrxQ/lbtdWuYVIxsGNpDHWztJ+plNG6qxU8kbD5kjA6mbYXCnJ4wYqdYvI9pT
 axDQH3VzmbGlRaVG9Xz0TAtxqoEDJTRvIt9IPvCKA2l5k97Ekj5awhPdo5icTeyJ7On1
 AwlZ/aCmr0Xq/UXnFoOlrYFxMFIUZqJdO+rEXiw3eFiP/YeC5TKP/YDE6hgDnTqmw3u9
 GQuTlo4+XDb3Jrm/XuATlI6A//dWmtao18SGyV+wfyovafaB3ii+GTh8wYCVOPiyZurS
 8aLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760865836; x=1761470636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H4FUeAMUzNZrglwNJ8tMUgowrhVHRjZhe24VNI5GSPc=;
 b=jGVkocsPDSGPJ4U17D8rtSIkWjZxd3MOtQf98wMyLKpDqKZV4tHOsOnZZTnIbbSPP9
 vEENVvOVhx2ZwmEu2fB6/sLKF5485wpPS42ChN1HUZFvM/osA+CpdmQFkKo8WkqR1l5E
 p7Yt2/WXcBrFseFQVZsW0LouO7NcCB06KzKdi6tWHl8BY6F7MVK0238it0HzLtI2nWaY
 VXES365I9zqpgOyvxf5av9zASkRThOYCISfD7tQrciwhRv+vLJLklzo5Rr5dShLbLeWD
 zyw/6HsrUf0HZKzHMMeWrVI3P6UTWSfwxjSBGL2zlcrAGaoKet34Pa0IEdImUJn84kQ3
 BjPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBfQAcRf1wkEKXJvYFhWoxXaEfmwP2Y5oQ5gYVr3NKQzXnCiIVOB2AgRW0ACd9Uua9nXmFAOY=@lists.denx.de
X-Gm-Message-State: AOJu0YxHaEChIvUgSZreAyObL87OPBoFMxBwbFhkCWRgJFmlhF367ebo
 hOy1LSrhX3cwTgmNISZ/8lmZZUPwEuU2HQzLyw1l3yc4z4hjDj6Xm8Y63KoiezaEeeg=
X-Gm-Gg: ASbGnct1aBuT3ysViraI3DEIeGniMLPR0h/B4OOMRe7ZiIDTc1AY8GvOXj6lkHj9FoN
 uvU9xHad46p+anGvQd1exM9OmUauSg5mVlWswPsGyqIH6gMskQ64q7hNByCOW6Ies0ovg+l341Y
 MdAj3ntW2G3KDNcqbO+n1lZbm7sWqk5vYjTtUYMeDowpp8CJuOMvt5jDHtdhPhdwWwe5MGbPkNB
 XXF/LXZQYxvDpELK7SL9PLb6hxoDMfi5CMsNH+m7bVPvPJR4yh7tVvmqsFs3+hxC1yPiNPDQtZW
 oV95iAvUaIbyCnqMvz8KC/RzrH2Q6YQf68xLSTiQS7CfNkAonXhgRelutKM1nMfcXP2zeNbPrB1
 ghn3Ohx2u8SlaCthfLpq6yI0MjPWNo8r3MicxOyAo9zJkm2NqNjlch3jEdYRfVvY2vJsi8U1AgX
 gOQgm0l0qBcwJIeoUuaxZ9XG9I8ypPz7ALGRfq
X-Google-Smtp-Source: AGHT+IGP9qblt7ZOX1YwVDf5rSxS3GZvCX/dTzf6uTkgL+2J7gvqEEs+wBqv1NDPecF0EtF4vA/LrA==
X-Received: by 2002:a05:6a00:14c8:b0:782:2b62:8188 with SMTP id
 d2e1a72fcca58-7a220b1077emr12265450b3a.15.1760865835726; 
 Sun, 19 Oct 2025 02:23:55 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.51])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a23010da0bsm4955968b3a.55.2025.10.19.02.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 02:23:55 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH] Altera SoCFpga Boot Stall Fix
Date: Sun, 19 Oct 2025 17:23:41 +0800
Message-ID: <20251019092341.1158-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: tg5 <briansune@gmail.com>

Since U-Boot 2025.07 pure SD Card
boot no longer works. Now Altera released 2025.07
shows the different on the u-boot files.
After testing, the major root case is
get_managers_addr. And this patch fix the
SD boot stall via pulling from offical.

Signed-off-by: tg5 <briansune@gmail.com>
---
 arch/arm/mach-socfpga/misc.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 97e01140513..11ab8f17489 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -177,7 +177,10 @@ int arch_cpu_init(void)
 	 * timeout value is still active which might too short for Linux
 	 * booting.
 	 */
+#if !(IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5_SIMICS) || \
+	IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5_EMU))
 	hw_watchdog_init();
+#endif
 #else
 	/*
 	 * If the HW watchdog is NOT enabled, make sure it is not running,
@@ -222,8 +225,16 @@ static int do_bridge(struct cmd_tbl *cmdtp, int flag, int argc,
 
 U_BOOT_CMD(bridge, 3, 1, do_bridge,
 	   "SoCFPGA HPS FPGA bridge control",
-	   "enable [mask] - Enable HPS-to-FPGA, FPGA-to-HPS, LWHPS-to-FPGA bridges\n"
-	   "bridge disable [mask] - Enable HPS-to-FPGA, FPGA-to-HPS, LWHPS-to-FPGA bridges\n"
+	   "enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2), F2SDRAM0 (Bit 3), F2SDRAM1 (Bit 4), F2SDRAM2 (Bit 5) bridges\n"
+	   "bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2), F2SDRAM0 (Bit 3), F2SDRAM1 (Bit 4), F2SDRAM2 (Bit 5) bridges\n"
+	   "Bit 3, Bit 4 and Bit 5 bridges only available in Stratix 10\n"
+	   "For example:\n"
+	   "1) To enable and disable all bridges (command without mask):\n"
+	   "	a) bridge enable\n"
+	   "	b) bridge disable\n"
+	   "2) To enable and disable HPS-to-FPGA and LWHPS-to-FPGA bridges (command with mask):\n"
+	   "	a) bridge enable 0x3\n"
+	   "	b) bridge disable 0x3\n"
 	   ""
 );
 
@@ -260,7 +271,15 @@ void socfpga_get_managers_addr(void)
 	if (ret)
 		hang();
 
-	if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX))
+	if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)) {
+		ret = socfpga_get_base_addr("altr,sys-mgr",
+					    &socfpga_sysmgr_base);
+		if (ret)
+			hang();
+	}
+
+	if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) ||
+	    IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M))
 		ret = socfpga_get_base_addr("intel,agilex-clkmgr",
 					    &socfpga_clkmgr_base);
 	else if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X))
-- 
2.25.1

