Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E148FCCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 10:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61BE38391C;
	Fri, 31 Oct 2025 11:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MHko3OkC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB8CE83849; Fri, 31 Oct 2025 08:46:20 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75D1F800B1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 08:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andrea.calabrese@amarulasolutions.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-63c489f1e6cso3615213a12.1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 00:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1761896778; x=1762501578;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YnTgU+u4t3vpMm4t6jAoVHzh76WkQfAFzu9ZIp7GPIQ=;
 b=MHko3OkCEltOWWBPPMFJa1Gw5BKoFrG1vP05wgbFCn4ku+JWmsl4AtDjCY5GS44mA0
 dvpn1BwBnE8JwWQlmZYeOOVshnG2evD2hVAOaBKRW7T9gJ6CGcfOltiwddBD1+I9+VyG
 vWJdkYWEnt99rzYuSrWmglRF6Qr2KI/GVEcYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761896778; x=1762501578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YnTgU+u4t3vpMm4t6jAoVHzh76WkQfAFzu9ZIp7GPIQ=;
 b=K/oldUTMRlVapSQntUNFNvTnGuwxeyvz8PkAzlW7E9WrbO+GcddfeDNrav56brfEHR
 LFvGnhAJ/ODd7f1VOyX1piy7oM5nk29WWpQ85rTOxqsueaxcuvf1Gx+6ZDeoV+Z1jEyY
 lEAGypalGhwVBGGjKV1wLNS8X9rfozSZcxQEHwUVWuMEg56DQj543ybFrK4n3WM/o+Ds
 fQN+g1OZdWfjdrNUbsx9kPCU8r1LL+XktQ/VOOMU0S2GYElO8YiW5cqmijzdpM9SQ1tJ
 UcXTvVOndMV4vAmrIoe8x1r9vmJBMAdWB8Yr+6gcmFQYHf4vWE3n2kPDWAKhF2uRtCkt
 vv9g==
X-Gm-Message-State: AOJu0Yzfn5DL//3sDkJqk/vrgBrh1dsIaS/S3mq+38ueSONw+KKpTrCW
 VgBmeDJdvHpIEvnUbKl/r67obqvhu9evN15biLr6CI3nTDXNzBqDdq+irUVY//ode+9gFmCcbZR
 3DuCq
X-Gm-Gg: ASbGncur6qgh5gcjKQrgUFxjm/qSis+DVedNITZAlo8CUGLgrWSZhJUGY36Q3l/V7+W
 IMeGXpc2ptODH/6Qq6YeLOnE0ST4/KUlgiZxkVgRz/sQpfK2JSAc69qyXMCv9gyVN/S4wxRep5m
 QN33s1SYadx+J8WPqtJg5MezvV7JBMRGSzBHO171XIFkR0hXqgzNB3TECRQV/usGrfyeqUYj5pT
 ria6O8+lgF6ysvmdEig3LivF5E0tgtPW3P2Vvy+hJkqIIeTBhjEnuZKMYz7zrZmqGNMuB2wxsjC
 yJ2uF59RJRJ2d1Oo+u4lyQ2K0d9Ckqvu64MhRykRAQBdmp5H30+bdtkrI71+XvS6s5tqALw0xQk
 J1WCmi9WrUO5vOkJxyd631UGucN6A7NjlDynBK3ysGaS+d5boh75s3dR6Ocm0DXKLbT1SceJKmx
 7/u8L9N6jaMixLLP5BjLVpEEKKPC2Si2DIkAHZLVKOcuG2NSdyHN/JIS5DMamdWtCezRGgJeZkT
 t+uhV0UG3f3kXl/0w==
X-Google-Smtp-Source: AGHT+IFqNZO88+7C5F2OkOJhMMUR5/1ArtxKdOb9uY1OHlyGC92mFpAaHwDepI1Pviua796xAYzwlA==
X-Received: by 2002:a05:6402:23cc:b0:640:4c6f:d65d with SMTP id
 4fb4d7f45d1cf-640753c3b18mr2127278a12.12.1761896777693; 
 Fri, 31 Oct 2025 00:46:17 -0700 (PDT)
