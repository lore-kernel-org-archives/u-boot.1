Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34332E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 19:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74FF1895E6;
	Sun,  8 Dec 2024 20:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="no7xLaPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAC45895DA; Sun,  8 Dec 2024 20:08:05 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76088894AE
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 20:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6d8918ec243so39183406d6.1
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 11:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733684882; x=1734289682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IUtd5i/t/7Xt6Go7yYLDif3wjjGIrQO8/pcCIp7Ya3g=;
 b=no7xLaPWVX4o4dvmqAxLK2Z2zrL2/lZyFY/xF0poXx4G9EKh/H7ar3rcFkbCHHOPxJ
 H7FKNzU8P5GUidVKzmDAQzd7nDYiqjHJdlnnKUrPlM8IadCmZWpQ63vZD4umS5V5k8/D
 9GT68OrldvuKCIiK7wVP/WCaCBgze3GJL1/wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733684882; x=1734289682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IUtd5i/t/7Xt6Go7yYLDif3wjjGIrQO8/pcCIp7Ya3g=;
 b=gti3N2esg4cCvqnus0fYs/hWkzlgkCANnlamw3hB3KSDvlYmcLEneKC6WkPmWbBp4D
 Bukuk68gz4GvbEmIbltmIbSf5jlmkLsHQwLXvatk4CoHy7qtw0pYCwAg/bPWWy39m2cH
 hR0kwRzaWjG1+k0UYxB/mHgStVAXfEDl3dXbBqVhXKPTbDn7mKlScSMPWqklFoWF6qAo
 zzNElMIXwUzCDEsPLy1hSAHsLxNrxNoExYa2C6b2eX5KbCVRv+IHOORNd07HjxnOCw8Y
 JZEwDieGgZyWuwVUoqatLV4C+6bZU7I+9HTePwTxQp4MtRPoJ7p8RAh4U9tOICbhRX8x
 6Mow==
X-Gm-Message-State: AOJu0Yx5uq4PKXZ4g8pQJCjzR2nUPKPzWxEKJJ5zZF+D7GIjqvMo9Qel
 uMEY9k0sFVy8wPUb+BZuOy7vMyFRo8LPEQU1b0CWH+fFrdmuyR8+aT5SrxgGg4MRc3JgKGxJIU3
 fTww=
X-Gm-Gg: ASbGncsq1zEBxwb8xEmuF8upQKmB17LZacjXNTT06MVbCFdEI4xGYKpvaaY5xZvDRxR
 BHKhwRK21cFQSszUPaf5mNSiVU/3XQK3rGxu0PVwDZjMw471Avy2CZ6Y/ZPfSuO+1WHBE0OQ0Iq
 XfMDzthcVQh6Q/hjAiCnZnrHpEXieC7FyVueWjcqBw+Z5opXzWrjNEtk5SVxZz33GqF6yAQrZqu
 OxV8iTZw1wsvsBls4Wnr7mbbnLFeQdeloer/1rHqnFYdysT/dv6GmAena2NqlpXPXEyEPSzkA==
X-Google-Smtp-Source: AGHT+IE4e+TWZt5/NEOJ+OGhIWyGzPFhgpcs8+ADh0vGd82U9gh/pAlyyheFVO1UX89dNzZUOgc0Wg==
X-Received: by 2002:a05:6214:21ac:b0:6d8:a32e:8430 with SMTP id
 6a1803df08f44-6d8e70a4538mr176198336d6.8.1733684882293; 
 Sun, 08 Dec 2024 11:08:02 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da66ddeasm41154076d6.25.2024.12.08.11.08.01
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 11:08:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 9/9] docker: Update to latest "Jammy" tag
Date: Sun,  8 Dec 2024 11:07:32 -0600
Message-ID: <20241208190741.4192601-10-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208190741.4192601-1-trini@konsulko.com>
References: <20241208190741.4192601-1-trini@konsulko.com>
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

Bring us up to the current Ubuntu "Jammy" tag.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml    | 2 +-
 .gitlab-ci.yml          | 2 +-
 tools/docker/Dockerfile | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index c577a724c82b..df3f82074af0 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -2,7 +2,7 @@ variables:
   windows_vm: windows-2022
   ubuntu_vm: ubuntu-24.04
   macos_vm: macOS-14
-  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20240808-03Dec2024
+  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20240911.1-08Dec2024
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
   # denied" error when it tries to "useradd -m -u 1001 vsts_azpcontainer",
   # since our $(ci_runner_image) user is not root.
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 696d3cb1bd74..a7bae035319c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -19,7 +19,7 @@ workflow:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240808-03Dec2024
+image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240911.1-08Dec2024
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 348605a2b6a3..d2848ab85f35 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,7 +2,7 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
-FROM ubuntu:jammy-20240808
+FROM ubuntu:jammy-20240911.1
 LABEL org.opencontainers.image.authors="Tom Rini <trini@konsulko.com>"
 LABEL org.opencontainers.image.description=" This image is for building U-Boot inside a container"
 
-- 
2.43.0

