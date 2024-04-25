Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7A5C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 23:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41E4089087;
	Fri, 26 Apr 2024 01:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714086458;
	bh=aClGLI+QLCSNnlo9Y0Shlq5uQdn/m+Od+JBZp4qH5BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JkK4tMOY3nzE0gmrLMzHdSy0C7Z9ooFvHbmtzz+5jHC+LsxSkigG4zOOmUQ1w0k/2
	 kbdvpHkvOzN2VwWb0lBVjLtHR0g54gn3PC91pxMY1kWx3P69qwhdUc0yWLLH0buDrH
	 +FbAvpvJXlTroUb13eydkDdWT+gigZltgH9QTLZ1Z8dTxTbZlc/BaN/geqSIzmqpc6
	 PdviftkGK7xXkdEXelpAypya52V8WdmwClCvuXUqPzq/vWy2P62o8BFxCDnIMgxKOv
	 8mlm8YWMe5gXbKA0h3hOcyr4NNd0mNKO3Bk9uQI2RTDLNXePFQUeKBRWZS1zeQvDcw
	 3iixjgWHL0A0Q==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BAB5988F15;
 Fri, 26 Apr 2024 01:07:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714086457;
 bh=aClGLI+QLCSNnlo9Y0Shlq5uQdn/m+Od+JBZp4qH5BI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RjZlScBBShcErujLb8F9b9ZQ6/EUryOOjk9wiWuK3S6ALjTt9JGPeETBENt+2dnDP
 NrBW7dy6asJouPaaZ0x9oYPN7brcwGftJphc2gOJq0Ow4bKKKHK6C20dq5gmfTS4WL
 mdoSbNfmuqfeLIHG2q4WDp9WUHYpIZwo/JD+XU9hHxPai23J/BggelMRH7FiWV1tcV
 Y03QnDqKHhMPJqGDWeIp9KD4kz+q8WcD9Q+hC/GCgJ6Vq31yhevNBytaWvRp5479KJ
 oFVrsi88OFFwVvE5HmIu7Zj/d33p5vQdkodTii1DJaOX5AvsOL07kHZ/g5w64YHrks
 MAcHEnKTE88UQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, kernel@puri.sm, u-boot@dh-electronics.com
Subject: [PATCH 2/2] imx: hab: Use nxp_imx8mcst etype for i.MX8M flash.bin
 signing
Date: Fri, 26 Apr 2024 01:07:02 +0200
Message-ID: <20240425230721.497441-2-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240425230721.497441-1-marex@denx.de>
References: <20240425230721.497441-1-marex@denx.de>
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

Update documentation and use nxp_imx8mcst binman etype for signing
of flash.bin instead of previous horrible shell scripting.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Cc: Angus Ainslie <angus@akkea.ca>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: kernel@puri.sm
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 doc/imx/habv4/csf_examples/mx8m/csf.sh        |  92 ------------
 doc/imx/habv4/csf_examples/mx8m/csf_fit.txt   |  30 ----
 doc/imx/habv4/csf_examples/mx8m/csf_spl.txt   |  33 ----
 doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 141 +++++++-----------
 4 files changed, 55 insertions(+), 241 deletions(-)
 delete mode 100644 doc/imx/habv4/csf_examples/mx8m/csf.sh
 delete mode 100644 doc/imx/habv4/csf_examples/mx8m/csf_fit.txt
 delete mode 100644 doc/imx/habv4/csf_examples/mx8m/csf_spl.txt

