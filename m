Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B754ECCFA05
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4236083923;
	Tue,  4 Nov 2025 19:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dC7m8kYo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1A6583942; Tue,  4 Nov 2025 19:12:26 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB39D8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:12:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6504c33afb1so42599eaf.1
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 10:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762279943; x=1762884743; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3s/ZzqyzwHGH0J6HTUNEzaqIHUGl+XMGCUCaPuk6sv8=;
 b=dC7m8kYoKf+7mPpVeKoQD+1mOmDTsZer1slVZXd7vqHTDa2DekFWKnO1MUECLsNst2
 gajFpXcQD3Ilysm1zahiXqqqLE7ye/fYpGa9FrVj/tdKwOCiVr2kAgMSls9Q+eSEhicb
 wlyNZqyc7LSLRumQwkzrHrDLZe4NcvOIWx11Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279943; x=1762884743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3s/ZzqyzwHGH0J6HTUNEzaqIHUGl+XMGCUCaPuk6sv8=;
 b=WxO+ijTl7OEcmIFbiCpw0QD/fLXSpK2Si/nHficOieyaNZrrQa5sT7F2WpzQv94ze2
 UK8Y5e9OYnGDLnR2DQSDAT60dQBuJEAG5xb2q0HlnNatoFjvt/HkUHjcWQqJ4YCp/+QM
 SNFRQvIoVT1Q/s+kvR1oXTo/rYRpDQBR1e92JpRDLzipgX0EsJppBOmIy0ZxBWaUtGvV
 XkVs3idX5VKTG9tJ3L+aIqcviZbwmvnb94uRlLXGR6d/X7+c9b7d2vkDbfGwpM3Zu0hI
 FwZtHJSBsL6J4VhGj7ofn32Wyn/GJRddpEsLvbnufvZ0+qhdo9WQjTkvbHLY8PL2qZ++
 qC+g==
X-Gm-Message-State: AOJu0YwqKKl8X8PcQo7POPdtTNmF0qj2K0Q+K5nE74KX7vKElZpMj5vW
 IHs1u7DXMBufgXYtEi1lH9S5627hk0Q98hFRQZQumBPRTIwXwefxu5KnsxgVZZiB2cUhf20vygD
 2BMRqcqOsIA==
X-Gm-Gg: ASbGncsnXqB5QB3UdroP9jvSXbX+yf0bjxH871HAEv22TkUz/K2xeAQD8ejcPEH3ppf
 YYXDCULO2bXq2R/DtP8UQPX/r/H7Bq/EfnVhzoT9tJtTzCT3753/q/vvQCrNYMC8tCO1LYtXjoI
 rTctFKeCdZFJTKU+iutzKV/DSrmt8MWEZ4i0fU1XI4772fhzuoOSHIU16F4TGfhvxytB4JB/5xC
 EZTs/fMD0iaEPDRxTsP7KxhZnoGr+XFIB+2FIx0eXRuUyCPsetfYgst/QsJgt1Vl125jZ/FG2z8
 h8SOaLfw7HHA7zrrkY96pfjYI2ZPtzdq9xBVBNHjBaiTjy9vbqLPLrrTeuT1ZFiTV/b7qux4ZcU
 S+AOiRNcaWGK4YUGGxv1CmM4zqg1ZSFgMd5X8FxpcMvDVi+QNeOBlf03nJcL4sXk6wP4cTP6tJq
 S7tE+5/ZicuexClw3M/X0S5vX6ACZyUYLpvSWen7K5OQ==
X-Google-Smtp-Source: AGHT+IGaIjso2H+ii9C8EOh6ri48FSzmgrYiLBObBU0Nd2nrVg7biIbCjQmn7/2mKH9lFjfB6U5QIQ==
X-Received: by 2002:a4a:d448:0:b0:651:c857:a4eb with SMTP id
 006d021491bc7-656afbe7badmr1133366eaf.4.1762279943486; 
 Tue, 04 Nov 2025 10:12:23 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656b9eaac5csm138479eaf.11.2025.11.04.10.12.21
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 10:12:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] CI: Move to Ubuntu 'Jammy' 20251001 tag
Date: Tue,  4 Nov 2025 12:12:20 -0600
Message-ID: <20251104181221.3980984-1-trini@konsulko.com>
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

This also incorporates the following commits to the Dockerfile:
da7942de29f7 Dockerfile: remove Python 2.7
183299d9a400 docker: add OP-TEE and TF-A build for testing Firmware Handoff

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml    | 2 +-
 .gitlab-ci.yml          | 2 +-
 tools/docker/Dockerfile | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 320f7567e6d6..c4a2504491ce 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -2,7 +2,7 @@ variables:
   windows_vm: windows-2022
   ubuntu_vm: ubuntu-24.04
   macos_vm: macOS-14
-  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025
+  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20251001-04Nov2025
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
   # denied" error when it tries to "useradd -m -u 1001 vsts_azpcontainer",
   # since our $(ci_runner_image) user is not root.
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 033d4f9f0af8..a585ece8a0f9 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -20,7 +20,7 @@ workflow:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025
+image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20251001-04Nov2025
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 5d2f6375e363..d2384219c06a 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,7 +2,7 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
-FROM ubuntu:jammy-20250714
+FROM ubuntu:jammy-20251001
 LABEL org.opencontainers.image.authors="Tom Rini <trini@konsulko.com>"
 LABEL org.opencontainers.image.description=" This image is for building U-Boot inside a container"
 
-- 
2.43.0

