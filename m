Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E7EE82CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 20:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E584286E02;
	Wed, 27 Sep 2023 22:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YoLDIcHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F8F7869F5; Wed, 27 Sep 2023 22:21:13 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E12E86D85
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 22:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-79fa416b7ffso367363239f.2
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 13:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695846069; x=1696450869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kq9WoSgqEviF42jhwFTI980vH31ePAvDcikVyQPxtc=;
 b=YoLDIcHeMnJKUM1iLrcjDJB1C1KH42JMX25rIHIjg+2Mb9W62OqTD6iag3zT2SeDy0
 /uoDth1Kkewr9d+c9oy5CJSVRSI841m5Rx1tJcMETPv70OJHYiU0H2rtUNGyh93RbgR9
 fJ4R6RT+Rv+11jmE8PrFwxRMTL9uTKwYpwLqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695846069; x=1696450869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1kq9WoSgqEviF42jhwFTI980vH31ePAvDcikVyQPxtc=;
 b=VmJbCbumRNzTpWWAI+jRC8hzPDcuRmvsg2M8ETZyAU8u4ovbHwsQuLlpyOOa9uVptK
 KLIwgh+CiBKXQ4Xh9qiv4MPNBFiGfJHKrfM2BeJLMfB3OUAZ6WxztVtBNj3UMUfbj1Gl
 tD1IH9I6+zaYJ0Wn9EcKM/MFN4DvB55VWpwRmcmnZklJURQed/sd148IZNKUbfa0a7P8
 aHQAVh6w6lak1r8jHVH4qjmlRqpItwWYptOTHf5ZoIlwLyLpwugumhFF+tw6YLTRZ5R6
 2elL9ri5gERj0qWyAr9ZxYDKdVz5VRlEgXpfjgx5JmyArx6YJ6LBY6HVoePa0h51v7B2
 I69A==
X-Gm-Message-State: AOJu0Yz6mf5lQ6DOtX5DqJWAyO3Mc6jyd6QV/EslI7OfsDWgORLtdK0V
 6aja7QN4OWj0ivIbn78yXGpIgA==
X-Google-Smtp-Source: AGHT+IFhPJEncrLdXnOVjxjuTHH/e94XYzo89HB1tZ1pWdiwxx4ZhAkrwcRurxLK1zLwja0dnf6dQQ==
X-Received: by 2002:a5e:a610:0:b0:795:16b8:85fc with SMTP id
 q16-20020a5ea610000000b0079516b885fcmr2995614ioi.0.1695846069701; 
 Wed, 27 Sep 2023 13:21:09 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5d4f:fe51:5575:6f76])
 by smtp.gmail.com with ESMTPSA id
 ei15-20020a05663829af00b0042fec8620e4sm4113299jab.57.2023.09.27.13.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 13:21:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, Rob Herring <robh@kernel.org>,
 Simon Glass <sjg@chromium.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: mtd: binman-partition: Add binman labels
Date: Wed, 27 Sep 2023 14:20:52 -0600
Message-ID: <20230927202057.3676497-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230927202057.3676497-1-sjg@chromium.org>
References: <20230927202057.3676497-1-sjg@chromium.org>
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

Add two labels for binman entries, as a starting point for the schema.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .../mtd/partitions/binman-partition.yaml      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
new file mode 100644
index 000000000000..6ee832cb4c4c
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
+  label:
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
+        compatible = "binman", "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition-u-boot@100000 {
+            label = "u-boot";
+            reg = <0x100000 0xf00000>;
+        };
+
+        partition-atf-bl31t@200000 {
+            label = "atf-bl31";
+            reg = <0x200000 0x100000>;
+        };
+    };
-- 
2.42.0.515.g380fc7ccd1-goog

