Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8189C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 23:18:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E2CC864D4;
	Thu, 31 Aug 2023 01:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W8l3ujCp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 900DD86556; Thu, 31 Aug 2023 01:18:21 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC4D086550
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 01:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-792726d3aeeso12610239f.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693437495; x=1694042295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c5dYm0P+tYaP9ugFonlv+1+ajXE4Bun3MDvz1H4U99Y=;
 b=W8l3ujCpQD2ouK8SDFKhugTGKgZPZP4Yb0d020t3YtZm99MBQ6rVcp2wx/t04CyJI4
 eHER9H1vc6pN6G4dp0Rvm1AAQJgVxCVk6xNe7K+MnjRnBYgrFeuLX4XS1dawmk+cAzsr
 hwOAJW7g7ll6RUSQkcA1U1eVlNHdlnyRJxcfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693437495; x=1694042295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c5dYm0P+tYaP9ugFonlv+1+ajXE4Bun3MDvz1H4U99Y=;
 b=e8HhhyFhDhrhSg4T5I6Gud655ezIb9cMKv59LI5aPhtoeIlqD1NCmAWD9nWlfM6SgX
 Mvrzuh1F9QnzTDt3LBSynHnc90cfyIfCbwGCom26zLiLR7El3N5MamnrknKcIryEYbaX
 RZ/n4Rvu/tPurwr3smZFEV2uAdjk8bZZk9FWFLJLK87aaqjfXtSx9XEjLzAKEgp94487
 DHR3LHISy7WRvw8hnoguUQRQZgEHO8toVztxjivbPxPlzWxZP4KMcd7OLVcqE3eAb89P
 SQY2d4MevCE/42ifjhc/Ak6w3iZ2e1EjlfbTo/2WnV+/LvurAVM8UC0Y7YDUpenuoRqP
 E0rw==
X-Gm-Message-State: AOJu0YxbQIe1tCof+nGC8QwILBbHJOesfwfLaeOFriM9+MNJquNVw5gf
 Nel5QtAFvJn4xq0r8n/25oK7QA==
X-Google-Smtp-Source: AGHT+IHbhEkN2e11zGzdoaKLoCaWImVUNVgxzxMc+LsGq9Hv9e+k6T9lyQM2LaTI4FZURLKgKoaYeg==
X-Received: by 2002:a5e:8a48:0:b0:790:c259:4ee5 with SMTP id
 o8-20020a5e8a48000000b00790c2594ee5mr4273635iom.8.1693437495666; 
 Wed, 30 Aug 2023 16:18:15 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 z25-20020a5ec919000000b007951e14b951sm73360iol.25.2023.08.30.16.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 16:18:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Maximilian Brune <maximilian.brune@9elements.com>,
 ron minnich <rminnich@gmail.com>, Tom Rini <trini@konsulko.com>,
 Dhaval Sharma <dhaval@rivosinc.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Rutland <mark.rutland@arm.com>, Yunhui Cui <cuiyunhui@bytedance.com>,
 linux-acpi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Gua Guo <gua.guo@intel.com>, Lean Sheng Tan <sheng.tan@9elements.com>,
 Guo Dong <guo.dong@intel.com>, lkml <linux-kernel@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, Chiu Chasel <chasel.chiu@intel.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 3/4] schemas: Add some common reserved-memory usages
Date: Wed, 30 Aug 2023 17:17:51 -0600
Message-ID: <20230830231758.2561402-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830231758.2561402-1-sjg@chromium.org>
References: <20230830231758.2561402-1-sjg@chromium.org>
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

The Devicetree specification skips over handling of a logical view of
the memory map, pointing users to the UEFI specification.

It is common to split firmware into 'Platform Init', which does the
initial hardware setup and a "Payload" which selects the OS to be booted.
Thus an handover interface is required between these two pieces.

Where UEFI boot-time services are not available, but UEFI firmware is
present on either side of this interface, information about memory usage
and attributes must be presented to the "Payload" in some form.

This aims to provide an small schema addition for this mapping.

For now, no attempt is made to create an exhaustive binding, so there are
some example types listed. More can be added later.

The compatible string is not included, since the node name is enough to
indicate the purpose of a node, as per the existing reserved-memory
schema.

This binding does not include a binding for the memory 'attribute'
property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may be useful
to have that as well, but perhaps not as a bit mask.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Drop the memory-map node (should have done that in v4)
- Tidy up schema a bit

Changes in v4:
- Make use of the reserved-memory node instead of creating a new one

Changes in v3:
- Reword commit message again
- cc a lot more people, from the FFI patch
- Split out the attributes into the /memory nodes

Changes in v2:
- Reword commit message

 .../reserved-memory/common-reserved.yaml      | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 dtschema/schemas/reserved-memory/common-reserved.yaml

diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
new file mode 100644
index 0000000..d1b466b
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/common-reserved.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common memory reservations
+
+description: |
+  Specifies that the reserved memory region can be used for the purpose
+  indicated by its node name.
+
+  Clients may reuse this reserved memory if they understand what it is for.
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  $nodename:
+    enum:
+      - acpi-reclaim
+      - acpi-nvs
+      - boot-code
+      - boot-data
+      - runtime-code
+      - runtime-data
+
+  reg:
+    description: region of memory that is reserved for the purpose indicated
+      by the node name.
+
+required:
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        boot-code@12340000 {
+            reg = <0x12340000 0x00800000>;
+        };
+
+        boot-data@43210000 {
+            reg = <0x43210000 0x00800000>;
+        };
+    };
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

