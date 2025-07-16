Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42F7C83F17
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 00:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B02E483102;
	Wed, 16 Jul 2025 02:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BpyvX7dy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 861A783123; Wed, 16 Jul 2025 02:15:47 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F0F7830C8
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 02:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72c172f1de1so2924885a34.3
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752624942; x=1753229742; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vyiN4ya9eqTbVw/2TOFhzGFzV++Q4XT0W60XLnlc39k=;
 b=BpyvX7dyOiuN5vrfVeXHphhRdnn45Wat6b9mFstDjqxbSkCoVPvhIQRrIIXH9XX67i
 UsbTAVvpuZ97zGo029tWfDvHXmcFqlsUng3EYHMU75BduV9R4WXgcnUBlED4NZYL4FdV
 K2yXBxVvH/UihMKormXehHpNiC4RWq4a1KeFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752624942; x=1753229742;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vyiN4ya9eqTbVw/2TOFhzGFzV++Q4XT0W60XLnlc39k=;
 b=bS6NLVuTjNbdbfQQ83Gc+kOj6ZVWuYogmn+aJATHGUYc3P6ezhM5w+6ZRc1DnoJ6Q0
 ZyL109SduPnTvh2hN+WYbPmZlhYyt5ze1ues4qz8wYGIu3TKgVuLIvan5eT2OiBR+qzO
 q2MEevoDa3746RMDChG+HqPjXk1x1KzI87yAFPPnhjb1MoxBFGMLWNSqt3SIXF7qk7jp
 bcg2sHXZ64zn2QDnVbk/qaTkR6FELxFchulNn/Dtn5EbOSWRtBBg/wFDpDCkNtLAuaWt
 6uYKuBRx9tIgD2qq513QDeOiZsjcDPPVRShIOlmTidxknYF1bA0FPLJiZOKYKf9oxJe1
 Cg4A==
X-Gm-Message-State: AOJu0YyGytR7TRps9RaSsHnTxx6BFDsL8wXzdF0v384GLFTXX9mkHTOt
 TVjRSd4RPi1xv0BwKvNw4CZY5VQ8MjEgZz34j1P2IAxybbKrDyp47Qkdo8FFa6/TutEBXBGAKB6
 d15Lv6Io=
X-Gm-Gg: ASbGncsdO2/+UccUDbxDbiMeMf3vy2lOaMUmY1D8jrtEgCWwZ59LWdn5nSwiEEFnd/s
 Hw5kcgofAXXau8cC4xJbutTqBbXC7Srr5XdTh2cHiWBeaxf+EjGL79J+JNDnle3rjHyBGUT4jim
 3rT3yBjw4hmsJUo8WXyRRKAs1GipJy61vGmOtW3J+z7NsKJ023UbNQMODgISDhDwNTXm8Nf9HJB
 E+ZPwFKSQjX9DDo5z14M1o+pcuzsCFrl+ApaTBCpj/SYINuJwsEZiq0aMGDWXnPF3j5evFyVCyY
 jH22JPIVUcoPVwQehjwvBbJa6rWWc/60saH3lbkOVgdTnDJhjMktLz6OCOW/FFomr1SCAFzUsGp
 fKnK9TC7+hlFGepqZXPF+4L3OJhj89qJu1gD6SM5fnyk8uMb41U7fFDFwkTQ=
X-Google-Smtp-Source: AGHT+IH3qijKUJT+GxZ24pW1/WrN6wci8c8etWH7racbVwi2X6PGhPaWxwc6luJKn3rXni/UMczgXw==
X-Received: by 2002:a05:6830:2b23:b0:731:cac7:3634 with SMTP id
 46e09a7af769-73e661145a2mr564403a34.3.1752624941972; 
 Tue, 15 Jul 2025 17:15:41 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf10adfa9sm2543607a34.30.2025.07.15.17.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 17:15:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>
Subject: [PATCH 1/3] CI: Disable sifive_unleashed_sdcard QEMU testing
Date: Tue, 15 Jul 2025 18:15:37 -0600
Message-ID: <20250716001539.2483390-1-trini@konsulko.com>
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

Changes in upstream QEMU have lead to this specific configuration of the
sifive_unleashed platform not working in QEMU. Until this can be
root caused and resolved, disable this test for now.

Link: https://gitlab.com/qemu-project/qemu/-/issues/2945
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atishp@atishpatra.org>
---
 .azure-pipelines.yml |  9 +++++----
 .gitlab-ci.yml       | 13 +++++++------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index b3fd4ceef135..e98882ca8650 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -531,10 +531,11 @@ stages:
           TEST_PY_BD: "r2dplus"
           TEST_PY_ID: "--id tulip_qemu"
           TEST_PY_TEST_SPEC: "not sleep"
-        sifive_unleashed_sdcard:
-          TEST_PY_BD: "sifive_unleashed"
-          TEST_PY_ID: "--id sdcard_qemu"
-          TEST_PY_TEST_SPEC: "not sleep"
+# This is broken upsteam: https://gitlab.com/qemu-project/qemu/-/issues/2945
+#        sifive_unleashed_sdcard:
+#          TEST_PY_BD: "sifive_unleashed"
+#          TEST_PY_ID: "--id sdcard_qemu"
+#          TEST_PY_TEST_SPEC: "not sleep"
         sifive_unleashed_spi-nor:
           TEST_PY_BD: "sifive_unleashed"
           TEST_PY_ID: "--id spi-nor_qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2dfeda9985d7..dd628fb1cfa7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -519,12 +519,13 @@ r2dplus_tulip test.py:
     TEST_PY_ID: "--id tulip_qemu"
   <<: *buildman_and_testpy_dfn
 
-sifive_unleashed_sdcard test.py:
-  variables:
-    TEST_PY_BD: "sifive_unleashed"
-    TEST_PY_TEST_SPEC: "not sleep"
-    TEST_PY_ID: "--id sdcard_qemu"
-  <<: *buildman_and_testpy_dfn
+# This is broken upsteam: https://gitlab.com/qemu-project/qemu/-/issues/2945
+#sifive_unleashed_sdcard test.py:
+#  variables:
+#    TEST_PY_BD: "sifive_unleashed"
+#    TEST_PY_TEST_SPEC: "not sleep"
+#    TEST_PY_ID: "--id sdcard_qemu"
+#  <<: *buildman_and_testpy_dfn
 
 sifive_unleashed_spi-nor test.py:
   variables:
-- 
2.43.0

