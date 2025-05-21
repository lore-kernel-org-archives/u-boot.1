Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE4EC54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D1A82FBC;
	Thu, 22 May 2025 01:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R0i6OfYc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C6B82FC5; Thu, 22 May 2025 01:01:49 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 457C382FBC
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6065803ef35so2050925eaf.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868504; x=1748473304; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BBZGSfhNqe+cqmGCjULDiW+dDXxs1jonZXrmzc+KkFM=;
 b=R0i6OfYch8sXuauVuzDkSp31GZILplgbWuh4snqBRi4gd3Z87GfdEJFD9pl9C6OOL9
 8Jl/8bSq+CdtIXDByuBdbGGAxIBAMGJz0uXcll4s1v05t6SUTyvpW7SbjdZVxH2Az2mI
 WftPBXJzlik84boGlTEhpq9P5gEwTC4m9iODU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868504; x=1748473304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BBZGSfhNqe+cqmGCjULDiW+dDXxs1jonZXrmzc+KkFM=;
 b=I8th8m8MEKhCFwsEtVznDk3a+zeufFd8Ai3ZJ0idT6pPo/2mr27/fhwGW+D++q4+3L
 6qK89ptDhmdOhWMrUf/WGIqrmlBijzopJAvHZv26XC+dKj/TlZ3Un6okS8FucWXvl++b
 F6kzWzPUvdUgXfPzqoVjI5kZDyH8GlhLjEqKlGGHmg3bMBxQEovLQuegM6nM3Nc+cdTV
 UEBwWNgsnpPxmdCWosrKg05bcAnN2PQDKl2cbuQRC5fCqWKHjn/Yj6P0t13VEOcYdr5a
 JKXOD07U2aVp3T+IbCCBf24h8DsaU9OoRY2m6HGMKFsPV5T+416T8vTC89XXJ+DloNnD
 BuWA==
X-Gm-Message-State: AOJu0YzC1uc6Jqv7gecPx3kz3kF1tnOcPL3BpoVUQQ8U+qq6SZgvGk7f
 eA4IpPHpiRI6D/2kLc7G4TPncm53UORGwyo2yjFf/PJulFifV3wcx5hCquUdkniSDdJocNRcbnv
 c6FGZpIw=
X-Gm-Gg: ASbGncvBP3mYA/YIrw+QLrCITG80fMj7a14jfKDbKlyH7Ydl206aULXbNHsiypFvywd
 sZQls3KSYqWkdxX6o2pUErn4k4fWb59zxN3RmjDNW2lCh7yR/H99s4m4tGzvtYSHObtoBOQdomR
 n9jvaIujrU9N1v8t8x+MowOx8BK43c5OQnNBzal2OiRgw+dnEknQ+v10aFT6CLY8N25PH6tFjPU
 ejHxeNF36IOIBeoTGouBJQbiy07CnSti3kBjcGEXPikrdWGoZ6az7ctCSrNCX9uRIHfj/8+en0U
 DTqnTT5WE5YxvIZEbqjIg4889AZZeNcsFFqKE/a3sD8wYGIROX+XtJGO0ygytCpeE/9EDFpDE/Z
 QKFMcVYh28dLcDLk=
X-Google-Smtp-Source: AGHT+IGQuzZBKesZ1IRLIqHnBnMfy4eDqohznvsf05v9rJbPfNZ26Tf2iVLockPAFkR+H7GjkKBAgQ==
X-Received: by 2002:a4a:ee8b:0:b0:60b:87fa:80e8 with SMTP id
 006d021491bc7-60b87fa836bmr893878eaf.7.1747868503985; 
 Wed, 21 May 2025 16:01:43 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.42
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 14/17] include/ide.h: Cleanup usage
Date: Wed, 21 May 2025 16:51:19 -0600
Message-ID: <20250521230119.2084088-15-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521230119.2084088-1-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
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

At this point in time, <ide.h> provides the IDE_BUS macro and the
function prototype for ide_set_reset, which is used with IDE_RESET. The
only files which should include this header are the ones that either use
that macro or that function. Remove <blk.h> from <ide.h> and remove
<ide.h> from places which do not need it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 board/freescale/m5253demo/m5253demo.c | 1 +
 board/imgtec/malta/malta.c            | 1 -
 cmd/ide.c                             | 1 -
 common/board_r.c                      | 1 -
 disk/part.c                           | 1 -
 disk/part_amiga.c                     | 1 -
 disk/part_dos.c                       | 1 -
 disk/part_efi.c                       | 1 -
 disk/part_mac.c                       | 1 -
 include/ide.h                         | 2 --
 include/part.h                        | 1 -
 lib/efi_loader/efi_device_path.c      | 1 +
 12 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/board/freescale/m5253demo/m5253demo.c b/board/freescale/m5253demo/m5253demo.c
