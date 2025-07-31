Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFBAC87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 11:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED597838AB;
	Thu, 31 Jul 2025 13:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mg3+ODMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8331D83852; Thu, 31 Jul 2025 13:53:22 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16F0083852
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 13:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikko.rapeli@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-55b797ad392so915957e87.3
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 04:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753962799; x=1754567599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KeLvsvwRGp4uSJXK4XfMGUK3W4ln46neOemZFB8ajjg=;
 b=mg3+ODMq6JJSK+FE/XIHei12CZHBPTo/R77gdv+e5kP0Us2NAuakBlD/whlE7ljdyP
 xWtfC/Z483ZxpMg1p6ORf1UQgsVW2CJ7VV2CKp9Cl4PN6ums80qZPQce5SrL+iaCpXL/
 lWmuw4nfYIlFOdJ54AYD4AB5YKRZzj3ZJBSlmNJfiPU0EHTXlmaZEhIENOovL6WJ/BnU
 yqqSgYUCkFTzXVXsa22JOFeOZXlvkkonnmmMZrE53S50jH8eWlfNaGaeIl+1K0CASkks
 nl1Fr+pb38jDSDtkzQKagYsVrYiQvnmhz2CNasOD0nBRo9PfsHmkZin+ArY9cB2XTNpq
 7InQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753962799; x=1754567599;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KeLvsvwRGp4uSJXK4XfMGUK3W4ln46neOemZFB8ajjg=;
 b=BITwxtzeCQhyomTPjjlk7aNsycqQKY1bpYafWEk51Rmb73K2+j6QysRpjNl4EJuHTQ
 +r6dwzcSzDNxaTaXQ8ta08jucepJeKjgrjoP+Tw/H8UmWeOB0LkfWs+hwINsP8WNonoD
 36wPGhyhHzA7wgV3/2qGDGrG0/RpCSuqWJuLtoaA7j0VxyrDdbTL/n84grI2Y7kThshK
 rDKUnPCZHyK+5jL9FG5O2XqNz4I4Qih6GJJtMbaNOGUuI37qCa/7IihzLKryc6aiwvgE
 DX9JMmuEUmOFJk4MFjtOzn8QBKXlURA3SyWRfHsUU/gqZ/dzU32lqoCJY+6M5+8HO81H
 g1zw==
X-Gm-Message-State: AOJu0Yz5LkdugVm2Z7vIFXMdiNYyZOqByUk26JteXfGZCRXsbqvCsCCg
 YPjkKj11DBDWu39ToB77i9NMAy9qFytQTEXl6d+9xJ2InQIFqi4w1viB6ZOcUUqisVFQtsPMLos
 mVbLh2Ws=
X-Gm-Gg: ASbGnctQdFYQVfnmIXEZOZpdVV8CEZ6R4fHENUGgm7209K0o348YfbCYEciT7jflEHH
 gIN46GrWVI9E7LRZ710nrKWbzk4RP2z5Gc9DdQW7XkSxMDzXrEb2qCvJHdHJxrBwghjdXqVzqWI
 RsVt8j1uMuC7c5HJPCytybLjAWS1FsUg0SLnYyarNuHVr7J3WzfsAwXixQiJT/wh++e8iceZUYs
 ugMlNAMgtFO3SnULfUp/7WNUoetoCfNHea0dHM5EiY6VkEF7KZpaHsED1sbXYgBVQReh3yJ5nUc
 cPj9AFKn0wVKw2SaGbuaLp3beLBIiliAVVkG5ZDr7OEk3hGKZjwkBwSKbToAdVtLTS6hnzwKXvR
 1nLHIDkAVqwaZBirjknaM7TSbWB6J7hk8jSrCE7bB1P971RuEMJX+7PI=
X-Google-Smtp-Source: AGHT+IHX7CpmkpMSbij5vaociOEgsQake/XbNIe5dVwl7PLSQv7VFW7jxGyV40ocleYFuvtKmWnYqQ==
X-Received: by 2002:a05:6512:3050:b0:55b:8a28:3cbc with SMTP id
 2adb3069b0e04-55b8a283d8cmr493806e87.51.1753962799233; 
 Thu, 31 Jul 2025 04:53:19 -0700 (PDT)
Received: from nuoska (87-100-218-141.bb.dnainternet.fi. [87.100.218.141])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55b889a8278sm205823e87.57.2025.07.31.04.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 04:53:18 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: u-boot@lists.denx.de
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v4] Makefile: add dependency from lib to arch/$(ARCH)/lib
Date: Thu, 31 Jul 2025 14:52:48 +0300
Message-ID: <20250731115248.264837-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
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

Top level Makefile starts separate "make" processes for each each
subdirectory. lib/efi_loader apps now depend on lib.a from
arch/$(ARCH)/lib if CONFIG_USE_PRIVATE_LIBGCC is enabled which creates
a race conditions since dependency from lib/efi_loader EFI apps to
arch/$(ARCH)/lib/lib.a is not explicit:

arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No such file or directory
make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/testapp_efi.so] Error 1

