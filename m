Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695DAEE4996
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:48:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D118C8704F;
	Mon, 21 Aug 2023 21:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="donK6i77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB6B887046; Mon, 21 Aug 2023 21:48:36 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA39987072
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-790f831c6fbso126799139f.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692647312; x=1693252112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3N7X/HZKiODl+6+MNX6JndqNW1xPMfJ5KlQEIhhEp20=;
 b=donK6i774XrVXYP+eFrBY/Un4gIoAVwXckSA4zoLb4QBZYzF5hY1hU1F0BosScRQZ7
 l8eJtPP5cxDUF78dsofEIp4j0EcKrNglBt9oSms17GThKXCDrYdb5byaw/WwyU/nlFex
 UW6rQKBjf9lgmZW8uJ/Z05szJXngqVckaTEWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692647312; x=1693252112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3N7X/HZKiODl+6+MNX6JndqNW1xPMfJ5KlQEIhhEp20=;
 b=aS4saMgClZMyPnoL/tgy/K8ud1oD7yuikccp5VRQQv08sm2hKFzhiz+fbpI2RccoFx
 2jvPXcIFgEDvUSEVwLQuWM7G9QiOajMOkpJhBUlqtnwnUvyS4ZlqGlD0qWZV+UKTr6ay
 xjq8Gb618+2srgJZhELkvVoD7RXBKyRuXYUc8QPaKKwM3CiE/L8S7UXLMEltWaCISr9C
 GhOufvnppYFgNJuSGmKuflCmyDe/W1mbt5J8m7DQ0bux8xaaPK96Sb4MHIxEKZHohf2Y
 SMl11EUr6z/isApLLjMvShhLfu/en2rknbuewXx0UHZa432prgy4zHZiC25+YFwzB3Ow
 4PUQ==
X-Gm-Message-State: AOJu0YxHcXB6pQpIs4ppkiG8qAOxPyDMeKeYCCsrQRtqqSZMHnmWMNjp
 qbWH/oPgBuvzEB8r5ehyx7J9mA==
X-Google-Smtp-Source: AGHT+IFcu3IPYhGGuLvsyVJO8RzW3hUh7Hrcr3zrfVG6DkyEQPecWurr30tfPYr4FOJh+8GUA9xkMA==
X-Received: by 2002:a05:6602:690:b0:785:5917:a35f with SMTP id
 dp16-20020a056602069000b007855917a35fmr10766390iob.8.1692647312413; 
 Mon, 21 Aug 2023 12:48:32 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:9102:8976:7620:5093])
 by smtp.gmail.com with ESMTPSA id
 o21-20020a02c6b5000000b0042b0ce92dddsm2552076jan.161.2023.08.21.12.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 12:48:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Chiu Chasel <chasel.chiu@intel.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Gua Guo <gua.guo@intel.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2] schemas: Add a schema for memory map
Date: Mon, 21 Aug 2023 13:48:19 -0600
Message-ID: <20230821194821.2961213-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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

The Devicespec specification skips over handling of a logical view of
the memory map, pointing users to the UEFI specification.

It is common to split firmware into 'Platform Init', which does the
initial hardware setup and a "Payload" which selects the OS to be booted.
Thus an handover interface is required between these two pieces.

Where UEFI boot-time services are not available, but UEFI firmware is
present on either side of this interface, information about memory usage
and attributes must be presented to the "Payload" in some form.

This aims to provide an initial schema for this mapping.

Note that this is separate from the existing /memory and /reserved-memory
nodes, since it is mostly concerned with what the memory is used for. It
may cover only a small fraction of available memory, although it could be
used to signal which area of memory has ECC.

For now, no attempt is made to create an exhaustive binding, so there are
some example types lists. This can be completed once this has passed
initial review.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Reword commit message

 dtschema/schemas/memory-map.yaml | 51 ++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 dtschema/schemas/memory-map.yaml

diff --git a/dtschema/schemas/memory-map.yaml b/dtschema/schemas/memory-map.yaml
new file mode 100644
index 0000000..97e531e
--- /dev/null
+++ b/dtschema/schemas/memory-map.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: BSD-2-Clause
+# Copyright 2023 Google LLC
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-map.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: /memory-map nodes
+description: |
+  Common properties always required in /memory-map nodes. These nodes are
+  intended to resolve the nonchalant clause 3.4.1 ("/memory node and UEFI")
+  in the Devicetree Specification.
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+properties:
+  $nodename:
+    const: '/'
+  usage:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Describes the usage of the memory region, e.g.:
+
+        "acpi-reclaim", "acpi-nvs", "bootcode", "bootdata", "bootdata",
+        "runtime-code", "runtime-data"
+  attr:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: |
+      Attributes possessed by this memory region:
+
+        "single-bit-ecc" - supports single-bit ECC
+        "multi-bit-ecc" - supports multiple-bit ECC
+        "no-ecc" - non-ECC memory
+
+patternProperties:
+  "^([a-z][a-z0-9\\-]+@[0-9a-f]+)?$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      reg:
+        minItems: 1
+        maxItems: 1024
+
+    required:
+      - reg
+
+additionalProperties: true
+
+...
-- 
2.42.0.rc1.204.g551eb34607-goog

