Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5326DC71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:02:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 716EA82EA3;
	Fri, 13 Jun 2025 15:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AKDQ1C+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7C3182CE7; Fri, 13 Jun 2025 15:22:14 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD6A382D18
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-60497d07279so4394155a12.3
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820931; x=1750425731;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LSDKg/CDM+3xyPwzLscnPfYXTegWvjjl2OJ66drk17o=;
 b=AKDQ1C+7TKJ4EFnqEQFciTgatdNKot3D+2u9fuFEsTgrq2MdYoFYWPcKHrzYKlnypp
 h4i9DgygYOhmSq0VH+Gj9PiNrTdqMDdBmzoMKrpiPaYU1A1uatz0lCgMPrnyn7lx0AtU
 +PUepeGNC2scKiCqN9k2MxODS3JYMlnlW4PrbnY9DyVZGsdqTHRS8iNuaNz5p6KfNZiF
 g3VEqdhPgnJKMd+fNw9yCjZyPJQeshcM/ljdoPgBr0TGCxl5tWIVGYxGRzhMTLptm5yf
 xApYys+9MS7J1CzIZ4jopvATX/IH2ELUkxiM7qBEc7D5q+a3DnbNTson9PD206MmssvN
 1k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820931; x=1750425731;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LSDKg/CDM+3xyPwzLscnPfYXTegWvjjl2OJ66drk17o=;
 b=v8gkB6pfi9uNogYptIAwG+wlva6e8BLo1ZpGKlU6K6mRmrCKXJPgnU1u7eTLa+QG4Y
 cII9svKejgOhi2h6+gLTTeEek+Jxmzi0vSXEKMWWsg/z2rlrDozQiuQITrhT1K/XRyFL
 2z8geTNnhihprL5vFdTx+jNwmuV4GEAGE4SBNO0HsT2qksORuI9/2B2hXJFdi8f15fHG
 gbZNiMMWknPI9FopbbWbImIKd7u6dw79EiKZTl6GFFVscDNMP0oa1IPEIxbNyC5R2SvS
 yh3zSqW03wq+Qy1e4YP18T+z5aBRS9x8SW5DZZTTezsgJ8ZhfwQ0/FUI5RDzu9dEEMR2
 zjYw==
X-Gm-Message-State: AOJu0YzJIrA2wBryH2dOVONuPd53vGZK8NiRMoo47SaQN+BZVh1Me8UH
 zCWN2QyS6sIKMC9u6KSepjr99pmnKFF8PZYdjFhncNOK+vEW7RWbBTtFk85UXunJj7zBcyOaQWN
 IQ3mv
X-Gm-Gg: ASbGncuU8cwvbrkDNYttIDOQ+Wbw7ARZaSEtU706X9ZE5ttUca0h4Xn9nnEhOAR7fZN
 7wC6SV83R0BahZHAn+hiwN9892vOShvX+9P1FrEuCSOvXTjG1eOH/CqPJJum0FcfWXMGX+ojHLx
 UcMKVH/rqtJ04XVndA9aKjY93QPaIIl7QH0OZD6rqLi7YFNAXGSaWF/SgHbawLTv6H+1VTbqRqb
 Q1mXr8BwSJTbtvYtW7RrSLpCyttQdMIbw4Wz7/dkVmsBRldxaTz6xm4+SPwOsKoETJVWV2c2VbD
 Y4z6LNQTbV1HVt4oMfs2ljOBinApUYJFdD1DxArNEl7I8c1023Q8hMbm7N8sOBXHSowowg==
X-Google-Smtp-Source: AGHT+IFbVQEj4kI9N0+16g0/bc/PUetBNc7Ld72O2YezZXAuB9WMSCgcDWkQGdtJs9JiQMcMpSonCw==
X-Received: by 2002:a05:6402:3551:b0:602:ef0a:cef8 with SMTP id
 4fb4d7f45d1cf-608b49b1b9dmr2873611a12.18.1749820931231; 
 Fri, 13 Jun 2025 06:22:11 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-608b4a60505sm1175848a12.37.2025.06.13.06.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:10 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:36 +0200
Subject: [PATCH v2 16/22] arm64: dts: ti: k3-am62a7-sk: Enable IPC with
 remote processors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-16-3d233aaea355@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3848; i=msp@baylibre.com;
 h=from:subject:message-id; bh=9oHACOpoV6uacjf/zbwwFe6LBSZnoPfHHC4AdN4WAJU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1TMF259IcIj3s6knuy5uzluznO9eTP2yQ+42axSdN
 v1Vd0zsKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIl4X2JkeHq1c87lM4GRifnt
 Qky9fI760yarrqqqVzu1rC2IcZ+eIMP//LA1PPVrrCYr/MmcHdQR/vToEsml+zmcEl9UPX7lnlP
 DBgA=
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
Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Jai Luthra <jai.luthra@ideasonboard.com>
Acked-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20250502220325.3230653-7-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 77c29ebe76d80174d5735b61edd3c95e32a75d2e ]

(cherry picked from commit 2cf6f198463cb250137fc009db599ca93241ef0a)
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

