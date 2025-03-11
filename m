Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF53C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E274681A0E;
	Tue, 11 Mar 2025 14:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xEA95jck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF74881703; Tue, 11 Mar 2025 11:33:19 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11A8381782
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e6ff035e9aso641343a12.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689181; x=1742293981;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9x1Ar677Q7oTOeh6Y8GZFKd22RTtLtDDrvs0FFbVvpE=;
 b=xEA95jckAEWlpMkjsSbin23xV1DAiWXvNVPeg+7q1JAL4c0HiqiDuCuVLP+4whrKH9
 RXVPieukKeiJ4hwvgW/Y6TnUHDfimVUGl+6eZzWz6+TLSkUdsmVBgnMDmepPOBslrADM
 R+RrbJat2Dn8dhxIdWgNrHpXps1UK9yMrM0hmv1FOpM1y0mM9gQJXNrFchwzdnvdNUvb
 o4743WhSORk5b69Rpu9EqAVjYBGqGYRavv42qMCYJW8uxZIt1zWduNIrJjsL6kwRKtJR
 05rwrjiyyIXyUCo8LLWYjS6GQE/kLKi7hw6ujvfY7GomtY2E9pEa0VI+Q+Ld8WyfE1sJ
 oxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689181; x=1742293981;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9x1Ar677Q7oTOeh6Y8GZFKd22RTtLtDDrvs0FFbVvpE=;
 b=Asl38CHSgKS8eWY8MLyvKQP6g9Hcfbl/obyc2nJTCYcBEYfuwLI7CK1g5+4F7mozrM
 MRV5MHqRX1nQf9lg5Qbyuhe+ewqN4VLET3dHzkwPP5DGwqRGbmP49erlEXRpj8+YiCv6
 +Ii6yKR+m6S+pzOHo/InC2JNOa1+JAxZHcFfRWMPeoMewjoN3tfLX5gWQ5AeL/zJq5La
 Qfz6E/xzIj3rBSOEYXW9a2P4ebwTmqDfkSrEOov2tfDhSPaP6RPbxLWMelQYx778kICL
 mzn2zuoR9ee816u+8fuSA2q1wbJIwmXrs4LAukdx7dTfu1h69YKgCWepBfCOP2/Mzi3+
 ww9A==
X-Gm-Message-State: AOJu0YxFdcx8PFtCgmt3+Bx1+ab8JsCVHZIRNseRlwbEY/21RokoXOHC
 Z3lcir5h4ndTuEInGi1isoBlQrIofdPTtLA2+YVjCiy8Sakhybu8APZh7+JZUNkLxQZhjJQcrYR
 r
X-Gm-Gg: ASbGncsGbHAYKeEudh6JpFJt/5sqKK+2cCYNCw3/p7MXxTNJe6qXcBAUq7bhzFkezBW
 bsXT2KU4Segu3vEfZvdzT3SxuyvOkpEKGDqUTG0LqOrV1ktQCwjyBEQZdNM16MjVx5BNCFXpdgY
 nJeqkU+9LTj02/yWkW8c4jlfJi7WU2gWtErZlWn45rV6SC/UrPVJgMU2UwDpEEk/vankbrKXmro
 XEP9VnEHCA9eoYzD4j82WDzawF37IlXiu5FpP62UN8NMehYOJcwLbdHhpN3I3KLBb4xCTTZ6qhH
 NpyfQE4Ym6nuJ2Y7LcWyHvE1CMDDiIUhpKh8BAwG
X-Google-Smtp-Source: AGHT+IEmpKzhBsvULVQTGeu4kZueBibshhl9A5qH9Eh/PSaYG65vX/GjvLmeugw1nXyAqwKfRRQQ8Q==
X-Received: by 2002:a05:6402:34d4:b0:5e0:9056:33f7 with SMTP id
 4fb4d7f45d1cf-5e75f5a3465mr3999782a12.24.1741689180962; 
 Tue, 11 Mar 2025 03:33:00 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-5e5c768ecb5sm8074240a12.77.2025.03.11.03.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:33:00 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:52 +0100
Subject: [PATCH 13/19] arm64: dts: ti: k3-am62a7-sk: Enable IPC with remote
 processors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-13-666de9c105cb@baylibre.com>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Hari Nagalla <hnagalla@ti.com>, 
 Judith Mendez <jm@ti.com>, Andrew Davis <afd@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3579; i=msp@baylibre.com;
 h=from:subject:message-id; bh=UFqwuMyIVllvZ7Jqzt+IiqSGXY/RPIetPlz/XdRIiCU=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCGqxCT3v4KsVWOufcOjD5IDgK3NZFDnuXAj89lV4u
 vHdR5+fd5SyMIhxMMiKKbLc/bDwXZ3c9QUR6x45wsxhZQIZwsDFKQATWdzA8N99drbNqdU+MvEO
 lfN39z/ZLJ2SUnu1/f4FzXX/CmYGqJUw/E87IdrjudNu04XumF7vGamH4j90R5e9OdNWHn+k6si
 cK8wA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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
Acked-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20250210221530.1234009-6-jm@ti.com
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 dts/upstream/src/arm64/ti/k3-am62a7-sk.dts | 96 ++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 6 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
index a6f0d87a50d8a7ebdb61e609e8071d6681dbec9a..ac67c51caa2111db1283060af7ccc7b7780bf204 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
@@ -49,6 +49,42 @@
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
+			reg = <0x00 0x9c900000 0x00 0x1e00000>;
+			no-map;
+		};
+
 		secure_tfa_ddr: tfa@9e780000 {
 			reg = <0x00 0x9e780000 0x00 0x80000>;
 			alignment = <0x1000>;
@@ -60,12 +96,6 @@
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
@@ -737,3 +767,57 @@
 		};
 	};
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
2.47.2

