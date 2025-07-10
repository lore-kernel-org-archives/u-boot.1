Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088A1C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 15:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 637B583666;
	Thu, 10 Jul 2025 17:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="leUTJ6nA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04D128367F; Thu, 10 Jul 2025 17:08:20 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 957D48363C
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 17:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikko.rapeli@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-55511c3e203so998736e87.3
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752160097; x=1752764897; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XJvwfO1fxpPpkOHUd0pox0sy564ufCdjguskFlVUsmk=;
 b=leUTJ6nAH5jmzvc1cH9W/ZW4vmRj1t5UNppXUZNYE6FJ725KPA2k4eLPf8rc4TuHOs
 6zfvVDyqMQ+Ggy5KjW3yBOWB4gh7fAsHfrnPSYyErIJ+3Jm8ZB9cm3QKu1OrxvM3jjY0
 EDUBPaQYGkOq22BFe4cXfI0vOtUljv2qUBpkLdJqafnl0UnOy8ajpOHZV6e1veeL40Lt
 meGV3meFYXBw63YKQ/SkC5ZmYXaNVPSn5XZGysVB7jm14g5ejegylaGZeMaKCHbhOwIh
 3caS7dJVFGykG/uL+9MRP9z1RN4+HNHzpPHUWzWS1fSYC8sxG6XN77ujcmMvm0EgB9SK
 gDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752160097; x=1752764897;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XJvwfO1fxpPpkOHUd0pox0sy564ufCdjguskFlVUsmk=;
 b=CWBl+juCgp7RQ+Pa6nprmWPiM7UiuDrXw07DvL8QkXCBCRRDEibYLaZlzrnee4ehfu
 VHNLPnykF16eVg2ltNoSyG3LPC1k0QoEWxoEFtDCUGnGvvnbAmOGR32a5DwZ2LPY3jz6
 Su3J62NgfYK/7T8zDgfyPN3i/s9GHPFn1npwKwU3OpcxnEkwf5NSMFG4FNG7eNJYBDVO
 6aT5K8ZUHEvBzLFVyaVQx3Qo2sqMFW7RUq7FK4+HQtxckblZIqyRi0OfJJOunu/Wj+Or
 7agLOfzo3z9v/0Nry/ChsbhRe5++FdbbXernGtXfpSJcg9mQJmYKKtnAEh1i0dimKXVk
 aHyw==
X-Gm-Message-State: AOJu0YwVUanI/wiR78UTArzk7AyUGM6M5B+JCfZ0M5JBcE/QzV/1/DwE
 1whUirkRnW/VJqIHw+qqPznOOQv9lHr1K0KvEMI4XtnUie33hezmz8lr/CcdmzeOhYes/SXQfS5
 e1Fpd
X-Gm-Gg: ASbGncvMFlPChC+b8s94P3dgbYcrElhNj4r72OzBUQBjtGNybNkkHriAy4BD2DPjvIY
 iOoI4mqxzV2i4azyZC5ae5DLtuqkIs6HXbO3YyQeDyq8S+pGDOpBNhfMTdL6yXtK1ZBjXU/VO6d
 e3mdWWoaFzcDdRABIQ7mz+IWtExLVmjx28oSev5Zdfbm3q7kLM9zn+kj5NcI6Dl1/0EuwZf0Usd
 pz80c95/sIeQfUWEiXnEdkK4oeY9oJXQc9ckm4nl96lYmHrt0TAxicftnha5ug+Ow1t84Ves4Ek
 30VfgWSa03WE9L98z39U5ALlPn6Te8wrIvvXqaSd8HX1O7YyzrYFdAMLIDH4zbwOsvhz4yal/Aq
 LWoDqvVjLRVq0JJwCDgk=
X-Google-Smtp-Source: AGHT+IGqjAuYpVVPkexWXJoXiNutmagAV/b0rQl5/PU0JzMEoLFVZB9+GhiOpOA70lX1Gh0aO1gJew==
X-Received: by 2002:a05:6512:b8a:b0:553:d8ca:4fcb with SMTP id
 2adb3069b0e04-5592e34ff8fmr995542e87.21.1752160096525; 
 Thu, 10 Jul 2025 08:08:16 -0700 (PDT)
Received: from nuoska (87-100-218-141.bb.dnainternet.fi. [87.100.218.141])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5593c7e9420sm398166e87.58.2025.07.10.08.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 08:08:16 -0700 (PDT)
Date: Thu, 10 Jul 2025 18:08:14 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Adriano Cordova <adrianox@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] scripts/Makefile.lib: fix *_efi.so dependency to
 PLATFORM_LIBGCC
Message-ID: <aG_XXm3Cvm6DJPQy@nuoska>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250710145903.GB6424@bill-the-cat>
 <20250710144445.335480-1-mikko.rapeli@linaro.org>
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

Hi, moving patch review from oe-core list to u-boot:

On Thu, Jul 10, 2025 at 08:59:03AM -0600, Tom Rini wrote:
<snip>
> I cleared you patch (and moderation flag) but I don't think the above
> works in all cases since PLATFORM_LIBGCC can have a number of values
> only one of which is that file.

Right. Should I make the dependency conditional to
CONFIG_USE_PRIVATE_LIBGCC like it's set in Makefile?

I don't see another variable for lib.a to use in
scripts/Makefile.lib

Cheers,

-Mikko

