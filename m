Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CD3C77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63BB082F5D;
	Mon, 23 Jun 2025 14:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R2uWlT96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BBA882D5E; Mon, 23 Jun 2025 14:10:46 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E97D8210D
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ae0290f8686so605535466b.2
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680644; x=1751285444;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hUMIzC3IUaHg4JtaTmWJojud12ytCI9qlieiPVaaQE0=;
 b=R2uWlT96nZXjZQ9L99FtcX2IdABWp0yews6DtqbthcATYkQJIB7Yn3RYOgjFB1wORo
 qBejUpYXuV3NMZkDtwoD5EoqVmXy7ooW4Uxavr4MVwdRoWHO9d3cPfLoFKKv2xl3dUCn
 2kW+uBvZwf+drH907Hv5Ut8S0bvIt5Dr2GOmTafP3oOQ6EVoyenSlHiU5rBNipPXESNQ
 stLmLuYgyu3jLWbyV6QiV7sf2GFOp1ez0yDIkpSUIXdD43ArHhWodE+iWjWWIF1Lx7cp
 k1uwMQ9YxmA3bfyG8aIQvVWPe4H7hIvUba8GZdiRs77xY/DOVE0MQvn0ldmiRZ3q2mt+
 3B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680644; x=1751285444;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hUMIzC3IUaHg4JtaTmWJojud12ytCI9qlieiPVaaQE0=;
 b=t7vWmY8M711r0CjIhrIDMuN65Scc9l5JO5utPxIgkQhe4kUJBaz6urz/+2XUjLvclc
 4F7SG8ebPZwwGpiv42LjVNj3JUvB7Tv/ewz9UDwfoVzXHWdflJkrv74QWmJMzndCu90F
 nacMbdI5MoCEmw2HXqmVicixBaXH9IiJh0tZgZNm+WeXCrUCqGrtKiSq8HHnsu3JEIU7
 iYJ0PeG4ZpAZjP4HQuK7srfLq1XCTDebfe36jyyxFuSBJgh5OS2G7ct7f2wacFNnHRNi
 DyrPTNz6PLVlJ1skfFRFnKtSVzz5FqaX4H2kquwMaQtRbsCbor32fA3p9AVvMxHIzpKE
 Ktng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN8qUSm2JnEyep8aXAn6bGcOqSTh6BOy/G9tMlF6mvhWb4ga2j7/eljdTXuyTE9xQ8Wm4paOA=@lists.denx.de
X-Gm-Message-State: AOJu0YyM03dvEGDukgb/knx+OOwwvKilmSnqjPovv7nPV2IGqVzvYupj
 vU718zki05R71L6Hqwe/fKyyBK0bts3JRPC6oxsddGlUJrlt3oFAZhJ5lAaznIUYwuA=
X-Gm-Gg: ASbGnctAb8tIJLXWasfBHuhNS7nDIqRlnNpY7+obANMx0V9c3U933VSsf+eRuqYwtch
 sLONysKUhZfN/japlp2E5NtGxOQ7V/pzOAdy6PJcw2pm8XaqJYvaiiz3J/xWiBmh6bu4EgGYMIR
 /rw73W81VksN51GWnsqnK4Ew7KB1hYIPocbV8kiADAtKAKyjFVZxhTSmq1rOdbH9ZcEJuqcSUDT
 mRrlvKQP37EA89zKbJxVZAapIB7TGMr/1kIkdHt9cZyNWIkM0LXeFCLEHIQKmvLS1RfGlZriIpU
 agjyZEdQs89wyzPDGa4wEoVTdYcnLp/Sxg4EMX4e7+8oA+AWvVS7lgRL43o=
X-Google-Smtp-Source: AGHT+IFTa6dAHyKtcujBJN3sNZRZ51kcPm6okDxDLQ9Y4VqHkdjdrl8gReFRhiqB3lQ+wJ13gxOCXA==
X-Received: by 2002:a17:906:c14b:b0:aca:95e7:9977 with SMTP id
 a640c23a62f3a-ae057c10600mr1168639866b.28.1750680643626; 
 Mon, 23 Jun 2025 05:10:43 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae05420a5fasm693635966b.181.2025.06.23.05.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:43 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:36 +0200
Subject: [PATCH v3 13/22] arm64: dts: ti: k3-am62a-mcu: Add R5F remote proc
 node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-13-a4da322c16af@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; i=msp@baylibre.com;
 h=from:subject:message-id; bh=A3PqGl1albS1C/UbZ5e3tJl40zqPD2EmgHzQXNziQTc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxI5/+Ka//ufD3X4SLTpZUe/+f11CdJqAqtYOlnS5ioq
 bg3x6+go5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACbSycHwv5CBMfPo/FdbbjwP
 DFnXv+91RYPNt4jAtt3py4XETk5S0WJkWOUZtERecY7Bbf3F1t6c1nVlxw6uUJ0mwdqxPnjmtVf
 nOAA=
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

AM62A SoCs have a single R5F core in the MCU voltage domain.
Add the R5FSS node with the child node for core0 in MCU voltage
domain .dtsi file.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
Tested-by: Daniel Schultz <d.schultz@phytec.de>
Acked-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20250502220325.3230653-4-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 7f321892dc53015e29cd1055231727b8cdc24923 ]

(cherry picked from commit 349f1d769bb67fda0271159557589c849c843b12)
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi b/dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi
index 9ed9d703ff24d80171fdb29abbb0d5e3819c8a90..ee961ced7208f99acf239ba9c8d8cbef0c326481 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi
@@ -174,4 +174,29 @@
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
 		status = "disabled";
 	};
+
+	mcu_r5fss0: r5fss@79000000 {
+		compatible = "ti,am62-r5fss";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x79000000 0x00 0x79000000 0x8000>,
+			 <0x79020000 0x00 0x79020000 0x8000>;
+		power-domains = <&k3_pds 7 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		mcu_r5fss0_core0: r5f@79000000 {
+			compatible = "ti,am62-r5f";
+			reg = <0x79000000 0x00008000>,
+			      <0x79020000 0x00008000>;
+			reg-names = "atcm", "btcm";
+			resets = <&k3_reset 9 1>;
+			firmware-name = "am62a-mcu-r5f0_0-fw";
+			ti,atcm-enable = <0>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <0>;
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <9>;
+			ti,sci-proc-ids = <0x03 0xff>;
+		};
+	};
 };

-- 
2.49.0

