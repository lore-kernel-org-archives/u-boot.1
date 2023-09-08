Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665A6EE57F5
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 10:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E8A86A04;
	Fri,  8 Sep 2023 12:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ma0X3d44";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1FB486998; Fri,  8 Sep 2023 10:00:22 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0475865D0
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 10:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jaewon8868@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68e369ba5f8so1448498b3a.2
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 01:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694160017; x=1694764817; darn=lists.denx.de;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XU8MYriCgu4QKPbyIFRiOihYKAcZu5lwELnDUnEkUY=;
 b=Ma0X3d443ENXkzcW63T2Dx+8mwI25tUyWRs741EVh3UxgCnCqQGGYcHRcTNvrHiz87
 x2F3MbmeeOu1aqdTZYcLVK67ERmIxTjndfBtK/RcfTV2aQQOO7tTy+f8/P38B4dtfHRw
 GPHcURgOOemGCc7Ukyf7hjYECPF4sBVm2VeCdyPJXPmHz6C4U0dG+HOwfQvgcf+o5cSi
 Fn7PddaHUnc2BGfxtLhKtsS/ab/SfW23ZFrvHBLbDdC9p7DzbEUxILsphtPz6NkxMcVG
 EufGXBHklxtVaKL1adBWfAR9VMzJOR9d+mGjGZ9UiqHlFJ6Pa6lPN5iucnp1DkJCJedz
 tyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694160017; x=1694764817;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XU8MYriCgu4QKPbyIFRiOihYKAcZu5lwELnDUnEkUY=;
 b=MA6MdHNwSHZbXFlKF+QbKpFiv4cRbk/DmZ5dXXCXnlFkyt4YgMcyNDVF8NVphgLTph
 qwYN/R04OP8g1p7+JaqFiDG0yHl+gCyBF4p558/W27v0NnDp1hwlvrBt2ZJK5JG2L8vZ
 sYXQ7zIAEzOqh26eW5ph28IF+9DUhIdzuByRzUzfyhh0MEVA2kKDNLTkRzt8Y6nRnWzS
 32FgepVkNDcGp0uWBCrOfvcUS7LD5csID1sy92JdBTo1Q0/sz9THoibjCcl2v0lCXV0J
 U225bqWHdwWNm5Deq+Qb6iEOwajNR7aZVmMKCJWp4j2JAcp5TPfX0PkNg+P9EGktw0nP
 P6hQ==
X-Gm-Message-State: AOJu0YzSCr1GP6lQdMZXHHM739EYaNw9wTgtg17o/xqLbl0Yozp0/RQQ
 S47XH+aDqQ1zYsHPdTS4XNgEBAeZo6w=
X-Google-Smtp-Source: AGHT+IGnMIw/VtXDj+5RojJhT4LlEdGYmXlKw9p3lUtJCVLNZwZWsnVNyI3358HeEdeQV5eod0ITmw==
X-Received: by 2002:a05:6a20:1395:b0:14c:6a05:dfbf with SMTP id
 hn21-20020a056a20139500b0014c6a05dfbfmr1647123pzc.60.1694160017188; 
 Fri, 08 Sep 2023 01:00:17 -0700 (PDT)
Received: from localhost.localdomain ([180.230.198.109])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a17090a414500b0026f919ff9a1sm2485341pjg.10.2023.09.08.01.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 01:00:16 -0700 (PDT)
From: Jaewon Jung <jaewon8868@gmail.com>
X-Google-Original-From: Jaewon Jung <jw.jung@navercorp.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org,
	Jaewon Jung <jw.jung@navercorp.com>
Subject: [PATCH] doc: delete unused values kernel command line
Date: Fri,  8 Sep 2023 17:00:01 +0900
Message-Id: <20230908080001.31231-1-jw.jung@navercorp.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Fri, 08 Sep 2023 12:59:17 +0200
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

Delete "boot=local", "noswap" unused values in kernel command line

