Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A45CDB470
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 04:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26D9284995;
	Wed, 24 Jun 2026 06:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kudzu-us.20251104.gappssmtp.com header.i=@kudzu-us.20251104.gappssmtp.com header.b="rqGdLnye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E4BA849CE; Tue, 23 Jun 2026 23:04:05 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B778B849BF
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 23:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=jdmason@kudzu.us
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e93cd4e64bso267762a34.2
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782248641; cv=none;
 d=google.com; s=arc-20240605;
 b=UZl7ZUzbs0RP+J8NEUwXIYQoFbKL0KbIyH6JTZJKW8wCbng6v+r3nkWsI81HqQRy9T
 58bT4GdmmzPrpMq2H026Vr76iXxEz0/5I+KziMjxaQ2Wrw+TBdSNkpxRLx0BZJTN7AWz
 vlEnH85R4hZJTT1/SzLVDi+j8sVGKjVKKDQY9c84I77eSjoMA1VbQ9GreCADWm6QNzjZ
 7FN4MB+CxaV4iG/qkYS3fLZ8V+koECUvmqS8QVrA6Kad3cVBqrkCvMW8hKpBMZmkLA4g
 ATqJtDcNzkrR83I0ScSjwel0qF99cuPa4X8jm/wKKd+f7zlzLBFsF21zgD2d/At/1ZTg
 oJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L2yulm/Hv317xv2jxhVvdGs3ywqFTiY5hyS+OE7gMmY=;
 fh=BVMZR5k21vuV0/l77AzaE6baA0zbLDNPNElFM6bU8UQ=;
 b=itUSLkbxnfc3dOeIQB04+lNtW/fPTV9lYbUOhXE9nfPff4+qElCfIT0zmx6t3tret4
 PSP1oeFDVT/WZwLyxQCER31z5M8QhlqSAuzW9Kseu9yJTi0h9Pge0E+gu2AlIopnWVaE
 h/ACEDFpFAK+VHV29mDDH/2CXPpSomQC7q6y/jqlj2y1CFWeq7LhXGSeDoPb7AWb/r95
 j+GsgEP3358tCfwscts0p+c9DEt5Elca4Fh4oatIRk63bYHGd/a5H5SOGbklKsunVE6h
 JsKhBfO6L63gkYmcW4cyYW6oftf4eybBQQ1UgZ+apSSjZr+lXP7wR1QkfbFVAN+ThJrL
 QO2A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kudzu-us.20251104.gappssmtp.com; s=20251104; t=1782248641; x=1782853441;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2yulm/Hv317xv2jxhVvdGs3ywqFTiY5hyS+OE7gMmY=;
 b=rqGdLnyeWIL9/HXX11p9uXyy4PsbqBaKmYMLrEzTJW0BEJee1K8e/rzmp+FSMW80Dm
 cEUbU/P67SXH1phcCL9ISEH/tcgMTcYuGO39hCUL0CHR6BIz9R0U8vMgHoHaW71Ey9hR
 j2jgFLth1qPwIxJLqlyp8N24VqW+7/QD48N8uSbP3nGoAgYTJJVMibUiBoNYfCaeM04A
 XmRGZhUfJzK1V0d6loPTO7v757VFAmuWH6SEVNrDkMuXC3xa+JdMR6RAoIUCyDKCR27v
 vHLUS1fU3ZZFo3diqZ7FoF/fyaaQDQTAJLz5iPqEqnGzr7RpHei9MocxLOhapYzqbkdL
 0ePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782248641; x=1782853441;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L2yulm/Hv317xv2jxhVvdGs3ywqFTiY5hyS+OE7gMmY=;
 b=guW6CK7b1d7SBknuOYx38KvM10oBQf4xOTs+nyAjXlRF6cF37+EuWrYwzSjXBeeDCA
 ak5e8j+k5mqrXWg23o8TtZG9lae+ZhQMQZ4Ljt++HvbmOE4XCH56wWKQhKTDF9GoqVi1
 D7IhtTJTrJTwRLSZ38J87zrWsWBdKa5G6oNk85keVt8dzdbCOjCz0pX64rd0CkMssgD3
 dsnfYV7zv5j/SltlqSfWAluJmUl63lIw247AUMSYmFSFs7kW2BQniqZe8RqGd/jz+76n
 h1CG7zoT0jgwuCHpKQBaREfZhmSvV/wl/SFUh93o+l9xaMQxbLvGpSaqp1nNXthcp3jy
 xZkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ83/ChO5zkA0MHqOT3EIMl4mu3MPPOcuucLhYX4zT0XrMgDjdJMLicbPM2xPm4J+7oouoQsApU=@lists.denx.de
