Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D85C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 17:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A9278144F;
	Fri,  7 Mar 2025 18:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="T8cybBlY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62749814A4; Fri,  7 Mar 2025 18:11:10 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB55080F6B
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 18:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8F88525BAC;
 Fri,  7 Mar 2025 18:11:06 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mm-26EuzrM_p; Fri,  7 Mar 2025 18:11:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1741367391; bh=0Cs/k6PulVqmfYsMOCh5/3qmbCOe7VzssMuVyOpaDX0=;
 h=From:To:Cc:Subject:Date;
 b=T8cybBlY2+y0cgS3+L8oxDR5KTmTj3kT6i81Lg9C6xP2GLOI0CRCLv1tlsAkn64Cm
 vgqT4CtU25hTekxgXiOTZ7MWj6a7uqLIY6dLwlLlJ2/f6m5Dp0emeGgSILkdyeUGYS
 FeIWMxWu0SXUpdifGjpfLN57VowtTJW0w3CP2jqBgeiM/7Gj6tNLsWCf13I6HG1bAG
 ZHo7+i8HeETjMu7XpId9xOUm15kewdKm1QdGpLKI7k12n7LYwyVMYi6uohxf+1jb+9
 sRxlTCfuimFY2Mz9EK4mALoLVC27ySFP0fjUjAoyH/nQ0BoHFHL1p8V+RBUWFh0WfJ
 SVuhXVaCbVA1w==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Kongyang Liu <seashell11234455@gmail.com>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH] riscv: dts: cv18xx: Drop unused dummy clocks
Date: Fri,  7 Mar 2025 17:09:22 +0000
Message-ID: <20250307170921.31551-2-ziyao@disroot.org>
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

Introduced in commit 5a4e0625ac77 ("riscv: dts: sophgo: Add ethernet
node"), eth_{csrclk,ptpclk} were used as placeholders for ethernet
controller. As the real clock controller has been added, drop them to
clean the devicetree up.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/dts/cv18xx.dtsi | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/riscv/dts/cv18xx.dtsi b/arch/riscv/dts/cv18xx.dtsi
index 8a7386b76e6..6fac247e7ac 100644
--- a/arch/riscv/dts/cv18xx.dtsi
+++ b/arch/riscv/dts/cv18xx.dtsi
@@ -46,20 +46,6 @@
 		#clock-cells = <0>;
 	};
 
-	eth_csrclk: eth-csrclk {
-		compatible = "fixed-clock";
-		clock-frequency = <250000000>;
-		clock-output-names = "eth_csrclk";
-		#clock-cells = <0x0>;
-	};
-
-	eth_ptpclk: eth-ptpclk {
-		compatible = "fixed-clock";
-		clock-frequency = <50000000>;
-		clock-output-names = "eth_ptpclk";
-		#clock-cells = <0x0>;
-	};
-
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
-- 
2.48.1

