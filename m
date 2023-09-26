Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774C7E7E65A
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 19:42:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D23AA86C71;
	Tue, 26 Sep 2023 21:42:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IU955moj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1F2086C71; Tue, 26 Sep 2023 21:42:50 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC5A86BE2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 21:42:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34deefc2016so28183285ab.2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695757367; x=1696362167; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ylRB+o0Qkrun1yi4fSnYM174Q1wG3Ph+hurLuy8H7Hg=;
 b=IU955mojU+7y9DDIcv/iQJ9EKOnbJNcVIl7detI6o5KYxJ53sFALqKdDDI0eC+0KvU
 sO7xJibbCpYRoeIi41Un/dAnl+6LsT1U6MYEXyXnAhq9oFDHQtwLfoqTYC1y9FM0kL63
 cbkovJ8z1Sj/ROYwQ+bIq14Duzm+N2HAvWZ3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695757367; x=1696362167;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ylRB+o0Qkrun1yi4fSnYM174Q1wG3Ph+hurLuy8H7Hg=;
 b=C2T456YTGTlOBgqsri3Agon0lSs4lYTpdblYdzVSCDN+q5afHggN36VYYYVjIA1iQh
 9XhWf8uydGl4VGgmJDzDCbXiZVeGlKQn6jojpZksH9dlv+O3q5cG/Nlolk3vrOPWBR0v
 IhrhyecOr9GecSxHURclCt92ROPekSCrf+EhhaKJWeR32WpDmCgRjOKXqTAinIct3Q+N
 G69ki6PqA1iqwaikGZB++RUJ6DeArJMp3N9g8W66JdPwsMbeLYpXOsqzd2qcr5ZZR8p7
 1p6s/bJyMemTXD6yST7Uv5aV5DdJ00DvoMb59l62aBOGuGtN0YtLpWcPL8supTcAr8Ti
 /gFg==
X-Gm-Message-State: AOJu0YyCNUEFDTxUKFToDRscu+2QGllpcRQDJCIC5eVX/iqaFHxUztdS
 1L/DPzXf8IxQf/6siCvJJeIT4g==
X-Google-Smtp-Source: AGHT+IFzCUeJ4+/f6cMQn/wpsFZyt5uO+MfysuCHFTtVfIOOSW4N6mcQ3ugSwBAMbKLYPMLI3Tso2g==
X-Received: by 2002:a05:6e02:1d0c:b0:351:50f1:1f98 with SMTP id
 i12-20020a056e021d0c00b0035150f11f98mr3806231ila.32.1695757367326; 
 Tue, 26 Sep 2023 12:42:47 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:1da0:a3ce:7aae:e9fa])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a056e02130600b0035134f1a240sm1961451ilr.86.2023.09.26.12.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 12:42:47 -0700 (PDT)
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
Subject: [PATCH v7 1/2] schemas: memory: Add ECC properties
Date: Tue, 26 Sep 2023 13:42:38 -0600
Message-ID: <20230926194242.2732127-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
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

Some memories provide ECC detection and/or correction. For software which
wants to check memory, it is helpful to see which regions provide this
feature.

Add this as a property of the /memory nodes, since it presumably follows
the hardware-level memory system.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v7:
- Drop unnecessary |
- Add a blank line between properties

Changes in v6:
- Use a number of bits instead of a string property
- Fix inidcates typo

Changes in v5:
- Redo to make this property specific to ECC
- Provide properties both for detection and correction

Changes in v3:
- Add new patch to update the /memory nodes

 dtschema/schemas/memory.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
index 1d74410..b3bf3c9 100644
--- a/dtschema/schemas/memory.yaml
+++ b/dtschema/schemas/memory.yaml
@@ -35,6 +35,19 @@ patternProperties:
           For the purpose of identification, each NUMA node is associated with
           a unique token known as a node id.
 
+      ecc-detection-bits:
+        default: 0
+        description: |
+          If present, this indicates the number of bits of memory error which
+          can be detected and reported by the Error-Correction Code (ECC) memory
+          subsystem (typically 0, 1 or 2).
+
+      ecc-correction-bits:
+        default: 0
+        description: |
+          If present, this indicates the number of bits of memory error which
+          can be corrected by the Error-Correction Code (ECC) memory subsystem
+          (typically 0, 1 or 2).
 
     required:
       - device_type
-- 
2.42.0.515.g380fc7ccd1-goog

