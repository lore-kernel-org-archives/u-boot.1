Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931E2C2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 14:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF1C287D10;
	Fri, 21 Jun 2024 16:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ykm2XM2d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C218851C; Fri, 21 Jun 2024 16:16:28 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA06587D10
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 16:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-dff0712ede2so2060832276.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718979385; x=1719584185; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K5Y5dkPresCSjeGTApLlRTLWd01ozXYd0/684k+w49Y=;
 b=Ykm2XM2deVav5g20nr+ovWcttFJnH8YGtPNT4/dFTUlrCNttfjSwCiQ7PK2gPjLqxi
 oz9Dr8mLUpdkiK5MXxdPdRH6wA6ucZskOQngAGVtOW+w6PFOf6ifbUvdx3tVFovKYjDJ
 6EdF4Bwk+nR+N17K0r7yerP9roOeTCoOPKhE149g8cnxGLbxwdAYDzdMqz/ZJtFTu9LZ
 IOiaJO0RNyqWxd8u3x3Pl36KYlp1Iwyp2igYSocQC95BKEs4RVHOhi9XRX9ZnFf3fOMx
 Y+cdogRN//MVUTqn+cx48pRXGe9otkdB69aQdVZvaONHwUOlvYIu2OB6IIirh9V3e+kW
 mDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718979385; x=1719584185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K5Y5dkPresCSjeGTApLlRTLWd01ozXYd0/684k+w49Y=;
 b=f/lBRrtNoIBuXDgpk4P2LrF0+boN3LntPQPXM5ejedIVB34Jcas1MheuDNzCqgfO5y
 DOiBgg4XS9TfvIRdBTQVtW52k0fUwnznIr9csLYe+70fdjheUBs2oyBvB5o8T3l8PONJ
 jAe+sTuJR6cIdqxe4Hgu8utQboWk8DDHzk1GQ2/xTFKy8PE6bvabX1L0yiDfRNq2SR/y
 T4A3/JrUHAdah1nLj1yYjFx1DezfaniVtvadKgN1l9U8KV1f+HBTkDRs/tQxkUwgkVYi
 u1yVfnDnxcJZTQtLr4ACYypgEif9U1yExeL1gb2dzS7I43v2GFWjyzpAmsZm/z9RDGwV
 uheg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHHkw+xLktfTmZexVaS/pUizcS3v/HZZNdS3gFISudv4VepCfJMxmTqtr5GmVRfs3Ye6Tu/uo6sKH90MZggnSV2zTK3A==
X-Gm-Message-State: AOJu0Yzy5DxpB7CeTyu67FbNOnRluH7dI+cc1/uFVj8VJVkWoiWW8727
 SBoqQ6hV+P16MswAyKCFNA28+u77tfZNfo/GuhOq7zRoNCn34JREuQoZSBAOghzMcDMRGdQuu6l
 7KiWbDcVD82czYpMqeqb/p+/rCkxgOieQnPk=
X-Google-Smtp-Source: AGHT+IEILIOgyzOv/hnfkIBLfa0WSpMdw0z/eLntt6blay0SEv7H5+u/nmKi2RDm10cUQyDDlaiqvEtZ1lqcb1Vd8UU=
X-Received: by 2002:a25:688e:0:b0:e02:c3de:5d95 with SMTP id
 3f1490d57ef6-e02c3de5e0amr7302155276.43.1718979384664; Fri, 21 Jun 2024
 07:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240621114210.51101-1-Maxim.Moskalets@kaspersky.com>
 <f516756f-93f7-4064-9dbe-abbced5fbd93@gmx.de>
In-Reply-To: <f516756f-93f7-4064-9dbe-abbced5fbd93@gmx.de>
From: =?UTF-8?B?0JzQsNC60YHQuNC8INCc0L7RgdC60LDQu9C10YY=?=
 <maximmosk4@gmail.com>
Date: Fri, 21 Jun 2024 17:16:13 +0300
Message-ID: <CALUeBeD7y=2DJWms46FmRq-T8hZGLAwxbO-GQOGpbVj8DJ0BpQ@mail.gmail.com>
Subject: Re: [PATCH v5] cmd: bootm: add ELF file support
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 quentin.schulz@theobroma-systems.com, 
 sjg@chromium.org, trini@konsulko.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

=D0=BF=D1=82, 21 =D0=B8=D1=8E=D0=BD. 2024=E2=80=AF=D0=B3. =D0=B2 15:51, Hei=
nrich Schuchardt <xypron.glpk@gmx.de>:

> On 21.06.24 13:42, Maxim Moskalets wrote:
> > Some operating systems (e.g. seL4) and embedded applications are ELF
> > images. It is convenient to use FIT-images to implement trusted boot.
> > Added "elf" image type for booting using bootm command.
> >
> > Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
>
> I guess a test could be added to test/py/tests/test_zynqmp_rpu.py which
> already uses the bootelf command?
>
> Is it necessary to use specific hardware to run this test?

Best regards

Maxim

