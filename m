Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECD7C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D8E387BDB;
	Fri, 29 Dec 2023 18:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FNtKqQa/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C051987BEE; Fri, 29 Dec 2023 18:47:16 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8D2C87B9D
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1kT088959;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=oReZScc9OuxUJkCJqhecgiAcM/MHbozPgnfagNFrKIg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FNtKqQa/6TPGk5V+CIJJyzcvz0yBGRYJIdN5LxhI9WyUaILMBLef00xihWgHbH+fG
 PXD3bYPRhefAEY/Aib5y0GpjEz+/CpDnU6ZiNl5AHn8z0anO1I/68ed3Yr0LRwFKW9
 /bcKLUBgg2aJz9/Z1/2yB1k985G0SOp3Igo0D5kQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl125066056
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1XO005070;
 Fri, 29 Dec 2023 11:47:01 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 12/26] arm: dts: k3-am654: add needed regs to udmap nodes
Date: Fri, 29 Dec 2023 11:47:09 -0600
Message-ID: <20231229174656.634065-40-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108; i=bb@ti.com;
 h=from:subject; bh=o0qRUGSBJBKJb/GU7v+0nEYKhFW1Gk7GiV7XLumB4TQ=;
 b=owNCWmg5MUFZJlNZgAtSwwAAYn////ff5z93+xe8I76nsw/vrP2/3l3vv9O3+D5am99vjH8wA
 RmzQ7U0AAAAaAyABoDQaeoGgAADQBpoaAMhoaNqHqaNGgeoeU00DT0mmg9NJ6bVEGjQ0yNDQ000
 NMRoGgxDTCaaNNMBABkBo000GQMhiMhpiNGQ0MENNMmgMmmjQMUbUBkaeU0Gg0GgA0ANBkGg0eo
 DQBo0A9RoYgaGjQHqDR6g00PUD0jQ00NNNDygIIg2nDe8QISCOBwqKXyQI58YT+2J6wMIGAp0+4
 FEtGuRy6IkbsPSbBV5g5iyJsExtGeauesqKrKN2O6gE6lrBktM12YIQToqkZHplFT3gdZK3OWOT
 XzezYtjWFO2j6S0umpR4Lpp7fy6t5vxG1X9/I5IWrx+XebKmqT3UPQb5R57mrHZFUtxrFt8XA+W
 7oFcKrFH4hxtNLFeN+D6Ft5FfJGYDX5/u3eXrHRmyWfnkcGcrvMpOUqPiF32ot++cmXUCdMpoIY
 S9rG3CM0qmpE4Wfxwg25kxiZ5bQ8aSnbpDCAy8VvH64vlyC/3MkjG+1+PAuG6pqqnZGVCs6W9b3
 wUaqxvlZaB75ij2ALNAppVcEeWyHMwyBFPcHdJSnoCgJwpHi/RyBx+pmTA6hw2aYg1iaTMigBDh
 HfU4ADFIgydXG/xdyRThQkIALUsMA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Ethernet is one of a few IPs in U-Boot that depend on DMA to operate.
However there are a few missing registers ranges in the udmap nodes
need to properly setup DMA for the am65x.

A fix has been added to the Linux kernel[0] to add these ranges however
they have not made it to a Linux tag. To keep DMA operational until the
next DT sync from Linux, add these ranges to the *-u-boot.dtsi with a
note for our future selves.

[0] https://lore.kernel.org/r/20231213135138.929517-2-vigneshr@ti.com

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index a008af5b4a047..a24cb895e5578 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -252,3 +252,37 @@
 &mcu_r5fss0 {
 	ti,cluster-mode = <0>;
 };
+
+/*
+ * The DMA driver requires a few extra register ranges
+ * which are missing for the am65x. A patch has been
+ * sent and will be synced after the v6.8-rc1 linux
+ * tag is published
+ */
+&main_udmap {
+	reg = <0x0 0x31150000 0x0 0x100>,
+	      <0x0 0x34000000 0x0 0x100000>,
+	      <0x0 0x35000000 0x0 0x100000>,
+	      <0x0 0x30b00000 0x0 0x10000>,
+	      <0x0 0x30c00000 0x0 0x10000>,
+	      <0x0 0x30d00000 0x0 0x8000>;
+	reg-names = "gcfg", "rchanrt", "tchanrt",
+		    "tchan", "rchan", "rflow";
+};
+
+/*
+ * The DMA driver requires a few extra register ranges
+ * which are missing for the am65x. A patch has been
+ * sent and will be synced after the v6.8-rc1 linux
+ * tag is published
+ */
+&mcu_udmap {
+	reg = <0x0 0x285c0000 0x0 0x100>,
+	      <0x0 0x2a800000 0x0 0x40000>,
+	      <0x0 0x2aa00000 0x0 0x40000>,
+	      <0x0 0x284a0000 0x0 0x4000>,
+	      <0x0 0x284c0000 0x0 0x4000>,
+	      <0x0 0x28400000 0x0 0x2000>;
+	reg-names = "gcfg", "rchanrt", "tchanrt",
+		    "tchan", "rchan", "rflow";
+};
-- 
2.43.0

