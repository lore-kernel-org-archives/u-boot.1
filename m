Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E53D2E9C4
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 09:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8100788FC4;
	Mon, 11 Nov 2024 10:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QHsmeIig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A218932C; Mon, 11 Nov 2024 10:05:50 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C5D188FAF
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 10:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 09FD43F1E9; 
 Mon, 11 Nov 2024 09:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731315946;
 bh=qY/+KEzJtcFLOj+B148GrH3jI+Nks0FCKFjcget5bl4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=QHsmeIignH5rPA01YfCLzMQv21B61IysJkXIctsEnJDglX7gaNpWiyC4CHit2ZJ0n
 9i765Ig8qfBRExPMHTyQ43NacyCHZ+xezWtJHKMoStarMlz3Xab4K0ajj/Hqzsyasq
 XhIOePBC7AEKsrbf+DM5eh+GgSzI6kwE9Flf7paZouEmnMo8TCXdERnZzoh0QZf7jf
 I+kQFdmAUAGnMHum3OJNbBVhNm62n8mvbY0aoGGi9cKvhukZkqOcIJOOF4s3HtQSwC
 d7lBsd4dPVY4nPjM+5T766K6/M//HmCjcT+QP9J8lLUYomroSH7ApWCv5XNzRLVL9r
 foXTpjmoVR/KA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: move README.kconfig to HTML documentation
Date: Mon, 11 Nov 2024 10:05:39 +0100
Message-ID: <20241111090539.32252-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

* format according to Sphinx style
* add link to Linux Kconfig documentation
* sort table alphabetically in 'Conversion from boards.cfg to Kconfig'

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/README.kconfig      | 151 --------------------------------------
 doc/develop/index.rst   |   1 +
 doc/develop/kconfig.rst | 157 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 151 deletions(-)
 delete mode 100644 doc/README.kconfig
 create mode 100644 doc/develop/kconfig.rst

