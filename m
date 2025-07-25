Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29D7C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 19:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 140C683987;
	Fri, 25 Jul 2025 21:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="anZaCA5j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DB07839C6; Fri, 25 Jul 2025 21:04:38 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13A57836A3
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 21:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-615a256240bso1121131eaf.3
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753470275; x=1754075075; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HhhzJyjeDTqg05j5hqNOpqsuuPoVgpRf8RFpjAaVVeg=;
 b=anZaCA5j6y45dKSIz9EKv+xkZTLoBsOvza7Fe5XoBE9BD2jHETOd9CkVwfxqIkHV/X
 EUHSi+XvEA9WZ8FwusMwWnPKZl5jxchzUD8Y/7D3XE18BKj8RP75xbJGsKNr5Gk/Y5hL
 JznZEj644Km6PXP98apFsMh6T69b8ditspa8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753470275; x=1754075075;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HhhzJyjeDTqg05j5hqNOpqsuuPoVgpRf8RFpjAaVVeg=;
 b=sGhrfNAdkKoFmoMc6tl/mFU0mj5fUWvNUjlooXN+cn9VY/+iolNeuV+fKKHMT7KAY5
 esikzLY9L5m8vtV5RXClKr/7slPfZLcEMQzTjSq0ejiynwiuxZzlFzCij6gD8wd1pzZQ
 Npg23eFC4H1mO/SKWV7kzDFm8gTGrz/G0fLAC4eZ6emJksdr3Ux2CD629BkSgtZm3HYH
 loWWi/LJYn3e+U5SgHVHnQWLgwtAGDUjTvHJ2yBqsFYZ01OfLaECHtrD8Bmny26dJIGV
 /N6XlV4cZJ3BndWToFqeBrtYc77bDPi1AHHqLc8VWP93/B3VzBmLk8P81DIWjZtTuNde
 bJaA==
X-Gm-Message-State: AOJu0Yy3j1qL8izifNPiRSwzmOmhtuFvxwAHJYSusYbGCdm8zs0/hShk
 rx9fdcVhiQ6FShr1I+9B29O2kDeNaBrou2bRZsG4aLvtyqwgxebhHqo4UXCUUFVImAubYWJljRA
 mjjLchlU=
X-Gm-Gg: ASbGncss0/udMOWLMv6y2boc5yp+uJ2N4rxjMB00ZvVgdPjmoiMhkNYgvksURf0CQYE
 t8mQQRLpZsJCpRaNwy+z6l+AKD6RCMHEMLaYFa3QPEvoqeOp5mR6mslmCz70DKoGGzbJZPU96uF
 QQzNqU4K5HY4c5dsLhuGUiU2yQcPB/1ET4BC6N7XHsmczuqFpj3bVhC8JhQRitv8ZpSt5LRypUW
 JGCWajPA5z/+pepaaKElYcGMiLucsh1hWR8W7m9Yp25zuxAsx7RKSmjNcBVZBMLSUvA+Fwcysxh
 dKlcHyaaNRrlM6q3M3evX21flqXIjtka4IVuhkb5NKMj1ultsR5tZqtDWwUmYXQbmMsnqxhWvpz
 wuRA9kZ8JwaQsWzEO+GpqmEvt+7mQYMuyJrt3yzDW3a+t7RKyfqiAEJaq7BE=
X-Google-Smtp-Source: AGHT+IGGgcN+vkRxny3/ZxUCygrXMfwS/TOYR6ZvMRyHzZm7jDkuRN+3bAiu1lG/xbtrj0sbHONUMQ==
X-Received: by 2002:a05:6820:1e85:b0:615:e20a:64cd with SMTP id
 006d021491bc7-6190ca41113mr1897633eaf.7.1753470274479; 
 Fri, 25 Jul 2025 12:04:34 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6191410b759sm78994eaf.30.2025.07.25.12.04.33
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 12:04:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Docker, CI: Update to latest Ubuntu and Dockerfile
Date: Fri, 25 Jul 2025 13:04:32 -0600
Message-ID: <20250725190432.4152488-1-trini@konsulko.com>
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

- Update to Ubuntu "Jammy" 20250714 tag
- Update to current Dockerfile which brings us QEMU 10.0.2 and newer
  coreboot and pulls in lz4 via the non-legacy package name.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml    | 2 +-
 .gitlab-ci.yml          | 2 +-
 tools/docker/Dockerfile | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index b1de8a6103ac..8209d2b329cb 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -2,7 +2,7 @@ variables:
   windows_vm: windows-2022
   ubuntu_vm: ubuntu-24.04
   macos_vm: macOS-14
-  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20250404-29Apr2025
+  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
   # denied" error when it tries to "useradd -m -u 1001 vsts_azpcontainer",
   # since our $(ci_runner_image) user is not root.
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index dd628fb1cfa7..85401d3e09b1 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -20,7 +20,7 @@ workflow:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20250404-29Apr2025
+image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index a83c80db496c..5b4c75f84005 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,7 +2,7 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
-FROM ubuntu:jammy-20250404
+FROM ubuntu:jammy-20250714
 LABEL org.opencontainers.image.authors="Tom Rini <trini@konsulko.com>"
 LABEL org.opencontainers.image.description=" This image is for building U-Boot inside a container"
 
-- 
2.43.0

