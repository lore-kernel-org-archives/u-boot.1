Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7D5C83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 14:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFAA38368F;
	Thu, 10 Jul 2025 16:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f0Rrq2ne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAD5783693; Thu, 10 Jul 2025 16:45:20 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B3378363C
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 16:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikko.rapeli@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-553b5165cf5so1317525e87.0
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752158717; x=1752763517; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+ZZj0jCRJ0Fo1xXvqy8LtTCgHnaX/O68LQT3l/8Vpog=;
 b=f0Rrq2neSfQ/6bnpUaSkLMGWQk6utCUYPdwyCEKdMoCqdWfYT5kOkucWt2pjhCpFhh
 Z+OVjAkqn6xcmg/0YzSArly5A8VqTOyP+7RjSXk7e9QI2g+hCrItNn+7uxxW1sADQ8DD
 St4MFdzEaM5LNNNZitiQlIBHUB7hFI7RPWwS6H44sh2klXWCh2z/HLEcm52oTWYccXnJ
 gFuIp4hHe6CGubqjaEtrzY5DEkEg980FBrXQcc/0tmkkHPtAElodERoZ5jVwxdGvoY5b
 JrFXzaqducjys9fGN/RYQRQ/k+1ftjy23q4AOC+S15a6bxMVRNyjmUwH23GiJD+uwAh9
 IuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752158717; x=1752763517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ZZj0jCRJ0Fo1xXvqy8LtTCgHnaX/O68LQT3l/8Vpog=;
 b=O/jYaoLRhBQ6/eIaaFSMlelEjANKm3i9SAupiuCJ6DRgFyJLIBRBSgpBpL0J3VFlIs
 vSXycusZ/4NMK3NsjOHiFC8nGwnOKKhg9S64cG8bPsI4x3qPNKXwjWygyWuN6Ph/TyQT
 oNf6G+BgCm2TiqCxvq4Yo/nwPEQI34s4hXFnll5yuVhCSA7zTiI4r41Ak/CFdsAKWhTT
 YYZ1ZsShY+/qUtZGiNmma84hUbSqGpLFGk6YEfUUmSGd1FiaLb4rzVOb2BB4UAaAc9kQ
 Fiu6gqSrdThSR3yB8wsOOEmWTNPKxxeL75UQvAklJx1+f8vovsw0AX4wyfRBxVdDa8XP
 86Bw==
X-Gm-Message-State: AOJu0YxyR5K9ngz0K7sBiLAQ8SANa7fQWNek6dEJhJ3ISobif1RlDMuk
 y7iJgSyGa7nyyTfdtHKbDd0m8KpKNxSBLgz9l5uOvgQu8RLKo/qmjkYKouWPZHrdmfarQAIV7nq
 eq2KT
X-Gm-Gg: ASbGncuGoxpE1CyLEZkoca0bO0UYLBW5FUzVn/icpfIZicI+LFSFsQaFO65ZG49tFhA
 8zHWXCnGy6G8plnjkHHyM8EMVfVVl9zER15Z3FchEZfCuppssxixzoHFmh7CHkPuavUggyY2vC3
 tqMieLMfl5lZNA/kjNQaR9qvKGmuaRgqrJEkGhjsTb9fiNa2F/B1+coHBOP2Sq5XjYMjoAKLAhM
 9MUgsPop7X8aH9fDIkH+RT42jTpXTptXufPWxgiYyBHoIW4bQeKesjlHPw56COSTshu5aVZexu8
 aRWVFQT/5Yhoh6fSB51Rey7mVcIRlJTTn/99/Brf6muYdmkdpgQrstgl/AT+iDy52ZCK5+xXBIQ
 Fh+DPwrfHAPHE9s9/yjjFdDOSko6dpDtwSTmsUoc=
X-Google-Smtp-Source: AGHT+IEk4nuX3fHHmBZvy9P9nDsq5VKDHOH3v5dbqMH/XkD5j76mJcHtgHcnumFElEVf4jjNo1KjhQ==
X-Received: by 2002:a05:6512:4013:b0:549:38eb:d694 with SMTP id
 2adb3069b0e04-558fa8f915fmr2235848e87.26.1752158717472; 
 Thu, 10 Jul 2025 07:45:17 -0700 (PDT)
Received: from localhost.localdomain (87-100-218-141.bb.dnainternet.fi.
 [87.100.218.141]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5593c7bbd4asm389744e87.2.2025.07.10.07.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 07:45:16 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: u-boot@lists.denx.de
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] scripts/Makefile.lib: fix *_efi.so dependency to
 PLATFORM_LIBGCC
Date: Thu, 10 Jul 2025 17:44:45 +0300
Message-ID: <20250710144445.335480-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 10 Jul 2025 16:48:46 +0200
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
added to the dependency of the .so rule. Thus a build can try
to link *_efi.so files before PLATFORM_LIBGCC lib.a is available.
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

Fixes: 43d43241d1c9 ("scripts/Makefile.lib: add PLATFORM_LIBGCC to efi link=
ing")

Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index e89a4a51b74d..54e17b2f8089 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -508,7 +508,7 @@ $(obj)/efi_reloc.o: $(srctree)/arch/$(ARCH)/lib/$(EFI_R=
ELOC:.o=3D.c) $(recordmcoun
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
=20
-$(obj)/%_efi.so: $(obj)/%.o $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/ef=
i_freestanding.o
+$(obj)/%_efi.so: $(PLATFORM_LIBGCC) $(obj)/%.o $(obj)/efi_crt0.o $(obj)/ef=
i_reloc.o $(obj)/efi_freestanding.o
 	$(call cmd,efi_ld)
=20
 targets +=3D $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/efi_freestanding.o
--=20
2.43.0

