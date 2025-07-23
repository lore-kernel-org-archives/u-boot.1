Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2C4C83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 23:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EB8783577;
	Thu, 24 Jul 2025 01:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AT8h9ZT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E241B835B6; Thu, 24 Jul 2025 01:11:26 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7961B8353A
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 01:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-556373661aaso322212e87.2
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 16:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753312283; x=1753917083; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0twKsT96XcocY5qTZ/2QLkrAJe6QvWBvDA9/E3Kbl2Y=;
 b=AT8h9ZT80O/5tGPN87ew/w6SDiCV7ifgE5QG+jtLTFppfCcXM6GV8mTOF+yWAC6+6t
 +W5/viNfh9sffUk5UL3GYQXoLbi6KW9ElmHhO2MTLjNjgflDRRtw0Adod/BTh2QhgtZ4
 sAD5SoRbNkN5XOTBUoFRnE1TKNstkyfaVQPwWD7vEgqjA4k0/5rUt0itwDOhswwO49jo
 uUloY6uGVRzeI1foPD1uAjqp4UtgRA5pvBmwXSqMtTSuSRi0HREGkjx7226z1F/b9tKa
 98TB3kBkiHssO9pljEnodqsiepOjAHq2iXnJ6u6tLb8zZxpKK9RGZqoXWuuDN9T6T9kv
 7KLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753312283; x=1753917083;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0twKsT96XcocY5qTZ/2QLkrAJe6QvWBvDA9/E3Kbl2Y=;
 b=CHoPmPvtIIbP83r2vM1VDMjTMU5vT+I1L1v5bBoIzejr06SRuGfl/BnQK9fzM0PlwJ
 /Gvx0+TZ6HZI7bRcIVcm/yleZoAFTybr0lBD0I6qzClZFXlyMO4glpAJP0yvIsQzFqP1
 u8iGdCOHZH1azZwvtFo3hbT07DYs3MuYIA7Ivo463O0ZffDFp2KfI+Q2kgY497481Ni/
 4a0oHv0qEGpcE4z0vGQ32EvjgZUHepTzTSebE24oN+Iu181siNzWY8w4hBJp033pfH+4
 c+CiH8xwovAGZcbC+62leCuaMfmo41W426QihdSQywRMPfsgClmI6N6hKlTdF6ymElGI
 Eczw==
X-Gm-Message-State: AOJu0YytkZkDNX54KlYKTpbTZOcOu8SFfUOxE5JIdtPzhgrdn0gtyel6
 Lf5cN6TsKcyBKx/i1+t83encEascc5xBfUBGjB91FZ794hc73xWgOZREEEwmKpErvErzy4SuTlD
 8iSzhLxuK/aCO13C9SNQpkl4vWGfFBKg/Yw==
X-Gm-Gg: ASbGnct7CB4L05pVZ2AoBHxZErlPqT5TgU/r257SPplzJxmRzsZ1M1qWi3Pw0B4EBnH
 mK36Gbflx1+zGXVLMdoAaFKmuI3bduU01R5IMaMVRMKksq7o07JLQq9N6+0eZuF+d0/HyVADFy8
 gyetgChEH09ZJCg+Yc1pdD/TbpBj0yS0YKqVROKXiwHDAcELwi/uQ//cvDSeFXOcPAI7wygy2BJ
 QnltQXW3JOdIcs7QdDR6ityrdftf+lP7HkLpyApxUpVN4r3Jw==
X-Google-Smtp-Source: AGHT+IFPj2MnqBRCNQC7IxUkQJG9T7dBhBsIymzoOCXJSyRAoawWKJ06ExLreZxAAOrLiI1w1oiV8g+qwCh4jNLkrpg=
X-Received: by 2002:a05:6512:612:10b0:55a:4b4a:bb0f with SMTP id
 2adb3069b0e04-55a513c0408mr966086e87.26.1753312282859; Wed, 23 Jul 2025
 16:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250718082959.416152-1-mikko.rapeli@linaro.org>
