Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D046C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 09:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4641082D06;
	Wed, 18 Jun 2025 11:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="SVY6QD/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA65982D21; Wed, 18 Jun 2025 11:55:28 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF2382C8D
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 11:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id AB4A420943;
 Wed, 18 Jun 2025 11:55:26 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZglFOqUr5AcD; Wed, 18 Jun 2025 11:55:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1750240525; bh=fR2pKIZdmllUCVo4/1hIJx7P257TelJCrqk8cmIEvVE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SVY6QD/OUZBTaPTtX36GdnQfmU0GDgHrKQZ+6Uv+ALscd9MhuM5t6eGlSdPcyBBbp
 jYJfSdHSftLcvFroyziRVWeG0XesTMkPV09Bfn8vbeuGC8PPmpBgOMCPvpNH5l+n+e
 ktlmZ03ij8OuWV6EMtuk20ef7UOWDuj6MO0kG+nE1yZxudZgLMIq/D4wQdHF3dt08f
 VoOR5h3nh7Y7SR2C8z9qs/5NBv0UKV6VxFkgXTZREAvisgy01Cic2NA34/Y+j17Fzj
 bjC9wbgwjC1lTNFLl+Yc0hJnK+WCActtMZSPpy4z/Xbcxa3ODKNokVdYuFytH7K9Sx
 GnjtLeY3/eYxA==
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH 2/3] riscv: dts: th1520: Add pin controllers
Date: Wed, 18 Jun 2025 09:54:56 +0000
Message-ID: <20250618095457.45926-3-ziyao@disroot.org>
In-Reply-To: <20250618095457.45926-1-ziyao@disroot.org>
References: <20250618095457.45926-1-ziyao@disroot.org>
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

Describe the three pin controllers integrated in TH1520 SoC. Since we
don't have support for clocks in the AON region, a dummy fixed-clock
node is added to supply the pin controller locating in it.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/dts/th1520.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/riscv/dts/th1520.dtsi b/arch/riscv/dts/th1520.dtsi
index e773d2e6a80..8306eda5521 100644
--- a/arch/riscv/dts/th1520.dtsi
+++ b/arch/riscv/dts/th1520.dtsi
@@ -128,6 +128,13 @@
 		#clock-cells = <0>;
 	};
 
+	aonsys_clk: clock-73728000 {
+		compatible = "fixed-clock";
+		clock-frequency = <73728000>;
+		clock-output-names = "aonsys_clk";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -259,6 +266,13 @@
 			};
 		};
 
+		padctrl1_apsys: pinctrl@ffe7f3c000 {
+			compatible = "thead,th1520-pinctrl";
+			reg = <0xff 0xe7f3c000 0x0 0x1000>;
+			clocks = <&clk CLK_PADCTRL1>;
+			thead,pad-group = <2>;
+		};
+
 		gpio0: gpio@ffec005000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0xff 0xec005000 0x0 0x1000>;
@@ -299,6 +313,13 @@
 			};
 		};
 
+		padctrl0_apsys: pinctrl@ffec007000 {
+			compatible = "thead,th1520-pinctrl";
+			reg = <0xff 0xec007000 0x0 0x1000>;
+			clocks = <&clk CLK_PADCTRL0>;
+			thead,pad-group = <3>;
+		};
+
 		uart2: serial@ffec010000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xff 0xec010000 0x0 0x4000>;
@@ -439,6 +460,13 @@
 			};
 		};
 
+		padctrl_aosys: pinctrl@fffff4a000 {
+			compatible = "thead,th1520-pinctrl";
+			reg = <0xff 0xfff4a000 0x0 0x2000>;
+			clocks = <&aonsys_clk>;
+			thead,pad-group = <1>;
+		};
+
 		ao_gpio1: gpio@fffff52000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0xff 0xfff52000 0x0 0x1000>;
-- 
2.49.0

