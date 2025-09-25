Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2464CAC5A7
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 14:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41FF382A9E;
	Thu, 25 Sep 2025 16:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TDKat/8i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D43088309D; Thu, 25 Sep 2025 16:32:15 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A48D80107
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 16:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-61bd4a3f39cso345296eaf.0
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 07:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758810732; x=1759415532; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iVEo4rRV0oJr65caBHvRHjuI8jwLs0/cC3yTyadpEpg=;
 b=TDKat/8iTgZh6jQ5gzMzl4KnGs0T17R5XuNZMLK5X/ncvm6Ir3NU+SryVgwKhrK5lO
 eHF4fDBEv9mbqfdu1xaFrJfrEpkPALAgJiMHi9/ojFgxJnJusHlE71mxwtWD5iDJ43y5
 JiPmmNxz1fdHW4KI3iyQFE9zCf4m6pZDy4S6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758810732; x=1759415532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVEo4rRV0oJr65caBHvRHjuI8jwLs0/cC3yTyadpEpg=;
 b=X8mg1FR5L8txI+ilRHsV0pPUu6mAiBlFmTueqNC1PRCnvqkBq1nKQ015juj3J76IuT
 5D1E4BcfLqoT4vpPViRSoJWzM/G0+dbSBTPpxTGUJGeOY1Lb2VNE2yomIA+OJirPYY2f
 5tUVyjfTLBVinTm8VS3LsIQL2W9r3QvEIYchFzL1xTY2w5DwMVPCQ8Ttcw9xH++Tpteb
 eaNLwPk0cguZb4oY0Gx7iodHwyGuM1iSIIDOsva8NoA3YFgh25/sPF/5bplogzHAMYc5
 zUt2MzgktWEQwo0ESHn1QGfXW3LjIsgD44pcoqRaSfXmOKu8nZgjGcWcgKMHag1vUSsv
 KF1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOAnV6ONS2EFKbsYIKagHZUiZvGcuJuNqtrCnD0w+W1ZTpCUSWSfKbLjfPJ0DVAeJq3sVxXuw=@lists.denx.de
X-Gm-Message-State: AOJu0Yxo0JceFk7+TvbRS4vCdxHrSZdADvZo7CrAatGl04DhtgGQICQ2
 keVg1eViPcI1YFJwsRratC5QnNP1pJOh2NXzR9FScs4V3Cea+bBCOpf/ge2XDznJza8=
X-Gm-Gg: ASbGncuPpg+g+XmCQ0iE43hDb4QRpGP1OUuVGdkleNsKJXUehvx7mTdpUPtU1AXHdrk
 Rm1oPDde2i4XkJStMpSkHpBTcsJuTBdCkvgWGin1C2I7C1epcYn5MfD9fMjqkJdO2sQQIqdB4LQ
 6wu34ChtRjozRfeUEbQm6qmzzLG/cD0prKn5zvbiHgDXL7sgth0icMXK6MFhSkYEvRivRFv6Cvk
 sikY3+6vvBZZVgbVdja7TsgkiptZ8CaLmq+4uzF9Mv7vWGRzLkNgq2Hj5JHuDDMHw7sZA/5LGUY
 qXcWZF1gpiAtz4x3KzqNgpiZug0rH/piwRoA+m7NE36cho1hWmiclSPRE1r/V8gAPaSLSdkJP7+
 QUIS9vkU3nBn5B/GaxzjsnGiPuIGSNBWU1MU/OMAaIogvotHQA9ru/fyk
X-Google-Smtp-Source: AGHT+IF6JBlffKlsHRhxNS+/EUxuNLjNGP/NZUTud51tHNxM6lu3xH+mNxjTbo/MCbWhbHLWLctD1w==
X-Received: by 2002:a05:6870:420f:b0:34a:63ae:4bcb with SMTP id
 586e51a60fabf-35eeb3e9a42mr1509253fac.46.1758810732115; 
 Thu, 25 Sep 2025 07:32:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-363a3d461e4sm597102fac.13.2025.09.25.07.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 07:32:11 -0700 (PDT)
Date: Thu, 25 Sep 2025 08:32:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul@pbarker.dev>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 5/6] power: regulator: tps65910: Cannot test unsigned for
 being negative
