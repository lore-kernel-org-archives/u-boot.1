Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41A0D11192
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 19:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBD8483A24;
	Wed, 26 Nov 2025 20:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TLBdZaYc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7056583A28; Wed, 26 Nov 2025 20:06:31 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4468A839E4
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 20:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c6cc44ff62so101416a34.3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 11:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764183988; x=1764788788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=oq6t/dNHoH9Fb46IYqhNQT8SG8o3REzf27XQnojIN+c=;
 b=TLBdZaYcfqRyIj1uRpWmPbHrS87GquJiYQZMN5zRGu9CHHr6lYjbXC4ES9VSmpzYiG
 RHyBGgCt3imacWn/4W0MDmrB9A2uZfq82dE+cnTH8kx/yElSoq7m63f1kMxjCDmObKUV
 Hns1sjjYGQX+cEItGIIcBtnchUOwWj/AciRRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764183988; x=1764788788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oq6t/dNHoH9Fb46IYqhNQT8SG8o3REzf27XQnojIN+c=;
 b=Xl3ZKyDHaxb769zbh0N8NsExw4cSYWuh3NkZKfy4N4V749fPrJC+9bEe5zmnFB6ogo
 dCWt9TP9+sen3NF3zqUYY/lZQKoNPGpGANywdCYyHgoSaBFdXZTHILuABza95IVHpdxF
 wlMIgu013xJTHdY/25HuPy2mjX2G5wd70sD9Svu/37fU9AhSCCDu91wSgg5dB2zZccxy
 fGT8XH9XGTxnluk9cVz5WLFpIFt20iyU5SZ3FctKUP86lyiUbcuaZc3gtuM2DgAGKIRf
 xLwIZ7p+UtI9oHERJsk+4fN75H555ffqSvul+5Urlgcwbse0GRCUHES1YLLFhJ79xqLG
 6LgQ==
X-Gm-Message-State: AOJu0YwNbmkqTbyxCArPFRj5KTrJThU0bAG+mEr4ecRH+ouywWoYZwLT
 V41yBX2POPrsDgDaXcwWKBsIZImCH3eZx3ZMuKOTveX2qOIVnMhfSjK0X1nR32F2XykclEBlqu8
 I16onF40=
X-Gm-Gg: ASbGnctjH0fNfMeeoNfENm3N1Yrl1oWtcd1wFdYQJGv8oUJ9BXK95yUTuPmceGRfZ9R
 R7hAFD7N/nqlWd7J9LJWGH2kIgz9L3DKomlWNyvebkNTIMp27jq5nRVR0JFuEoe1YzIpke6TQmW
 PiUNcNrsxJMHJ7/hoU7a5/zmrpZzzS4MpyyG4rKdtOgNb8l204x9/vVjz+joJn+aGP8uQgNU2Mu
 B9IIgjD7YcKiXxHGVAlqor5YTEPwFabUC+XgNVUXdsYWgkmZ+cnKekW4hg8T25hLjPPsp1DeU/0
 AIkhLDHTbqaVcRhYvo1rJivbgZsnvvG15haW7BZv+gT4LmJez+IxNJOvNM3gBSSfXMUgkA6+pFP
 xHLCbBvk12KVko2cVN4fssUmDC68Gnja0XaMSBUlE7BG2Eyq9RmaM9YFeHkc5Avx0pRESpIqN9N
 cd1bkmQIBmNbzErMw56xIwR6f4XKzrpczXoCv8x4Y/jBsE2KrS4CIF
X-Google-Smtp-Source: AGHT+IFqARhFAQfvo17NYCOvHVISBaDnVUXmCKL88xD6R5823VD/VWdxbFE5Kb8An5eO4XJ/Fpxbxw==
X-Received: by 2002:a05:6830:6f47:b0:7c7:827f:8730 with SMTP id
 46e09a7af769-7c7c4485d9fmr3903482a34.38.1764183987963; 
 Wed, 26 Nov 2025 11:06:27 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d42801fsm7746362a34.27.2025.11.26.11.06.27
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 11:06:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: Update to latest container
Date: Wed, 26 Nov 2025 13:06:26 -0600
Message-ID: <20251126190626.3799644-1-trini@konsulko.com>
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

- Move to jammy-20251013 tag
- Bring in tkinter so that FATtools should run and more tests should be
  run.
- Update to QEMU 10.0.6
- Pick tags for (most of) trace-cmd

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml    | 2 +-
 .gitlab-ci.yml          | 2 +-
 tools/docker/Dockerfile | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 3f671dd078d7..0c7c38ba7300 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -2,7 +2,7 @@ variables:
   windows_vm: windows-2022
   ubuntu_vm: ubuntu-24.04
   macos_vm: macOS-14
-  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20251001-04Nov2025
+  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20251013-26Nov2025
   # Ensure we do a shallow clone
   Agent.Source.Git.ShallowFetchDepth: 1
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 86d3c741ea17..e7234e003ea5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -18,7 +18,7 @@ workflow:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20251001-04Nov2025
+image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20251013-26Nov2025
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 960e4a7177f5..8ab1cff55843 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,7 +2,7 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
-FROM ubuntu:jammy-20251001
+FROM ubuntu:jammy-20251013
 LABEL org.opencontainers.image.authors="Tom Rini <trini@konsulko.com>"
 LABEL org.opencontainers.image.description=" This image is for building U-Boot inside a container"
 
-- 
2.43.0

