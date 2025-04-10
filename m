Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE34C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 15:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92B3683D03;
	Thu, 10 Apr 2025 17:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iXVlJEvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC35783B8F; Thu, 10 Apr 2025 17:15:12 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFF9083D10
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 17:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3fe9fe62295so281096b6e.0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 08:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744298107; x=1744902907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BXnFVfaUbdbD5wWxtvHsN8/RG2OXYvQw6/7qRmc2M+k=;
 b=iXVlJEvjF6QiRwV9LcfXytSI/dHoriuCcplJYmkGfXzfNzL0D6Vf1FttjnouwPdHTQ
 VQAetrIm2DW16atwXwrAnX09CyFW8NJlIl7AsENEYVHViVPLKXmN8RVAi1+Gudsu+UT3
 6QoICKqRyPwSLodbkd9Wt+opHlsVMgonLJ2Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744298107; x=1744902907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BXnFVfaUbdbD5wWxtvHsN8/RG2OXYvQw6/7qRmc2M+k=;
 b=Rl2kYcPd5aRzchkOlzetRmHta0bjDnRS5RWq/fojUH0wpYdANW6v1nUQpoQG73wlBl
 G8iaEH6jMWEwTfsO9kqxY8pb4ttzcoL9ULJ+Pj1sMLkADgj6qYwERrxJSVmU6Wmx0Z20
 1yK+BixQHOpkcAvaTNAW8uBLgWervW8AbzlTCf6ZyGmoX3ddLBdAIdGqmFh2mJXPKfpq
 43m8WwZ8u1mqT/aoN/8CeNuE1eF7ocJMX2YqyQ9l3lgpE4KMQTz9QDnGDb2wSOyFE5UU
 5lKNGEDvffNlwmgETlAl/+w5l8JipwM9rlaSoranblHAmIdpMKQmfDwpRI5lo8phu3tX
 pGMA==
X-Gm-Message-State: AOJu0YwCWY5t5ZbmtfvMQjdc44TIcvFExIFIrLZY3k0VMar4/E2x0YTV
 CXQbpxlbkORVUv+0dh58CshtHqXyRlE7pnHXDVSzc66s1ZlRs+aSeMUS+WgBLmkUh4P5+kVK+UC
 X
X-Gm-Gg: ASbGncuHq+gtRb0jR4yogfUKPXR/F/ydpvgqxUIzAx3CnbLIO9/X7WWaL4oZn9UdAIJ
 xBnInMfnYBruc6ZfF5Bi+39Uuf+sFL605tVhtu0IVkrF35gO/Ato3gQbm3Yrr0xuhNETWCga7bB
 KrnkAVMDxANycFtZ5G024NYyDpIN/xIJEoXAy6cB66r60Cs03ESxJjDVF+Q6PQ9vkbtDuyzpIfw
 JIuMMcOnm8mvNsWx3A5RYOaIJygmF7sv0X74jeGGl+DbGLifZE1TCbNm1VVfyx1mR3gYhwhNeRO
 ybQtCGB14TPndzyMbNas6XtwtzZEnUcLxaSkEU7GwblK4Adgtxi+hWZBdiFFfLVrDQd4j7wNWcs
 NOSKJ
X-Google-Smtp-Source: AGHT+IGbtheJug1T5MEUcZkfPdVfZmMKx5Ohaa6KnIV+YFaWj/UQMEdubihMTWimivLIb/+RDQ73nw==
X-Received: by 2002:a05:6808:1244:b0:3f8:93c5:6d98 with SMTP id
 5614622812f47-4007bcc3f79mr2147140b6e.11.1744298107407; 
 Thu, 10 Apr 2025 08:15:07 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-400762d5603sm572656b6e.26.2025.04.10.08.15.06
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 08:15:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: Move to latest container images
Date: Thu, 10 Apr 2025 09:15:05 -0600
Message-ID: <20250410151505.2596608-1-trini@konsulko.com>
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

- Bump up "Jammy" tag to jammy-20250404
- Include most recent changes to the Dockerfile itself

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml    | 2 +-
 .gitlab-ci.yml          | 2 +-
 tools/docker/Dockerfile | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 593e90c7f790..ac07d87cca1a 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -2,7 +2,7 @@ variables:
   windows_vm: windows-2022
   ubuntu_vm: ubuntu-24.04
   macos_vm: macOS-14
-  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20240911.1-28Jan2025
+  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20250404-10Apr2025
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
   # denied" error when it tries to "useradd -m -u 1001 vsts_azpcontainer",
   # since our $(ci_runner_image) user is not root.
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index df793e50e03f..e54bdd6c4bec 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -20,7 +20,7 @@ workflow:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240911.1-28Jan2025
+image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20250404-10Apr2025
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index c8a39ac6a168..589397bc1a23 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,7 +2,7 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
-FROM ubuntu:jammy-20240911.1
+FROM ubuntu:jammy-20250404
 LABEL org.opencontainers.image.authors="Tom Rini <trini@konsulko.com>"
 LABEL org.opencontainers.image.description=" This image is for building U-Boot inside a container"
 
-- 
2.43.0

