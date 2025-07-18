Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D22C83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 08:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CF58835BF;
	Fri, 18 Jul 2025 10:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R5/37r+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C83BF835FD; Fri, 18 Jul 2025 10:30:22 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE1378357F
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 10:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikko.rapeli@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5561c20e2d5so2406280e87.0
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 01:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752827418; x=1753432218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RnJb6H1cvHOdaOov/t0VrpnEMYlRjbYFZS3Kq0gbTUo=;
 b=R5/37r+GaSxK8JigdXp13zAV0UDBsnB/dDBAXFpOojc4wsVcb4MyK0GjLE0CEy6WZa
 Y+RtZa/gO0W9lvgqLLhzzWoY3YUpYKkbOAoqyTpOOx9WpdAondzcosUrNBNuTl9linQ4
 pO+eKbFI8cfRz7Tc5/HvtMHWvJpGq90zpzIX9Er39XhDaNPEA82LFcB0ebcI781efVSi
 OeYkkc0+i7Kko32ZUqCfr2uq0hoQRdLD1h0G5BOEeYlApGDpVsREVnl+Jr9ui2ItSJDH
 nwHg0+tveoku6EKIvueDq6/p0VRb9zw3Hr6q3F+DeLCzTcJK+10+/H52iRt961dIFiEK
 qu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752827418; x=1753432218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RnJb6H1cvHOdaOov/t0VrpnEMYlRjbYFZS3Kq0gbTUo=;
 b=d734hzHsCU9uPF4WNUgUNqo5GoT6B3BE63HdDQM6IxjGCNWRbcCOF0QmYMI8s4B/sf
 XIkMZbQgKlkYgiJuH8BdEFoEJh7atGD6cXqy+A6WrYxurLqrpzFsohOfibK11ky5aopP
 Bbcme2crhhcmAfVL07YqrDYmZMPs1wruB+s75sB/SkC8ZNAtlzhT9zyGBWksR2puLeju
 hLfUiZmTEBF5bm2px8u36p/NgCzyftxkc9wwmxJ6ag/VN/knk7Q9y/QQovaowx9pvMBc
 M5YhwQMy9U1wPzjon4I2QmadLv/IbAattr/lAffSsa+YTxdHmRY5W824vJd8Yy7ujPmr
 VYmQ==
X-Gm-Message-State: AOJu0YxuRM5lSuqFTmnuKiJylNBQCdATtaWfIJUtsY30Ax2vtEI+y12s
 FEj7JzzBY2pLcdvWIOdAL7jLbdax59kCflXf70/mRm45pCJIalRbMMuRlUOAWl5egmH9t+VtLbT
 QUgv0
X-Gm-Gg: ASbGnctN9gpiQzTKIszBg2HLX8LPqQvRQRYTXNXrJrjTo9rJ0/ziv6Z8NxNUlqaOGf8
 GzN5iqpZ4xPi66b12dJzZm+J9sCotFCJl0oIxOkxmpjqHPW8ktbuMGeFOIfnbN00G1/M/a/AoqM
 2PuXldGzkwUC/76lvqtR+iTauy6DzrNYolWTZ5SdLk6Ui4vIHexCAOPXQJd3O3mkOIQCWlZEzCE
 mg88ssjV5lUxxUFXHRqu8WN9G2RSHDFe/GFDs0hax4qIHVIwcxGSz9UkPnBvMbKktlI9Y11JGOy
 e0qvIRFfbjF3+ipQyTt5/rTG6YPGDQ95q3v/7AIQ/9WYbBDPvp1ms5ez8jPSSNzelzd+gYrAnlS
 fSiGqLM3yOUSGX+4yntTfU3zmreWNNjpohv40qqjELP5/fbCa4A==
X-Google-Smtp-Source: AGHT+IEOlj+j63lfCLo8j6TKqGalZ9Ri/Voi5lVqNlNWatqRPcEdpshdCsZ9+ULf80CicuELv6JpHA==
X-Received: by 2002:a05:6512:3d0b:b0:553:2d93:d31 with SMTP id
 2adb3069b0e04-55a3184c007mr434927e87.22.1752827418365; 
 Fri, 18 Jul 2025 01:30:18 -0700 (PDT)
Received: from nuoska (85-76-141-8-nat.elisa-mobile.fi. [85.76.141.8])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55a31a9b996sm175524e87.14.2025.07.18.01.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 01:30:17 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: u-boot@lists.denx.de
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3 1/2] Makefile scripts/Makefile.lib: fix *_efi.so dependency
 to PLATFORM_LIBGCC
