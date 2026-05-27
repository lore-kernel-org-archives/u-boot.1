Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4F9CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 14:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 695CA844CF;
	Wed, 27 May 2026 16:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LtGLJzB5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44376846E2; Wed, 27 May 2026 16:47:40 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17556839A8
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 16:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7df05fc49e5so11625009a34.3
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779893255; x=1780498055; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xDUQMBFj9allUg/dpFXrlMgHz0MAzM7oXUL1QgOnquw=;
 b=LtGLJzB56Z7m0XNZICGd682/VS91fC3nytOWBnP5XG1ydquqb5n45Zcdm/khGkZ8fk
 DfWzj7JxGCg3uiHqaiPZ6NdEKAZFGd9DvkJJAiTDMVx5BDPLTz0m3OWJRqvWvmRKbKXa
 /v3mROUk5qvrcmn5/shfUf0hxSzZQv8aymrTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779893255; x=1780498055;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xDUQMBFj9allUg/dpFXrlMgHz0MAzM7oXUL1QgOnquw=;
 b=J2xvdIyxLYbNhwReu5uGi4OnIvTiUeJXsjPqNcDGaACi+G0MItrSCYpoORGFHCc8Ih
 BBkBgPsNjhtoigQPNPgoqaoAbuWuXlYBP+U5hD6FDcrHb1MhevIOasgCxFbWrgDSy8T5
 EaovL5vv18mLy/CR7a9xjgcdnFdTOfcTgO86PoO3irr5zJYOWVWleteVCPeWcECKWC5n
 UaXh1zrcV0GwRKE5MpuixIynvpn0+32/ga+a6Hq5va/zMHo5GEQ9ohfDCpYmVbi+OSAS
 wFSRjhFqgP/whz6G9n1VRo/F3u1+mgf+jjBpLBHek3yS6U0R+VJ1yn1t3e3GWSZRUw0b
 8PCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ850c0moo50rk2dig5ShIPhXCJ5r4AzS/AVOzprFlBtuTt/hUDjsfmc81JrBHj93nMrqgV17AQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3JdKusc2pad2NMge3c0QRO5J0gfymAsp/jKWYkxgUyZUJdNeg
 vWY68YpKOn8VKiexXD605VpfCj8xBY4BO7HaW1d1DvI9eB6XWJ+lhe6Z2HWzeLHIVqw=
X-Gm-Gg: Acq92OH0XcPDu/FXmSBi5lJr1jJRJlDb2aeVhk8IF+JA3nklWW4ZLGhoctUMJ4hy8Gr
 XA+QyOg24LQMIuo/L/SinAaFD5E/ZzBFMKl6yN9K2vpL26AkWUCXg0yqP1vCRblh9doH66WliuQ
 qb4z4vIXzH58Cwyhyk09yKoxnZSDmdIqPxqtAszVQ9vZ/Bf3cnZNs3LCrqXKNwX6raIl2C2KFHD
 T+Azgiid8yGFts4OGkWrHx0JorIb49Zks5pV4qROkjDQ1VQOKrmkGxzmYOWqXxqrzMgTav4pXz5
 SYFtSgQwFL5wX4uKKPz5+p7fKT3lwe+tiSCrJuko9z/q0KfiFHafky0lMnOvbq20sWM8yJ18CP+
 /N2pE3kA7WF2EAmhs7lV6u0fAaWPjESUr0wEAGCG3hFtMT9h2GQlId+kcc1rSWoUMWV9J1N/51r
 JStArBsW0HS8Ga887IHcCFtY0rM0QGIQIUoaMFU8c4jVhjv3+rGJRm6I9a2mFJnMO8vw41hHvBx
 e2x55T67dLb5d2F12H1hFvjfmqvf760dSNi8NjJkW7Cxex7VHqDPNSU
X-Received: by 2002:a05:6830:6682:b0:7dc:dd58:50a1 with SMTP id
 46e09a7af769-7e5fee5ef73mr15386790a34.15.1779893255479; 
 Wed, 27 May 2026 07:47:35 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm11720286a34.4.2026.05.27.07.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 07:47:34 -0700 (PDT)
Date: Wed, 27 May 2026 08:47:32 -0600
From: Tom Rini <trini@konsulko.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH 6/6] net: mvpp2: convert FDT access to ofnode API
Message-ID: <20260527144732.GF1858239@bill-the-cat>
References: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
 <20260526-devfdt-net-v1-6-be3597b85b5e@nxp.com>
 <CAFLszThr_osXm8kdJr8aXEN0uZwk_-FV9EsB2s=oWqTDbu6cUw@mail.gmail.com>
 <MRWPR04MB123306B6BA8249EBBC856412A88082@MRWPR04MB12330.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QoekJkAk4Kmpu0/Z"
Content-Disposition: inline
In-Reply-To: <MRWPR04MB123306B6BA8249EBBC856412A88082@MRWPR04MB12330.eurprd04.prod.outlook.com>
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


--QoekJkAk4Kmpu0/Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 02:29:37PM +0000, Peng Fan (OSS) wrote:
> Hi Simon,
>=20
> Thanks for giving a look.
>=20
> > Subject: Re: [PATCH 6/6] net: mvpp2: convert FDT access to ofnode API
> >=20
> > Hi Peng,
> >=20
> > On 2026-05-26T07:25:09, Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > > net: mvpp2: convert FDT access to ofnode API
> > >
> > > Convert mvpp2 driver from legacy fdtdec/fdt_* APIs to the ofnode-
> > based
> > > interfaces.
> > >
> > > Replace usage of dev_of_offset(), fdtdec_lookup_phandle(),
> > > fdtdec_get_int(), fdt_parent_offset(), and related helpers with their
> > > ofnode equivalents, including dev_ofnode(), ofnode_parse_phandle(),
> > > ofnode_read_s32_default(), ofnode_get_parent(), and
> > > ofnode_for_each_subnode().
> > >
> > > Remove direct dependencies on gd->fdt_blob.
> > >
> > > Main changes:
> > > - Use ofnode_valid() instead of integer checks for node presence
> > > - Switch fixed-link detection to ofnode_find_subnode()
> > > - Replace uclass_get_device_by_of_offset() with
> > >   uclass_get_device_by_ofnode()
> > > - Update subnode iteration and device binding to use ofnode
> > >
> > > [...]
> > >
> > > drivers/net/mvpp2.c | 54
> > > ++++++++++++++++++++++++++---------------------------
> > >  1 file changed, 27 insertions(+), 27 deletions(-)
> >=20
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >=20
> > > diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c @@ -5436,15
> > > +5436,14 @@ static struct driver mvpp2_driver =3D {
> > >   */
> > >  static int mvpp2_base_bind(struct udevice *parent)  {
> > > -     const void *blob =3D gd->fdt_blob;
> > > -     int node =3D dev_of_offset(parent);
> > > +     ofnode node =3D dev_ofnode(parent);
> >=20
> > 'node' is now no longer used by the look of it. Do you see a warning?
>=20
> I use "./tools/buildman/buildman x250 ", I may miss something.
> indeed no user, I will remove it.=20

You have to use buildman -E to make warnings be errors. Or, *cough*, we
enable WERROR by default, as has been suggested.

--=20
Tom

--QoekJkAk4Kmpu0/Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahcEBAAKCRAr4qD1Cr/k
Cv9wAP9zQpqfPO40jHXLcSuv1AKayQkB/OGqEKKeMG8q9VYXEgEAuQm6hVR9+TE1
em+057dq71HUJ0KujjMwkzwOI/kzhQg=
=h7Gx
-----END PGP SIGNATURE-----

--QoekJkAk4Kmpu0/Z--
