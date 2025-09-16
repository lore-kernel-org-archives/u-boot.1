Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952DACAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 14:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 292A383253;
	Tue, 16 Sep 2025 16:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mCeUbEXp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0658F832BC; Tue, 16 Sep 2025 16:30:11 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B114B83287
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 16:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-74542b1b2bcso5660242a34.3
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 07:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758033007; x=1758637807; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9ycDR7Au59Koj81OL9QgGZ55ugOHJn5Jpf8IgFvOeVQ=;
 b=mCeUbEXphNrJ+ZDspOgVv8FRo4cSkhWlVgUAvKluO6A0Ocf7K7/3hG1egUYFsXvuGI
 nUf9A43dTTqeM16jRFxyvfm+N/bC11OHapGKKJgfBTmg+uWbNLTTSe58tn++CJ0r6jDm
 MoSJXLNAOAX9I3Hs2IhUc0XgUifT/5RnW9dO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758033007; x=1758637807;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ycDR7Au59Koj81OL9QgGZ55ugOHJn5Jpf8IgFvOeVQ=;
 b=Yx7aGa6RYIP64RdKq6YVU/Ub9lQ7IislGFpbED148fapXb6/cN6cETAePmebUrcU84
 Txt0Ix9JmWFm51xc21sn70gLDDNQhE5gSxbLkAakkG8gL45Hz8YYE26EO8pm2L04W95o
 Tvr5xTeYvfounTXKL78U6kUWOvWIicecvvZ8Xj7Oeb9/y8DBK7ByEx7EzKIGaj+7QJtB
 u3eIvV0/Lcj9TwVqwkkWVeJNob81TIMkSqF71iCpkI3OpZ2CDoFfhfV39i4I9PYYza5M
 zh/97j7iIkmLKFQrp1k2A9Xs9Iek2KnaGkFKrsAg4iNZxzOs3GKtI3LiSsDutYtQl16S
 QDoQ==
X-Gm-Message-State: AOJu0Yxx8HYMpWrVaIuouWCSNp/23vy1VvW7IwqYG2YdKkoQXoCcNjB/
 OtcYNviLXVcDEMPHXOGvUQRLCky9y75s+iwJPgk/ApPc8fOU8k2GrkFV2OCitFwrtbg+rY25Goc
 iPvyc3YQ=
X-Gm-Gg: ASbGnctt9UEs8wxIr6ZHPjqi362ufkJ5p0esjfk15nPfUxtNFTv7ToTxpljXHwYD/Ta
 YULndrmQrapgiTNOyrnFJnKSUUxKKIrXCdNXv56ytjYeF22TtSMHZMkZuoocWb52QoSdAXQn1G0
 bDAAHVaG4dtatqDpoAW03Ov8Dwkb8DvdlMAYQREmajfapmnitWlg4kORvJr7ocOc8a+9nFKlkoG
 rTynKTMK9ZJ4DG3PHUvoVSyFCSc85Iw4ynOFAMMzM3/dKG/mCdOxzg1djGZlelHeCmaL+XwwutS
 DPbokeSSyzoQSpkJSI4xDeS/ANFjxAusreNXg2FpTIqKNyHPSyRreNowq0Q2xEH/UDHg5vhUQTa
 J2BKs5ug+ExH4/+hYCGUe9fmFO7SB4gdHkibV8Qt178NqhsowQU7+yfRN493SAuNiBMOubV/4sI
 CN3g==
X-Google-Smtp-Source: AGHT+IHpi+TcRctCvflGXkiJvyJKusvJLfNCdX4FB/sA4f7WJkwBXmqY7mfjq6QLWTi38BgyUqbC8g==
X-Received: by 2002:a05:6808:2116:b0:438:4312:ab9d with SMTP id
 5614622812f47-43b8da55ec5mr8652571b6e.45.1758033006546; 
 Tue, 16 Sep 2025 07:30:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-330c51caddesm2962410fac.29.2025.09.16.07.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:30:05 -0700 (PDT)