Date: Fri, 18 Jul 2025 11:29:58 +0300
Message-ID: <20250718082959.416152-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

When PLATFORM_LIBGCC was added to linker command it was not
added to the dependency of the .so and other rules. Thus a build can
try to link *_efi.so files before lib.a from PLATFORM_LIBGCC is available.
This was seen in yocto autobuilder builds with u-boot 2025.07
update, see https://lists.openembedded.org/g/openembedded-core/message/2200=
04

https://autobuilder.yoctoproject.org/valkyrie/api/v2/logs/2914600/raw_inline

|    rm -f lib/efi_loader/built-in.o; arm-poky-linux-gnueabi-ar cDPrsT lib/=
efi_loader/built-in.o lib/efi_loader/efi_bootmgr.o lib/efi_loader/efi_bootb=
in.o lib/efi_loader/efi_boottime.o lib/efi_loader/efi_helper.o lib/efi_load=
er/efi_console.o lib/efi_loader/efi_device_path.o lib/efi_loader/efi_device=
_path_to_text.o lib/efi_loader/efi_device_path_utilities.o lib/efi_loader/e=
fi_dt_fixup.o lib/efi_loader/efi_fdt.o lib/efi_loader/efi_file.o lib/efi_lo=
ader/efi_hii.o lib/efi_loader/efi_hii_config.o lib/efi_loader/efi_image_loa=
der.o lib/efi_loader/efi_load_options.o lib/efi_loader/efi_memory.o lib/efi=
_loader/efi_root_node.o lib/efi_loader/efi_runtime.o lib/efi_loader/efi_set=
up.o lib/efi_loader/efi_string.o lib/efi_loader/efi_unicode_collation.o lib=
/efi_loader/efi_var_common.o lib/efi_loader/efi_var_mem.o lib/efi_loader/ef=
i_variable.o lib/efi_loader/efi_var_file.o lib/efi_loader/efi_watchdog.o li=
b/efi_loader/efi_disk.o lib/efi_loader/efi_net.o lib/efi_loader/efi_smbios.=
o lib/efi_loader/efi_load_initrd.o lib/efi_loader/efi_conformance.o
|   arm-poky-linux-gnueabi-ld.bfd -nostdlib -zexecstack -znocombreloc -znor=
elro --no-warn-rwx-segments -L /srv/pokybuild/yocto-worker/oe-selftest-armh=
ost/build/build-st-3119200/tmp/work/beaglebone_yocto-poky-linux-gnueabi/u-b=
oot/2025.07/sources/u-boot-2025.07 -T arch/arm/lib/elf_arm_efi.lds -shared =
-Bsymbolic -s lib/efi_loader/helloworld.o lib/efi_loader/efi_crt0.o lib/efi=
_loader/efi_reloc.o lib/efi_loader/efi_freestanding.o arch/arm/lib/lib.a -o=
 lib/efi_loader/helloworld_efi.so
| arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No such fi=
le or directory
| make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/helloworld_efi.so]=
 Error 1

The issue is hard to reproduce but this change can artificially trigger it:

  --- a/scripts/Makefile.build
  +++ b/scripts/Makefile.build
@@ -353,7 +353,7 @@ $(modorder-target): $(subdir-ym) FORCE
 #
 ifdef lib-target
 quiet_cmd_link_l_target =3D AR      $@
-cmd_link_l_target =3D rm -f $@; $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(lib-y)
+cmd_link_l_target =3D rm -f $@ && echo "HACK, delaying build!" && sleep 60=
 && $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(lib-y)

 $(lib-target): $(lib-y) FORCE
        $(call if_changed,link_l_target)

Then run a rebuild with:

$  rm -f $( find build/ -name lib.a -or -name helloworld_efi.so ) && \
   make
...
  arm-poky-linux-gnueabi-ld.bfd -nostdlib -zexecstack -znocombreloc -znorel=
ro --no-warn-rwx-segments -L /home/mcfrisk/src/base/repo/poky/build_bea
glebone/tmp/work/beaglebone_yocto-poky-linux-gnueabi/u-boot/2025.07/sources=
/u-boot-2025.07 -T arch/arm/lib/elf_arm_efi.lds -shared -Bsymbolic -s lib/e=
fi_loader/helloworld.o lib/efi_loader/efi_crt0.o lib/efi_loader/efi_reloc.o=
 lib/efi_loader/efi_freestanding.o arch/arm/lib/lib.a -o lib/efi_loader/hel=
loworld_efi.so
arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No such file=
 or directory
make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/helloworld_efi.so] E=
rror 1

