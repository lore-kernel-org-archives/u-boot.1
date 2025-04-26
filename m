Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C65C369CB
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 17:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E325A82076;
	Sat, 26 Apr 2025 19:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="B5uDumUw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7AAA82105; Sat, 26 Apr 2025 19:01:36 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB61482045
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 19:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id A56BF25D52;
 Sat, 26 Apr 2025 19:01:34 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id veXu9ylnSac9; Sat, 26 Apr 2025 19:01:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745686893; bh=AsTZs0ine29r4pc4ea/ubYLuZpTCdjEdHqGVrjTZP7c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B5uDumUwBfFGKIPbIYBt6rUxWkOY6HdA5NUBny/Mqtw9wiAFPXTetB7msjkNywrVz
 a04AbFz+yS2N25PmLJd9IqrVLuUA8DpTIv5MfhnsBCbpp91LarUDfcJS+7hStoyhVX
 CrBWRwdImaTBL7zCcE0hmbIAsQjOq19BKliwuTHd9iQw633hzKDLjYIudImn7vM9Y7
 ReS6As0/DHahQGTpGuy5W9tA79sEZFi+2OTkWA5sJWsFmJlhMpCjhCoEOqIdoPvXcY
 CeYycKT6C4Pxs9dSzUzP8OxXhvnJ6zdmBMZu4DGrW5lXlZ0bmcfi38Q7vmrE85JimY
 ulcB3iIq8xM/Q==
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
Subject: [PATCH 05/10] riscv: dts: th1520: Preserve necessary devices for SPL
Date: Sat, 26 Apr 2025 17:00:54 +0000
Message-ID: <20250426170059.35571-2-ziyao@disroot.org>
In-Reply-To: <20250426165704.35523-1-ziyao@disroot.org>
References: <20250426165704.35523-1-ziyao@disroot.org>
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
---
 arch/riscv/dts/th1520.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/dts/th1520.dtsi b/arch/riscv/dts/th1520.dtsi
index e4c8cee66bc..ef84d8cc265 100644
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
 			clock-frequency = <100000000>;
-- 
2.49.0

