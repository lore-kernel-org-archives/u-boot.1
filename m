Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A8FC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 14:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4653786EEE;
	Fri, 17 Nov 2023 15:25:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YXbStlT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A98A86EEE; Fri, 17 Nov 2023 15:25:46 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD0686D9A
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 15:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-778a47bc09aso122911285a.3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 06:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700231143; x=1700835943; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9FPRypj+1LftBv3Q0sDO/2L9P1VgXrDszr2QAzRxpxw=;
 b=YXbStlT4FVde2amZYKXw7zc6oDykvFya7RGbBRRuQ24USjnlehXnObgTvm5DF0WNPo
 4JEVFSsx+rKRCIaf5ZJwU2b9VeltkOjSGXG8wUBr4PzswQX8xAPJENIp5noqhcSkFp18
 fC+4Poanop62iKtyaINGMhSd+dlnn/QgQjoxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700231143; x=1700835943;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9FPRypj+1LftBv3Q0sDO/2L9P1VgXrDszr2QAzRxpxw=;
 b=uFkOUe+gcqpUU0jnZ8JLyDXXSlcFVE4ydMQwoNv3O5t80TFHCJRdIX8NrGFdkWxQrI
 WzfbDnSfaPjpV2xQZdL6wAjdBuC3YivjGlEBErENgHlegWVdii5+I76vJhD9G1NT2/VI
 3dtPE+FfNUitpJnzgnCKiXFlp+6c8WJ8WZvW/i+LorFNCKnhJrnLxgCcky+XNYmMeQMK
 r26/Y0QMdW72wOc4ZfTYS4vnXuWEsrQonV5HyhQ1owzogLq+7MO6zlPH0gor/Fm7wmyY
 551ySev2muNTAzefjI+Xh5nTA3aeUQEsS4+KXYB6FSeTxJRKTdczrMixHcwTDnaCqktf
 RMEQ==
X-Gm-Message-State: AOJu0YxTwGtZhqnxHVws6l7PsD+CJCPFiSrk10NLcbqfMG5OCMvn8d75
 LGrxX2yc49loKZV/bSn0rf43Bg==
X-Google-Smtp-Source: AGHT+IFoMwGb4RjrXvoUZ+CcaALRQr/vmYNGklod9eI87XQuaj7od8KrIfRU7KXEYasFF4jdtOZBAQ==
X-Received: by 2002:ae9:e50f:0:b0:77b:c8ab:af94 with SMTP id
 w15-20020ae9e50f000000b0077bc8abaf94mr10720320qkf.67.1700231142783; 
 Fri, 17 Nov 2023 06:25:42 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a05620a220500b00767dc4c539bsm637157qkh.44.2023.11.17.06.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 06:25:42 -0800 (PST)
Date: Fri, 17 Nov 2023 09:25:40 -0500
From: Tom Rini <trini@konsulko.com>
To: Stefano Babic <sbabic@denx.de>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v1 2/2] imx: spl_imx_romapi: fix emmc fast boot mode case
Message-ID: <20231117142540.GE170968@bill-the-cat>
References: <20231026073220.244387-1-marcel@ziswiler.com>
 <20231026073220.244387-3-marcel@ziswiler.com>
 <f9ce2b20-1fa1-408c-9ae6-4dd382c9c999@prevas.dk>
 <6ab14ae1-7044-4663-98e4-919b9d1757b9@denx.de>
 <899b50aa96b802275035f9ee40f46b461f8bfb46.camel@toradex.com>
 <86ddb623945da5a507fb4632375f7cb70361ac58.camel@toradex.com>
 <20231116184226.GF170968@bill-the-cat>
 <91c3d742-a87a-458a-ab6f-6a56706bb78c@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="skH0ZtUmFYMo9V1p"
Content-Disposition: inline
In-Reply-To: <91c3d742-a87a-458a-ab6f-6a56706bb78c@denx.de>
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


