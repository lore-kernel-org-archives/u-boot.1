Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6D8C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 17:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 889EE8723E;
	Mon, 12 Feb 2024 18:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cffZ0MIw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E9B68751B; Mon, 12 Feb 2024 18:08:22 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72F1C8718A
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 18:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-604e7de7bddso19225247b3.3
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 09:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707757697; x=1708362497; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+hWl4UsKyKNkxtXq8hkf4iamZ+xxG7lBQeK3xBbng7I=;
 b=cffZ0MIwAOGdC0Kj9JIruGztES9Y/jWb8BVnbRJGLqGXZ3JkSehtGFd5WFedC8jeeN
 Xq0u3cHfuSZ6BDhSqeWYjg+gxaX60devhh6LqAO+6F937Gj2MCSvaH55DGUlchQuaNl5
 zPekn++MPe4PF5Yy2mMAEdRT+Xsh/dFqQAwIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707757697; x=1708362497;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+hWl4UsKyKNkxtXq8hkf4iamZ+xxG7lBQeK3xBbng7I=;
 b=Jpu9BhjGzg3CLK3hG6L0cDIUGzXzLc5bXVEpJdEqMiI1ZV3n823DIybzlb4O2Qkfnb
 vjwcbRduSTrFg6jMVAjRcb5xVXNR05AvIImCss1v+3tyKDexkYgNpQk82h7RjuYm0EuI
 xLTa55uuhHDJnBXdYzrjPZuSDKH2H5I5lURVGFaBxGZmxfd08TE3xas1TMGGigwNxNDC
 ONxP0k/cTFvtSk53dKlCmaEW4lDVdfK+wNtDHT8j7SyWarxXN8gW77uJk0NaoTq40g31
 0cBsz/8lTm7iLvRiWIJBubDqvzErPECB8xxPIjTWVTHKqatZRADN8wQyur7eODxEGKvy
 z3JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNvxicUwpJuQzoLD3+kmIn5A75SG8O9BLhtHrlvbgpEmHjXsPUzv2SPFU8REPSmbB/uKyfAgDxp35MzbRG1U9NP39f1A==
X-Gm-Message-State: AOJu0YxcIZAwbZiYxbpc1axVs7P7wezgq2jgyGc9XkF3BuEiz/S602G2
 VFmbvgKygee+1vMTMKC3Xwb/8IopctCzawJQ/Cti5BCuSpQRVZDMIwOpxetV3YJUr3lxluOc39L
 T
X-Google-Smtp-Source: AGHT+IFHcsXUDk0vbXPhlxtLcUx9FyVMu8+r8f7DrEDka/qqUV8Id3xrM8fLw3EH0jg+lnNoCYwFJA==
X-Received: by 2002:a0d:fac5:0:b0:5ff:c4b9:be5f with SMTP id
 k188-20020a0dfac5000000b005ffc4b9be5fmr5541773ywf.47.1707757697106; 
 Mon, 12 Feb 2024 09:08:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU5Fr33V3GMNa08g4LsMiVuOtQD0q2oI/u0MZcyq8xmrMmn+PN1/Qlflu+4Wxdpf6K9ZBYmwPXIUqPEYGJHh+gq3GwoPlLG+rk/3RpHK5mpAW5qdQxwZ7eHGU8vKH7/mg==
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 o12-20020a81de4c000000b00603eb201977sm1219596ywl.70.2024.02.12.09.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 09:08:16 -0800 (PST)
Date: Mon, 12 Feb 2024 12:08:14 -0500
From: Tom Rini <trini@konsulko.com>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC] pinctrl: add support for HiSilicon HiSTB SoCs
Message-ID: <20240212170814.GK3040305@bill-the-cat>
References: <20240213-pinctrl-v1-1-e71c8ead72f2@outlook.com>
 <20240212165827.GJ3040305@bill-the-cat>
 <SEZPR06MB69597D40FEF2059B89BC68D196482@SEZPR06MB6959.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vF35S14QKm3MXR37"
Content-Disposition: inline
In-Reply-To: <SEZPR06MB69597D40FEF2059B89BC68D196482@SEZPR06MB6959.apcprd06.prod.outlook.com>
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


--vF35S14QKm3MXR37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 01:02:50AM +0800, Yang Xiwen wrote:
> On 2/13/2024 12:58 AM, Tom Rini wrote:
> > On Tue, Feb 13, 2024 at 12:30:15AM +0800, Yang Xiwen via B4 Relay wrote:
> >=20
> > > From: Yang Xiwen <forbidden405@outlook.com>
> > >=20
> > > The first supported SoC is Hi3798MV200.
> > >=20
> > > Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> > > ---
> > > This patchset adds support for HiSTB ioconfig module. The module is u=
sed
> > > to set pins config(e.g. pull-up, pull-down, drive-strength etc..) and
> > > pinmux.
> > >=20
> > > The first supported chip is Hi3798MV200. Adding support for Hi3798CV2=
00
> > > should be also easy.
> > >=20
> > > Below is an example of the dts node:
> > [snip]
> >=20
> > Has this binding already been accepted to the kernel? Thanks.
> >=20
> No, I've not wrote the driver for linux yet. That's why it is RFC now. But
> it is expected to be soon. I'm going to finish u-boot part first and work=
 on
> linux kernel later. After that, i can sync linux dts and bindings back to
> u-boot.

How soon before you start on the Linux side of things? Given that this
wouldn't be merged for v2024.04, there's plenty of time to get that
Linux side going (or at least the binding reviewed and accepted to -next
or similar) before merging here, and for U-Boot the biggest feedback
(aside from anything checkpatch.pl may say) would be to get the binding
reviewed.

--=20
Tom

--vF35S14QKm3MXR37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXKUH4ACgkQFHw5/5Y0
tyxoRQwAteGx8SAWnCeATK2ldFO7BCDO3b7r6GeAtUfr4IFXSO2EKLeZKiYLi2C+
2hHVu3z+GpEYugc7WmE3vixcBPTAtfhf7mVa+uwwSd/3PEC7s/HEfPSA+Bfzs6Kk
TA0uJo2HALCTjFfUaPw2KT4L77T5PXCPnIgjN4vM9S1HBELfwyGI39z2Ec5dVFmO
1nZ9OLe6nrOg9qjPHkRBvW1MOpxMNtqK17aj/ylsmKQoEeWiULraCVT4wReX0lIy
u/g07m9m7euhRnUYPU1nRRYqSRI8rSapeJP3JW9gw37uBQjuc1qIf/Of7OmjhtKF
3wxevejNydzXh3Yhbg42AxKPXVqZudnhZYLKvqsgk3bR0UYs6gpI2CYj2x1fAUEZ
UguAR2vQkZ2BGTHgRbp5Z40Tx0sQXLMh+UYYjE9onbT84wcV24c52ja7mqGITPjE
QPqoTDDVJ9p+ZmkyIApqrcNzRgMkUSWb3fyf3qXZhMLNj3d9YIxyO0Suo9RJ4n5d
tL3yAAsh
=9aaM
-----END PGP SIGNATURE-----

--vF35S14QKm3MXR37--
