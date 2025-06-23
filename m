Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1FAC7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDFCA82FD6;
	Mon, 23 Jun 2025 14:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UaScSk4v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E51082D21; Mon, 23 Jun 2025 14:10:51 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D35228210D
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-607cc1a2bd8so6181110a12.2
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680648; x=1751285448;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6zVcRKx8+bYgfqpo1heDYeUcM9xkUTySc7K7Lcptp3E=;
 b=UaScSk4vimpUt9jOiNV15VijZSeUay1fHgj9LwC3ekrQcX1LQ5EKsALXapV+g6Puhq
 KgIN7hPQRrLbSN9Z68J0bIFatEyq5YRunUZBpwynMtSgzE4XL8smClvSbjo7R+SiaNtb
 /GnSZ27wPEXIc27ZV12Ir25UOopmQhUPfh8j+GC1WOeK8DOnUoxtrrglpVvvQA96+qs4
 axA75WT87ZBDxkmvPWuncmK/q2yHBscGBj2wufZy1MVeLkYp1XfFkgivdIt5WSgEh58Y
 uh66MwgSxoi6ectvMZx3aFR2GZH5OLg5/7PzPYUOEA9iDuPjm+iV9vitP5/1JT5PNqwg
 quHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680648; x=1751285448;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6zVcRKx8+bYgfqpo1heDYeUcM9xkUTySc7K7Lcptp3E=;
 b=KZ9XrPU08lp58Jib1ec37u7v5e/DgXYgyxgt8p1qAUAi6KicfmmLGzd7qHnP1/uMVg
 r1e310pafl06X/bULICUfFYtN0wETTNPgbApDpT3TXoNlzxNzbtMOmYKajSw807lRAVl
 d7dX3r0oCG3sz4oOPCQ3zYjj6ZPf5RBJg7fcQJBgD2R1u0g+uKBY+E/WB4bX85GHdzKr
 gGJXELPC1HYGdfcFA/zXfONNA0KNScv8ALdUT+uDpWweFzDhlYfx/j0OLfj8/mKOQZPo
 czMNJ6qxIiP5Hcb91BVDVZ0KEZoi9vQ1ebC/sf2YZT4EhRz540jAdKw49wZxUgpXVJMS
 O9ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNX+rWxk1CSyKd/0fE39znDg23v+ALBs/PNTi1qJ20KtRNVLcDuiXvJZ+qg3X3CkwrVGgd0CY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4G+sus6HXxvE5R2aTqtPO9iIIZMlAFIFO6AwXcN6z1yOkgWae
 xqmvZlEX9wW7VInmwW3x+9C4eongANNGaKBdNKKyAR9BMZFNbHAYNuGBpI9uN1Md0Mo=
X-Gm-Gg: ASbGncsW5QfwQEMccyFe5TRoT9P0HulQwBU44a5kO2C206HnvFhQH3VIyqkEjtkrzLB
 TJzl9W4YlAlk49aRvoHDBbYYn0YEcEyupKrs/RN/zee5hVrV4TqDkuZxCa3QyUUL/OsX4yYcTBU
 OJezzKrrkDGuYx7+5D31+ieI6OgQDGL4pyopW263GlZehMIiWb+Vgr9b+7JrnlnAzIqJV2EGU31
 1DLCxVpDr4witxuSU7VgxVAHnLGB5kkx599c16hc9QEq6Qv8IrCx1YjkQbAcaKDSeojJY6eU8O6
 VENFt0kxhe03L8WCuz0AIsOzRyQMhVqOwL48YKHiVpSDFWIaEe1/k7VU5AHLmApxB0ffgg==
X-Google-Smtp-Source: AGHT+IHoeLIOCu8LWcVJqX37WxpcB6YzHJkBy9nX5tSyxHORqswqvTHDP0rIfPw4oj47gnC4UWRbNA==
X-Received: by 2002:a05:6402:234d:b0:607:f558:e328 with SMTP id
 4fb4d7f45d1cf-60a1ccada76mr9861578a12.5.1750680648302; 
 Mon, 23 Jun 2025 05:10:48 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-60a18c94acesm6107004a12.44.2025.06.23.05.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:47 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:40 +0200
Subject: [PATCH v3 17/22] arm64: dts: ti: k3-am62p5-sk: Enable IPC with
 remote processors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-17-a4da322c16af@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3053; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Z/W7IEBoYVA7c9ZelrZHfDX+ZMf+p2Fm3HckrXFOKYo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxIF+GL6m9aZ8dnLbvszK28Y/OFe7xlrTXB/Q/qPdj9f
 t/a3SLRUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABMR5mBkuOX9RrXY+w9jjvL9
 faZFhVza+1zm9vHoVl2a8lmlUOGcC8MfrmMKSksXSUzL8H2XurfS9KC8zTOdI1NdlA5pZKyZxOr
 FDQA=
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
Reviewed-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20250502220325.3230653-8-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: b05a6c145001e99348a2fe33958be912f4eb8d4d ]

(cherry picked from commit ccd74102c4199bb661090168ca5035d8ad438869)
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
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

