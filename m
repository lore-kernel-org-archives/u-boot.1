Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9069CCF9EA
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 04:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 226F283655;
	Thu, 30 Oct 2025 05:36:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KGblMnID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9944E836D1; Thu, 30 Oct 2025 05:36:04 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7996F835FE
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 05:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3d47192e99bso1076899fac.0
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 21:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761798961; x=1762403761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=tYwrXNbR2JzFR4RLeJyi4SmnBelwtI1C83QAasAMp6E=;
 b=KGblMnIDCBGlWI73UKu0RxHPQDl8HKaM4wKj7eEdHiWNDdhSroT40z1WZt85PvdmGg
 c2DHQPTamS7mQ7q3uly7n94gFsQXON4brha8mkZHxJf6x5f0CeQBZbqH64cewITWkO0S
 OmO4q0OJ/qtyLcaWNj0hrn2f0YGcMxdCDnBb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761798961; x=1762403761;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tYwrXNbR2JzFR4RLeJyi4SmnBelwtI1C83QAasAMp6E=;
 b=AQxHP3Fg17tZbdfqyMDRi8edIvBQDVgXs1TE+Fg1gcYUdc5jal7BGYsCChVBPt5maE
 AeLuRteqAd5hu3o3hpWyNhJRGi6ah6kcmjDv3lqil1CxfvxnKmvtwVqpPb8/pVZSXC0z
 LYj6xk14yWLX3Pqclsz5j9LnDou1BiMa0u1fsPRNYALRzF3JY0PCegnI/wagGMlerPTg
 8nITIbMixZidHEdUlNwMahhmtgWNs+errEHS5yTvww1w36XIKx44v8iCBWz8wjSwmpq5
 nmA8Jk6vgprj4wIx4JwozJO/oHA4QhJUMKzC5/QLm5Wb2OILnaI5dRPUURobJ68Y94JB
 +A5g==
X-Gm-Message-State: AOJu0YzJN8hfQgYn/hcjlxGhcx9BVhRNbl6MKXOcnBavd+LevtpsbKj2
 vzBBUy+v/9N+51eegdLcIn2cYd3cg1aSrnFiSXz2q0vkLog6a5Xt8GizfovJXJ/z4+z6gKdzM80
 LNlRlqVEyBQ==
X-Gm-Gg: ASbGnctyoQ6aA/uFeTVeC9BdCbpQgAj4jEOzn8hZ6ufsVrEuJ2h71XmfjpyYwpdSm/2
 2drwajIrxGZAMVrtFIoXwDrqHQFnPneBvnULf4322Ze8I1ouWZ/IQRMpj72oUupYWlSlAkRSA+Q
 bIGeaDt91Ivn6RdRkj4IcpYKuD7DI9rEWTRaNdunreqvBymezQUlcgTQnzDZrySDXguZfIqL09e
 oMEt7S9SMckgLflxKfR17EwnmQlH7FpWWsHGf6QGSvv4H22C1zCHA6wcFsOdOEVaw8H6p8eerQS
 tqevOSoXXc3Qim64wgMhJt/heQ7BhpGUMdJshmjx7UupxmruIpnEf0bILcxdcggoyQkjWP+Tsiw
 KNX3mfXrggZlFTPd2BVKtbVZr7USWOZuNJ/49Ia53G5A8wqRMmroupXsFZfP8lQ2xf9QENnHAlQ
 W1ci+YCC1h+NE7dUXkn189ePWLeqVEyvEe4asPY7y8waT8
X-Google-Smtp-Source: AGHT+IGZhmF6F+AAfbjEA6yAh97LNoy4FqWFc+y8ZUJaisj0uYwEAIfe/BEhadBfhBbj2kemtM2Vhg==
X-Received: by 2002:a05:6870:7024:b0:3cd:c7ed:3377 with SMTP id
 586e51a60fabf-3d8a285317emr1003038fac.9.1761798960936; 
 Wed, 29 Oct 2025 21:36:00 -0700 (PDT)
Received: from bill-the-cat.k.g (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2f0bf4sm4132107eaf.18.2025.10.29.21.35.59
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 21:35:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Gitlab CI: Rework our tag usage again
Date: Wed, 29 Oct 2025 22:35:58 -0600
Message-ID: <20251030043558.2620797-1-trini@konsulko.com>
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

Now that we've had jobs running on both amd64 and arm64 hosts for a
while, we have enough data to look at usage and findings. For the world
build job, make use of the new DEFAULT_FAST_TAG and only build it once,
on either amd64 or arm64 as we don't run in to host specific results
there. For sandbox, continue to build on both arm64 and amd64 hosts as
we can find host specific breakage that way. Remove the mistaken
restriction on sandbox64_lwip.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci.yml | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 73ff975e5746..a9a57f1d58e7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -2,10 +2,8 @@
 
 variables:
   DEFAULT_ALL_TAG: "all"
-  DEFAULT_ARM64_TAG: "arm64"
-  DEFAULT_FAST_ARM64_TAG: "fast arm64"
   DEFAULT_AMD64_TAG: "amd64"
-  DEFAULT_FAST_AMD64_TAG: "fast amd64"
+  DEFAULT_FAST_TAG: "fast"
   MIRROR_DOCKER: docker.io
   SJG_LAB: ""
   PLATFORM: linux/amd64,linux/arm64
@@ -134,12 +132,8 @@ stages:
 build all platforms in a single job:
   stage: world build
   dependencies: []
-  parallel:
-    matrix:
-      - HOST: "fast arm64"
-      - HOST: "fast amd64"
   tags:
-    - ${HOST}
+    - ${DEFAULT_FAST_TAG}
   script:
     # Prepare python environment
     - python3 -m venv /tmp/venv;
@@ -309,12 +303,6 @@ sandbox64 with clang test.py:
   <<: *buildman_and_testpy_dfn
 
 sandbox64_lwip test.py:
-  parallel:
-    matrix:
-      - HOST: "arm64"
-      - HOST: "amd64"
-  tags:
-    - ${HOST}
   variables:
     TEST_PY_BD: "sandbox64_lwip"
   <<: *buildman_and_testpy_dfn
@@ -361,8 +349,6 @@ evb-ast2500 test.py:
   <<: *buildman_and_testpy_dfn
 
 sandbox_flattree test.py:
-  tags:
-    - ${DEFAULT_AMD64_TAG}
   variables:
     TEST_PY_BD: "sandbox_flattree"
   <<: *buildman_and_testpy_dfn
-- 
2.43.0

