Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63779EE49A5
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:26:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D079F87002;
	Sat, 19 Aug 2023 23:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SbhgNqHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72B7787045; Sat, 19 Aug 2023 23:23:34 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF9B186C1C
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7914633a110so71383039f.0
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480210; x=1693085010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBcuuoxM8VnGEUGWaHRoa5NtC7BPZ38lonY2a+Kw9jM=;
 b=SbhgNqHsO3gyKfULh54kgLCgwjtueb7NDUAQNIO0+K03+J/0KDFpCEafg4bgEcb4ZL
 TtvHasNaWMxU4lzx8TEnxak6Im2j+wVNqCPvH4WGlu496PGeXqUd7nMaVrfx/SI/DKHo
 8uAi63H4cXTmzQi7eDKVIB/szsg1PouWJhtjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480210; x=1693085010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBcuuoxM8VnGEUGWaHRoa5NtC7BPZ38lonY2a+Kw9jM=;
 b=PubmP/6ufgVAowd2hBn2MhM2YyWNkirDKjky4IXxKIYoKGuXDfxbMCpW7FD1o/A8le
 grmfft9M5dT4mRZsIiJYWXqjnak3dvPjDxg0xtPKVt3wMPDFEH84Wzbrq3fGczd/P7+x
 gWwmYUpUDhPzPJDlJgs5rLZGizDXPTSFnsXVVNdYWwpVYK34UMx+9hP/ZuL4ho3x1Nx1
 SyG5/BDS9NdyH4AEn9VhcCdRoZ/kOzxkSxmH3KUnU8mK6booM10/6nE3lEZkJGXTlCtF
 EGKzrW9QIyVEOnYOaWzBe52gONLjoC+BYoR33cI0aztAqghQPOqPJM3RbZed+IMFO3Ij
 hhkw==
X-Gm-Message-State: AOJu0YwWCM3Jw8UERe9zARqZE4lR4TUVs0SbQpMsiNDxzSJeuA8p4ID2
 fk3nb/JhHKp0b63PpylHmKPtJtQAmiDtMGCrnpc=
X-Google-Smtp-Source: AGHT+IEc2M8iv0C3zfw7YyJcD9Ah26SqUyJ/+Iy0bSM2GrhwG3HvrzhRxW+AQmf7SKJTYGTS44G3fA==
X-Received: by 2002:a5d:9d02:0:b0:786:25cf:421f with SMTP id
 j2-20020a5d9d02000000b0078625cf421fmr3917909ioj.19.1692480210244; 
 Sat, 19 Aug 2023 14:23:30 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 16/19] x86: doc: Move into its own directory
Date: Sat, 19 Aug 2023 15:22:54 -0600
Message-ID: <20230819212309.1094440-17-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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

There is enough material that it makes sense to split this up into
several files. Create an x86/ directory for this purpose.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch

 doc/arch/index.rst         |  2 +-
 doc/arch/x86/index.rst     | 11 +++++++++++
 doc/arch/{ => x86}/x86.rst |  6 +++---
 3 files changed, 15 insertions(+), 4 deletions(-)
 create mode 100644 doc/arch/x86/index.rst
 rename doc/arch/{ => x86}/x86.rst (99%)

diff --git a/doc/arch/index.rst b/doc/arch/index.rst
index 2f916f4026c5..60c93b3b6640 100644
--- a/doc/arch/index.rst
+++ b/doc/arch/index.rst
@@ -15,5 +15,5 @@ Architecture-specific doc
    riscv
    sandbox/index
    sh
-   x86
+   x86/index
    xtensa
diff --git a/doc/arch/x86/index.rst b/doc/arch/x86/index.rst
new file mode 100644
index 000000000000..3dc19d603d4c
--- /dev/null
+++ b/doc/arch/x86/index.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0+ */
+.. Copyright 2023 Google LLC
+.. sectionauthor:: Simon Glass <sjg@chromium.org>
+
+x86
+===
+
+.. toctree::
+   :maxdepth: 2
+
+   x86
diff --git a/doc/arch/x86.rst b/doc/arch/x86/x86.rst
similarity index 99%
rename from doc/arch/x86.rst
rename to doc/arch/x86/x86.rst
index 725a1ae58639..ef6970b88a59 100644
--- a/doc/arch/x86.rst
+++ b/doc/arch/x86/x86.rst
@@ -695,8 +695,8 @@ to load a 'u-boot-payload.efi', see below test logs on QEMU.
   No controllers found
   Hit any key to stop autoboot:  0
 
-See :doc:`../develop/uefi/u-boot_on_efi` and :doc:`../develop/uefi/uefi` for
-details of EFI support in U-Boot.
+See :doc:`../../develop/uefi/u-boot_on_efi` and :doc:`../../develop/uefi/uefi`
+for details of EFI support in U-Boot.
 
 Chain-loading
 -------------
@@ -732,7 +732,7 @@ SMBIOS tables
 To generate SMBIOS tables in U-Boot, for use by the OS, enable the
 CONFIG_GENERATE_SMBIOS_TABLE option. The easiest way to provide the values to
 use is via the device tree. For details see
-:download:`smbios.txt <../device-tree-bindings/sysinfo/smbios.txt>`.
+:download:`smbios.txt <../../device-tree-bindings/sysinfo/smbios.txt>`.
 
 TODO List
 ---------
-- 
2.42.0.rc1.204.g551eb34607-goog

