Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC57FC71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F9C382DA1;
	Fri, 13 Jun 2025 15:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YGXFXk74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3470082D57; Fri, 13 Jun 2025 15:22:16 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13BD182CA8
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad891bb0957so350049966b.3
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820933; x=1750425733;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qv8hh0+scgCapNBUyi4KcVwsEZez+halzo8sN6xsuIg=;
 b=YGXFXk74pP7d1of4idPIy6GeSnF8+ZVPdRjm1JQ5Lh+3sorWgEfsUE1sScjW23nVEj
 rJ+EGXV/frfGKaudzgqHlGGsV8GeQxtC9GRAjRamcQRDkJTGYsuUQuHQfxRwOx+KZ0Jh
 t4awt5H2hhlD567CMGX1GowLZCbQsxH0OozPEG/3x/2TP+wIBUsIWOxf8OBiQhzY4A6y
 thsIjF7IMHsTdwp1q0JSRF0TYc1Hh92A/9aoAkYEJJrpKFisq+8FbpA5ec5RwXD7Ense
 +4aSIuSb/ygyTk5Wgzcl3fM+X2WVnG6CbtZ8HToQH5b5kOQN8F9hIAeatX+qziWFW3NQ
 25UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820933; x=1750425733;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qv8hh0+scgCapNBUyi4KcVwsEZez+halzo8sN6xsuIg=;
 b=bhNtpTfdV8GcqUu5hcgj7GgixxfnRURvciHrrlPymg9stFxt3uEpZGYW5Hph07NC3I
 HXUip5wqMA2RQ+srAUd1Z8O3GrgByKcV3ne5oGvXPmQeH/EIg8uG4mGq3x9OqhfDfFzL
 FRbih8v1ldNpPVs6fNUPMT1erUY2ed98vuzXSMfSE7JYbeMX3DAW5L7GCGBZa2FYYsWn
 371WFydgvs+FaHJPz6A1S+cCYM+OfftK/jkGzQ4ED8sifh80llKzMcfQ5dxiAdp69SsR
 c+i6E+wpuClnlLVzMvQhY8hwCVAxf71khNXC0pKzss3QhBusetPdA0eYRcnpPCAkuMMf
 9USg==
X-Gm-Message-State: AOJu0Yws5XzkVudgP7u3daBEnJfBB8GLT9ce4wlAGzKwTfCrQSOa4oeH
 JkCeViAZ8peGecUQbZFwyuZDWczrnxKeO6LUypPRvTA/SVfSLIP+r5mbG9TdRrJeG2gkklJhu1P
 zLLH0
X-Gm-Gg: ASbGnct+MI0QR6ikJPevs5IBm2u0woVv1QrwI/Q8QyJFp6dRpeQrfcRt35BAk3YBsRF
 CYLwc274nTtbbd06ay26Vs54yuK3C5bCggi1xETs1KMQj8mZVDTgTZTCdB4zNzeMDOLOvhQ6jeJ
 xNaxkK+mxRg4d76aYn7YfDwNm4ecQG2/v9V9pf8jkqMBSYHfBnT/oQWOTFhWeXMRcpEIRELYefY
 VtipFaseoP3yZeKHryfA1sL98cFpUQD4ktk8v3HSxG/zmLfeMMBevT68rLR8mqkgFKBm3OFl8Vu
 H7diMAinolIIJE9G5DQq5djMkipIclOM+4voouVvVo3LMe3dblDlMlknO+c=
X-Google-Smtp-Source: AGHT+IH3gqKC3aaE1jY2CITNtNX6M7RBnaTRzCeFcA66k0YkvrqnZtamAtk95yS0sYXMiSkwnaT4Ow==
X-Received: by 2002:a17:907:9603:b0:ad8:8364:d4ac with SMTP id
 a640c23a62f3a-adec5caaba6mr310204566b.55.1749820933403; 
 Fri, 13 Jun 2025 06:22:13 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec88feb23sm128696066b.96.2025.06.13.06.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:13 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:38 +0200
Subject: [PATCH v2 18/22] arm64: dts: ti: k3-am62x-sk-common: Enable IPC
 with remote processors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-18-3d233aaea355@baylibre.com>
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2547; i=msp@baylibre.com;
 h=from:subject:message-id; bh=E6DfkZp9tcL+PEIlep9jBaNkPbqPTks6O1lYrapuBHM=;
 b=kA0DAAoWhcFWaZAVSlMByyZiAGhMJdehfi1CB97rLy8tcmjE5QOLucyHqBKt/mFaCfHw35QMs
 Ih1BAAWCgAdFiEEiWFVZv8fucZjoqazhcFWaZAVSlMFAmhMJdcACgkQhcFWaZAVSlNQqwEAt+WW
 83ALRzDY8Ftj/eShe0xs1I4Fc0Ryq+Yug76gADIA/0e+WKDvjPajX5kxioRH951sRglGnbPh8eg
 AcpbKMM4B
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 13 Jun 2025 15:59:32 +0200
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

From: Hari Nagalla <hnagalla@ti.com>

For each remote proc, reserve memory for IPC and bind the mailbox
assignments. Two memory regions are reserved for each remote processor.
The first region of 1MB of memory is used for Vring shared buffers
and the second region is used as external memory to the remote processor
for the resource table and for tracebuffer allocations.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
Acked-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20250502220325.3230653-9-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 8fb034b8402ead1028ed63394a177947b1450fcd ]

(cherry picked from commit 4dc654f3ea4fca3be4b8140bbb0df9b6416f3b67)
---
 dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi | 34 +++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
index 17f97434b91ae8c9e46da872e0a08a60ec4fbc0c..4060e740a659e88af6b3ee9d3fa258a85705e80e 100644
--- a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
@@ -70,6 +70,18 @@
 			no-map;
 		};
 
+		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9da00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9da00000 0x00 0x100000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_memory_region: r5f-memory@9db00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9db00000 0x00 0xc00000>;
+			no-map;
+		};
+
 		secure_tfa_ddr: tfa@9e780000 {
 			reg = <0x00 0x9e780000 0x00 0x80000>;
 			alignment = <0x1000>;
@@ -82,11 +94,6 @@
 			no-map;
 		};
 
-		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9db00000 0x00 0xc00000>;
-			no-map;
-		};
 	};
 
 	leds {
@@ -475,10 +482,17 @@
 };
 
 &mailbox0_cluster0 {
+	status = "okay";
+
 	mbox_m4_0: mbox-m4-0 {
 		ti,mbox-rx = <0 0 0>;
 		ti,mbox-tx = <1 0 0>;
 	};
+
+	mbox_r5_0: mbox-r5-0 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
 };
 
 &mcu_m4fss {
@@ -488,6 +502,16 @@
 	status = "okay";
 };
 
+&wkup_r5fss0 {
+	status = "okay";
+};
+
+&wkup_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
+	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
+			<&wkup_r5fss0_core0_memory_region>;
+};
+
 &usbss0 {
 	bootph-all;
 	status = "okay";

-- 
2.49.0

