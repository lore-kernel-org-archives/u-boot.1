Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790541098782
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 13:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFDE783BC8;
	Fri, 20 Mar 2026 14:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dw+NZ0Mt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD4A83CEA; Fri, 20 Mar 2026 14:56:23 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F95805D7
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 14:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d7f92bde91so36706a34.1
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 06:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774014979; x=1774619779; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A8tUBY3i2Im1K4aZLi3YDoLOKLgWa2CvtYGTG/i1NgQ=;
 b=dw+NZ0MtKx4yYCQO6uSeiZXi91Ux1IoGJVF9goDiXqGPBPggJjXtqWkllQiwLTJNlt
 IhRfBu2SszTZeCJdWJVVSBsf1FiJfQ3ZRLD9kRhnWVXYWGkCDe4q4BoaRqWyDZg7oJjH
 sEC5QCRHopiHe1zZgvpECxKrqdhxo5fCSJPcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774014979; x=1774619779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A8tUBY3i2Im1K4aZLi3YDoLOKLgWa2CvtYGTG/i1NgQ=;
 b=J+bCKmxHhcBPD4VcF00b/4GDUKOwreKNBE0AR7mmtMeWlD8cyI+cse55TX2Ap0116e
 DynIkO30O7Vhv9RAW35ZdZZhTuYO6gZcjsAq2rq58Y9M8r5ZvTHDj9MWErwcBfoPJplr
 WoQaxqsNWMVPCtKFOmKrX29Sl1DjsPAWeQ1jqyTvZDB2i3Uzd2CU99X2MG/itWyWSgg2
 xOj8q5IhJVcqepgkg8H8eAwf26dqVl9VVbL/fevpE7nTIvUd6O+CJoxUGjXSvKqKtQeP
 /IA1r5vDbFG9eu3joIIBQJLPlpYphZ2bwNwMTZo6mdnqX0De8VVDD52fquBUYcKNiHxP
 y96g==
X-Gm-Message-State: AOJu0Yy4ho0JVMoYI+/ugrmC8s8g0L/WlymIOWN3Hie4fPxUw0SOB6E4
 3wsyyob92sbY56IbGi/RKW5AbpNe/EmKs5i7lmaIJTiClY3i4y8YEipqtL+WUwGfHOg=
X-Gm-Gg: ATEYQzwbn60BOdELam6YKGX4yr5Ul5ux+3qVqCB1waabriYRkGf8wXUB/AYCD05jzNE
 Ts+2Q48kbLVNHrfedD5xGbaD2Fgfe9Fx+7Ey1iYgTYMkFytMtA2WZ5VAASU6jJuwvcFFPR36TC4
 Tg671DjfzFQ44C7/cOjfmh+UgSr8Mos3YSiiKL0LcFrT3cWilRiKW+m725b9nyjYfrZ45or9h2z
 8cx3ZceX/hhp1lPEB+g6EF2NNz5KeHbB4YnxaILxQVVH54vpVqekIV9vU0PyQ2/YZAHGVVnwfR3
 7o6OEfvmzBysaXVsZBnc1nqBNVOeqs+z3H6l1je6S5bWFrXn863JULjMAH4gsGQDrEPpD7/6qIv
 8VbstDqWnXze1b8FjP0limqIQT7Duq/BNO+aRIJ41miDJTYZBu+YxtRJxhmIwe9n4BL3FoR1OKB
 ZKHHRx315OJcrq5RoUs21pPTEclkROspDiP8HuQSshePhHOZqFpFQ/Ebslz7ZITf4W/krCFnDrU
 hnEL819qiTNxznNhvpH35/WjkfaxPbHu16KvrtURDeFYXJ+WHCtl3yNJOI=
X-Received: by 2002:a05:6830:82c3:b0:7d7:cc53:1ead with SMTP id
 46e09a7af769-7d7eac66f45mr2137847a34.0.1774014978826; 
 Fri, 20 Mar 2026 06:56:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac3e763sm2239580a34.11.2026.03.20.06.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:56:18 -0700 (PDT)
Date: Fri, 20 Mar 2026 07:56:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] reset: Correct dependencies for RESET_RZG2L_USBPHY_CTRL
Message-ID: <20260320135616.GY502704@bill-the-cat>
References: <20260317012443.4162600-1-trini@konsulko.com>
 <ed88ec35-7d53-48df-a65b-7da1298e265b@mailbox.org>
 <20260317134008.GQ502704@bill-the-cat>
 <58699be1-5414-4749-9975-7fdf0064b1a3@mailbox.org>
 <20260318012557.GF502704@bill-the-cat>
 <34a0c151-f8ff-4b91-92b3-d6f63097440e@mailbox.org>
 <20260319134128.GP502704@bill-the-cat>
 <11128ed2-a53d-4286-84cc-dc5c6d932405@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TWUcbXq08EREhb7u"
Content-Disposition: inline
In-Reply-To: <11128ed2-a53d-4286-84cc-dc5c6d932405@mailbox.org>
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


--TWUcbXq08EREhb7u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 04:58:13AM +0100, Marek Vasut wrote:
> On 3/19/26 2:41 PM, Tom Rini wrote:
>=20
> [...]
>=20
> > > > So I think the answer is if you fire up menuconfig, and turn off
> > > > RESET_RZG2L_USBPHY_CTRL and REGULATOR_RZG2L_USBPHY and DM_REGULATOR=
 and
> > > > then enable RESET_RZG2L_USBPHY_CTRL things will become mad because
> > > > RESET_RZG2L_USBPHY_CTRL has select'd REGULATOR_RZG2L_USBPHY but we =
don't
> > > > have DM_REGULATOR.
> > > How is it possible to enable RESET_RZG2L_USBPHY_CTRL without enabling=
 its
> > > dependencies ? This is what I do not understand.
> >=20
> > The way I said in the part you quoted? If you don't like the way I'm
> > solving the problem with the dependency graph here please propose an
> > alternate. But it is possible to encounter this problem, or randconfig
> > wouldn't expose it.
> What I do not understand is, how is it possible to enable Kconfig symbol
> without enabling its dependencies. Is that a bug in Kconfig ?

There is nothing ensuring that when you enable RESET_RZG2L_USBPHY_CTRL
today that DM_REGULATOR is enabled. But since you're telling it to
select REGULATOR_RZG2L_USBPHY it then will give an error.

--=20
Tom

--TWUcbXq08EREhb7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCab1R/wAKCRAr4qD1Cr/k
CvoMAQDirpOlLJdcbQgmOvzu+nCxKEEapRPQonE8Q62qN2EQ1QEA5Nv2aIGfaNJN
YHKHqdQCy4RIhLvaWMYEnu6HgyxI2gQ=
=eKDu
-----END PGP SIGNATURE-----

--TWUcbXq08EREhb7u--
