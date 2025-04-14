Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9FFC369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 22:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CFD682169;
	Tue, 15 Apr 2025 00:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q8AuiTp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BA02826AD; Tue, 15 Apr 2025 00:04:45 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C386C8215D
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 00:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2c873231e7bso3039837fac.3
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 15:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744668281; x=1745273081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mab9HF3F/Or9o3GAZWEEbxcoTBKVvGOcEtXVWoDbio0=;
 b=Q8AuiTp+/EfIX5O+mHLXcqurw63/qHIlI2ssiiO1OIqvktVGVWKwDW3+/qfWclTO2E
 IZpVXkmLTHOwsaIwe8Q43Z8MYkK/01CHLcqArwQKuXV6NoCB8zGiWTkg50EwxVCh1InR
 fbyZR8URN/hpJe1lFvAnVHAGT29XHprMYxtNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744668281; x=1745273081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mab9HF3F/Or9o3GAZWEEbxcoTBKVvGOcEtXVWoDbio0=;
 b=MPTY1v/jeGXwJ2j7aspwVULfdSIeZgBf8LyEiQHjcNZm2iFMaTdr+T70IrENJXWgs3
 wrcfNirTPhozdmGSND9kdCWWFn0xPUVLgEi7yC8Ex3g9eaWHNPjEoJlRpqqA+I4/+Xnz
 oDVIdRYOetk/fnEuCJPjpEXhXwUDRDO/Dujy+YQ5UXZwwFQOqaHTQQfVivcQdp7quHVK
 ik6r7WdkQgEZvGBaVg4W+PytuNOnAV3t0rrDmYAjPbtd4cVhRBrMTPGiMXnxx9wi0aKx
 dDwbwfAn3LeOOE/+tylsmX/n0IGi87AqvoMwN/slefWvToBtgSfnl/RGNPz5RI2s6l4V
 8aCw==
X-Gm-Message-State: AOJu0YzJTq29QtJlru3TrUjqcnD9xtoToppzsL4DmSNUajA9JP056Vk+
 49PIWNtowQRTdtdUKBxGofYRdXeyn5b/J6cTkFGpPAVRk/aaRk3ql2JqCEdGZJf2j6sVMc+Fb/p
 G
X-Gm-Gg: ASbGncuoRYQtOyV1ogZoQokebNnS56yLbnmtl+jYlDBA+a6sT0oxrhxOChGn5yTWG7d
 bg8CtxEl8b9qxJ8IEk6JkgDcjdfFB4Etvhz4Ng8Oqxc3mM2af4evikkb8FVgPrBr1Dple2Ac9Lb
 WJmXLKvdPoEi/vqWp4xzTF0jOl6SC+QQcbCSWbso+/NnSpHucZAkPt879fsVJdC1Whz4pOFc947
 nEiTMzl2LC59KDI40jkm76J8fK3CCW2/TuOljIjK9O0v+gZQe+EbGHT+/KZgGhYjeddjG+qL+XI
 6HzCl0+aGR4ALZDGbdFFURTiwz86THTwmLZ0s+RGFb8muo38HQbTiPUF5kid6KvQeaEcbCAmMvA
 YMglQ/m7nnKAxLiQ=
X-Google-Smtp-Source: AGHT+IEpGUw6sMnXdNkOLx4cu55Xr1FXh2X+Vg/QX6Q3AVROX16YSJvjZ0V3Hg1iBBvLdM67tY64mw==
X-Received: by 2002:a05:6870:71c6:b0:2c1:6663:f603 with SMTP id
 586e51a60fabf-2d0d5d66c38mr7756180fac.19.1744668281482; 
 Mon, 14 Apr 2025 15:04:41 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d0969af774sm2557481fac.21.2025.04.14.15.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 15:04:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH] Revert "CI: Disable evb-ast2600"
Date: Mon, 14 Apr 2025 16:04:39 -0600
Message-ID: <20250414220439.529572-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Upstream developers have been unable to replicate this failure exactly.
Furthermore, with commit 8c98b57d72d5 ('Merge patch series "Static
initcalls"') we have now replaced the part of the U-Boot code which the
platform was hanging in when I was debugging. Moving forward, if we have
a failure again the next steps are to upgrade QEMU (which should be done
regardless).

This reverts commit 8a2cf6307a2ccc09c39dde486b6d9375b78c82c2.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>
---
 .azure-pipelines.yml | 4 ++++
 .gitlab-ci.yml       | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index cb787d32f142..24b6661c9c94 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -424,6 +424,10 @@ stages:
           TEST_PY_BD: "evb-ast2500"
           TEST_PY_ID: "--id qemu"
           TEST_PY_TEST_SPEC: "not sleep"
+        evb_ast2600:
+          TEST_PY_BD: "evb-ast2600"
+          TEST_PY_ID: "--id qemu"
+          TEST_PY_TEST_SPEC: "not sleep"
         vexpress_ca9x4:
           TEST_PY_BD: "vexpress_ca9x4"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5f3418e482fe..aa15e009b39e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -331,6 +331,13 @@ evb-ast2500 test.py:
     TEST_PY_ID: "--id qemu"
   <<: *buildman_and_testpy_dfn
 
+evb-ast2600 test.py:
+  variables:
+    TEST_PY_BD: "evb-ast2600"
+    TEST_PY_TEST_SPEC: "not sleep"
+    TEST_PY_ID: "--id qemu"
+  <<: *buildman_and_testpy_dfn
+
 sandbox_flattree test.py:
   tags:
     - ${DEFAULT_AMD64_TAG}
-- 
2.43.0

