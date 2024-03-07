Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D6DC48BF6
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 12:55:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3958587DF8;
	Thu,  7 Mar 2024 13:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qGbOkIzi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1133587D91; Thu,  7 Mar 2024 13:55:34 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 183B087DF8
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 13:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5a136ac89b3so422605eaf.0
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 04:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709816128; x=1710420928; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NstjR8bIP9HAOLiwAJjYimzGJpFaxKUOpU6VyW7pWlQ=;
 b=qGbOkIziIxvo9Y2cOeGT3iaghK1lKnSQWCuwik9Z/90K6M03HbX7A1z57QK3tqO2ZZ
 7odbjoiUNCXJHOc9R8gxVOeWl9rd3kb0pf/iFOUpufh4stShfKAvN6vWAcvEXBZ5dWUh
 zqE51fHDQUUGo2lgjGwcdYhiXMLkXYA+uVCPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709816128; x=1710420928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NstjR8bIP9HAOLiwAJjYimzGJpFaxKUOpU6VyW7pWlQ=;
 b=rXcOk1PQtMuIJGjXpTaXo69yqyFEtpgl7OAFSmlSBPkI8YpXWJtwMp8OUM85aaNSbc
 /701jPb1aYQOiTC0wG/914NqMMeXAcoqwn0ukgVH8NOFrhcgubzmHX2KiLNczOt/uJtK
 vjOwOSJqDhQP+QubijjnBJ1z1liXYk0zRcy9eJa8OUFzywv0j+0U9yPgsHo5X4RTAZRG
 tMSXKzi7vJOml9OuSfacnlrqEKMyJiiFccdcwZjJ5zY5KFNGld2rQXrCVXjdsdS4AUby
 h01/s/qJ8Ycxox2wrGu9pb7EQVVqsyRS4vwZ1lTQNkxqFpXMsPMdXgM+bVecuaspCOAM
 OgTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkqhjIzOGOBRYeS+5rQkC0S0C4IQdhj/xxaH5aW9uHQY5lUQ+fvGfq9yZhPAdVKxXAqSDuEtseEB0Jgy3P+7m8n4YzfQ==
X-Gm-Message-State: AOJu0YxN2T7kUMCFQ7MRkrbJlVvDZ0U7QuxBQ5nLl7S9fLDh4Nij9ms9
 zeXXjn7q0LmOn/bqzfVbIXcqbSMq4xrGKeazwJ9ZZZ5AkqKyvpniJGsFvifiohg=
X-Google-Smtp-Source: AGHT+IHlQqssIEjN2qJTx/eW3IwlFpmc4VkhneAAZq8ZUoevRXseNUDyEH3SUm+uRkt3meSIQ6ES2A==
X-Received: by 2002:a05:6358:93a5:b0:17c:11b4:9d1a with SMTP id
 h37-20020a05635893a500b0017c11b49d1amr8099962rwb.30.1709816128552; 
 Thu, 07 Mar 2024 04:55:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 do18-20020a056214097200b00690a7785ce0sm343888qvb.77.2024.03.07.04.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 04:55:28 -0800 (PST)
Date: Thu, 7 Mar 2024 07:55:25 -0500
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Angelo Dureghello <angelo@kernel-space.org>,
 Love Kumar <love.kumar@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3] test/py: reset: Add a test for reset command
Message-ID: <20240307125525.GF1523872@bill-the-cat>
References: <4b7c5e82165b009cf8b28701ca3f1e182fbc3c09.1708414720.git.love.kumar@amd.com>
 <20240302151813.GA1652651@bill-the-cat>
 <bd0b13b0-0554-b280-a40a-17056a1e2c5e@kernel-space.org>
 <c11e1809-b5d1-46cd-a5c8-a5276b83f26f@amd.com>
 <c523aabd-93a4-f9db-2726-7f912a85aef0@kernel-space.org>
 <20240307001053.GE1523872@bill-the-cat>
 <c05a25ca-d4b7-1179-cf46-645bc4cdba89@kernel-space.org>
 <c0bbe63d-adee-456f-bcf8-44579aa2593a@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zf8DQoe3JdSlNSmH"
Content-Disposition: inline
In-Reply-To: <c0bbe63d-adee-456f-bcf8-44579aa2593a@amd.com>
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


