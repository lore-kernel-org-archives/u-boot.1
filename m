Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C33CC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 21:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B626F87E20;
	Thu, 15 Feb 2024 22:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jmGA5++v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B52F487E2C; Thu, 15 Feb 2024 22:10:37 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 199B587DEC
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 22:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-607d5af59feso8619257b3.3
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 13:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708031427; x=1708636227; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+nbxA+sDkZ5llZO7sbARGMHAuWT8AplLeJ6kmT8uptM=;
 b=jmGA5++vTn3knqBIkyeaNY0SmhLKRasysVgRdJuDK4CWQsO8ZgEIV1wF35ZYHfzvh4
 V6HbNU63GznXgCtuAB0hai7ECCgaFCX2DF9F9DqFWNH0U54EHR/+s1FF5x4MKdeZSLTd
 Xq60SG8ZE4nVqOoF9zG1CcYX5rafX6iwlYfP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708031427; x=1708636227;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+nbxA+sDkZ5llZO7sbARGMHAuWT8AplLeJ6kmT8uptM=;
 b=lltBCBPk6chqDVT9XZQL7dJ0TUElPgBivE9v6VkG4+aAquf2cpKa12kbdm2jpvx0Y7
 r5FCaYmMGd64nf5bYp2u+th8ODjO5o/8h45zJD1ZK+SpyH/GDa9C2p1vsZHB1o8mfobQ
 HjUwrMMXu3BqyRyqSP5/FdpKJhDE6aDA5J0B8BMpPjSakxHTX6dbHk96DHOpc9zeIl3Q
 50VctUVaMgwbfk0q6C4U+qxX09X0Fm1X2I7/4+qvU97CJB1arGTsfPKjKG+PwmlT9LGT
 u+ymzvD+xZEZ3AUP0ZPOQcpy57m6mdc5lVR32uuT+bjQxYAZyPY3KKFTE0KJ5stD6GJk
 jEhQ==
X-Gm-Message-State: AOJu0YwlLIXJCRaArAgTr6mwSx5xaD8gDIU6CWX1GgFX5i8CjpKjhz4N
 fcU3QQYT5MoX1pon31z6R1wDT5ur9aPoXPbVYe125AK1cRtER8pknL8K1kcK3Stavd7n6paHf/k
 k
X-Google-Smtp-Source: AGHT+IF1y29uXRfAG5owu42BVtzRPj5t/sOmitMKyYBCkpbLIdWO/sel41aaYoPcIcNLJRxHeCLxdA==
X-Received: by 2002:a81:b603:0:b0:604:a9c2:2a17 with SMTP id
 u3-20020a81b603000000b00604a9c22a17mr2908001ywh.45.1708031427522; 
 Thu, 15 Feb 2024 13:10:27 -0800 (PST)
Received: from bill-the-cat.. (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 w84-20020a817b57000000b006077c89b001sm45484ywc.83.2024.02.15.13.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 13:10:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH 1/2] doc: Update our clang documentation to reflect current
 status
Date: Thu, 15 Feb 2024 16:10:24 -0500
Message-Id: <20240215211025.690964-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

First, since this document was written the biggest challenges at the
time are simply not applicable anymore. Second, we need to list the
challenges which are preventing more platforms from being able to be
built with Clang today.  Next, we update the general wording to be host
distribution agnostic. Finally, the section about xenguest_arm64 issues
is not present anymore.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Mark Kettenis <kettenis@openbsd.org>
This does leave the FreeBSD section unchanged and should likely be
looked at again by someone with a BSD build machine available.
---
 doc/build/clang.rst | 85 +++++++++++----------------------------------
 1 file changed, 21 insertions(+), 64 deletions(-)

diff --git a/doc/build/clang.rst b/doc/build/clang.rst
index 09bb988e9236..d8c554982567 100644
--- a/doc/build/clang.rst
+++ b/doc/build/clang.rst
@@ -1,34 +1,27 @@
 Building with Clang
 ===================
 
