Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E782D29C40
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 16:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CD89802C1;
	Mon, 19 Jan 2026 17:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C6c/UmjY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C2148313B; Mon, 19 Jan 2026 17:30:27 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9D738003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 17:30:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7cfdcae466eso2387092a34.3
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 08:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768840223; x=1769445023; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U8Pn2Qiwuca7fubi4+O3X71fd8bg/fzU8siHXNZVDBs=;
 b=C6c/UmjYY1gM0KFFX2NWNGVv1mW161fuNg1l/+Aw1oUuZHKvBDrYJY5f0rOkPj+Jqd
 +/iULiPqBvjpGW5wMAYcG5Vgnv+FiZ4fVrctHQmXvwkSconH6g97NhUxX9MkChMc0nqf
 jehnROk+YwNDIYgkbQBqnIgzJA09NKawoQFgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768840223; x=1769445023;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8Pn2Qiwuca7fubi4+O3X71fd8bg/fzU8siHXNZVDBs=;
 b=UykjRG6rvFuF17X93irEhTnLIW6P4yMBdCifHXdnbKcBMwaQa0UJFrcEDc8n9tJuUi
 8jCiKeX0YOEEL7Mu9e8MEcmTz8Plj0z29T7NQmRiCNhwMuEH8wWFDE2dxHeoL7rKIGdC
 bk5JcHhMOSOIG8c/sNLulEGpdzO9v2LifwtgncdpSdtAC8paPH3Twm2Rkgs2SKljb6c+
 Dc/PjZlz5DIlk3Y9nLEMvGEEawA4cIfD/GMdioymKWQq/Er07/NJe8dk0uJxKr46AyiY
 Z80NmTnDvleyxv7+a0Uu6n+UPPSRxb2/AHnXYfBfq6rMHBtrUAgv5iAICqG+HLTm/Qfy
 PyXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmnLr+25t5JDbFfZKxRJQaTaWC1V+vUJQZ5ZSIpBxdDr8EGJCa4Axyd4Ent4C+RPaEGfBa5Eo=@lists.denx.de
X-Gm-Message-State: AOJu0YwSZBIW/Ty55lTjlixKPJr8RmNmd8+Tu1i1z/Dn3RTbUjwmjQS7
 KCYiznVS/kFt2VMlxmhBZO1KEHHfpRg9CFSmT3zjtGv+8iPIPGXckcYmeNlroj7M9bg=
X-Gm-Gg: AY/fxX690J2CuAd/QMz0YIx/tH+8F6sozVN25dhUFbnuHrtSXb7O/GUvXrbZlHpbSar
 XzX+U5OvhCXDhlLqcAIae/Cwkl2sW1GKWVrss9gmWR5GAQB25ibNPqRTeiYCICJOcBXzeksjpFV
 yGg3DgC9JWxwY+hh3YzpJh7616v9Ad9pad4Dc64Vkrz1YdQq315V3TbzZDodsUizOuflOAQG6SD
 En0uDQGSJXXJtnBdCr/JeSgg0ZKNVgf3P7RROZnfJmGYANtRjaTXdXoEQvfS/xhKwVjgWMZhfjl
 dyoXQ4xMjKEbT+OWtBIiV62LTFGn3Qmri3g5lTKYNcX0E+y1xEJy05KyhGlZ+lOYeobWP3Rr/DD
 xZ4i1wyWSONKejLMZiUOitvPAmC7JCt1ZoOMQTvsiA/g5V0COts1lPN+SywCLTSOZcCMdh4CjPD
 w++eD9+d7EZWoepPXYKTV5q5HkZ5joilEP3R4frMI0y7YxQdwaSyGb+kx+dXV8TPrt7w+sqmBfw
 74cDypYpgJ5Mi+9EAALl0HsN/L6hQ8I3lef8JI=
X-Received: by 2002:a05:6830:6d4e:b0:7cf:d2f3:af8a with SMTP id
 46e09a7af769-7cfdee50f9bmr5888323a34.28.1768840223456; 
 Mon, 19 Jan 2026 08:30:23 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0e9209sm6939218a34.8.2026.01.19.08.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 08:30:22 -0800 (PST)
Date: Mon, 19 Jan 2026 10:30:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] ARM: dts: stm32: Add bootph-all in ltdc node in
 stm32mp257f-ev1-u-boot
Message-ID: <20260119163020.GY3416603@bill-the-cat>
References: <20260116-add_bootph_all_for_ltdc-v1-1-de4dc0ae1115@foss.st.com>
 <20260116192837.GO3416603@bill-the-cat>
 <480a1eaa-c090-4293-bb1c-ebddc8a4d04a@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J40/4dXd9d/Vg1gU"
Content-Disposition: inline
In-Reply-To: <480a1eaa-c090-4293-bb1c-ebddc8a4d04a@foss.st.com>
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


--J40/4dXd9d/Vg1gU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 08:53:39AM +0100, Patrice CHOTARD wrote:
>=20
>=20
> On 1/16/26 20:28, Tom Rini wrote:
> > On Fri, Jan 16, 2026 at 08:12:06PM +0100, Patrice Chotard wrote:
> >=20
> >> Add bootph-all property in ltdc node in stm32mp257f-ev1-u-boot.dtsi
> >> to fix the following issue :
> >>
> >> Video device 'display-controller@48010000' cannot allocate frame buffer
> >> memory - ensure the device is set up beforen
> >> stm32_rifsc bus@42080000: display-controller@48010000 failed to bind on
> >> bus (-28)
> >> stm32_rifsc bus@42080000: Some child failed to bind (-28)
> >> initcall_run_r(): initcall initr_dm() failed
> >> ERROR ### Please RESET the board ###
> >>
> >> Fixes: 29ab19c2bead ("Subtree merge tag 'v6.18-dts' of dts repo [1] in=
to dts/upstream")
> >>
> >> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> >> ---
> >>  arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi b/arch/arm/dts/s=
tm32mp257f-ev1-u-boot.dtsi
> >> index b70cd8b52ce..c3c9c94f165 100644
> >> --- a/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
> >> +++ b/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
> >> @@ -52,6 +52,10 @@
> >>  	};
> >>  };
> >> =20
> >> +&ltdc {
> >> +	bootph-all;
> >> +};
> >> +
> >>  &usart2 {
> >>  	bootph-all;
> >>  };
> >>
> >=20
> > Are you upstreaming these? Thanks.
> >=20
> Hi Tom
>=20
> I didn't get your point. Is there a problem ?
> Yes of course i'm upstreaming this.

I see how I was unclear, sorry. Are you submitting these to the Linux
kernel so they can be removed from our tree? Those are valid for the
upstream dts itself.

--=20
Tom

--J40/4dXd9d/Vg1gU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW5cGAAKCRAr4qD1Cr/k
CudpAP42i8bTghQnM4xcaNe8Vwovya2XMzn0BsEGrRxz7VJGnAD/aceTNKptJdkz
qYBtnnLioJX/QEc7xau5YnHerqY1hAo=
=6O+3
-----END PGP SIGNATURE-----

--J40/4dXd9d/Vg1gU--
