Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2162C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 22:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7E1C87B77;
	Fri,  8 Mar 2024 23:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gEm0paSS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6A9387CE8; Fri,  8 Mar 2024 23:37:51 +0100 (CET)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAB8B87A00
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 23:37:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7db797c5c93so766198241.0
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 14:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709937467; x=1710542267; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/EKS0yWclUcagWjn/LoXGlU5EXE0ufPSCwvgqshunP0=;
 b=gEm0paSSsZyO9f0DCQ7NGGQtUB0Wh50m95zvQjsnUsHjSDfDj35BCI8pUM5+Wl3g91
 oljUGV5gwYEGfFAP/lQNkFCGYGjLqSfwyvJk45OS6DjcC+dowag22gkhH3TRCoDuVbfO
 7SA0SCxhpjZudyr35av7pyu3riJOMpN0pbka3z7cuyywTfoJNfQ6/TUn8dbKp6afU5Du
 nc7ZipTaZKKw99h2I1dnogi6tXmEa/nrQphtPp8SPhAF1mlmPG9iWYD4J2TSjAE4hC5/
 Ib5QwKYcGC47EwtSZzQJGNQ0UPQjwBkzXhzg+jwVP1c1W+qqFmIyLUbQkyd0LC0yQU70
 Qzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709937467; x=1710542267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/EKS0yWclUcagWjn/LoXGlU5EXE0ufPSCwvgqshunP0=;
 b=k0FJVn9To07k5qDiy27WwxMZBhIYYmEvqF5lfKJiW9XVtHhtYbVrsqupMl/iTjk2cj
 GVYaC8WPCaKiNuBxFW5od//GTGUQpN8vHsj6kipZLUZI9JrgnjxigeZv6vxdJE3/WLlK
 SF8Cx5NWN6jYOGIkpi1MMr8unPZVpoad8j5hqKsem1YSdPJ0kda/GTgULU0Vrs8LPPIo
 Yoi98PWHwDFWceGDH6pYM0V64XCqoRvN0q9St7wNYP/JBi7krX2I1kprOzBcKPAxSP/X
 V2r7LAi1Jgam/6LsSJU0Z+hXWVAB64I6JbaDYEBemw52ncbOvtdwh/EsrBUaWOkeY6ap
 Uf5g==
X-Gm-Message-State: AOJu0Ywk658CJ0Vps4pc1yEQEELYeDeEV1dTyUvYjUgVu9FSMybYoYjz
 tRs9PDBAs+bWNYHU2Ovq5tz66FTG7eTm4HQml0oShL/COJaPtyC72nwllJvuq5dKN+f7Bn7VOS8
 Yn/eXc85CibyliAcIH98IViyDAEw=
X-Google-Smtp-Source: AGHT+IFSJAdKZ17aaTMr6exWwrTdNZQB8PBq5/sXXZoM3XAD6ObLcaQAY8uD6kgHk6XFicj97xmPZ/Xwyv0ZiuXQj8M=
X-Received: by 2002:a67:f88e:0:b0:472:5c3e:caf4 with SMTP id
 h14-20020a67f88e000000b004725c3ecaf4mr395769vso.27.1709937467692; Fri, 08 Mar
 2024 14:37:47 -0800 (PST)
MIME-Version: 1.0
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
 <20240303130122.29983-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240303130122.29983-3-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Fri, 8 Mar 2024 14:37:36 -0800
Message-ID: <CANV2PTNbhB1D32pK9nVKi0MNA=G-ooP=qcJBcsaEGMNzaxo97g@mail.gmail.com>
Subject: Re: [RFC 2/5] riscv: set fdtfile on Milk-V Mars
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

Sharing the info from Mars CM Lite 4GB:
--------EEPROM INFO--------
Vendor : MILK-V
Product full SN: MARC-V10-2340-D004E016-000006DF
data version: 0x2
PCB revision: 0xc1
BOM revision: A
Ethernet MAC0 address: 6c:cf:39:00:83:11
Ethernet MAC1 address: 6c:cf:39:00:83:12
--------EEPROM INFO--------

I do not like this practice of force setting fdtfile environment variable.
If I set fdtfile from u-boot prompt and saveenv, I expect that my action as
the user will persist over a reboot but instead it gets ignored and
overwritten by this strategy. Is this necessary to happen before the boot
scripts?

On Sun, Mar 3, 2024 at 5:02=E2=80=AFAM Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> Set environment variable fdtfile to the correct value for the Milk-V Mars
> board.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  .../visionfive2/starfive_visionfive2.c        | 43 +++++++++++++------
>  1 file changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c
> b/board/starfive/visionfive2/starfive_visionfive2.c
> index 78e118d5a05..9970e309690 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -9,6 +9,7 @@
>  #include <dm.h>
>  #include <fdt_support.h>
>  #include <env.h>
> +#include <log.h>
>  #include <asm/arch/eeprom.h>
>  #include <asm/io.h>
>  #include <asm/sections.h>
> @@ -17,6 +18,8 @@
>  DECLARE_GLOBAL_DATA_PTR;
>  #define JH7110_L2_PREFETCHER_BASE_ADDR         0x2030000
>  #define JH7110_L2_PREFETCHER_HART_OFFSET       0x2000
> +#define FDTFILE_MILK_V_MARS \
> +       "starfive/jh7110-milkv-mars.dtb"
>  #define FDTFILE_VISIONFIVE2_1_2A \
>         "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
>  #define FDTFILE_VISIONFIVE2_1_3B \
> @@ -48,20 +51,34 @@ static void set_fdtfile(void)
>  {
>         u8 version;
>         const char *fdtfile;
> +       const char *product_id;
>
> -       version =3D get_pcb_revision_from_eeprom();
> -       switch (version) {
> -       case 'a':
> -       case 'A':
> -               fdtfile =3D FDTFILE_VISIONFIVE2_1_2A;
> -               break;
> -
> -       case 'b':
> -       case 'B':
> -       default:
> -               fdtfile =3D FDTFILE_VISIONFIVE2_1_3B;
> -               break;
> -       };
> +       product_id =3D get_product_id_from_eeprom();
> +       if (!product_id) {
> +               log_err("Can't read EEPROM\n");
> +               return;
> +       }
> +       if (!strncmp(product_id, "MARS", 4)) {
> +               fdtfile =3D FDTFILE_MILK_V_MARS;
> +       } else if (!strncmp(product_id, "VF7110", 6)) {
> +               version =3D get_pcb_revision_from_eeprom();
> +
> +               switch (version) {
> +               case 'a':
> +               case 'A':
> +                       fdtfile =3D FDTFILE_VISIONFIVE2_1_2A;
> +                       break;
> +
> +               case 'b':
> +               case 'B':
> +               default:
> +                       fdtfile =3D FDTFILE_VISIONFIVE2_1_3B;
> +                       break;
> +               }
> +       } else {
> +               log_err("Unknown product\n");
> +               return;
> +       }
>
>         env_set("fdtfile", fdtfile);
>  }
> --
> 2.43.0
>
>