index 446a79e67232..50c5320b55cb 100644
--- a/board/freescale/m5253demo/m5253demo.c
+++ b/board/freescale/m5253demo/m5253demo.c
@@ -93,6 +93,7 @@ int testdram(void)
 
 #ifdef CONFIG_IDE
 #include <ata.h>
+#include <ide.h>
 void ide_set_reset(int idereset)
 {
 	atac_t *ata = (atac_t *) CONFIG_SYS_ATA_BASE_ADDR;
diff --git a/board/imgtec/malta/malta.c b/board/imgtec/malta/malta.c
index 4a72ab5cecad..0ffa964178f0 100644
--- a/board/imgtec/malta/malta.c
+++ b/board/imgtec/malta/malta.c
@@ -6,7 +6,6 @@
 
 #include <config.h>
 #include <fdt_support.h>
-#include <ide.h>
 #include <init.h>
 #include <net.h>
 #include <netdev.h>
diff --git a/cmd/ide.c b/cmd/ide.c
index 036489fda979..ed30f9468660 100644
--- a/cmd/ide.c
+++ b/cmd/ide.c
@@ -19,7 +19,6 @@
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 
-#include <ide.h>
 #include <ata.h>
 
 #ifdef CONFIG_LED_STATUS
diff --git a/common/board_r.c b/common/board_r.c
index b90a4d9ff695..a1183f0811dd 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -36,7 +36,6 @@
 #include <env.h>
 #include <env_internal.h>
 #include <fdtdec.h>
-#include <ide.h>
 #include <init.h>
 #include <initcall.h>
 #include <kgdb.h>
diff --git a/disk/part.c b/disk/part.c
index 303178161c08..9cbd03686f5d 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -8,7 +8,6 @@
 #include <command.h>
 #include <env.h>
 #include <errno.h>
-#include <ide.h>
 #include <log.h>
 #include <malloc.h>
 #include <part.h>
diff --git a/disk/part_amiga.c b/disk/part_amiga.c
index 5b8ae5762d3a..22bf99f1b88c 100644
--- a/disk/part_amiga.c
+++ b/disk/part_amiga.c
@@ -6,7 +6,6 @@
  */
 #include <command.h>
 #include <env.h>
-#include <ide.h>
 #include "part_amiga.h"
 #include <part.h>
 #include <vsprintf.h>
diff --git a/disk/part_dos.c b/disk/part_dos.c
index 96f748702fd5..5c77225cef93 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -15,7 +15,6 @@
 
 #include <blk.h>
 #include <command.h>
-#include <ide.h>
 #include <memalign.h>
 #include <vsprintf.h>
 #include <asm/unaligned.h>
diff --git a/disk/part_efi.c b/disk/part_efi.c
index 932d058c184c..68ba1d11e7b6 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -21,7 +21,6 @@
 #include <asm/unaligned.h>
 #include <command.h>
 #include <fdtdec.h>
-#include <ide.h>
 #include <malloc.h>
 #include <memalign.h>
 #include <part_efi.h>
diff --git a/disk/part_mac.c b/disk/part_mac.c
index 21c85942fd84..dd3ce0be832b 100644
--- a/disk/part_mac.c
+++ b/disk/part_mac.c
@@ -15,7 +15,6 @@
 #include <command.h>
 #include <log.h>
 #include <memalign.h>
-#include <ide.h>
 #include "part_mac.h"
 #include <part.h>
 
diff --git a/include/ide.h b/include/ide.h
index 2c25e74ede08..550b33056213 100644
--- a/include/ide.h
+++ b/include/ide.h
@@ -7,8 +7,6 @@
 #ifndef	_IDE_H
 #define _IDE_H
 
-#include <blk.h>
-
 #define IDE_BUS(dev)	(dev / (CONFIG_SYS_IDE_MAXDEVICE / CONFIG_SYS_IDE_MAXBUS))
 
 /**
diff --git a/include/part.h b/include/part.h
index fcb3c13dea4d..3fa2d8424b70 100644
--- a/include/part.h
+++ b/include/part.h
@@ -7,7 +7,6 @@
 #define _PART_H
 
 #include <blk.h>
-#include <ide.h>
 #include <u-boot/uuid.h>
 #include <linker_lists.h>
 #include <linux/errno.h>
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index c9bf2726fe24..66a951a8c1bb 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -10,6 +10,7 @@
 #include <blk.h>
 #include <dm.h>
 #include <dm/root.h>
+#include <ide.h>
 #include <log.h>
 #include <net.h>
 #include <usb.h>
-- 
2.43.0

