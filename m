Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30F7EFB7E3
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 02:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 116C382BF2;
	Tue, 24 Feb 2026 03:00:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cV6ocr14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 641FB83642; Tue, 24 Feb 2026 03:00:19 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F5A98063E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 03:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7d513bc15c7so3608659a34.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771898414; x=1772503214; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4+EfYQxTrD+qH/L1nl35Ec94fyBwJp/mQFeTpTQdQvI=;
 b=cV6ocr14UuTx/om3EQND37LMbFyCo7EonkgzvXFEpW4wUAINXj/M1fwxq+xpNsCya6
 G/cCSfagl0o6FOA2oF51x+SuCk/U1ntwDqZf8einUSZCWNuzU6YvMLq1ixgHzuShAHiY
 Qcx8hIOZ3IVdFLHkS2v/eeZGuaTP9m7rruCXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771898414; x=1772503214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+EfYQxTrD+qH/L1nl35Ec94fyBwJp/mQFeTpTQdQvI=;
 b=invZA/n3/9JZ5KBtvvtUS4fpLCV6YQ9MLZnmwVgG8R3Cl94FBX9iSohRzCDGIOiYpo
 mPCNRGwGCwztR7NYtQHuqnV+KeelHN8hIRZ+NwImodoiVky+AXP8XnU+OdUvm0trQ8/a
 8/SHfofwjYzmkQBOiksNENdnkJeMtXI5qY4ZMlMCQCWnBVPGh7OwsqPjwK6z0vVg0ecJ
 RABWNHDWOiFQYNNOYeFwbUn+InwlTvol4s/ADJ4V1bkDvVo9WiyEgQciQxGYOGJFufvs
 20EqXcndF/kQQJ4CSRge6/51NHhSiebHcguy/ZVVvHb/8rgvNBxwUSmNdcKqtBEPoK5Y
 HnSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH8Wr7GRS+9uEgV/VPsguAKdzF5qAahHJwqPvQPS9BJefcFj7rAo0FbQyzgTJmYB5aDq2KxOo=@lists.denx.de
X-Gm-Message-State: AOJu0YyXNctbuSWsvJ0dof7FScDfJRc9nBGp/d/HYtkohZKO0ZNIG+9V
 fi2V73C0PrIhtMH5v1xqEPJ8jrPBAHOOrkfMTZOyEOVG6CLekzcyKYJwjZL8pVovVmU=
X-Gm-Gg: AZuq6aIUHsOcwtkytU+zDGrEwVfESdbhPXsS5rZRCxUWcYsSCN4H3dlaj8ltBeuXqHE
 II3F3GZUWxDVszXdC/fSwb1JvmrPRYo4n1Xiy5AjW2iteuzXqmFU6wKu/V6oolnqNHjus75v+l2
 UlPB2AbVBfNowoGIn0osxe4kSEKBAE6yYR1zg9LgiAm3QBtbKFmZaO8Z52nArPQgcK2QPqM6QIj
 sWqaMFoil7QGzSv8iVITKWMULpyTbmh4OKSa2g4Xn9xIOGiQGD2mcjsnHoMwl/xua3ig5NGCSZr
 zIhs5mW+ddbI8pR6DoMCYUr9uISUpl22c/xRwB96WYVJsdCIixQAywc1IGfN/fD8tej1zC2UGwG
 c13CcSPof5CGIC1S2iEGTVwBuwGpIWTUTpEbBn5zfIeESs0bL9GbokkQh9robzG6DP6j9DNAT6g
 cFPnECWqTyaO7xM4QFgxs5KU8nIEFaAgm7kl20idpzvgYedsZApfvK8yQZ/R4Cwt4R4zYL8qzdS
 bXwNylzsFp/K7TdPT/7wwq7kPu+hmhsJfXB
X-Received: by 2002:a05:6830:7315:b0:7cf:d784:5dd with SMTP id
 46e09a7af769-7d52be3f220mr7958053a34.11.1771898414372; 
 Mon, 23 Feb 2026 18:00:14 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf78503sm8665413a34.3.2026.02.23.18.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 18:00:13 -0800 (PST)
Date: Mon, 23 Feb 2026 20:00:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: vigneshr@ti.com, u-boot@lists.denx.de, a-dutta@ti.com
Subject: Re: [PATCH 2/2] arm: dts: k3-am64-evm: Add "bootph-all"
Message-ID: <20260224020011.GN3233182@bill-the-cat>
References: <20260223061906.1794872-1-s-k6@ti.com>
 <20260223061906.1794872-3-s-k6@ti.com>
 <20260223152432.GC3233182@bill-the-cat>
 <cb0c4c33-4e09-462a-9848-3bf4e0a092cc@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/RUur8ERRdA4cZfH"
Content-Disposition: inline
In-Reply-To: <cb0c4c33-4e09-462a-9848-3bf4e0a092cc@ti.com>
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


--/RUur8ERRdA4cZfH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 06:42:59AM +0530, Santhosh Kumar K wrote:
> Hello Tom,
>=20
> On 23/02/26 20:54, Tom Rini wrote:
> > On Mon, Feb 23, 2026 at 11:49:06AM +0530, Santhosh Kumar K wrote:
> > > Add 'bootph-all' for 'main-bcdma' node to pass it to the FDT in early
> > > stage to allow the BCDMA channel 0 to be allocated for OSPI NOR reads.
> > >=20
> > > Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> > > ---
> > >   arch/arm/dts/k3-am642-evm-u-boot.dtsi | 1 +
> > >   1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-=
am642-evm-u-boot.dtsi
> > > index 6469f43fca81..5048432ef8ca 100644
> > > --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> > > +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> > > @@ -42,6 +42,7 @@
> > >   	      <0x00 0x484c2000 0x00 0x2000>;
> > >   	reg-names =3D "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
> > >   		    "cfg", "tchan", "rchan";
> > > +	bootph-all;
> > >   };
> >=20
> > What's the status on upstreaming that whole node right there? Thanks.
>=20
> 'main_bcdma' node is already upstream [0] [1]
>=20
> [0] https://elixir.bootlin.com/u-boot/v2026.04-rc2/source/dts/upstream/sr=
c/arm64/ti/k3-am64-main.dtsi#L141
> [1] https://elixir.bootlin.com/u-boot/v2026.04-rc2/source/arch/arm/dts/k3=
-am642-evm-u-boot.dtsi#L34

Then we are we not upstreaming "bootph-all" and also everything else in
our local node here? Thanks.

--=20
Tom

--/RUur8ERRdA4cZfH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ0GJwAKCRAr4qD1Cr/k
Cti/AP9pZqLA/aTD2bytKMJ5ljuYviArBYOmfvz/u1rRw7v22QD/TL1/HLnMrtw+
8DU+gspQMCATD0bOsDhFp5GMhLfp5g4=
=y89P
-----END PGP SIGNATURE-----

--/RUur8ERRdA4cZfH--
