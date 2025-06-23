Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9917CC7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3731382F28;
	Mon, 23 Jun 2025 14:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k9mX3g4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B17A582D17; Mon, 23 Jun 2025 14:10:42 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 763D781E13
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-601dfef6a8dso6528401a12.1
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680640; x=1751285440;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ny9mQDThP1+7bHHWjHHB6gVR6T/viK0npNb6tysl36Q=;
 b=k9mX3g4O/BT87n/aZxYxFN1uTfGGg9L0oTaFSQ4AIwCG5J9wQIKRrYoToRVSjNErRr
 DZGNn9ERLY4PMCnPgNzFhGg8kaopYRUQrL5DKxQ4hOeLnb95/ms22oXE/P0KzfXWVfwP
 knyqVwznLFshkRkKYOpMGRJ/3l8Kg2pCzH0dtJv5stYB8/19IXowoUrKSdig1tKvGEuh
 tPN+0N5Q/h/upOVRltwf6P9FdNDuiJG7KuXXYowCxqzLw/edG3m6QD8dmTBto47S7wte
 o4RQ3FbWI/pc+GxcMSaiTLhq+JtM3C+VQ5dbZiKxubpJz/bDE/mlXpGFwz8mpIRo/pPp
 lkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680640; x=1751285440;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ny9mQDThP1+7bHHWjHHB6gVR6T/viK0npNb6tysl36Q=;
 b=Rlofcwzd9K4Ez0M3kEhK3ChA4vMfq20hxnMVYCtAva1eiGcSeZf39gz58oUNMR31ey
 TDjC/HqcYG0zbn5PeovwfxRVDN2ETDV09jiGmgvmbiywR88TZO4609ZTMDlbPbf2G03O
 NS8UqDzxmsTgJfYwWYMAm39kBcYmhXxvNV0yzS2xaiLp7lsmgM/qy36UemkzzNOPU67y
 jNK5/JrIy0xKuR3KeldhyqV80+CwxKKcUOtHd7stlq/cEK+DPmvWUrX1VE47upZUjJYf
 ICnaaxe71QP4TF3Jp/J2Q3cXfptrRnAd/WHAGjWOET36iYBF/tirMgwRkFmwhCRCS9a1
 oFGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXv7N/kqXyHzUk9FqUH0d7r93CcZJXj4Z8M4vkoDpsHK7kVS0t/vh1cEyk3rUOeLLrN0GzHKU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/eUU/Vb0v5HpOXOoWuGFB9j6cUPsmx/GhNvwICGR/0k/C4M9s
 G71mPKKB65tHq5bVkiuEXsgjhRm3iejF3dXcY3v5Ia271igGbsHxrwbk9kw1RGQxnJU=
X-Gm-Gg: ASbGncvq4AgL4lOIxfOz7qDJ/6UjzvVkELFEPXTC81FOW6KtIP0Paoz+d+FkC3EEW+E
 WC8l7GcCij+kQMnHIegTDr+SiC4DlGHiI1n9fHVTDuNmIp5zCdQpY2yiCNPGQstcKY/KYXPY2tA
 dwyAzIGac+SS8OntpVbYuaTBSD5qZOCGAzghOxs8iSGao0TBO6+eK8yqoPs0H4Th5P5Ie59BdCf
 F1LYaRah/Jv5JEgfsMnN7sIPIxTiJJzorlXuBeUTk6vhA44sI8A0S0xff+w1/SJ1LE/spjQ5e7c
 xcU2wGOwyr32o2mOsKZDxUsNDpvCThbFNOUhZGSF6p3B3A5WmYr2dtRXlS8=
X-Google-Smtp-Source: AGHT+IE6FELzG68e1nyYpqxJVdGZ9RWGkoKkl5qM8iaEaWrxwiA5joMrex18s/2MAvOp55BgVop3fQ==
X-Received: by 2002:a17:907:3f1d:b0:ade:c102:dc9a with SMTP id
 a640c23a62f3a-ae057c46464mr1166380766b.40.1750680639866; 
 Mon, 23 Jun 2025 05:10:39 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae053e80b52sm709176066b.37.2025.06.23.05.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:39 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:33 +0200
Subject: [PATCH v3 10/22] arm64: dts: ti: k3-am62a7-sk: Enable PWM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-10-a4da322c16af@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2216; i=msp@baylibre.com;
 h=from:subject:message-id; bh=muobz5HecFTxPMoZIV6BPJtvzMHN6nlCfEQ9BEGKglw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxI53f+v32Vzxx/Iyc7earyFnefe81HTvE7rz/0qZy9h
 M+jYZJTRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExEqYyR4c6stF0yGYmLGhQF
 TD5zf3RYnT5z5/FoX+Nb935ptr3wSGf4K7Cu/gf3F93/R1ZG3tjlsq1soqFew0/JxJT9S1fVRCl
 0cgMA
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
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
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

