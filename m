Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9C2D26D94
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 19:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC21F843AD;
	Fri,  9 Jan 2026 20:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h3GMztG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E7A0843B6; Fri,  9 Jan 2026 20:11:06 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE2C18437C
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 20:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-657523b5db0so1483943eaf.2
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 11:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767985857; x=1768590657; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6IguXCGZYeq9PBjwFh1lAQ1y6hjuzy5DwRFwo6v4RJA=;
 b=h3GMztG3o7XSFcmp6MqhawIic8L/vV4gsJBxT7wUy0eutdU60Djo0J9fjxbJDEwV28
 k2KkPjG9pm4bFdeT2BY4uOzAt1snHtRbRCK1Xe9KsSovRKrHDIcTbWoCDCnTevbpa6Y1
 iqpgUdxEJEwHz23nzGcUjRdImdEuSaneYR1M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767985857; x=1768590657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6IguXCGZYeq9PBjwFh1lAQ1y6hjuzy5DwRFwo6v4RJA=;
 b=s1EvJMAH+AmYIlMIc2cRmr2MuLWSx05VWEjT8iq2TfYeITTkVpyybqtfjzlUjgS71k
 EIYUhh2EphjaxVD358jk3pc2og9fEJXSK+lhHI+j3cFxKa/iOUrFGBn50pkET+/KdBs1
 MfMXbxsUUtjtnsD8HQ/IVbcHDIiFvQB7X+I8oviRSWly2GX3zEsmpPdyhmPRiNqhMG0a
 u3dNlMAde7iiKHO793/AVWHDPyphmBexsHe1MUY82M1W1fVuiV+QOaoKoOa2Zsz9RjgI
 528Hl+WbE+5HaGNRKU5X3z7CzZp9RI3kqeSUdxdohlf/V+I23V7QDxv5BbmRwl55kach
 vOzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbX2T9WFlt6sLmZuijQbCF9Fl/KD7mZJUTj86m7aBJZFllhnLKWri7EwfsKzquoYgOhBY6pAU=@lists.denx.de
X-Gm-Message-State: AOJu0YzZxj90sqzGgk/5HmLgC3OyvPoNWLCtkezXqXJlR35UTPR661Gt
 Cyo5d+KTKE9ofAX6snrqh+Ysm6R3hfgvTSS6ZZI77PoU9yQrtwTF2lujD17CA2WfmJE=
X-Gm-Gg: AY/fxX7ONxQoiWtjoipidmU82NBRXe8/OKT44Mq0rIC/KUxsrgc+5RKrxt5pT1tVOjx
 I7tStF/hPcqFsbtTAZFAxLsGp6J5/xYNa31pMOfIUebzHP4O3Bdwpj2MmfNB4mIB82VDy17afLi
 6/uaRRhI6zjn56zSdNwKmRIYXippszQmbg9BAu4pTbWpnSV7Jiv1IrRUHzBdwz8FsKZt78h/86W
 CtPGL1BtLges8ZE3w/0Q3SSFLb6DGnbtxhWTU0tjRRpSNceLRCXfpwmODQtpG10GwTpGPbwQ7zm
 hZxWLLMT+zSweHIInL+aoeq8ZskktvPgUh488Y/PPRBtMFzhgvXKv16bD6oPfV8U9RoA0JQZK5K
 eC0aPv4lv8fss7/Eh676B2WkvfMf0eiZwAQRYKYXTexf3piYYJppz8tqz3R58+CcbXkv1SwJobA
 QqcA5PmKVOL/lXGQViKGz8q/7vszAw/e2DVwDzE9jWbGC5n9p6wY64pB1vPlQ98npojwZTlh47M
 bFA1agtrdXm0fGSQRSUFfIYQC9CYi5m3c5y2No=
X-Google-Smtp-Source: AGHT+IHiElsX7tTNah75fNoea6zUSSemOg4RKe9VP96fhSrPI+4HasFoPcv4rVJ9+o61Pm03PqY9OQ==
X-Received: by 2002:a05:6820:228f:b0:65e:dd95:38c4 with SMTP id
 006d021491bc7-65f54ed5b29mr5644748eaf.10.1767985857609; 
 Fri, 09 Jan 2026 11:10:57 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48bbbc44sm4366582eaf.3.2026.01.09.11.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 11:10:57 -0800 (PST)
Date: Fri, 9 Jan 2026 13:10:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com,
 anshuld@ti.com, afd@ti.com, nm@ti.com, vigneshr@ti.com,
 n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment
 before DTB
Message-ID: <20260109191054.GJ3416603@bill-the-cat>
References: <20260109190026.58464-1-b-padhi@ti.com>
 <20260109190026.58464-3-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MRXujCDItJlv+MGQ"
Content-Disposition: inline
In-Reply-To: <20260109190026.58464-3-b-padhi@ti.com>
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


--MRXujCDItJlv+MGQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 12:30:26AM +0530, Beleswar Padhi wrote:

> The OMAP2 SPL linker script (also used for K3 platforms) currently uses
> 4-byte alignment after the __u_boot_list section. Change this to 8-byte
> alignment to meet the device tree specification requirement for DTB
> alignment.
>=20
> However, this alignment directive only advances the location counter
> without padding the actual binary output. When objcopy extracts
> u-boot-spl-nodtb.bin, it includes only actual data, stopping at the last
> byte of __u_boot_list (e.g., 0x41c359fc), not the aligned address (e.g.,
> 0x41c35a00). When the FIT image containing device trees is concatenated
> to the above SPL binary, it gets appended at the unaligned file size,
> causing libfdt validation failure.
>=20
> To fix this, add an alignment directive inside the __u_boot_list section
> itself. This forces the linker to include padding as part of the section
> data, ensuring objcopy includes the padding bytes in the binary and the
> appended FIT image starts at an 8-byte aligned boundary.
>=20
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>  arch/arm/mach-omap2/u-boot-spl.lds | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach-omap2/u-b=
oot-spl.lds
> index 3bb759d8a1c..081323e6599 100644
> --- a/arch/arm/mach-omap2/u-boot-spl.lds
> +++ b/arch/arm/mach-omap2/u-boot-spl.lds
> @@ -35,9 +35,10 @@ SECTIONS
>  	. =3D ALIGN(4);
>  	__u_boot_list : {
>  		KEEP(*(SORT(__u_boot_list*)));
> +		. =3D ALIGN(8);
>  	} >.sram
> =20
> -	. =3D ALIGN(4);
> +	. =3D ALIGN(8);
>  	__image_copy_end =3D .;
>  	_end =3D .;
>  	_image_binary_end =3D .;

Do we need both of these? Shouldn't we just need the one inside the sram
section with a comment that this ensures the end of the SRAM portion is
8-byte aligned?

--=20
Tom

--MRXujCDItJlv+MGQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWFSvgAKCRAr4qD1Cr/k
Cm1xAQDRcv5nWPXEafq9TU/JlrAAFLWMaELirB2LllH5cGDsVQD/U2XyDT1b8DUn
wqcVUes6Sfqogx5BO7wk2xVDJVCFkQc=
=AgSn
-----END PGP SIGNATURE-----

--MRXujCDItJlv+MGQ--
