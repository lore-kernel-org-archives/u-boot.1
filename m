Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08760C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 12:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74A0086E82;
	Mon, 25 Dec 2023 13:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ITZALGoY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 265AF86E82; Mon, 25 Dec 2023 13:29:04 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD48380844
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 13:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5d33574f64eso33393377b3.3
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 04:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703507340; x=1704112140; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=823MV+S3bWXhyElKC42jMnbSlSMb1+2waYDKRguXf44=;
 b=ITZALGoYt2Jm8tvMoVVlGDbFO/YQTNYRru8zaK3L/gfxb73OMs5G7Z1WLG2T2D2K7a
 x9GkIvKqkmk5UGaBVr1iAAYmcu62jC6+xq24a7cB4KRmLoNv7HcGwDOrhrrz790uGa87
 KMExXDxxmqarQFOhraGy230+qIEGw2JIBDwlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703507340; x=1704112140;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=823MV+S3bWXhyElKC42jMnbSlSMb1+2waYDKRguXf44=;
 b=PYq7B7Ddc67wdzmqUzxJOfGGosrcxR+b9b/wuPLhrrUJKZOnSY9W5LcfovKQcMPUqc
 FxkY4/QQ6Yd9wabOXUqZLgvobwJ0HuInWnLrgoGeN8EpSM8rkpQNvcolHeo6k9jtkS+l
 qdbzosv4UI6W7A7y69xCByjkEd4QKbno4ckeDS3PA0Q/j//SGuIcF4GJtncwfw4mn2aZ
 r60yEhyv97bi2vuUrc6Nr4PCpXGuXzCmNSV/y3E8wdHkdO1W826X/eJ+j1lFh2zVXOBi
 J3U1VG6V6lUQXggKwKtD/q0MyDlFZhWKm156iPW9E8XqJWL6UBxYl+z0OoeidxI2q09Y
 r0BQ==
X-Gm-Message-State: AOJu0Ywnrw2mYsm1XW8K34rpklUmFt+w0MiVNnL8yMoqLQKdoNzrs21S
 GI1qeJf8sg4mn9VeOa60zKmVXZRwQd89yA==
X-Google-Smtp-Source: AGHT+IHGumQ/1iDDTOnnOfSCTejqSZrsXQJtbKqneGMV+uzLFT16OjGifZGSMu1pgBK+RM89YbQ2TA==
X-Received: by 2002:a81:914d:0:b0:5d6:85f1:1539 with SMTP id
 i74-20020a81914d000000b005d685f11539mr3210325ywg.18.1703507340582; 
 Mon, 25 Dec 2023 04:29:00 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 t199-20020a0dead0000000b005e6e0361d87sm4623175ywe.16.2023.12.25.04.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 04:28:59 -0800 (PST)
Date: Mon, 25 Dec 2023 07:28:56 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de,
 sjg@chromium.org, ilias.apalodimas@linaro.org,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH v3 3/4] net: tftp: remove explicit efi configuration
 dependency
Message-ID: <20231225122856.GG2652760@bill-the-cat>
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-4-takahiro.akashi@linaro.org>
 <b236a38c-3b66-4b7d-8c00-bfd06b3d0e77@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r6UyMDVru5C0/Yad"
Content-Disposition: inline
In-Reply-To: <b236a38c-3b66-4b7d-8c00-bfd06b3d0e77@gmx.de>
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


--r6UyMDVru5C0/Yad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 10:23:35AM +0100, Heinrich Schuchardt wrote:
> On 12/18/23 03:38, AKASHI Takahiro wrote:
> > Now it is clear that the feature actually depends on efi interfaces,
> > not "bootefi" command. efi_set_bootdev() will automatically be nullified
> > if necessary efi component is disabled.
> >=20
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >   net/tftp.c | 10 ++++------
> >   1 file changed, 4 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/net/tftp.c b/net/tftp.c
> > index 88e71e67de35..2e335413492b 100644
> > --- a/net/tftp.c
> > +++ b/net/tftp.c
> > @@ -302,12 +302,10 @@ static void tftp_complete(void)
> >   			time_start * 1000, "/s");
> >   	}
> >   	puts("\ndone\n");
> > -	if (IS_ENABLED(CONFIG_CMD_BOOTEFI)) {
> > -		if (!tftp_put_active)
> > -			efi_set_bootdev("Net", "", tftp_filename,
> > -					map_sysmem(tftp_load_addr, 0),
> > -					net_boot_file_size);
> > -	}
> > +	if (!tftp_put_active)
> > +		efi_set_bootdev("Net", "", tftp_filename,
>=20
> Function efi_set_bootdev() will not be compiled for CONFIG_EFI_LOADER=3Dn.
> So this change may lead to build failures.

In the EFI_LOADER=3Dn case <efi_loader.h> has an empty inline instead so
this should be fine.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--r6UyMDVru5C0/Yad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWJdYIACgkQFHw5/5Y0
tyyJcQv8C83qaXebj+KcoE4wG95wPA2Q1ODayJHJErzM9oeQafDHiwMyYgrHwlFB
3MqbzexKbg9TY9ML7Fz6W1yJ4uFo5R27DFibJhN/3ZP5cjqVjBdteKot5gjxo5OG
DWC2elbbsdH0sB9Jqw2KB4Uz6C4UCxBPU3/GHaNR5SbihUb819WVEs51mSbYY4KW
RuLWN6701iZZNAYiRavRo/7l3iAIEDJRyIUCaNpcH0+PkdFp3Ulc55Jk/s0RIfqA
5sPQb68LxInAzB4Iw2FKXjWAi4Kqp4Z1Gg96jh4w66DXNsCpFi+xLzO1RWqpYohm
rc1VdZi76ro5Y3nWDe3YmCgnRzNcnx6ms2VPiNhuuCLcfjmnOTIWmLgcrWmwWYk2
SbVeF2jKCULEi0YlWhWRqiqujU6RFQPmo5jc7lZJN2AsPF5BuF5ojYpUnwlpqi0u
Vw1AXrXA65Dsjzoj26nhnZGXCrzYXfwl3REeuBeCCtMGMg6KYjO86QdCRPZhfl4+
oHb1npLr
=tVyy
-----END PGP SIGNATURE-----

--r6UyMDVru5C0/Yad--
