Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C8CFD9E26
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 00:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4417F83D1A;
	Fri, 27 Feb 2026 01:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9584683E61; Fri, 27 Feb 2026 01:04:18 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 025CE83AA9
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 01:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vvlKU-000000005Pe-1wdJ; Fri, 27 Feb 2026 00:03:38 +0000
Date: Fri, 27 Feb 2026 00:03:29 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Otavio Salvador <otavio@ossystems.com.br>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, jerome@forissier.org,
 Philip Molloy <philip.molloy@analog.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>,
 Anshul Dalal <anshuld@ti.com>, Luca Weiss <luca.weiss@fairphone.com>,
 David Heidelberg <david@ixit.cz>, Shiji Yang <yangshiji66@outlook.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Francois Berder <fberder@outlook.fr>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [PATCH] treewide: fix uImage.FIT document paths
Message-ID: <0fd6b30e6181e10fcc30a1e23618e97adc9f3441.1772149772.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Commit 488445cefa1 ("doc: Move FIT into its own directory") moved the
documentation in doc/uImage.FIT to doc/usage/fit, subsequently all
documents and example sources have been converted to reStructuredText.

Fix (almost) all of the remaining occurrences of the old path and
filenames across the tree.

The exception is doc/uImage.FIT/command_syntax_extensions.txt which
apparently has been removed entirely, or at least I was unable to
locate where that document is now.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 README                                             | 2 +-
 board/technexion/pico-imx7d/README.pico-imx7d_BL33 | 2 +-
 boot/Kconfig                                       | 2 +-
 doc/README.dfutftp                                 | 2 +-
 doc/README.odroid                                  | 2 +-
 doc/README.uniphier                                | 2 +-
 doc/README.update                                  | 6 +++---
 doc/board/qualcomm/board.rst                       | 2 +-
 doc/develop/package/index.rst                      | 2 +-
 doc/usage/fit/howto.rst                            | 4 ++--
 lib/ecdsa/Kconfig                                  | 2 +-
 lib/rsa/Kconfig                                    | 4 ++--
 tools/image-host.c                                 | 2 +-
 13 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/README b/README
index 20a73bab802..e2d49e2ebd3 100644
--- a/README
+++ b/README
@@ -1662,7 +1662,7 @@ New uImage format (FIT)
 Flexible and powerful format based on Flattened Image Tree -- FIT (similar
 to Flattened Device Tree). It allows the use of images with multiple
 components (several kernels, ramdisks, etc.), with contents protected by
-SHA1, MD5 or CRC32. More details are found in the doc/uImage.FIT directory.
+SHA1, MD5 or CRC32. More details are found in the doc/usage/fit directory.
 
 
 Old uImage format
diff --git a/board/technexion/pico-imx7d/README.pico-imx7d_BL33 b/board/technexion/pico-imx7d/README.pico-imx7d_BL33
index 1b346093b88..9bf4b9907d3 100644
--- a/board/technexion/pico-imx7d/README.pico-imx7d_BL33
+++ b/board/technexion/pico-imx7d/README.pico-imx7d_BL33
@@ -41,4 +41,4 @@ fiptool_images. Run below command in ATF folder to generate FIP image.
 - Test
     Just boot up your board and wait for u-boot start up after ATF's log.
     For booting Linux in FIT image, please reference the FIT files in
-    u-boot doc/uImage.FIT/ folder.
+    u-boot doc/usage/fit/ folder.
diff --git a/boot/Kconfig b/boot/Kconfig
index e5db165424a..ab31b8f40ed 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -335,7 +335,7 @@ config TPL_LOAD_FIT
 	     property will not be loaded. This limitation also applies to FPGA
 	     images with the correct "compatible" string.
 	  2. For FPGA images, the supported "compatible" list is in the
-	     doc/uImage.FIT/source_file_format.txt.
+	     doc/usage/fit/source_file_format.rst.
 	  3. FDTs are only loaded for images with an "os" property of "u-boot".
 	     "linux" images are also supported with Falcon boot mode.
 
