Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C63C61DFB
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 17:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB51B83D17;
	Sat, 21 Feb 2026 18:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TMPlKQOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B68583A41; Sat, 21 Feb 2026 17:32:27 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAF70801BE
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 17:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a91215c158so20372455ad.0
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 08:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771691543; x=1772296343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PsStu99SvKp4nR9xQ1oemSijpYLMhzSTUrPObC/Cr+o=;
 b=TMPlKQODbhec7l3hYAp5M5tNjMMaDDf8ZbmE+OMniabV+9gpH9Spvex+ML+acKVpoy
 75Vf4L4z1stgQ0erLn5cVB0ipe5lfP8qnCeT5av3qdEVqKxnmTGuSSmp8rF8T9YpSXty
 kcynp9eDthQGCUPsbyIWEAHxj4vxGBIWWphRnhy1XM5ItTDtjy9JPqKYshdZ11zVHde/
 WsAfqAOy24H7MSw0VNu/EYJuv5vKawGAaMVep7AllWO+F1nVebv7YN1/MgIi2a3C1zp0
 jgK38+MbGd2rMp6Yr1y/mOoMidy0Fp8DwYoO/E05NDKi6psWf8CbKV+E54Gu8lC1FZMN
 oRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771691543; x=1772296343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PsStu99SvKp4nR9xQ1oemSijpYLMhzSTUrPObC/Cr+o=;
 b=pJovdiWunkc4T4tDHSd/UjTq4STaNIWw1i1uj5AWOkBPc7szWeSE3b/BfCp1sj4rzw
 OVMSTqaM2+wPx55gEJMQnUiuH2tm/YKb8kNvxu2cHXyWFkxHkjV55rdSKcoT8zf79Cfw
 gy1ToVlNJGU297tbBsdZhDpi0j5bSwiMn64I9NVCO8yUf5xPLcVIev2pwd1nv8hWESy5
 mFol1ev+C84TGrIh2PUUJCOHhkxy13yRdFHWUXFG/u3cr5p2QtuXKT0Y/j3F3g0zzwl/
 m+4/CQIHYymY/ZuBcCOyyliI8TDRjRjRIE+5MnBXNw1FyhXZAK199zSX8pZIKPHviGlm
 Z5Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpQCW8tspGsjj7HGJ4QUvvJRZLdigrW4J2sQqUh6ayuB5Dvzu0B1aAOm4WU5Q53Y1FvLDTWaM=@lists.denx.de
X-Gm-Message-State: AOJu0YwhTsPzkbGtvuk1Nkeoz9xXL3FI0E/5tfJIOnTi2TOnIrotxjMU
 4I9g5Ih2aVmADhYuIP+H5jbbni/P4oUgCd+iHKm1NkR37c+lo3lVNKfw
X-Gm-Gg: AZuq6aJpqBCgAWS1/499G/5qCVV0zrUaYPs55UgNSFqbXF4wTeQ1OKMYYSbw9rdFVRF
 oZPMXxUXny2HLsHhYejqo8LrVBw2zY9wc1zJuuVinUnzGQbSiIY3JCAuo2SCr6EZn6tQGvwccIo
 kwFBsuEi5FOO7t2wuEDJaHjb0jT0s96KIn5DkflkcrVnVoJsXENDOVxj01UxMwMLyjrH7851uQ+
 9urhMKjbeKynkZpCJa7JyxiRV6A+Fw+StQl5FfJmjJnWWUDYzgs+jQjzaIzw2qdJSx3LSlPYvmN
 S2eb54jiRCyCn5hIQOwmYLG9JKLHCwbthDWvhZ7rR9etP+fcv7MBcsz9VMBk0evzZsZkpOwBYz6
 p+vz2S3O6fon9Tn28YTNaazbwdCjGdLyKw2kOIYiHUE8zcgZFUTYqw857aRbU5Vdleaf8rlIt+F
 rQHo4F/wpgmIQ+xcw7NOW5QCRWSSADE0SvfLgfrsGbdONeGtvmf52Kz5S5KFo9kBBVQlws8abrv
 Ve0BBCV9fvJsSGAVl7T4g==
X-Received: by 2002:a17:902:c952:b0:2a9:838e:8d7f with SMTP id
 d9443c01a7336-2ad74524453mr33680785ad.41.1771691543122; 
 Sat, 21 Feb 2026 08:32:23 -0800 (PST)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad7500e062sm36868365ad.48.2026.02.21.08.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 08:32:22 -0800 (PST)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org
Cc: ericwouds@gmail.com, kabel@kernel.org, vladimir.oltean@nxp.com,
 frank-w@public-files.de, daniel@makrotopia.org, ansuelsmth@gmail.com,
 mkorpershoek@kernel.org, skylake.huang@mediatek.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v1 1/4] dt-bindings: phy: rename transmit-amplitude to
 phy-common-props and add polarity
Date: Sun, 22 Feb 2026 00:31:11 +0800
Message-Id: <20260221163114.87553-2-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221163114.87553-1-lucienzx159@gmail.com>
References: <20260221163114.87553-1-lucienzx159@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Feb 2026 18:32:49 +0100
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

Rename transmit-amplitude.yaml to phy-common-props.yaml to better reflect
its scope, and extend it with two new common PHY properties:

  - rx-polarity: configure receiver polarity (normal, inverted, or auto)
  - tx-polarity: configure transmitter polarity (normal or inverted)