Fix by introducing PLATFORM_LIBGCC_LIBA variable with only lib.a
filename which is then used to add the dependency in rules which use
PLATFORM_LIBGCC. This should not impact builds which don't set
PLATFORM_LIBGCC_LIBA and PLATFORM_LIBGCC usage stays as is.

Fixes: 43d43241d1c9 ("scripts/Makefile.lib: add PLATFORM_LIBGCC to efi link=
ing")

Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 Makefile                     | 4 +++-
 examples/standalone/Makefile | 2 +-
 scripts/Makefile.lib         | 2 +-
 scripts/Makefile.xpl         | 3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

v3: added "export PLATFORM_LIBGCC_LIBA" like PLATFORM_LIBGCC, not sure
    how testing worked without this before

v2: introduced PLATFORM_LIBGCC_LIBA variable with just lib.a filename,
    PLATFORM_LIBGCC can have other flags too
    https://lists.denx.de/pipermail/u-boot/2025-July/594034.html

v1: https://lists.denx.de/pipermail/u-boot/2025-July/593982.html

diff --git a/Makefile b/Makefile
index 1a5c77d7caf0..a0797f36f7f6 100644
--- a/Makefile
+++ b/Makefile
@@ -911,7 +911,8 @@ u-boot-main :=3D $(libs-y)
=20
 # Add GCC lib
 ifeq ($(CONFIG_USE_PRIVATE_LIBGCC),y)
-PLATFORM_LIBGCC =3D arch/$(ARCH)/lib/lib.a
+PLATFORM_LIBGCC_LIBA =3D arch/$(ARCH)/lib/lib.a
+PLATFORM_LIBGCC =3D $(PLATFORM_LIBGCC_LIBA)
 else
 ifndef CONFIG_CC_IS_CLANG
 PLATFORM_LIBGCC :=3D -L $(shell dirname `$(CC) $(c_flags) -print-libgcc-fi=
le-name`) -lgcc
@@ -926,6 +927,7 @@ endif
=20
 export PLATFORM_LIBS
 export PLATFORM_LIBGCC
+export PLATFORM_LIBGCC_LIBA
=20
 # Special flags for CPP when processing the linker script.
 # Pass the version down so we can handle backwards compatibility
diff --git a/examples/standalone/Makefile b/examples/standalone/Makefile
index 9b57f1c0c66c..aa9e3121cf9a 100644
--- a/examples/standalone/Makefile
+++ b/examples/standalone/Makefile
@@ -64,7 +64,7 @@ quiet_cmd_link_elf =3D LD      $@
       cmd_link_elf =3D $(LD) $(KBUILD_LDFLAGS) $(LDFLAGS_STANDALONE) -g  \
 		     -o $@ -e $(SYM_PREFIX)$(@F) $< $(LIB) $(PLATFORM_LIBGCC)
=20
-$(ELF): $(obj)/%: $(obj)/%.o $(LIB) FORCE
+$(ELF): $(obj)/%: $(obj)/%.o $(LIB) $(PLATFORM_LIBGCC_LIBA) FORCE
 	$(call if_changed,link_elf)
=20
 $(obj)/%.srec: OBJCOPYFLAGS +=3D -O srec
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index e89a4a51b74d..cef3863dfdc4 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -508,7 +508,7 @@ $(obj)/efi_reloc.o: $(srctree)/arch/$(ARCH)/lib/$(EFI_R=
ELOC:.o=3D.c) $(recordmcoun
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
=20
-$(obj)/%_efi.so: $(obj)/%.o $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/ef=
i_freestanding.o
+$(obj)/%_efi.so: $(PLATFORM_LIBGCC_LIBA) $(obj)/%.o $(obj)/efi_crt0.o $(ob=
j)/efi_reloc.o $(obj)/efi_freestanding.o
 	$(call cmd,efi_ld)
=20
 targets +=3D $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/efi_freestanding.o
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 43f27874f9fe..68c88293f0d9 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -139,7 +139,8 @@ libs-y :=3D $(patsubst %/, %/built-in.o, $(libs-y))
=20
 # Add GCC lib
 ifeq ($(CONFIG_USE_PRIVATE_LIBGCC),y)
-PLATFORM_LIBGCC =3D arch/$(ARCH)/lib/lib.a
+PLATFORM_LIBGCC_LIBA =3D arch/$(ARCH)/lib/lib.a
+PLATFORM_LIBGCC =3D $(PLATFORM_LIBGCC_LIBA)
 PLATFORM_LIBS :=3D $(filter-out %/lib.a, $(filter-out -lgcc, $(PLATFORM_LI=
BS))) $(PLATFORM_LIBGCC)
 endif
=20
--=20
2.43.0

