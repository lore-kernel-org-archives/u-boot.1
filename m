Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FD2C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 10:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E4288249;
	Sat, 20 Apr 2024 12:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I313dwMw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F399388124; Sat, 20 Apr 2024 09:02:16 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C67E8811C
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 09:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e3ff14f249so20418985ad.1
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713596532; x=1714201332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8ZMaK0u4awexmvKs9quqmrEtmiorWkfBm0llfAtya0=;
 b=I313dwMwPTl8MNpOEFq1fRLq5AMSYqaCH90wDPqJVXe/sH9VScGvqP4DKN8deSBsU8
 GkG1JOOwQUbeWyLt01N3ppY8+JTy++Ak1ywJ5l92pXFtFQ5w00ftpyO/4wPwommXDOT1
 TGbdTn4d7HT0yoqRTmtA5QH5634AxRjEL+OzzVrwcaBe56enBHX6FvzpmvYIfs1R0/av
 GQqCZZMUp6dzC7oTqkDMl5TDpdRw/u25l/e+V3QfNxRB9jYf3TkE6Q2iBZBqgw+BhalP
 PGAiatSsjF+PDPfJOr/QArimegUE3EikNRrEiCoGJupNTLNBZ4FS3tsdWc+FW+QK80bw
 MZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713596532; x=1714201332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y8ZMaK0u4awexmvKs9quqmrEtmiorWkfBm0llfAtya0=;
 b=p187HLDorJkRA+N/F37IMn56hM74h0WJ8pGjX/kZoQhHSUrsJXyOX4ybrfUdtVoDbL
 tSNrFUjSw/6KrPbvoM7L0kDzxR4+1D4AyAex3P1ZwnNoHpOR8C15825eqfe+8JxBdbc+
 Rv+b2uOJkpoT7ARJhSVV9hu/gJ218BwTmEuEhtoTTl/GVdjuW3pICfnxdEooWfN8O8e8
 ZGw4O/8GkK9mtRC9WVGDcYM+2z2r2W1lArBLMsgDeIhN1p9Bp7Qnjo7Ve2SZowiBxrIQ
 JD36iIxosKefURoAOpcOwmPo5xxlDpq9uI9pX3BEIKJZwIMlUu8Q8UCFmLtwgsmfcEto
 zVOA==
X-Gm-Message-State: AOJu0YzM2OP3U0eQA4Jie8bVz2tdDinxZkhHQbCJTPoCPw6vQDYe+BKc
 DriiyNlNLO6XDN/ikPZpRixQWDOQiiJ/x8QyuuXIekFbh7g/kQuT94AEb8TuYUQ=
X-Google-Smtp-Source: AGHT+IHn0sELj6A3tMRr6gKuGBVbq2mzNU/fs4mkDLAbg3JFuMwxt7bwiXztAmuffaRlqPfLtPUqDA==
X-Received: by 2002:a17:902:e84f:b0:1e2:7734:63dd with SMTP id
 t15-20020a170902e84f00b001e2773463ddmr11629527plg.30.1713596532162; 
 Sat, 20 Apr 2024 00:02:12 -0700 (PDT)
Received: from localhost.localdomain ([120.204.189.229])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a170902778900b001e51b690b7dsm4424137pll.295.2024.04.20.00.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Apr 2024 00:02:11 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/3] riscv: dts: sophgo: Add ethernet node
Date: Sat, 20 Apr 2024 15:00:28 +0800
Message-ID: <20240420070149.8917-3-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240420070149.8917-1-seashell11234455@gmail.com>
References: <20240420070149.8917-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Apr 2024 12:11:39 +0200
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

Add ethernet node for cv1800b SoC

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

---

Changes in v2:
- Change compatible
- Add clocks and interrupt properties.

 arch/riscv/dts/cv1800b-milkv-duo.dts |  7 ++++++-
 arch/riscv/dts/cv18xx.dtsi           | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/dts/cv1800b-milkv-duo.dts b/arch/riscv/dts/cv1800b-milkv-duo.dts
index 94e64ddce8..c1e6611e33 100644
--- a/arch/riscv/dts/cv1800b-milkv-duo.dts
+++ b/arch/riscv/dts/cv1800b-milkv-duo.dts
@@ -29,6 +29,11 @@
 	};
 };
 
+&ethernet0 {
+	status = "okay";
+	phy-mode = "rmii";
+};
+
 &osc {
 	clock-frequency = <25000000>;
 };
@@ -39,7 +44,7 @@
 	no-1-8-v;
 	no-mmc;
 	no-sdio;
-};
+}
 
 &uart0 {
 	status = "okay";
diff --git a/arch/riscv/dts/cv18xx.dtsi b/arch/riscv/dts/cv18xx.dtsi
index ec99c4deeb..c95bac77be 100644
--- a/arch/riscv/dts/cv18xx.dtsi
+++ b/arch/riscv/dts/cv18xx.dtsi
@@ -50,6 +50,20 @@
 		clock-frequency = <375000000>;
 		clock-output-names = "sdhci_clk";
 		#clock-cells = <0>;
+	}
+
+	eth_csrclk: eth-csrclk {
+		compatible = "fixed-clock";
+		clock-frequency = <250000000>;
+		clock-output-names = "eth_csrclk";
+		#clock-cells = <0x0>;
+	};
+
+	eth_ptpclk: eth-ptpclk {
+		compatible = "fixed-clock";
+		clock-frequency = <50000000>;
+		clock-output-names = "eth_ptpclk";
+		#clock-cells = <0x0>;
 	};
 
 	soc {
@@ -138,6 +152,15 @@
 			};
 		};
 
+		ethernet0: ethernet@4070000 {
+			compatible = "sophgo,cv1800b-dwmac";
+			reg = <0x04070000 0x10000>;
+			interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&eth_csrclk>, <&eth_ptpclk>;
+			clock-names = "stmmaceth", "ptp_ref";
+			status = "disabled";
+		};
+
 		uart0: serial@4140000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04140000 0x100>;
-- 
2.41.0

