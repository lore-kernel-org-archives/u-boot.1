Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9821DD116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 14:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAB4D83B0B;
	Mon,  1 Dec 2025 15:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TLvgpQQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2AC583B22; Mon,  1 Dec 2025 15:07:03 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16C6583B03
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 15:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c6d13986f8so2895269a34.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 06:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764598019; x=1765202819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=yAEth/Dh5P9OoVqXt0smQ6c0DPY2NcpXjIrHfoqs24Q=;
 b=TLvgpQQ+gFR0oeYYrwh+htF3ddAkIGXBT3rax/r96lGnDC87lZRqjpIN3v/daajxPs
 qJvWTiw8Bnd+b9fyyqJvzkPAqChZbpmhNoYPfPSZidd6nsMlVkqmM7vGIh0Bzg+X6xdQ
 kG4aj746Dg45nTP5bvXvxrgpxJ1LJLh+N4EFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764598019; x=1765202819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yAEth/Dh5P9OoVqXt0smQ6c0DPY2NcpXjIrHfoqs24Q=;
 b=uwZFWUtRs8sLzna3devKJD4Bnk84DdZOx2gYee4EU3duWtXjseXpPtWujXDCFmiyMR
 GjwQZVM50/G5rQ89T9jzvMcmP887j0YyqwpG3zbpVKkF1mrhvJYoax/w1Vm9CcYyiusk
 6tSCHPn+3LW+TTI+TYYgoBqVhZv5fIdFEK0gpcLJmhEvi779Z15zQVyKEiwF6HbC8EEO
 dCXPSNFO0sJ61TsyerhuuabYM626mca8lqtkhRzxYWHHknvrS+4824dl9JWuHgOvCXFR
 TIhcu1H/dXsb7mHBnpDQNJQDVTW9h8WucmNqbEZ6U5MyPvDcaG2GZozIIgKIMTvB8TLi
 2ohA==
X-Gm-Message-State: AOJu0Yza6MfTH5pKZZmanWxKXzifp9MQOGx/MkXKFcZObbnEd1NdvSIR
 0nNgLYmkK8/MAotJilVJut63n6mD+SYAc1Bb/dcvFXPO7kjY0UskLcGuNrDHjSOAwPw3mMFAjXG
 3gZpJidE=
X-Gm-Gg: ASbGncsCBOrTdW7cghXrcWgi0pnsKzjIruYLSg1cY7ZZoEemnox+KwzMfdhELFBznQh
 fTBh9zpjsgJo+l6n5fQznSorWCZ8FH63X+C3PoybJrsQdLo4gsb70KJ1+vDP89DG+nfbqIpNaff
 W0TgoBit9RrtkYTTs2oQdf2Rm55ZgSp7GeuQeTo3rh+3TPWLw6XiIVModmeZr2sQdp4csrPtlK0
 98JdzmFo7nasD2vNSBuOVVRaYx6YG7ik937TLwUcYJOJMth+A5yuj8akXmElbofTIoaW8rQ4OID
 yyg5VfP6KLXC5C2o41A+sa2NScKYwQZlbOSME8nX9xctgJ60psKGle9q1Q2g/8DCty/PbaQxg/d
 kjT2O+RwpYq+P4vlokAZdAPOZQ0TzYpdaQcy2/nFE+staaod5iwvUsqkEzZYz2Jl84wQ7e+301a
 bCHrNwBUzDqZnk12sikqErtLUkTA4kOvbsUjVEu1bb1b8q55QfUF8t
X-Google-Smtp-Source: AGHT+IHbfJNbpRnMtzblG9wA3NDblbCZKFQ6RPakgxNVOwaUj2UwlaZ634c3qKU+pGmqmFKy85/Fig==
X-Received: by 2002:a05:6830:4486:b0:7c7:6e32:dc72 with SMTP id
 46e09a7af769-7c7989ee704mr17418518a34.2.1764598018632; 
 Mon, 01 Dec 2025 06:06:58 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5d7ba2sm4583915a34.5.2025.12.01.06.06.57
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 06:06:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: Update to latest container images
Date: Mon,  1 Dec 2025 08:06:56 -0600
Message-ID: <20251201140656.1045134-1-trini@konsulko.com>
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

- Bump to noble-20251013
- Include tools for sage lab, build TF-A for platforms there.
- Switch to distro provided trace-cmd, add libengine-pkcs11-openssl
- Use mirrors for GNU projects
- Switch to QEMU 10.1.x

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml    | 2 +-
 .gitlab-ci.yml          | 2 +-
 tools/docker/Dockerfile | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index abbd48d0056b..032938ca3401 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -2,7 +2,7 @@ variables:
   windows_vm: windows-2022
   ubuntu_vm: ubuntu-24.04
   macos_vm: macOS-14
-  ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20251001-11Nov2025
+  ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20251013-30Nov2025
   # Ensure we do a shallow clone
   Agent.Source.Git.ShallowFetchDepth: 1
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6ed07cae317e..08bea0dd2342 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -19,7 +19,7 @@ workflow:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:noble-20251001-11Nov2025
+image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:noble-20251013-30Nov2025
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index eb71460219f7..6eaa17800979 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,7 +2,7 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
-FROM ubuntu:noble-20251001
+FROM ubuntu:noble-20251013
 LABEL org.opencontainers.image.authors="Tom Rini <trini@konsulko.com>"
 LABEL org.opencontainers.image.description=" This image is for building U-Boot inside a container"
 
-- 
2.43.0

