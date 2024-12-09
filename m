Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828E4E77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 19:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0259B89782;
	Mon,  9 Dec 2024 20:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tRSkNRMz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82C5D8976E; Mon,  9 Dec 2024 20:02:09 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ED4D89723
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 20:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6d3d51e1dso154971085a.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 11:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733770926; x=1734375726; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+NGIpqETtN0VR2zXLd3EI0I/8orFJ9T3F61jH5J/vMM=;
 b=tRSkNRMzHaXEECKRtbWC2DhuFfRVgELECBlTOc1t4qjzYkAX55O7JgaZzfR4XcITHG
 HNS/pJdtgqG20oGaZOQRtGpj4bo5C37dhsDmc9DwgmqqTqD7c5D6SxWUNzb05yVhjKw2
 ftkdIaRFSLkUtNsIBfrjkDZRqfyyKsoOycNYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733770926; x=1734375726;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NGIpqETtN0VR2zXLd3EI0I/8orFJ9T3F61jH5J/vMM=;
 b=Ui0KqRD+6ofXuM0StRhtOurE8K07m7m4s4C+o/Gd9Kk5G+2JncGzOOmAABS4OhKxye
 J6a/Nm942/88Alo4zlR7RXJjgRgbc99PMp0PYnwQC0zmoGHOD3Q1KeYePHmWIxeiNEWp
 Wx1el3EQ3cbRLvcbTtzOA7tTIEYbeK9/pspMIkqiShmCT5h9Q7zbEdMfiGQvLP0TWK81
 Fk+C0VHaxha97GLiSgiGMVdbiUslxqJUcAF/VGDtcGZbgtxEeVYu7yiH7Z04jLjHkcBT
 Uxv38NVzX+rfqlE3nHR5XSnmH3S0frTUzyaUIamt6/UA8uIX6Hiwp95bhG87s6Jyn3ec
 ih0w==
X-Gm-Message-State: AOJu0YyDBAZCbj6t+yA8hBz930Wnfxtu9peYgGSdzmq4dfxpa4WCT2Ug
 RGEcgueOtBnUYz8el0hI4Axm5YRGM7drK2RtGBtkMhNVmmjX3WuiDACFB4dwgqR1Hde3+MWLo/K
 Lz20=
X-Gm-Gg: ASbGnctum7RFZvWzC3Rlx8AVc73rkVrP9f+OGi9/C0gvY102Lecs5Kj5WnmAIL5ppmb
 XgIGzzyTACUEvP1iQO2RPOhQPUB383XOu4U9XjCxAU0xmmcNmYXoVkckv7m5nHkqJW/BxUVMsp5
 q630aNZ45u94L3r5bwf05iQtsp6vfYS5L9f/gN5/MeJhOV5Ooex7vEo2T+XCCYar0Pc1NSlDWzy
 e7syWcHK6EAlDhCPzA4GcwucYTE7vAzMuPCMxaf5PNkLgxZ+3Q=
X-Google-Smtp-Source: AGHT+IEeMpGVvb5Qc9LCoSEd6qR0XIo7QksuV/TgkzsiLpHiFPTBXQXoRdjQGOun0LMy8RJb1CW1WA==
X-Received: by 2002:ad4:5f8f:0:b0:6d8:86c8:c29a with SMTP id
 6a1803df08f44-6d91e300cb9mr28206076d6.10.1733770926069; 
 Mon, 09 Dec 2024 11:02:06 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dabfec80sm51639036d6.98.2024.12.09.11.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 11:02:05 -0800 (PST)
Date: Mon, 9 Dec 2024 13:02:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Francois Berder <fberder@outlook.fr>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v2 5/5] rpi: Use the U-Boot control FDT for fdt_addr
Message-ID: <20241209190202.GU2457179@bill-the-cat>
References: <20241209182002.671953-1-sjg@chromium.org>
 <20241209182002.671953-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RAKfavuRBPvjuw2p"
Content-Disposition: inline
In-Reply-To: <20241209182002.671953-6-sjg@chromium.org>
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


--RAKfavuRBPvjuw2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2024 at 11:20:01AM -0700, Simon Glass wrote:

