Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A529BC54791
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 22:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21ECA87EF7;
	Sat,  9 Mar 2024 22:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SwVEaqQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E8487D5E; Sat,  9 Mar 2024 18:53:57 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1965C87D46
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 18:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6e51bc7640fso387585a34.1
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 09:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710006833; x=1710611633; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIodyOa/gwY/4GRCw4HyUfMPXNvU/4IZl69pc/smWIk=;
 b=SwVEaqQyO72yRrJ4HWJdf9FiE1d7AQU9Sb/wlYgPPSk2gqvCWdCvZwqJIJJPMdevmS
 XsiwgsNdPok0/QFK0CyvwZIj3ZBVWEma6K8+TMzWLQFfQKkj0nx0qdp/KyINGxYv4vgt
 2DYSx9jlfPmzUqjSe2b1A3gtH5kI7+rQG51uT1sEE5DXUogE08U+PwuhSji4o0LYOr34
 MSk4SFAFzZXycNG5scQNaAKTcJoDAN65Vps8EywgqOrW9N8lt/S0w0j9iXFckP5G2kZP
 YjgaU7yqQQflmcKRmQ8cmMXihEGZDXYocypaP8tVmgnD3ykh0sW4bf/CJbARJuQFEXNc
 4aIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710006833; x=1710611633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SIodyOa/gwY/4GRCw4HyUfMPXNvU/4IZl69pc/smWIk=;
 b=mQKIAcMeP3pgCHoBkggzMZveT/THnlpgeAUYsDFMr47TphefbQfxFmbVQ1NUqaCbWl
 qkVrNCCMVbbijD1Mow1RSoQqsa7oMPPVV4MkWpMJzgQ92HspRiS3Rrm27bwaPYxcrKaH
 iig/q4Na+fY+ul6FmD1eNYlo2urw5T61gDYFIOpFFb+XrGGieFvsBVgFrTOmIOvAjx+h
 /HSr14tSt9SuJ86F1IoXkB2UiFSWkgIJ0ySsp0wcG6s4sXthC3H9yRxxkymLjA4d/oh1
 nNnfkSX7sZAPWPcnwzPiw3/OVolRPxfRHsVGpU+6xueRBNdh9gnLt2xzYzpNKmyZHZIT
 WkdQ==
X-Gm-Message-State: AOJu0YyG3VhYD/3a7ygvCQALxFbtMDXL/TcxBxpW9BC4Qd5LaXSAXDU0
 gK5voKEhm2/tKDHbNp5hpgVmNKETzw84IqMgOo35tybQEASvISi/SDogTPIlNKq0EQ==
X-Google-Smtp-Source: AGHT+IGBULoc+n8P43Me8R6KZ6dYA2mmx0BlY/voHAOyLDRdcjc0ITz5bB88zUUjQB7uc8K05PWDSg==
X-Received: by 2002:a05:6830:2006:b0:6e4:e4a9:45ec with SMTP id
 e6-20020a056830200600b006e4e4a945ecmr2986576otp.29.1710006832667; 
 Sat, 09 Mar 2024 09:53:52 -0800 (PST)
Received: from localhost.localdomain ([117.135.91.249])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a631e02000000b005d7994a08dcsm1530651pge.36.2024.03.09.09.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 09:53:52 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/3] riscv: dts: sophgo: Add clk node and sdhci node
Date: Sun, 10 Mar 2024 01:51:56 +0800
Message-ID: <20240309175330.79267-3-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309175330.79267-1-seashell11234455@gmail.com>
References: <20240309175330.79267-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 Mar 2024 22:59:37 +0100
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

Add clk node and sdhci node for cv18xx SoCs according to patches from Linux
kernel.

clk: https://lore.kernel.org/all/IA1PR20MB4953F9AD6792013B54636F05BB4F2@IA1PR20MB4953.namprd20.prod.outlook.com/
sdhci: https://lore.kernel.org/all/20240217144826.3944-1-jszhang@kernel.org/

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

---

Changes in v2:
- Sync device tree with ptaches from Linux kernel

 arch/riscv/dts/cv1800b-milkv-duo.dts |  8 ++++++++
 arch/riscv/dts/cv1800b.dtsi          |  4 ++++
 arch/riscv/dts/cv18xx.dtsi           | 22 ++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/riscv/dts/cv1800b-milkv-duo.dts b/arch/riscv/dts/cv1800b-milkv-duo.dts
index 3af9e34b3b..94e64ddce8 100644
--- a/arch/riscv/dts/cv1800b-milkv-duo.dts
+++ b/arch/riscv/dts/cv1800b-milkv-duo.dts
@@ -33,6 +33,14 @@
 	clock-frequency = <25000000>;
 };
 
+&sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	no-mmc;
+	no-sdio;
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/riscv/dts/cv1800b.dtsi b/arch/riscv/dts/cv1800b.dtsi
index 165e9e320a..baf641829e 100644
--- a/arch/riscv/dts/cv1800b.dtsi
+++ b/arch/riscv/dts/cv1800b.dtsi
@@ -16,3 +16,7 @@
 &clint {
 	compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
 };
+
+&clk {
+	compatible = "sophgo,cv1800-clk";
+};
diff --git a/arch/riscv/dts/cv18xx.dtsi b/arch/riscv/dts/cv18xx.dtsi
index 2d6f4a4b1e..ec99c4deeb 100644
--- a/arch/riscv/dts/cv18xx.dtsi
+++ b/arch/riscv/dts/cv18xx.dtsi
@@ -45,6 +45,13 @@
 		#clock-cells = <0>;
 	};
 
+	sdhci_clk: sdhci-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <375000000>;
+		clock-output-names = "sdhci_clk";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -53,6 +60,12 @@
 		dma-noncoherent;
 		ranges;
 
+		clk: clock-controller@3002000 {
+			reg = <0x03002000 0x1000>;
+			clocks = <&osc>;
+			#clock-cells = <1>;
+		};
+
 		gpio0: gpio@3020000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x3020000 0x1000>;
@@ -175,6 +188,15 @@
 			status = "disabled";
 		};
 
+		sdhci0: mmc@4310000 {
+			compatible = "sophgo,cv1800b-dwcmshc";
+			reg = <0x4310000 0x1000>;
+			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+			status = "disabled";
+		};
+
 		plic: interrupt-controller@70000000 {
 			reg = <0x70000000 0x4000000>;
 			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
-- 
2.41.0

