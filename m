Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F840CA0FE8
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 20:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB99186453;
	Fri,  1 Sep 2023 22:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sP/DJaR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C160986722; Fri,  1 Sep 2023 22:41:50 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F17E28657B
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 22:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d743a5fe05aso1962149276.2
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 13:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693600906; x=1694205706; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=badmzAFl8M2ZAmhFzeo6F4p9hl84yeJHJZk0GpBhLXA=;
 b=sP/DJaR6E6mNNzgZwq2TiPzIpZ/nupa8zRSEZmnUfGkK5hBAW93+UkVCjt2ipmISVz
 PL+uEeUOycz9svmRmc5tbRBUGeDlCtgYkNgFYiEeayfVeb3szquc9f2tiuHBGouHAFA8
 RScXI7EMJXpNAqPAvEmonNVzcKmH0WUBkXxIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693600906; x=1694205706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=badmzAFl8M2ZAmhFzeo6F4p9hl84yeJHJZk0GpBhLXA=;
 b=Jna1erM7jv2MB9sy/7TN1EbKCaraZfyzzZvc1UhImUeZddMZKsgB66esSkMjjttY/S
 69UXej6ZqXdtS92tbviSNGeZGzoKuivc+3d3CYqzsbeyhicSeXQPCrvtunuA4L4rM4ln
 ztLbQzp54AwSe/UFQJB90qzABt4IY6N6Gehz7qpYr+NcwxJLV2CDVJ00j4DDdlAaKuMd
 v1b7IbwzT4h+hFmDbRwBScdz8M6LePiqA/Rc8B2HkyJq6KqyCmFXBNsPAdAcBgLGlkLy
 ZDvBUlOJtYKxpSI+GkIvZ/aEzC4+nsYMT1DNIYgpC17pct44KkAgP4cINv8xaJ1fsT6O
 AdNA==
X-Gm-Message-State: AOJu0YzcKMzqGlK623TDB0MxM29myGu/geD1US/XPEHAQDeEUuO9wJYR
 oPIl8IYilllyn7TDQ6WqcMPFYvRMoECTjlxbJ9bRAw==
X-Google-Smtp-Source: AGHT+IHJu8/wklh266uKgn56cAKtf3dD4w/yHnE39ZS/8ipcYSuteMKEDQtk5AhKTSQ07+Cj6QfbNg==
X-Received: by 2002:a25:dfd3:0:b0:c73:e6b5:c452 with SMTP id
 w202-20020a25dfd3000000b00c73e6b5c452mr3920974ybg.2.1693600906152; 
 Fri, 01 Sep 2023 13:41:46 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-4587-e14d-65a2-5068.res6.spectrum.com.
 [2603:6081:7b00:6400:4587:e14d:65a2:5068])
 by smtp.gmail.com with ESMTPSA id
 k66-20020a252445000000b00d071631665fsm1075707ybk.59.2023.09.01.13.41.45
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:41:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/3] Azure: Split sandbox and qemu test.py runs
Date: Fri,  1 Sep 2023 16:41:42 -0400
Message-Id: <20230901204143.3617876-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901204143.3617876-1-trini@konsulko.com>
References: <20230901204143.3617876-1-trini@konsulko.com>
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

Currently, most sandbox runs take a long time (due to running so many
tests) while QEMu based test.py runs are fairly short.  Split the
pipeline here so that we get more consistent average run times.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 61 ++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index cd9048964eea..72a772ce9c65 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -321,10 +321,10 @@ stages:
         displayName: 'Publish test.sh'
         artifact: testsh
 
-- stage: test_py
+- stage: test_py_sandbox
   jobs:
-  - job: test_py
-    displayName: 'test.py'
+  - job: test_py_sandbox
+    displayName: 'test.py for sandbox'
     pool:
       vmImage: $(ubuntu_vm)
     strategy:
@@ -353,6 +353,47 @@ stages:
           BUILD_ENV: "FTRACE=1 NO_LTO=1"
           TEST_PY_TEST_SPEC: "trace"
           OVERRIDE: "-a CONFIG_TRACE=y -a CONFIG_TRACE_EARLY=y -a CONFIG_TRACE_EARLY_SIZE=0x01000000 -a CONFIG_TRACE_BUFFER_SIZE=0x02000000"
+    steps:
+      - download: current
+        artifact: testsh
+      - script: |
+          # make current directory writeable to uboot user inside the container
+          # as sandbox testing need create files like spi flash images, etc.
+          # (TODO: clean up this in the future)
+          chmod 777 .
+          chmod 755 $(Pipeline.Workspace)/testsh/test.sh
+          # Filesystem tests need extra docker args to run
+          set --
+          # mount -o loop needs the loop devices
+          if modprobe loop; then
+              for d in $(find /dev -maxdepth 1 -name 'loop*'); do
+                  set -- "$@" --device $d:$d
+              done
+          fi
+          # Needed for mount syscall (for guestmount as well)
+          set -- "$@" --cap-add SYS_ADMIN
+          # Default apparmor profile denies mounts
+          set -- "$@" --security-opt apparmor=unconfined
+          # Some tests using libguestfs-tools need the fuse device to run
+          docker run "$@" --device /dev/fuse:/dev/fuse \
+                         -v $PWD:$(work_dir) \
+                         -v $(Pipeline.Workspace):$(Pipeline.Workspace) \
+                         -e WORK_DIR="${WORK_DIR}" \
+                         -e TEST_PY_BD="${TEST_PY_BD}" \
+                         -e TEST_PY_ID="${TEST_PY_ID}" \
+                         -e TEST_PY_TEST_SPEC="${TEST_PY_TEST_SPEC}" \
+                         -e OVERRIDE="${OVERRIDE}" \
+                         -e BUILD_ENV="${BUILD_ENV}" $(ci_runner_image) \
+                         $(Pipeline.Workspace)/testsh/test.sh
+
+- stage: test_py_qemu
+  jobs:
+  - job: test_py_qemu
+    displayName: 'test.py for QEMU platforms'
+    pool:
+      vmImage: $(ubuntu_vm)
+    strategy:
+      matrix:
         coreboot:
           TEST_PY_BD: "coreboot"
           TEST_PY_ID: "--id qemu"
@@ -457,20 +498,6 @@ stages:
           # (TODO: clean up this in the future)
           chmod 777 .
           chmod 755 $(Pipeline.Workspace)/testsh/test.sh
-          # Filesystem tests need extra docker args to run
-          set --
-          if [[ "${TEST_PY_BD}" == "sandbox" ]]; then
-              # mount -o loop needs the loop devices
-              if modprobe loop; then
-                  for d in $(find /dev -maxdepth 1 -name 'loop*'); do
-                      set -- "$@" --device $d:$d
-                  done
-              fi
-              # Needed for mount syscall (for guestmount as well)
-              set -- "$@" --cap-add SYS_ADMIN
-              # Default apparmor profile denies mounts
-              set -- "$@" --security-opt apparmor=unconfined
-          fi
           # Some tests using libguestfs-tools need the fuse device to run
           docker run "$@" --device /dev/fuse:/dev/fuse \
                          -v $PWD:$(work_dir) \
-- 
2.34.1