--skH0ZtUmFYMo9V1p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 09:17:27AM +0100, Stefano Babic wrote:
> Hi Tom, Marcel,
>=20
> On 16.11.23 19:42, Tom Rini wrote:
> > On Thu, Nov 16, 2023 at 10:57:27AM +0000, Marcel Ziswiler wrote:
> > > Hi Tom
> > >=20
> > > On Thu, 2023-11-02 at 08:09 +0100, Marcel Ziswiler wrote:
> > > > Hi Stefano
> > > >=20
> > > > On Thu, 2023-10-26 at 10:36 +0200, Stefano Babic wrote:
> > > > > On 26.10.23 10:29, Rasmus Villemoes wrote:
> > > > > > On 26/10/2023 09.32, Marcel Ziswiler wrote:
> > > > > > > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > > > > >=20
> > > > > > > This fixes a regression in the eMMC fast boot mode case where=
 the buffer
> > > > > > > was missing 464 bytes.
> > > > > > >=20
> > > > > > > The code figures out how many bytes must at least be fetched =
to honor
> > > > > > > the current read, rounds that up to the ss->pagesize [which i=
s a no-op
> > > > > > > in the USB download case because that has ->pagesize=3D=3D1],=
 fetches that
> > > > > > > many bytes, but then recorded the original upper bound as the=
 new end of
> > > > > > > the valid data. However, this did not take into account the r=
ounding up
> > > > > > > to the ss->pagesize. Fix this by recording the actual bytes d=
ownloaded.
> > > > > > >=20
> > > > > > > Fixes: 4b4472438f5a ("imx: spl_imx_romapi: avoid tricky use o=
f spl_load_simple_fit() to get full FIT
> > > > > > > size")
> > > > > > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > > > > >=20
> > > > > >=20
> > > > > > Thanks for reporting and fixing this, and sorry for the trouble.
> > > > > >=20
> > > > > > Acked-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > > > > >=20
> > > > >=20
> > > > > And thanks for all your work - I will apply this fix soon.
> > > >=20
> > > > Any news on applying this fix? Note that master still stays broken =
as of today.
> > >=20
> > > And two weeks later still broken!
> >=20
> > I've put this in my not to forget queue for the next -rc.
> >=20
> > > Anyway, I feel i.MX maintainership seems rather stalled at times most=
 of the time. I don't want to criticise
> > > anybody knowing how busy our trade can get. However, if it helps the =
cause Toradex would be ready to step up.
> > > Let me know what you think. Thanks!
> >=20
> > I would be happy to see an additional custodian for the imx tree, if
> > that's agreeable with Stefano.
>=20
> I have rather less time for U-Boot and it won't be better in the near
> future. Fabio is co-maintainer and he has accepted to take over the
> repository and go on maintaining u-boot-imx. Just let him some time to be
> confident with patchwork and CI.

OK. Fabio, please send me your patchwork username off-list and I'll get
you added and you can start managing patches there. I've started using
some of the b4 + patchwork integration just recently and it's very nice.

--=20
Tom

--skH0ZtUmFYMo9V1p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXd+EACgkQFHw5/5Y0
tyxWIgv+MbQ1U6piuF3QZzd250zYQrdMrRoLlrlLGP35mqQLUBSs00stK7v2jPE2
mlJn6SQoe531nZHv/9XQvtyHsmyDjAvVOcGeDKBImiSh37vDA9ShSJgnzOoBH8yu
pRFqji1E7gVrC+f7Hk5Ag9RtfdnTCulmOVyat/I6CFsfBRWT3qzxkLw1p5++q89Z
VgNpD+Q32CKyP4GgXUdQ9STt/VaWWKtMEn57bIYYENG7I1WObpI/BKqyO0D1Wfnx
/6qEXWjVRbISCvyh9razcjt/KYexgd+propjO3Z/3Bf+XQEMm1k3D4LfQEP/4Ffi
DExN54xbAIZv8tzJffrg6D4n8K+1GBCuwYNy7eMqNZjNt8IB128d6W4+VY7VxOvm
1Z9AFv8pxJ0VEJRzE4xA9zt6A3sWBpXHssEZL+tYJZ1bjou+sTOCRf2C5a4Kb+lI
Nbz/oas/W4tI2myFEwt5RRs82+4JFEUK7I5BZof1d+TNTyH1z1uXgKAEXCZ0O+r4
j3vB27MI
=jQlq
-----END PGP SIGNATURE-----

--skH0ZtUmFYMo9V1p--
