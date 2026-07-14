Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85B7C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 21:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD2F784A52;
	Tue, 14 Jul 2026 23:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mCfbglpA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6297D84A6B; Tue, 14 Jul 2026 23:38:08 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3443384A4C
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 23:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6a116bd18ebso804005eaf.1
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784065085; x=1784669885; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=na4cUPoV0TPggGEFW+9Wok/MYk4wn1Iojb9azGkn0eM=;
 b=mCfbglpAeNMpffYkrqkg1DzVfgVenD6+jQLTafh158ElIkA/GsuAWr3nXtxPyspeLm
 IkHosQd2J3KUBdhqcWdbDV+KIy+sbUOZa4VW0OvgHEdl8iglrL2GMONVSBwin6LixTp8
 KhcxFOKYnAwlUXPqkgrQXk3ayQa8Z/oYdtxRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784065085; x=1784669885;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=na4cUPoV0TPggGEFW+9Wok/MYk4wn1Iojb9azGkn0eM=;
 b=hOEJ7KuEY5PFYeB3PswZtAZDg8Ie7ANzEI7S24pLayTRaQyiX01e9p06V4iizObhTj
 y4k3b8/r0QjJ+7vulgBtx2UafeHYgFUUuxY1r7WkinSk9iJJDCmqkLmrIVnVQldmiUuh
 FRig5C+nTn6Wr8Y0nJAAn3FkYstClv9DwPU74C2NK8E6lyad8VI+GsL59jMaa68WnS+s
 OHkT0x9c2vbFpgxdXzgxGmGhIx3jjBqalJ5P8RBVBREABsR3JH8HG51AfOBgOn3fHH3A
 gDvkZnO72PVQqAvOsIcnWGJ01+DBCsoIJR3TOufK+OHHH7iBR/qwAWiJpgZJMD8jBKTt
 bHfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5pAz7BBEDnXGonWFMQFtu6+y14Rtl44Bg4AkT9lWuLAnJM3vddS3vdiwozaskrEFuAg4ZrCY=@lists.denx.de
X-Gm-Message-State: AOJu0YyX/gUvtW06XCbNA3n9Ttvxz9BUqU9MtUK3wbF6+LyzSI31DXte
 vYtSdDr/jHOXvg/+Qrw+atXG2aUvm2MpHjE1itPy8MjkMUXUyiWBlPJ57b+bB/Xa3Aw=
X-Gm-Gg: AfdE7ck4cRMKOoHpW9Rby7f/apN6+f0sCJyyBc/lxdYZVJAsqdbUSAGWKp9cw59Q6I1
 DPx915upb4MW6D5GlXYAFCX5rYc1texmGTIdjQQieoqpolXPoIyeQg5gtfft636lkryDjLyiTWc
 DKtAfa/ySohzDwILU2UTDY6UwOpm45GzgR3mjP1K6h/R2jNCPlroEuOgHeyhPHzi9s/Qzm2z/Ww
 EtyZjF8SJUfOuDL0/NG177ctu8bF7wMcIY/qD68oIm6Q9b0ELyIch2tZzG5eGq/GKnuN0LOddqo
 gNrxw2bJEGPESQPwiBkqjpuRfUK6ptQk/ayR8Tecp4psOCH7m6WrdZTKMvjHeA2CqpXGi5rjbL0
 igPV1Hg2PyFMJrDdG0mjQ8JkUbr9mNPxAb+QXhJhooJ0+/JysFLx9OcklgzqmllkzqsRgcrxYEh
 ezjq3MU5MbLOefJRLIewRvUiUjzylE433vCo7gph6gpY1jHUhk6D3PQqfwAdXhOaR64gafNrG++
 2RhR7Qf8lfyXFBwFXujUzuh+tBYW38/Yq8aTw==
X-Received: by 2002:a05:6820:2224:b0:6a3:7761:b50d with SMTP id
 006d021491bc7-6a39a72cc15mr8793552eaf.55.1784065084926; 
 Tue, 14 Jul 2026 14:38:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb2b79c9sm15957568a34.22.2026.07.14.14.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 14:38:04 -0700 (PDT)
Date: Tue, 14 Jul 2026 15:38:02 -0600
From: Tom Rini <trini@konsulko.com>
To: "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "nora.schiffer@ew.tq-group.com" <nora.schiffer@ew.tq-group.com>,
 "Steffen.Doster@tq-group.com" <Steffen.Doster@tq-group.com>,
 "alexander.feilke@ew.tq-group.com" <alexander.feilke@ew.tq-group.com>,
 "Max.Merchel@ew.tq-group.com" <Max.Merchel@ew.tq-group.com>
Subject: Re: [PATCH v1] env: Fix compile error for envtools
Message-ID: <20260714213802.GF749385@bill-the-cat>
References: <20260713083141.2772971-1-Jacky.Cao@sony.com>
 <MRWPR04MB1233021A0AF8D2117DBE5984888FA2@MRWPR04MB12330.eurprd04.prod.outlook.com>
 <KL1PR04MB6734F919E17C467C8B29DBD787F92@KL1PR04MB6734.apcprd04.prod.outlook.com>
 <20260714015324.GZ749385@bill-the-cat>
 <KL1PR04MB6734A43A5179C30DA1F9B9A887F92@KL1PR04MB6734.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RugoFJQaxj2fwVO6"
Content-Disposition: inline
In-Reply-To: <KL1PR04MB6734A43A5179C30DA1F9B9A887F92@KL1PR04MB6734.apcprd04.prod.outlook.com>
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


--RugoFJQaxj2fwVO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 03:04:42AM +0000, Jacky.Cao@sony.com wrote:
> > > I use master branch of OSS u-boot repo and meet the issue with below
> > > commands:
> > >
> > > make mx6qsabrelite_defconfig
> > > make -j8
> > > make tools envtools
> >=20
> > What host distribution are you building on? And, <config.h> *must* come=
 first
> > in the include list, for it to function correctly.
>=20
> Host OS is Ubuntu 22.04.3 LTS.
> Toolchain is Arm GNU Toolchain 11.3.Rel1(arm-none-linux-gnueabihf-).
> Also tried Ubuntu 24.04.4 LTS and Arm GNU Toolchain 15.3.Rel1,
> the issue still happens.

So, are you on an ARM host too? You aren't specifying where you are /
aren't using the ARM toolchain in the above. Thanks.

--=20
Tom

--RugoFJQaxj2fwVO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalasOQAKCRAr4qD1Cr/k
CmOzAP0YpQyWAkWXVcNL1QzgIreyLa+9AWHL8U9v6pMZvsW0MwEAoFq25KBmksTF
S5jve4rrVXWqXF/nigDTPbtcKWUbvwk=
=RYTe
-----END PGP SIGNATURE-----

--RugoFJQaxj2fwVO6--
