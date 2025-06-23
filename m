Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CC1C77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9806582FAB;
	Mon, 23 Jun 2025 14:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZtAazZks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1064082D17; Mon, 23 Jun 2025 14:10:50 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9BFF82D21
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-acbb85ce788so788633366b.3
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680647; x=1751285447;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cGhQZc1VlGuyV4FSyTGkSKLMRQzUGWyZi8K75wG8/Hk=;
 b=ZtAazZkswCSVOZT9szUZj+LZIWnY942cNtNdP5lg7TiRTGq2ox7nbg9+IrE3B4NLHQ
 T5OVVbU8VhpN5Z9CSN1UplKRaM/23WL5CF19mV6Fs2CFApQrctaF1Q0t2RLoo45VDPFz
 mXUQy3/5nq5pCNh2MZMqnSCZijv0SNG2wWljRiH3dWQ7aRS2mI2KuAJcTD5QkcfKLmwA
 nb0U5fkBMKWJq+KglCnXltPdugtndC1rjKqz3uO+m3SQcWPh2BlbI++iLJdXmQIvUabu
 4cU75/78cc8JzUalC+aUX+aquzfe8LWr9Q5f8AX8hVFO1x8p8cDT2S39jkUE9hNK/jkk
 QwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680647; x=1751285447;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGhQZc1VlGuyV4FSyTGkSKLMRQzUGWyZi8K75wG8/Hk=;
 b=DyWkynxCGKnoAKjByIBTDydwvUgMlLErk0G74HA1fuw6xtTb4//IxLw57gS2nJyWSM
 6VSYZeZs8CCPe5G5jSYyxYkZ8S8xWVpZ7XTcJdyEn7X8ggjx9JDCS57EMIyjc3xVZmQ9
 JhDZu2gWqxMNk/61d1fKsclgApl08Oc6wxumUQ9/NCNSceifI79vsf/OH2ncVJcP2M7N
 2SFGgAm0uWypAa4sNXCOe4JMvKYfjD6bURM1MX1q1/zUN9t6bRNQmY2gW6ehdNtXWvv6
 rMLtg3K6cpq/R0ND5x5SyxJq5golTzjEv6bXkKSVjUMgwuKVsXC7sJOPcCANlODH7/TN
 AXOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUoB1/cf1x+jCnXaiMf7I2CE8xQY3Y8Mzi983QKYdIbbv8HWIjBQexpcT8TArEppWgAmIoXAY=@lists.denx.de
X-Gm-Message-State: AOJu0Yzpl51vLGlGHeEEwaPNgM4fm2uL+TKak12lj58ZEdN/Xapu3xCL
 aQtZRQPCvCrvTUf73TNeIrPnmSkPOvKcWqw3fzmZDisdfE2Md9kKe1LyJeDJHMnevTc=
X-Gm-Gg: ASbGnctQO7QpoCNpbuDLFJs7uAvMIGte+/jIjwLoVMdwEmbhBd5zm1tzQP6tu2+Iumx
 QbNz7qqatXyKL3DTLkZ2Ux262BFin0DfzXsfTpVtUDKRH0HcC4H6IajMW1+hic3BsH8JmDtNxMz
 ngvWZOxvIvQbmBAtFFVxXa5VYUf1rNZ7DzxmevcOjUQj3+gZK27H239Pa8xQV3gi4AcyC3JTwXk
 bbP23rC8HMrnwqAjHtH6c/dL6vW8H0Xt3MGUHyO82zEuqpc4TrvGAdiTWaM97vK0bu4Du5vv16I
 8aIntPNKTNccMN78j9hWLxE16ELLwk+GMRMSVPPjpokAXbgWsp7RNQILjs0=
X-Google-Smtp-Source: AGHT+IHbjB1apCLX2wfihE0VvDAPnhZX1tBnpbWjvimhZBO0JcbY82r4IBO4H4xhiuocgMbJ5Ou84A==
X-Received: by 2002:a17:907:1c8d:b0:ad8:8ac5:c75e with SMTP id
 a640c23a62f3a-ae057c709dcmr1103703466b.60.1750680647046; 
 Mon, 23 Jun 2025 05:10:47 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae053ecbee6sm714901366b.52.2025.06.23.05.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:46 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:39 +0200
