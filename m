Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E02C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E02283010;
	Mon, 23 Jun 2025 14:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IuUx02F9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A8F88210D; Mon, 23 Jun 2025 14:10:52 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3219181E13
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ade4679fba7so792697966b.2
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680650; x=1751285450;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MdkmOo5JgIRoyX9i1G1Egl7sCF4/UMa8O07aWzfl6h0=;
 b=IuUx02F95nhrkw7DUMkvuItd97W6mgOGZ5KB3DbWvl0yUR/E6boLmgYZBvQeRzWIkG
 hEU4k/ViOx0UFp8vCMjdkubCYFiRO1Uj1M1avf+hMIFAeemCZ6yBcpVEhzMnZ3QA0H+I
 /zFgXjhhstnPCSotqcng4HuVH7mPHIs22VXZYcSBId9OGAs60G5LyLxru1rUeI7VYcya
 ygiX47ZEvdF24efVuU6czvfuU4mbwunuyd+lYek1QMpGChZFIU2U8dNRByeOPMMjLehP
 FgYcwziOpX1rNhnSSl2qVcdCTrpN5UiGtSViZtp43ls0LG2arJ9gIvlemWrUx7Bu83dh
 qqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680650; x=1751285450;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MdkmOo5JgIRoyX9i1G1Egl7sCF4/UMa8O07aWzfl6h0=;
 b=fEZQF81nUxgWF1QpM6oIgj82eVNPBrDz33WViAHcbD96Z/J7pU/UzFcSNuLTAchsuC
 /Omcvdot24U6C+OyD4UZUClxEKIpXvblNlk4Fw0mgTbf7icxsqePQIhCS37b7vyi+OWm
 +9Oo5kEcO8Obu2bFAleuB5J8Bm6GzPntRumZeL7v0zxG3jM4cl3OA/yML5NuN5ucTHcB
 c+zCyIimdzJDIfs0QNET4Pyjv5pjpp/CkTA9O/hHK7h8ccQIUN34RXp9X568SORh1S+5
 i0noH2FBllT0+JqVMnWqdlT/YcQCHHqyiNumvImc/4ExfBDmbCf5iO1bMUXozgPLBCUi
 JyYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkYKdQivClJKXf3gSOT4fTagSSba08YLa/N5Wwem36V1srSis4VrhIpGzjPbjGOcYjheCpjmo=@lists.denx.de
X-Gm-Message-State: AOJu0YwlVbIBPqf3B/5miXfe8V7tsqtkQi3KcytKoZUZja5md2JSol8r
 iVcpEQrJuFP5aQq2F/B/Sd5gqDUF5TAWNL1eGq8WipIWsb4fL2EsQ1xwQXQqhiEX5Kw=
X-Gm-Gg: ASbGncs2gdupefmUOZStMZknL/Jzb+AtOSadb0TizUdB6FMIj+zPXGbA4hZ+61okixS
 aZMt/Hl88BeKlXE8NvFjQvV+bLQWyXuQ16pvuZ+5rH2XPadqeBZ8VwCPf7k/kc7wzaMnP0TNoOh
 9cmERjVmNGvoCDt44x3KpL9A/fz7LK4dJE6ZZIZ6vUEMSZAIixy1JG+1s5ltfZ09aa+/H0eJQ+K
 qwgGz7BxIcMm7KYaZy/IV8Q/Pi3iotk2XGBtFvC+XRUexVB8SoQf9MdaXmemPQNWpGqF5UQosIL
 wraCqofDJqbq2expVB4lCh8ynlYtY4r2Obz6yq7bdN7t+CyByysKjiUiw2Y=
X-Google-Smtp-Source: AGHT+IEFxxcwFp1YbeN3yu3IzqtADngXCe8JwMYO0TZWTBsl7zoilL8tLqBcusnD6zFZ+EPTpD0S4A==
X-Received: by 2002:a17:907:d8f:b0:ad8:8c09:a51a with SMTP id
 a640c23a62f3a-ae0578f5642mr1224900066b.4.1750680649555; 
 Mon, 23 Jun 2025 05:10:49 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae05420936asm698947966b.159.2025.06.23.05.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:49 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:41 +0200
Subject: [PATCH v3 18/22] arm64: dts: ti: k3-am62x-sk-common: Enable IPC
 with remote processors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-18-a4da322c16af@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2663; i=msp@baylibre.com;
 h=from:subject:message-id; bh=b8NdJhNGLketc0r5IVLYvz93baYlzk2k5bW6n3mZl7w=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxIFwmmm1seKIsqvroZE7WO9+ika7Zn74n8yTu7e6ZYf
 NACTuObHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjAR5jaG/xFMa/YwGLioFT1v
 D12kvngXz8vIVssIF4edTNM3PPhW2snIcMI+19fUNOJm16PUfJN/LBp1D1df1b3rGnj5eabPiz2
 dLAA=
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
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
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

