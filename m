Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AB8D29C40
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 16:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CF028397A;
	Mon, 19 Jan 2026 17:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KcqesVab";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAF31839D5; Mon, 19 Jan 2026 17:31:05 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DC7F8003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 17:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7cfcb5b1e2fso2865121a34.3
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 08:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768840262; x=1769445062; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MSsq6ZXdXwZ+OyRTp3Kvb9YQCj919Pvajln/SPZIPc4=;
 b=KcqesVabL2auWeqUpLauPHKs0Nyv+RGUQRnStjZ2AdWt597iQrw+g7i2UA0xxOt+r4
 f5/FOwlaf/W4Wa+VTlyPVtTAEnI6cXou9Uv58j5BhYhYzILjrSSpLbjVO5ptLMFsJ68c
 akDdffSORNQHe8sfsx3WTjmr5wELcVwDJAEcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768840262; x=1769445062;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MSsq6ZXdXwZ+OyRTp3Kvb9YQCj919Pvajln/SPZIPc4=;
 b=QnVSxMpgWIFL6iLrpUywHiE6FRhJHyrzQzyj8kBIUF897aKAeXlyVoJWyH7Xn0bY+t
 PY8CZpALiS6VdJy/6FBsBag+Xb0WZ4Sie+rFRnL949Qa/6zdGlfpvV/pysNdifIT6x6f
 zzG9eY29ZHH6c45DTxnzp+EeHe0XqeQIeUP3CmkrfL2VLdF6eJfaSzswtVASl16JMifr
 WtN9ruWeZ4QqPbxkJzvqw1pgyzUEkn20rRJ3jgh2CeTihF1IqDIxauj9gNbuC6CBhuut
 N9gqSQ8T2tmTEWzYnH5FUbgcWnBpJv/QLA24O35we3bwtSgiDa+dJQCgYvgGIC7L3PGl
 eEeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjO8qpeb8+R5fVNoVLpHZzfj7eQfoxsLxUE8UbnrU8iROurAE5Pb/iVRujrpMkvtbk1nvV4uk=@lists.denx.de
X-Gm-Message-State: AOJu0YzHBG6/7mKao5Kv09fjg1yW1XLOO6Ae+haCpBrFK0IW/Cs+pUpe
 1DiKPoJKGGhNDZtGBDdpBdzgkyuvx67Ry0zmv2+7HSYvzYZVkYEDZwOJbCWvF3mW//S50+TLImT
 JPB2P/yU=
X-Gm-Gg: AY/fxX4FJ+fA0qE/lZP0wVe9CUB29ta9psB9uNwdD8knurAam1p+Zmf3eN7og+Px3OW
 vPVTKTjdzZ/aI9ZB7d3Vyn9TBjHYnV2v+YbW+6uzMV4dXxGfC72R2wjLBL+7W8ylDD+DOmtoQfB
 Y0VabcUU60q+PEQmimipFjvX7PAsdwI554hU1dWmiKVTiWEOWQ1kqpR15EN9ngN59FuW6BPU4gW
 xOZuzMljb6OTWBFoxIxgJmcAJQ5hOrEplOiBlSc0yInO7kgpWcpXKacSX6MfRgJCuMFDbz5JmK/
 YlSgb0BBevQ2X1cZDZKnjaneSPQtZEce5MJNg+f8a3Vibi4GBd4riYWR3sWucjNyL9sOWFoelHV
 RvDk6Hb+YlzqR2fWKqtNjYYCOGFMR5Bl9fwa0SgTljQCdGAWkRAzgvM1aatv+xKFcCtdzFmp2lf
 vcQM3Kt+San5HqtT5tpxwbzHPzuxvdA2mCd59DAO6z9DmNbQ79T/RgPl8mQBkWq5NN8yiPBeW60
 +8/0nV4gI/WAwtBpWPqKBVyVwJQrSHFQ1Mjqi8=
X-Received: by 2002:a05:6808:148a:b0:44f:8c46:a2c2 with SMTP id
 5614622812f47-45c9d8f8c87mr4939043b6e.57.1768840261682; 
 Mon, 19 Jan 2026 08:31:01 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9e03e817sm5701466b6e.16.2026.01.19.08.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 08:31:01 -0800 (PST)
