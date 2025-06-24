Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DBDC77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 13:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9320282D17;
	Tue, 24 Jun 2025 15:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ea/KqzPu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F081D82D17; Tue, 24 Jun 2025 15:55:30 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8705582C2F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 15:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2e8f7ca7ca3so2845387fac.2
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 06:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750773327; x=1751378127; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GG4kJ+mzWrZFMh9qm2l9QPYYlSdAPzF21ip8ZbADnsw=;
 b=ea/KqzPuRFqyTlEa75AV7YpIMjKWggW2lOuKSeOnLkpLgMGehQTGEMxyB/JJY5OQXm
 tOeDdVETckgZ6VKgqXXTQCquDJUpiOK+eDCysdPCSItwi2d6kEdNsB1Z+MbuTes6Ylzw
 FFHKDgaIHm3rR5qryRndsI/1QaxDQpElGAJFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750773327; x=1751378127;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GG4kJ+mzWrZFMh9qm2l9QPYYlSdAPzF21ip8ZbADnsw=;
 b=QabCzbaNKWRZkkYm4pUIXWAprZcnem3jyLCKt6hZDBfQQvdrlBGnIc3P9tT4wv3vaV
 iRmXTlzmk7yc24o7GOs19NgFTe9LDZlqwOBNxg1GBTgJ9VhlpmkR2s4IsGKMd6YlzqCX
 b3ArOAxohYVdtiWw7xNy0O5UaM69KDi3hxfNFVWPV08HPxRD9nWwjs0Xtu2SRKuUieD6
 XR6Kgu27C0W8mQv9/Vd1P5x8THz3zxOvunzL6QzuRW4BjX60SpzIGlzpxh+K4lunbO0b
 Q1ga2/aK3Fmfxl8DnxFxmepm7d7LR5rEfUamH3pB8Q6IUhRKN0y0WJ07yOYXOBvqGocs
 VtMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsOJ9wFIg3791YjCmsCWKSGkdHakTPxSegw4+ZqqdAQBy2elfyYDEb6cxsxZr5MYsgaM5CWkQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyb7q9saHbfBVT6QZLDsxS+GKM8XCjdTgUlqVTSc1zQmYfymNZo
 hAr8+R9jRFIeoOpRm0ciRI3wsVxuud9nOD0qSV5iR9u6Q27tCyC+6/XnvWpMaRjmxgw=
X-Gm-Gg: ASbGncscj6c4hwh9C2U/uhbIKP2ZZ3EAb5UMIbobxmPcnrjuqYf9UpMpb99lN2Om4RD
 05RfkcQktIa6WmtgaPW6eo6vy47OOCYhXInwiHVuZMPs2gMNM4b/0WTtVhZVP8g6m2oUGl9Ec1u
 b87knVFfZs9rOoaEOseaSSfF8FYrpvCJgT9U69mziOCOii8hJSZZ9cumodWkile5HArMfuoGnOI
 XACJVQSfhEBNFNMactGK7XTwrgDm8QC/LRJe04RGFQ+Urpcw0Li27/vnq/788WWEuTNMb8XpxRR
 WrDdZ7R3vOu6kzdgFMBhdmon+pXSizO35MAaO8OmsgYaNqUpYqmCmVMyVJyOrt6wGZMqLknWC9p
 E74cS11mSRHpuaMv54XVYpQ8=
X-Google-Smtp-Source: AGHT+IFZRYw7aK84UabY+pGNcqpC6BwSxUAhQEkKAwcp6yROYnXkEMTFLZNki8I3mqBhTnfGwnECTw==
X-Received: by 2002:a05:6870:4f0d:b0:2c2:3ae9:5b9c with SMTP id
 586e51a60fabf-2eeda51ca82mr12113221fac.2.1750773327202; 
 Tue, 24 Jun 2025 06:55:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eead8dc454sm2064871fac.42.2025.06.24.06.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 06:55:26 -0700 (PDT)
Date: Tue, 24 Jun 2025 07:55:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 George Chan <gchan9527@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot@lists.denx.de
Subject: Re: [PULL] Please pull qcom-next-23Jun-1
Message-ID: <20250624135524.GJ4003484@bill-the-cat>
References: <20250623234640.126706-1-casey.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4W68B0mISY2YM/NJ"
Content-Disposition: inline
In-Reply-To: <20250623234640.126706-1-casey.connolly@linaro.org>
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


--4W68B0mISY2YM/NJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 01:45:43AM +0200, Casey Connolly wrote:

> Hi Tom,
>=20
> sorry this one took a while, still figuring out a good cadence for
> this...
>=20
> This PR introduces 3 new platforms, two from the new Dragonwing IQx
> series (QCS615 and QCS8300) as well as the IPQ5424.
>=20
> Additionally:
>=20
> * Support for booting downstream Android boot images on some phones is ad=
ded
> * Capsule update support is expanded to be more generic, determining whic=
h partition U-Boot was flashed to automatically and supporting many more bo=
ards.
> * Minor capsule update bugs are fixed
> * A watchdog driver is added and gets timeout support
> * Autoboot now requires pressing "space" specifically to stop booting as =
a workaround for some boards getting rogue key presses which would cause au=
toboot to fail
> * Documentation is added for the Dragonwing boards
> * The RB1/2 now use USB gadget mode rather than host
> * A bug is fixed where GPIO reads could return incorrect values
>=20
> The following changes since commit dbf7fd557a73ded3141db3c2cf5c5729893788=
25:
>=20
>   Merge patch series "Consistent Kconfig environment options CONFIG_ENV_ =
prefix" (2025-06-20 12:57:47 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git tags/qco=
m-next-23Jun-1
>=20
> for you to fetch changes up to c4c08cc21448aa97328b4dac17fb54c4f657ce80:
>=20
>   doc: board/qualcomm: remove signing references from dragonwing.rst (202=
5-06-23 18:50:41 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--4W68B0mISY2YM/NJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmharkgACgkQFHw5/5Y0
tyxYSAwAqZi5T6WUyqRrhZIa81mceL7rNYjsZqeXafqJrqKcV3Sdh5iO7ULjyhf0
XC2OWBnKTzzI05ZRJggeMg+zQ+qTX9ELdRjupZsoftNSdrhuziY96F7QpYKMKDHs
j8aqg8T3HWjUsY2F+CT9N+L3X+zopqk6RNPL4spdz9uD/DGHvLp7UDoXV1yaan9K
99Z8nRjzQLskg8GkVue15wlnr1RC+2ZxNhvBE9mVtfz/WgM35OAW0UkZuLoR1dBd
873rXn3CHUixyXirJq68Dg86ENpCvcqiyyjh2rZtWbwngmTixOrfwJsz0KD5cdp/
DPNp4kkQUbjiH5IMuzG3DBv4djVJMllF9PUjnGdwbbCQ75WKGuX4G5MIiaT2PhVx
uwhn9p1kmfP5r9dtFBFqUkh08MeN14LJg95lBIH0Sv6qO1DWTyplwdXmd+5TP3VW
+Yr+rFRO9DW62owKixUKuaxEWDpjpRCNsYeIJ2rdVnROonmtaXrrnt50l2SmGhDE
TGYjSXjl
=h5Gu
-----END PGP SIGNATURE-----

--4W68B0mISY2YM/NJ--