X-Gm-Message-State: AOJu0YwJRhFuAr68RIB1NBLDklmKkqhuG6dNCkR+k20pBnTC37Bdi7Fq
 VuXLXqU8tQSGwWx9/kFHo1VLLCV5jclweN7vWxinSGmUAyelc2ca/mfZLDhTiQ4mGGqShSDkX4w
 Adp7nNQDUkr7ue1c9RngE9myncZlSkq0gRIi6HXrq
X-Gm-Gg: AfdE7clT6QKB7WeaINFBh5M44U8qUqhScLsYN3iMnPe1joN+X9ZLcatJcf2CZkRqx1Z
 3whXZ/lBy4/ZbBkfPH9I06lgVOn+3VKRVGasGPEOh75ZmCQS+HMIrsGUpT+kI2T/HE8ityG5T7R
 WrU9KZziDZYF+4y/FjVh3Mdm21WiXtpgyURiVCPZW7ghoSnGyrZA5uqoobophWYV0s86bj/redm
 JZMMZzhAmg08P521tkOWYAdrfR87FRz41YfqIljwaTAA13IVyh6+gjmbyBSDdOvUsaIDaUYqAp5
 s9F6aJc=
X-Received: by 2002:a05:6830:6684:b0:7e6:eb9c:3781 with SMTP id
 46e09a7af769-7e9794d3dddmr4194309a34.12.1782248641281; Tue, 23 Jun 2026
 14:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260619155857.9665-1-jon.mason@arm.com>
 <FC600559-0FE9-4EA3-B047-F69CEAB64795@gmx.de>
 <CAPoiz9zGJuhZjGgWTV1dz1mh9KET6zBaL62LB4upooUSNYyj5g@mail.gmail.com>
 <2C956F19-DD44-4C45-B8B3-05DD4E6DEDA0@gmx.de>
In-Reply-To: <2C956F19-DD44-4C45-B8B3-05DD4E6DEDA0@gmx.de>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 23 Jun 2026 17:03:50 -0400
X-Gm-Features: AVVi8CfmwZjNXj-BEed5fz_sYlYlcrNnW89A2n5ikSOLPtRu3fdyMo2gb1CrWnc
Message-ID: <CAPoiz9zg4OXgHo5J3WtJHKOEuWOdCDrugWfAt6Z+d71j=+q8oA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: move efi_var_seed.o to objtree
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jon Mason <jon.mason@arm.com>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 24 Jun 2026 06:48:40 +0200
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

On Tue, Jun 23, 2026 at 4:16=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> Am 23. Juni 2026 21:03:38 MESZ schrieb Jon Mason <jdmason@kudzu.us>:
> >On Fri, Jun 19, 2026 at 12:46=E2=80=AFPM Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
> >>
> >> Am 19. Juni 2026 17:58:57 MESZ schrieb Jon Mason <jon.mason@arm.com>:
> >> >With commit bd3f9ee679b4d1456d0d3c261ab76788950e6096
> >> >(kbuild: Bump the build system to 6.1), there is an issue when trying=
 to
