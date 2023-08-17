Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78D5C2FC22
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 19:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04085860AA;
	Thu, 17 Aug 2023 21:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c4ny+lK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4121185F9F; Thu, 17 Aug 2023 21:29:26 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60EB986BC9
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 21:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-56cc461f34fso150009eaf.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692300562; x=1692905362;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IlAlutvupOptEkkxyGz8Lfp2OCcFT0nWiV7FBQInhvo=;
 b=c4ny+lK05/uScgaZfz64OB4S7aD34CH8YZkC5WrmFuEzvb+xt2lwW06ZofeioSOJry
 Wu0IosWSYtMXITREkPpKjvRal4XNPN5FqmffloAkk1J25BTJg+VI7xqASmC7kmdKH1Af
 lu/PTguva/e3QcbXL+Nz+w7SgJyff8nBI+1K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692300562; x=1692905362;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlAlutvupOptEkkxyGz8Lfp2OCcFT0nWiV7FBQInhvo=;
 b=ReexNdf1ARuopLAl9AbUqtj3NEcwnjHntycwVw7qyY4JvRHFyuIDvFwNbfKHNB7/nw
 dbqD0e2sxmArvUg4qo/IgWgVTneiApCLZShcK5ilTSwjlNhmRVmDPHs7UQDsh0mTE6Hl
 S3LoRuWGwoqxd+GnI4/1p7Pfm136ah3IySRjVkctyivKQSEkWI53Qi3tAs9s6ycRGCl5
 AyC9toLE3kmgIxbRFVUu4YmplMbeelJC6YgsOciPI9Uy6QK5HkEWk2ykBlKU5GrnW6hW
 59BsTvad7v783Ks6jXwqp49v48ocuqAHQTseWfzev+uXGKCSHYFrrUtMSBpIY+18J3yJ
 BsPg==
X-Gm-Message-State: AOJu0YyNpfkeaWrO70UilOTJ40TVrNj9DZNLqp+oFOzKSGSpnPRZvnVM
 62JQTw5h6tbVAp8c0dh4IKTj91O87K2H8NX8kWZkJg==
X-Google-Smtp-Source: AGHT+IEFaPLBAjdP9d1dApF+5gZ2/KGT7Ccj4KPtdRGxNC0N+1VKjsccJzOP1hL0DQmCMdeGZ30pxA==
X-Received: by 2002:a05:6358:7f1a:b0:134:d78f:67bc with SMTP id
 p26-20020a0563587f1a00b00134d78f67bcmr391359rwn.14.1692300561829; 
 Thu, 17 Aug 2023 12:29:21 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 203-20020a2501d4000000b00d4fc4132653sm39241ybb.11.2023.08.17.12.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 12:29:21 -0700 (PDT)
Date: Thu, 17 Aug 2023 15:29:19 -0400
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] doc: rockchip: Add supported RK3566/RK3568 boards
Message-ID: <20230817192919.GT1515023@bill-the-cat>
References: <20230817060422.477759-1-jonas@kwiboo.se>
 <20230817060422.477759-2-jonas@kwiboo.se>
 <32a6441a-cafe-2cef-7b36-cad3fb0232c3@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j2KWYur3WYvTatWz"
Content-Disposition: inline
In-Reply-To: <32a6441a-cafe-2cef-7b36-cad3fb0232c3@rock-chips.com>
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


--j2KWYur3WYvTatWz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 04:32:41PM +0800, Kever Yang wrote:
> Hi Jonas,
>=20
> =A0=A0=A0 Thanks for your patch.
>=20
> On 2023/8/17 14:04, Jonas Karlman wrote:
> > Update Rockchip documentation to include RK3566/RK3568 boards already
> > supported. Also list Pine64 boards under RK3566 and drop defconfig to
> > match other listed boards.
> >=20
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> >   doc/board/rockchip/rockchip.rst | 20 ++++++++++++--------
> >   1 file changed, 12 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockc=
hip.rst
> > index 31aeb8567607..4668e598515e 100644
> > --- a/doc/board/rockchip/rockchip.rst
> > +++ b/doc/board/rockchip/rockchip.rst
> > @@ -91,18 +91,22 @@ List of mainline supported Rockchip boards:
> >        - Theobroma Systems RK3399-Q7 SoM - Puma (puma_rk3399)
> >   * rk3566
> > -     - Anbernic RGxx3 (rgxx3-rk3566)
> > +     - Anbernic RGxx3 (anbernic-rgxx3)
>=20
> This board is using anbernic-rgxx3 as defconfig name, but I would prefer
> update this defconfig to
>=20
> use name rgxx3-rk3566_defconfig instead, to follow all the other boards w=
ith
> SoC name.

Sorry, in my rush to get more MAINTAINERS entries updated / correct I
missed your feedback here.  Jonas, please update and I'll make sure it
gets in to the tree.

--=20
Tom

--j2KWYur3WYvTatWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTedQgACgkQFHw5/5Y0
tyyBJAv+P5E4z0f/fi2agqwr8vr51m5e1T8iK9gaG3do1vNMbtj84/Q55u/S+jN6
upJbroYu5JNbjIkDiUDfe/Hu2RDefzPrt3o4JL87BeHSJwqpnAROQ+l5+hnBhYmw
eNFmyVTHFMXUK4iy5v4/HK//AZ5QwF4SrCd6WFqrnRlr5hNQa+/gLDA7lCybd2fE
Bhzcm9dEpc5DA6Sp8ml24wf8euTTQ1tzGqeBL0hS8HjX3oaK09+TmbvAmRYTghcH
rKi7bIjczfce/6yGsQsvZxG5D9pUX8WQFqLDKDD/Fpz6/UCxRnmfgFqjxUDl1TH+
+it1tKsRw03PSULaTDpTNSGLnFwOjQL0UDB4/qJFRzViEUDBNVYiK4poLsQqPyNx
im9nJCY7qmzV6Hp90KryWKyKfTp3xTMenmieei4QzfcMh7wpjK6e36It9dkraZ6V
Iy1m7w/FarMcDgfqfUS5+rHWMxc6HZ8c204c30WTur/RScTgRsy7drcjQbVV0mWa
B6DTZ5dc
=LOY6
-----END PGP SIGNATURE-----

--j2KWYur3WYvTatWz--
