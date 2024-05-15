Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE57C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 16:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C46D6881AA;
	Wed, 15 May 2024 18:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JsIDJv+F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D2E8824C; Wed, 15 May 2024 18:00:11 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E6208717A
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 18:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-792bd1f5b38so552183685a.1
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715788808; x=1716393608; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qH1XHyyo6YxTluaTuiIzpzy6RpiayLHbjUeeCJBniyo=;
 b=JsIDJv+FT2TJdEvZTZaDmuCErHyqlG3lJKlYpp3OREistzzV6db5zLBDwZnjIYqbx+
 5iZS1ocuk67kiS5qDmpKQ+Jc2Pw1XLhDnxh613kzwxVRj66TDbT6cgZyXc4DDxnICxuN
 65TEs9hymWxrFDogm1Y+lf43axYpCyZV7P7zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715788808; x=1716393608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qH1XHyyo6YxTluaTuiIzpzy6RpiayLHbjUeeCJBniyo=;
 b=m3vVfZWkzpNy8FdEF8XH8Ir8CCKVPmsA2iZgJv0HVcdYyzt1hKSc7gS5xDrQ7/znNs
 A22CDPoJQncs5tCmQA7QimQuvGcsixgu+HwNy9HFPSClBl1/33e/GalcJaV57C2ecQT0
 vheoC+H8jX3v8TUJasPQjxcWu82HH7yjIWJRIMvOVgrWOYPUDU3lznoGgP3DPw9GeZJU
 EV4ymRuFvIASO+938tj/3FEdnhcTvMEudoVeCbd+TBIwuNytZrFFOpUJDS2V+ebf1pY+
 lpsUdYjB5ArQXqVsR1Y6uxvGWk0/QASwxApg3ISMa80ODWg2umSD3JkK0+BO8YXwsSEJ
 cVBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2geoFew+Ll/IKgQNM5d3y9PQUqmMhKFnI7ISwbPffR0wWBerXM49i4+B3Bkwp4jcu6+HL4XYpABeErJEoWatevu+VOg==
X-Gm-Message-State: AOJu0YxqJ6OtTk16lCVFQR6N8va8ckddRZ4eKrOoqnGyZlYNIsvTABYF
 gKSjLS7P2uyXvKVkQZXrdem7EM1aE2UUytNdzmDQwU+AfJNlbwA+Kp5min58CM52l6Io8vBQEim
 Pm/w=
X-Google-Smtp-Source: AGHT+IEu6DOQvwhpXZv+43x3x/jTp+8DFmR0cSySTplXg0AB1LFj+j31dCNQnWEIDrMQKqWHPZ2GQQ==
X-Received: by 2002:a05:620a:4709:b0:792:bad2:95e8 with SMTP id
 af79cd13be357-792c75ff90dmr2103449185a.58.1715788807418; 
 Wed, 15 May 2024 09:00:07 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2a11e8sm687384185a.58.2024.05.15.09.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 09:00:06 -0700 (PDT)
Date: Wed, 15 May 2024 10:00:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] Squashed 'dts/upstream/' changes from
 b35b9bd1d4ee..7e08733c96c8
Message-ID: <20240515160003.GW2568172@bill-the-cat>
References: <20240514164236.516595-1-trini@konsulko.com>
 <b12a9b07-2c92-4651-b6ba-3aff6ecc9219@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3pxIf0d31SoctDvP"
Content-Disposition: inline
In-Reply-To: <b12a9b07-2c92-4651-b6ba-3aff6ecc9219@kwiboo.se>
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


