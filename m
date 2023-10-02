Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C7DE74901
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 17:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC95986EFF;
	Mon,  2 Oct 2023 19:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RgH9asWM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81DF1870DE; Mon,  2 Oct 2023 19:50:38 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 300AD86DBC
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 19:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79fe8986355so60839f.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696269035; x=1696873835; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2OIh/G3vvfH8cT1f+jhivcT+xHStCXj54HHC5DhSlw=;
 b=RgH9asWM5qJ9TvD1r49SXeJglvTu/q2Ilo8vAIgJnGru979G0PxrJDv0ZzT7vIZyV4
 hcZOn1EjcGm+UmWfSqLFLCJQIrO8eb3HUitqMqcmVuFsV5caoQDnsKQg1t98TIodxddS
 OAD2Nx/zb2+oLh2tNm3PeAZdttv9mnPjJOwds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696269035; x=1696873835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2OIh/G3vvfH8cT1f+jhivcT+xHStCXj54HHC5DhSlw=;
 b=YSC6C0YAWKKSGnUbs/IbTT37qJ3LOw96qNBAX7B4zPytglUtycHifc99JpTdEii1tr
 m7aNmB0fKEJEib0BhrxsFyZ+h0/Hml8t2dFsEiXAJ66LY6edVX8CxTASsfmZ3nSUxBev
 c5PHwOQxkYz9Os5fKYevgHq7ptU00wWtvfN/rY94Jvy8vGZbi7kjJX9va2836rZibK6k
 OorgKmspywj6BoLzphbiMayAFrCfw6fDLeyITWbw316l5H8g1hBvgSM4J7jbGcqxzu3+
 ibxtNPdlkxVVy7RW3s1WtDWJiXFEL4eYnbwCCSoyFzLKAToAvLtjeYMyvIdzRbeoDs5T
 351A==
X-Gm-Message-State: AOJu0YxCaHcix6xXRugBAzCsoUKqzIdLPwid6tIPwOyb+adT4gD9r+SW
 14uiMLmJyEWaKNOpyetTM9z9Bw==
X-Google-Smtp-Source: AGHT+IEajo7AgZ09G/o1FHYBl5iibeG+V+B1CsR5q6ZjwznpqxMf8wOSm4wNhvKtLK5z7hs1GK8trg==
X-Received: by 2002:a5d:9cd5:0:b0:799:36c2:fa49 with SMTP id
 w21-20020a5d9cd5000000b0079936c2fa49mr12850092iow.15.1696269034885; 
 Mon, 02 Oct 2023 10:50:34 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:63cd:2673:520:2e9])
 by smtp.gmail.com with ESMTPSA id
 s23-20020a02c517000000b0042b2e309f97sm6919562jam.177.2023.10.02.10.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 10:50:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, linux-mtd@lists.infradead.org,
 Simon Glass <sjg@chromium.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: mtd: binman-partition: Add binman labels
Date: Mon,  2 Oct 2023 11:49:41 -0600
Message-ID: <20231002174948.1015223-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002174948.1015223-1-sjg@chromium.org>
References: <20231002174948.1015223-1-sjg@chromium.org>
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

Changes in v2:
- Use plain partition@xxx for the node name

 .../mtd/partitions/binman-partition.yaml      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
new file mode 100644
index 000000000000..406a8997d3e4
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
+        partition@100000 {
+            label = "u-boot";
+            reg = <0x100000 0xf00000>;
+        };
+
+        partition@200000 {
+            label = "atf-bl31";
+            reg = <0x200000 0x100000>;
+        };
+    };
-- 
2.42.0.582.g8ccd20d70d-goog

