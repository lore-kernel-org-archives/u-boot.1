Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF505E81A36
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 15:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2025E8063E;
	Mon, 16 Feb 2026 16:31:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PCTokyzo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4971831AC; Mon, 16 Feb 2026 16:31:16 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1B6E80086
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 16:31:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-409de4132b5so1817146fac.1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 07:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771255873; x=1771860673; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sykoMD2SK3bXjVSf4nPzfJl3q2aFrZedmEOy+L6Dv1U=;
 b=PCTokyzotjAF9ByAQ8HKZ18k8OHkX7upxIofnKNwRKE0F1iwNIlj1tPK0T0YHpQd1x
 lr99QM+XuRGyAuV3J1b513KFHZ+J+uGdvkH7mVDvbhlly8A1i3uH9FgyrqErO+M9Ww/e
 UoSARSuDanATVCudaMCWRkC9MqvcURtDo8rnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771255873; x=1771860673;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sykoMD2SK3bXjVSf4nPzfJl3q2aFrZedmEOy+L6Dv1U=;
 b=uprxFwe/QgDpwqXziomMryKI3ajmfiUS5T6d9voc+eNGLCK2udEJOk67FPXWX9ayeL
 MPXsbZG38loeGALVcxpw0DVFD8ovAWhxxYOIWYwT0q5cza1j14LsA/6qopuI9Blc2qk/
 fuPWCpNqe1VyiAbn73Bi/1Zgx54n7KY/19ohY3myhOUrOKh3JZd0zyVSGcgnpd9IJgPm
 kH5WtYQFvP5LoVH8ay6Az7cKqEt0cFvy7Z2JOhqdC5RNFOI52bBp/Hegb9wSdsVSjp2/
 mbLNa4wZwCzSSQAz7Ym96WOA/+pc3ZWKtS8ItCnAinFSOG+reZeSlqojG0XnKMz0o+cG
 t86w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1/1SiroEXzSLVRar0mmw4KBmxgaOuf8vfT3r+lXWEKQ+7ZBicNXeIsgDoaAa6cnjnDDefWRU=@lists.denx.de
X-Gm-Message-State: AOJu0YzAPBv1U5fHKiGQU7xB5vP40lcJNqsTe/wqZgVzfrJX2nLLYK3B
 6kmCrUm4QVishpsbl2aqGaeL/wo5VgvlZ0tEK/kSG29u/oMEs7xGKYbvhQdi2GMrT6Y=
X-Gm-Gg: AZuq6aJ9pNv3fp5v7fROOsDgmqBKPryIxvopxkXaEmtTO6LU5VK/LO2OJk4wxjqB5K6
 98DqGDhfWX+SPrYD/Z56JwAh4obF43TsJLNYpIwyQegFfEAP11A4Bhyp0xi3yr28i+/vXzqbrhU
 R/dkTIOcHU9QuSnau/R2R8z7B5E91v6pC2rudNhpgPjc8H5eC6xx/dc6ohMwr21uQue7roxdnBT
 y+fkNftgdU/hjfm9KIM79A1wL19qEh17BFgXTSC+BdsWNlGwjV5Zxu1uxsoc1+0qAdGfZ68esnr
 Xoeu3vUusJv7f0NGDWM90mSqVx09F92nRMX0/BaMk0Qq4mxFrTCWWaN8FLPrG91/DhFTSqo/X34
 gF4Pec8ibiyhki1FHnkLw68i+6E+S6VWMqynjWLhuVs/xQEQDCoNQdCL8NnpNO7nG8Ov0QKySlo
 NOoICWf6eVIBXahvNYt6MQUwNE5UOxx6I+YhNA/SZE3HlVAqCA3MQVE8XK/71eNu+4MfEkrmoV+
 MGM2JWQ/qjehcx1xYGBCzP5B24Pz9d78bIkDG94bg00GxR2Dii9nHfu3BkisQ==
X-Received: by 2002:a05:6870:8275:b0:409:99bb:1eb0 with SMTP id
 586e51a60fabf-40f0d94fbe5mr4505668fac.44.1771255873221; 
 Mon, 16 Feb 2026 07:31:13 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40f062ee328sm8717228fac.4.2026.02.16.07.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 07:31:12 -0800 (PST)
Date: Mon, 16 Feb 2026 09:31:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, u-boot@lists.denx.de,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>
Subject: Re: [RFH] SPI and SPI-NOR patch help
Message-ID: <20260216153110.GV2747538@bill-the-cat>
References: <20260213164607.GI2747538@bill-the-cat>
 <20260214-sternness-cling-4259916a8f73@spud>
 <DGG8OA1O1UEL.12RR559TX4XX6@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BitxFZBc3gTzefki"
Content-Disposition: inline
In-Reply-To: <DGG8OA1O1UEL.12RR559TX4XX6@kernel.org>
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


--BitxFZBc3gTzefki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 09:21:55AM +0100, Michael Walle wrote:
> On Sat Feb 14, 2026 at 7:58 PM CET, Conor Dooley wrote:
> > On Fri, Feb 13, 2026 at 10:46:07AM -0600, Tom Rini wrote:
> >> Hey all,
> >>=20
> >> To be blunt, U-Boot needs help with reviewing and maintaining the SPI
> >> and SPI-NOR subsystems. We haven't had someone with time to actively
> >> work in this area for some time. I'm going through the outstanding
> >> changes now, but it also seems a common problem is that with respect to
> >> device IDs, most of the new ones also aren't in the upstream Linux
> >> Kernel. Is there some better and generic solution we're missing so that
> >> we don't have large and often growing device ID tables? I'd rather not
> >> make that problem worse, so I've rejected two of those types of updates
> >> today and I'm just setting aside a large number of others.
> >
> > Dunno if your timing was cursed on sending this, but Tudor submitted his
> > resignation from spi-nor maintainership in the kernel about 10 mins
> > after.
> > I think Michael Walle might be responsible for what you're talking about
> > here, with his 773bbe1044973 ("mtd: spi-nor: add generic flash driver"),
> > but idk jack about spi-nor stuff.
>=20
> Yeah. Nowadays SPI-NOR flashes come with self describing tables,
> which are already supported by u-boot, I think. The only change that
> seems to be missing is the fallback to it if an id isn't found in
> the flashdb. Only thing is, the SFDP doesn't describe all features,
> most prominent example being locking. So if you need that, you'll
> still need to have an entry per flash.
>=20
> In fact, in linux I'm planning to change to make it probe SFDP first
> and then amend it with the flashdb information (if there is an
> entry).

Thanks for explaining. So in that U-Boot does have SFDP support, the
first thing is platforms should likely be enabling that instead of just
adding IDs, at least for basic support. It still leaves us in a bad spot
about having SPI and SPI-NOR stuff reviewed and maintained, but at least
it's clearer in public now where it stands.

--=20
Tom

--BitxFZBc3gTzefki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZM4PQAKCRAr4qD1Cr/k
CgLbAQCwNbD1OxYdIKeHDuC1edwhX4KuPTNQM2xCxof19IynGQD9HiY2TMT29T2E
roDCQwCIKEewF6tO2hcXEnFz52SULgQ=
=U2ws
-----END PGP SIGNATURE-----

--BitxFZBc3gTzefki--