--3pxIf0d31SoctDvP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 09:29:41AM +0200, Jonas Karlman wrote:
> Hi Tom,
>=20
> On 2024-05-14 18:42, Tom Rini wrote:>=20
> > git-subtree-dir: dts/upstream
> > git-subtree-split: 7e08733c96c84eb323f47e9b248c924e2ac6272a
> > ---
> > This moves OF_UPSTREAM to be tracking the v6.9 release and is for the
> > -next branch. To test these changes yourself locally, either use my
> > "WIP/14May2024-next" branch or run:
> > ./dts/update-dts-subtree.sh pull v6.9-dts
> > yourself locally. I intend to wait a few days to apply this to -next, to
> > give people time to test.
> >=20
>=20
> There are currently more boards/SoCs that use OF_UPSTREAM in master
> branch than in next branch, a few Rockchip SoCs and other boards/SoCs.
> Next dts/upstream sync will probably be good to do together with a merge
> of master into next :-)

Yeah, with -rc3 I'll pull that in to next. And I did this sync now since
Quentin reminded me on IRC about it. The massive CC list comes from
using qconfig.py to see who enables it, and then a quick one-off to get
a list out of get_maintainers.pl.

> Also what is the expected sync cadence of dts/upstream? Linux v6.10 will
> probably be released shortly after U-Boot v2024.07. So will next sync be
> to v6.10-dts if that happens in the U-Boot merge window or do we expect
> 2024.10 to use v6.9 DTs if the v6.10 release gets delayed and miss the
> U-Boot merge window?

So, I need to put something in to doc/develop/process.rst about when the
full dts/upstream resyncs happen, and where. The plan currently is every
Linux kernel release gets pulled in, and master or next depends on if
the -next branch is open (which is with -rc2). This should give us the
most time to get changes tested, while minimizing drift away from
upstream sources. This is also because, and related to, that I try and
make sure that nothing breaking comes in to master once next is open,
and so if a board maintainer has time to test things at -rc3 or what
have you, it should still work in the release proper. More testing is
always great, but given our release cadence and generally predictable
schedule, I am hopeful this provides the best trade-offs in terms of
time demands on board maintainers.

> Linux kernel typically have all major DT changes in -rc1 and fixes in
> later -rcX, so for next branch I would suggest an early sync to a
> v6.10-rcX-dts tag, and then sync to the final v6.10-dts tag once v6.10
> gets released. That should give more time for testing, migration and
> cleanup using v6.10 DTs in time for a 2024.10 release.

The issue in my mind is that we just don't have a lot of people with
time to test things in U-Boot. So I'd rather avoid possible broken
upstream and then fixed later upstream problems. And having done it now,
I can also say it's really easy to use dts/update-dts-subtree.sh so if
someone has time they can do that locally.

--=20
Tom

--3pxIf0d31SoctDvP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZE3AAACgkQFHw5/5Y0
tyyaqwv+PUUJGqWb8lQ4ea28GFuXH9XK0runDk16aQIsabVKtrd0tzS33xZT1rdB
g+DVse7dH+9TaTQIvacaw/Q/IvrcmurLTWFmA+l282VHHOoj8jmq1QwD4MAJ0vzR
KErouNoo+f6jKEjksDqFSGAcE4BJ7uHEM+KMNRDIahs1H7jw2KcIOA1mVVI2XyvB
rqABwy/9/91uj63voAZdeLW0WXOhHikUrjKmoyHxYsumhVJKeoAyxlThoBYfBP8b
Nf9ZZwV3sfbIR8wlzKJSRFpyEpXWOkd+vjpzWKyk9tojYxtnkexcIp3LlcCknblz
Qn+yrZJPrSXxgu8jEmCSxH1KWZBA3A/Uh65SPlUYAEXuoybk3YdkfNaLr5h1DhjL
UGNNHFDnCK/qCksGyH01eKq5l1A2yTdXHP47sqiDD1/ZNfY/BOuXSTllS1A9axNO
p9w7HfB8mGojd3GsKeMS23gCWzUZ6WMg6hcA4xsCWJwqvw4aMLSYojJx6yZ7bmTB
KpV3zJUI
=yv1W
-----END PGP SIGNATURE-----

--3pxIf0d31SoctDvP--