--Zf8DQoe3JdSlNSmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 09:26:42AM +0100, Michal Simek wrote:
>=20
>=20
> On 3/7/24 08:56, Angelo Dureghello wrote:
> > Hi Tom,
> >=20
> > On 07/03/24 1:10 AM, Tom Rini wrote:
> > > On Thu, Mar 07, 2024 at 12:36:42AM +0100, Angelo Dureghello wrote:
> > > > Hi,
> > > >=20
> > > > On 05/03/24 1:34 PM, Michal Simek wrote:
> > > > >=20
> > > > >=20
> > > > > On 3/3/24 22:58, Angelo Dureghello wrote:
> > > > > > Hi Tom,
> > > > > > > On Tue, Feb 20, 2024 at 01:11:38PM +0530, Love Kumar wrote:
> > > > > > > > Add a test for reset commands which performs resetting of
> > > > > > > > CPU, It does COLD reset by default and WARM reset with -w
> > > > > > > > option. Signed-off-by: Love Kumar <love.kumar@amd.com>
> > > > > > > > Reviewed-by: Tom Rini <trini@konsulko.com> --- Changes in
> > > > > > > > v2: - Set bootmode through boardenv if modeboot is not
> > > > > > > > defined Changes in v3: - Fix the issue with bad pattern
> > > > > > > > found on console --- test/py/tests/test_reset.py | 61
> > > > > > > > +++++++++++++++++++++++++++++++++++++ 1 file changed, 61
> > > > > > > > insertions(+) create mode 100644 test/py/tests/test_reset.py
> > > > > > > I had hoped this was all sorted out now, but both this and the
> > > > > > > saveenv test cause qemu_m68k to fail now. See:
> > > > > > > https://source.denx.de/u-boot/u-boot/-/jobs/791635
> > > > > > looking into this.
> > > > >=20
> > > > > Is reset implemented in qemu? It should be skipped if it is not.
> > > > >=20
> > > > yes, seems not implemented
> > > >=20
> > > > =3D> reset
> > > > =3D> reset -w
> > > > =3D>
> > > > =3D>
> > > >=20
> > > > Not finding any trace in the qemu code related to
> > > >=20
> > > > out_8(&rcm->rcr, RCM_RCR_SOFTRST);
> > >=20
> > > Does reset work on the real HW, or can you not test? What I'm wonderi=
ng
> > > is if we have a missing feature on the board/arch code (and should
> > > disable the reset command) or a problem with QEMU.
> > >=20
> > I don't have the exact hardware (m5208evb) but:
> >=20
> > 1) i checked by tracing that on qemu the reset function is properly cal=
led
> >=20
> > =3D> reset
> > resetting, RCR fc0a0000
> >=20
> > 2) reset register address is correct. I checked also that writing
> > directly to it by mw.b does now produce the reset,
> >=20
> > =3D> reset
> > resetting, RCR fc0a0000
> >=20
> > =3D> mw.b 0xfc0a0000 80
> > =3D>
> >=20
> > So looks not implemented in qemu.
>=20
> ok. That means that we shouldn't run reset test inside CI loop for this p=
latform.

Agreed.  The TEST_PY_TEST_SPEC variable in both of the pipelines can be
used to say "not reset" for this platform in the next rev. It would also
be nice to file a bug report with QEMU too I think. Thanks for digging
in to this everyone.

--=20
Tom

--Zf8DQoe3JdSlNSmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXpuT0ACgkQFHw5/5Y0
tyyWFgv/QbqEpBnMuzcVmMNIVi3dd6Wr1o7mt+SpJXPIlQqMsOaYzZ9aybave8T2
arZZNz98PAA2Y23xlmNC+0UZp7K+bB2BnwkE9LHGGFdX0Mia5beSvjRa4cfZ2K7n
FsKgwIw4CfLMwsLARNIjU1NMlt7bGpKiC+3A6E6lpdcgzPlo+xltzMf4vaecdAQB
eBzPQWY0tHOrvG6MJ6kkRVTd5my6SRvSHw4LKz1jEUi/cfgyj0H14ZFqs/aNm0d/
qP7xqJyLEF+X6vKjyPimgKHll6uE9ju6HoSTUKFKUBppAIvoHjLm1bL44Mnls7W6
SmXKoHJa7IgSDWjAZWcUYaMqXB3k59vWzhdsbFW+OuhNBVPI5g+0lwQi1zzhsoaR
4T4aN+oUZNGEpyFs8LKuaAQ7evONoqGW2b5pOmOXAK/GP0xHU+cxIm94CD5c0NQg
Ojquz1oqYztFhq7mpvO5vhE1dmSQ78bGA6poei5T3/Wv81Y0zFCfwAHBDB6iuY2z
sQUGUON5
=oQsU
-----END PGP SIGNATURE-----

--Zf8DQoe3JdSlNSmH--
