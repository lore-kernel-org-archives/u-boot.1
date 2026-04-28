Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4248DFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB6EF84150;
	Tue, 28 Apr 2026 16:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QC2gqlxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9FEB8426E; Tue, 28 Apr 2026 16:06:13 +0200 (CEST)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62CC883FB5
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 16:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so4800815a34.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777385170; x=1777989970; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VhecRkFsiwa4bqd8Q6UAch9uEbaU0KMf19eywZgWEgY=;
 b=QC2gqlxALxt0iEhQ7fZUQIddZVjSw2OE3rXzAJ3Z1Pts6YThKviC7l2Qvh0TGUItgp
 FaHKPagDZSoEwPhYyMbPlhod0OTOzPS0jEMScxP1gqm+WcE9r+la5+F4Q+R2Kh2EPPFw
 r0SCjim1CPmvjW4eUiKu0fBPLkXQmnyhDQ5Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777385170; x=1777989970;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VhecRkFsiwa4bqd8Q6UAch9uEbaU0KMf19eywZgWEgY=;
 b=rJ5XKEC3EmpNrBdO885jP/QJrhAeE10O/Qre8QAA1lCx41bbtZ+hj357woaXneji1C
 HdVH/acKvYxR0tMnvNfWeg5wvdTkgcVLFL99R8YqfXcgqIyyZKbZd/zcWaGztN8k2Kzg
 l8vUsWNwZstmV1fN62bS40ykcSyv6q1GzmiH3lqoamjMIybpopEArBIIgHbeq3EdZBHJ
 nIaK4cw6lf3bgUIzHIzJ46HPHz90wF+FtaUa+Vq69a1WYMWHXzhtBfn7DWrGuy5sQXhY
 rQl2ab9zTjPkN1NUzvSo5Wvl5GW89ZnfdKfOLzUxooOPk8fJpTat0iaJ1bVikl0HRvFq
 QN5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ89vSFH2au+9QW4K9UXxedYhebRYQOB8eVZd4/6tWsTcUMlJkhwpXLjzrlJ9myRv7YDJQ/fdzg=@lists.denx.de
X-Gm-Message-State: AOJu0YwWngYP1ZYwSe7WMDtir/HaHR6M+37UQPfa4LVjCaUo1Xto9Du4
 2eEEiJKyfH8iMDLVGAo8e8pyxg8Bpi/fdYnFT9nRTbMlzV4k60eEjEsj/ooYTyxpf48=
X-Gm-Gg: AeBDieuoJMuXGBlfyI8yA3zTFgtlrjQgsXMJMBlhGsqLWyAEkGML77EABkfiIBLAmGq
 w4HocCfQg5/nQx9ANGf0vkxx5Tcy4/9rXG6XUfyp+0824LciTGFsZpZLQOXx8J1hq9gKxqX5qZu
 jb3kcnqNk1gotxX4a3hyrdPtem4SxPZiLGE/sQA8I06XEKOOQJIOjnptanCP789CgJgdUnVK5fy
 FUkZ/IjFcy0H8+pFS6nBAHfZhInor4L67Nd8D0L4ZkNAX1MrSZGNZ9NaSYfAPL1DWRxjmHWd8jf
 RoxdKGN44jOywvRVWu9jAtHH9x1V7me+QALcyHgKfr69LtyM8gy6cPhxQKTerXUTTV+oUE5J+P/
 wdqxjDtTU/3LTqAUFUTNU8O33e68/xh7gSM0z/PIPcCI3iMM2dl+Q6WyEBp+fjw7SDGVPv41ifl
 w41mjaS54PG2UHwiZgWX4D3L5bi4tYJk/OjpsZaMJcblb5EHh7LUsgrTNFoFnpHKP3n3GsWYv7S
 WUSjeA+EIxO69J0y0VIQ9uLqx+OvPEhGZ0T6QWv2sPF7iU9MGbuLuW96ri/KeaJCwc/d4y7
X-Received: by 2002:a05:6830:82b8:b0:7dc:cd0b:58af with SMTP id
 46e09a7af769-7de99f83abcmr1631061a34.6.1777385169759; 
 Tue, 28 Apr 2026 07:06:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7de9866be1esm1834496a34.18.2026.04.28.07.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:06:09 -0700 (PDT)
