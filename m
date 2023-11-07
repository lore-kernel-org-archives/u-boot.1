Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7D5C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 13:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4E6C86F44;
	Tue,  7 Nov 2023 14:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bgcmAr0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EC7F86F44; Tue,  7 Nov 2023 14:05:47 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E307486FBF
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 14:05:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahiroy@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E1F17CE0ECE
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C183C433C7
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699362339;
 bh=RruP1QGaZvTuXJrll5bj84ebMUg3UJxqsTsrVsJCqms=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=bgcmAr0ekyPjtlHlJRSPoSGWONG64/XmcaIrdKW4mI3D+o6ctW5e4A+4ERsddqsg8
 Acv+3kdbcNT3MoTiufI565Pu0r+e4QwHMlOmga69I0TEwjvBp/1/uRKu+byguAtB2j
 rNFwGxzIoEOChohuCTot/fFBVh+aEa1+mDYPhQZaKiCsCFT0ArI/r+KCFt81aznIkP
 MNy0APlt90qjAtX+9sGlQdqVYmJ6F2BRooRI9kP+9ROi9JzV9Z4vYXYSbRukg5LWY7
 KDmTsFn+ZxmsuU3qTVJdED7vNIqJ7q4cKx4KCXhniaEDd3j+kqIVFCr2v7xgo6IVEM
 jPHPBSMXOLEpQ==
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-1ef370c2e1aso3346579fac.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 05:05:39 -0800 (PST)
X-Gm-Message-State: AOJu0YxXh7NlRr+NMyusDm6jZFQC3PZWGZQEWpmgDZsClmE+YLUlm6hi
 0uq7U3xoTlWmKxrPrAs7b3nXzGCuvqHUb4vjiQQ=
X-Google-Smtp-Source: AGHT+IEMhw9WYqCbJTZndEZaZJUtNVpum44vv8O60uyxnlRHxP3PHUzubA1MYIHj/VkTdRa2z2aQxv757U3hRX3iZOI=
X-Received: by 2002:a05:6871:42c4:b0:1ea:4338:20b7 with SMTP id
 lt4-20020a05687142c400b001ea433820b7mr3600723oab.20.1699362338526; Tue, 07
 Nov 2023 05:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20231104194207.3370542-1-sjg@chromium.org>
 <20231104194207.3370542-4-sjg@chromium.org>
In-Reply-To: <20231104194207.3370542-4-sjg@chromium.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 7 Nov 2023 15:05:01 +0200
X-Gmail-Original-Message-ID: <CAK7LNAQCu9tWcjEtak3sBVo5mQYu1abu-v-GQ0b5h7PhzuHKww@mail.gmail.com>
Message-ID: <CAK7LNAQCu9tWcjEtak3sBVo5mQYu1abu-v-GQ0b5h7PhzuHKww@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: boot: Support Flat Image Tree
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Nick Terrell <terrelln@fb.com>, 
 Nicolas Schier <nicolas@fjasle.eu>, Will Deacon <will@kernel.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Nov 4, 2023 at 9:42=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>  PHONY +=3D $(BOOT_TARGETS)
>
> @@ -215,6 +215,7 @@ virtconfig:
>  define archhelp
>    echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Im=
age.gz)'
>    echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/=
Image)'
> +$(if $(CONFIG_EFI_ZBOOT),,echo  '  image.fit     - Flat Image Tree (arch=
/$(ARCH)/boot/image.fit)')



Why should this be hidden when CONFIG_EFI_ZBOOT=3Dy?




