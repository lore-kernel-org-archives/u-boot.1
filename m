Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646B4C47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B508987CFE;
	Fri, 19 Jan 2024 17:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z49pue+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84A2987CFE; Fri, 19 Jan 2024 17:08:23 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2425A87CF0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:08:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5ebca94cf74so9411847b3.0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680500; x=1706285300; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OxhPnPq1T2HGQpxeG0pzbV/VasuZ89B3QedqqfjkjvM=;
 b=Z49pue+WhqWYSeOffhcTum0Wu7TVs/2ALGRhxIASM3I3JJRbPkAFR4j545Dm8gjmGs
 +X7rUQGjfbsRmrZnce590f9TrweBpCIMVp2tXWTxTt4yfsrmaZ+AOdFiLYHqJpt9xFiK
 tA4JDrxt3RgBWf60C/rLplLKwcZBRNjkJES0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680500; x=1706285300;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OxhPnPq1T2HGQpxeG0pzbV/VasuZ89B3QedqqfjkjvM=;
 b=RFfiGiA2UmNbO4Nx/qJ4xWKGr6T6gJaSBgovl3/AReQ6nqYhbl/4h23QDLJbUIEwU8
 HUMecMcmR9iXTTJ+E+GqYqFHIVKUHdRhflUI9WB4E7YcwCaaKmwKWpEHZc3WN6rwHEmG
 L4pkoflj6CeQlm/S/OszggAciT8jZBJIvvYSLdcpFvpX3otw2ethmcR/nl4e6Ltsf4Ab
 nT0cp1kAp8CD1diAPnPd8UmNz4UGPa80unYx7beOz+mFFnNIcC4QeIY5yB3ryg+e95vZ
 qh29GoF6leRhze923K08DbCtoiWGA052D9CuCFrCjXsmr+ru8ynhPEkwe3k2i43kGCHe
 71xg==
X-Gm-Message-State: AOJu0Yw9+KHIWEtscPn7qsWrAXjETBPCJEAecgrnb9hdv3VPvfqmkS/y
 DKaZBhTUQBAVNSPBHhRzzy5rmuWO0nDtKh4vg3EdWdIrFrqA+cbF/twiOkWSpHmjUxvCVdcu7TE
 R
X-Google-Smtp-Source: AGHT+IGdYjmyfPhIcoL4IWnXlFtZzWLHLgXyi416kxOYhl3bcN4zjzFXnjbb5miFHfZHeiTnrel+yg==
X-Received: by 2002:a0d:dd84:0:b0:5ff:9676:3658 with SMTP id
 g126-20020a0ddd84000000b005ff96763658mr116524ywe.48.1705680499833; 
 Fri, 19 Jan 2024 08:08:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 s9-20020a819b09000000b005ff81bbfd66sm1588271ywg.136.2024.01.19.08.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:08:19 -0800 (PST)
Date: Fri, 19 Jan 2024 11:08:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20240119
Message-ID: <20240119160817.GK12635@bill-the-cat>
References: <20240119082023.552165-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TUXEMJmqUFC4DFeV"
Content-Disposition: inline
In-Reply-To: <20240119082023.552165-1-kever.yang@rock-chips.com>
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


--TUXEMJmqUFC4DFeV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 04:20:23PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the updates for rockchip platform:
> - Add board: rk3328 FriendlyARM NanoPi R2C Plus, rk3588 Turing RK1 SoM;
> - Enable SPI boot for rk3588 and rk3528;
> - Set boot device in SPL as common code;
> - other misc fixes;
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/19374
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit f7cca7ccc5117eaafcc2bde91ad1bed6fee7cf=
c3:
>=20
>   Revert "test: hush: dollar: fix bugous behavior" (2024-01-18 11:38:25 -=
0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20240119
>=20
> for you to fetch changes up to c16c7ac2fe69f3cebbfc921c5b023dccc12cd198:
>=20
>   rockchip: rk3128: remove noop file (2024-01-19 10:57:36 +0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--TUXEMJmqUFC4DFeV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnm4ACgkQFHw5/5Y0
tyzDCwv+PgVg/sK134hoWUCOhQF5/rW3zpW12IqMCO8TF2eu5GMjfsVZ493ncYcV
aqbMDGe9AfPtb+8Gh83SPqJpRGQYHaOtnuqZfyNGMMeKRYE7Oj8N61weXNvgf3ks
Lfbrknqb2+SoazrmQPmJyuI9+PfcmfchVBg+iEABnHmb+NocHKnOsu0U6GMcVWSw
RZdadgdYFB6Eb2PUH6R0JmTEJZUluiYExDNQ3MA27v6tRLMxSYWbsys3rWZR4E++
ezRtic5YxgtAzIwiPAoQ1gJ+cHxCE3ud2SrHzb5f3xjRNRYD7T9yICbZTXqfJ2RV
QGKUhC91U6uDX++mQtyFYPVrBTaf6gcjwsakrqfoqASZKyss41L298M3/IMOyzmd
pnsRnZbNoGgJC3065BvxsqD26h6oUn3+iKTbfYNjj4ExFXnsqYul9zUXngUyDvop
iVw/UXgO/qJAuXcqpP3aQgMggPc8u0gXl5u3p5Dk3xops+p4ElrxtIA5AJaVeltt
Xmsnawzs
=w3ED
-----END PGP SIGNATURE-----

--TUXEMJmqUFC4DFeV--
