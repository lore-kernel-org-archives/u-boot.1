Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA51CF8853
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 23:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1FAF88CA2;
	Sat,  5 Oct 2024 01:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728083295;
	bh=nAUmoJFGKj3sFv+V9hP4JUBotMBS86EE24cuRkQMa6o=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Rj1Cr6tE0lE9zjeHi1E9xODxah3u4/RKH4Pp3Lfa9lb1n1YVnVx5PX2vsekpkJYqr
	 /IAYOdCLoLSnFRugw6B2r1gvK+H9xiaRjEsBtC9olwTHVbHY8PAYy/y8PlYEfS2lDR
	 Ps3PrfYfPL65FNr1iQjCCmS6/aQOSZnRnQD+tCXmrNFW3Ni5EmOgiqy8MkuHiQPTpQ
	 P/kPOF3/7CEnfLIM8/wMTO/UcLj1Y1uN3b3G68tjxnnM6LfpgmUl6JskAjtQLGwz1Z
	 ppTF1nXHBfcNeDofbPTv0XKYsBCHAp9xO0rMDpXW/4VOuNzgr6FXExu0OkzgE6AtMT
	 lKU9Vx8j68OEw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 26D1F88AC2;
 Sat,  5 Oct 2024 01:08:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728083294;
 bh=nAUmoJFGKj3sFv+V9hP4JUBotMBS86EE24cuRkQMa6o=;
 h=From:To:Cc:Subject:Date:From;
 b=LwxGJvXmC7KwoLQDZVyG8hg5Mp4VoFVXnW0QwvmBGbyHmDwfokvJll4kAlDoO32Mu
 RZuHKhada/mN07QRBGMdxZqIdlJME/7qBKNKKyvDu3gB465UkLfSudgy7jE2GWiaow
 wPziHk8qNQrCB5hxTSzj34g5SfmrQw3SfyCFvAgqKnRc2LefrPGp1dbW6ULUk7f4j8
 McEz9bQXSR5kQMIqu1+B8JVJ7U7Wymna2J5Yto38jV8k9z64BFxQr4aC7keqEk1/6k
 Mai5I807liPY8QjcVvr37V4L5oqZPsSXMmyPuWEwqFTiGX4N3+QgzelQVdeFhNHKs1
 mwzYnDwcQPuVg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/2] Makefile: Drop SPL_FIT_SOURCE support
Date: Sat,  5 Oct 2024 01:07:13 +0200
Message-ID: <20241004230756.371153-1-marex@denx.de>
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

The SPL_FIT_SOURCE is long superseded by SPL_FIT_GENERATOR which
is long superseded by binman, drop SPL_FIT_SOURCE support as there
are no more users.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
NOTE: Depends on https://lore.kernel.org/u-boot/20241004225916.361000-1-marex@denx.de/
---
 Makefile                |  6 ------
 boot/Kconfig            |  8 --------
 doc/usage/fit/howto.rst | 11 +++--------
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index af24de4165e..a70926ec2fa 100644
--- a/Makefile
+++ b/Makefile
@@ -1417,18 +1417,12 @@ u-boot.ldr.hex u-boot.ldr.srec: u-boot.ldr FORCE
 # or a generator script
 # NOTE: Please do not use this. We are migrating away from Makefile rules to use
 # binman instead.
-ifneq ($(CONFIG_SPL_FIT_SOURCE),"")
-U_BOOT_ITS := u-boot.its
-$(U_BOOT_ITS): $(subst ",,$(CONFIG_SPL_FIT_SOURCE))
-	$(call if_changed,copy)
-else
 ifneq ($(CONFIG_USE_SPL_FIT_GENERATOR),)
 U_BOOT_ITS := u-boot.its
 $(U_BOOT_ITS): $(U_BOOT_ITS_DEPS) FORCE
 	$(srctree)/$(CONFIG_SPL_FIT_GENERATOR) \
 	$(patsubst %,$(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) > $@
 endif
-endif
 
 ifdef CONFIG_SPL_LOAD_FIT
 MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
diff --git a/boot/Kconfig b/boot/Kconfig
index 925afe06a19..51e6cd6cb1d 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -282,14 +282,6 @@ config SPL_FIT_IMAGE_POST_PROCESS
 	  injected into the FIT creation (i.e. the blobs would have been pre-
 	  processed before being added to the FIT image).
 
-config SPL_FIT_SOURCE
-	string ".its source file for U-Boot FIT image"
-	depends on SPL_FIT
-	help
-	  Specifies a (platform specific) FIT source file to generate the
-	  U-Boot FIT image. This could specify further image to load and/or
-	  execute.
-
 config USE_SPL_FIT_GENERATOR
 	bool "Use a script to generate the .its script"
 	depends on SPL_FIT
diff --git a/doc/usage/fit/howto.rst b/doc/usage/fit/howto.rst
index b5097d4460b..280eff724f6 100644
--- a/doc/usage/fit/howto.rst
+++ b/doc/usage/fit/howto.rst
@@ -57,14 +57,9 @@ own subnode under the /images node, which should then be referenced from one or
 multiple /configurations subnodes. The required images must be enumerated in
 the "loadables" property as a list of strings.
 
-If a platform specific image source file (.its) is shipped with the U-Boot
-source, it can be specified using the CONFIG_SPL_FIT_SOURCE Kconfig symbol.
-In this case it will be automatically used by U-Boot's Makefile to generate
-the image.
-If a static source file is not flexible enough, CONFIG_SPL_FIT_GENERATOR
-can point to a script which generates this image source file during
-the build process. It gets passed a list of device tree files (taken from the
-CONFIG_OF_LIST symbol).
+CONFIG_SPL_FIT_GENERATOR can point to a script which generates this image source
+file during the build process. It gets passed a list of device tree files (taken
+from the CONFIG_OF_LIST symbol).
 
 The SPL also records to a DT all additional images (called loadables) which are
 loaded. The information about loadables locations is passed via the DT node with
-- 
2.45.2