-The biggest problem when trying to compile U-Boot with Clang is that almost all
-archs rely on storing gd in a global register and the Clang 3.5 user manual
-states: "Clang does not support global register variables; this is unlikely to
-be implemented soon because it requires additional LLVM backend support."
-
-The ARM backend can be instructed not to use the r9 and x18 registers using
--ffixed-r9 or -ffixed-x18 respectively. As global registers themselves are not
-supported inline assembly is needed to get and set the r9 or x18 value. This
-leads to larger code then strictly necessary, but at least works.
-
-Debian based
-------------
-
-Required packages can be installed via apt, e.g.
-
-.. code-block:: bash
-
-    sudo apt-get install clang
-
-We make use of the CROSS_COMPILE variable to derive the build target which is
-passed as the --target parameter to clang.
-
-The CROSS_COMPILE variable further determines the paths to other build
-tools. As assembler we use the binary pointed to by '$(CROSS_COMPILE)as'
-instead of the LLVM integrated assembler (IAS).
-
-Here is an example demonstrating building U-Boot for the Raspberry Pi 2
-using clang:
+In general terms, U-Boot support building with Clang as the C compiler and
+building and booting our "sandbox" target is part of CI.
+
+There are however some specific issues that need to be addressed to fully
+support building with Clang on all targets.
+
+* Given the issue reported in https://github.com/llvm/llvm-project/issues/78778
+  currently one has to configure the build first with GCC.
+* Support for passing the correct flags along to `$(CPP)` needs to be
+  backported from the Linux Kernel.
+* Support for using Clang as the linker is required to support the LTO feature
+  which some platforms require in order to create an appropriately small
+  binary.
+
+In general, when building with Clang we make use of the CROSS_COMPILE variable
+to derive the build target which is passed as the --target parameter to clang.
+The CROSS_COMPILE variable further determines the paths to other build tools.
+As assembler we use the binary pointed to by '$(CROSS_COMPILE)as' instead of
+the LLVM integrated assembler (IAS).  After installing clang as per the
+instructions for your specific distribution, in order to build for example the
+Raspberry Pi 2 using clang:
 
 .. code-block:: bash
 
@@ -72,39 +65,3 @@ simplified with a simple wrapper script - saved as
 
     #!/bin/sh
     exec clang -target arm-freebsd-eabi --sysroot /usr/arm-freebsd "$@"
-
-
-Known Issues
-------------
-
-When build U-boot for `xenguest_arm64_defconfig` target, it reports linkage
-error:
-
-.. code-block:: bash
-
-    aarch64-linux-gnu-ld.bfd: drivers/xen/hypervisor.o: in function `do_hypervisor_callback':
-    /home/leoy/Dev2/u-boot/drivers/xen/hypervisor.c:188: undefined reference to `__aarch64_swp8_acq_rel'
-    aarch64-linux-gnu-ld.bfd: drivers/xen/hypervisor.o: in function `synch_test_and_set_bit':
-    /home/leoy/Dev2/u-boot/./arch/arm/include/asm/xen/system.h:40: undefined reference to `__aarch64_ldset1_acq_rel'
-    aarch64-linux-gnu-ld.bfd: drivers/xen/hypervisor.o: in function `synch_test_and_clear_bit':
-    /home/leoy/Dev2/u-boot/./arch/arm/include/asm/xen/system.h:28: undefined reference to `__aarch64_ldclr1_acq_rel'
-    aarch64-linux-gnu-ld.bfd: drivers/xen/hypervisor.o: in function `synch_test_and_set_bit':
-    /home/leoy/Dev2/u-boot/./arch/arm/include/asm/xen/system.h:40: undefined reference to `__aarch64_ldset1_acq_rel'
-    aarch64-linux-gnu-ld.bfd: drivers/xen/hypervisor.o: in function `synch_test_and_clear_bit':
-    /home/leoy/Dev2/u-boot/./arch/arm/include/asm/xen/system.h:28: undefined reference to `__aarch64_ldclr1_acq_rel'
-    aarch64-linux-gnu-ld.bfd: drivers/xen/events.o: in function `synch_test_and_clear_bit':
-    /home/leoy/Dev2/u-boot/./arch/arm/include/asm/xen/system.h:28: undefined reference to `__aarch64_ldclr1_acq_rel'
-    aarch64-linux-gnu-ld.bfd: drivers/xen/events.o: in function `synch_test_and_set_bit':
-    /home/leoy/Dev2/u-boot/./arch/arm/include/asm/xen/system.h:40: undefined reference to `__aarch64_ldset1_acq_rel'
-    aarch64-linux-gnu-ld.bfd: drivers/xen/gnttab.o: in function `gnttab_end_access':
-    /home/leoy/Dev2/u-boot/drivers/xen/gnttab.c:109: undefined reference to `__aarch64_cas2_acq_rel'
-    Segmentation fault
-
-To fix the failure, we need to append option `-mno-outline-atomics` in Clang
-command to not generate local calls to out-of-line atomic operations:
-
-.. code-block:: bash
-
-    make HOSTCC=clang xenguest_arm64_defconfig
-    make HOSTCC=clang CROSS_COMPILE=aarch64-linux-gnu- \
-         CC="clang -target aarch64-linux-gnueabi -mno-outline-atomics" -j8
-- 
2.34.1

