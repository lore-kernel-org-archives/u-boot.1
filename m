Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C53C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE07382EC6;
	Fri, 13 Jun 2025 15:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gy+NAbxT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E50782CA0; Fri, 13 Jun 2025 15:22:15 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E848A82D09
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ade58ef47c0so423309266b.1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820932; x=1750425732;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SklMoIuYyVKcROmM6hz7ijMMgtfSYxuCtsoXa4B/F1Q=;
 b=gy+NAbxTcuk9mvkcDFqVX/yn1WKRqgio1CuHZA6x8HjwAj+9RXsyI2mDmukf09N77r
 JCqVHrd7kUtfnpWzu8/ohr8wO9g5WhGtc2oLvoCMlo70ZbTKk+NPmSpaRZDhR9f3Ptpn
 ZbuW5a0iswnAkLxNNqrmQQpyQAX9eP4WTZqg/eWVBuPZpSm3GgHNuQ+8LCkRzygDR2PK
 fYxENnE9/ziU+yT8FNrw8szp5qfOKeWtlAhmgenA2IdONjlXD6VVyfcAZ2Ha7mKDxgWI
 8Cqg/Oef0GTO+O+iKGCoj7FilnVzT37fCMqfsFJzl5KjV6KFjiumkYRFerh7WucKaU/v
 QNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820932; x=1750425732;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SklMoIuYyVKcROmM6hz7ijMMgtfSYxuCtsoXa4B/F1Q=;
 b=sPhYLhlLdrB9IOo4BLBN68Ae/6zrFB11HKIKa7kvZGkIgZ9TfyLDbY9UsUVxcPakTa
 160GubQeIM3SzGC3fsiFsrzo3NPp7AjC8aIoe4YIo1DG82tTZqElLEbpgBsDHi09HTHP
 jrWI0wzm4FIiQF7FTNEFlYGBjTppnBr9u6vhqPSztc0wnNadaxo/GIe+itzUpf97Tb9Q
 x7bLjJszFYyvRd9STv9v91lDdyyvWmM+6Dfepq+U392tncLPSc6IXXuJbkjhP+crYZR6
 h5w0roDcLhQV9uNsTy+zTqATZsluIp6dVB+sWQCvVsj8sPb3akOC4W/xQVasjhC4LM4Z
 zNDA==
X-Gm-Message-State: AOJu0YxztfGWfX0BwFpDhZGvKlU817l2WbqfBAFgsEPaMVIOpqwoJPml
 BMhg933IcDEvpWGSWEEYi7M3tS//pW/91lmy+IXv2C5rZS5NtAAYZpF/6Kn8NeoegjOpOat4oCs
 uacMg
X-Gm-Gg: ASbGncvaRi60P/9+s2/1dlLQoW1p0yvboNxVXH1a9DE11trBTzi2U8Vlh0mu4HsBXK/
 ZlH5UVamqQQJpyfjCT+p4tEm8LkGHQI37WaIcNX7iMCRtbdBCMOuCVGx9Z14uVdx4klrGD4YkBy
 HipSr6BmcjjdcAMy7j26gehmdcvbivMCWao5wXvRUqS/xzh21V0hZlZf6a3u8X+goRHxtM2/j4T
 IGO2OC67W+MRLImqF8IjMzUHnA+hiWP3yVsJ7s6cXqnJgW+SuBsnZeVXSIwDHTxpnYICxVnQZ3E
 EWAzBjj8PHsSJMnPYmK5FbxNTPSXc8ZgSxhYZCwO4LGVfXIuUl9/HVvIXH4wkfjkzSYa0g==
X-Google-Smtp-Source: AGHT+IHTCuhOGiIvrmO70f1Q2arBH0gRIiLequ0f7PYHY2q+creC7OIlnBY1RM3P89ynbwkdw3p/EA==
X-Received: by 2002:a17:907:70b:b0:ade:9249:25dd with SMTP id
 a640c23a62f3a-adf4c73212bmr70921266b.8.1749820932319; 
 Fri, 13 Jun 2025 06:22:12 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec88fe907sm128279666b.93.2025.06.13.06.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:12 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:37 +0200
Subject: [PATCH v2 17/22] arm64: dts: ti: k3-am62p5-sk: Enable IPC with
 remote processors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-17-3d233aaea355@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2937; i=msp@baylibre.com;
 h=from:subject:message-id; bh=n3s1+V6gJPQuysaskw5diUz3uqLfoKMQBvph4siynSo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1Yu/ZU5FCDd3n1j04P7C3Re3tWzs9Pp4zlJCcdf+G
 fMWWSh86ChlYRDjYpAVU2TpTAxN+y+/81jyomWbYeawMoEMYeDiFICJnPrK8Ffuv7xJwx522165
 jkbviMnLZRvU7J/1FNRIXrri7tLz/AzDf+d09yOvC4XdjZb9Y+rcL2m/S/TkClmOv8ffCf4KetX
 ZywMA
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

From: Devarsh Thakkar <devarsht@ti.com>

For each remote proc, reserve memory for IPC and bind the mailbox
assignments. Two memory regions are reserved for each remote processor.
The first region of 1MB of memory is used for Vring shared buffers
and the second region is used as external memory to the remote processor
for the resource table and for tracebuffer allocations.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20250502220325.3230653-8-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: b05a6c145001e99348a2fe33958be912f4eb8d4d ]

(cherry picked from commit ccd74102c4199bb661090168ca5035d8ad438869)
---
 dts/upstream/src/arm64/ti/k3-am62p5-sk.dts | 50 ++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts b/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
index 7cc730e27ce69dc30feb97d68c9cec88b553a4bd..731252d84330b69c7b2911c1216118c02a787569 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
@@ -49,6 +49,30 @@
 		#size-cells = <2>;
 		ranges;
 
+		mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@9b800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9b800000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@9b900000 {
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
+		wkup_r5fss0_core0_memory_region: r5f-memory@9c900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9c900000 0x00 0xf00000>;
+			no-map;
+		};
+
 		secure_tfa_ddr: tfa@9e780000 {
 			reg = <0x00 0x9e780000 0x00 0x80000>;
 			no-map;
@@ -58,12 +82,6 @@
 			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
 			no-map;
 		};
-
-		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9c900000 0x00 0x01e00000>;
-			no-map;
-		};
 	};
 
 	vmain_pd: regulator-0 {
@@ -639,6 +657,26 @@
 	};
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
+&mcu_r5fss0 {
+	status = "okay";
+};
+
+&mcu_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5_0>;
+	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
+			<&mcu_r5fss0_core0_memory_region>;
+};
+
 &main_uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;

-- 
2.49.0

