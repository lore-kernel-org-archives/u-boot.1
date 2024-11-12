Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35906D42B86
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC4008944B;
	Tue, 12 Nov 2024 15:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NO/jD4Jo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 241D38944E; Tue, 12 Nov 2024 15:11:33 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 714AA89246
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-83a9cd37a11so232158539f.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420688; x=1732025488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O3KwDJeSFE5hL8qLmZ8dqtd+QSWukshZi78Owg+UWMQ=;
 b=NO/jD4Jo18+Xn2/O3+Q4y3VqeIEDVO21FMwu+m4LYp72vdUz2WI3DIm/6WN8Me2Azq
 P9OmknNtoS2cPQ651rOD7L0gCgPWFtnhT4BazA5wTgh1VNrSAcX4MS8P8s6zy8TUpUmN
 DNGowgvWCbsVAfO2Fdp5IKrEaMauJzmbQUEH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420688; x=1732025488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O3KwDJeSFE5hL8qLmZ8dqtd+QSWukshZi78Owg+UWMQ=;
 b=uKHjKzf0IzxHo4zRTH/xLnw85ND/EMK4F4o9xP1IWEIQkAWamy7nbM0hRfvG1PcoMt
 k0QyPcG6NOGHzL1vk4H2IoC6UhEHrzkdHXrs3XTvxE4hPYBRpLHH407YHyBplRPxCU0c
 S7s47/oVxhgamGEumDzLz4QKyejzAJZCRA5HzFiaq2KLNww9rZBj1ayKJkxvFRBNHKXf
 D7W/E5fwGSGtquA9AcfQ+ZxZyywggx/xC/rdcNIF9Y9kcyRLQ9OYgBmexWYFMO2Aqb+X
 b2BVcH67ET7l0bCda8WcmTd22lfsDMNaCZW6xrGEIXub7ts0gLtSMhBMGM2p6RgoH0Wi
 Zq/w==
X-Gm-Message-State: AOJu0Yx4j1XGZd0qGAp4jr7M4rE0CQ670X/9WMdZ1tbaS6j+ZLV0fgxF
 I8NQ58SIwjW+4oyy2QxlALojGqt0HMPyz/+1zJAVhh+B947W2hhNZfjhrlalLdaY7Pa+Lklnozo
 =
X-Google-Smtp-Source: AGHT+IH7r7TE8XFw3QtDJBoi9ol6U9ZoOLVPIMj8sy8xcRkikhE8dQxUSWM9BjO8Vp3++1rDiwSYWA==
X-Received: by 2002:a05:6602:1614:b0:83a:7a19:1de0 with SMTP id
 ca18e2360f4ac-83e033611d7mr1999965139f.14.1731420688493; 
 Tue, 12 Nov 2024 06:11:28 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de783d11f0sm1977776173.0.2024.11.12.06.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:11:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 9/9] WIP: CI: Update for arm64
Date: Tue, 12 Nov 2024 07:11:05 -0700
Message-Id: <20241112141105.640189-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112141105.640189-1-sjg@chromium.org>
References: <20241112141105.640189-1-sjg@chromium.org>
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

Do not apply.

This is an unfinished attempt to update gitlab to run on an arm64 host.

For now it just adjusts grub and selects the multiarch image

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .gitlab-ci.yml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e152060b046..9a513cad102 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -11,7 +11,7 @@ default:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240808-21Aug2024
+image: ${MIRROR_DOCKER}/sjg20/u-boot-gitlab-ci-runner-multiarch:jammy-20240808-08Nov2024
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
@@ -33,8 +33,12 @@ stages:
     - ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
     - ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
     - ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
-    - grub-mkimage --prefix="" -o ~/grub_x86.efi -O i386-efi normal  echo lsefimmap lsefi lsefisystab efinet tftp minicmd
-    - grub-mkimage --prefix="" -o ~/grub_x64.efi -O x86_64-efi normal  echo lsefimmap lsefi lsefisystab efinet tftp minicmd
+    - if [ $PLATFORM = "linux/amd64" ]; then
+        grub-mkimage --prefix="" -o ~/grub_x86.efi -O i386-efi normal  echo lsefimmap lsefi lsefisystab efinet tftp minicmd;
+        grub-mkimage --prefix="" -o ~/grub_x64.efi -O x86_64-efi normal  echo lsefimmap lsefi lsefisystab efinet tftp minicmd;
+      else
+        grub-mkimage --prefix="" -o ~/grub_x86.efi -O arm64-efi normal  echo lsefimmap lsefi lsefisystab efinet tftp minicmd;
+      fi
     - if [[ "${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then
         wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
         export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
-- 
2.34.1

