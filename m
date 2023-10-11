Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4639CCD6E7E
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 15:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A6E186D12;
	Wed, 11 Oct 2023 17:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OECM982K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40D2C86D2E; Wed, 11 Oct 2023 17:30:44 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AA2886D12
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 17:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-351367c8fcdso26111185ab.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697038238; x=1697643038; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4xx4UYuoSVvlhHwNx9pHy3LwEQxdgPl05GDMNscdwus=;
 b=OECM982K2g5UeQVJbQoOFlMV+wt98MktdQ5MvmGrMBEmvcpe2DH137hHtdlmXHr+Th
 Ds9IT0wo/RZwRNM6Woh61PEqASK0nzCkEtrB+WhlJeAAMtrr0hituHIZm/ukmoajDtgz
 R+brLR9TdrVPM3pKZMZDzuR3u05exykRTM52rl8m/XfaMJyeNaBmPrG2WDMJTi5McH88
 /QuHrkvs5KnIXPi4sq6tImz8U+tfEZ+PCsDP7Xed+7CtQ39HWagCIL+jB9bAX5ldJp2F
 hDlcVz5Hex5f66J8vTdv97mabMyN+jMVgtV0bra9+kHYTkpGyIt+JGM5vYdxeraMknz8
 9x3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697038238; x=1697643038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4xx4UYuoSVvlhHwNx9pHy3LwEQxdgPl05GDMNscdwus=;
 b=wgGjhTQT7LxbV2/6AHnPAPEi1/wVRmNif5fl9sF4b+6+UY51m4Cmo6TaS5EEWfBbe4
 qER9drROQfzLUvRP5kVeFEK1O4F/sT/pAALgZmWGydd951DArMs/2dogKenHd1OpN5SE
 wOipvVhOgbc1acnZXAXnj5U+NWz7AjGjm7zWwsMaCmib7sdK8GH+0zBtH9Qyyo55X75r
 CuVkkwJuUeRGu0GdhlVU59N17Ibt0GTtz7FCgAQuUP7ORm3CG31VceVY911HkRQxK4M7
 iDZtCwMSDVpJAXDtQkOb+7/ybgZNKtzPIvzXW5UVgBxzT1D1pCCcssEScsYkKt6jPdRs
 cC5A==
X-Gm-Message-State: AOJu0YzNJeQeJ3gwfWmrME1VLhyP/uqGe50CnRO9IjVR7G1pUCgLGWYH
 77KC470UQQnlZhFL5nb740zvNw==
X-Google-Smtp-Source: AGHT+IFT6753SZ+1sNkfvNjXhslgN+feqkRhQ/R8aBsNf5sB/oyCdkgTbaJMIt1XmbvfVlfq7LsmpQ==
X-Received: by 2002:a05:6e02:1c0c:b0:351:1d53:c770 with SMTP id
 l12-20020a056e021c0c00b003511d53c770mr27069813ilh.5.1697038238280; 
 Wed, 11 Oct 2023 08:30:38 -0700 (PDT)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:561f:d0f6:ce05:7e84:21e5:49c])
 by smtp.googlemail.com with ESMTPSA id
 du13-20020a056a002b4d00b0068e4c5a4f3esm10231348pfb.71.2023.10.11.08.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 08:30:37 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Yu Chien Peter Lin <peterlin@andestech.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
	u-boot@lists.denx.de
Subject: [PATCH] riscv: binman: Fix compilation error
Date: Wed, 11 Oct 2023 21:00:20 +0530
Message-Id: <20231011153020.1008123-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
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

Some platforms may not have any DDR memory below 4G and for such platforms
the TEXT_BASE and LOAD addresses etc are all 64 bit addresses due to
which the u-boot build fails with below error:

u-boot/arch/riscv/dts/binman.dtsi:30.14-25
Value out of range for 32-bit array element
u-boot/arch/riscv/dts/binman.dtsi:43.14-25
Value out of range for 32-bit array element
u-boot/arch/riscv/dts/binman.dtsi:44.15-26
Value out of range for 32-bit array element
FATAL ERROR: Syntax error parsing input tree

Fix by setting the address-cells property to 2 and converting load
addresses to 64 bit values.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 arch/riscv/dts/binman.dtsi | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index 156cb00971..b448b2a712 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -5,6 +5,9 @@
 
 #include <config.h>
 
+#define U64_TO_U32_H(addr)		(((addr) >> 32) & 0xffffffff)
+#define U64_TO_U32_L(addr)		((addr) & 0xffffffff)
+
 / {
 	binman: binman {
 		multiple-images;
@@ -17,7 +20,7 @@
 
 		fit {
 			description = "Configuration to load OpenSBI before U-Boot";
-			#address-cells = <1>;
+			#address-cells = <2>;
 			fit,fdt-list = "of-list";
 
 			images {
@@ -27,7 +30,8 @@
 					os = "U-Boot";
 					arch = "riscv";
 					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
+					load = <U64_TO_U32_H(CONFIG_TEXT_BASE)
+						U64_TO_U32_L(CONFIG_TEXT_BASE)>;
 
 					uboot_blob: blob-ext {
 						filename = "u-boot-nodtb.bin";
@@ -40,8 +44,10 @@
 					os = "opensbi";
 					arch = "riscv";
 					compression = "none";
-					load = <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
-					entry = <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
+					load = <U64_TO_U32_H(CONFIG_SPL_OPENSBI_LOAD_ADDR)
+						U64_TO_U32_L(CONFIG_SPL_OPENSBI_LOAD_ADDR)>;
+					entry = <U64_TO_U32_H(CONFIG_SPL_OPENSBI_LOAD_ADDR)
+						U64_TO_U32_L(CONFIG_SPL_OPENSBI_LOAD_ADDR)>;
 
 					opensbi_blob: opensbi {
 						filename = "fw_dynamic.bin";
-- 
2.34.1

