Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEEBE7E65A
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 19:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56FDA86CBB;
	Tue, 26 Sep 2023 21:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S2GwTJwq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC56986D4D; Tue, 26 Sep 2023 21:42:52 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC6586C67
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 21:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79fca042ec0so163652839f.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 12:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695757369; x=1696362169; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfBINqFi+tu9r+hgIndvcFHVghblGM5fsNWuNXfdXnI=;
 b=S2GwTJwqCMZ345xoqhQa1ANG3Yo1S6GsWyanAM4doI93y0gx/vSh1lQMw2xgbznOSr
 ydG15LvfPsKBcQmqpayLQshxRrYZOZps7H/bs+GysNu6DIwJJy3O0rL4Tw7c76pSJl/L
 ee6nFI+RquiMlutZMltjE0eIDMxuCaB/awO00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695757369; x=1696362169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfBINqFi+tu9r+hgIndvcFHVghblGM5fsNWuNXfdXnI=;
 b=CjlWsQAR9VBIcZA3sIpymjIUuGlwLf7TVawCWhLRSEU3LkL7xkEsUBaEn6LZUvTB8a
 U/lIeY1NTET8l2FtWavLtUIk7ew7bDs7NeXnV1eehVToKPvPICdu7zZqQyt37YTQRMll
 mh9CIfXZPRjxWt4DTZp/2hkzqdywKfWELxnYyN79D3ytuoWuYQbhY4vEQ7PyynFVN/KF
 KjYey3new6JTgxTmZk+kiX1uii5pz2XfVSbSH7tMJWppEQr6PFbJ3O0ZIwfyOlqDjyCd
 FwLZt7J80Xa5ONvDfFWtzz8g/mHkClZgluOBMbEzy35e+6AtRiYWRs0NO73PItbJuN06
 2LZA==
X-Gm-Message-State: AOJu0YzUCxqYl2SRzHXIVAcPqHsdoDcwDHFtOu1u4ItZ84JOAFcfkitE
 1xaDM5YI0hp25n/voyB4R5a6hQ==
X-Google-Smtp-Source: AGHT+IHn4wKAiOfOfPpJ96btA7O5kjWAiCXjuBwMWz61V9KKEyTA4jYKowovoVpbKAJXqsBb2Sa7gA==
X-Received: by 2002:a05:6e02:219c:b0:349:7cec:db76 with SMTP id
 j28-20020a056e02219c00b003497cecdb76mr14089105ila.31.1695757369179; 
 Tue, 26 Sep 2023 12:42:49 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:1da0:a3ce:7aae:e9fa])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a056e02130600b0035134f1a240sm1961451ilr.86.2023.09.26.12.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 12:42:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 lkml <linux-kernel@vger.kernel.org>, Dhaval Sharma <dhaval@rivosinc.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>, Guo Dong <guo.dong@intel.com>,
 Tom Rini <trini@konsulko.com>, ron minnich <rminnich@gmail.com>,
 Gua Guo <gua.guo@intel.com>, Chiu Chasel <chasel.chiu@intel.com>,
 linux-acpi@vger.kernel.org, U-Boot Mailing List <u-boot@lists.denx.de>,
 Ard Biesheuvel <ardb@kernel.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
Date: Tue, 26 Sep 2023 13:42:39 -0600
Message-ID: <20230926194242.2732127-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926194242.2732127-1-sjg@chromium.org>
References: <20230926194242.2732127-1-sjg@chromium.org>
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

It is common to split firmware into 'Platform Init', which does the
initial hardware setup and a "Payload" which selects the OS to be booted.
Thus an handover interface is required between these two pieces.

Where UEFI boot-time services are not available, but UEFI firmware is
present on either side of this interface, information about memory usage
and attributes must be presented to the "Payload" in some form.

This aims to provide an small schema addition for the memory mapping
needed to keep these two pieces working together well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v7:
- Rename acpi-reclaim to acpi
- Drop individual mention of when memory can be reclaimed
- Rewrite the item descriptions
- Add back the UEFI text (with trepidation)

Changes in v6:
- Drop mention of UEFI
- Use compatible strings instead of node names

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

 .../reserved-memory/common-reserved.yaml      | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 dtschema/schemas/reserved-memory/common-reserved.yaml

diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
new file mode 100644
index 0000000..f7fbdfd
--- /dev/null
+++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
@@ -0,0 +1,71 @@
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
+  indicated by its compatible string.
+
+  Clients may reuse this reserved memory if they understand what it is for,
+  subject to the notes below.
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    description: |
+      This describes some common memory reservations, with the compatible
+      string indicating what it is used for:
+
+         acpi: Advanced Configuration and Power Interface (ACPI) tables
+         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (NVS). This is reserved by
+           the firmware for its use and is required to be saved and restored
+           across an NVS sleep
+         boot-code: Contains code used for booting which is not needed by the OS
+         boot-code: Contains data used for booting which is not needed by the OS
+         runtime-code: Contains code used for interacting with the system when
+           running the OS
+         runtime-data: Contains data used for interacting with the system when
+           running the OS
+
+    enum:
+      - acpi
+      - acpi-nvs
+      - boot-code
+      - boot-data
+      - runtime-code
+      - runtime-data
+
+  reg:
+    description: region of memory that is reserved for the purpose indicated
+      by the compatible string.
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
+        reserved@12340000 {
+            compatible = "boot-code";
+            reg = <0x12340000 0x00800000>;
+        };
+
+        reserved@43210000 {
+            compatible = "boot-data";
+            reg = <0x43210000 0x00800000>;
+        };
+    };
-- 
2.42.0.515.g380fc7ccd1-goog

