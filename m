Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5D0CCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 13:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F372182C84;
	Mon, 20 Oct 2025 15:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U3/uYAiN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBC998334F; Mon, 20 Oct 2025 15:35:12 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 967B3807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 15:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-33255011eafso4065832a91.1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760967309; x=1761572109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=b9zXCNksV66vpOGM7J5qGPHEjMShVYwftlU2+brrrIY=;
 b=U3/uYAiNN8FvKBB2SDOWzkLXkIREnNaFxVlM44UF7VHA0ciGyk/KxHK+RCd2fpGxdd
 8ikdEAhArkr3cpACexOvZ5hWycVo+r39WRU2kf2ck8vTOq13NLhHCOn9tD/2sRFSR+gB
 LeZmMbRHmFFSgHFLULNFQ3+DESaUPl0hou5B8B/EWyyDHeWmt63JDjnns1+Zk9PM0qZ6
 cgwswF8pKNHmQ5POuNMngpGWNSWRUmQXzhoDb8UcjZkks5HigEkllFdvWmuXfk7orelk
 x8/+R4jw2DPU88cHbLpelpoMMdxq/QXfCH2WTdrsI34S09MI6D5xtjp20Jr4BSJqPdCB
 I19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760967309; x=1761572109;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b9zXCNksV66vpOGM7J5qGPHEjMShVYwftlU2+brrrIY=;
 b=E5zyDUuhwuyVhOuOgocau1ZWzM187sjzkyrOfSL/UaU3p1jsa1Rba3sP231kM/4m8u
 xhyWjtdIT+W1vQP+CrjcyEzFpmoKLy23sf8/FuUArkBXSRpLqxOkHQ+gcYRs1lfHIfAP
 O69U+Wqxu3R9wSupJCjv3W0J4EHmndOhjGlOrO3okEXe4RwUwVjGdIArzDPvIHSHyN1c
 Adkmg7tKLeq4RJpE9jdoS3RvakEXmh/ef3LDXJH+p+BbbbzXwjWDa7gPtharon0zRrL3
 IxPT1T0xKpHECBLL06vQqC9BzYI6Ig63iHlvREtN1TGZjJSFj6SyXfUW3nMhCSGiV7iA
 LA7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+dxKycxCX0CH4YrBEyJNJYeUsJHWQUV46tA3KpzOQeT2j0jZcqOR8QY0bKe8yUk3fO8OXZWw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4NQg4Yv/MB0+mqcbmhjp54Fx4axpM9Po6nQvOezKBKjUt+Oaw
 9SA1J8EJHEkho0Kp8nJN5vY73lVoW8vwHbsW/8ce7SgoHFBj/wxcW2bn
X-Gm-Gg: ASbGncsgy8XMG7ou2sy+gcYbkAWL5lc2aPh0YlvrtaW+96c5NfR/gvbnBo3l0acbaJt
 V8G/HWzvUpt0wLj8oMOlJbvDb06Yz7g1jWZWOBRVCdU+c1qqiNjeg6OZca7NjgCppP+YBbg5qUW
 yQzSG6+ZvKKiwj2aKns0F7JQY8H4VgW85S7bteFzkqsK0zOlSQSL5Fo7mN1v1cXEM1EyhZAkEJe
 zfG4bH9/3CzTBGMl1HIyKPPwLVZBVB6XeBqCCSocUrx0Vq3WqFkBGG0nTxV6dGb9Es5ZrmrDKQi
 GDW19heIkWqedVnN+VpPWC8Fmd0/UPDicVFD9+PudQ1kFjvzNXa8+IpSMKv6M3rGXQo+h6nSsJr
 grEDjQb2stdGek3jzSlVayyMRxLUK051CMM/KtvmbbiZXbGazv6spiSjSHmwnDG6cJlA0J92EGJ
 Cj06a5vANiMoOKlHXHbVjbGnJm3Q==
X-Google-Smtp-Source: AGHT+IGDjmfTnFT75bOmoj8s6VpPvbCsxKWDSMc8qdThyFwRptupzaqMmm4TH60QYORU4meFZLDVxA==
X-Received: by 2002:a17:90b:2604:b0:330:797a:f504 with SMTP id
 98e67ed59e1d1-33bcf85fb3cmr14738460a91.3.1760967309006; 
 Mon, 20 Oct 2025 06:35:09 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.51])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a779d704dsm7522898a12.24.2025.10.20.06.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 06:35:08 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v4] Altera SoCFpga Boot Stall Fix
Date: Mon, 20 Oct 2025 21:34:55 +0800
Message-ID: <20251020133455.1870-1-briansune@gmail.com>
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

