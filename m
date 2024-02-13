Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA927C48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 14:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E9B87D8E;
	Tue, 13 Feb 2024 15:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mz3OgXLU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 022D987D8D; Tue, 13 Feb 2024 15:39:38 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0108187D58
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 15:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-60792653b94so4298827b3.3
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 06:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707835172; x=1708439972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mzLXWTfDLslc8rGPA/7IWCmgDI+qVcqlxpUIFhCUPhU=;
 b=Mz3OgXLUtrHJd1M+/ijSCaMnU+NFzoV4J+Dq1AlKUF2UCJihEv0INz8sh6nVmc1AQZ
 aa9tuMNbxUtNNBlWTDllBKYRldcaAaPLUkEW3InP7nqUWdwBw/iRPe+bC4M7oonMebtB
 Yv6UWVmlQFkKTKUOgS+eMesM542F1LSnwfhnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707835172; x=1708439972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mzLXWTfDLslc8rGPA/7IWCmgDI+qVcqlxpUIFhCUPhU=;
 b=SMzojiRO6ULiI5xr2NhXNuSnUqd1vmELi0cd3InJQluVE8ELb4mLNCcJQJ4PXVE5t/
 Fsdacn03ew71395VzlSA9D7zzUUFqShvSt+Rtmz5lyS/JhSqreBh2Ms24X1BOvBLM81q
 Eay5UpxDFVqw/NcH0Qq+vLtUgOxTWnEbdHHpvbGis52BpDjOGNGrJikIob1BvfDGLYIP
 EHDQ+rVoohJHA4LFGNXEkbWzJYQ7uJ1oo0aKgzCu/E/VTwpyFZ5a570hHBiy06kY/jeg
 fYhV8NrH1SbJZG4jas4JdM7OrtbozjvjRi1+u0QHUeIKSyh040MuobumhLzLZBYYnumM
 v87w==
X-Gm-Message-State: AOJu0YyFrcSKOMjLOyBW7o2urc91vW9PkJe/qmD9/jYrOwWb8dleQZVY
 mfErBmGDZikPZdY5y5W05ESxPz6WBLKVf7LFUIouilM9i1mYEkSjgFH27L9UEsOaN02gHL/ICiA
 a
X-Google-Smtp-Source: AGHT+IFoh0dZTy6cFfQ2KTqE3ZUyzfautuDiUOUcCkLILUEJ0JOsx1RNm72/c7e6bbdSwzjONH9xQw==
X-Received: by 2002:a81:ab48:0:b0:604:7b5d:7146 with SMTP id
 d8-20020a81ab48000000b006047b5d7146mr8856027ywk.40.1707835172463; 
 Tue, 13 Feb 2024 06:39:32 -0800 (PST)
Received: from bill-the-cat.. (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 d21-20020a814f15000000b00604997f9e77sm1765928ywb.5.2024.02.13.06.39.31
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 06:39:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/3] CI: Move to latest container image
Date: Tue, 13 Feb 2024 09:39:28 -0500
Message-Id: <20240213143928.91443-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213143928.91443-1-trini@konsulko.com>
References: <20240213143928.91443-1-trini@konsulko.com>
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
index aebcc8908687..7c3172610ee6 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -2,7 +2,7 @@ variables:
   windows_vm: windows-2019
   ubuntu_vm: ubuntu-22.04
   macos_vm: macOS-12
-  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20240111-17Jan2024
+  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20240125-12Feb2024
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
   # denied" error when it tries to "useradd -m -u 1001 vsts_azpcontainer",
   # since our $(ci_runner_image) user is not root.
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 66f3cb14b03a..6ab3bb5ec2aa 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -10,7 +10,7 @@ default:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240111-17Jan2024
+image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240125-12Feb2024
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 3d044657406e..274255456619 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,7 +2,7 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
-FROM ubuntu:jammy-20240111
+FROM ubuntu:jammy-20240125
 MAINTAINER Tom Rini <trini@konsulko.com>
 LABEL Description=" This image is for building U-Boot inside a container"
 
-- 
2.34.1

