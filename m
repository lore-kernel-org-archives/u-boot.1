Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1032E784AF
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 22:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FD1186D78;
	Tue, 10 Oct 2023 00:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eXSR8Xi+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5F1886D9C; Tue, 10 Oct 2023 00:04:45 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5505986D56
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 00:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7a27254cd12so199587839f.3
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 15:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696889081; x=1697493881; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Oy3/oDIsrYxVx08XCzjcM9Z9wsmpIMgRcvueEjHv/4=;
 b=eXSR8Xi+d6n7o6ULzxp62lKREi/v46zHTXancpHhpzCYCmWNtjufs5V4ePMUvlGLB4
 OpLu/J3uc/7PmT5BDojXSLsVMhcLOeGLbMSEDiSYtWsSS+XhRjSq5hW1KbNZRtld5krU
 ZZxXl8knxeji003dVqPL8qvIadXxAFl3t4phs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696889081; x=1697493881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Oy3/oDIsrYxVx08XCzjcM9Z9wsmpIMgRcvueEjHv/4=;
 b=Hlg2c6wFoaUMsJl5E7AQ4Z//NgGk38v2MnJkGT/vCUWsWCcsCKSouduux+cMUdzP4S
 xtzUVaV/ZW+AyyUj2R/huIa8OiM4678/aeC5ZQD1ZskOQHTHsYo+Ljb7r7LOchR1aX/j
 v3twREx1yj5EgAAkzkryxFLYiFTE21RJexUcNK8YXIbsD61CpkktJvBu/HsZWFtbUe3q
 e21SyRKNT1wvD2a7dvYoY9taMK87ihO0U2+XP7XTT29eb+Gp41wbEcDiallngYfgIsxO
 DugmwpQ2HVuFRfsGng56FobwddjgKTGJ6JrQ9P/+RHzKx1evC/8hW3xm6LNxkZI0QK32
 sDJQ==
X-Gm-Message-State: AOJu0YyceM99710nBzJXMekcVcTQlT5Xv4EwxVeQxZz8G/23rAAQ8h5+
 Ylk8QwgUV32rM1CUTwmQYp7e/g==
X-Google-Smtp-Source: AGHT+IFwSMMRzbI9ukD+T9rudHAv5MuufQsbRJFD77HiKbqNVg7VVe4MkQLuLmI2ApcxREzIG9BR/A==
X-Received: by 2002:a05:6e02:170c:b0:350:f510:3990 with SMTP id
 u12-20020a056e02170c00b00350f5103990mr23056007ill.2.1696889081061; 
 Mon, 09 Oct 2023 15:04:41 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:138c:cf57:c18d:20f5])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a92d4c3000000b0034cd2c0afe8sm3164063ilm.56.2023.10.09.15.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 15:04:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Walle <mwalle@kernel.org>, Rob Herring <robh@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: mtd: binman-partition: Add binman
 compatibles
Date: Mon,  9 Oct 2023 16:04:14 -0600
Message-ID: <20231009220436.2164245-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231009220436.2164245-1-sjg@chromium.org>
References: <20231009220436.2164245-1-sjg@chromium.org>
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

Changes in v4:
- Correct selection of multiple compatible strings

Changes in v3:
- Drop fixed-partitions from the example
- Use compatible instead of label

Changes in v2:
- Use plain partition@xxx for the node name

 .../mtd/partitions/binman-partition.yaml      | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
new file mode 100644
index 000000000000..35a320359ec1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
@@ -0,0 +1,49 @@
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
+    oneOf:
+      - const: binman,entry     # generic binman entry
+      - items:
+          - const: u-boot       # u-boot.bin from U-Boot project
+          - const: atf-bl31     # bl31.bin or bl31.elf from TF-A project
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

