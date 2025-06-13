Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A812C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9538F82E27;
	Fri, 13 Jun 2025 15:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nXRjUOVC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB04F82CA8; Fri, 13 Jun 2025 15:22:07 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9497682CA8
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-adb4e36904bso410711966b.1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820925; x=1750425725;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6KIQw+Uv46Cr/zzsV+8knw+9fKTqnWu6VRUpXsnKwyQ=;
 b=nXRjUOVC/oRMzro9UE1R0BHR5h9qc58JeYqc5GJek7fjJiVcNCEQ+xCrG/MXIIFjWB
 uTpfhRGpxgX4zEP8ZtP7Mwoov0oaXOBqFSK/tV/x1Mjm2T3+ubMHRIh4uZWS6+BYITLV
 j0A2jv0NDlgJuF5H3XPL0pyc0gLv99XZ/DWnlC1iCT7Y8fm3oXHHZXy7vRbGi4Omo7KZ
 6Iwu9nQG2/6fdI24BZohp1dSg3WfwnzKe2om+DllyZ2Kx8fXvBfzwyy4mif9X82YM/jd
 RRNb0yE0QcJIVXef421uZFC0dl9NndCPA6EsEG//J2cdyG2OzCJcNYVy7t1D2HfG2nqD
 /Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820925; x=1750425725;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6KIQw+Uv46Cr/zzsV+8knw+9fKTqnWu6VRUpXsnKwyQ=;
 b=Hr/lwY5YmLC/iC82ThlaihK8bHrB6Jjb+goAdEIVg/3IcQsS0qJ4/Uxr+oyOhjUTBE
 BVbC78p5X6hMDqiM+yWo7fQZJo0i61u5EVnO5wPoUtXutvlwplFWZWL5BbxTglhPANJD
 1/cE0SctYH1ggz5luN7bxs27UesZ6Y3mSMZ434LaNrXRfzwNCKMh7IK2F386xhQgFliC
 QBEjzLSBmMXXTRrXyexjgmALAY+zhDH2wniBgRgSVIrE6xcLp7gwgX3a7lwHbwwzwwuu
 JZcU2Rdse3tx9RX/xSi0x+aqeTJiSOrwa9Zo8d2EAUA21NgG/ugAbx4iszIV8YSvPfre
 Qlug==
X-Gm-Message-State: AOJu0YwOj6XQ3KcDY8hu9bZ+RN0cpxReCrcQ2cGRzPff5cmZWuZw6nea
 /9xrCZFNmoAwf0NrHjE+vSTIMUNcGGObqAT8AHxltZk02GUhOV8IrLeuf9ZtZVjOeeqOGUjg6qy
 e6IAG
X-Gm-Gg: ASbGncsvRmUTTWcNpieIOUHYqzZLp7XiROUhHXWrO7Zb6yIDguF0yruajUEf0TMBYGx
 SCqOiZBOl2lqBKGSInbWY74D1nqjP/FvXw5nKPaeTaxay3ifOP84g74I+K6BE2zVFYMtHDxPNmM
 rdtH+3wdTF+rK6+iaFGVQUwV9RGZ4dCNVEst2OOpbGvJmuSm/XhWkMvvYQ3dWhjSvfYWio8g7Cr
 ytR12JKx3d6B3sU3Hm9dZ/+k40k9NIk8hPiLm94czD0ElsD8+LUBo+wgzqx2Oo7V5WAK3S/cXnS
 oTveF03LvXURESpQqmvczHTC2VaDAVLPRv8rtkk+b+XowW2fOUAHmW6/oT0=
X-Google-Smtp-Source: AGHT+IHUa+zndOQYWkHA/5hwRwAGSFuTPKwEPyTw5l8O4vM8IQmJSwqf865/l89ArJFLrAn/UlEcZg==
X-Received: by 2002:a17:907:720a:b0:adb:300a:bcc0 with SMTP id
 a640c23a62f3a-adec5d184e6mr306712266b.46.1749820924980; 
 Fri, 13 Jun 2025 06:22:04 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec81c729csm129963766b.67.2025.06.13.06.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:04 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:30 +0200
Subject: [PATCH v2 10/22] arm64: dts: ti: k3-am62a7-sk: Enable PWM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-10-3d233aaea355@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2100; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Jwj16kUOyZJPaHTGfluQFB4SG1hmfBPBs5J6+uozIEg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1dWXSrS/L46733vLunKJ+UWnQuW4228E/Msj4s6bM
 gtV2s7sKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIl8TGZk6Dkf5BMee/B8SMFr
 w773S776SyYYr4w6xLk9OF+AW7XThpHhu8CZQBZjqWafmPf/sze23OhYUCKWH/rnxAK/K5khGsE
 8AA==
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

From: Judith Mendez <jm@ti.com>

PWM signals can be routed to the user expansion header on am62a7
SK. Enable eCAP0, eCAP1, eHRPWM1, and route the output PWM signals
to pins on J3 header.

Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
Link: https://lore.kernel.org/r/20250422000851.4118545-3-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 5aec1169b53969d07cc288814f7eebd2ef01f9a0 ]

(cherry picked from commit 16c71470bff15f5ea677edebe3cba8a2504dc5e0)
---
 dts/upstream/src/arm64/ti/k3-am62a7-sk.dts | 40 ++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
index 1c9d95696c839a51b607839abb9429a8de6fa620..a9557ee73b8311087db9ce9cd9596efb8bb8975d 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
@@ -383,6 +383,25 @@
 			AM62AX_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */
 		>;
 	};
+
+	main_ecap0_pins_default: main-ecap0-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x01b8, PIN_OUTPUT, 3) /* (C16) SPI0_CS1.ECAP0_IN_APWM_OUT */
+		>;
+	};
+
+	main_ecap2_pins_default: main-ecap2-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x01a4, PIN_OUTPUT, 2) /* (A19) MCASP0_ACLKX.ECAP2_IN_APWM_OUT */
+		>;
+	};
+
+	main_epwm1_pins_default: main-epwm1-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x019c, PIN_OUTPUT, 6) /* (B18) MCASP0_AXR1.EHRPWM1_A */
+			AM62AX_IOPAD(0x01a0, PIN_OUTPUT, 6) /* (B20) MCASP0_AXR0.EHRPWM1_B */
+		>;
+	};
 };
 
 &mcu_pmx0 {
@@ -741,3 +760,24 @@
 		};
 	};
 };
+
+&ecap0 {
+	/* P26 of J3 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_ecap0_pins_default>;
+	status = "okay";
+};
+
+&ecap2 {
+	/* P11 of J3 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_ecap2_pins_default>;
+	status = "okay";
+};
+
+&epwm1 {
+	/* P36/P33 of J3 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_epwm1_pins_default>;
+	status = "okay";
+};

-- 
2.49.0

