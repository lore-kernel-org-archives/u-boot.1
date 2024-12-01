Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61378D49775
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 820678914D;
	Sun,  1 Dec 2024 16:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="If7z0SQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D9F89428; Sun,  1 Dec 2024 16:07:34 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD91888D3C
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-53df1e0641fso3765955e87.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733065648; x=1733670448; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QwJc1/NFbm6ZlSJcRwTKaXmlWWOb38U8nBnnuqkMe40=;
 b=If7z0SQ7MUst5gaBlKIFRZdSF65Len9aMjGa4jCLfFXpg1469FuhvNTbtE5c25ZMRl
 Ii2hLdG2tkLSoNXvfNiAzBxc6w2TZUI/u6Rf6q9vm20nawE43XUUQ2m5gopPEQiYkX3m
 x+bhBd8zYiDqkIbH67FtijTd4v7ZeNxs4W9o5LQsq1l8A+WjifAaVydlYmBG+saBFUWy
 It8E0lx3URAdvyieAFKFs4i3T/s7TMHVFnsofYlt1JOqb1MISZfFP7KNRPueLxxxwDQG
 lcfjfXzKLE/3zBTJDDwXjceDtylP/zSsG/ZYVaWJ9jET/Y3Bg72lyZpryPIeeP48drdy
 ID+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065648; x=1733670448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QwJc1/NFbm6ZlSJcRwTKaXmlWWOb38U8nBnnuqkMe40=;
 b=Go1Oy0KyyPhJphjmfMzyvsyBnZwvJu+kR+xM+VImXBOUvTXj3L3p6XbCLZ2FOvmtm+
 ToJhs+SZxywl7k7l9FnoYZYUx3+B0EI+AmTW/RnkBNGVhTFMjnOjNB82Pet7pC+z/0Bp
 ACuhrmycsGVe9sEasshKeegd8zPhAve5rm0lz03wUa8+1Sdi/298i5tdRwEkV7LGNxpE
 J21Feez/yrTonlMQGH/uZtnWzQmloL2XaKw5gJP7J68/tr6yuEVNl64HmuH2Z3o6jflp
 o32PyBMC5fZeHxlLG2LQ6PcTNUK460QSd0zvwjlugpjZv/vAIOghzhcC0/0aBVK6E/vD
 bEPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9HjjQnEWZcjvybTVJdFqV3YnI1mox9J9Vv6wlspgNjIREc03hlx2TAWbyo9Z/do6fP6KVSHc=@lists.denx.de
X-Gm-Message-State: AOJu0YwjdufGN1kRDxWnLcLQ/FhqP7QFRcdqOcYGxdlyWnCW8SpbJk+x
 g1KVS9AiTLzfkPaLMPMpLHXJs0yTfruarmv1zuVhTdssnQZLQKmE
X-Gm-Gg: ASbGncuHNt25uY+4iwJffp7+o6WN6KioCEHg4KNZ678X7snR5+8C8l33AGG5C5afKik
 dxVDobhJzXJUVfg7OzG4sfJiN5R9oKTuc5NhVLt/EqHE94N4x1YAD9cp1SqbVc0Guy6g25GvMrg
 KDb9k2uJekRXoFU3XhK6B87fya25zfl1AMD1brydQ5L37IQIa4Y3SOvx/Ltvmxx5TU1rW42NK1u
 r9mBroFU6yBVwguJEjRhBNYWVRVYxybwBrfJQIclU4w84w+hOtyNSAZwdJEr/FWPlnUJqjl
X-Google-Smtp-Source: AGHT+IHmmHLhLBjXBAL2L3Gh+OigcsooXLoBa5xa4iAPJION468RoyiWPruJ0NOcPZTaiB0LSzP1RQ==
X-Received: by 2002:a05:6512:b0b:b0:539:e85f:ba98 with SMTP id
 2adb3069b0e04-53df01126a8mr10423054e87.56.1733065647668; 
 Sun, 01 Dec 2024 07:07:27 -0800 (PST)
Received: from wpc.. (host-93-124-60-94.dsl.sura.ru. [93.124.60.94])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53df646f1a7sm1101120e87.165.2024.12.01.07.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:07:26 -0800 (PST)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Wei Liang Lim <weiliang.lim@starfivetech.com>,
 Kuan Lim Lee <kuanlim.lee@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1 2/3] riscv: dts: t-head: Add sdhci and emmc nodes
Date: Sun,  1 Dec 2024 18:06:55 +0300
Message-ID: <20241201150704.44462-3-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201150704.44462-1-bigunclemax@gmail.com>
References: <20241201150704.44462-1-bigunclemax@gmail.com>
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

From: Maksim Kiselev <bigunclemax@gmail.com>

Add SDHCI and EMMC controlles nodes on TH-1520 SoC. And enable them for
Lichee module 4A.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 arch/riscv/dts/th1520-lichee-module-4a.dtsi | 18 +++++++++++
 arch/riscv/dts/th1520.dtsi                  | 34 +++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/riscv/dts/th1520-lichee-module-4a.dtsi b/arch/riscv/dts/th1520-lichee-module-4a.dtsi
index dc00e3dfa0..86a81bdcf7 100644
--- a/arch/riscv/dts/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/dts/th1520-lichee-module-4a.dtsi
@@ -32,3 +32,21 @@
 &uart_sclk {
 	clock-frequency = <100000000>;
 };
+
+&emmc {
+	bus-width = <8>;
+	max-frequency = <198000000>;
+	mmc-ddr-1_8v;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&sdio0 {
+	bus-width = <4>;
+	max-frequency = <198000000>;
+	status = "okay";
+};
diff --git a/arch/riscv/dts/th1520.dtsi b/arch/riscv/dts/th1520.dtsi
index d68c446a6b..9378de89c5 100644
--- a/arch/riscv/dts/th1520.dtsi
+++ b/arch/riscv/dts/th1520.dtsi
@@ -141,6 +141,13 @@
 		#clock-cells = <0>;
 	};
 
+	sdhci_clk: sdhci-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <198000000>;
+		clock-output-names = "sdhci_clk";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -206,6 +213,33 @@
 			status = "disabled";
 		};
 
+		emmc: mmc@ffe7080000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe7080000 0x0 0x10000>;
+			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+			status = "disabled";
+		};
+
+		sdio0: mmc@ffe7090000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe7090000 0x0 0x10000>;
+			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+			status = "disabled";
+		};
+
+		sdio1: mmc@ffe70a0000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe70a0000 0x0 0x10000>;
+			interrupts = <71 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+			status = "disabled";
+		};
+
 		uart1: serial@ffe7f00000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xff 0xe7f00000 0x0 0x100>;
-- 
2.45.2

