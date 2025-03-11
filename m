Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3029C28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F20819AA;
	Tue, 11 Mar 2025 14:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kMb49aTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D7B181870; Tue, 11 Mar 2025 11:33:16 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C32F180F92
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso8473587a12.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689182; x=1742293982;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3lqtvDm4+O4sf9DSJGdtegrsVy+d4ValpI/hJRKJBwY=;
 b=kMb49aTDQMhp6TVEOA4tmtFOuyKMFtKHJQfxBxqJ7KLvsfBZGqMfEQYwPz8m1O09Ah
 TFcQJtidZwJo/OGi8rv43SbfCrHUBRUxmMLc2RiUhtgywhxqwtCYuUILENivYRT0GOH1
 DRW6dpNCXvn2gi1ul/WHwbb1Mxo32qnZjq5jgaVGMEONd/xLtiBXfk14U1psSRigmr1N
 G4LDNUKu2tYfqVRg+Yd7q4T9Kyfz1F0Wue9kMax6wak7LMU09fdMQuEj+e+Gk+r/mOQl
 0NXtXuDGs6MpfgUwHFxm7+xvnfofrov9FBSUKZo3LsN2hah99Hx+6B3wqikD7U5/3ZhV
 omKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689182; x=1742293982;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3lqtvDm4+O4sf9DSJGdtegrsVy+d4ValpI/hJRKJBwY=;
 b=BRdnVrFku8TIIIl3IG+/sXQd4oONh+tZkCU5/YhXTHD5nIzExdBG8scNgmgWr5p/wt
 dpmUZmGW7lNhANpNbaOWTxqhsfTIrfeET3DQGZlMKmeXD4xZk1sqhNCr+dbQZ8RRq8QW
 yJ0xb0kZ6ek1Z8ASQPG3LOLlv7jH1USjWv8mNwLTGz+kcLWTcGTUcJJmFMTnwqIdc/6Z
 MOziwcyrktYQP+/Xw6VX/6zV3lsYdOuezsq3RaQW2ySOVfRiS9Vc1VESEr8eHtLYqiCB
 RwxMi5BLbvEgORE1mks20koDV2X1cy13/v0kMRX9+5ERuYKFsHBzFXVkiQh1ryQ2RkAV
 7Bew==
X-Gm-Message-State: AOJu0YxV985tWTTcvfFx1QginPL2yGpEfgW3o952KTeSwjciNTrvvjKc
 Ej9yf0ixD3HgBXbIJ+CV7jFPKYyWBPgQbAknifyvnQwSJgjZCiv/QpLtnIMCF8NXnHWJFmbjdzt
 7
X-Gm-Gg: ASbGnctenlb3hblmNdxAK/+Mk9E7Dl1CRBqXZxjpmoEzTtkDQLSzlgDnQdn1y7LuIyu
 XEHlSS1m+6Py5M9QAtFP7GBggmY8wEvwnXVbjiN5p7ay/+gwun07rpDjXxOm4SAPYnOYWxCZOTu
 F0cps0pUcTtVBf2QX8uZOWD6y1Il5qrHRUIp/7w0G28e8PnCR5OKNKIUa/IjwZ1lAhNxJsNJEur
 rZ7OL1xt/rC2H9frAqJvOCXOIH9SejLMVZGmZpL7Tj9XzehKr1p67qZWfT4B9FdHaIHWk8H99g3
 F164Q9x5w0vHbDxeM5uX+Sr2CthqGT2+ERa+ypf2
X-Google-Smtp-Source: AGHT+IH2DfDmcgXfhHTficswLOTFJvy9m9MisSCnS4ZKSWQceBPbgA8WcPsdQPVFYVDyNUPcpjqpSA==
X-Received: by 2002:a05:6402:2109:b0:5e0:752a:1c7c with SMTP id
 4fb4d7f45d1cf-5e76250f713mr2849939a12.1.1741689182017; 
 Tue, 11 Mar 2025 03:33:02 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-5e5c766a16esm8089052a12.60.2025.03.11.03.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:33:01 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:53 +0100
Subject: [PATCH 14/19] arm64: dts: ti: k3-am62p5-sk: Enable IPC with remote
 processors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-14-666de9c105cb@baylibre.com>
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
 Judith Mendez <jm@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2779; i=msp@baylibre.com;
 h=from:subject:message-id; bh=XyNWv0yqVZEcb6Uv1GMbO/c0Dl/hwgZYgzN7oMzKKHs=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCBoeS1iz9Olvm6frlkYF35r6yMn9zIaZrZ+any0Iv
 HhiFo9JbUcpC4MYB4OsmCLL3Q8L39XJXV8Qse6RI8wcViaQIQxcnAIwkVgdRoYPgWV8X6K3H/1y
 zLY3M+tFYpM9U5+h2R25O1rHG8qTGu8wMuz6cGpH290mZ36ZA9s9wzY/rLv0rTRKwfLZ28xY9cD
 5c5kB
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
Link: https://lore.kernel.org/r/20250210221530.1234009-7-jm@ti.com
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 dts/upstream/src/arm64/ti/k3-am62p5-sk.dts | 50 ++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts b/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
index 7f3dc39e12bc9ca4a746ff092f946b84a36404b3..37ff0dc54ba8eea4197079b04ada032dd73119d4 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
@@ -48,6 +48,30 @@
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
+			reg = <0x00 0x9c900000 0x00 0x1e00000>;
+			no-map;
+		};
+
 		secure_tfa_ddr: tfa@9e780000 {
 			reg = <0x00 0x9e780000 0x00 0x80000>;
 			no-map;
@@ -57,12 +81,6 @@
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
@@ -634,6 +652,26 @@
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
2.47.2