> >> >build out of tree, where efi_var_seed.S wants ubootefi.var to be in t=
he
> >> >object tree, but lib/efi_loader/efi_var_seed.o wants ubootefi.var to =
be
> >> >in the source tree.
> >>
> >> Ubootefi.var is an optional file with the EFI security database. Why w=
ould you ever put it into the build directory?
> >
> >I didn't know that was a limitation.
> >
> >Would you prefer that I make a change like:
> >-$(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
> >+$(obj)/efi_var_seed.o: $(srctree)/lib/efi_loader/$(EFI_VAR_SEED_FILE)
>
> Hello Jon,
>
> It is still not clear to me why you want to change this.
>
> If you don't like the current default, why wouldn't you change CONFIG_EFI=
_VAR_SEED_FILE in your local .config file to match the storage location of =
your seed file?

Sorry, I think I've not been clear.  I have a previously working setup
in my Yocto layer for ~2 years.
After u-boot commit bd3f9ee679b4d1456d0d3c261ab76788950e6096 (kbuild:
Bump the build system to 6.1), it no longer works.
I'm only seeing this now because Yocto recently updated u-boot to v2026.04

I'm seeing the following error:
<snip>
|   aarch64-poky-linux-gcc
--sysroot=3D/builder/meta-arm/build/tmp/work/qemuarm64_secureboot-poky-linu=
x/u-boot/2026.04/recipe-sysroot
-fcanon-prefix-map
-ffile-prefix-map=3D/builder/meta-arm/build/workspace/sources/u-boot=3D/usr=
/src/debug/u-boot/2026.04
 -ffile-prefix-map=3D/builder/meta-arm/build/tmp/work/qemuarm64_secureboot-=
poky-linux/u-boot/2026.04/u-boot-2026.04=3D/usr/src/debug/u-boot/2026.04
 -ffile-prefix-map=3D/builder/meta-arm/build/tmp/work/qemuarm64_secureboot-=
poky-linux/u-boot/2026.04/recipe-sysroot=3D
 -ffile-prefix-map=3D/builder/meta-arm/build/tmp/work/qemuarm64_secureboot-=
poky-linux/u-boot/2026.04/recipe-sysroot-native=3D
 -Wp,-MMD,lib/efi_loader/.efi_var_seed.o.d -nostdinc -isystem
/builder/meta-arm/build/tmp/work/qemuarm64_secureboot-poky-linux/u-boot/202=
6.04/recipe-sysroot-native/usr/bin/aarch64-poky-linux/../../lib/aarch64-pok=
y-linux/gcc/aarch64-poky-linux/16.1.0/include
-Iinclude  -I/builder/meta-arm/build/workspace/sources/u-boot/include
"-DMBEDTLS_CONFIG_FILE=3D\"mbedtls_def_config.h\""
-I/builder/meta-arm/build/workspace/sources/u-boot/lib/mbedtls
-I/builder/meta-arm/build/workspace/sources/u-boot/lib/mbedtls/port
-I/builder/meta-arm/build/workspace/sources/u-boot/lib/mbedtls/external/mbe=
dtls
-I/builder/meta-arm/build/workspace/sources/u-boot/lib/mbedtls/external/mbe=
dtls/include
 -I/builder/meta-arm/build/workspace/sources/u-boot/arch/arm/include
-include /builder/meta-arm/build/workspace/sources/u-boot/include/linux/kco=
nfig.h
-I/builder/meta-arm/build/workspace/sources/u-boot/dts/upstream/include
 -D__KERNEL__ -D__UBOOT__ -D__ASSEMBLY__ -fno-PIE -gdwarf-4 -I.
-D__ARM__ -fno-pic -mstrict-align -ffunction-sections -fdata-sections
-fno-common -ffixed-x18 -mgeneral-regs-only -mbranch-protection=3Dnone
-pipe -march=3Darmv8-a+crc -D__LINUX_ARM_ARCH__=3D8 -I
/builder/meta-arm/build/workspace/sources/u-boot/lib/efi_loader -I
./lib/efi_loader    -c -o lib/efi_loader/efi_var_seed.o
/builder/meta-arm/build/workspace/sources/u-boot/lib/efi_loader/efi_var_see=
d.S
| Assembler messages:
| /builder/meta-arm/build/workspace/sources/u-boot/lib/efi_loader/efi_var_s=
eed.S:14:
Error: file not found: ubootefi.var
| make[3]: *** [/builder/meta-arm/build/workspace/sources/u-boot/scripts/Ma=
kefile.build:344:
lib/efi_loader/efi_var_seed.o] Error 1
</snip>

My ubootefi.var is in the root of the u-boot source when building
(where it has always been), but it is no longer being found.

Something is broken, and I _think_ it is not being seen by others
because they build in their source tree (whereas my obj tree is in
another location in my file system, due to how yocto works).  That is
assuming that this is being tested, otherwise it is broken for
everyone and not just me.

With the patch in my first email, and some changes to my yocto
recipes, it is working again.
With the changes I suggested in my previous email, and some changes to
my yocto recipes, it is working again.

I understand your first point that the ubootefi.var file is coming
from outside, and thus doesn't belong in obj.  This is why I did some
more ugly hacking today to find the changes I suggested earlier today.
It seems like the S file is looking in the local directory,
lib/efi_loader.

I am more than happy to test out any patches, if you come up with one
that addresses the issue.

Thanks,
Jon

>
> Best regards
>
> Heinrich
>
>
> >
> >This seems to work for my use case, and still keeps it in the src direct=
ory.
> >
> >Thanks,
> >Jon
> >
> >>
> >> Heinrich
> >>
> >> >
> >> >If we change efi_var_seed.o to look in the objtree, then it should wo=
rk
> >> >in both local and out-of-tree.  However, it would require anything
> >> >previously working to put ubootefi.vars to the objtree, but it's brok=
en
> >> >now anyway.
> >> >
> >> >Signed-off-by: Jon Mason <jon.mason@arm.com>
> >> >---
> >> > lib/efi_loader/Makefile | 2 +-
> >> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> >diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> >> >index f490081f6542..9c836f6ee237 100644
> >> >--- a/lib/efi_loader/Makefile
> >> >+++ b/lib/efi_loader/Makefile
> >> >@@ -74,7 +74,7 @@ obj-$(CONFIG_EFI_ECPT) +=3D efi_conformance.o
> >> > obj-$(CONFIG_EFI_DEBUG_SUPPORT) +=3D efi_debug_support.o
> >> >
> >> > EFI_VAR_SEED_FILE :=3D $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
> >> >-$(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
> >> >+$(obj)/efi_var_seed.o: $(objtree)/$(EFI_VAR_SEED_FILE)
> >> >
> >> > ifeq ($(CONFIG_EFI_CAPSULE_AUTHENTICATE),y)
> >> > capsule_crt_path=3D($(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE)=
))
> >>
>
