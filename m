Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC89606AB39
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EBc7n4VF;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=giVRJVkC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE5DA8132E;
	Wed,  4 Nov 2026 19:21:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UW6XpkMDMpbL; Wed,  4 Nov 2026 19:21:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0DAD081332
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793820088;
	b=UhsuVRKAYyVUExEj4+7qGAXaofSw510dI4m7ueoawz3/7RWkvV4fjtN9nr+cxa34PpHA
	 j0l8aV18l5n3o01Kcp7lgQr+pd3Dt6G6wixkFrW4lGoqNwX+FgsfFRTow2Botel3HD8cE
	 wt0S3dFaLhuRiuMSsi6l3mnmWimA6fmK4Zm/pZEcJH5gha8otbgnsJl42ugZyi5A1Mkia
	 pb4Oplwa1mcXawurP+1cQHybI40SY8cwYjmGjjodPyta0B5RtARqiBjyBVUPWuIycTdsh
	 hgqo96J9M5oKaKhn0zKpQEDYkpyGlaP0jOArzKtJcJBfuIv3qQQPjS9JKjoPG0IIYrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793820088;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0CX4EJl1oCJ5FrwBRAWuBSn8TOP2Ki31KySlh6ms5Q8=;
	b=UippU6cs4kiOhiFAtPIb6C/i8Dtp5hIRJPinPZmb3Fx5VJHNDWwg55+AF2NbjvZPy7FX
	 U6HTnPhorgTNLmaoqIPhYNqPEunOODxE06JS4s2mKj6MPArsjc0k7wL0FEEj9ZELC7Txf
	 dkeepDQquxwe7diTQNugrrX5U/NHChC2yvXG/Ts8RqkjxM1gs6Ol3ovYzKvKk8rfgvrDd
	 cmVXoR19HGF/Gz5BRnWTrpDmpD2rKX//a6iWkxDxPYba9uI8x+H9fvLHe7kBExu2yLpqA
	 ZS5PRVYLmHCHHWzdVWF7lWZvV2zJ/X98QkBfut/u5LtX7/xzgOO1Q8IjOl82fZs6rfg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=giVRJVkC;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793820088;
	bh=0CX4EJl1oCJ5FrwBRAWuBSn8TOP2Ki31KySlh6ms5Q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EBc7n4VFHHmc0tJal9MbtDBhLRnWCbGaQeHhUFEhyF9rZtTAd3aKFSrG/4at8JdEa
	 655pk+Y7+A2V12DoqM8hcmVj8Xai/SkF/IazX5SHyl7FIRBrWghCVjQgSq/yQPuLF+
	 IpMkUQT45fNH8pjQr+f1VvGX+d/1nf00Kc3AyzE+Tz0qJgDPkilii0WpzNr/7Z8DHM
	 McINdjkD6cYn4V3FBTjuw1LG5z4vN8PbzHVEFxj6mVq+BG8z0f2uxWjol2UqZLn3fk
	 O69RpKILz3cn7oYLsdBCHS3xbtGuPfm77GtqJoCWKw1m/snwP03shGMBybSmggwCQV
	 plEgRr+9TwBNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DAD081332;
	Wed,  4 Nov 2026 19:21:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C1511779
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:21:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 817B781331
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:21:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kREjXjW26IKo for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 19:21:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D442E8132E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=giVRJVkC
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D442E8132E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:21:22 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6ddef424972so849237eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 11:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793820082; x=1794424882;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0CX4EJl1oCJ5FrwBRAWuBSn8TOP2Ki31KySlh6ms5Q8=;
 b=giVRJVkCrDor3sSC9kV51bepzBucFaxcd6tRPPCXuozNvfCNfE3R05EF0YhBy+t6T8
 VMSX4im10c0XrIVczgc+tY920r7jC75FLLUqv6txwUxT+eeX4DVEgT7DDhszJn5jB/es
 zRBdi0/c8scwMQRnENOJrqZfa7+wqE0W6WR7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793820082; x=1794424882;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0CX4EJl1oCJ5FrwBRAWuBSn8TOP2Ki31KySlh6ms5Q8=;
 b=1wqkJ2ZybcLdTen8tNpibTd6Zq6POuHojpL8QfAkGcESyB1JWiu+s/r2DjeFDW/Bjd
 b+LwhakUMkg/EADs3xPvLFzKK8dSAtG2rgydT4LyP9HCDXo+KhjAft2CboggYR6W5W5c
 JxPaUQHJd9+CMmH67KZyOYtnEYYlscSeqt8q+Feos6MWG1B+S65esXd51YBl8R/bbQ1F
 ckm9fyAQqIiNs2lIFoK+Zp5vXxvpAJSNL8lT6Jl02XEWb41Z04xZFSglPABXGGU8F7+9
 91JwN9skds9qh/FqmxyObfhxoRZPNj34y55r6+cviLhqgTb+Elp7EH98gEWrls+kEkgc
 2KHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxrxkUoKt4NXI/13nlK8zN/23G6HwRLTQxvquybj/a6R+iuBYCqP1iUdmdob0b0QhOD1V7nwQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8esa8NyC1+WO5GZaF2vWC4H3p2cGnzdC0toHMuFL/dFJ0+29IM
 1hTLuFYGL6RZc/tKF9LQ+BNIXYlGXB57obf4hKfPkTg7BCJTAt59FuvHdPdNPiRpVGE=