Message-ID: <20250925143209.GQ197373@bill-the-cat>
References: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
 <20250807-pwr_regulator-v1-5-42a4105336ec@linaro.org>
 <78a0767b-2508-4602-a37a-eb4e72b37120@kontron.de>
 <b44654c2-de9e-4bd6-96a8-aa338435048a@linaro.org>
 <d320ef0e-2711-4f86-9881-6aabdf6766c2@kontron.de>
 <5b5d3865-1bc0-45c5-adf8-0f63cfda47bf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jQLkTwKzxb6PoH2m"
Content-Disposition: inline
In-Reply-To: <5b5d3865-1bc0-45c5-adf8-0f63cfda47bf@linaro.org>
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


--jQLkTwKzxb6PoH2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 12:11:14PM +0100, Andrew Goodbody wrote:
> On 01/09/2025 17:58, Frieder Schrempf wrote:
> > Hi Andrew,
> >=20
> > Am 01.09.25 um 18:26 schrieb Andrew Goodbody:
> > > On 27/08/2025 08:54, Frieder Schrempf wrote:
> > > > Am 07.08.25 um 18:35 schrieb Andrew Goodbody:
> > > > > The code in tps65910_regulator.c treats the field supply in struct
> > > > > tps65910_regulator_pdata as an int and even tests the value for b=
eing
> > > > > negative so change it from a u32 to int so that the code all work=
s as
> > > > > expected.
> > > >=20
> > > > I'm not sure if this is the best solution. The supply field holds a
> > > > voltage value in uV and u32 seems like a reasonable type to use.
> > > >=20
> > > > I would argue that the driver should be changed to not use int and
> > > > remove the negative value check.
> > >=20
> > > Hi Frieder,
> > >=20
> > > I would offer the counter argument that the TPS65910 has an absolute
> > > maximum rating of 7V so any advantage of being able to use all 32 bits
> > > vs 'only' 31 bits to hold a value in uV, when 23 bits would be enough,
> > > is somewhat lost.
> > >=20
> > > As I say in the commit message all the rest of the code in this driver
> > > treats this field as an int and declares int variables to hold its va=
lue
> > > so using a u32 throughout this driver would just mean changes being m=
ade
> > > with no benefit. Removing the negative value check leaves the code op=
en
> > > to unexpected behaviour and hard to find bugs.
> > >=20
> > > More than that the field is being assigned to from the function
> > > regulator_get_value() which is in the regulator uclass and returns an
> > > int. So following your suggestion to its logical conclusion would mean
> > > changing the uclass and then that would lead to changes also being ma=
de
> > > to all other clients. This would turn into a major project which I am
> > > not very keen to take on as I do not see any benefit to it.
> > >=20
> > > So yes, simply changing one field in a struct from u32 to int does se=
em
> > > to me to be the best solution. It achieves the aim of fixing the code
> > > with the minimum of effort and I see no downside to it.
> >=20
> > Thanks for the reply. I totally missed the fact that
> > regulator_get_value() returns an int. When I was looking at the code, I
> > assumed that there are only positive values ever used.
> >=20
> > You are right. Sorry for the noise. The patch is fine.
> >=20
> > Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >=20
> > Thanks
> > Frieder
>=20
>=20
> This patch is still showing as 'Changes requested' in Patchwork but I am =
not
> sure why. Should I change its state or should I leave that to someone els=
e?

Please update the patchwork state. I assume patchwork also shows the b4
email from when I applied it. However due to patchwork being slow
sometimes the state change gets missed and I only run my script that
updates patchwork to include the git hash when I also merge next to
master (which is something I should look in to doing more frequently).

--=20
Tom

--jQLkTwKzxb6PoH2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNVSaAAKCRAr4qD1Cr/k
Cm81APwMsN+XYFi2R/BFN/U45lGvSnk4x7GU4zb3enj/hLeGkAD/e52/7aindHEH
VSs7K2Xtw2DnB7PnoZayCIpuDMwKAgY=
=N0eJ
-----END PGP SIGNATURE-----

--jQLkTwKzxb6PoH2m--
