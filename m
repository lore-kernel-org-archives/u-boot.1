Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6284EC875E
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 21:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E06E86A0A;
	Thu,  7 Sep 2023 23:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hYMIEuxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C0DA869F2; Thu,  7 Sep 2023 23:40:20 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2F5086A0A
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 23:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-34e12396f6fso5956675ab.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 14:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694122815; x=1694727615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uuNfNRXcT/k9V+ptR/yNdUXnw9b7b9R/vB+EyNk6U1Q=;
 b=hYMIEuxqjE6qqR+f44KH5ng9G3rdrZp1kh/15rgcjBovXbYkZxadDfz8Ugj4/sLrOp
 lPprc3DPbezT1AHObVoH4OY/pYMqyj9IozfIqfEJqjtDCY12c4UyEJlhshOCu6vS7k3Z
 xiiwaof1PWkvGJuLkW8AxFB08ju47Qz0xlXkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694122815; x=1694727615;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uuNfNRXcT/k9V+ptR/yNdUXnw9b7b9R/vB+EyNk6U1Q=;
 b=ZnJxqa11lGx+gS6cwXYJQN4y5YDQXhbiru1LMGHixbqYRi2RJP3MSsgoFPpJqAU5NK
 IGquYqllHyP4T+Nv0WCwJpcyRjKBmEtmT62ZDKDR6Vw7Uq0Se9GKdPn0JlN3r2YG21La
 fTHWzP+YI9sFxu7PBHVkLLRqIaNfuvcgyG5fzxKGzPUFcKjfmWuZjdXHWDE212E4ip6I
 2wyYS3jO8Zh1H4PcVwaKJAW2fh+uXyyl5WfiOEQDA31CODkJvO2R/QMvv1zTcvsIXHYu
 gdWL7D0FmnEA4i/BRioHZ8EkTRZN9qqih14j9yEGlX69fqj8ILtsNORhFWpe5WfAGNLB
 SgnA==
X-Gm-Message-State: AOJu0Yzd2sy3HYATrsfgOrKA0WxsCtUMw/NDzQs5oJ1gOHnmBVCl/BhU
 y1XdWUao3Q8lBn2sYexoFKPtCQ==
X-Google-Smtp-Source: AGHT+IHDLp8Ggcfk51qBwQHePnX3O5h7/52QV2/g5gnYYMU/kivj6AJyv0nmeNnWNBadoPNLcyCjng==
X-Received: by 2002:a92:d44c:0:b0:349:8a8b:70ca with SMTP id
 r12-20020a92d44c000000b003498a8b70camr1055691ilm.14.1694122815649; 
 Thu, 07 Sep 2023 14:40:15 -0700 (PDT)
Received: from sjg1.lan (c-73-243-118-188.hsd1.co.comcast.net.
 [73.243.118.188]) by smtp.gmail.com with ESMTPSA id
 x14-20020a92d30e000000b00348edca2abesm72006ila.47.2023.09.07.14.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 14:40:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Dhaval Sharma <dhaval@rivosinc.com>, Guo Dong <guo.dong@intel.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Yunhui Cui <cuiyunhui@bytedance.com>, Chiu Chasel <chasel.chiu@intel.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Ard Biesheuvel <ardb@kernel.org>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Gua Guo <gua.guo@intel.com>,
 ron minnich <rminnich@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 1/2] schemas: Add some common reserved-memory usages
Date: Thu,  7 Sep 2023 15:40:10 -0600
Message-ID: <20230907214012.74978-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
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

This aims to provide an small schema addition for the memory mapping
needed to keep these two pieces working together well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
index 0000000..4889f59
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
+      This describes some common memory reservations:
+
+         acpi-reclaim: Contains ACPI tables; memory may be reclaimed when the
+           tables are no-longer needed
+         acpi-nvs: Contains ACPI Non-volatile-storage data; memory may be
+           reclaimed when the tables are no-longer needed
+         boot-code: Contains code used for booting; memory may be reclaimed by
+           the OS when it is running
+         boot-code: Contains data used for booting; memory may be reclaimed by
+           the OS when it is running
+         runtime-code: Contains code used for interacting with the system when
+           running; memory may be reclaimed if this code is not called
+         runtime-data: Contains data used for interacting with the system when
+           running; memory may be reclaimed if the runtime code is not used
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
2.42.0.283.g2d96d420d3-goog