diff --git a/doc/imx/habv4/csf_examples/mx8m/csf.sh b/doc/imx/habv4/csf_examples/mx8m/csf.sh
deleted file mode 100644
index cd3b2614a2f..00000000000
--- a/doc/imx/habv4/csf_examples/mx8m/csf.sh
+++ /dev/null
@@ -1,92 +0,0 @@
-#!/bin/sh
-
-# 0) Generate keys
-#
-# WARNING: ECDSA keys are only supported by HAB 4.5 and newer (i.e. i.MX8M Plus)
-#
-# cd /path/to/cst-3.3.1/keys/
-#    ./hab4_pki_tree.sh -existing-ca n -use-ecc n -kl 4096 -duration 10 -num-srk 4 -srk-ca y
-# cd /path/to/cst-3.3.1/crts/
-#   ../linux64/bin/srktool -h 4 -t SRK_1_2_3_4_table.bin -e SRK_1_2_3_4_fuse.bin -d sha256 -c ./SRK1_sha256_4096_65537_v3_ca_crt.pem,./SRK2_sha256_4096_65537_v3_ca_crt.pem,./SRK3_sha256_4096_65537_v3_ca_crt.pem,./SRK4_sha256_4096_65537_v3_ca_crt.pem -f 1
-
-# 1) Build U-Boot (e.g. for i.MX8MM)
-#
-# cp -Lv /path/to/arm-trusted-firmware/build/imx8mm/release/bl31.bin .
-# cp -Lv /path/to/firmware-imx-8.14/firmware/ddr/synopsys/ddr3* .
-# make -j imx8mm_board_defconfig
-# make -j`nproc` flash.bin
-
-# 2) Sign SPL and DRAM blobs
-
-cp doc/imx/habv4/csf_examples/mx8m/csf_spl.txt csf_spl.tmp
-cp doc/imx/habv4/csf_examples/mx8m/csf_fit.txt csf_fit.tmp
-
-# update File Paths from env vars
-if ! [ -r $CSF_KEY ]; then
-	echo "Error: \$CSF_KEY not found"
-	exit 1
-fi
-if ! [ -r $IMG_KEY ]; then
-	echo "Error: \$IMG_KEY not found"
-	exit 1
-fi
-if ! [ -r $SRK_TABLE ]; then
-	echo "Error: \$SRK_TABLE not found"
-	exit 1
-fi
-sed -i "s:\$CSF_KEY:$CSF_KEY:" csf_spl.tmp
-sed -i "s:\$IMG_KEY:$IMG_KEY:" csf_spl.tmp
-sed -i "s:\$SRK_TABLE:$SRK_TABLE:" csf_spl.tmp
-sed -i "s:\$CSF_KEY:$CSF_KEY:" csf_fit.tmp
-sed -i "s:\$IMG_KEY:$IMG_KEY:" csf_fit.tmp
-sed -i "s:\$SRK_TABLE:$SRK_TABLE:" csf_fit.tmp
-
-# update SPL Blocks
-spl_block_base=$(printf "0x%x" $(( $(sed -n "/CONFIG_SPL_TEXT_BASE=/ s@.*=@@p" .config) - 0x40)) )
-spl_block_size=$(printf "0x%x" $(stat -tc %s u-boot-spl-ddr.bin))
-sed -i "/Blocks = / s@.*@  Blocks = $spl_block_base 0x0 $spl_block_size \"flash.bin\"@" csf_spl.tmp
-
-# Generate CSF blob
-cst -i csf_spl.tmp -o csf_spl.bin
-
-# Patch CSF blob into flash.bin
-spl_csf_offset=$(xxd -s 24 -l 4 -e flash.bin | cut -d " " -f 2 | sed "s@^@0x@")
-spl_bin_offset=$(xxd -s 4 -l 4 -e flash.bin | cut -d " " -f 2 | sed "s@^@0x@")
-spl_dd_offset=$((${spl_csf_offset} - ${spl_bin_offset} + 0x40))
-dd if=csf_spl.bin of=flash.bin bs=1 seek=${spl_dd_offset} conv=notrunc
-
-# 3) Sign u-boot.itb
-
-# fitImage
-fit_block_base=$(printf "0x%x" $(sed -n "/CONFIG_SPL_LOAD_FIT_ADDRESS=/ s@.*=@@p" .config) )
-fit_block_offset=$(printf "0x%s" $(fdtget -t x u-boot.dtb /binman/imx-boot/uboot offset))
-fit_block_size=$(printf "0x%x" $(( ( ( $(stat -tc %s u-boot.itb) + 0x1000 - 0x1 ) & ~(0x1000 - 0x1)) + 0x20 )) )
-sed -i "/Blocks = / s@.*@  Blocks = $fit_block_base $fit_block_offset $fit_block_size \"flash.bin\"@" csf_fit.tmp
-
-# IVT
-ivt_ptr_base=$(printf "%08x" ${fit_block_base} | sed "s@\(..\)\(..\)\(..\)\(..\)@0x\4\3\2\1@")
-ivt_block_base=$(printf "%08x" $(( ${fit_block_base} + ${fit_block_size} - 0x20 )) | sed "s@\(..\)\(..\)\(..\)\(..\)@0x\4\3\2\1@")
-csf_block_base=$(printf "%08x" $(( ${fit_block_base} + ${fit_block_size} )) | sed "s@\(..\)\(..\)\(..\)\(..\)@0x\4\3\2\1@")
-ivt_block_offset=$((${fit_block_offset} + ${fit_block_size} - 0x20))
-csf_block_offset=$((${ivt_block_offset} + 0x20))
-
-echo "0xd1002041 ${ivt_block_base} 0x00000000 0x00000000 0x00000000 ${ivt_block_base} ${csf_block_base} 0x00000000" | xxd -r -p > ivt.bin
-dd if=ivt.bin of=flash.bin bs=1 seek=${ivt_block_offset} conv=notrunc
-
-# Generate CSF blob
-cst -i csf_fit.tmp -o csf_fit.bin
-
-# When loading flash.bin via USB, we must ensure that the file being
-# served is as large as the target expects (see
-# board_spl_fit_size_align()), otherwise the target will hang in
-# rom_api_download_image() waiting for the remaining bytes.
-#
-# Note that in order for dd to actually extend the file, one must not
-# pass conv=notrunc here. With a non-zero seek= argument, dd is
-# documented to preserve the contents of the file seeked past; in
-# particular, dd does not open the file with O_TRUNC.
-CSF_SIZE=$(sed -n "/CONFIG_CSF_SIZE=/ s@.*=@@p" .config)
-dd if=/dev/null of=csf_fit.bin bs=1 seek=$((CSF_SIZE - 0x20)) count=0
-
-# Patch CSF blob into flash.bin
-dd if=csf_fit.bin of=flash.bin bs=1 seek=${csf_block_offset} conv=notrunc
diff --git a/doc/imx/habv4/csf_examples/mx8m/csf_fit.txt b/doc/imx/habv4/csf_examples/mx8m/csf_fit.txt
deleted file mode 100644
index 97f3eea573b..00000000000
--- a/doc/imx/habv4/csf_examples/mx8m/csf_fit.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-[Header]
-  Version = 4.3
-  Hash Algorithm = sha256
-  Engine = CAAM
-  Engine Configuration = 0
-  Certificate Format = X509
-  Signature Format = CMS
-
-[Install SRK]
-  # SRK_TABLE is full path to SRK_1_2_3_4_table.bin
-  File = "$SRK_TABLE"
-  Source index = 0
-
-[Install CSFK]
-  # CSF_KEY is full path to CSF1_1_sha256_4096_65537_v3_usr_crt.pem
-  File = "$CSF_KEY"
-
-[Authenticate CSF]
-
-[Install Key]
-  Verification index = 0
-  Target Index = 2
-  # IMG_KEY is full path to IMG1_1_sha256_4096_65537_v3_usr_crt.pem
-  File = "$IMG_KEY"
-
-[Authenticate Data]
-  Verification index = 2
-  # FIXME:
-  # Line 1 -- fitImage
-  Blocks = CONFIG_SPL_LOAD_FIT_ADDRESS 0x57c00 0xffff "flash.bin"
diff --git a/doc/imx/habv4/csf_examples/mx8m/csf_spl.txt b/doc/imx/habv4/csf_examples/mx8m/csf_spl.txt
deleted file mode 100644
index 88fa420a5fa..00000000000
--- a/doc/imx/habv4/csf_examples/mx8m/csf_spl.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-[Header]
-  Version = 4.3
-  Hash Algorithm = sha256
-  Engine = CAAM
-  Engine Configuration = 0
-  Certificate Format = X509
-  Signature Format = CMS
-
-[Install SRK]
-  # SRK_TABLE is full path to SRK_1_2_3_4_table.bin
-  File = "$SRK_TABLE"
-  Source index = 0
-
-[Install CSFK]
-  # CSF_KEY is full path to CSF1_1_sha256_4096_65537_v3_usr_crt.pem
-  File = "$CSF_KEY"
-
-[Authenticate CSF]
-
-[Unlock]
-  Engine = CAAM
-  Features = MID
-
-[Install Key]
-  Verification index = 0
-  Target Index = 2
-  # IMG_KEY is full path to IMG1_1_sha256_4096_65537_v3_usr_crt.pem
-  File = "$IMG_KEY"
-
-[Authenticate Data]
-  Verification index = 2
-  # FIXME: Adjust start (first column) and size (third column) here
-  Blocks = 0x7e0fc0 0x0 0x306f0 "flash.bin"
diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
index e16e5410bd9..4b2fe08e1d1 100644
--- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
+++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
@@ -121,6 +121,9 @@ build configuration:
 - Defconfig:
 
   CONFIG_IMX_HAB=y
