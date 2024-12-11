Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DABE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 20:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86C988021F;
	Wed, 11 Dec 2024 21:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GHz977SD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4728021F; Wed, 11 Dec 2024 21:11:32 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F5A880200
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 21:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53df6322ea7so8348801e87.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 12:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733947888; x=1734552688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3CCJpCZWax8ALuYLwwrioe0afLhHHu26G/KY+halvNs=;
 b=GHz977SD15Kx3d37N5sERb5XB2lGqOVtmSe93bOtPL6Adcsu9+oIk6c8ocsnSgsNsY
 qlVF+paN9GeTL9uQFDlsOQQtYy1UNCRD9lexZNFRoDqcI7F44VI0HDIxJ3fkXZqi0NzP
 ydRRfHZeXLWKaKIhrn9MmwogGDCnPszx0ZnCLsOFG0Ewcy6sCKoMz1IE3EDh1/eNoE2X
 DmYbc0WkK1nqL3aTceiRftWafD2dxNkF0rHvK+CVX8mJ7dC7a+Z4nSZD2NvWgXlAFhkH
 xMaIBohHKPDSMIhN4lXxmfBcuZlJadabsjoJTaZWMkJvEOgcOhtto+cijvfRLBby6BRF
 Pisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733947888; x=1734552688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3CCJpCZWax8ALuYLwwrioe0afLhHHu26G/KY+halvNs=;
 b=pIsmOZWj7wrYNwC5+i+R58LWNTOX4oc2ZYNQ/IjQaQzFnAL95Ru2rsoLhBs9/nNoJV
 XfKWp0SoBUpmwHnCtzOalLQjSm490NL0R/BP5++JQ+obdktTCV07t0BwSrNiorzIDm6b
 lXxG+D82C6xyc1uWnY8fqRzWZzAQmDNu28XhjJ2dYy5kIrl8Z2eRNK0/AmjzUKYVlvLI
 xdtBIawNCe6cL+ALk5DRYpoYu2yqYx+y3FVbJFfC+G6GXpiggtSerYoc+Wr7QcpC+vlr
 ppvhGjrRsdUpy3prHs/COtW7rSiNyYk6g1QEu6K8LSa5rWTOxDqtAbb04tYyx/drfsdl
 kanQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWueq/zwjY1StyksF/CfK+IJykxIqHOA9PaG70pyo6Dd6GrBMPtPc3jCDii+9Y+lQBNeDK9O80=@lists.denx.de
X-Gm-Message-State: AOJu0YybHwpj1os+5UpMVjj94liipX4BxhKiG7g3cvcks7j0gXvtAW62
 fDmA8BWFSsqrM8kRIdJFoZFSjy8HnuRP5ZNKvc7aqqqZ7gS8G2zD
X-Gm-Gg: ASbGnct8T43i6KBd9+oiJJIIMhYzx38ZE4Vw9kGjukVx4ZHkGteiqYJj+UsQJ2LUoXy
 knzKHnztatpz7YiURJT3bYic/ad1tyN5KVJeRESIsm/hxzwrF7NPizChU4r4iLoa4e2BVTrzUNm
 vv3fD/grmf4Vnk9Maj+HrDpliefHsMHVmKA3m2cr0anZI77MeexHGo7NBXuXbz1hcOhOxBQNutM
 xRqAxrMtVBOyZTOKC2vP1UvDtOaaTiTH5sOsCQbV00lNpM+uMhPeJ1Ho5RvhDh5htCXtN/nDqHs
 eaT3i363KbGbJQ==
X-Google-Smtp-Source: AGHT+IFyLqx6BOq2uVjqyAxWrG4+kspbn7w1VWQgCOuIB30E7QuXiOEQ3IcTeerZWjk/e7Ih6sS4BA==
X-Received: by 2002:a05:6512:1110:b0:540:1ea7:44db with SMTP id
 2adb3069b0e04-5402a5d9e27mr1515671e87.4.1733947888297; 
 Wed, 11 Dec 2024 12:11:28 -0800 (PST)
Received: from wpc.yadro.com (host-95-152-63-227.dsl.sura.ru. [95.152.63.227])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5401ea77d14sm1107401e87.113.2024.12.11.12.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 12:11:27 -0800 (PST)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Jaehoon Chung <jh80.chung@samsung.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Wei Liang Lim <weiliang.lim@starfivetech.com>,
 Kuan Lim Lee <kuanlim.lee@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v2 2/3] riscv: dts: t-head: Add sdhci and emmc nodes
Date: Wed, 11 Dec 2024 23:11:00 +0300
Message-ID: <20241211201108.234285-2-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211201108.234285-1-bigunclemax@gmail.com>
References: <20241211201108.234285-1-bigunclemax@gmail.com>
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

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
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