Both properties support per-mode configuration via a companion -names
property, with a "default" entry as fallback when a specific mode is
not listed.

Ported from Merge tag 'phy-for-7.0':
  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy

Link: https://git.kernel.org/linus/b7b4dcd96e3dfbb955d152c9ce4b490498b0f4b4
Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
 ...t-amplitude.yaml => phy-common-props.yaml} | 92 +++++++++++++++----
 1 file changed, 73 insertions(+), 19 deletions(-)
 rename dts/upstream/Bindings/phy/{transmit-amplitude.yaml => phy-common-props.yaml} (44%)

diff --git a/dts/upstream/Bindings/phy/transmit-amplitude.yaml b/dts/upstream/Bindings/phy/phy-common-props.yaml
similarity index 44%
rename from dts/upstream/Bindings/phy/transmit-amplitude.yaml
rename to dts/upstream/Bindings/phy/phy-common-props.yaml
index 617f3c0b3df..b2c709cc1b0 100644
--- a/dts/upstream/Bindings/phy/transmit-amplitude.yaml
+++ b/dts/upstream/Bindings/phy/phy-common-props.yaml
@@ -1,36 +1,27 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/phy/transmit-amplitude.yaml#
+$id: http://devicetree.org/schemas/phy/phy-common-props.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Common PHY and network PCS transmit amplitude property
+title: Common PHY and network PCS properties
 
 description:
-  Binding describing the peak-to-peak transmit amplitude for common PHYs
-  and network PCSes.
+  Common PHY and network PCS properties, such as peak-to-peak transmit
+  amplitude.
 
 maintainers:
   - Marek Behún <kabel@kernel.org>
 
-properties:
-  tx-p2p-microvolt:
+$defs:
+  protocol-names:
     description:
-      Transmit amplitude voltages in microvolts, peak-to-peak. If this property
-      contains multiple values for various PHY modes, the
-      'tx-p2p-microvolt-names' property must be provided and contain
-      corresponding mode names.
-
-  tx-p2p-microvolt-names:
-    description: |
-      Names of the modes corresponding to voltages in the 'tx-p2p-microvolt'
-      property. Required only if multiple voltages are provided.
-
-      If a value of 'default' is provided, the system should use it for any PHY
-      mode that is otherwise not defined here. If 'default' is not provided, the
-      system should use manufacturer default value.
+      Names of the PHY modes. If a value of 'default' is provided, the system
+      should use it for any PHY mode that is otherwise not defined here. If
+      'default' is not provided, the system should use manufacturer default value.
     minItems: 1
     maxItems: 16
+    uniqueItems: true
     items:
       enum:
         - default
@@ -89,15 +80,78 @@ properties:
         - mipi-dphy-univ
         - mipi-dphy-v2.5-univ
 
+properties:
+  tx-p2p-microvolt:
+    description:
+      Transmit amplitude voltages in microvolts, peak-to-peak. If this property
+      contains multiple values for various PHY modes, the
+      'tx-p2p-microvolt-names' property must be provided and contain
+      corresponding mode names.
+
+  tx-p2p-microvolt-names:
+    description:
+      Names of the modes corresponding to voltages in the 'tx-p2p-microvolt'
+      property. Required only if multiple voltages are provided.
+    $ref: "#/$defs/protocol-names"
+
+  rx-polarity:
+    description:
+      An array of values indicating whether the differential receiver's
+      polarity is inverted. Each value can be one of
+      PHY_POL_NORMAL (0) which means the negative signal is decoded from the
+      RXN input, and the positive signal from the RXP input;
+      PHY_POL_INVERT (1) which means the negative signal is decoded from the
+      RXP input, and the positive signal from the RXN input;
+      PHY_POL_AUTO (2) which means the receiver performs automatic polarity
+      detection and correction, which is a mandatory part of link training for
+      some protocols (PCIe, USB SS).
+
+      The values are defined in <dt-bindings/phy/phy.h>. If the property is
+      absent, the default value is undefined.
+
+      Note that the RXP and RXN inputs refer to the block that this property is
+      under, and do not necessarily directly translate to external pins.
+
+      If this property contains multiple values for various protocols, the
+      'rx-polarity-names' property must be provided.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 16
+    items:
+      enum: [0, 1, 2]
+
+  rx-polarity-names:
+    $ref: '#/$defs/protocol-names'
+
+  tx-polarity:
+    description:
+      Like 'rx-polarity', except it applies to differential transmitters,
+      and only the values of PHY_POL_NORMAL and PHY_POL_INVERT are possible.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 16
+    items:
+      enum: [0, 1]
+
+  tx-polarity-names:
+    $ref: '#/$defs/protocol-names'
+
 dependencies:
   tx-p2p-microvolt-names: [ tx-p2p-microvolt ]
+  rx-polarity-names: [ rx-polarity ]
+  tx-polarity-names: [ tx-polarity ]
 
 additionalProperties: true
 
 examples:
   - |
+    #include <dt-bindings/phy/phy.h>
+
     phy: phy {
       #phy-cells = <1>;
       tx-p2p-microvolt = <915000>, <1100000>, <1200000>;
       tx-p2p-microvolt-names = "2500base-x", "usb-hs", "usb-ss";
+      rx-polarity = <PHY_POL_AUTO>, <PHY_POL_NORMAL>;
+      rx-polarity-names = "usb-ss", "default";
+      tx-polarity = <PHY_POL_INVERT>;
     };
-- 
2.34.1

