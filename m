Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA0DCCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 13:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E90D82C84;
	Mon, 20 Oct 2025 15:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dKeEKBLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC7382E34; Mon, 20 Oct 2025 15:31:19 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7AEB807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 15:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b550eff972eso2958951a12.3
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760967075; x=1761571875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ajeWYi1TySQjgdiqqvayBiMKGEkZ1WZH7xNp8PA/rHQ=;
 b=dKeEKBLxCKFX1F2o8uF2+qyLtDkfbedUGowotmCEcDXCn3AjTuuArz/ztppyrY34AU
 w4xFQFLjPlaI/OQxNf+TCEiEsIx+mkYYlSLk3ORRAGPCtcTfTi1svl81UPjxlO/qz2j7
 teVisX01VYcMmRjgppX3hYR2BbHqDGl68NsXk+AYHQgrtf2mUb2pmAXIbrUHgyEpH1Tt
 Yje9GFDYszyjvm1JZLyBpo5Zx7dudcrE8hMOGCQKErOJJPVVMebUC3nNAM3ijm7gSn9J
 fiNZHWy5rstcXXDqYcRtKDwooxJ8zXQw6gmWcjoESH3vY03MMROjmtUTfRrDw6xFL4tT
 wO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760967075; x=1761571875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ajeWYi1TySQjgdiqqvayBiMKGEkZ1WZH7xNp8PA/rHQ=;
 b=rm/5PV8f+gtwFkImc6/JHK+gyZ5sxkXKZqbWzv7ts+ZEcqgCEimN+AvfM7YH4nRfjp
 HYTkhbYVPDB0x8uFMzDwR1/gBZ7wc+S0mmn4mISRo+jXLgn4sH9xZA1GZLAmkbXS5Epf
 GX7mzsK/qvakYU2ZZ9RHqz9Vkwc8DNE2ImuLjZkHkk9mloXSMtfmK1qJmgWRe8uQuiwQ
 CHFThLdHC4ptQDu2K9839pt2YH5sk76mkjPGjekPBZNG87I6AX72ahmByqo6ddky2HFO
 dVs6zFLxWN87rBs2rciEeRfufjSQo+Mb0DPEo/0auWZlyesVnlomC+cAp941KBgc+FMW
 FRVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfwAS3C/CVAKWVjHnH2VJYD+cAmoZ6HPzXizhS4fM1rHdr9ueN+08zjfv25KjQWg4ZCQ2TVyI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx72/JJA+OLZDHcuIFuPqd7eJdKOKhZaOM5ODmJbafZzoCRYZuH
 sP8ihD15guazl81XWYhjx2M9q7mD3rHRY8+0SRb1YjNbm3DfYEgOcgCIfY7d0zYe
X-Gm-Gg: ASbGnct/WUeADYAHZGGVDdIT8UgDh0njvyC63jg+QpjzD/XS9NSc+9U1Sm1YE8+msiB
 gQN4KzmzqLbkyY8FoNA/mCuplh/VRwwGElXCkF73lQ6cHOKUi8shZnzscD2mRxokXLip6gX9Xfy
 AfeiYk66S7HaKfZO73Io5cWFsvHlfC9YHk0yw4DAnSXRI5U50abQ6jLHIQ5ibXoohiSq9DLOsli
 F6Yw3vOvNo+fxLu6xk/tKaEBzsXkjnGzxNGjdNUPw62KyGS6M3porhOb3L8yvZKFb2AawI6oX5q
 DDG2dp0TlMT93DrmL/YfmaHp0ZY0e6o+kbMjpTqTFeMuN2hUqhib73jwD5jYjRsnqHVm2Ft8mzw
 Ta4W7vwtM6h+11CenvZBW/etPqxkeyDPpH2M1EtrHsDWpTzNGM4IqsGrv/S/umH6TfrW7ECr364
 fnCBhRGZrCjhc1+l7jNCTIzVa/daTdsRUIRlet
X-Google-Smtp-Source: AGHT+IG7jw0aFY9k2Pf2qC7yuDrfa4PwyrptBD95CwepRGBIf/csyAJS8Ouwuen0TADFBlVWNO5mcQ==
X-Received: by 2002:a17:903:b0e:b0:25c:d4b6:f111 with SMTP id
 d9443c01a7336-290cb65b633mr158170435ad.47.1760967075228; 
 Mon, 20 Oct 2025 06:31:15 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.51])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29247218f22sm80292345ad.100.2025.10.20.06.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 06:31:14 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v3] Altera SoCFpga Boot Stall Fix
Date: Mon, 20 Oct 2025 21:31:00 +0800
Message-ID: <20251020133100.1837-1-briansune@gmail.com>
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

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 arch/arm/mach-socfpga/misc.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 76747c2196a..c54f5e32454 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -178,7 +178,10 @@ int arch_cpu_init(void)
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
@@ -223,8 +226,16 @@ static int do_bridge(struct cmd_tbl *cmdtp, int flag, int argc,
 
 U_BOOT_CMD(bridge, 3, 1, do_bridge,
 	   "SoCFPGA HPS FPGA bridge control",
-	   "enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
-	   "bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
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
 
@@ -261,6 +272,17 @@ void socfpga_get_managers_addr(void)
 	if (ret)
 		hang();
 
+	if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)) {
+		ret = socfpga_get_base_addr("altr,sys-mgr",
+					    &socfpga_sysmgr_base);
+		if (ret)
+			hang();
+	}
+
+	if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) ||
+	    IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M))
+		ret = socfpga_get_base_addr("intel,agilex-clkmgr",
+					    &socfpga_clkmgr_base);
 	else if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X))
 		ret = socfpga_get_base_addr("intel,n5x-clkmgr",
 					    &socfpga_clkmgr_base);
-- 
2.25.1

