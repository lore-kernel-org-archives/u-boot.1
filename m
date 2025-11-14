Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBBCCE8D4F
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 16:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A4CA8416F;
	Fri, 14 Nov 2025 17:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="liFpqgdt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B61984175; Fri, 14 Nov 2025 17:04:42 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 273B78415D
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 17:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7ba49f92362so1122523b3a.1
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 08:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763136278; x=1763741078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6UMhutAMx4QUWJQ9KR3n8aRSp+U9KgyTbidIF43ADNg=;
 b=liFpqgdtOO1UNgoObAJoFLAakzcV7EnA/ln74yChHykxCzFOSb7JwI4Puql453D2Bc
 Q5f3W0PEp/v5mPYu/332FLIOFYn7cALnUsZJijS0Iwdf3VT0lFnVzrqRLjPWXYJg4OAk
 0R9+XVewHOQ6ttqR/WbeuwRpJc5fGtwgiqq5putWvH6F71HZ3KqOpbLfcTMoZCbbMypu
 y4GoAUw1Vws5e/suFHwBhdwiSwsT+i2j8ZynEi4Z3TBbZfkcnaqpkTxRoU6ofkaNnGbS
 FU5rta4NdcnQxWmXGlkj48EYJ7XYMAoZ0iJyAfnMalBakd5u6b0pL07aXfO7h4/uae0m
 e9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763136278; x=1763741078;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6UMhutAMx4QUWJQ9KR3n8aRSp+U9KgyTbidIF43ADNg=;
 b=V2Q/XBroN3lKbSqA2N5JbzjoKrj7sCNFfNT/kjJGEl0A9Yc1ChDdzTNKIhQByIczfV
 rPYNtWODrTGBIaBRRma6OmaIsi/t/UmNjmtBJycFSJVnPJaqVReDnXr4Cl+Wn6914pHl
 ZoOhODoVE6dSzpUZRvusExlgvhqMrqCS87VL510o4nvalQv7rfwopIik/Rxn/vTm/4/g
 blKEol/gmHdPoHaYQXOl291ekj1qmhQXQ1UT7sIygttolxPy3aYbavNzoOPJ2qnXZdU+
 aROmNgN8JkDir0ngzaW21smm3sEZI0BOO1sacLRnXkbphjJ4G+TKHiJ1Wg/YQIKKEl3U
 0rBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR38ba6d8tlmYQrpVdx4piocW/u9DBb904xAqkJsPI/nFAtEA3fR6nSFuoN4Mr95m0oBXYOso=@lists.denx.de
X-Gm-Message-State: AOJu0YwnGyL49O4rM2RRUNhIX1JfW+FKkipXrWwFndrqOuhIyQGzXmU+
 2M4LDDJFmeLEBg8uvzQMG7g96ieKHgWBRFT6yoCGvqj5/74VhDvyzQGm
X-Gm-Gg: ASbGncswS1YfClkHMg3tHqbRPoiN2AmSG/sC4r07FUsa8uYRGRM8X88NCekzlEnp68j
 7h0W5yu0+Ecb/ihiRtj9N15gj1Wp1Ec/OeUPRNO6kH9gtcB6mm7QS75Xl4kXnf76dWPL8OtVz6D
 721IO/DR+rEFJTef+/gAKlpPTnqynkbJFp4Vcss2xnctkrRQgqr/OAUwXnEiaMwqLWDqn0SoHvk
 Fc2qtw2Fj4m5q9jc/mZ0sX3S8VFIjrzq1LVjzPFwX/9VB51dg4lC4iloovjB3U58LVJjpPKE3b8
 3cYrlpCyO17JXtsY2tkF5pMQfG2uQhsS/KsSqijHpv5cPg/Rse4C89KZ4wz89Ku9fQCPgavQ+W3
 zp8WO7+WyGbI8sLoBsjQ1RINd2epbmL2CSZwQei+L2ahiX+wwR4DU6kslRaGiQEo7D3+uQSy16V
 55xZjCzcLCQpEYXjNyi2F/9dMekZ2XJCSXZdU1jQ==
X-Google-Smtp-Source: AGHT+IFLmSG8X9qmciqkd/4qwylWkUbtjGvK35NQgNhgB5IW+Fxw4v2EcnwcbRm/FMDVMZbnL3KxEQ==
X-Received: by 2002:a05:6a00:3d42:b0:776:19f6:5d2f with SMTP id
 d2e1a72fcca58-7ba3419a59emr4967955b3a.11.1763136278282; 
 Fri, 14 Nov 2025 08:04:38 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.189])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b927c24254sm5647610b3a.64.2025.11.14.08.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 08:04:38 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Chee Tien Fong <tienfong.chee@altera.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v5] Altera SoCFpga Boot Stall Fix
Date: Sat, 15 Nov 2025 00:04:23 +0800
Message-ID: <20251114160423.1518-1-briansune@gmail.com>
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
 arch/arm/mach-socfpga/misc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 76747c2196a..07694107c8a 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -222,7 +222,7 @@ static int do_bridge(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 U_BOOT_CMD(bridge, 3, 1, do_bridge,
-	   "SoCFPGA HPS FPGA bridge control",
+	   "GEN5 SoCFPGA HPS FPGA bridge control",
 	   "enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
 	   "bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
 	   ""
@@ -261,7 +261,16 @@ void socfpga_get_managers_addr(void)
 	if (ret)
 		hang();
 
-	else if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X))
+	if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
+	    !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M) &&
+	    !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)) {
+		ret = socfpga_get_base_addr("altr,sys-mgr",
+					    &socfpga_sysmgr_base);
+		if (ret)
+			hang();
+	}
+
+	if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X))
 		ret = socfpga_get_base_addr("intel,n5x-clkmgr",
 					    &socfpga_clkmgr_base);
 	else if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
-- 
2.34.1

