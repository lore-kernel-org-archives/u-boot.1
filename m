Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674C3C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 20:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8182B878DA;
	Wed, 17 Jan 2024 21:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KgtmEJM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F9698794F; Wed, 17 Jan 2024 21:05:22 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A8E86DC3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 21:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-783293278adso684729285a.3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 12:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705521919; x=1706126719; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=t9G48ByGcfES3W/jqYsPQakn2bkOzgQ5YNNhr3T3UGQ=;
 b=KgtmEJM4ka0vKXfHzDRboKw+GxW5WksdyQ2s6cvz52EI3B5OlTtdw4nVX9ZfSmps0j
 fr+evkQcLtP5Hmus3hkJdV5mO3alXXpap8eWMsDccxaF2SZ1P4k4f2LQ08ahqSjN1TPU
 bLYsMZhM9nDI+IeXJlGXAT6RMdzT59lPChX7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705521919; x=1706126719;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t9G48ByGcfES3W/jqYsPQakn2bkOzgQ5YNNhr3T3UGQ=;
 b=tIvvmrRcHvcMkS7C6cb+HM1Y/I1xhaSR3blPMSM83j4UpnDnsGKDuOK0PaYc2TGjsF
 PWKpx3WaSI0YgYP0PsQxROlV/2d9Hu2gDZjjck7N9oLr0TtAHO9ZvUEtyc/4GHfP/zsH
 8i73ja8xYPeyo7FLW6o+qetc7qf0eyTtviHrFeqPxqQPMZ+4wOdWHXMwSvarQ7Lh1Jjl
 djgAOiYrkN8X7UKmGmTPEHFmpe2OFYhQY0LIbQ6dIxvjnpM1McNyUb1QMR8u/wbSjcyF
 khmG6z9yLC2Aic/Xgf5cmL27Z75RATZGDquuUKKI5Mfv6LBlTyULIGXvNUf6xPZa8TWU
 lRPw==
X-Gm-Message-State: AOJu0Yz6v/PDmPfCdoPizj6b/zOzG9gBcXjreX1dIK+tkCxLXfu7Ttpe
 SdBnwLUztFiEGwjDTyS2YCalyrI4l8rOMo3Zuv5pLK/ai1Q=
X-Google-Smtp-Source: AGHT+IFAilT/xDxGxGLtbuJ8QpfZM000eZ/Hu4e12c7WD67ncuJx/Ygg0dfpZy08KkJT1cXOH6MvrQ==
X-Received: by 2002:a05:620a:2491:b0:783:32e8:9538 with SMTP id
 i17-20020a05620a249100b0078332e89538mr12760733qkn.145.1705521918843; 
 Wed, 17 Jan 2024 12:05:18 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 z18-20020a05620a08d200b007834386eeaesm4696253qkz.33.2024.01.17.12.05.11
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 12:05:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: Move to latest Ubuntu "Jammy" tag
Date: Wed, 17 Jan 2024 15:04:50 -0500
Message-Id: <20240117200450.1880105-1-trini@konsulko.com>
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

Move to the latest "Jammy" tag from Ubuntu.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml    | 2 +-
 .gitlab-ci.yml          | 2 +-
 tools/docker/Dockerfile | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index b9d6aa98a0b9..e2646783ee62 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -2,7 +2,7 @@ variables:
   windows_vm: windows-2019
   ubuntu_vm: ubuntu-22.04
   macos_vm: macOS-12
-  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20230804-25Aug2023
+  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20240111-17Jan2024
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
   # denied" error when it tries to "useradd -m -u 1001 vsts_azpcontainer",
   # since our $(ci_runner_image) user is not root.
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index fbf99f0322a7..278a2e2bbf31 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -10,7 +10,7 @@ default:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20230804-25Aug2023
+image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240111-17Jan2024
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 72ffb99a0c15..0e2dd0a6a946 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,7 +2,7 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
-FROM ubuntu:jammy-20230804
+FROM ubuntu:jammy-20240111
 MAINTAINER Tom Rini <trini@konsulko.com>
 LABEL Description=" This image is for building U-Boot inside a container"
 
-- 
2.34.1

