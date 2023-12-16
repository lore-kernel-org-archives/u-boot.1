Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAB8C46CCD
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 15:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEE1287536;
	Sat, 16 Dec 2023 16:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qhzTyrT6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C60A876D9; Sat, 16 Dec 2023 16:38:46 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 419E18646E
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 16:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.lan (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4B5793F5F0; 
 Sat, 16 Dec 2023 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702741123;
 bh=OHnC9YHuDo/wNaGKqw8kGmVC95gk1Zckv+n8UX/Dn5Y=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=qhzTyrT6Pv5vbo4OWBd6RqdWH7sdFfvnOR2nM4bJUrg/6aDNXkK7V/pPz/5PCppqG
 l8/WrGiXMt7aXt7pOQE4eKNHxzdzJIdR+aJi93OPGo4jIln97okjgE8ruefm6Ja+Ji
 nM3g68gY6LezEy1Kd/BYrTvyC/OI+MLp5zLMRrI+/GF9mCL6QGSh8ypQkB/mM+FXq0
 YGo4WEvNu9roF01XW44mGwf/pl7FFVm+wU6m7aFH/y6ZFl3vsxaKvkGJoHE2Zxzp3L
 Y1A9c9LVTljdrXYMMMaA/m4rA2Wf6rFEtU9lFXagkcjJ4GVR9qrZaZpWV+QVhGpk3A
 44hsq2U0bGMNg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] boot: CONFIG_CEDIT must depend on CONFIG_EXPO
Date: Sat, 16 Dec 2023 16:38:36 +0100
Message-Id: <20231216153836.81717-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Building sandbox_defconfig with

    CONFIG_CMD_CEDIT=y
    CONFIG_EXPO=n

fails with

    cmd/cedit.c:258:(.text.do_cedit_run+0x4c):
    undefined reference to `expo_apply_theme

Fix the dependencies.

Fixes: a0874dc4ac71 ("expo: Add a configuration editor")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/Kconfig  | 2 +-
 boot/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index b438002059..98273b2d3b 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1678,7 +1678,7 @@ menu "Configuration editor"
 
 config CEDIT
 	bool "Configuration editor"
-	depends on BOOTSTD
+	depends on EXPO
 	help
 	  Provides a way to deal with board configuration and present it to
 	  the user for adjustment.
diff --git a/boot/Makefile b/boot/Makefile
index de0eafed14..40931218ee 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -33,11 +33,11 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EFILOADER) += bootmeth_efi.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
+obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
 ifdef CONFIG_$(SPL_TPL_)BOOTSTD_FULL
 obj-$(CONFIG_CMD_BOOTEFI_BOOTMGR) += bootmeth_efi_mgr.o
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += bootflow_menu.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootflow_menu.o
-obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
 endif
 
 obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o
-- 
2.40.1

