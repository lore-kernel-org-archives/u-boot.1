Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60938CD6133
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 20:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24FA486D2E;
	Mon,  9 Oct 2023 22:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="edMwbSKV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB0C086ACA; Mon,  9 Oct 2023 22:10:19 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF19185894
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 22:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79fe87cd74eso219203239f.3
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 13:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696882215; x=1697487015; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b3GY1i1RwOxFPsx3r0WAP41F76rpcBgk99acMMB0WNM=;
 b=edMwbSKVCau5h+yI9Vb6sRrSzhWH9lkd6Upx5rIndei2DFB4/U2t5rOxZr4csdtenk
 cmSRpgsgboomW7cqQ76e2qafnZ7cayolhmmrLqmb/ZYE6nOaC0QhKbfT5oKIQpgw+7xc
 HP0WG7WuDzYZEfFFpsIQz3fj06z0k7AOcCOdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696882215; x=1697487015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3GY1i1RwOxFPsx3r0WAP41F76rpcBgk99acMMB0WNM=;
 b=AcQ+HseRUKqyJ1aLoFh77zzmDX9wVF62HevMZrGc634Bhhu9sT5MACZjozNVdPHC8m
 uGeGEoURchNxILzHYxwNxsf8AeeP9YAn9+NNSq5SSsWC/4/F06Yp0HklKSUBejq1Cgee
 nqjVtd6SrAXYAdCllbxLGTlm4rfjYfrdGt+cpRPz7CFpXTN2CGd2T9R7AL8UMQbqYcBo
 12TBaHgEWrUHbaHT7z3RIpvLJ7JLDz4eBRzVpNN0hrciNAUBrSGyKgdpzRl6bdHD1i6j
 yToNbYz0xsgbD+0m9xdfdXIQmo8zCrIofIRmvvSUEkWZqxxHpHullHNDZuzYiJOUTTEp
 EKyQ==
X-Gm-Message-State: AOJu0YzJW5isYT3z+7/22lQLNT63DRwVcZ+0zyGk/KXoOnZWFWnnWOvP
 XzURWKI2TjJTkOMYM0yBhiqhKA==
X-Google-Smtp-Source: AGHT+IGRVDl2QlAkPNETkpq0SUkGBPU/UdXTV3AM7x9Hs22e2Z60hPdHjcDCo4XmjZUSi77IkFoEjw==
X-Received: by 2002:a05:6602:220e:b0:786:f352:e3d4 with SMTP id
 n14-20020a056602220e00b00786f352e3d4mr19797645ion.7.1696882215555; 
 Mon, 09 Oct 2023 13:10:15 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:138c:cf57:c18d:20f5])
 by smtp.gmail.com with ESMTPSA id
 q21-20020a02a315000000b0042b2df337ccsm2215294jai.76.2023.10.09.13.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 13:10:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, linux-mtd@lists.infradead.org,
 Michael Walle <mwalle@kernel.org>, Tom Rini <trini@konsulko.com>,
 Rob Herring <robh@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: mtd: binman-partition: Add binman
 compatibles
Date: Mon,  9 Oct 2023 14:10:00 -0600
Message-ID: <20231009201005.1964794-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231009201005.1964794-1-sjg@chromium.org>
References: <20231009201005.1964794-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add two compatible for binman entries, as a starting point for the
schema.

Note that, after discussion on v2, we decided to keep the existing
meaning of label so as not to require changes to existing userspace
software when moving to use binman nodes to specify the firmware
layout.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Drop fixed-partitions from the example
- Use compatible instead of label

Changes in v2:
- Use plain partition@xxx for the node name

 .../mtd/partitions/binman-partition.yaml      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
new file mode 100644
index 000000000000..754f804524a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Google LLC
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/binman-partition.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binman partition
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+select: false
+
+description: |
+  This corresponds to a binman 'entry'. It is a single partition which holds
+  data of a defined type.
+
+allOf:
+  - $ref: /schemas/mtd/partitions/partition.yaml#
+
+properties:
+  compatible:
+    items:
+      enum:
+        - u-boot       # u-boot.bin from U-Boot projec6t
+        - atf-bl31     # bl31.bin or bl31.elf from TF-A project
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "binman";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@100000 {
+            compatible = "u-boot";
+            reg = <0x100000 0xf00000>;
+        };
+
+        partition@200000 {
+            compatible = "atf-bl31";
+            reg = <0x200000 0x100000>;
+        };
+    };
-- 
2.42.0.609.gbb76f46606-goog