X-Gm-Gg: AYBFou2RZsb0PqT3p/AEyLXBWUaruQ0XLpF927CHZdl5yBPPAiTl2U7xCu21LyXMUKC
 bXa/6pIdGz6o2OgAIqE8jpHhQ64Rb91aG0FUzeYaslB/qyEEc2avvYXFxlPrIJElVSKlype4W6u
 3jV/RmRYJkk/0WkTXRlwFnqCtPEimS1FC3q9UWw7CxLdrsC3NSJKZzHYh0DuvU2GlYhy+z0P80A
 t/iqzb7UeJuObT5BaiqQy9TS/A06jHM1CdEx5Sp3dEpO+okqpDRKwFPmkxhVi4UsAZ7/x5opjpf
 ThhG6Kz1Xx+tkrYJwkbv3CRC2X4WgMznxwvoJ2qTmOKAn5J7RoCv4WwXUcvc1M6K3U9nAuGtu+1
 FYofk1rkg1x8wMl91kYxXUzioOn8E0Azg+QWpJfn5Tj9QBIS8hVLhTIwxli9d5e1m7WFI0PFwtP
 pGH5Jwf5Z72r4BDwnGEgxsGXhhMO2f74rnT9asX/hbF74Wxgsg9iC5COS3c0RBOGoak5jxkJfYc
 2Lgs4jnn0UXj3S8e0Bgz9XBP/+Urfg6wRL/YklLQPe5Jz34DQE8COVIBJyF3p20xj5wnvHuRHjw
 DmRyi1zrbMiVtClp7nK67VnsExMyMfSOkcPNjPtQjpS2t7GTPVTPa3BmVX8HVES64CmpjLn22Q9
 x2iky6eEERQPmRSSWTYGSeruf+Lo1nlEl7VKq9oR8qNHrv8tRAKZA+M92mydyzojf2y8QJrKctb
 DTnA7rcuHauRajSMSG7yhDR+UMjOL0+w==
X-Received: by 2002:a05:6820:615:b0:715:21d1:b81 with SMTP id
 006d021491bc7-71521d11e6cmr5578258eaf.80.1793820081548; 
 Wed, 04 Nov 2026 11:21:21 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c134ff86sm2377383eaf.14.2026.11.04.11.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:21:21 -0800 (PST)
Date: Wed, 4 Nov 2026 13:21:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Yannick Fertre <yannick.fertre@foss.st.com>, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 00/33] Add Engicam MicroGEA-STM32MP257D-RMM board support
Message-ID: <20261104192118.GD1164024@bill-the-cat>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LWRgSC9JM4MRZ/io"
Content-Disposition: inline
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--LWRgSC9JM4MRZ/io
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 09:49:33AM +0100, Dario Binacchi wrote:

> This series adds support for the Engicam MicroGEA-STM32MP257D-RMM
> board, with its RGB and LVDS displays and the FWU A/B update.
>=20
> The first patches pick the board devicetrees, merged for Linux v7.4,
> from devicetree-rebasing. They can be dropped if dts/upstream is synced
> with v7.4-dts first. Then come the fixes, the refactors moving the
> STM32MP2 environment and FWU support to the SoC code, and the board
> support.

What's the status on upstreaming all of the changes you're putting in
the -u-boot.dtsi files? Thanks.

--=20
Tom

--LWRgSC9JM4MRZ/io
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauuFrgAKCRAr4qD1Cr/k
CnTJAQDEDVBVctOHaGHFFu2hTvHhUvdE7MUV4eHV2rc7yQ2SLQD+MtxM1sbfq/6P
jX4xVOaIGSCLjJj5ui6qoR4SgzIIWgM=
=w7V0
-----END PGP SIGNATURE-----

--LWRgSC9JM4MRZ/io--
