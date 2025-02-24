Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BA6C021BB
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 14:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F31C680079;
	Mon, 24 Feb 2025 15:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dSEi4T+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0210D800B3; Mon, 24 Feb 2025 15:57:05 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B504E80017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22114b800f7so88279635ad.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740409021; x=1741013821; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vhy6NBJw3c4rD6DWweUVOz1C3gNUKRcwl0TX8poLRD4=;
 b=dSEi4T+qManxaXARrHKg/Dq5I55kSMmH3ERRqMHhc2q3/C0OQqrFID0HU0wfMOvfxL
 xX3hikWtqy8UKs/UAT15ExsKw8ZaVWPD5qYU9fIjofZvMaQFcch2SB/9+PiPv4Eq+Jg9
 QiZPrzCPbkjZDIQkfkSyk7RmgvX0WbHmMh4Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740409021; x=1741013821;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vhy6NBJw3c4rD6DWweUVOz1C3gNUKRcwl0TX8poLRD4=;
 b=psg2pNGtGaIJAHttnwz/Ph6IgZVOGgIRReOtd5dMZHYrPBcN8j2HJKovfUZOtH9+Ns
 gCWKSTZILLWU8yrcPXm+m/0SlAseo5dGXt40+HiKrBfdT1krIbPsTTHY5RhpUoyKqlXc
 UFMVeW/ztH4wHGM9E8Tzy/ZcwCyR3RlDCNXZL4GSKETF9w2HmF7PZkHnsTtDBCWXGebl
 yvmVz7A84IBHjASVS2SMleQAm/LoCoACapPBhEFIQ7/N6KXum1F/gQ8T6EiLncZhMWTS
 6XzDE2T70bbVSjejcafkUrKYbEAEq9du3QcGbO2A5hNMrN0BCgLXJuKzFFAxcU/CokUI
 Y4ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHLT2ZGBKFb+4cOk588DwqO7WYZiBbjx45TkONO9QXxl8EbktatIfMXLtmEUJVVwGPLmoat8w=@lists.denx.de
X-Gm-Message-State: AOJu0YwOp8grzG/UXZix22HzdRUkmvdowfrr3WY4P8kvDWpJsYNFHmNG
 SFuPX67b8sVl1k9R4r/5pfxiaRMp0QseBiWxgXAPpb1ys3YScb8eDtYrxmU85DQ=
X-Gm-Gg: ASbGncuWKvZAd94ZY8DxxS4ZJFPjyrRtPkX8JnQMd/tE4aX3yCM+95cIRJHja3txEPl
 OZ9562jZq8doi1CfYSfIX3yleDCZTENQtBGC8a8xVDV4SGtIbcCMs3MVN29KybwdWbXjLkTl46A
 kp8zzCytrNu7qthSJbCQdfEvch6lNJPEurZ2akmIRuA2Qnma3FRknn/RlSW4eeoKKTr00xvgpLX
 YEY6rkMnAqdyOP/V7VMJFkFCvfFqe622/FUQRtSTJ6ukGAuKUaUPL4T0acaxGcHFnlTfLVsxO8W
 TWrgTWKh4Uzy+QVC3S8TMrvN
X-Google-Smtp-Source: AGHT+IHAJJdru115fYUXo33qwbvufshTNT/hg0SACq6v30MzWITx+RC8qv7G1/3f8ItpoVMQ/XynHg==
X-Received: by 2002:a17:902:cf10:b0:21a:8300:b9d5 with SMTP id
 d9443c01a7336-2219ff5f65emr239388105ad.23.1740409021147; 
 Mon, 24 Feb 2025 06:57:01 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d53fsm181484425ad.110.2025.02.24.06.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 06:57:00 -0800 (PST)
Date: Mon, 24 Feb 2025 08:56:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sam Edwards <cfsworks@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 10/17] spl: Align FDT load address
Message-ID: <20250224145657.GD1233568@bill-the-cat>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-11-CFSworks@gmail.com>
 <2cd9e4dd-cb85-4661-92d2-fae4bc54ad05@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qsv4avsK9TWQGGPj"
Content-Disposition: inline
In-Reply-To: <2cd9e4dd-cb85-4661-92d2-fae4bc54ad05@gmx.de>
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


--Qsv4avsK9TWQGGPj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 09:59:42AM +0100, Heinrich Schuchardt wrote:
> On 2/24/25 06:55, Sam Edwards wrote:
> > While the image size is generally a multiple of 8 bytes, this is not
> > actually guaranteed; some linkers (like LLD) may shave a few bytes off
> > of the end of output sections if there are no content bytes there. Since
> > libfdt imposes a hard rule of 8-byte alignment, make the SPL also be
> > explicit about the alignment when loading the FDT.
> >=20
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >   common/spl/spl_fit.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> > index 49b4df60560..86506d6905c 100644
> > --- a/common/spl/spl_fit.c
> > +++ b/common/spl/spl_fit.c
> > @@ -397,7 +397,7 @@ static int spl_fit_append_fdt(struct spl_image_info=
 *spl_image,
> >   	 * Use the address following the image as target address for the
> >   	 * device tree.
> >   	 */
> > -	image_info.load_addr =3D spl_image->load_addr + spl_image->size;
> > +	image_info.load_addr =3D ALIGN(spl_image->load_addr + spl_image->size=
, 8);
>=20
> We want to keep the SPL code size as small as possible as on many
> platforms it is restricted to the cache size.
>=20
> Can't we fix this linker issue in the linker script by properly aligning
> the SPL image end address?

Size growth is always something to watch for, but not at the expense of
correctness and saving a few bytes. We really do need to fix the places
where U-Boot could but doesn't ensure the device tree is correctly
aligned in memory.

--=20
Tom

--Qsv4avsK9TWQGGPj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme8iLkACgkQFHw5/5Y0
tyweDgwAguBW8eYuyOibxX6uHVujDeTMo6PwAr1yxk+9zcsiejTSNBhtSyc4z67t
ejsMME1c/1/DKTG8xKJQHP+I4kIERIVGYCO5LdMzNTt1Zq1sF6le3qqJLePNbTwO
bk68tK46jPd3o0PBHlnYZGZANLwAuHWCgligLm6U2LIA7tw9zwYRVhpgRNCFBgwU
JnadqYrbiug6rG4IQ1F0vk+NYWINEgmlv50WA0c3sw0Lyc7Jv46pUNQRgxzmgoDW
XajjOaOWgmqNLdxC5uRIAFmblKmhrm5yyfEemqEKql837kvoybvaqkavl1IYXatw
aauZY43YTUtGjNwyJDGlEXUdUq818zqycv6fz6I6v2RG9+nFx3UXTUhZ4xxJx28W
mbR+SEwcQZc/y1HXZxY8xDhO7tdT4+gt+tEEFj5wqwbd9BvORigviH3beh/Pzy9c
BYGbyII6CYEV46jKg9ItPho9m7TZPbOeinWkDLFgaZvWN0N0mE563lqYqgB/dDKU
djl8ael4
=9waT
-----END PGP SIGNATURE-----

--Qsv4avsK9TWQGGPj--
