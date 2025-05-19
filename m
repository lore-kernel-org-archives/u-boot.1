Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89505C3ABD8
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 15:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2624581FFC;
	Mon, 19 May 2025 17:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o5MTlRNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D9B082B81; Mon, 19 May 2025 17:00:19 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 008E681FEE
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 17:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72ecc30903cso2773915a34.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 08:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747666816; x=1748271616; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BfVZS8/JgJRndwd+drjpyX8cotHG3S4zl6j28VJfY5o=;
 b=o5MTlRNkEu2VsmAeUMWcQRdcaZlKB/PntC/2kOb37uNn3JjjFAcRfVgMgepzAV4L5O
 k3F3mCxgawTe4VU3ovIQ/mtegPJs1HlrBvR3iqSlyw8QV3FLyS8h2fMlZyG17+x5z3LN
 QWjJZl/i+l5144fDyYpSfe0L8w7TJkfSVLvJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747666816; x=1748271616;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfVZS8/JgJRndwd+drjpyX8cotHG3S4zl6j28VJfY5o=;
 b=SRyhOhPxruJrBjY2Am+lI06pjdbd7ZUbSF1QikH85QpDQuuT9+/rKegC+HP0oh8q7D
 uE0F+Mwf6XISLLTdmxCaHqUfOANKPkYXiGTe3LjhO9sy59m3GQ5zQov5+10G+ZJU9cgg
 voTgEGnKBEYt2dKsJQSQfYr2XImM2Me+Uyp9aMgrjbPXnqPBSdxc7YXT9Sx4Ns44c0/w
 6aZYKOJCpO3bI1LntphDN9QKgjZfyz4N7pKgnEiToBTzCD4hPrmxap2USHvxjXFmoIRX
 kRFfW6RTBo8c3qwmPMstRwyN+SuM8LMhB9njnlWvggvug7dLGRmZmtAIyNaFSieOgqpb
 OmEg==
X-Gm-Message-State: AOJu0YyypAE1cDVJR9kMcRVrWVpOc54lYBN61kTQZ9q/+iMRkTjy/mJS
 FuqAwA5mZYdDsYYUhqnlhWmtY5NoNQW/vYiOpnm1FV9yug0csZ0OlrSGw8R1JnSqYISGAUgZidl
 pdg9N
X-Gm-Gg: ASbGnctQC6eu8ET7u2GKm3KNSmZ6Wm4Wr+3X2bH+KMhVVdHs4sxu3K92Ns3wWHj0CzX
 V0nM51W18X3MsJwPcI/CFofc3GSxjMDow/Ewlcn1EmrlJCyVtxjhbTaQH7onmbCQW6ItqAmTVRz
 SFDVF4MJzrmU7h++l4pTbZCrIPUzY1u3/OBUkLHJz1GkjfymYjLsuKb1dUbXuLjU0oRN1C3LAg+
 YXqtjn5mqNx+chZ3LqY8AHzn2YmS0p/UNhGAianSNb6FmRdAe0fgcZkKHE8zTXFW2LINNv32Un2
 KhR5rijLA0Euj+wcqpHs9fWarEAmeEYE0KsGl68zqODsTNgy3EEuVdbIV2Fxe7KnFIVdWYWaB3R
 e6HlttDaLvgOM
X-Google-Smtp-Source: AGHT+IHHXIvP9jT15BW4luTsHRVCJD3LboryK8ueHHp/6Y1r9hv2BW98ILQSx842y0Z1wq+O2Id9BQ==
X-Received: by 2002:a05:6808:2288:b0:3fb:57ca:1ea7 with SMTP id
 5614622812f47-404d88873d0mr7550025b6e.36.1747666815540; 
 Mon, 19 May 2025 08:00:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404db60dbd1sm1277869b6e.13.2025.05.19.08.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 08:00:14 -0700 (PDT)
Date: Mon, 19 May 2025 09:00:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] [RFC]: dtc: Add Kconfig option to pad device tree blob
Message-ID: <20250519150012.GQ100073@bill-the-cat>
References: <20250502183826.859174-1-eric.schikschneit@novatechautomation.com>
 <20250516162825.GA2939351@bill-the-cat>
 <SJ2PR07MB97112B1C40CEB525086F92FF819CA@SJ2PR07MB9711.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="afYVxIfMxvP9UoUw"
Content-Disposition: inline
In-Reply-To: <SJ2PR07MB97112B1C40CEB525086F92FF819CA@SJ2PR07MB9711.namprd07.prod.outlook.com>
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


--afYVxIfMxvP9UoUw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 02:58:38PM +0000, Eric Schikschneit wrote:

> Hello Tom, I have made the changes as discussed and rebased on master. Yo=
u can find the latest version of my commit here:
>=20
> https://github.com/emz229/u-boot/commit/739fe94e1f8096a90241f5a9348f3dcce=
4eb97c1
>=20
> With your approval I can issue a PR.

Looks good, thanks. Please email the patch like the last one.

--=20
Tom

--afYVxIfMxvP9UoUw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgrR3gACgkQFHw5/5Y0
tyzZRgv/f5SVBdhNCvIbEdtHmfz0jyOJNp9cpNO16ijf/HGNfb3BO7KXkMHmaQKj
1cHlf9NLGs0+D3G6QKazODM3nLqINwjuFZakzypq3QktFB10ElF8EkAo1RjnHeq7
vfOTP/vz/AArzh8DCGEepq/VQnqOFupu4G/jL0HIkNKByoQ58i054LIPTmYgp2rP
FCrrPLyLcKvSKXBqZ05VzUmaOs3c0Wg/beL8wZlRbisNgWTVcZcmxQWuCVYHzRVc
nY/Ww99j2FF0Q8CxzFv3Jabg7xltkH55LlECubIUJ8LRHC2St7G/ZVnULsbvEtr/
oruGDYrYBdASB2ck/zz+/omhgtt7TgTBTLC5CjsAcpxVvAFyiCtoC2tNX8BwptlG
BBLLdY7ys+oIZ87podsrV7v/ZlU9D3SGZD6H3IWPqm+8U5oQEPiPxe7A7z5lNoXT
PXsNDFp5cPvlh+N9qTwfX9Um6WBQpf9xcykRES1EdgcXK+AlwXxPXSRsehhVY3Ao
+0Jf8nyF
=hiDL
-----END PGP SIGNATURE-----

--afYVxIfMxvP9UoUw--