diff --git a/doc/README.dfutftp b/doc/README.dfutftp
index 12065079117..b25f398ee2e 100644
--- a/doc/README.dfutftp
+++ b/doc/README.dfutftp
@@ -94,7 +94,7 @@ FIT image format for download
 To create FIT image for download one should follow the update tftp README file
 (./doc/README.update) with one notable difference:
 
-The original snippet of ./doc/uImage.FIT/update_uboot.its
+The original snippet of ./doc/usage/fit/update_uboot.rst
 
 	images {
 		update@1 {
diff --git a/doc/README.odroid b/doc/README.odroid
index 1090a0ea141..6eb7e67474d 100644
--- a/doc/README.odroid
+++ b/doc/README.odroid
@@ -152,7 +152,7 @@ Two for both, kernel with device tree support and also without it:
 If proper fdt file exists then it will be automatically loaded,
 so for old kernel types, please remove fdt file from boot partition.
 
-The third boot option for multi image support (more info: doc/uImage.FIT/)
+The third boot option for multi image support (more info: doc/usage/fit/)
 - boot_fit - for binary file: "Image.itb"
 
 Default boot command: "autoboot"
diff --git a/doc/README.uniphier b/doc/README.uniphier
index 9f72cfa67b5..6f373aa2a6c 100644
--- a/doc/README.uniphier
+++ b/doc/README.uniphier
@@ -112,7 +112,7 @@ Verified Boot
 
 U-Boot supports an image verification method called "Verified Boot".
 This is a brief tutorial to utilize this feature for the UniPhier platform.
-You will find details documents in the doc/uImage.FIT directory.
+You will find details documents in the doc/usage/fit directory.
 
 Here, we take LD20 reference board for example, but it should work for any
 other boards including 32 bit SoCs.
diff --git a/doc/README.update b/doc/README.update
index bf4379279e2..f16b2d23af1 100644
--- a/doc/README.update
+++ b/doc/README.update
@@ -48,14 +48,14 @@ The auto-update feature uses the following configuration knobs:
 Since the update file is in FIT format, it is created from an *.its file using
 the mkimage tool. dtc tool with support for binary includes, e.g. in version
 1.2.0 or later, must also be available on the system where the update file is
-to be prepared. Refer to the doc/uImage.FIT/ directory for more details on FIT
+to be prepared. Refer to the doc/usage/fit/ directory for more details on FIT
 images.
 
 
 Example .its files
 ------------------
 
-- doc/uImage.FIT/update_uboot.its
+- doc/usage/fit/update_uboot.rst
 
   A simple example that can be used to create an update file for automatically
   replacing U-Boot image on a system.
@@ -83,7 +83,7 @@ Example .its files
   where the update will be placed is correct. Making mistake here and
   attempting the auto-update can render the system unusable.
 
-- doc/uImage.FIT/update3.its
+- doc/usage/fit/update3.rst
 
   An example containing three updates. It can be used to update Linux kernel,
   ramdisk and FDT blob stored in Flash. The procedure for preparing the update
diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
index e5dbc9816b9..eb800f8c535 100644
--- a/doc/board/qualcomm/board.rst
+++ b/doc/board/qualcomm/board.rst
@@ -27,7 +27,7 @@ We will build ``u-boot-nodtb.bin`` from the u-boot source tree.
 
 Generate FIT image (optional)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-See doc/uImage.FIT for more details
+See doc/usage/fit for more details
 
 Pack android boot image
 ^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/doc/develop/package/index.rst b/doc/develop/package/index.rst
index 4f448313f95..ff4c1882cbd 100644
--- a/doc/develop/package/index.rst
+++ b/doc/develop/package/index.rst
@@ -5,7 +5,7 @@ Package U-Boot
 
 U-Boot uses Flat Image Tree (FIT) as a standard file format for packaging
 images that it reads and boots. Documentation about FIT is available at
-doc/uImage.FIT
+doc/usage/fit
 
 U-Boot also provides binman for cases not covered by FIT. Examples include
 initial execution (since FIT itself does not have an executable header) and
diff --git a/doc/usage/fit/howto.rst b/doc/usage/fit/howto.rst
index 675c9aa5bb0..9c8d86e50be 100644
--- a/doc/usage/fit/howto.rst
+++ b/doc/usage/fit/howto.rst
@@ -157,7 +157,7 @@ development host is to be booted old-style (non-FDT) by U-Boot on an embedded
 target. Assume that the outcome of the build is vmlinux.bin.gz, a file which
 contains a gzip-compressed PPC Linux kernel (the only data file in this case).
 The uImage can be produced using the image source file
-doc/uImage.FIT/kernel.its (note that kernel.its assumes that vmlinux.bin.gz is
+doc/usage/fit/kernel.rst (note that kernel.its assumes that vmlinux.bin.gz is
 in the current working directory; if desired, an alternative path can be
 specified in the kernel.its file). Here's how to create the image and inspect
 its contents:
@@ -269,7 +269,7 @@ Example 2 -- new-style (FDT) kernel booting
 Consider another simple scenario, where a PPC Linux kernel is to be booted
 new-style, i.e., with a FDT blob. In this case there are two prerequisite data
 files: vmlinux.bin.gz (Linux kernel) and target.dtb (FDT blob). The uImage can
-be produced using image source file doc/uImage.FIT/kernel_fdt.its like this
+be produced using image source file doc/usage/fit/kernel_fdt.rst like this
 (note again, that both prerequisite data files are assumed to be present in
 the current working directory -- image source file kernel_fdt.its can be
 modified to take the files from some other location if needed):
diff --git a/lib/ecdsa/Kconfig b/lib/ecdsa/Kconfig
index 5c3d67d8144..ca13b6bfa1f 100644
--- a/lib/ecdsa/Kconfig
+++ b/lib/ecdsa/Kconfig
@@ -5,7 +5,7 @@ config ECDSA
 	  This enables the ECDSA (elliptic curve signature) algorithm for FIT
 	  image verification in U-Boot. The ECDSA algorithm is implemented
 	  using the driver model, so CONFIG_DM is required by this library.
-	  See doc/uImage.FIT/signature.txt for more details.
+	  See doc/usage/fit/signature.rst for more details.
 	  ECDSA is enabled for mkimage regardless of this option.
 
 if ECDSA
diff --git a/lib/rsa/Kconfig b/lib/rsa/Kconfig
index 1a763149c05..12a71c3df6f 100644
--- a/lib/rsa/Kconfig
+++ b/lib/rsa/Kconfig
@@ -6,7 +6,7 @@ config RSA
 	help
 	  RSA support. This enables the RSA algorithm used for FIT image
 	  verification in U-Boot.
-	  See doc/uImage.FIT/signature.txt for more details.
+	  See doc/usage/fit/signature.rst for more details.
 	  The Modular Exponentiation algorithm in RSA is implemented using
 	  driver model. So CONFIG_DM needs to be enabled by default for this
 	  library to function.
@@ -88,7 +88,7 @@ config RSA_SOFTWARE_EXP
 	  Enables driver for modular exponentiation in software. This is a RSA
 	  algorithm used in FIT image verification. It required RSA Key as
 	  input.
-	  See doc/uImage.FIT/signature.txt for more details.
+	  See doc/usage/fit/signature.rst for more details.
 
 config RSA_FREESCALE_EXP
 	bool "Enable RSA Modular Exponentiation with FSL crypto accelerator"
diff --git a/tools/image-host.c b/tools/image-host.c
index 48d69191c92..8b550af0dc1 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -650,7 +650,7 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
  *     |- algo = "sha1"
  *     |- value = sha1(data)
  *
- * For signature details, please see doc/uImage.FIT/signature.txt
+ * For signature details, please see doc/usage/fit/signature.rst
  *
  * @keydir	Directory containing *.key and *.crt files (or NULL)
  * @keydest	FDT Blob to write public keys into (NULL if none)
-- 
2.53.0