>    echo  '  install       - Install uncompressed kernel'
>    echo  '  zinstall      - Install compressed kernel'
>    echo  '                  Install using (your) ~/bin/installkernel or'
> diff --git a/arch/arm64/boot/.gitignore b/arch/arm64/boot/.gitignore
> index af5dc61f8b43..f84a7073dbcd 100644
> --- a/arch/arm64/boot/.gitignore
> +++ b/arch/arm64/boot/.gitignore
> @@ -2,3 +2,5 @@
>  Image
>  Image.gz
>  vmlinuz*
> +image.itk
> +image.fit
> diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
> index 1761f5972443..2681f54cd2c8 100644
> --- a/arch/arm64/boot/Makefile
> +++ b/arch/arm64/boot/Makefile
> @@ -16,7 +16,8 @@
>
>  OBJCOPYFLAGS_Image :=3D-O binary -R .note -R .note.gnu.build-id -R .comm=
ent -S
>
> -targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo Ima=
ge.zst
> +targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo \
> +       Image.zst image.fit
>
>  $(obj)/Image: vmlinux FORCE
>         $(call if_changed,objcopy)
> @@ -39,6 +40,10 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
>  $(obj)/Image.zst: $(obj)/Image FORCE
>         $(call if_changed,zstd)
>
> +# Provide the kernel for the FIT
> +$(obj)/image.itk: $(obj)/Image FORCE
> +       $(call if_changed,copy)
> +
>  EFI_ZBOOT_PAYLOAD      :=3D Image
>  EFI_ZBOOT_BFD_TARGET   :=3D elf64-littleaarch64
>  EFI_ZBOOT_MACH_TYPE    :=3D ARM64
> @@ -48,3 +53,5 @@ EFI_ZBOOT_OBJCOPY_FLAGS       =3D --add-symbol zboot_co=
de_size=3D0x$(shell \
>                                 $(NM) vmlinux|grep _kernel_codesize|cut -=
d' ' -f1)
>
>  include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
> +
> +clean-files :=3D image.itk
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 03e79e319293..1427dba4f0f9 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -494,7 +494,23 @@ quiet_cmd_uimage =3D UIMAGE  $@
>                         -C $(UIMAGE_COMPRESSION) $(UIMAGE_OPTS-y) \
>                         -T $(UIMAGE_TYPE) \
>                         -a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
> -                       -n $(UIMAGE_NAME) -d $< $@
> +                       -n "$(UIMAGE_NAME)" -d $< $@


Please do not do this.
Just drop 2/3.




> +
> +# Flat Image Tree (FIT)
> +# This allows for packaging of a kernel and all devicetrees files, using
> +# compression.
> +# ----------------------------------------------------------------------=
-----
> +
> +MAKE_FIT :=3D $(srctree)/scripts/make_fit.py
> +
> +quiet_cmd_fit =3D FIT     $@
> +      cmd_fit =3D $(MAKE_FIT) -f $@ --arch $(UIMAGE_ARCH) --os linux \
> +                       --name "$(UIMAGE_NAME)" \
> +                       --compress $(UIMAGE_COMPRESSION) -k $< \
> +                       $(dir $<)/dts
> +
> +$(obj)/%.fit: $(obj)/%.itk $(MAKE_FIT) FORCE
> +       $(call if_changed,fit,gzip)


No. This is worse than v1.

Please do not create a silly copy.





As I said in v1, this if_changed does not catch the DTS updates.
So, there is no point in using it.

I recommend just use 'cmd'.


$(obj)/image.fit: $(obj)/Image FORCE
        $(call cmd,fit)





> +
> +    Returns:
> +        tuple:
> +            str: Model name
> +            bytes: Compatible stringlist
> +    """
> +    with fsw.add_node(f'fdt-{seq}'):
> +        # Get the compatible / model information
> +        with open(fname, 'rb') as inf:
> +            data =3D inf.read()
> +        fdt =3D libfdt.FdtRo(data)
> +        model =3D fdt.getprop(0, 'model').as_str()
> +        compat =3D fdt.getprop(0, 'compatible')
> +
> +        fsw.property_string('description', model)
> +        fsw.property_string('type', 'flat_dt')
> +        fsw.property_string('arch', 'arm64')


Why hard-code 'arm64' ?





--=20
Best Regards
Masahiro Yamada