Date: Tue, 16 Sep 2025 08:30:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: spl: Remove ATAG support from this command
Message-ID: <20250916143003.GR124814@bill-the-cat>
References: <20250915190548.446942-1-trini@konsulko.com>
 <DCU0GZQN2183.FPGUJYH3KQ7V@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7c8CFnqhngo0GeBj"
Content-Disposition: inline
In-Reply-To: <DCU0GZQN2183.FPGUJYH3KQ7V@ti.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--7c8CFnqhngo0GeBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:59:41AM +0530, Anshul Dalal wrote:
> On Tue Sep 16, 2025 at 12:35 AM IST, Tom Rini wrote:
> > While we continue to have some systems which support extremely legacy
> > OS booting methods, we do not have use cases for supporting this in
> > Falcon mode anymore. Remove this support and references from the
> > documentation.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  cmd/spl.c               | 18 ---------
> >  doc/README.commands.spl | 14 ++-----
> >  doc/develop/falcon.rst  | 84 ++++-------------------------------------
> >  include/cmd_spl.h       |  3 +-
> >  4 files changed, 11 insertions(+), 108 deletions(-)
> >
> > diff --git a/cmd/spl.c b/cmd/spl.c
> > index 379b512f1ffd..90193b43abf4 100644
> > --- a/cmd/spl.c
> > +++ b/cmd/spl.c
> > @@ -27,19 +27,6 @@ static const char **subcmd_list[] =3D {
> >  		"cmdline",
> >  		"bdt",
> >  		"prep",
> > -#endif
> > -		NULL,
> > -	},
> > -	[SPL_EXPORT_ATAGS] =3D (const char * []) {
> > -#ifdef CONFIG_SUPPORT_PASSING_ATAGS
> > -		"start",
> > -		"loados",
> > -#ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
> > -		"ramdisk",
> > -#endif
> > -		"cmdline",
> > -		"bdt",
> > -		"prep",
> >  #endif
> >  		NULL,
> >  	},
> > @@ -96,7 +83,6 @@ static int call_bootm(int argc, char *const argv[], c=
onst char *subcommand[])
> > =20
> >  static struct cmd_tbl cmd_spl_export_sub[] =3D {
> >  	U_BOOT_CMD_MKENT(fdt, 0, 1, (void *)SPL_EXPORT_FDT, "", ""),
> > -	U_BOOT_CMD_MKENT(atags, 0, 1, (void *)SPL_EXPORT_ATAGS, "", ""),
> >  };
> > =20
> >  static int spl_export(struct cmd_tbl *cmdtp, int flag, int argc,
> > @@ -128,10 +114,6 @@ static int spl_export(struct cmd_tbl *cmdtp, int f=
lag, int argc,
> >  #endif
> >  			break;
> >  #endif
> > -		case SPL_EXPORT_ATAGS:
> > -			printf("Argument image is now in RAM at: 0x%p\n",
> > -				(void *)gd->bd->bi_boot_params);
> > -			break;
> >  		}
> >  	} else {
> >  		/* Unrecognized command */
> > diff --git a/doc/README.commands.spl b/doc/README.commands.spl
> > index ecfd3ca9ee58..54cc5b1ec421 100644
> > --- a/doc/README.commands.spl
> > +++ b/doc/README.commands.spl
> > @@ -5,24 +5,16 @@ SUBCOMMAND EXPORT
> >  To execute the command everything has to be in place as if bootm shoul=
d be
> >  used. (kernel image, initrd-image, fdt-image etc.)
> > =20
> > -export has two subcommands:
> > -	atags: exports the ATAGS
> > +export has one subcommand:
> >  	fdt: exports the FDT
>=20
> Why do we even need the fdt subcommand anymore? Can't we just have the
> command be 'spl export [kernel_addr] [initrd_addr] [fdt_addr]' now?

Because commands are part of our API.

>=20
> > =20
> >  Call is:
> > -spl export <fdt|atags> [kernel_addr] [initrd_addr] [fdt_addr if fdt]
> > +spl export fdt [kernel_addr] [initrd_addr] [fdt_addr if fdt]
> > =20
>=20
> Also, we should just drop the 'if fdt' from the command help.

Yes, true, thanks.
>=20
> > =20
>=20
> [snip] =20
>=20
> > diff --git a/include/cmd_spl.h b/include/cmd_spl.h
> > index 51ec12edb906..45ea91e9bce6 100644
> > --- a/include/cmd_spl.h
> > +++ b/include/cmd_spl.h
> > @@ -8,7 +8,6 @@
> >  #define SPL_EXPORT	(0x00000001)
> > =20
> >  #define SPL_EXPORT_FDT		(0x00000001)
> > -#define SPL_EXPORT_ATAGS	(0x00000002)
> > -#define SPL_EXPORT_LAST		SPL_EXPORT_ATAGS
> > +#define SPL_EXPORT_LAST		SPL_EXPORT_FDT
> > =20
> >  #endif /* _NAND_SPL_H_ */
>=20
> The below diff should also be part of the patch:
>=20
> diff --git a/arch/arm/lib/spl.c b/arch/arm/lib/spl.c
> index c43a63f1819..6c7d1fb5629 100644
> --- a/arch/arm/lib/spl.c
> +++ b/arch/arm/lib/spl.c
> @@ -46,8 +46,7 @@ void __weak board_init_f(ulong dummy)
>  }
>=20
>  /*
> - * This function jumps to an image with argument. Normally an FDT or ATA=
GS
> - * image.
> + * This function jumps to an image with argument, usually an FDT.
>   */
>  #if CONFIG_IS_ENABLED(OS_BOOT)
>  #ifdef CONFIG_ARM64
> diff --git a/arch/powerpc/lib/spl.c b/arch/powerpc/lib/spl.c
> index 3a24cbfff3b..a2bf52c5adc 100644
> --- a/arch/powerpc/lib/spl.c
> +++ b/arch/powerpc/lib/spl.c
> @@ -9,8 +9,7 @@
>  #include <linux/compiler.h>
>=20
>  /*
> - * This function jumps to an image with argument. Normally an FDT or ATA=
GS
> - * image.
> + * This function jumps to an image with argument, usually an FDT.
>   */
>  #ifdef CONFIG_SPL_OS_BOOT
>  void __noreturn jump_to_image_linux(struct spl_image_info *spl_image)
> diff --git a/cmd/spl.c b/cmd/spl.c
> index 90193b43abf..f591dc07fb6 100644
> --- a/cmd/spl.c
> +++ b/cmd/spl.c
> @@ -158,11 +158,10 @@ static int do_spl(struct cmd_tbl *cmdtp, int flag, =
int argc, char *const argv[])
>=20
>  U_BOOT_CMD(
>  	spl, 6 , 1, do_spl, "SPL configuration",
> -	"export <img=3Datags|fdt> [kernel_addr] [initrd_addr] [fdt_addr]\n"
> -	"\timg\t\t\"atags\" or \"fdt\"\n"
> +	"export fdt [kernel_addr] [initrd_addr] [fdt_addr]\n"
>  	"\tkernel_addr\taddress where a kernel image is stored.\n"
>  	"\t\t\tkernel is loaded as part of the boot process, but it is not star=
ted.\n"
>  	"\tinitrd_addr\taddress of initial ramdisk\n"
>  	"\t\t\tcan be set to \"-\" if fdt_addr without initrd_addr is used.\n"
> -	"\tfdt_addr\tin case of fdt, the address of the device tree.\n"
> +	"\tfdt_addr\tthe address of the device tree.\n"
>  	);

Ah, thanks. I'll add a Co-developed when I respin since you've changed
almost as much as I have now.

--=20
Tom

--7c8CFnqhngo0GeBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMl0awAKCRAr4qD1Cr/k
CjAsAP980vjBZc73hsCKymf5E7gBJwBNUJacaXCyjKyoBb8XMAEAjisItpmkIvly
lpbG0Blo8Wu6XHCkcMwj5TyBp+lcag4=
=dhnV
-----END PGP SIGNATURE-----

--7c8CFnqhngo0GeBj--
