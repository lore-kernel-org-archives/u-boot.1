Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F51FC0218F
	for <u-boot@archiver.kernel.org>; Sun,  2 Feb 2025 15:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A932F80079;
	Sun,  2 Feb 2025 16:00:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YfRrz3P+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C50A780085; Sun,  2 Feb 2025 16:00:31 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F131C80077
 for <u-boot@lists.denx.de>; Sun,  2 Feb 2025 16:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2161eb95317so59399015ad.1
 for <u-boot@lists.denx.de>; Sun, 02 Feb 2025 07:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738508427; x=1739113227; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fZ3x6SVADi5UXIPzpX1XrpxNA8eytUYmc77OF/omLzE=;
 b=YfRrz3P+uAKBkOjSOqZLsoPAna/QtsK2xRsKakTuMKuc+/P1POY2F/BR1BwSsPVSAf
 DDeS/m3dYebX5ckIF3d3Ps7soA4inxrtpWiN8qNLqHKwbqLRaBMhfh/MOA90tZjgAs9l
 GDU0PQU+4tymp++TdVVwDmw4Eu24BQCBwymZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738508427; x=1739113227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZ3x6SVADi5UXIPzpX1XrpxNA8eytUYmc77OF/omLzE=;
 b=TTJxQvYB1M7XRT2aVtbI3yOxS2p+AUBOORcU9wOVOAB9+8U7gDRVEqTLuCZvCwOHE9
 MsQF+UYE1COlJei59LG2RPrDPSsE4tKJfX7JqGQO7PZtnHRevjiCEWXm5rjhLEn9QMig
 eNN3oVSP5pi/8Xi43gxBdueRmhjNfzK5NlcmPii3G5XEQiGWbmsOlHdgTfcSebpUmOMl
 RWJizz2/RbxtTYuI6hGruOOJYDjlEhzMVqnT9HqKUvCtcCnYQ32zqDC1JeSh8QPgUZN5
 tYVn1YCIRjE87nrsKcfQ7T4TNJiFkuWScc1zDURHOXE0dxSd6JHEo8IU620DVi/o/9pY
 zZ9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/qFULY22QnsNTubMcvPWduSj2vlLza6o8qWEgUkxfSOMl/QzxDAnPUB2dJWBlaqf7d7tPdPY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/8k9UjMmvBwvpuArH7jgqBGT6pmNV/AVAK7bAWWynrS3J3Z2r
 HtsxXkUxwGKHDACFvFVBFGjNRGVlRWwx8ztfjdMS5zvOlD/ZjXIW5z+YX7E7sy4=
X-Gm-Gg: ASbGnct3R/aWH1ZH41j0btvRo/QhB2jut3ghfjOewtUpEapbGXycoUKjGTihs83cIu6
 8/SPhJASM45W2JgH2efrC1W3cyPOIQ/3l9YbruYYYnCaLwAXU08TwFcXIsotiyE+UA0V619Q9+5
 GEAYVY5AYf5nbHmlEOw4+mTCKhAquOtBdrMnFkP4hpXpkUTnpY3z1wQLM+JeAx1YC8owBGgwL/9
 +AOxbQ/hUbBy2RQEm9PQ0LyaaauR74WBwWrHoTLJ2VIx/Ylylvv5Puh9lzvEhzkwyza247XwniC
 tytty7oqWh2Y2e8=
X-Google-Smtp-Source: AGHT+IHdJfdb3SFxU49OXQieIntdFS+QfwUrHALOULtvEmUqEtc1TFp/i3kjrnjx7i6rKaPk4O7T5g==
X-Received: by 2002:a17:903:2281:b0:21b:d2b6:ca7f with SMTP id
 d9443c01a7336-21dd7deefa0mr308652085ad.32.1738508426935; 
 Sun, 02 Feb 2025 07:00:26 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de331f0d6sm58947025ad.219.2025.02.02.07.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 07:00:26 -0800 (PST)
Date: Sun, 2 Feb 2025 09:00:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Massimiliano Minella <massimiliano.minella@se.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] cmd/setexpr: support concatenation of direct
 strings
Message-ID: <20250202150022.GV1233568@bill-the-cat>
References: <20250105104614.7916-1-heinrich.schuchardt@canonical.com>
 <20250120205232.GE3476@bill-the-cat>
 <81b96e0f-0721-4488-b379-b09bb0f436a8@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="be/km23/DKyPs3uS"
Content-Disposition: inline
In-Reply-To: <81b96e0f-0721-4488-b379-b09bb0f436a8@canonical.com>
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


--be/km23/DKyPs3uS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 02, 2025 at 01:01:00PM +0100, Heinrich Schuchardt wrote:
> On 1/20/25 21:52, Tom Rini wrote:
> > On Sun, Jan 05, 2025 at 11:46:14AM +0100, Heinrich Schuchardt wrote:
> >=20
> > > The setexpr.s command allows to concatenate two strings.
> > >=20
> > > According to the description in doc/usage/cmd/setexpr.rst the paramet=
ers
> > > value1 and value2 can be either direct values or pointers to a
> > > memory location holding the values.
> > >=20
> > > Unfortunately `setexpr.s <value1> + <value2>` fails if any of the val=
ues
> > > is a direct value. $? is set to false.
> > >=20
> > > * Add support for direct values in setexpr.s.
> > > * Correct the unit test for "setexpr.s fred 0".
> > > * Add a new unit test for "setexpr.s fred '1' + '3'" giving '13'.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >=20
> > This causes ut_setexpr_setexpr_test_str to fail.
> >=20
>=20
> Hello Tom,
>=20
> I am not able to reproduce this problem in Gitlab.
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24424
>=20
> Please, provide a link to the failure.

The three failures in:
https://source.denx.de/u-boot/u-boot/-/jobs/999497
were from that test. Do we have some problem lurking perhaps similar to
what Marek fixed in commit 082b41df8abd ("test/cmd/wget.c: Fix loadaddr
rewrite") ?

--=20
Tom

--be/km23/DKyPs3uS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmefiIYACgkQFHw5/5Y0
tyxDEgv/XwaSfOIl121BEpDeMGmuX1M6l+4jRzPaGfqSFvTU0mfnqXmlrfPS7mj7
vOks3GarbEYrchDEqUL3bwz9KecxW0HqFDXIyRyQZcwYsPLL3/nJKBD0YPSH/S3W
NuxAR7cNtLQttOMlcFnFh6ZzbijgQQE3zwEkGH23chUv7x+5vLEYojtpb06GdEhF
nR5J9jCYrUI9gAFbBcOo5EkL6qPgqSfRDRpX2GVeIIFiatr1J4ogf5Y6maviFUjf
gK56fNSsxcDYaBYCGHaSOa3yP3rJMZTwKawkqqAs2JIoQEp8Q51I2EMu9bI1Dixt
nXVkKOBE0xd2Sp3+739bAgD40Z2Bz/uzx/QyTAaUlPb4N8w41wGOEs+PJBD2jjVk
kvC9kUXrar0d7PdL1KW/PYUKCcgR6F+rrBHbaK2lE9+02EyTNeNl0CzgfrSdGIDK
UowGYvDpcECdzzUh5E58rilQBmImImr87jLJub3E5HBAOLTM85aI76n/wObi79d0
MFaB1wqO
=ukIA
-----END PGP SIGNATURE-----

--be/km23/DKyPs3uS--
