Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DABEC83F2D
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 15:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F141E864A0;
	Sun,  3 Sep 2023 17:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wu463fdD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB27E864A6; Sun,  3 Sep 2023 17:16:06 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9DD08645D
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 17:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79275d86bc3so33225439f.0
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693754157; x=1694358957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vuH0D+iSaLUV8dzaf6OcOaIxno4spGqtYOToX1JG3Zk=;
 b=Wu463fdDSiuY1eE1arSAyDtoVespB8Asik7wgGpEHHj1fMqwN8bd70Dvh0LzZJUvRt
 9tv1G7dQmHJR5Vtew4GIq+dHke4L1vBcgh7eKG2xDqo5n5Ga2fTqPKAm25HTgsQzWtY2
 e2IwR/RuGvEv5ffvRX04KESkSj5Xgvr4do1gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693754157; x=1694358957;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vuH0D+iSaLUV8dzaf6OcOaIxno4spGqtYOToX1JG3Zk=;
 b=QgmRXkXDYuGZY9B/ne40wVVQoRElJXZst2+WKPQyEd4n1xryUnj0pM2P7Jk1iMFYqH
 H0kaC8MjarygiY/xyBwtSd7LN1oLVJVXPNyHu2EGkk1pPWkIDA6mpuYHtbFwTImDxNjm
 /wy8cWMhs9MflhM8ymOuWNkgbPOlGSTCXbCbm4XJ/8V3ifxetKsw6q5GFqGugeZ8SY+Q
 /E3aZ8cq1ioR53YeiBF93VdOckxhNlJ1L4Q/m0qjQppLZNzZvS1gE9WtzwNww+rkpQ31
 pmO89jhPMlUek3GrrEFk8k/NG/doca2hzLuwrf/61RgsuYbVNuvnrozA888xK2qihjfa
 gQNA==
X-Gm-Message-State: AOJu0Yzpy4+puKPoZ9OcXCpGE4RhUjlQIC+QqYTiBcJRqDiX39oDneIx
 JFOF45rlMSpMKxsieB6YvNpaMvyoPPO/kHMPJsc=
X-Google-Smtp-Source: AGHT+IG+kJY5g+IUZa9c2uVF2E5WAGWncW4OqMIVw7nkGaA+pqMDXT0AGaYhPhmicYNsVvYePenEuQ==
X-Received: by 2002:a5d:9952:0:b0:792:4994:d1bf with SMTP id
 v18-20020a5d9952000000b007924994d1bfmr8720383ios.9.1693754157078; 
 Sun, 03 Sep 2023 08:15:57 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dm8-20020a0566023b8800b00791e6ae3aa4sm2675315iob.23.2023.09.03.08.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 08:15:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] doc: efi: Update for the 64-bit app
Date: Sun,  3 Sep 2023 09:15:51 -0600
Message-ID: <20230903151555.2647134-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
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

The 64-bit app is supported now, so update the documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/uefi/u-boot_on_efi.rst | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index acad6397e81d..1746965e7eab 100644
--- a/doc/develop/uefi/u-boot_on_efi.rst
+++ b/doc/develop/uefi/u-boot_on_efi.rst
@@ -31,14 +31,12 @@ Only x86 is supported at present. If you are using EFI on another architecture
 you may want to reconsider. However, much of the code is generic so could be
 ported.
 
-U-Boot supports running as an EFI application for 32-bit EFI only. This is
-not very useful since only a serial port is provided. You can look around at
-memory and type 'help' but that is about it.
+U-Boot supports running as an EFI application for both 32- and 64-bit EFI.
 
-More usefully, U-Boot supports building itself as a payload for either 32-bit
-or 64-bit EFI. U-Boot is packaged up and loaded in its entirety by EFI. Once
-started, U-Boot changes to 32-bit mode (currently) and takes over the
-machine. You can use devices, boot a kernel, etc.
+U-Boot supports building itself as a payload for either 32-bit or 64-bit EFI.
+U-Boot is packaged up and loaded in its entirety by EFI. Once started, U-Boot
+changes to 32-bit mode (currently) and takes over the machine. You can use
+devices, boot a kernel, etc.
 
 
 Build Instructions
@@ -47,9 +45,9 @@ First choose a board that has EFI support and obtain an EFI implementation
 for that board. It will be either 32-bit or 64-bit. Alternatively, you can
 opt for using QEMU [1] and the OVMF [2], as detailed below.
 
-To build U-Boot as an EFI application (32-bit EFI required), enable CONFIG_EFI
-and CONFIG_EFI_APP. The efi-x86_app config (efi-x86_app32_defconfig) is set up
-for this. Just build U-Boot as normal, e.g.::
+To build U-Boot as an EFI application, enable CONFIG_EFI and CONFIG_EFI_APP.
+The efi-x86_app32 and efi-x86_app64 configs are set up for this. Just build
+U-Boot as normal, e.g.::
 
    make efi-x86_app32_defconfig
    make
@@ -189,9 +187,9 @@ interrupts disabled at present.
 
 32/64-bit
 ~~~~~~~~~
-While the EFI application can in principle be built as either 32- or 64-bit,
-only 32-bit is currently supported. This means that the application can only
-be used with 32-bit EFI.
+While the EFI application can be built as either 32- or 64-bit, you need to be
+careful to build the correct one so that your UEFI firmware can start it. Most
+UEFI images are 64-bit at present.
 
 The payload stub can be build as either 32- or 64-bits. Only a small amount
 of code is built this way (see the extra- line in lib/efi/Makefile).
@@ -261,8 +259,6 @@ This work could be extended in a number of ways:
 
 - Add ARM support
 
-- Add 64-bit application support (in progress)
-
 - Figure out how to solve the interrupt problem
 
 - Add more drivers to the application side (e.g.USB, environment access).
-- 
2.42.0.283.g2d96d420d3-goog

