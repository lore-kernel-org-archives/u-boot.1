Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A956C3ABC9
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 09:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86EC182A1C;
	Tue, 13 May 2025 11:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="BoRZpQHr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 568E682A39; Tue, 13 May 2025 11:06:43 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7479C8294C
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 4201A25C49;
 Tue, 13 May 2025 11:06:41 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rTdg8A4dNxIw; Tue, 13 May 2025 11:06:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1747127196; bh=dv12ssYfFApZo6obse2pFRs516bEP/zgs/4tIX9ywHg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BoRZpQHrh48DhhZVO9RlN+AqZmL3Y5Zhzd81GaIP7gV9dJr+gL/GN6YWoyMe308Qh
 ynY0IfRuguKNKFjUAN9PqhrUznBgZoCNO0yXn4o30fD+O/x8wrsoLO4/r2QNbu0sL9
 Blj+//05JMGauKlSGX01FMA3QCaL9ogKGbFM54jMhmJaXV/mvzowuYKobwePJiQq6Q
 GJDICaYLnT+pl46grPxTJygrXLfSimtaIydyRQV98FYOjxf9a3Ow0pTXtSW2oSv2hW
 xeoMZmf+5CbxffeTWU3Ck/X2Cqyf5yrq6Z354QtJ8gos731LqNOetteHs0t0II9pMu
 B+FIwxI+qrVpw==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Vaishnav Achath <vaishnav.a@ti.com>, Andrew Davis <afd@ti.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 05/10] riscv: dts: th1520: Preserve necessary devices for
 SPL
Date: Tue, 13 May 2025 09:04:58 +0000
Message-ID: <20250513090503.46670-6-ziyao@disroot.org>
In-Reply-To: <20250513090503.46670-1-ziyao@disroot.org>
References: <20250513090503.46670-1-ziyao@disroot.org>
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

SPL for TH1520 requires CPU and boot UART nodes to function. Preserve
them in SPL devicetree blob with bootph-pre-ram property.

Signed-off-by: Yao Zi <ziyao@disroot.org>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/dts/th1520.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/dts/th1520.dtsi b/arch/riscv/dts/th1520.dtsi
index cbe3481fadd..b34ac323503 100644
--- a/arch/riscv/dts/th1520.dtsi
+++ b/arch/riscv/dts/th1520.dtsi
@@ -14,6 +14,7 @@
 	cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		bootph-pre-ram;
 		timebase-frequency = <3000000>;
 
 		c910_0: cpu@0 {
@@ -21,6 +22,7 @@
 			device_type = "cpu";
 			riscv,isa = "rv64imafdc";
 			reg = <0>;
+			bootph-pre-ram;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
 			i-cache-sets = <512>;
@@ -42,6 +44,7 @@
 			device_type = "cpu";
 			riscv,isa = "rv64imafdc";
 			reg = <1>;
+			bootph-pre-ram;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
 			i-cache-sets = <512>;
@@ -63,6 +66,7 @@
 			device_type = "cpu";
 			riscv,isa = "rv64imafdc";
 			reg = <2>;
+			bootph-pre-ram;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
 			i-cache-sets = <512>;
@@ -84,6 +88,7 @@
 			device_type = "cpu";
 			riscv,isa = "rv64imafdc";
 			reg = <3>;
+			bootph-pre-ram;
 			i-cache-block-size = <64>;
 			i-cache-size = <65536>;
 			i-cache-sets = <512>;
@@ -173,6 +178,7 @@
 		uart0: serial@ffe7014000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xff 0xe7014000 0x0 0x100>;
+			bootph-pre-ram;
 			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&uart_sclk>;
 			reg-shift = <2>;
-- 
2.49.0

