Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D857C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4711986558;
	Thu, 24 Aug 2023 05:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VnAz8ETV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D823F86546; Thu, 24 Aug 2023 05:03:29 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B0E486542
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-34bb72ffb1fso18483785ab.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692846205; x=1693451005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jS11sI1kqWax+Q8MurKVskGejYCZpG0Fvuz4p7+ABGI=;
 b=VnAz8ETV1ll2ltZ/TLsWaItqcLOHKpq2d9oNX2OKYVmEJeG6/8Qieay9dHxEEVMfFK
 RgyX+knUVWwS8VChhAXnrDsqkQBa70aifTC0j4epb+X6v8AeSzH7FVAHE7xgNZYxxnhn
 MEUXbUlbyNgsIIcHp3UjZ6MhI7fU5rCn7pokc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692846205; x=1693451005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jS11sI1kqWax+Q8MurKVskGejYCZpG0Fvuz4p7+ABGI=;
 b=iH5Y+myLkuFs5JRhLJVrjm79eyOdy5s3hKUrwthEbtrl+7q8oAc0UsnntZlX7o8fqS
 bVlP94CE35ZrUcwxYYJBNlQezAkca3QRgmyUygkTr4I/NyxLyVpspt+hPDTRWWsEKtgQ
 jRNWb01pySShSAAep9Sj5jRW0Ee0RenYpQlf+bJ1imONHiVGrgIKzCgY9rsP0p3YD5SM
 bSWbEdxOoU2UWrz73ptIcGPOUcnw3C2x2XWSHdZD+WWggqeffObtQnwu6KwpGsbfBO/Y
 4vmzDS2P+uCogfk/SFTCZs11ToxGD2EgF14Nn4u3ikAekIjXqfzXaMyz1vqtSH/EBmjY
 Ndrg==
X-Gm-Message-State: AOJu0YyYE9DRPlg9SCrED14YL4i4mbdEoqbRD4v5BxEmOBeb8unSjs6p
 lH9VQ8reSrmT7DO59i+Ontys39XHxrNJFm3b0vc=
X-Google-Smtp-Source: AGHT+IHYdqagPPrDvuQDh0O8wGp9XtW1gO8iiEM0Y/fvsw2FN80oUrlF8qzshisM09HTK/2cSFfiWg==
X-Received: by 2002:a05:6e02:2142:b0:349:3896:d931 with SMTP id
 d2-20020a056e02214200b003493896d931mr5165638ilv.18.1692846205269; 
 Wed, 23 Aug 2023 20:03:25 -0700 (PDT)
Received: from localhost.localdomain (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 u4-20020a92ccc4000000b00345fcbce508sm4274117ilq.39.2023.08.23.20.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 20:03:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dillon Min <dillon.minfei@gmail.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 6/6] stm32mp15: Use u-boot-spl-stm32.bin instead of
 u-boot-spl.stm32
Date: Wed, 23 Aug 2023 21:02:59 -0600
Message-ID: <20230824030304.1555547-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824030304.1555547-1-sjg@chromium.org>
References: <20230824030304.1555547-1-sjg@chromium.org>
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

A '.stm32' extension is not allowed anymore, so change it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/stm32mp15-u-boot.dtsi   |  2 +-
 doc/board/st/stm32mp1.rst            | 18 +++++++++---------
 include/configs/stm32mp15_dh_dhsom.h |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/dts/stm32mp15-u-boot.dtsi b/arch/arm/dts/stm32mp15-u-boot.dtsi
