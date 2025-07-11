Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21613C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 06:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F5C8344C;
	Fri, 11 Jul 2025 08:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s2ykItsB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1F328349B; Fri, 11 Jul 2025 08:52:07 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 802EC83444
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikko.rapeli@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-32ac42bb4e4so15532421fa.0
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 23:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752216725; x=1752821525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cQNdPA3grcE5mCprDTjfaCGjg8q91RKNCPXY04Hbrzg=;
 b=s2ykItsBrKN6vb84xc0mr+8vMQCiVlBvFAJ5aRx0TQ/qs+6ix83R0JrCbVA4irPjD0
 HNZevJ+UyHyykQ91nsltR983aTGsmAK+39tE05D+7nKmRMTwS+F119D0ffopqvDJdBZG
 N5yXeJA9Ary9NWNeHxEYbDmY2jFNYMWiRAKWWHRsGxQ4Gli+L4xTQy2Nth6oLautF4T0
 azwgc2AfieOwwK5iYK8J2yPbVG2rqWs4sBjwlCr7G1vRJf2zxB3hGav1dGoztrCE8oTx
 ZAhSv+uxWRhstRCS7p/w1uvjg/9aOnD5UWptQcLM99sGy3cmWJXWCaUvommNOKHleyXZ
 7WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752216725; x=1752821525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cQNdPA3grcE5mCprDTjfaCGjg8q91RKNCPXY04Hbrzg=;
 b=ZIfhkxEi+XL+sAplxEv8FtYv0MOCnLsqrSLyUHR2Ozhwflba0vLfYCG/A1R9c4WKxq
 jOVuHtDx0Vo8ylBY+kvOY4woQ0QGQSpP8256aeKxDdxNzJvl7MsrS27Kw0kUc20GcEUY
 u+hRUaKpl/SAq5UbTfWbfKvdNB5TtsaUKfA1zOxL3XLeRDI6ESvNHsrSFFqueJ94Slc7
 q9qgMJ/i2Eqja0LowtScchg3RdGtfjVfljvtPa+K39OIYAHAdISq3ai1WIcqjaj7hvpL
 MHSBcLUQ7FFFedbrGwsANBnOUS7+WlO/lib8nNq3fCX9lSFLpYkQBX7u21V4UmBbjWsi
 GDBA==
X-Gm-Message-State: AOJu0YwWx2b9sfQTB3/u3FfHxpc5eSZX5kxxfNbG3vK6GSdGmmMdZ9pI
 xzVy/ou9I3qjczK584qHF6cGA6rF+ctbs4zZkrY82Cc/N2iOXdKsAZ2PbG4c4Jzh2xuWonFmXnD
 7nBOn
X-Gm-Gg: ASbGncsW6LEdI6MjU7qXZh+bT6IAowD/ZXxDmLrmB/TNAWGKB6l6fI4pPdVIyzNBvVZ
 sdfH64E311VEj28J25JzPTfBorpPKc5pKUENEnLGOKlhEiurCxXeeEh3yFAyY9AFZi8rUao1Nle
 QTEvMzO+7EWsfbu+gMYvXEmXnPHnxiHyRQmDIZxTrXafbjp3BKY4CRlAqnLGuiVTQztz0gZidcn
 kpWdWVn/xSw2qPcYKXVUfOocKHPdQvQB60AldKWDSWMK/KJH7s+Fe31rgPkbQCJMjemj+Cc/Ot4
 8dXDKwcSaMBqdACcBEDvEdK1XpDwXkBA2vSakePiHtbzwlwdRFKMINmmKmfHMYXmF5/5OmaPY8u
 E3c2JctxLkBOFd3TtfVNt/pMkb19jQKbOoxDJH0rOtwbKm6iRwiBGs4L0Ubqfjf7Z1a7GO0cdnz
 w=
X-Google-Smtp-Source: AGHT+IHtdYuuQwvZkURUKfRxEV9vIEKBuniZ/VuLihnLeE7DA482kdwpftGyAOQZWwj7c/2xzDxlDw==
X-Received: by 2002:a05:6512:3d27:b0:553:2bf2:e30b with SMTP id
 2adb3069b0e04-55a045ed5b7mr493984e87.18.1752216724549; 
 Thu, 10 Jul 2025 23:52:04 -0700 (PDT)
Received: from localhost.localdomain (87-100-218-141.bb.dnainternet.fi.
 [87.100.218.141]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5593c7bb8acsm766175e87.51.2025.07.10.23.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 23:52:04 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: u-boot@lists.denx.de
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] Makefile scripts/Makefile.lib: fix *_efi.so dependency to
 PLATFORM_LIBGCC
Date: Fri, 11 Jul 2025 09:51:49 +0300
Message-ID: <20250711065149.350463-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.49.0
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
 Makefile                     | 3 ++-
 examples/standalone/Makefile | 2 +-
 scripts/Makefile.lib         | 2 +-
 scripts/Makefile.xpl         | 3 ++-
 4 files changed, 6 insertions(+), 4 deletions(-)

v2: introduced PLATFORM_LIBGCC_LIBA variable with just lib.a filename,
    PLATFORM_LIBGCC can have other flags too

v1: https://lists.denx.de/pipermail/u-boot/2025-July/593982.html

diff --git a/Makefile b/Makefile
index 93e9f4018423..649b16643eea 100644
--- a/Makefile
+++ b/Makefile
@@ -1072,7 +1072,8 @@ u-boot-main :=3D $(libs-y)
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
index 5db2fbc418a1..24bff63d68e7 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -533,7 +533,7 @@ $(obj)/efi_reloc.o: $(srctree)/arch/$(ARCH)/lib/$(EFI_R=
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
index 03a2f151d916..f0fc7ae923d8 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -139,7 +139,8 @@ libs-y :=3D $(patsubst %/, %/built-in.a, $(libs-y))
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