On Thu, Jul 10, 2025 at 05:44:45PM +0300, Mikko Rapeli wrote:
> When PLATFORM_LIBGCC was added to linker command it was not
> added to the dependency of the .so rule. Thus a build can try
> to link *_efi.so files before PLATFORM_LIBGCC lib.a is available.
> This was seen in yocto autobuilder builds with u-boot 2025.07
> update, see https://lists.openembedded.org/g/openembedded-core/message/22=
0004
>=20
> https://autobuilder.yoctoproject.org/valkyrie/api/v2/logs/2914600/raw_inl=
ine
>=20
> |    rm -f lib/efi_loader/built-in.o; arm-poky-linux-gnueabi-ar cDPrsT li=
b/efi_loader/built-in.o lib/efi_loader/efi_bootmgr.o lib/efi_loader/efi_boo=
tbin.o lib/efi_loader/efi_boottime.o lib/efi_loader/efi_helper.o lib/efi_lo=
ader/efi_console.o lib/efi_loader/efi_device_path.o lib/efi_loader/efi_devi=
ce_path_to_text.o lib/efi_loader/efi_device_path_utilities.o lib/efi_loader=
/efi_dt_fixup.o lib/efi_loader/efi_fdt.o lib/efi_loader/efi_file.o lib/efi_=
loader/efi_hii.o lib/efi_loader/efi_hii_config.o lib/efi_loader/efi_image_l=
oader.o lib/efi_loader/efi_load_options.o lib/efi_loader/efi_memory.o lib/e=
fi_loader/efi_root_node.o lib/efi_loader/efi_runtime.o lib/efi_loader/efi_s=
etup.o lib/efi_loader/efi_string.o lib/efi_loader/efi_unicode_collation.o l=
ib/efi_loader/efi_var_common.o lib/efi_loader/efi_var_mem.o lib/efi_loader/=
efi_variable.o lib/efi_loader/efi_var_file.o lib/efi_loader/efi_watchdog.o =
lib/efi_loader/efi_disk.o lib/efi_loader/efi_net.o lib/efi_loader/efi_smbio=
s.o lib/efi_loader/efi_load_initrd.o lib/efi_loader/efi_conformance.o
> |   arm-poky-linux-gnueabi-ld.bfd -nostdlib -zexecstack -znocombreloc -zn=
orelro --no-warn-rwx-segments -L /srv/pokybuild/yocto-worker/oe-selftest-ar=
mhost/build/build-st-3119200/tmp/work/beaglebone_yocto-poky-linux-gnueabi/u=
-boot/2025.07/sources/u-boot-2025.07 -T arch/arm/lib/elf_arm_efi.lds -share=
d -Bsymbolic -s lib/efi_loader/helloworld.o lib/efi_loader/efi_crt0.o lib/e=
fi_loader/efi_reloc.o lib/efi_loader/efi_freestanding.o arch/arm/lib/lib.a =
-o lib/efi_loader/helloworld_efi.so
> | arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No such =
file or directory
> | make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/helloworld_efi.s=
o] Error 1
>=20
> The issue is hard to reproduce but this change can artificially trigger i=
t:
>=20
>   --- a/scripts/Makefile.build
>   +++ b/scripts/Makefile.build
> @@ -353,7 +353,7 @@ $(modorder-target): $(subdir-ym) FORCE
>  #
>  ifdef lib-target
>  quiet_cmd_link_l_target =3D AR      $@
> -cmd_link_l_target =3D rm -f $@; $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(lib-y)
> +cmd_link_l_target =3D rm -f $@ && echo "HACK, delaying build!" && sleep =
60 && $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(lib-y)
>=20
>  $(lib-target): $(lib-y) FORCE
>         $(call if_changed,link_l_target)
>=20
> Then run a rebuild with:
>=20
> $  rm -f $( find build/ -name lib.a -or -name helloworld_efi.so ) && \
>    make
> ...
>   arm-poky-linux-gnueabi-ld.bfd -nostdlib -zexecstack -znocombreloc -znor=
elro --no-warn-rwx-segments -L /home/mcfrisk/src/base/repo/poky/build_bea
> glebone/tmp/work/beaglebone_yocto-poky-linux-gnueabi/u-boot/2025.07/sourc=
es/u-boot-2025.07 -T arch/arm/lib/elf_arm_efi.lds -shared -Bsymbolic -s lib=
/efi_loader/helloworld.o lib/efi_loader/efi_crt0.o lib/efi_loader/efi_reloc=
=2Eo lib/efi_loader/efi_freestanding.o arch/arm/lib/lib.a -o lib/efi_loader=
/helloworld_efi.so
> arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No such fi=
le or directory
> make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/helloworld_efi.so]=
 Error 1
>=20
> Fixes: 43d43241d1c9 ("scripts/Makefile.lib: add PLATFORM_LIBGCC to efi li=
nking")
>=20
> Cc: Adriano Cordova <adrianox@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> ---
>  scripts/Makefile.lib | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index e89a4a51b74d..54e17b2f8089 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -508,7 +508,7 @@ $(obj)/efi_reloc.o: $(srctree)/arch/$(ARCH)/lib/$(EFI=
_RELOC:.o=3D.c) $(recordmcoun
>  	$(call cmd,force_checksrc)
>  	$(call if_changed_rule,cc_o_c)
> =20
> -$(obj)/%_efi.so: $(obj)/%.o $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/=
efi_freestanding.o
> +$(obj)/%_efi.so: $(PLATFORM_LIBGCC) $(obj)/%.o $(obj)/efi_crt0.o $(obj)/=
efi_reloc.o $(obj)/efi_freestanding.o
>  	$(call cmd,efi_ld)
> =20
>  targets +=3D $(obj)/efi_crt0.o $(obj)/efi_reloc.o $(obj)/efi_freestandin=
g.o
> --=20
> 2.43.0
>=20