> Best regards
>
> Heinrich
>
> > ---
> > v5:
> >       used func from lib/elf.c to avoid dependency form CLI
> > ---
> >   boot/bootm_os.c  | 18 ++++++++++++++++++
> >   boot/image-fit.c |  3 ++-
> >   boot/image.c     |  5 ++++-
> >   cmd/Kconfig      |  7 +++++++
> >   include/image.h  |  1 +
> >   5 files changed, 32 insertions(+), 2 deletions(-)
> >
> > diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> > index 15297ddb53..6a6621706f 100644
> > --- a/boot/bootm_os.c
> > +++ b/boot/bootm_os.c
> > @@ -8,6 +8,7 @@
> >   #include <bootstage.h>
> >   #include <cpu_func.h>
> >   #include <efi_loader.h>
> > +#include <elf.h>
> >   #include <env.h>
> >   #include <fdt_support.h>
> >   #include <image.h>
> > @@ -394,6 +395,20 @@ static int do_bootm_qnxelf(int flag, struct
> bootm_info *bmi)
> >   }
> >   #endif
> >
> > +#if defined(CONFIG_BOOTM_ELF)
> > +static int do_bootm_elf(int flag, struct bootm_info *bmi)
> > +{
> > +     Bootelf_flags flags =3D { .autostart =3D 1 };
> > +
> > +     if (flag !=3D BOOTM_STATE_OS_GO)
> > +             return 0;
> > +
> > +     bootelf(bmi->images->ep, flags, 0, NULL);
> > +
> > +     return 1;
> > +}
> > +#endif
> > +
> >   #ifdef CONFIG_INTEGRITY
> >   static int do_bootm_integrity(int flag, struct bootm_info *bmi)
> >   {
> > @@ -535,6 +550,9 @@ static boot_os_fn *boot_os[] =3D {
> >   #ifdef CONFIG_BOOTM_EFI
> >       [IH_OS_EFI] =3D do_bootm_efi,
> >   #endif
> > +#if defined(CONFIG_BOOTM_ELF)
> > +     [IH_OS_ELF] =3D do_bootm_elf,
> > +#endif
> >   };
> >
> >   /* Allow for arch specific config before we boot */
> > diff --git a/boot/image-fit.c b/boot/image-fit.c
> > index f6464bcf62..9253f81fff 100644
> > --- a/boot/image-fit.c
> > +++ b/boot/image-fit.c
> > @@ -2175,7 +2175,8 @@ int fit_image_load(struct bootm_headers *images,
> ulong addr,
> >               fit_image_check_os(fit, noffset, IH_OS_TEE) ||
> >               fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
> >               fit_image_check_os(fit, noffset, IH_OS_EFI) ||
> > -             fit_image_check_os(fit, noffset, IH_OS_VXWORKS);
> > +             fit_image_check_os(fit, noffset, IH_OS_VXWORKS) ||
> > +             fit_image_check_os(fit, noffset, IH_OS_ELF);
> >
> >       /*
> >        * If either of the checks fail, we should report an error, but
> > diff --git a/boot/image.c b/boot/image.c
> > index fc774d605d..abac254e02 100644
> > --- a/boot/image.c
> > +++ b/boot/image.c
> > @@ -130,7 +130,10 @@ static const table_entry_t uimage_os[] =3D {
> >       {       IH_OS_OPENRTOS, "openrtos",     "OpenRTOS",             }=
,
> >   #endif
> >       {       IH_OS_OPENSBI,  "opensbi",      "RISC-V OpenSBI",       }=
,
> > -     {       IH_OS_EFI,      "efi",          "EFI Firmware" },
> > +     {       IH_OS_EFI,      "efi",          "EFI Firmware"          }=
,
> > +#ifdef CONFIG_BOOTM_ELF
> > +     {       IH_OS_ELF,      "elf",          "ELF Image"             }=
,
> > +#endif
> >
> >       {       -1,             "",             "",                     }=
,
> >   };
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index a2dee34689..613baa106e 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -321,6 +321,13 @@ config BOOTM_EFI
> >       help
> >         Support booting UEFI FIT images via the bootm command.
> >
> > +config BOOTM_ELF
> > +     bool "Support booting ELF images"
> > +     depends on CMD_BOOTM && LIB_ELF
> > +     default n
> > +     help
> > +       Support booting ELF images via the bootm command.
> > +
> >   config CMD_BOOTZ
> >       bool "bootz"
> >       help
> > diff --git a/include/image.h b/include/image.h
> > index c5b288f62b..9daaee15cd 100644
> > --- a/include/image.h
> > +++ b/include/image.h
> > @@ -100,6 +100,7 @@ enum {
> >       IH_OS_TEE,                      /* Trusted Execution Environment =
*/
> >       IH_OS_OPENSBI,                  /* RISC-V OpenSBI */
> >       IH_OS_EFI,                      /* EFI Firmware (e.g. GRUB2) */
> > +     IH_OS_ELF,                      /* ELF Image (e.g. seL4) */
> >
> >       IH_OS_COUNT,
> >   };
>
>