Signed-off-by: Jaewon Jung <jw.jung@navercorp.com>
---
 doc/board/google/chromebook_coral.rst | 4 ++--
 doc/usage/cmd/bootflow.rst            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/board/google/chromebook_coral.rst b/doc/board/google/chromebook_coral.rst
index 23e2db4556..1ee634c6c2 100644
--- a/doc/board/google/chromebook_coral.rst
+++ b/doc/board/google/chromebook_coral.rst
@@ -88,7 +88,7 @@ Here is the console output::
   Net:   No ethernet found.
   SF: Detected w25q128fw with page size 256 Bytes, erase size 4 KiB, total 16 MiB
   Hit any key to stop autoboot:  0
-  cmdline=console= loglevel=7 init=/sbin/init cros_secure oops=panic panic=-1 root=PARTUUID=${uuid}/PARTNROFF=1 rootwait rw dm_verity.error_behavior=3 dm_verity.max_bios=-1 dm_verity.dev_wait=0 dm="1 vroot none rw 1,0 3788800 verity payload=ROOT_DEV hashtree=HASH_DEV hashstart=3788800 alg=sha1 root_hexdigest=55052b629d3ac889f25a9583ea12cdcd3ea15ff8 salt=a2d4d9e574069f4fed5e3961b99054b7a4905414b60a25d89974a7334021165c" noinitrd vt.global_cursor_default=0 kern_guid=${uuid} add_efi_memmap boot=local noresume noswap i915.modeset=1 Kernel command line: "console= loglevel=7 init=/sbin/init cros_secure oops=panic panic=-1 root=PARTUUID=35c775e7-3735-d745-93e5-d9e0238f7ed0/PARTNROFF=1 rootwait rw dm_verity.error_behavior=3 dm_verity.max_bios=-1 dm_verity.dev_wait=0 dm="1 vroot none rw 1,0 3788800 verity payload=ROOT_DEV hashtree=HASH_DEV hashstart=3788800 alg=sha1 root_hexdigest=55052b629d3ac889f25a9583ea12cdcd3ea15ff8 salt=a2d4d9e574069f4fed5e3961b99054b7a4905414b60a25d89974a7334021165c" n
 oinitrd vt.global_cursor_default=0 kern_guid=35c775e7-3735-d745-93e5-d9e0238f7ed0 add_efi_memmap boot=local noresume noswap i915.modeset=1 tpm_tis.force=1 tpm_tis.interrupts=0 nmi_watchdog=panic,lapic disablevmx=off  "
+  cmdline=console= loglevel=7 init=/sbin/init cros_secure oops=panic panic=-1 root=PARTUUID=${uuid}/PARTNROFF=1 rootwait rw dm_verity.error_behavior=3 dm_verity.max_bios=-1 dm_verity.dev_wait=0 dm="1 vroot none rw 1,0 3788800 verity payload=ROOT_DEV hashtree=HASH_DEV hashstart=3788800 alg=sha1 root_hexdigest=55052b629d3ac889f25a9583ea12cdcd3ea15ff8 salt=a2d4d9e574069f4fed5e3961b99054b7a4905414b60a25d89974a7334021165c" noinitrd vt.global_cursor_default=0 kern_guid=${uuid} add_efi_memmap noresume i915.modeset=1 Kernel command line: "console= loglevel=7 init=/sbin/init cros_secure oops=panic panic=-1 root=PARTUUID=35c775e7-3735-d745-93e5-d9e0238f7ed0/PARTNROFF=1 rootwait rw dm_verity.error_behavior=3 dm_verity.max_bios=-1 dm_verity.dev_wait=0 dm="1 vroot none rw 1,0 3788800 verity payload=ROOT_DEV hashtree=HASH_DEV hashstart=3788800 alg=sha1 root_hexdigest=55052b629d3ac889f25a9583ea12cdcd3ea15ff8 salt=a2d4d9e574069f4fed5e3961b99054b7a4905414b60a25d89974a7334021165c" noinitrd vt.global_
 cursor_default=0 kern_guid=35c775e7-3735-d745-93e5-d9e0238f7ed0 add_efi_memmap noresume i915.modeset=1 tpm_tis.force=1 tpm_tis.interrupts=0 nmi_watchdog=panic,lapic disablevmx=off  "
   Setup located at 00090000:
 
   ACPI RSDP addr      : 7991f000