> The fdt_addr variable is used in extlinux as a fallback devicetree if
> none is provided by the boot command.
>=20
> The existing mechanism uses the devicetree provided to U-Boot, but in
> its original, unrelocated position. For the rpi_4 I am using, this is
> at 2b35ef00 which is not a convenient place in memory, if the ramdisk
> is large.
>=20
> U-Boot already deals with this sort of problem by relocating the FDT
> to a safe address.
>=20
> So use the control-FDT address instead.
>=20
> Remove the existing comment, which is confusing, since the FDT is not
> actually passed unmodified to the kernel: U-Boot adds various things
> using its FDT-fixup mechanism.
>=20
> Note that board_get_usable_ram_top() reduces the RAM top for boards with
> less RAM. This behaviour is left unchanged as there is no other
> mechanism for U-Boot to handle this.
>=20
> In version 2, it incorporates some changes to fdt_addr, etc. suggested
> by Tom, as well as adding myself as a maintainer.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Drop patch to allow expanding the devicetree during relocation
>=20
>  board/raspberrypi/rpi/rpi.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>=20
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 9122f33d88d..8f6ab1b1b9b 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -3,6 +3,8 @@
>   * (C) Copyright 2012-2016 Stephen Warren
>   */
> =20
> +#define LOG_CATEGORY	LOGC_BOARD
> +
>  #include <config.h>
>  #include <dm.h>
>  #include <env.h>
> @@ -325,19 +327,10 @@ static void set_fdtfile(void)
>  	env_set("fdtfile", fdtfile);
>  }
> =20
> -/*
> - * If the firmware provided a valid FDT at boot time, let's expose it in
> - * ${fdt_addr} so it may be passed unmodified to the kernel.
> - */
> +/* Allow U-Boot to use its control FDT with extlinux if one is not provi=
ded */
>  static void set_fdt_addr(void)
>  {
> -	if (env_get("fdt_addr"))
> -		return;
> -
> -	if (fdt_magic(fw_dtb_pointer) !=3D FDT_MAGIC)
> -		return;
> -
> -	env_set_hex("fdt_addr", fw_dtb_pointer);
> +	env_set_hex("fdt_addr", (ulong)gd->fdt_blob);
>  }
> =20
>  /*
> @@ -572,7 +565,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>  {
>  	int node;
> =20
> -	update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
> +	if (blob =3D=3D gd->fdt_blob)
> +		log_debug("Same FDT: nothing to do\n");
> +	else
> +		update_fdt_from_fw(blob, (void *)gd->fdt_blob);
> =20
>  	node =3D fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
>  	if (node < 0)

Have you tested this to make sure that assorted overlays specified in
config.txt are still passed on correctly to the kernel? Or do we end up
being OK here due to board_fdt_blob_setup() meaning that we set
gd->fdt_blob to fw_dtb_pointer much earlier on, and that hook simply
didn't exist back in 2016 when commit
ade243a211d6 ("rpi: passthrough of the firmware provided FDT blob")
introduced some of what you're removing here?

--=20
Tom

--RAKfavuRBPvjuw2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdXPqoACgkQFHw5/5Y0
tyxwhgv+LGltjlF/kKFiCoxJwU+e2SEBKTmOEmngithmr2heNZZrTzH4ZM1sI65w
Ikk3kbhUj6Qgbvp4MIo5z0LPrjXZpzlw6Uu7VBeTyVCQ2IFy0nFvHld4dzFJmM7x
dx7fs3wFfGIqynrBj7z1aTOR0DuYtIkXGfcrrdeDdkD3BOidaYsJSjtOJa7NgnsX
Cam1JBCFCAkFnzHmzoeOfhX2y1+N5w80nfyMHChaZLkfofkl4HcAfSU6CZJBpZKi
NoMY98/5WNlRcmFIOHMWcYuuB1FU4Lf9ByfUeuII4/u6dSGE2GSwyM0yLCNkVepg
0VOkwR8YoDy1m/tKFkjn5A7+hLwli53GGQTiPfCYKgr7Pmqv1nhPr7dc2WUl6yhY
XLYEbEDjPBWQ2XwhTmarc1shL4EJShX05Ts91Fy5FDGcfeFlEoUNymUAedD6gnDw
uZ0t4LztkbpMJe7TRkiRoL8qEGjmRbIUB/KvPayKRH/kZCbXmwGf7hhHuhvvsuFB
3tHw0WHJ
=xMHv
-----END PGP SIGNATURE-----

--RAKfavuRBPvjuw2p--