In-Reply-To: <20250718082959.416152-1-mikko.rapeli@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 23 Jul 2025 20:11:11 -0300
X-Gm-Features: Ac12FXwqT2moX_AhRgBh970qcHdWfAYdtJ-SfjKouN4x0SRVauDOBer2sqOw-mU
Message-ID: <CAOMZO5DEQ1iUA5nEvOkK3KLZdz0q_hZF7WWc8k3ysWKZKe0v1Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Makefile scripts/Makefile.lib: fix *_efi.so
 dependency to PLATFORM_LIBGCC
To: Mikko Rapeli <mikko.rapeli@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Mikko,

On Fri, Jul 18, 2025 at 5:30=E2=80=AFAM Mikko Rapeli <mikko.rapeli@linaro.o=
rg> wrote:
>
> When PLATFORM_LIBGCC was added to linker command it was not
> added to the dependency of the .so and other rules. Thus a build can
> try to link *_efi.so files before lib.a from PLATFORM_LIBGCC is available=
.
> This was seen in yocto autobuilder builds with u-boot 2025.07
> update, see https://lists.openembedded.org/g/openembedded-core/message/22=
0004
>
> https://autobuilder.yoctoproject.org/valkyrie/api/v2/logs/2914600/raw_inl=
ine
>
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
>
> The issue is hard to reproduce but this change can artificially trigger i=
t:
>
>   --- a/scripts/Makefile.build
>   +++ b/scripts/Makefile.build
> @@ -353,7 +353,7 @@ $(modorder-target): $(subdir-ym) FORCE
>  #
>  ifdef lib-target
>  quiet_cmd_link_l_target =3D AR      $@
> -cmd_link_l_target =3D rm -f $@; $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(lib-y=
)
> +cmd_link_l_target =3D rm -f $@ && echo "HACK, delaying build!" && sleep =
60 && $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(lib-y)
>
>  $(lib-target): $(lib-y) FORCE
>         $(call if_changed,link_l_target)
>
> Then run a rebuild with:
>
> $  rm -f $( find build/ -name lib.a -or -name helloworld_efi.so ) && \
>    make
> ...
>   arm-poky-linux-gnueabi-ld.bfd -nostdlib -zexecstack -znocombreloc -znor=
elro --no-warn-rwx-segments -L /home/mcfrisk/src/base/repo/poky/build_bea
> glebone/tmp/work/beaglebone_yocto-poky-linux-gnueabi/u-boot/2025.07/sourc=
es/u-boot-2025.07 -T arch/arm/lib/elf_arm_efi.lds -shared -Bsymbolic -s lib=
/efi_loader/helloworld.o lib/efi_loader/efi_crt0.o lib/efi_loader/efi_reloc=
.o lib/efi_loader/efi_freestanding.o arch/arm/lib/lib.a -o lib/efi_loader/h=
elloworld_efi.so
> arm-poky-linux-gnueabi-ld.bfd: cannot find arch/arm/lib/lib.a: No such fi=
le or directory
> make[3]: *** [scripts/Makefile.lib:512: lib/efi_loader/helloworld_efi.so]=
 Error 1
>
> Fix by introducing PLATFORM_LIBGCC_LIBA variable with only lib.a
> filename which is then used to add the dependency in rules which use
> PLATFORM_LIBGCC. This should not impact builds which don't set
> PLATFORM_LIBGCC_LIBA and PLATFORM_LIBGCC usage stays as is.
>
> Fixes: 43d43241d1c9 ("scripts/Makefile.lib: add PLATFORM_LIBGCC to efi li=
nking")
>
> Cc: Adriano Cordova <adrianox@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> ---
>  Makefile                     | 4 +++-
>  examples/standalone/Makefile | 2 +-
>  scripts/Makefile.lib         | 2 +-
>  scripts/Makefile.xpl         | 3 ++-
>  4 files changed, 7 insertions(+), 4 deletions(-)
>
> v3: added "export PLATFORM_LIBGCC_LIBA" like PLATFORM_LIBGCC, not sure
>     how testing worked without this before

Thanks for your hard work on this series. I appreciated it.

This series fixed the build failures observed on the OE-core autobuilders.

For the series:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
