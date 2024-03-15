Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5530BC54E5D
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 02:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C723F87F87;
	Fri, 15 Mar 2024 03:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KZZlbwXa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 894D087F74; Fri, 15 Mar 2024 03:36:48 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67C818753A
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 03:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-690c5d7851dso7438726d6.0
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 19:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710470205; x=1711075005; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xQpCY2gEwvh4waWTKovHEZ99q7fYWbzHELoXJvasVn4=;
 b=KZZlbwXaEv8q/bKNK6UYsQODHAghOU/dMZR8focJqHwyg1an2v5yi21ATcPjQjuwmX
 GaYoyzFJa9Ox4ncmRbZiIYw88ji0VObptmrulnE8qiV8xX6UgSbOktV/fzjU7HdRDDQR
 Bj1fdjguyjUZT9loUO0a51DkInxzbW7zYgHMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710470205; x=1711075005;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xQpCY2gEwvh4waWTKovHEZ99q7fYWbzHELoXJvasVn4=;
 b=USJTWw2Ai/Q2/N3+fsYrN9B8EVFe1YgkIx28XboP1aA0XwR7LHxemPlila7oG/HZVv
 JGT6K4kkqT2usBWxweSITJh/n80PbMs0B+hW8Rxovf7ZJB8qmsSvhr6QOlAKmGmKs8KA
 u8Be4wI2HSN4BypLT2yP8g16YppoK6Qs4Obm/cVqVM5FrYIHGrMt6mqRb1HxKE+2T6jV
 4SXVBJUB6bRiyJwjGkbOK3qo73X3Hy7TzcRZEQ0UxCKHUg0pfWV2uu9bmcgHMGrI8uoT
 382CFe04VvUUvJO5mgfcmDTji56Lidw99s1xNZZ2QmCPGPQFze1uBBw9HQ8CHTETYbFC
 82Eg==
X-Gm-Message-State: AOJu0Yx6LLTb6C/3T0z4SmEAzUl4+jDwTj+7o+MaOwKELZzRDWMPDdQq
 nM7ByS3J5hLRokjdijB49zYUH41fdY9if0+NuMWAhGL0NGgPfw558maKTko7H6XlQH6WAS3D5kk
 G
X-Google-Smtp-Source: AGHT+IHZJCm6B0uwnzLPFXaH4/kHq7b+IBbNmka1nWWvZo4VJgvEtQ39gAbfnu/FG/7uhRjRbctzSQ==
X-Received: by 2002:a0c:e102:0:b0:690:cf9c:f568 with SMTP id
 w2-20020a0ce102000000b00690cf9cf568mr3710945qvk.14.1710470204698; 
 Thu, 14 Mar 2024 19:36:44 -0700 (PDT)
Received: from bill-the-cat..
 (2603-6081-7b00-007f-0000-0000-0000-1004.res6.spectrum.com.
 [2603:6081:7b00:7f::1004]) by smtp.gmail.com with ESMTPSA id
 gg8-20020a056214252800b00690befbe5a5sm1314014qvb.74.2024.03.14.19.36.43
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 19:36:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: Move to latest container image
Date: Thu, 14 Mar 2024 22:36:43 -0400
Message-Id: <20240315023643.728195-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

This moves us to our latest container image, which is now based on the
current "Jammy" tag.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml    | 2 +-
 .gitlab-ci.yml          | 2 +-
 tools/docker/Dockerfile | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index f8a3a9a1c8c5..27f69583c655 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -2,7 +2,7 @@ variables:
   windows_vm: windows-2019
   ubuntu_vm: ubuntu-22.04
   macos_vm: macOS-12
-  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20240125-12Feb2024
+  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar2024
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
   # denied" error when it tries to "useradd -m -u 1001 vsts_azpcontainer",
   # since our $(ci_runner_image) user is not root.
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6930b4158e14..165f765a8332 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -10,7 +10,7 @@ default:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240125-12Feb2024
+image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240227-14Mar2024
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 6d9931be7a81..cda87354566d 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,7 +2,7 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
-FROM ubuntu:jammy-20240125
+FROM ubuntu:jammy-20240227
 MAINTAINER Tom Rini <trini@konsulko.com>
 LABEL Description=" This image is for building U-Boot inside a container"
 
-- 
2.34.1

