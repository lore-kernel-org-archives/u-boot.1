Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6E8C3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20EF386536;
	Wed, 23 Aug 2023 23:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OqF9vELn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25230864DD; Wed, 23 Aug 2023 23:11:25 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1694286445
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34baf19955cso20013805ab.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825081; x=1693429881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1oxkNc22y1YDTOKyB8c82tzff3Hmx8SgOFUkkgxj0Y=;
 b=OqF9vELnFl3KaFY7HRmExEfr+5qv32cfgEiCW/y1i3kkSSepKjCCzYtUpa2dCyMEBE
 5HprVmaR7DZrCfsb5DHrv/1sF91qZxGVxdTk4/J3L9C67H/AqDaR6xrWRMVARdRurse6
 ejkU2lGE27p1w7UM8Y7RjMSd+cthJ80xPieCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825081; x=1693429881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1oxkNc22y1YDTOKyB8c82tzff3Hmx8SgOFUkkgxj0Y=;
 b=Z0IkZh6CT+12yguJs7/EdEDQNT/dXVip00GGGaCMG/i9GnO7WZ8U6QbrlxA6eZgltW
 uuOn6Tsqzj9BafvdQxRiwT6VtIzMyU2YWpuAGxyepTYjF5ihl30sAOKjqBzBxUT88EWa
 yKxd7bE/T6KyC6s/eDjn5fSENC7X9eu7kSlsfiArgsS+5lFQHEjprVwI8yfMyoxxT4Jf
 0675hJ6gkxZYI7Sw0XJ4QqCGRURw9iWhGaxvSyqdh8WjH6mz3UcTDB29t45a8JDx2/T9
 2dPZsXyEDMuYXIgjbC2n9qYUKkGKQY1KrZ/2pyd/f8CwPo30jL7eguL+vWj/CQ8BEOVU
 tl+g==
X-Gm-Message-State: AOJu0YwAo/bmkmsEIU8tM8WSEXXXnqqSQSr3Cys86/3wc6cWIrpnajtB
 s5g6b/VFtDnT8qHzIaGnSNQSG8Q+mLtgX7yuizA=
X-Google-Smtp-Source: AGHT+IGVyFhmeBbV6Ko0Kj1Qu8kvSs+7SkabBkSdvHVr5a9GI0SAkdVQ+5F2i9UBpiJKrVjkdLQarQ==
X-Received: by 2002:a05:6e02:1542:b0:348:f4c1:4817 with SMTP id
 j2-20020a056e02154200b00348f4c14817mr4505211ilu.6.1692825081693; 
 Wed, 23 Aug 2023 14:11:21 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 17/20] x86: doc: Move into its own directory
Date: Wed, 23 Aug 2023 15:10:34 -0600
Message-ID: <20230823211059.1235147-18-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823211059.1235147-1-sjg@chromium.org>
References: <20230823211059.1235147-1-sjg@chromium.org>
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
index 2f916f4026c..60c93b3b664 100644
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
index 00000000000..3dc19d603d4
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
index 725a1ae5863..ef6970b88a5 100644
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

