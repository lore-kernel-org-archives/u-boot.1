Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB51EC3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6F728898E;
	Tue, 16 Jul 2024 09:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LiuN29Bx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF2418875C; Tue, 16 Jul 2024 09:04:31 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8988C8895E
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-427ad8bd88eso12978065e9.2
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113468; x=1721718268; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MdF+CUFPf5aVmCB32npUJ9gXQFNzkGbk4EUygWj13yI=;
 b=LiuN29Bx8zZlk10GDUwpkCeUkQn5ksfLIecCcizimW708jML7+a67KySv39QMWhRCX
 uF/21ITfdDA/FNq40NJ7E45SrjJNrbsF/uqZqOf2rNCbKMa1gR86DmXW73fIQJ0kAoIi
 cB8IAccT4vgQUOepDRdugRt20dHWsNf9NAVr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113468; x=1721718268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MdF+CUFPf5aVmCB32npUJ9gXQFNzkGbk4EUygWj13yI=;
 b=Mvf8PhGL7V7fS/ptIqgRROerOS6ot7EqNrgpNrfkdeeI1j5RSEM6AOKtU5nAYBO5rZ
 ozpDT8ceCSxMdz6Msxrqu1U+zreQl2nAVXKKIEcoyjlVuLdmQiaC082t08LxiPEP+x6y
 MYOe3E6weYJiLkIEEm2266Idh1Loy4rmV8sIEawpm48JFhsdnGs/vBRDC4qw7pAuHSJo
 X8vLqtdwC31jG5RuiPL67NqauFUgLW3V19IjPgzZL5aGf+NhQrhE1gefpWosYJdLfRta
 Euw7JzxHzR9SELgqBO97yQB+iVWPdkMZ/Bjntdi4Px9IxPWHYbfS21pxSD0xYvMKUWeF
 8eNQ==
X-Gm-Message-State: AOJu0Yz/yWCJkPht5T51rsOiw4HQvKofxW8iTxhLpgFG8Dmq2gMrGYVj
 soN38/wGxsxJltd8z49ym1yzksYeniDHgTBPocJVPidLiqN4zEzh60J5mXQnNuaNN9FoaMGHokU
 =
X-Google-Smtp-Source: AGHT+IHs7xbFCqlv8ID8a8Kf2VEBbg21KVYkWEYQxcO0M+DX8NkLvcCHNOsKDqeIac9knUh4cMTbQw==
X-Received: by 2002:a05:600c:4455:b0:426:62c5:473e with SMTP id
 5b1f17b1804b1-427ba697989mr6565905e9.26.1721113468623; 
 Tue, 16 Jul 2024 00:04:28 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc286sm149446295e9.33.2024.07.16.00.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:04:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 02/14] doc: Move bootstd into its own directory
Date: Tue, 16 Jul 2024 08:04:07 +0100
Message-Id: <20240716070419.1897560-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716070419.1897560-1-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
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

Before adding more files, move the bootstd docs into a new directory,
with an index.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 MAINTAINERS                                       |  2 +-
 doc/board/starfive/milk-v_mars_cm.rst             |  2 +-
 doc/develop/board_best_practices.rst              |  2 +-
 doc/develop/bootstd/index.rst                     |  9 +++++++++
 doc/develop/{bootstd.rst => bootstd/overview.rst} | 14 +++++++-------
 doc/develop/index.rst                             |  2 +-
 doc/usage/cmd/bootdev.rst                         |  2 +-
 doc/usage/cmd/bootflow.rst                        |  2 +-
 doc/usage/cmd/bootmeth.rst                        |  2 +-
 doc/usage/environment.rst                         |  2 +-
 10 files changed, 24 insertions(+), 15 deletions(-)
 create mode 100644 doc/develop/bootstd/index.rst
 rename doc/develop/{bootstd.rst => bootstd/overview.rst} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9bee9284cca..86b830aa997 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -927,7 +927,7 @@ F:	boot/bootmeth*.c
 F:	boot/bootstd.c
 F:	cmd/bootdev.c
 F:	cmd/bootflow.c
-F:	doc/develop/bootstd.rst
+F:	doc/develop/bootstd/
 F:	doc/usage/bootdev.rst
 F:	doc/usage/bootflow.rst
 F:	doc/usage/bootmeth.rst
diff --git a/doc/board/starfive/milk-v_mars_cm.rst b/doc/board/starfive/milk-v_mars_cm.rst
index b31de6043bb..52d4e5e9098 100644
--- a/doc/board/starfive/milk-v_mars_cm.rst
+++ b/doc/board/starfive/milk-v_mars_cm.rst
@@ -89,7 +89,7 @@ provide a default value.
 
 The variable *$fdtfile* is used in the boot process to automatically load
 a device-tree provided by the operating system. For details of the boot
-process refer to the :doc:`U-Boot Standard Boot <../../../develop/bootstd>`
+process refer to the :doc:`/develop/bootstd/index`
 description.
 
 Boot source selection
diff --git a/doc/develop/board_best_practices.rst b/doc/develop/board_best_practices.rst
index f44401eab7d..09632c80ce7 100644
--- a/doc/develop/board_best_practices.rst
+++ b/doc/develop/board_best_practices.rst
@@ -7,7 +7,7 @@ In addition to the regular best practices such as using :doc:`checkpatch` and
 following the :doc:`docstyle` and the :doc:`codingstyle` there are some things
 which are specific to creating a new board port.
 