+  CONFIG_FSL_CAAM=y
+  CONFIG_ARCH_MISC_INIT=y
+  CONFIG_SPL_CRYPTO=y
 
 - Kconfig:
 
@@ -131,92 +134,58 @@ build configuration:
 
 The CSF contains all the commands that the HAB executes during the secure
 boot. These commands instruct the HAB code on which memory areas of the image
-to authenticate, which keys to install, use and etc.
-
-CSF examples are available under doc/imx/habv4/csf_examples/ directory.
-
-CSF "Blocks" line for csf_spl.txt can be generated as follows:
-
-```
-spl_block_base=$(printf "0x%x" $(( $(sed -n "/CONFIG_SPL_TEXT_BASE=/ s@.*=@@p" .config) - 0x40)) )
-spl_block_size=$(printf "0x%x" $(stat -tc %s u-boot-spl-ddr.bin))
-sed -i "/Blocks = / s@.*@  Blocks = $spl_block_base 0x0 $spl_block_size \"flash.bin\"@" csf_spl.txt
-```
-
-The resulting line looks as follows:
-```
-  Blocks = 0x7e0fc0 0x0 0x306f0 "flash.bin"
-```
-
-The columns mean:
-  - CONFIG_SPL_TEXT_BASE - 0x40 -- Start address of signed data, in DRAM
-  - 0x0 -- Start address of signed data, in "flash.bin"
-  - 0x306f0 -- Length of signed data, in "flash.bin"
-  - Filename -- "flash.bin"
-
-To generate signature for the SPL part of flash.bin container, use CST:
-```
-cst -i csf_spl.tmp -o csf_spl.bin
-```
-
-The newly generated CST blob has to be patched into existing flash.bin
-container. Conveniently, flash.bin IVT contains physical address of the
-CSF blob. Remember, the SPL part of flash.bin container is loaded by the
-BootROM at CONFIG_SPL_TEXT_BASE - 0x40 , so the offset of CSF blob in
-the fitImage can be calculated and inserted into the flash.bin in the
-correct location as follows:
-```
-# offset = IVT_HEADER[6 = CSF address] - CONFIG_SPL_TEXT_BASE - 0x40
-spl_csf_offset=$(xxd -s 24 -l 4 -e flash.bin | cut -d " " -f 2 | sed "s@^@0x@")
-spl_bin_offset=$(xxd -s 4 -l 4 -e flash.bin | cut -d " " -f 2 | sed "s@^@0x@")
-spl_dd_offset=$((${spl_csf_offset} - ${spl_bin_offset} + 0x40))
-dd if=csf_spl.bin of=flash.bin bs=1 seek=${spl_dd_offset} conv=notrunc
-```
-
-CSF "Blocks" line for csf_fit.txt can be generated as follows:
-```
-# fitImage
-fit_block_base=$(printf "0x%x" $(sed -n "/CONFIG_SPL_LOAD_FIT_ADDRESS=/ s@.*=@@p" .config) )
-fit_block_offset=$(printf "0x%s" $(fdtget -t x u-boot.dtb /binman/imx-boot/uboot offset))
-fit_block_size=$(printf "0x%x" $(( ( ( $(stat -tc %s u-boot.itb) + 0x1000 - 0x1 ) & ~(0x1000 - 0x1)) + 0x20 )) )
-sed -i "/Blocks = / s@.*@  Blocks = $fit_block_base $fit_block_offset $fit_block_size \"flash.bin\"@" csf_fit.tmp
-```
-
-The fitImage part of flash.bin requires separate IVT. Generate the IVT and
-patch it into the correct aligned location of flash.bin as follows:
-```
-# IVT
-ivt_ptr_base=$(printf "%08x" ${fit_block_base} | sed "s@\(..\)\(..\)\(..\)\(..\)@0x\4\3\2\1@")
-ivt_block_base=$(printf "%08x" $(( ${fit_block_base} + ${fit_block_size} - 0x20 )) | sed "s@\(..\)\(..\)\(..\)\(..\)@0x\4\3\2\1@")
-csf_block_base=$(printf "%08x" $(( ${fit_block_base} + ${fit_block_size} )) | sed "s@\(..\)\(..\)\(..\)\(..\)@0x\4\3\2\1@")
-ivt_block_offset=$((${fit_block_offset} + ${fit_block_size} - 0x20))
-csf_block_offset=$((${ivt_block_offset} + 0x20))
-
-echo "0xd1002041 ${ivt_block_base} 0x00000000 0x00000000 0x00000000 ${ivt_block_base} ${csf_block_base} 0x00000000" | xxd -r -p > ivt.bin
-dd if=ivt.bin of=flash.bin bs=1 seek=${ivt_block_offset} conv=notrunc
-```
-
-To generate CSF signature for the fitImage part of flash.bin container, use CST:
-```
-cst -i csf_fit.tmp -o csf_fit.bin
-```
-
-Finally, patch the CSF signature into the fitImage right past the IVT:
-```
-dd if=csf_fit.bin of=flash.bin bs=1 seek=${csf_block_offset} conv=notrunc
-```
-
-The entire script is available in doc/imx/habv4/csf_examples/mx8m/csf.sh
-and can be used as follows to modify flash.bin to be signed
-(adjust paths as needed):
-```
-export CST_DIR=/usr/src/cst-3.3.1/
-export CSF_KEY=$CST_DIR/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem
-export IMG_KEY=$CST_DIR/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem
-export SRK_TABLE=$CST_DIR/crts/SRK_1_2_3_4_table.bin
-export PATH=$CST_DIR/linux64/bin:$PATH
-/bin/sh doc/imx/habv4/csf_examples/mx8m/csf.sh
-```
+to authenticate, which keys to install, use and etc. The CSF is generated
+using the CST Code Signing Tool based on input configuration file. This tool
+input configuration file is generated using binman, and the tool is invoked
+from binman as well.
+
+The SPL and fitImage sections of the generated image are signed separately.
+The signing is activated by wrapping SPL and fitImage sections into nxp-imx8mcst
+etype, by adding the following modification into the binman node:
+
+"
+    diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
+    index c4c1a177102..ccd44bf9d0b 100644
+    --- a/arch/arm/dts/imx8mp-u-boot.dtsi
+    +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
+    @@ -86,6 +86,12 @@
+            section {
+                    pad-byte = <0x00>;
+
+    +               nxp-imx8mcst@0 {
+    +                       filename = "u-boot-spl-mkimage.signed.bin";
+    +                       nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+    +                       nxp,unlock;
+    +                       args;   /* Needed by mkimage etype superclass */
+    +
+                    nxp-imx8mimage {
+                            filename = "u-boot-spl-mkimage.bin";
+                            nxp,boot-from = "sd";
+    @@ -129,6 +135,14 @@
+                            };
+                    };
+
+    +               };
+    +
+    +               nxp-imx8mcst@1 {
+    +                       filename = "u-boot-fit.signed.bin";
+    +                       nxp,loader-address = <CONFIG_SPL_LOAD_FIT_ADDRESS>;
+    +                       offset = <0x58000>;
+    +                       args;   /* Needed by mkimage etype superclass */
+    +
+                    fit {
+                            description = "Configuration to load ATF before U-Boot";
+     #ifndef CONFIG_IMX_HAB
+    @@ -191,5 +205,6 @@
+                                    };
+                            };
+                    };
+    +               };
+            };
+     };
+"
+
+Build of flash.bin target then produces a signed flash.bin automatically.
 
 1.4 Closing the device
 -----------------------
-- 
2.43.0