Date: Tue, 28 Apr 2026 08:06:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Prasad Padhi <b-padhi@ti.com>
Cc: Simon Glass <sjg@chromium.org>, afd@ti.com, bb@ti.com, anshuld@ti.com,
 hnagalla@ti.com, jm@ti.com, nm@ti.com, n-francis@ti.com,
 u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v4 01/11] spl: Use FIT data address as fallback when
 'load' property is absent
Message-ID: <20260428140606.GR41863@bill-the-cat>
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-2-b-padhi@ti.com>
 <20260427195405.GL41863@bill-the-cat>
 <9863b81f-e6ad-41cb-8e02-4f22377d0137@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/jYIVM8tSl6xXAux"
Content-Disposition: inline
In-Reply-To: <9863b81f-e6ad-41cb-8e02-4f22377d0137@ti.com>
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


--/jYIVM8tSl6xXAux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 04:26:31PM +0530, Beleswar Prasad Padhi wrote:
> Hi Tom,
>=20
> On 28/04/26 01:24, Tom Rini wrote:
> > On Sat, Apr 25, 2026 at 09:07:32AM +0530, Beleswar Padhi wrote:
> >> In cases where the 'load' property is not defined in a FIT image node,
> >> fallback to using the data address returned by `fit_image_get_data()`.
> >> This enables FIT images to omit the 'load' property during FIT creatio=
n.
> >>
> >> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> >> ---
> >> Cc: Simon Glass <sjg@chromium.org>
> >>
> >> v4: Changelog:
> >> 1. None
> >>
> >> Link to v3:
> >> https://lore.kernel.org/all/20251231173621.1069988-2-b-padhi@ti.com/
> >>
> >> v3: Changelog:
> >> 1. None
> >>
> >> Link to v2:
> >> https://lore.kernel.org/all/20250506104202.16741-3-b-padhi@ti.com/
> >>
> >> v2: Changelog:
> >> 1. New patch. Add support to load images without 'load' property.
> >>
> >>  common/spl/spl_fit.c | 16 +++++++++++++++-
> >>  1 file changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> >> index 46ebcabe56a..87d01b8b8e6 100644
> >> --- a/common/spl/spl_fit.c
> >> +++ b/common/spl/spl_fit.c
> >> @@ -799,6 +799,8 @@ int spl_load_simple_fit(struct spl_image_info *spl=
_image,
> >>  {
> >>  	struct spl_image_info image_info;
> >>  	struct spl_fit_info ctx;
> >> +	const void *fit_image_loadaddr;
> >> +	size_t fit_image_size;
> >>  	int node =3D -1;
> >>  	int ret;
> >>  	int index =3D 0;
> >> @@ -889,7 +891,19 @@ int spl_load_simple_fit(struct spl_image_info *sp=
l_image,
> >>  		if (firmware_node =3D=3D node)
> >>  			continue;
> >> =20
> >> -		image_info.load_addr =3D 0;
> >> +		/*
> >> +		 * If the 'load' property is not present in the image node,
> >> +		 * use the FIT image's data address as the fallback load
> >> +		 * address. This allows flexibility in omitting the load address
> >> +		 * during FIT creation time.
> >> +		 */
> >> +		ret =3D fit_image_get_data(ctx.fit, node,
> >> +					 &fit_image_loadaddr, &fit_image_size);
> >> +		if (ret < 0)
> >> +			panic("Error accessing node =3D %d in FIT (%d)\n", node,
> >> +			      ret);
> >> +
> >> +		image_info.load_addr =3D (ulong)fit_image_loadaddr;
> >>  		ret =3D load_simple_fit(info, offset, &ctx, node, &image_info);
> >>  		if (ret < 0 && ret !=3D -EBADSLT) {
> >>  			printf("%s: can't load image loadables index %d (ret =3D %d)\n",
> > I guess the real question here is, does the spec allow this to be
> > omitted like that?
>=20
>=20
> Could you please point me to the spec? I could not find it.

Sure: https://github.com/open-source-firmware/flat-image-tree/

--=20
Tom

--/jYIVM8tSl6xXAux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafC+zgAKCRAr4qD1Cr/k
CuCBAP4n5j3EWIqfez21c9BNVQf/Rd1rTuSj5iXi+Ah4vT5ahAEA8aOvjirz/U0L
Y2rGV7SR+D0jb7KL3+0AE1e8uy5+Gwk=
=HkW8
-----END PGP SIGNATURE-----

--/jYIVM8tSl6xXAux--
