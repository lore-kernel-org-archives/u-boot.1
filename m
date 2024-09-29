Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7740CF6497
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 09:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34E408852D;
	Sun, 29 Sep 2024 11:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="M/nmDhs1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 792AE889B3; Sun, 29 Sep 2024 11:27:52 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B434C8839E
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 11:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7db12af2f31so2888982a12.1
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1727602066; x=1728206866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P6D4VYfv79x+cY/bGoNby3LJalqXonBn0miFpPAE7uw=;
 b=M/nmDhs1TQDSAGN9f3xIxVg+TvpBulvQJoWVMit8nxFD97BGUFNqY2WBW4fGRm206f
 coFK2cZzuTPv5nI3WHuO+lDvn8c0wxxe+VMiPp7teHstYLh6niIBwt/A+MH3WZsXomok
 zRbQ2G8zWqLOvtyo0RE8NW26quNrgJxQNNb6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727602066; x=1728206866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P6D4VYfv79x+cY/bGoNby3LJalqXonBn0miFpPAE7uw=;
 b=JbyxIMcPkOmx5FQqKVFs3x4+oyRIJ7f3O+1AkFwk2xYcAcTyPkxIjz0xFUcZlq5dVP
 +xtanXdwK8kMHsMs9sUDnchvu3rVlSp2xEHuDY2/IBQCgxJQLpC7kh5J3bBMt86Z/+tR
 6BvcuKFUkkMsTe4MmsSIB+zn6Rk/wu/HSNYHhER25fu3r+vfZNB+0fN4ieIMSF7r0Xlx
 FQa+v9OUV55Egpvd8rpUT82/39/inu853V1NUEB1ivLHQm38BgxO3hp4nyMJCYrcl5PV
 Sb/AsBICdka9oDMe8PsELgq4bmHv44W5CAciSS+2bihfHNo3d+RMYnenh9YVruGEDGit
 71mw==
X-Gm-Message-State: AOJu0Yy9IWVOcUaR5w+GPNX7AFDeZ9CIXdWN1984fmGIzqXIePeYKgUn
 mHlwn1fQ8UJh0NIgaY6oefjb0gOQlUoERcTVUop+/Znfd8/kFv730ZcHEiX6+otEt1TILcy5FkH
 s7RI=
X-Google-Smtp-Source: AGHT+IG6rdIa4ILggpfCioDvX8nwl9QwKf0AmMpb03vukMwyzxjep7X92vCMmQHzjTM1fbzU0ZpaVQ==
X-Received: by 2002:a17:90b:1247:b0:2e0:8028:3f37 with SMTP id
 98e67ed59e1d1-2e0b89d4c8emr10771806a91.11.1727602066364; 
 Sun, 29 Sep 2024 02:27:46 -0700 (PDT)
Received: from shiro.work.home.arpa ([2400:4162:2428:2ffe:355d:54b6:cddd:c153])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2e0b6c81886sm5471982a91.23.2024.09.29.02.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 02:27:46 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: u-boot@lists.denx.de
Cc: Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] cmd: Make bootvx independent of bootelf
Date: Sun, 29 Sep 2024 18:27:39 +0900
Message-ID: <20240929092739.2513768-1-daniel@0x0f.com>
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

There are lots of usecases for running baremetal ELF
binaries via bootelf but if you enable bootelf you
get bootvx as well and you probably don't want or need
it.

Hide bootvx behind it's own configuration option.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 cmd/Kconfig | 11 +++++++++--
 cmd/elf.c   |  6 ++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda426..262c4118f7f6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -491,11 +491,18 @@ config CMD_CEDIT
 	  loading and saving of configuration as well as showing an editor.
 
 config CMD_ELF
-	bool "bootelf, bootvx"
+	bool "bootelf"
 	default y
 	select LIB_ELF
 	help
-	  Boot an ELF/vxWorks image from the memory.
+	  Boot an ELF image from memory.
+
+config CMD_ELF_BOOTVX
+	bool "bootvx"
+	default y
+	depends on CMD_ELF
+	help
+	  Boot a vxWorks image from memory
 
 config CMD_ELF_FDT_SETUP
 	bool "Flattened Device Tree setup in bootelf cmd"
diff --git a/cmd/elf.c b/cmd/elf.c
index 673c6c30511c..fe7f06ef74eb 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -10,8 +10,10 @@
 #include <env.h>
 #include <image.h>
 #include <log.h>
+#ifdef CONFIG_CMD_ELF_BOOTVX
 #include <net.h>
 #include <vxworks.h>
+#endif
 #ifdef CONFIG_X86
 #include <vesa.h>
 #include <asm/cache.h>
@@ -100,6 +102,7 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return rcode;
 }
 
+#ifdef CONFIG_CMD_ELF_BOOTVX
 /*
  * Interpreter command to boot VxWorks from a memory image.  The image can
  * be either an ELF image or a raw binary.  Will attempt to setup the
@@ -307,6 +310,7 @@ int do_bootvx(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	return 1;
 }
+#endif
 
 U_BOOT_CMD(
 	bootelf, CONFIG_SYS_MAXARGS, 0, do_bootelf,
@@ -323,8 +327,10 @@ U_BOOT_CMD(
 #endif
 );
 
+#ifdef CONFIG_CMD_ELF_BOOTVX
 U_BOOT_CMD(
 	bootvx, 2, 0, do_bootvx,
 	"Boot vxWorks from an ELF image",
 	" [address] - load address of vxWorks ELF image."
 );
+#endif
-- 
2.43.0

