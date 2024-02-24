Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3658FC54798
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 00:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E0EC87BCB;
	Sat, 24 Feb 2024 01:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CZP7k3eD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B60F8780A; Sat, 24 Feb 2024 01:17:25 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F608781D
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 01:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41O0H7x8073673;
 Fri, 23 Feb 2024 18:17:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708733827;
 bh=901SYfW3Vle5Z3tVcRXogYDQQeSh7a0jBxU1zIBMVXg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=CZP7k3eDp+NYVaHNvvqjqKZRZWVDVxeoK9xJHbo3Nc4HF1GJzBohCfoydDgcfeGV0
 /TK8xs71/N0MEPN/01Dm58PfMEuJIrwi9q0/DY0YzoljSiMBrAVQMHeG7nf5cbMqTs
 4RUGwsYkPY3th0CpN6okkv8/kGxMhK/PlcXWy9RA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41O0H7sK015298
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 23 Feb 2024 18:17:07 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 18:17:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 18:17:07 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41O0H7tb072359;
 Fri, 23 Feb 2024 18:17:07 -0600
From: Jonathan Humphreys <j-humphreys@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH v2 2/2] arm: dts: k3-am642-evm/sk: Enable OSPI support in SPL
Date: Fri, 23 Feb 2024 18:17:02 -0600
Message-ID: <20240224001702.2283727-3-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240224001702.2283727-1-j-humphreys@ti.com>
References: <20240224001702.2283727-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Sat, 24 Feb 2024 01:47:06 +0100
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

Add bootph DT tags to enable OSPI in SPL.
Set OSPI regs for R5 SPL to address OSPI's boot region.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 arch/arm/dts/k3-am642-evm-u-boot.dtsi | 16 ++++++++++++++++
 arch/arm/dts/k3-am642-r5-evm.dts      |  5 +++++
 arch/arm/dts/k3-am642-r5-sk.dts       |  5 +++++
 arch/arm/dts/k3-am642-sk-u-boot.dtsi  | 16 ++++++++++++++++
 4 files changed, 42 insertions(+)

diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
index b843078243..60b219c0be 100644
--- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
@@ -182,3 +182,19 @@
 &cpsw_port2 {
 	status = "disabled";
 };
+
+&ospi0_pins_default {
+	bootph-all;
+};
+
+&fss {
+	bootph-all;
+};
+
+&ospi0 {
+	bootph-all;
+
+	flash@0 {
+		bootph-all;
+	};
+};
diff --git a/arch/arm/dts/k3-am642-r5-evm.dts b/arch/arm/dts/k3-am642-r5-evm.dts
index 64b3c3af63..6825c07df3 100644
--- a/arch/arm/dts/k3-am642-r5-evm.dts
+++ b/arch/arm/dts/k3-am642-r5-evm.dts
@@ -120,3 +120,8 @@
 	/delete-property/ assigned-clock-parents;
 	/delete-property/ power-domains;
 };
+
+&ospi0 {
+	reg = <0x00 0x0fc40000 0x00 0x100>,
+	      <0x00 0x60000000 0x00 0x8000000>;
+};
diff --git a/arch/arm/dts/k3-am642-r5-sk.dts b/arch/arm/dts/k3-am642-r5-sk.dts
index daa483a781..60d747ddd5 100644
--- a/arch/arm/dts/k3-am642-r5-sk.dts
+++ b/arch/arm/dts/k3-am642-r5-sk.dts
@@ -103,3 +103,8 @@
 	/delete-property/ assigned-clock-parents;
 	/delete-property/ power-domains;
 };
+
+&ospi0 {
+	reg = <0x00 0x0fc40000 0x00 0x100>,
+ 	      <0x00 0x60000000 0x00 0x8000000>;
+};
diff --git a/arch/arm/dts/k3-am642-sk-u-boot.dtsi b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
index 2eb227c1d0..2b42c74190 100644
--- a/arch/arm/dts/k3-am642-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
@@ -211,3 +211,19 @@
 &serdes_refclk {
 	bootph-all;
 };
+
+&ospi0_pins_default {
+	bootph-all;
+};
+
+&fss {
+	bootph-all;
+};
+
+&ospi0 {
+ 	bootph-all;
+
+	flash@0 {
+		bootph-all;
+	};
+};
-- 
2.34.1

