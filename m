Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4DFC3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 17:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7799486699;
	Fri, 25 Aug 2023 19:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jGYZ/Yoh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91EBF86AAF; Fri, 25 Aug 2023 19:21:33 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D02E986963
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 19:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5922b96c5fcso14168627b3.0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692984089; x=1693588889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6PNFmI/ffnIA3is8uB9PcRLFQTcMNjx7mKrA1/916Fg=;
 b=jGYZ/YohyLRkkp1aRSTSlku91TjrMOmkhWUpNXuCYjoilJUNUyj9OB/4rhlvuSz8KG
 HxQQFhmcuW3HiRpPIQYOeUAMkYt1v2xwViTc2bFzPzGreQFIuNXIix4CYnxZKayv2nsf
 PaZKkDnOtguhsjh/oINJaAHnAz0NYA2NN2jPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692984089; x=1693588889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6PNFmI/ffnIA3is8uB9PcRLFQTcMNjx7mKrA1/916Fg=;
 b=QJ+MBAIGjxtoEZl9Z7s5BMuYOiSikVzBKRM3WnadZxSSRZtJpRM8uNHTsWFfpeEgfb
 /KGjr/0TNgTffP9+ki8XliS4vORqX0CXAiVpjG4ZKA4J/pnHEpqepFkwUf6lc0/3tzQ+
 RRu0DRIUCMEQJQxvcZncHXne/1XUgIJzbuv/mgPWdpoiDvPKS2b0DMyCoPA9dIdVUVkc
 SGOLcvzJObwkXYi4ubuu2E7qW3utrQJ1Mx5Lfb8JSn8cyqAEN0mx55oTgz1i8yvn2S1A
 3dO6UnBzTdMH66RCeL55YobYyfFVd7pUpZ/9eTmldnE/fdlOyUmMWuX/FxuY7/b+vuRs
 pWxg==
X-Gm-Message-State: AOJu0YzZEScgK9T2BZJes6AkdqRifEGP/bM83oKbHkQ9tiAhz2G8hrhv
 7hdb8J3FusFgQlJjPszSntHVVPDkfVhOw0Jsi++oYA==
X-Google-Smtp-Source: AGHT+IHjLA991n/UducO/n9vm/N79hl6chQo9FWZAJLIO6hLxXgt4t5XIcXBq4xt2qIYtbsHfi4zmw==
X-Received: by 2002:a0d:ea95:0:b0:579:f163:dc2f with SMTP id
 t143-20020a0dea95000000b00579f163dc2fmr20187696ywe.3.1692984089321; 
 Fri, 25 Aug 2023 10:21:29 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-fcb7-366a-fd11-1c19.res6.spectrum.com.
 [2603:6081:7b00:6400:fcb7:366a:fd11:1c19])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a0dc302000000b0057a0e5b18e0sm590469ywd.142.2023.08.25.10.21.28
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 10:21:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] CI: Move to latest Ubuntu "Jammy" tag
Date: Fri, 25 Aug 2023 13:21:27 -0400
Message-Id: <20230825172127.3406461-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825172127.3406461-1-trini@konsulko.com>
References: <20230825172127.3406461-1-trini@konsulko.com>
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
index 711b067c1f31..b9dce3b1cadf 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -2,7 +2,7 @@ variables:
   windows_vm: windows-2019
   ubuntu_vm: ubuntu-22.04
   macos_vm: macOS-12
-  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20230624-20Jul2023
+  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20230804-24Aug2023
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
   # denied" error when it tries to "useradd -m -u 1001 vsts_azpcontainer",
   # since our $(ci_runner_image) user is not root.
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index aff6a5c2dce1..09b95fce41af 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -10,7 +10,7 @@ default:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20230624-20Jul2023
+image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20230804-24Aug2023
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 93fe8c613244..9670f04eb5ee 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,7 +2,7 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
-FROM ubuntu:jammy-20230624
+FROM ubuntu:jammy-20230804
 MAINTAINER Tom Rini <trini@konsulko.com>
 LABEL Description=" This image is for building U-Boot inside a container"
 
-- 
2.34.1

