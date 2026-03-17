Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109F0FD877F
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12FCB8435B;
	Tue, 17 Mar 2026 15:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OCXYGFRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 759F78435C; Tue, 17 Mar 2026 15:50:01 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E4EF84353
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:49:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40ee9b945d5so3733161fac.0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773758998; x=1774363798; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NMteZNCPCznOLBdeKOZHT5zYUySWZ/ftZDuqND6ZhyY=;
 b=OCXYGFRU3JY0JMmkaFniqWrYBry//VnP0DxT+I19Yqi8J79C4eCUJulhx0nnS4y25n
 C8YJcLE4Bhyy8COf4QTnYcoCqW0LxJtSR0qFu7oT+smTDNrSCBdVAAqif/T+tuc8twyo
 TYGQPvfSoDi+jv5oBSz2WY8VsOFq4c0UEiJGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773758998; x=1774363798;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NMteZNCPCznOLBdeKOZHT5zYUySWZ/ftZDuqND6ZhyY=;
 b=iIbZ9A7UC6Ed62DdP94xGN1ZjKkny6K1u8Lphf8y6xKa+TLFWZa+6yIXJV7czBTdXU
 M+IwB/BKvlG9J0Byz/5n8WtT5l/HYDnNSZoYOrN6RmWFUGNWudXXQfuJ2RbRzUb7XWo+
 uX3JjR/2wsET54k3xAYICWCCV+1O5rSjY32CEUr/knQS7DurVZZ9SxOi+bMrw7cavMeH
 N9gVTslzlqj4BHnVDzjhMiGVnOk0lVtEcRFOKFMKhsoU9SFD9tvkQqYLjTZ6SkusKAEN
 8QRS4jKsAOgFS7YyiRWycsHlaC4JxN/Cx9BSK6FV8Zu53kIeR+U0NFYISlHLYsrSaE1T
 v1wg==
X-Gm-Message-State: AOJu0YxXKrUt+Q/zfqQ5AF+PU6O6eTiR+FELYtE9cFsF14xDJnRZBnO/
 RvV10T2G78GVKnEQQnqJT5Xgxtqjl/9qAjzH/STqfDV9nZTqnzgh6HzEBgwW9y0ii8g=
X-Gm-Gg: ATEYQzymHvjDt8QZbnPjptMgqr8J44ZBRnCvE5nb3wsTVlnpvi9A9iMKZeqTVXyVt0C
 nKo7/S5jpBNpKqf5b4ErMlhxtqZ3R2+TeKePk9rwAFU9DV7hB8XJTQWeB8KO0G7Sgsy0Du9PrZ7
 28YEyP1EsNaDubMEJt0U/UQy9A2AAYpDxRc//kSLonBMBj9SjV54zBFS/cItDozjOz9tTRih8n8
 3GAtfySEQvl52gv4E7xbx+IF21iaF0HztQOgZuYa8aTY8Z2Q5XmhxbSOzDxlP3KDO30EwhvJg6Y
 fX10O+jBsqMgyG3Ch/eRYC2WHzzc3lhBRsyylcNn2qeD+BLkv3FsQelyku9SN1mcLofM1rZGnFs
 9K+FA5sIJRuYqITfmW9eqdMo96L2tfIAVhsSuC6scfHFhLPXCGetGnNp8vxUwPCbdmLBMdeGjgA
 k49/COWAaZkuyApBluEsGKbZJCXV7nXZPshMBGDTilJ+HFZSuAxwrlMoGtlWWpLjBDC9hyPEnnC
 PTNFwwMNEzBJeKa4HNnf4biVpihy+GLuFgqBW3THtQ3WxMK
X-Received: by 2002:a05:6870:5492:b0:417:3b1e:ca84 with SMTP id
 586e51a60fabf-417b94506bamr10590552fac.49.1773758997762; 
 Tue, 17 Mar 2026 07:49:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-417a2372b13sm16307352fac.10.2026.03.17.07.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:49:57 -0700 (PDT)
Date: Tue, 17 Mar 2026 08:49:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] microblaze: Rework TARGET_MICROBLAZE_GENERIC
 implementation
Message-ID: <20260317144955.GC502704@bill-the-cat>
References: <20260317012412.4162279-1-trini@konsulko.com>
 <92a3aa0d-4d2f-4845-9ac2-6bcb976bced8@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ltjiStJ7luSyfSBp"
Content-Disposition: inline
In-Reply-To: <92a3aa0d-4d2f-4845-9ac2-6bcb976bced8@amd.com>
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


--ltjiStJ7luSyfSBp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 01:06:15PM +0100, Michal Simek wrote:
>=20
>=20
> On 3/17/26 02:24, Tom Rini wrote:
> > As exposed by "make randconfig", some symbols such as
> > XILINX_MICROBLAZE0_PVR can be set without TARGET_MICROBLAZE_GENERIC but
> > have a transitive dependency on it. The easiest path of resolution here
> > is that since there is only one valid microblaze "board", rework that
> > symbol to be non-optional.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Michal Simek <michal.simek@amd.com>
> > ---
> >   arch/microblaze/Kconfig | 10 +++-------
> >   1 file changed, 3 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> > index 4261e5009fdc..16c55ddfd95c 100644
> > --- a/arch/microblaze/Kconfig
> > +++ b/arch/microblaze/Kconfig
> > @@ -7,12 +7,8 @@ config SYS_ARCH
> >   config STATIC_RELA
> >   	def_bool y
> > -choice
> > -	prompt "Target select"
> > -	optional
> > -
> >   config TARGET_MICROBLAZE_GENERIC
> > -	bool "Support microblaze-generic"
> > +	def_bool y
> >   	select BOARD_LATE_INIT
> >   	select DM
> >   	select DM_SERIAL
> > @@ -26,8 +22,8 @@ config TARGET_MICROBLAZE_GENERIC
> >   	select MTD
> >   	select SPI
> >   	imply CMD_DM
> > -
> > -endchoice
> > +	help
> > +	  Support microblaze-generic
> >   source "board/xilinx/Kconfig"
> >   source "board/xilinx/microblaze-generic/Kconfig"
>=20
> Applied.

Please drop this for now, I need to do a v2 and I've found another
randconfig that gives me:
WARNING: unmet direct dependencies detected for XILINX_MICROBLAZE0_PVR
  Depends on [n]: MICROBLAZE [=3Dy] && TARGET_MICROBLAZE_GENERIC [=3Dn]
  Selected by [y]:
  - CPU_MICROBLAZE [=3Dy] && CPU [=3Dy] && MICROBLAZE [=3Dy]

with this applied.

--=20
Tom

--ltjiStJ7luSyfSBp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCablqDwAKCRAr4qD1Cr/k
Cg4FAQCWmpPFxs/NQqUNIyDIGVd97ccB4012OINiemZTU81TYwEA3ua9dxv/yfzj
F1en1x64fVf/2wZr5vZC7ZUGmUJK3AI=
=XrSn
-----END PGP SIGNATURE-----

--ltjiStJ7luSyfSBp--