This error was seen on yocto/OE-core CI builds after u-boot 2025.07 update:

https://lists.openembedded.org/g/openembedded-core/message/220004

https://autobuilder.yoctoproject.org/valkyrie/api/v2/logs/2914600/raw_inline

    |    rm -f lib/efi_loader/built-in.o; arm-poky-linux-gnueabi-ar cDPrsT lib/efi_loader/built-in.o lib/efi_loader/efi_bootmgr.o lib/efi_loader/efi_bootbin.o lib/efi_loader
/efi_boottime.o lib/efi_loader/efi_helper.o lib/efi_loader/efi_console.o lib/efi_loader/efi_device_path.o lib/efi_loader/efi_device_path_to_text.o lib/efi_loader/efi_device_
path_utilities.o lib/efi_loader/efi_dt_fixup.o lib/efi_loader/efi_fdt.o lib/efi_loader/efi_file.o lib/efi_loader/efi_hii.o lib/efi_loader/efi_hii_config.o lib/efi_loader/efi
_image_loader.o lib/efi_loader/efi_load_options.o lib/efi_loader/efi_memory.o lib/efi_loader/efi_root_node.o lib/efi_loader/efi_runtime.o lib/efi_loader/efi_setup.o lib/efi_
loader/efi_string.o lib/efi_loader/efi_unicode_collation.o lib/efi_loader/efi_var_common.o lib/efi_loader/efi_var_mem.o lib/efi_loader/efi_variable.o lib/efi_loader/efi_var_
file.o lib/efi_loader/efi_watchdog.o lib/efi_loader/efi_disk.o lib/efi_loader/efi_net.o lib/efi_loader/efi_smbios.o lib/efi_loader/efi_load_initrd.o lib/efi_loader/efi_confo
rmance.o
    |   arm-poky-linux-gnueabi-ld.bfd -nostdlib -zexecstack -znocombreloc -znorelro --no-warn-rwx-segments -L /srv/pokybuild/yocto-worker/oe-selftest-armhost/build/build-st-
3119200/tmp/work/beaglebone_yocto-poky-linux-gnueabi/u-boot/2025.07/sources/u-boot-2025.07 -T arch/arm/lib/elf_arm_efi.lds -shared -Bsymbolic -s lib/efi_loader/helloworld.o
lib/efi_loader/efi_crt0.o lib/efi_loader/efi_reloc.o lib/efi_loader/efi_freestanding.o arch/arm/lib/lib.a -o lib/efi_loader/helloworld_efi.so
    | arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No such file or directory
    | make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/helloworld_efi.so] Error 1

The different "make" processes share common scripts/Makefile.build
and scripts/Makefile.libs but since they are separate processes
the Makefile rules can't add a dependency from lib/uefi_loader targets
to arch/$(ARCH)/lib/lib.a. Or the file level dependency can be added but
then "make" produces a too sparse error message which does not mention
that one of the dependencies like arch/$(ARCH)/lib/lib.a was not found:

make[3]: *** No rule to make target 'lib/efi_loader/helloworld.efi', needed by '__build'.  Stop.

Fix this dependency problem by building arch/$(ARCH)/lib before lib
if CONFIG_USE_PRIVATE_LIBGCC was enabled.

To reproduce the race condition more reliably, add a "sleep 10" delay
before linker command cmd_link_l_target with 2025.07
or to $(lib-target): target in scripts/Makefile.build with master branch
after Kbuild update.

Fixes: 43d43241d1c9 ("scripts/Makefile.lib: add PLATFORM_LIBGCC to efi linking")

Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

v4: replaces two patches from v3 which did not fix the root cause correctly.
    Top level Makefile level dependency is needed to fix the race
    condition.

v3: added "export PLATFORM_LIBGCC_LIBA" like PLATFORM_LIBGCC, not sure
    how testing worked without this before
    https://lists.denx.de/pipermail/u-boot/2025-July/594581.html

v2: introduced PLATFORM_LIBGCC_LIBA variable with just lib.a filename,
    PLATFORM_LIBGCC can have other flags too
    https://lists.denx.de/pipermail/u-boot/2025-July/594034.html

v1: https://lists.denx.de/pipermail/u-boot/2025-July/593982.html

diff --git a/Makefile b/Makefile
index c31bf7ecea97..b03f87a93fb9 100644
--- a/Makefile
+++ b/Makefile
@@ -2131,6 +2131,11 @@ $(filter-out tools, $(u-boot-dirs)): tools
 # is "yes"), so compile examples after U-Boot is compiled.
 examples: $(filter-out examples, $(u-boot-dirs))
 
+ifeq ($(CONFIG_USE_PRIVATE_LIBGCC),y)
+# lib/efi_loader apps depend on arch/$(ARCH)/lib for lib.a
+lib: $(filter arch/$(ARCH)/lib, $(u-boot-dirs))
+endif
+
 # The setlocalversion script comes from linux and expects a
 # KERNELVERSION variable in the environment for figuring out which
 # annotated tags are relevant. Pass UBOOTVERSION.
-- 
2.43.0