Date: Mon, 19 Jan 2026 10:30:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [Uboot-stm32] [PATCH] ARM: dts: stm32: Add bootph-all in ltdc
 node in stm32mp257f-ev1-u-boot
Message-ID: <20260119163059.GZ3416603@bill-the-cat>
References: <20260116-add_bootph_all_for_ltdc-v1-1-de4dc0ae1115@foss.st.com>
 <20260116192837.GO3416603@bill-the-cat>
 <480a1eaa-c090-4293-bb1c-ebddc8a4d04a@foss.st.com>
 <a64676b0-c67c-4fa8-a399-905fc04a471e@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bgP9V3DKxHQcpZAw"
Content-Disposition: inline
In-Reply-To: <a64676b0-c67c-4fa8-a399-905fc04a471e@foss.st.com>
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


--bgP9V3DKxHQcpZAw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 02:07:03PM +0100, Patrice CHOTARD wrote:
>=20
>=20
> On 1/19/26 08:53, Patrice CHOTARD wrote:
> >=20
> >=20
> > On 1/16/26 20:28, Tom Rini wrote:
> >> On Fri, Jan 16, 2026 at 08:12:06PM +0100, Patrice Chotard wrote:
> >>
> >>> Add bootph-all property in ltdc node in stm32mp257f-ev1-u-boot.dtsi
> >>> to fix the following issue :
> >>>
> >>> Video device 'display-controller@48010000' cannot allocate frame buff=
er
> >>> memory - ensure the device is set up beforen
> >>> stm32_rifsc bus@42080000: display-controller@48010000 failed to bind =
on
> >>> bus (-28)
> >>> stm32_rifsc bus@42080000: Some child failed to bind (-28)
> >>> initcall_run_r(): initcall initr_dm() failed
> >>> ERROR ### Please RESET the board ###
> >>>
> >>> Fixes: 29ab19c2bead ("Subtree merge tag 'v6.18-dts' of dts repo [1] i=
nto dts/upstream")
> >>>
> >>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> >>> ---
> >>>  arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi b/arch/arm/dts/=
stm32mp257f-ev1-u-boot.dtsi
> >>> index b70cd8b52ce..c3c9c94f165 100644
> >>> --- a/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
> >>> +++ b/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
> >>> @@ -52,6 +52,10 @@
> >>>  	};
> >>>  };
> >>> =20
> >>> +&ltdc {
> >>> +	bootph-all;
> >>> +};
> >>> +
> >>>  &usart2 {
> >>>  	bootph-all;
> >>>  };
> >>>
> >>
> >> Are you upstreaming these? Thanks.
> >>
> > Hi Tom
> >=20
> > I didn't get your point. Is there a problem ?
> > Yes of course i'm upstreaming this.
>=20
> I think i understood your remark, currently without this patch the board =
stm32mp257f-ev1 can't boot.
> I temporarily added the bootph-all in stm32mp257f-ev1-u-boot.dtsi to allo=
w this board to reach at least
> the U-Boot console.
>=20
> In kernel side, i submitted a series which add u-boot bootph-all property=
 for STM32 boards which is not already merged [1].
> When this kernel series will be merged and U-Boot will be synchonized wit=
h this kernel DT, i will then revert this patch.
>=20
> [1] https://lore.kernel.org/linux-arm-kernel/20260109-upstream_uboot_prop=
erties-v4-0-75e06657c600@foss.st.com/

Ah, yes, that was my question, thanks!

--=20
Tom

--bgP9V3DKxHQcpZAw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW5cQgAKCRAr4qD1Cr/k
CtuKAP9v/p4OfKRKuxVsnZqjeYaI8umvME94codQE1EsFAakGwEA8zeXiVXsIXL+
vNWQHJ8JCX5iGnoFDSjgT+fdpQi+mAo=
=rXon
-----END PGP SIGNATURE-----

--bgP9V3DKxHQcpZAw--