index 573dd4d3ed56..717eb96a517c 100644
--- a/arch/arm/dts/stm32mp15-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp15-u-boot.dtsi
@@ -222,7 +222,7 @@
 #if defined(CONFIG_SPL)
 &binman {
 	spl-stm32 {
-		filename = "u-boot-spl.stm32";
+		filename = "u-boot-spl-stm32.bin";
 		mkimage {
 			args = "-T stm32image -a 0x2ffc2500 -e 0x2ffc2500";
 			u-boot-spl {
diff --git a/doc/board/st/stm32mp1.rst b/doc/board/st/stm32mp1.rst
index 63b44776ffc1..01ba817aa80d 100644
--- a/doc/board/st/stm32mp1.rst
+++ b/doc/board/st/stm32mp1.rst
@@ -318,7 +318,7 @@ Build Procedure
 
      - stm32mp15_basic_defconfig
 
-       - FSBL = spl/u-boot-spl.stm32
+       - FSBL = spl/u-boot-spl-stm32.bin
 
        - SSBL = u-boot.img (without CONFIG_SPL_LOAD_FIT) or
                 u-boot.itb (with CONFIG_SPL_LOAD_FIT=y)
@@ -361,7 +361,7 @@ Build Procedure
 8. The bootloaders files
 
 + The **ROM code** expects FSBL binaries with STM32 image header =
-  tf-a.stm32 or u-boot-spl.stm32
+  tf-a.stm32 or u-boot-spl-stm32.bin
 
 According the FSBL / the boot mode:
 
@@ -468,9 +468,9 @@ or:
   +-------+--------+---------+------------------------+------------------------+
   | *Num* | *Name* | *Size*  | *Trusted boot content* | *Basic boot content*   |
   +=======+========+=========+========================+========================+
-  | 1     | fsbl1  | 256 KiB | TF-A_ BL2 (tf-a.stm32) | SPL (u-boot-spl.stm32) |
+  | 1     | fsbl1  | 256 KiB | TF-A_ BL2 (tf-a.stm32) | SPL (u-boot-spl-stm32.bin) |
   +-------+--------+---------+------------------------+------------------------+
-  | 2     | fsbl2  | 256 KiB | TF-A_ BL2 (tf-a.stm32) | SPL (u-boot-spl.stm32) |
+  | 2     | fsbl2  | 256 KiB | TF-A_ BL2 (tf-a.stm32) | SPL (u-boot-spl-stm32.bin) |
   +-------+--------+---------+------------------------+------------------------+
   | 3     | ssbl   | 2MB     | U-Boot (u-boot.stm32)  | U-Boot (u-boot.img)    |
   +-------+--------+---------+------------------------+------------------------+
@@ -528,8 +528,8 @@ c) copy the FSBL (2 times) and SSBL file on the correct partition.
 
    for basic boot mode : <SD card dev> = /dev/mmcblk0::
 
-    # dd if=u-boot-spl.stm32 of=/dev/mmcblk0p1
-    # dd if=u-boot-spl.stm32 of=/dev/mmcblk0p2
+    # dd if=u-boot-spl-stm32.bin of=/dev/mmcblk0p1
+    # dd if=u-boot-spl-stm32.bin of=/dev/mmcblk0p2
     # dd if=u-boot.img of=/dev/mmcblk0p3 # Without CONFIG_SPL_LOAD_FIT
       OR
       dd if=u-boot.itb of=/dev/mmcblk0p3 # With CONFIG_SPL_LOAD_FIT=y
@@ -542,7 +542,7 @@ Prepare eMMC
 You can use U-Boot to copy binary in eMMC.
 
 In the next example, you need to boot from SD card and the images
-(tf-a.stm32, fip.bin / u-boot-spl.stm32, u-boot.img for systems without
+(tf-a.stm32, fip.bin / u-boot-spl-stm32.bin, u-boot.img for systems without
 CONFIG_SPL_LOAD_FIT or u-boot.itb for systems with CONFIG_SPL_LOAD_FIT=y) are
 presents on SD card (mmc 0) in ext4 partition 4 (bootfs)
 
@@ -561,7 +561,7 @@ b) copy FSBL, TF-A_ or SPL, on first eMMC boot partition
 
     # ext4load mmc 0:4 0xC0000000 tf-a.stm32
     or
-    # ext4load mmc 0:4 0xC0000000 u-boot-spl.stm32
+    # ext4load mmc 0:4 0xC0000000 u-boot-spl-stm32.bin
 
     # mmc dev 1
     # mmc partconf 1 1 1 1
@@ -838,4 +838,4 @@ Arm TrustZone technology
   + https://www.op-tee.org/
   + https://optee.readthedocs.io/en/latest/
   + https://optee.readthedocs.io/en/latest/building/devices/stm32mp1.html
-  + https://github.com/OP-TEE/optee_os
\ No newline at end of file
+  + https://github.com/OP-TEE/optee_os
diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/stm32mp15_dh_dhsom.h
index 919216906249..ad4e93805ded 100644
--- a/include/configs/stm32mp15_dh_dhsom.h
+++ b/include/configs/stm32mp15_dh_dhsom.h
@@ -22,7 +22,7 @@
 	"usb_pgood_delay=1000\0" \
 	"update_sf=" /* Erase SPI NOR and install U-Boot from SD */	\
 		"setexpr loadaddr1 ${loadaddr} + 0x1000000 && "		\
-		"load mmc 0:4 ${loadaddr1} /boot/u-boot-spl.stm32 && "	\
+		"load mmc 0:4 ${loadaddr1} /boot/u-boot-spl-stm32.bin && "	\
 		"env set filesize1 ${filesize} && "			\
 		"load mmc 0:4 ${loadaddr} /boot/u-boot.itb && "		\
 		"sf probe && sf erase 0 0x200000 && "			\
-- 
2.42.0.rc1.204.g551eb34607-goog

