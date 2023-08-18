Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D84AC2FC0E
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7932186C5D;
	Fri, 18 Aug 2023 02:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R3qW0DkB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D30386BFE; Fri, 18 Aug 2023 02:27:33 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C263986BFE
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34bae82b2ffso1364725ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318447; x=1692923247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MigkGG6qJQYUF+76zx2Jh8om/R7uik+trrdJbi3sp+U=;
 b=R3qW0DkBcYKNEmY5FuUpmUyybCzXl9lFJEVH2PpsXDkhW/5Y1OBV9AupkqYpbAsv17
 J6k1HO0HvHIrgJw8UV+NZXlxsnfPdW1TMXoo9B+tggdZdFANtvifsgCkH7l965vGgKls
 HWw9aOr90gASJs2ItnVNRz1imk3jlH8c1vYRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318447; x=1692923247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MigkGG6qJQYUF+76zx2Jh8om/R7uik+trrdJbi3sp+U=;
 b=JU/edZnuxukjzjmjOrEBTZsRZt1WKUGrlu9+xFMIlMWxPyt6wZo/VbWTfXw0ZHDPVB
 rzvDhzDeKMvhjrNPSZUSHEVw37jnxaHJjyqade0wUjECE8X4fsJZ0FBa3gSio7b2rYRG
 ZuQZIUHrS56uJsoOsW7ANLAMSuVKz2JJeXjnsMaz/RH2gEY/Qy+POX714MN0+tEapk0G
 tRfMPvKQR61Cg02vG1OvbHVQycSqRiqbfBeNK9DWA6gXq77Y1zcR+nVJsmMoRERjMu7p
 WbGm7ieUfjAKqNQ4p0Ux1pvjQDJyKKP9z6MCS3nLzEVd8ZV3TPyX8OGCcFu2wtb3/aKz
 FMiw==
X-Gm-Message-State: AOJu0YxXkdwCtOeCxqFE58eNt5HiTRf7NGa7fx4Zy7LvvIb3pVFB3ExY
 7aKSeuISmqh7AYGxklF+QplSoAZlnKAYJxKtF4A=
X-Google-Smtp-Source: AGHT+IHkKGgj+ahmrep/EomzlLg6WC3beHYKXUycp2Kv63rQ2614j6DzSCsTMDm5+4xIngwFLiQFvA==
X-Received: by 2002:a05:6e02:c64:b0:349:8811:fc51 with SMTP id
 f4-20020a056e020c6400b003498811fc51mr1195167ilj.20.1692318447414; 
 Thu, 17 Aug 2023 17:27:27 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v2 17/20] x86: doc: Move into its own directory
Date: Thu, 17 Aug 2023 18:26:56 -0600
Message-ID: <20230818002706.853550-18-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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