Received: from andrea-amarula.home (98-215-98-95.ftth.glasoperator.nl.
 [95.98.215.98]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6407b34a808sm1018102a12.8.2025.10.31.00.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 00:46:17 -0700 (PDT)
From: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
To: u-boot@lists.denx.de, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, trini@konsulko.com, festevam@gmail.com
Cc: andrea.calabrese@amarulasolutions.com
Subject: [PATCH v3 1/3] bsh: update readme with instructions to build M2B
Date: Fri, 31 Oct 2025 08:46:09 +0100
Message-ID: <20251031074611.39426-1-andrea.calabrese@amarulasolutions.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Oct 2025 11:57:12 +0100
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

readme was missing instructions to build M2B. Now added.

Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>

diff --git a/board/bsh/imx6ulz_smm_m2/README b/board/bsh/imx6ulz_smm_m2/README
deleted file mode 100644
index 03d01325a97..00000000000
--- a/board/bsh/imx6ulz_smm_m2/README
+++ /dev/null
@@ -1,67 +0,0 @@
-How to Update U-Boot on imx6ulz_smm_m2 board
---------------------------------------------
-
-Required software on the host PC:
-
-- UUU: https://github.com/NXPmicro/mfgtools
-
-Build U-Boot for m2:
-
-$ make mrproper
-$ make imx6ulz_smm_m2_defconfig
-$ make
-
-This generates the SPL and u-boot-dtb.img binaries.
-
-1. Loading U-Boot via USB Serial Download Protocol
-
-Copy SPL and u-boot-dtb.img to the uuu folder.
-
-Load the U-Boot via USB:
-
-$ sudo uuu -v -b nand_script.lst u-boot-with-spl.imx
-
-where nand_script.lst contains the following:
-
-uuu_version 1.2.39
-
-# @_flash.bin            | bootloader
-# @_image   [_flash.bin] | image burn to nand, default is the same as bootloader
-
-# This command will be run when i.MX6/7 i.MX8MM, i.MX8MQ
-SDP: boot -f _flash.bin
-
-# This command will be run when ROM support stream mode
-# i.MX8QXP, i.MX8QM
-SDPS: boot -f _flash.bin
-
-# These commands will be run when use SPL and will be skipped if no spl
-# SDPU will be deprecated. please use SDPV instead of SDPU
-# {
-SDPU: delay 1000
-SDPU: write -f _flash.bin -offset 0x57c00
-SDPU: jump
-# }
-
-# These commands will be run when use SPL and will be skipped if no spl
-# if (SPL support SDPV)
-# {
-SDPV: delay 1000
-SDPV: write -f _flash.bin -offset 0x11000
-SDPV: jump
-# }
-
-FB: ucmd setenv fastboot_buffer ${loadaddr}
-FB: download -f _image
-FB: ucmd if test ! -n "$fastboot_bytes"; then setenv fastboot_bytes $filesize; else true; fi
-# Burn image to nandfit partition if needed
-FB: ucmd if env exists nandfit_part; then nand erase.part nandfit; nand write ${fastboot_buffer} nandfit ${fastboot_bytes}; else true; fi;
-FB: ucmd nandbcb init ${fastboot_buffer} nandboot ${fastboot_bytes}
-FB: Done
-
-Then U-Boot starts and its messages appear in the console program.
-
-Use the default environment variables:
-
-=> env default -f -a
-=> saveenv
diff --git a/doc/board/bsh/imx6ulz_bsh_smm_m2.rst b/doc/board/bsh/imx6ulz_bsh_smm_m2.rst
new file mode 100644
index 00000000000..0f391a17ade
--- /dev/null
+++ b/doc/board/bsh/imx6ulz_bsh_smm_m2.rst
@@ -0,0 +1,85 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+How to Update U-Boot on imx6ulz_smm_m2 and imx6ulz_smm_m2b boards
+=================================================================
+
+Required software on the host PC:
+
+- UUU: https://github.com/NXPmicro/mfgtools
+
+Build U-Boot for m2:
+
+.. code-block:: bash
+
+   $ make mrproper
+   $ make imx6ulz_smm_m2_defconfig
+   $ make
+
+Build U-Boot for m2b:
+
+.. code-block:: bash
+
+   $ make mrproper
+   $ make imx6ulz_smm_m2b_defconfig
+   $ make
+
+This generates the SPL and u-boot-dtb.img binaries.
+
+Loading U-Boot via USB Serial Download Protocol
+-----------------------------------------------
+
+Copy SPL and u-boot-dtb.img to the uuu folder.
+
+Load the U-Boot via USB:
+
+.. code-block:: bash
+
+   $ sudo uuu -v -b nand_script.lst u-boot-with-spl.imx
+
+where nand_script.lst contains the following:
+
+.. code-block::
+
+   uuu_version 1.2.39
+
+   # @_flash.bin            | bootloader
+   # @_image   [_flash.bin] | image burn to nand, default is the same as bootloader
+
+   # This command will be run when i.MX6/7 i.MX8MM, i.MX8MQ
+   SDP: boot -f _flash.bin
+
+   # This command will be run when ROM support stream mode
+   # i.MX8QXP, i.MX8QM
+   SDPS: boot -f _flash.bin
+
+   # These commands will be run when use SPL and will be skipped if no spl
+   # SDPU will be deprecated. please use SDPV instead of SDPU
+   # {
+   SDPU: delay 1000
+   SDPU: write -f _flash.bin -offset 0x57c00
+   SDPU: jump
+   # }
+
+   # These commands will be run when use SPL and will be skipped if no spl
+   # if (SPL support SDPV)
+   # {
+   SDPV: delay 1000
+   SDPV: write -f _flash.bin -offset 0x11000
+   SDPV: jump
+   # }
+
+   FB: ucmd setenv fastboot_buffer ${loadaddr}
+   FB: download -f _image
+   FB: ucmd if test ! -n "$fastboot_bytes"; then setenv fastboot_bytes $filesize; else true; fi
+   # Burn image to nandfit partition if needed
+   FB: ucmd if env exists nandfit_part; then nand erase.part nandfit; nand write ${fastboot_buffer} nandfit ${fastboot_bytes}; else true; fi;
+   FB: ucmd nandbcb init ${fastboot_buffer} nandboot ${fastboot_bytes}
+   FB: Done
+
+Then U-Boot starts and its messages appear in the console program.
+
+Use the default environment variables:
+
+=> env default -f -a
+
+=> saveenv
diff --git a/doc/board/bsh/index.rst b/doc/board/bsh/index.rst
index 570ee4d72ed..e4f8b1f0b1c 100644
--- a/doc/board/bsh/index.rst
+++ b/doc/board/bsh/index.rst
@@ -7,3 +7,4 @@ BSH Hausgeraete GmbH
    :maxdepth: 2
 
    imx8mn_bsh_smm_s2
+   imx6ulz_bsh_smm_m2
-- 
2.48.1

