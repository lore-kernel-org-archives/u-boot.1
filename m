Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DDECCD183
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 13:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4817682991;
	Sun, 19 Oct 2025 15:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fwyV/6h1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F86582E34; Sun, 19 Oct 2025 15:28:50 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 303E4807B1
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 15:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-793021f348fso3109869b3a.1
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 06:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760880527; x=1761485327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VQjdLzFrJa4ruqBOj2jKDL3jjLywveUUBfDndA3OY3E=;
 b=fwyV/6h1FCxKe5UWtMXKRqqP+TEiGHpshPKgDB92f6HLF1k9SsQhuqajeaS+hcmamR
 2VZFrp5YojL86OmMVW3fpv/FvGSTqtQVBK7nVamppxofNYJGkbGRlLHZUFbWufLd6MSy
 URHbX095CpkD1mr9Ip2GGGvoyO6IbzxIkhTqewDSnsm4dFZpZmqkk02OYeJzIkIIkD93
 6w6VYPaT60K8mXKoAsXVjIeyNr2D/58KDOPMU7XIUxObSYbQYSTNAjHV4hiKLZIoc4/H
 Sed3QP6dgOIFM8fsekUHvvRbVUQy8ylXZ8Az+1EM1LLBKKi6/P1BXyhDxcM5FZyboqgn
 aSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760880527; x=1761485327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VQjdLzFrJa4ruqBOj2jKDL3jjLywveUUBfDndA3OY3E=;
 b=bmgJszU/dX1OHOSao/zH9QwKjaZ7II7Gh9LSxUDhaWrO+0yyALed8uYzYbDPVmCGCd
 2U9IX5H0/2gEYk10pLzARpT3iiGsssTv//VLiN8duY96v5H/VFUqfO3mYIrwdKYShkzZ
 UYmC04LTKzXhTCGet528fx+9O8WQHllb172WiA6Ga6Fp7nO+QGuQIODUVcVuT3VV3O4H
 6ZqEkxHhwv7A/+NZ+aniyIEbGHYmkYxSo+SKuZzw5FO9bJzs2g1Hukk4cdL2Yjm2gybz
 tQEWD7qrdVwhC/577jQshnDD6oUQmv3KSxxdZmluMjqsIIE3o4BGGsYxIIYzTl5ecnMJ
 NESg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfTExAtb3dnNYvpVsYZaSLy7ujcrepweRu8bLAkwgitTcmrSKdmla0eZ1SDfC3Ckjbe+H4VN8=@lists.denx.de
X-Gm-Message-State: AOJu0YwsUo9NVPfpB75gF4Sli4jfFj1NAZw9Wn4MynB+/MpM1YHdiMHp
 SKodS/mtppLGCzhqbkaI/eVos4yvpVwIyVA0IK8ai26y1QujR5Blh6iERtnkEXXtJ54=
X-Gm-Gg: ASbGncuM6KtNaveg4DbsT9hUAoS55RLIHG6Cyy1j4RXmZshWPc4cm1JjUD1uaPMaojZ
 g3ELvkO3u7wwlcG/yETLq5VA6qA1Bfj5t25tyI/gUJwbK2I+NIvO4xDW5PUQ8dsGkQ3kzHYffc8
 rfUhZ2XUUBlmK0+xapyl1u1ghXTAvri90px534k5OFxr+hnyzCAdWVGj9N2Ku1PPhtUSQPyk4FJ
 PJm61qwXZzNhdJ3G+FbmM231VY+zyEUNnFK8GwL1HV6BQ/QBUWR/oPocBdp/Xx3NhuaeMzTkOCd
 w/pEsONpS3aMoAlft0y/J+QwgVGJgRahOZldPhGR1r5MYNLrilqCxBzpRoOX5/x9/kkcsDdbXlC
 IwZfh3ss2/JIqPdWnTp3P/cF725pDk4n5VEX6RcfKtrMAlqRocZLy8TtP3fVpZ9PBZoax/LtqvT
 D0ydUMuzNXEeuPDxb5Y18wXFLZ6qcUn9FWme0e
X-Google-Smtp-Source: AGHT+IHmkx1Y+Ldp72twJlTcOcBFusl14pyzqh9Y2b1hWEEdsCrUGh0XNxCny5Z1VztbCSrLfAh/0w==
X-Received: by 2002:a05:6a21:3986:b0:334:a9ff:8da9 with SMTP id
 adf61e73a8af0-334a9ff8dedmr12899255637.6.1760880526644; 
 Sun, 19 Oct 2025 06:28:46 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.51])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a7664a9c1sm5179168a12.2.2025.10.19.06.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 06:28:46 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2] Altera SoCFpga Boot Stall Fix
Date: Sun, 19 Oct 2025 21:28:34 +0800
Message-ID: <20251019132834.1134-1-briansune@gmail.com>
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