diff --git a/doc/README.kconfig b/doc/README.kconfig
deleted file mode 100644
index 808cf56e59c..00000000000
--- a/doc/README.kconfig
+++ /dev/null
@@ -1,151 +0,0 @@
-Kconfig in U-Boot
-=================
-
-This document describes the configuration infrastructure of U-Boot.
-
-The conventional configuration was replaced by Kconfig at v2014.10-rc1 release.
-
-
-Language Specification
-----------------------
-
-Kconfig originates in Linux Kernel.
-See the file "Documentation/kbuild/kconfig*.txt" in your Linux Kernel
-source directory for a basic specification of Kconfig.
-
-
-Difference from Linux's Kconfig
--------------------------------
-
-Here are some worth-mentioning configuration targets.
-
-- silentoldconfig
-
-  This target updates .config, include/generated/autoconf.h and
-  include/configs/* as in Linux.  In U-Boot, it also does the following
-  for the compatibility with the old configuration system:
-
-   * create a symbolic link "arch/${ARCH}/include/asm/arch" pointing to
-     the SoC/CPU specific header directory
-   * create include/config.h
-   * create include/autoconf.mk
-   * create spl/include/autoconf.mk (SPL and TPL only)
-   * create tpl/include/autoconf.mk (TPL only)
-
-   If we could completely switch to Kconfig in a long run
-   (i.e. remove all the include/configs/*.h), those additional processings
-   above would be removed.
-
-- defconfig
-
-  In U-Boot, "make defconfig" is a shorthand of "make sandbox_defconfig"
-
-- <board>_defconfig
-
-  Now it works as in Linux.
-  The prefixes such as "+S:" in *_defconfig are deprecated.
-  You can simply remove the prefixes.  Do not add them for new boards.
-
-- <board>_config
-
-  This does not exist in Linux's Kconfig.
-  "make <board>_config" works the same as "make <board>_defconfig".
-  Prior to Kconfig, in U-Boot, "make <board>_config" was used for the
-  configuration.  It is still supported for backward compatibility, so
-  we do not need to update the distro recipes.
-
-
-The other configuration targets work as in Linux Kernel.
-
-
-Migration steps to Kconfig
---------------------------
-
-Prior to Kconfig, the C preprocessor based board configuration had been used
-in U-Boot.
-
-Although Kconfig was introduced and some configs have been moved to Kconfig,
-many of configs are still defined in C header files.  It will take a very
-long term to move all of them to Kconfig.  In the interim, the two different
-configuration infrastructures should coexist.
-The configuration files are generated by both Kconfig and the old preprocessor
-based configuration as follows:
-
-Configuration files for use in C sources
-  - include/generated/autoconf.h     (generated by Kconfig for Normal)
-  - include/configs/<board>.h        (exists for all boards)
-
-Configuration file for use in makefiles
-  - include/config/auto.conf         (generated by Kconfig)
-  - include/autoconf.mk              (generated by the old config for Normal)
-  - spl/include/autoconfig.mk        (generated by the old config for SPL)
-  - tpl/include/autoconfig.mk        (generated by the old config for TPL)
-
-When adding a new CONFIG macro, it is highly recommended to add it to Kconfig
-rather than to a header file.
-
-
-Conversion from boards.cfg to Kconfig
--------------------------------------
-
-Prior to Kconfig, boards.cfg was a primary database that contained Arch, CPU,
-SoC, etc. of all the supported boards.  It was deleted when switching to
-Kconfig.  Each field of boards.cfg was converted as follows:
-
- Status      ->  "S:" entry of MAINTAINERS
- Arch        ->  CONFIG_SYS_ARCH defined by Kconfig
- CPU         ->  CONFIG_SYS_CPU defined by Kconfig
- SoC         ->  CONFIG_SYS_SOC defined by Kconfig
- Vendor      ->  CONFIG_SYS_VENDOR defined by Kconfig
- Board       ->  CONFIG_SYS_BOARD defined by Kconfig
- Target      ->  File name of defconfig (configs/<target>_defconfig)
- Maintainers ->  "M:" entry of MAINTAINERS
-
-
-Tips to add/remove boards
--------------------------
-
-When adding a new board, the following steps are generally needed:
-
- [1] Add a header file include/configs/<target>.h
- [2] Make sure to define necessary CONFIG_SYS_* in Kconfig:
-       Define CONFIG_SYS_CPU="cpu" to compile arch/<arch>/cpu/<cpu>
-       Define CONFIG_SYS_SOC="soc" to compile arch/<arch>/cpu/<cpu>/<soc>
-       Define CONFIG_SYS_VENDOR="vendor" to compile board/<vendor>/common/*
-         and board/<vendor>/<board>/*
-       Define CONFIG_SYS_BOARD="board" to compile board/<board>/*
-         (or board/<vendor>/<board>/* if CONFIG_SYS_VENDOR is defined)
-       Define CONFIG_SYS_CONFIG_NAME="target" to include
-         include/configs/<target>.h
- [3] Add a new entry to the board select menu in Kconfig.
-     The board select menu is located in arch/<arch>/Kconfig or
-     arch/<arch>/*/Kconfig.
- [4] Add a MAINTAINERS file
-     It is generally placed at board/<board>/MAINTAINERS or
-     board/<vendor>/<board>/MAINTAINERS
- [5] Add configs/<target>_defconfig
-
-When removing an obsolete board, the following steps are generally needed:
-
- [1] Remove configs/<target>_defconfig
- [2] Remove include/configs/<target>.h if it is not used by any other boards
- [3] Remove board/<vendor>/<board>/* or board/<board>/* if it is not used
-     by any other boards
- [4] Update MAINTAINERS if necessary
- [5] Remove the unused entry from the board select menu in Kconfig
- [6] Add an entry to doc/README.scrapyard
-
-
-TODO
-----
-
-- In the pre-Kconfig, a single board had multiple entries in the boards.cfg
-  file with differences in the option fields.  The corresponding defconfig
-  files were auto-generated when switching to Kconfig.  Now we have too many
-  defconfig files compared with the number of the supported boards.  It is
-  recommended to have only one defconfig per board and allow users to select
-  the config options.
-
-- Move the config macros in header files to Kconfig.  When we move at least
-  macros used in makefiles, we can drop include/autoconfig.mk, which makes
-  the build scripts much simpler.
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 30f7fdb8847..d9f2a838207 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -13,6 +13,7 @@ General
    codingstyle
    designprinciples
    docstyle
+   kconfig
    memory
    patman
    process
diff --git a/doc/develop/kconfig.rst b/doc/develop/kconfig.rst
new file mode 100644
index 00000000000..3a2be54e117
--- /dev/null
+++ b/doc/develop/kconfig.rst
@@ -0,0 +1,157 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kconfig in U-Boot
+=================
+
+This document describes the configuration infrastructure of U-Boot.
+
+The conventional configuration was replaced by Kconfig at v2014.10-rc1 release.
+
+Language Specification
+----------------------
+
+The Kconfig configuration language originates in Linux kernel.
+See the Linux document
+`Kconfig Language <https://www.kernel.org/doc/html/latest/kbuild/kconfig-language.html>`_
+for a description of Kconfig.
+
+Difference from Linux's Kconfig
+-------------------------------
+
+Here are some worth-mentioning configuration targets.
+
+silentoldconfig
+  This target updates .config, include/generated/autoconf.h and
+  include/configs/* as in Linux.  In U-Boot, it also does the following
+  for the compatibility with the old configuration system:
+
+   * create a symbolic link "arch/${ARCH}/include/asm/arch" pointing to
+     the SoC/CPU specific header directory
+   * create include/config.h
+   * create include/autoconf.mk
+   * create spl/include/autoconf.mk (SPL and TPL only)
+   * create tpl/include/autoconf.mk (TPL only)
+
+   If we could completely switch to Kconfig in a long run
+   (i.e. remove all the include/configs/\*.h), those additional processings
+   above would be removed.
+
+defconfig
+  In U-Boot, "make defconfig" is a shorthand of "make sandbox_defconfig"
+
+<board>_defconfig
+  Now it works as in Linux.
+  The prefixes such as "+S:" in \*_defconfig are deprecated.
+  You can simply remove the prefixes.  Do not add them for new boards.
+
+<board>_config
+  This does not exist in Linux's Kconfig.
+  "make <board>_config" works the same as "make <board>_defconfig".
+  Prior to Kconfig, in U-Boot, "make <board>_config" was used for the
+  configuration.  It is still supported for backward compatibility, so
+  we do not need to update the distro recipes.
+
+The other configuration targets work as in Linux Kernel.
+
+Migration steps to Kconfig
+--------------------------
+
+Prior to Kconfig, the C preprocessor based board configuration had been used
+in U-Boot.
+
+Although Kconfig was introduced and some configs have been moved to Kconfig,
+many of configs are still defined in C header files.  It will take a very
+long term to move all of them to Kconfig.  In the interim, the two different
+configuration infrastructures should coexist.
+The configuration files are generated by both Kconfig and the old preprocessor
+based configuration as follows:
+
+Configuration files for use in C sources
+  - include/generated/autoconf.h     (generated by Kconfig for Normal)
+  - include/configs/<board>.h        (exists for all boards)
+
+Configuration file for use in makefiles
+  - include/config/auto.conf         (generated by Kconfig)
+  - include/autoconf.mk              (generated by the old config for Normal)
+  - spl/include/autoconfig.mk        (generated by the old config for SPL)
+  - tpl/include/autoconfig.mk        (generated by the old config for TPL)
+
+When adding a new CONFIG macro, it is highly recommended to add it to Kconfig
+rather than to a header file.
+
+Conversion from boards.cfg to Kconfig
+-------------------------------------
+
+Prior to Kconfig, boards.cfg was a primary database that contained Arch, CPU,
+SoC, etc. of all the supported boards. It was deleted when switching to
+Kconfig. Each field of boards.cfg was converted as follows:
+
+=========== ====================================================
+From        To
+=========== ====================================================
+Arch        CONFIG_SYS_ARCH defined by Kconfig
+Board       CONFIG_SYS_BOARD defined by Kconfig
+CPU         CONFIG_SYS_CPU defined by Kconfig
+Maintainers "M:" entry of MAINTAINERS
+SoC         CONFIG_SYS_SOC defined by Kconfig
+Status      "S:" entry of MAINTAINERS
+Target      File name of defconfig (configs/<target>\_defconfig)
+Vendor      CONFIG_SYS_VENDOR defined by Kconfig
+=========== ====================================================
+
+Tips to add/remove boards
+-------------------------
+
+When adding a new board, the following steps are generally needed:
+
+1. Add a header file include/configs/<target>.h
+
+2. Make sure to define necessary CONFIG_SYS_* in Kconfig:
+
+   * Define CONFIG_SYS_CPU="cpu" to compile arch/<arch>/cpu/<cpu>
+   * Define CONFIG_SYS_SOC="soc" to compile arch/<arch>/cpu/<cpu>/<soc>
+   * Define CONFIG_SYS_VENDOR="vendor" to compile board/<vendor>/common/\*
+     and board/<vendor>/<board>/\*
+   * Define CONFIG_SYS_BOARD="board" to compile board/<board>/\*
+     (or board/<vendor>/<board>/* if CONFIG_SYS_VENDOR is defined)
+     Define CONFIG_SYS_CONFIG_NAME="target" to include
+     include/configs/<target>.h
+
+3. Add a new entry to the board select menu in Kconfig.
+   The board select menu is located in arch/<arch>/Kconfig or
+   arch/<arch>/\*/Kconfig.
+
+4. Add a MAINTAINERS file
+   It is generally placed at board/<board>/MAINTAINERS or
+   board/<vendor>/<board>/MAINTAINERS
+
+5. Add configs/<target>_defconfig
+
+When removing an obsolete board, the following steps are generally needed:
+
+1. Remove configs/<target>_defconfig
+
+2. Remove include/configs/<target>.h if it is not used by any other boards
+
+3. Remove board/<vendor>/<board>/\* or board/<board>/\* if it is not used
+   by any other boards
+
+4. Update MAINTAINERS if necessary
+
+5. Remove the unused entry from the board select menu in Kconfig
+
+6. Add an entry to doc/README.scrapyard
+
+TODO
+----
+
+* In the pre-Kconfig, a single board had multiple entries in the boards.cfg
+  file with differences in the option fields. The corresponding defconfig
+  files were auto-generated when switching to Kconfig. Now we have too many
+  defconfig files compared with the number of the supported boards. It is
+  recommended to have only one defconfig per board and allow users to select
+  the config options.
+
+* Move the config macros in header files to Kconfig. When we move at least
+  macros used in makefiles, we can drop include/autoconfig.mk, which makes
+  the build scripts much simpler.
-- 
2.45.2