-* Implement :doc:`bootstd` to ensure that most operating systems will be
+* Implement :doc:`bootstd/index` to ensure that most operating systems will be
   supported by the platform.
 
 * The platform defconfig file must be generated via `make savedefconfig`.
diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
new file mode 100644
index 00000000000..f4f87c7787c
--- /dev/null
+++ b/doc/develop/bootstd/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+Standard Boot
+=============
+
+.. toctree::
+   :maxdepth: 2
+
+   overview
diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd/overview.rst
similarity index 99%
rename from doc/develop/bootstd.rst
rename to doc/develop/bootstd/overview.rst
index 34631089ae0..761f61a573b 100644
--- a/doc/develop/bootstd.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0+:
 
-U-Boot Standard Boot
-====================
+Standard Boot Overview
+======================
 
 Introduction
 ------------
@@ -17,7 +17,7 @@ introduces the following concepts:
 For Linux, the distro (Linux distribution, e.g. Debian, Fedora) is responsible
 for creating a bootflow for each kernel combination that it wants to offer.
 These bootflows are stored on media so they can be discovered by U-Boot. This
-feature is typically called `distro boot` (see :doc:`distro`) because it is
+feature is typically called `distro boot` (see :doc:`../distro`) because it is
 a way for distributions to boot on any hardware.
 
 Traditionally U-Boot has relied on scripts to implement this feature. See
@@ -32,7 +32,7 @@ way to boot with U-Boot. The feature is extensible to different Operating
 Systems (such as Chromium OS) and devices (beyond just block and network
 devices). It supports EFI boot and EFI bootmgr too.
 
-Finally, standard boot supports the operation of :doc:`vbe`.
+Finally, standard boot supports the operation of :doc:`../vbe`.
 
 Bootflow
 --------
@@ -427,16 +427,16 @@ Three commands are available:
 
 `bootdev`
     Allows listing of available bootdevs, selecting a particular one and
-    getting information about it. See :doc:`../usage/cmd/bootdev`
+    getting information about it. See :doc:`/usage/cmd/bootdev`
 
 `bootflow`
     Allows scanning one or more bootdevs for bootflows, listing available
     bootflows, selecting one, obtaining information about it and booting it.
-    See :doc:`../usage/cmd/bootflow`
+    See :doc:`/usage/cmd/bootflow`
 
 `bootmeth`
     Allow listing of available bootmethds and setting the order in which they
-    are tried. See :doc:`../usage/cmd/bootmeth`
+    are tried. See :doc:`/usage/cmd/bootmeth`
 
 .. _BootflowStates:
 
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index f9c4bf839ee..c0107a783fc 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -29,7 +29,7 @@ Implementation
 
    directories
    bloblist
-   bootstd
+   bootstd/index
    ci_testing
    commands
    config_binding
diff --git a/doc/usage/cmd/bootdev.rst b/doc/usage/cmd/bootdev.rst
index f759abab354..98a0f43c580 100644
--- a/doc/usage/cmd/bootdev.rst
+++ b/doc/usage/cmd/bootdev.rst
@@ -22,7 +22,7 @@ Description
 The `bootdev` command is used to manage bootdevs. It can list available
 bootdevs, select one and obtain information about it.
 
-See :doc:`../../develop/bootstd` for more information about bootdevs in general.
+See :doc:`/develop/bootstd/index` for more information about bootdevs in general.
 
 
 bootdev list
diff --git a/doc/usage/cmd/bootflow.rst b/doc/usage/cmd/bootflow.rst
index 6519e4880a9..5d41fe37a7a 100644
--- a/doc/usage/cmd/bootflow.rst
+++ b/doc/usage/cmd/bootflow.rst
@@ -26,7 +26,7 @@ Description
 The `bootflow` command is used to manage bootflows. It can scan bootdevs to
 locate bootflows, list them and boot them.
 
-See :doc:`../../develop/bootstd` for more information.
+See :doc:`/develop/bootstd/index` for more information.
 
 Note that `CONFIG_BOOTSTD_FULL` (which enables `CONFIG_CMD_BOOTFLOW_FULL) must
 be enabled to obtain full functionality with this command. Otherwise, it only
diff --git a/doc/usage/cmd/bootmeth.rst b/doc/usage/cmd/bootmeth.rst
index bac9fdf85cd..c3d2ec1574b 100644
--- a/doc/usage/cmd/bootmeth.rst
+++ b/doc/usage/cmd/bootmeth.rst
@@ -21,7 +21,7 @@ Description
 The `bootmeth` command is used to manage bootmeths. It can list them and change
 the order in which they are used.
 
-See :doc:`../../develop/bootstd` for more information.
+See :doc:`/develop/bootstd/index` for more information.
 
 
 .. _bootmeth_order:
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index 7d4b448cb30..cc33d3ec0f2 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -100,7 +100,7 @@ to add environment variables.
 
 Board maintainers are encouraged to migrate to the text-based environment as it
 is easier to maintain. The distro-board script still requires the old-style
-environments, so use :doc:`../develop/bootstd` instead.
+environments, so use :doc:`/develop/bootstd/index` instead.
 
 
 List of environment variables
-- 
2.34.1

