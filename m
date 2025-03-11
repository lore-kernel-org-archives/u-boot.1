Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B440CC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F1381C84;
	Tue, 11 Mar 2025 14:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YUz8Wq0d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E6281951; Tue, 11 Mar 2025 11:33:18 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF8F816AB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac286d4ed05so374412066b.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689183; x=1742293983;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2YWsDofVcUDTjP2/cs7XDrLpekdtWwv1Ygee/zfPdfQ=;
 b=YUz8Wq0d3ek0PoO7Q+rr260BMwOU5F7lAYbiCk/V/4wndy+2U5mp4ILboJ4U2Gzy0Y
 bQ2zot8ygOYi+7kycvRh9bRPOdmUI5BUHQW2s/PTMfBfqoPGyMblHAHlaz0ZdV6R2h2c
 nyh+0ZxHgstuGXFVM+d3bAY3yVT5Bhic19yNBa7nX63sQiHsVlFFQf9a4SX6N/PkPAig
 ruoRCE1c7MyK0zZP2KAmGaAE7Yw6BkcXEko8d7N4GfrBLwHIVDYFI0fxn85X7/mlVfz3
 OxaNE1xNBsgbbS2Mw+8gWgdtSep/wLjwiLJiBdZyuQbefFrv8313P4uk63v/dxABJZRR
 VxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689183; x=1742293983;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2YWsDofVcUDTjP2/cs7XDrLpekdtWwv1Ygee/zfPdfQ=;
 b=LAzNnISDHDYhoXTHH+QVrEPOPh6SjOFrSyl0KTneLAfI9r3lR+OXjpmHqUIn4S4nPm
 MdcSgkdof7Tnh48cBtQz2/Bi8r3z/BSxMDN7nyth+nZCc58FpXpSUXNBtqBkXI3t7LTI
 QiQ6Zm2lGO2PQxU0WYZYhfJL8tb/h2TycOjgBgcBTtnZGphlDGq1Bffflc1jh2GvG7X4
 a7b2D34stC+zTQaAn2R4w9gZMm2Bjgh9cWrB0aelj5R3nqO9GHW9JOmV5x7v6fQjRFVw
 Uqe1NwkeN1aPQY8zzx3yLERztPWcNVPMjjZSkYQwqwozLXItNYis4Zxn9VL3PJSvk/IV
 9uUg==
X-Gm-Message-State: AOJu0Yzs2ozeOXe2pEJuaY0vclYbz8eFbfq6ZLEQpYbJRohVnN8IkwYE
 XpnIF1UqUi3tuKx23nIffpksJmU/g5g/dO+czHVfls2AeUJrWXzOwaC6B+ZFwUONab1hLKX4M39
 b
X-Gm-Gg: ASbGnctpuqFiFnOUDy3hsH6tjqv/T70cXJRwkcjyVTbAGblwUfSdZWQNroyIu+hELfd
 7zh9bmxx0bl1mgkgul8jeCX5O133MyfMUGv8aCaSela1u9tSiHEiuyLJoSD6WY/7NuoOI/jAqgg
 gi00pb8sOo/I5SVhFX2DlJxJJPu+4qFzQ4T6xJnQmaAhEYngEkpE3Pc+2Dw3fNYGGyCsUAw48cd
 BmCaCV53qpRPWQM9qR7Kt+BN6xh2pOkPLmQBMfWSk/m826+Ba4beYX6U1NECGHOuqrWjj2qP57j
 O4j25f518Yq0huIrwRr/ySDWBmcDQZrKkl/LyucN
X-Google-Smtp-Source: AGHT+IF3E/snfII47dB8WYa+C6XNNl0KIo/mKJPttbxGkfew2RJrK3HeKLYi2gh6mfq1l8CgTle6Nw==
X-Received: by 2002:a17:907:3f2a:b0:abf:76d1:f0fd with SMTP id
 a640c23a62f3a-ac2525f9ae1mr1718297266b.19.1741689183078; 
 Tue, 11 Mar 2025 03:33:03 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ac28c11561dsm435699366b.145.2025.03.11.03.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:33:02 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:54 +0100
Subject: [PATCH 15/19] arm64: dts: ti: k3-am62x-sk-common: Enable IPC with
 remote processors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-15-666de9c105cb@baylibre.com>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Hari Nagalla <hnagalla@ti.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Judith Mendez <jm@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2418; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Yek+jQEXE1/XgA6hhlLnJUUeeecldhGEp7f0MhyMa+w=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCJo987nM+r8rTGLnLJFaxscb7tf7LeuczBF8RqX6Z
 6iM9IFrHaUsDGIcDLJiiix3Pyx8Vyd3fUHEukeOMHNYmUCGMHBxCsBENugz/BVR+feVqd105dSL
 mi/XTO2znN0QtjM+Q2iZzSXnnCnJU1YyMsxc5HBkCtvW1UfTanh1V93i71z88YBgEdfnrwm9qml
 /IzgA
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

From: Hari Nagalla <hnagalla@ti.com>

For each remote proc, reserve memory for IPC and bind the mailbox
assignments. Two memory regions are reserved for each remote processor.
The first region of 1MB of memory is used for Vring shared buffers
and the second region is used as external memory to the remote processor
for the resource table and for tracebuffer allocations.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
Link: https://lore.kernel.org/r/20250210221530.1234009-8-jm@ti.com
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi | 35 +++++++++++++++++++----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
index 6957b3e44c82f169e77aee94d19c709ccc1ff610..816d9fca27a8e288c4eb45d781a5cad86765574d 100644
--- a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
@@ -68,6 +68,18 @@
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
@@ -79,12 +91,6 @@
 			alignment = <0x1000>;
 			no-map;
 		};
-
-		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9db00000 0x00 0xc00000>;
-			no-map;
-		};
 	};
 
 	leds {
@@ -470,10 +476,17 @@
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
@@ -483,6 +496,16 @@
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
2.47.2