@@ -136,7 +136,7 @@ Here is the console output::
   Ext loader ver      : 0
   Ext loader type     : 0
   Command line ptr    : 99000
-     console= loglevel=7 init=/sbin/init cros_secure oops=panic panic=-1 root=PARTUUID=35c775e7-3735-d745-93e5-d9e0238f7ed0/PARTNROFF=1 rootwait rw dm_verity.error_behavior=3 dm_verity.max_bios=-1 dm_verity.dev_wait=0 dm="1 vroot none rw 1,0 3788800 verity payload=ROOT_DEV hashtree=HASH_DEV hashstart=3788800 alg=sha1 root_hexdigest=55052b629d3ac889f25a9583ea12cdcd3ea15ff8 salt=a2d4d9e574069f4fed5e3961b99054b7a4905414b60a25d89974a7334021165c" noinitrd vt.global_cursor_default=0 kern_guid=35c775e7-3735-d745-93e5-d9e0238f7ed0 add_efi_memmap boot=local noresume noswap i915.modeset=1 tpm_tis.force=1 tpm_tis.interrupts=0 nmi_watchdog=panic,lapic disablevmx=off
+     console= loglevel=7 init=/sbin/init cros_secure oops=panic panic=-1 root=PARTUUID=35c775e7-3735-d745-93e5-d9e0238f7ed0/PARTNROFF=1 rootwait rw dm_verity.error_behavior=3 dm_verity.max_bios=-1 dm_verity.dev_wait=0 dm="1 vroot none rw 1,0 3788800 verity payload=ROOT_DEV hashtree=HASH_DEV hashstart=3788800 alg=sha1 root_hexdigest=55052b629d3ac889f25a9583ea12cdcd3ea15ff8 salt=a2d4d9e574069f4fed5e3961b99054b7a4905414b60a25d89974a7334021165c" noinitrd vt.global_cursor_default=0 kern_guid=35c775e7-3735-d745-93e5-d9e0238f7ed0 add_efi_memmap noresume i915.modeset=1 tpm_tis.force=1 tpm_tis.interrupts=0 nmi_watchdog=panic,lapic disablevmx=off
   Initrd addr max     : 7fffffff
   Kernel alignment    : 200000
   Relocatable kernel  : 1
diff --git a/doc/usage/cmd/bootflow.rst b/doc/usage/cmd/bootflow.rst
index a8af1f8f60..65e3777cdc 100644
--- a/doc/usage/cmd/bootflow.rst
+++ b/doc/usage/cmd/bootflow.rst
@@ -495,8 +495,8 @@ the cmdline is word-wrapped here and some parts of the command line are elided::
           root_hexdigest=78cc462cd45aecbcd49ca476587b4dee59aa1b00ba5ece58e2c29ec9acd914ab
           salt=8dec4dc80a75dd834a9b3175c674405e15b16a253fdfe05c79394ae5fd76f66a"
         noinitrd vt.global_cursor_default=0
-        kern_guid=799c935b-ae62-d143-8493-816fa936eef7 add_efi_memmap boot=local
-        noresume noswap i915.modeset=1 ramoops.ecc=1 tpm_tis.force=0
+        kern_guid=799c935b-ae62-d143-8493-816fa936eef7 add_efi_memmap
+        noresume i915.modeset=1 ramoops.ecc=1 tpm_tis.force=0
         intel_pmc_core.warn_on_s0ix_failures=1 i915.enable_guc=3 i915.enable_dc=4
         xdomain=0 swiotlb=65536 intel_iommu=on i915.enable_psr=1
         usb-storage.quirks=13fe:6500:u
-- 
2.17.1