Subject: [PATCH v3 16/22] arm64: dts: ti: k3-am62a7-sk: Enable IPC with
 remote processors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-16-a4da322c16af@baylibre.com>
References: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
In-Reply-To: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
To: Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, u-boot@lists.denx.de, 
 Kevin Hilman <khilman@baylibre.com>, Vishal Mahaveer <vishalm@ti.com>, 
 Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3964; i=msp@baylibre.com;
 h=from:subject:message-id; bh=KsPNyYHgGVkLAShV9avZjdlExL3guHM2N5L81P65p1Q=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxIFz55l7eyCybFThFtFxeSulpue+G2bZ/7DEe9jGzTm
 DcVkts7SlkYxLgYZMUUWToTQ9P+y+88lrxo2WaYOaxMIEMYuDgFYCJ/tjEybNjVVK6TdvD16tkr
 1s2esv0IW2z0ioksIr2zDbtmXFl4uZjhr7DA1q/7eFYmRQhMi3p768fndV337HXlQ/tNT2Qm+Z/
 R4AcA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 23 Jun 2025 14:23:35 +0200
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

From: Devarsh Thakkar <devarsht@ti.com>

For each remote proc, reserve memory for IPC and bind the mailbox
assignments. Two memory regions are reserved for each remote processor.
The first region of 1MB of memory is used for Vring shared buffers
and the second region is used as external memory to the remote processor
for the resource table and for tracebuffer allocations.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Jai Luthra <jai.luthra@ideasonboard.com>
Acked-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20250502220325.3230653-7-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 77c29ebe76d80174d5735b61edd3c95e32a75d2e ]

(cherry picked from commit 2cf6f198463cb250137fc009db599ca93241ef0a)
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 dts/upstream/src/arm64/ti/k3-am62a7-sk.dts | 96 ++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 6 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
index c65ada5a22abbd88a70e81703c28b7b83461c6c8..59a872413bab1f580610d8c7cc0a0eb2187d7db1 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
@@ -52,6 +52,42 @@
 			linux,cma-default;
 		};
 
+		c7x_0_dma_memory_region: c7x-dma-memory@99800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x99800000 0x00 0x100000>;
+			no-map;
+		};
+
+		c7x_0_memory_region: c7x-memory@99900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x99900000 0x00 0xf00000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@9b800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9b800000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core0_memory_region: r5f-dma-memory@9b900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9b900000 0x00 0xf00000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9c800000 0x00 0x100000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9c900000 0x00 0xf00000>;
+			no-map;
+		};
+
 		secure_tfa_ddr: tfa@9e780000 {
 			reg = <0x00 0x9e780000 0x00 0x80000>;
 			alignment = <0x1000>;
@@ -63,12 +99,6 @@
 			alignment = <0x1000>;
 			no-map;
 		};
-
-		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9c900000 0x00 0x01e00000>;
-			no-map;
-		};
 	};
 
 	opp-table {
@@ -782,3 +812,57 @@
 	pinctrl-0 = <&main_epwm1_pins_default>;
 	status = "okay";
 };
+
+&mailbox0_cluster0 {
+	status = "okay";
+
+	mbox_r5_0: mbox-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster1 {
+	status = "okay";
+
+	mbox_c7x_0: mbox-c7x-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster2 {
+	status = "okay";
+
+	mbox_mcu_r5_0: mbox-mcu-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&wkup_r5fss0 {
+	status = "okay";
+};
+
+&wkup_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster0>, <&mbox_r5_0>;
+	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
+			<&wkup_r5fss0_core0_memory_region>;
+};
+
+&mcu_r5fss0 {
+	status = "okay";
+};
+
+&mcu_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster2>, <&mbox_mcu_r5_0>;
+	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
+			<&mcu_r5fss0_core0_memory_region>;
+};
+
+&c7x_0 {
+	mboxes = <&mailbox0_cluster1>, <&mbox_c7x_0>;
+	memory-region = <&c7x_0_dma_memory_region>,
+			<&c7x_0_memory_region>;
+	status = "okay";
+};

-- 
2.49.0

