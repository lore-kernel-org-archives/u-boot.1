Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15227C54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 17:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5377E87F73;
	Thu,  7 Mar 2024 18:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t7/7WMvO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 153B087F87; Thu,  7 Mar 2024 18:13:10 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5AAB87F6F
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 18:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-68f9c01a148so4275576d6.3
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 09:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709831580; x=1710436380; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zIwEsDSzprTnmhcD44SYX3s037+TyRQZb5U6qva9Wrg=;
 b=t7/7WMvOiJ0lg1Fdxv37PXVSdkDVwgVeXK2WtIa0HF5xgty572FJAIrxqPVXMA3/GI
 Utm+oR5a2Xru3qeKPj7hmlQ4/WslYB/nrvWKPXgrHrbFNEGhYo1w2TRJ8P/jAexGGL4e
 J5Sy9nlcZ7xm8Gg69swHHwubiXfwJprQlixUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709831580; x=1710436380;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zIwEsDSzprTnmhcD44SYX3s037+TyRQZb5U6qva9Wrg=;
 b=MJuK12Mt4KH1dyqdLMPopkUIlrsSTWBseU/M2FlXC7i33dZTKBwsQB8tVOTXacFF5u
 vgBCMpiANzwn8k4zTrKeFV/SzjVzG0qSXrd9+z7BjYp9vHEnpI0wzigor0U2bIcac2Mb
 m4gXqPTtBZk+mo/CBmiOWvQw5mAr7t0qL7sL0svD9uqdv2X7jI/HynELzE227KV18J+L
 gpo2AbX4nLdbssYjVEpjamjxJVZBRgB6LTxYKNu49ySlK3TH1eFZxGASr4mK6E49HZFR
 WxC7RFutKs2GYz0dikyDwlOnI59mnBwZyXKb9lIXIupga9p34KYSsD1u44+FZXFa8HLP
 Qt1A==
X-Gm-Message-State: AOJu0Ywoz7k139UBmdjuMF/Ep2eeDoHkF+Nk2kXNS7gKOqbrfBlAybKy
 YVoZ2FYRFhkXV5sKpXjU1vkyHz4qeHrdbSAqi3nAjpAlD0VVVIuPVYsa7fbmVWQMkbgEaAgg49C
 b
X-Google-Smtp-Source: AGHT+IFRrC+w0HBNFemMss003N9khJiV/IYFr3Rt6kBRp302ZQ3bJgX29wzZRkD5/rPmBkKn3LQQMA==
X-Received: by 2002:a05:6214:180e:b0:690:a649:73b0 with SMTP id
 o14-20020a056214180e00b00690a64973b0mr1682752qvw.12.1709831550576; 
 Thu, 07 Mar 2024 09:12:30 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 y16-20020a0cd990000000b0068f54a37babsm8865255qvj.129.2024.03.07.09.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 09:12:30 -0800 (PST)
Date: Thu, 7 Mar 2024 12:12:28 -0500
From: Tom Rini <trini@konsulko.com>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] autoboot: Add check for result of malloc_cache_aligned()
Message-ID: <20240307171228.GN1523872@bill-the-cat>
References: <20240229223211.22489-1-maks.mishinFZ@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="STqIs9SdhWSc5oDD"
Content-Disposition: inline
In-Reply-To: <20240229223211.22489-1-maks.mishinFZ@gmail.com>
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


--STqIs9SdhWSc5oDD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 01:32:11AM +0300, Maks Mishin wrote:

> Return value of a function 'malloc_cache_aligned'
> is dereferenced at autoboot.c:207 without checking for NULL,
> but it is usually checked for this function.
>=20
> Found by RASU JSC.
>=20
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--STqIs9SdhWSc5oDD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXp9XwACgkQFHw5/5Y0
tyzrXQwAmnHCQ8acG/ZRBptoQ3crh9lT8Ut0atSemQiYmGVzyr5lLkAe4VSiVDc4
iRkAdGaHEKbud/WnMkesBPpPrIzXCaWLCLHdacwNnSKa8VJ7QxrVv8kH7oc+2XLK
K0Wmjj9IGqg3Z5/ot9wxb92vEui/IcGCA6DyMSrgbeQNkVwB80FlfXm+6RGxIBEf
Gj3vZqdSdMu2LR+vFn6GNyXmHSs26vmRyoniAyFP4cv8z0RffRjGtbG/40a91/cR
izzOec+PS797HtDPdnqCIVsPgkk5l3NPW62l3DVjro2jfoU/yqRrTLin/JNhaxfK
KeQFfvCGPDWBVejDSaZqGIwNk5bzAE2+yjSJN/c6gN1QPQH0tcFFijnhMAZ3jmbO
9GPXQMICg+Sr0/To6xVgDbdIiTKZYUe4CaKphmcYIUdUT+2dMDtLIE+X3t+VU9cQ
Zs03AKBxmy0eiMvDOafxhuOJQoOVDvd0n0BUmnRx2v8JZw2iuTRU+5YAFY85quA7
lQwWvCzB
=NoDu
-----END PGP SIGNATURE-----

--STqIs9SdhWSc5oDD--
