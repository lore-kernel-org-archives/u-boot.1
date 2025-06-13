Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948ACC71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C3982E6A;
	Fri, 13 Jun 2025 15:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ml+FOzH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD01F82D17; Fri, 13 Jun 2025 15:22:11 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5C7C82CA0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-60794c43101so3414288a12.1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820929; x=1750425729;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tlgr8A750AkcHoW9OOQt/iJ+A5qigty5nmveVkcVG+g=;
 b=Ml+FOzH4t7B0O5OTr6bEZMudk+Ychb9EkvrZg5EtlOvppmjUkMxnVELUc57jGPMuw+
 340kFJqqYprj1zYOF3wIXWkNTwneeZSipYfoCL8ARoe2TBFsQXPfiQRyagKEmI9+tXw+
 NKyGImJu48T4UBSQGkqbk/XLtLC/SfjrU6icOPpxZNjyaCX68HKK3K1iS0b+5rxB6kZp
 Nbm/5sg/6q0iwa0DWTcmZUeqeJBDmVjickHfyb/Q4uwq6vkhcox0IDpn69B1HuFYcHne
 kgmLKl3/OdxAZPMW0W5hU8Hd0IYyc76w5osrUaY2qu/F9ZHiMNi5L7JS4ZpEkkN6Z4QO
 ffmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820929; x=1750425729;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlgr8A750AkcHoW9OOQt/iJ+A5qigty5nmveVkcVG+g=;
 b=JWO1zQlvY0FXBxuxZhk9Uzt+m9SJASiQN7UJgLTnZtbPsd9WOnxoOkFS8MqhL6PNLq
 OT0Ym8+5jaz8cOwnjduWU0M1/VusoC3EFdTZuPq4CxEuInQukWNzOlUq98kd/pm1J87N
 kedAG3TXNSu9I4IjNybg6wX3idjSm7DuQjF4SfBJyf4wndcXJvjFDK5UPQEVTNcIKxf/
 UUxjbQurIrAtRdEi38XQBTLeOJIugmbUtrxXI2TV17Jj1p7BhFrsUOHS8Sb67i88I8WX
 AJ1cvAA+zvE0gVKXSBukhWL/76OBuoueBksGnCDMKEP85Ri9it1xfuIkhcH12UtWt3zD
 z/dA==
X-Gm-Message-State: AOJu0YwZ6L2zEOLhu2Pl9+WCaguurwTuya69ceS7TC4BBRCad019ml6K
 /tZDYV2/jt7onxaxjoFNreXGaSS22bme6CvzRSiS5TPQPbOeJ3qOAnwQ+WrbV8MSrdKQ0/ELKTM
 7WStX
X-Gm-Gg: ASbGncse8xd/ogSr/FIdKXYvrxOYLdhII/xIFhX4ToslVjZtVMeEvqCTrhXMeyGK9NX
 vK5P6A12XXsmbi1Umijj8k1evcBNnM9xdPdw0gUnOpB3t2I2zBBHsCvRi0/9/Z2bSHelFf7RzXT
 pKec26A/kRo+bj2ucHSjWeie/5PIQTFnJgv2eHHdxLLgJwhg6rJO9xlw1U9xGtZGjH4hyVKXFuE
 PjFKiHWqPgzAvrxs/7RITxpBW3AAt38xOH2EGzvfagC2J0JEUnFJyS7R9kEPRBBrBv6JUKW6/JE
 FwDyBZRQdeD2GNu9aEtg/pZhtNV9Jk33dGoiTMu0VgXcM6eCa0unI9l7KA+Qt4FWJ4qlXA==
X-Google-Smtp-Source: AGHT+IF0jwR8HJr3ZfayFfb/xRNk5DOpUFbqOsadhK9OmSEcun2a0p/ti0B1H0q4qt1ecp2e85XW/A==
X-Received: by 2002:a05:6402:40d2:b0:607:1c07:727d with SMTP id
 4fb4d7f45d1cf-608b4a0dd28mr2431520a12.23.1749820929113; 
 Fri, 13 Jun 2025 06:22:09 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-608b4a5b6fdsm1204785a12.43.2025.06.13.06.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:08 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:34 +0200
Subject: [PATCH v2 14/22] arm64: dts: ti: k3-am62a-wakeup: Add R5F device node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-14-3d233aaea355@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933; i=msp@baylibre.com;
 h=from:subject:message-id; bh=bY7EtKF3tut0oqqiZB9kErNW97oPfI20aYb61CeastI=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1cPxMzI1OERzVKbd7tQQf8z4YUr5n60Mby/uDPDXj
 g2Y8mtGRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzkxj2GPxzvQu5bfVDTiH11
 +bx/IJPxz/ORC1e6RUsKTlP8wbvvuxzDb5aiY/fEWSYtOKviMmXVaTbv+3qx5wrdz/bUv2KaN7l
 6LT8A
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

AM62A SoCs have a single R5F core in wakeup domain. This core is
also used as a device manager for the SoC.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
Tested-by: Daniel Schultz <d.schultz@phytec.de>
Acked-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20250502220325.3230653-5-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: f0623719c2a612cbb9d5927fc5ffef9b54a12fb7 ]

(cherry picked from commit 87d1a5e90b69c4d995561fe9c1e077bad5db7416)
---
 dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi b/dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi
index b2c8f5351743857a54385178cce5c82a961917e3..259ae6ebbfb5ac5f83cc2c159c779ecaf9f96dcf 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi
@@ -103,6 +103,31 @@
 		status = "reserved";
 	};
 
+	wkup_r5fss0: r5fss@78000000 {
+		compatible = "ti,am62-r5fss";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x78000000 0x00 0x78000000 0x8000>,
+			 <0x78100000 0x00 0x78100000 0x8000>;
+		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		wkup_r5fss0_core0: r5f@78000000 {
+			compatible = "ti,am62-r5f";
+			reg = <0x78000000 0x00008000>,
+			      <0x78100000 0x00008000>;
+			reg-names = "atcm", "btcm";
+			resets = <&k3_reset 121 1>;
+			firmware-name = "am62a-wkup-r5f0_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <121>;
+			ti,sci-proc-ids = <0x01 0xff>;
+		};
+	};
+
 	wkup_vtm0: temperature-sensor@b00000 {
 		compatible = "ti,j7200-vtm";
 		reg = <0x00 0xb00000 0x00 0x400>,

-- 
2.49.0

