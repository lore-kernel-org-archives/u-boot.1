Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B598C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 18:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0800688363;
	Tue, 21 May 2024 20:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YiYPf4zF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5474788381; Tue, 21 May 2024 20:15:41 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 297C18835C
 for <U-Boot@lists.denx.de>; Tue, 21 May 2024 20:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-792bc48f6beso301543385a.2
 for <U-Boot@lists.denx.de>; Tue, 21 May 2024 11:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716315338; x=1716920138; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z7MQImJGWLvE79Db8Uxq6Ydqkgo+iRKurs53u5ybezM=;
 b=YiYPf4zFvWU4mgL3EzpDED5CHsYrtWAUNKMUIaxcQ77lhISOjch+kdai1JkQtPO7U2
 S9ITWW3Je3sbqKokIdTJjebAaXYKHCqBBOcWupo7ivYMxZdhjPMVTsjzWkOTd+bJw7Td
 iEY9M5XbyBml+UVS8qP0SCk1vzGxQ03QmrrCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716315338; x=1716920138;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7MQImJGWLvE79Db8Uxq6Ydqkgo+iRKurs53u5ybezM=;
 b=Q4Dk41A0R9zfzNrbAy2YNc6EJZehegbRO9yJQz+UsQU9DINUeu2XsPEKQnWPbjTdUR
 Y+A+UOnUDd9A1aHMx/NGTzMJeSJ+rI3SSEQE8ToUV/e4dHm1tjZmAlkgJcYdytH/ftVN
 zu/uoTo0v+UxRS8yMSvPH01/NHIbAT6Iz69OvPgC+T+0kK7GCcB7bmEQB8tQxVTsU8BD
 1EdSOis9ddsFkuVMywzjUAs/bLWr7+U/K5N7/Fin5e3EzodXqlfSY/4TC0pDKX3T3DLS
 wCI70QfnA0lngljBvUZb+ZMr4/cHi6iePHqF8r++h8T+20vmNgBaE4TNLon9BMWwOSk0
 eYEg==
X-Gm-Message-State: AOJu0YyCL1WbPjnK7RtemRvLXoco2r/nW0c7TYpdV5ZToXBBEp+eXL4X
 w9T5pq44G+3We8CHKflUHwmaiC551I9MBXoXVs3Hn3TEgKejuPwaTD6K1d4RpAsP6qnALaxBdGC
 XEok=
X-Google-Smtp-Source: AGHT+IHoNg2JLEOZLjSjp/UH91D5q15C5O5KwZu5tQBog+i0n0we7fMR19+TgudkdMoDeArkWcfgxg==
X-Received: by 2002:a05:620a:814:b0:792:bf91:3d41 with SMTP id
 af79cd13be357-792c7574b0fmr3484454285a.15.1716315337747; 
 Tue, 21 May 2024 11:15:37 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7930325d5d0sm605501785a.75.2024.05.21.11.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 11:15:37 -0700 (PDT)
Date: Tue, 21 May 2024 12:15:34 -0600
From: Tom Rini <trini@konsulko.com>
To: "Brunham, Kalen" <kalen.brunham@intel.com>
Cc: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Message-ID: <20240521181534.GD2568172@bill-the-cat>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LaxymsCNTl+9Sp8F"
Content-Disposition: inline
In-Reply-To: <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
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


--LaxymsCNTl+9Sp8F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 04:54:58PM +0000, Brunham, Kalen wrote:

> Hi Tom,
>=20
> Fundamentally I want to create standalone applications that can be
> used to help debug low-level HW issues. The advantage to doing this in
> U-Boot is to leverage existing drivers and other facilities. I agree
> this is niche, but is something I saw one of our power-users do
> recently and are looking to share with our customers. Unfortunately,
> the Makefiles today make this more difficult than it should be, hence
> the desire to change this. My current goal is to enable a user to use
> the stock (unpatched) u-boot to minimally create a hello-world that
> they can execute following the existing examples/standalone steps. =20
>=20
> Are your plans to deprecate both API and Standalone?

So, the next set of questions become:
- Why isn't it just part of U-Boot? Make your tool a new command
  instead.
- If for license reasons you can't, why not just start from some other
  appropriate for your needs licensed skeleton and bootelf your tool?

We have long not done a great job with the U-Boot standalone API stuff,
and for a number of years at this point a lot of the use cases it was
used for could instead be filled by making an EFI application. There's a
well defined API there, there's lots of examples, and frankly for the
license related questions, makes a much nicer answer.

That there's some power users out there making use of standalone to do
useful things is news to me. Some of them speaking up and offering to
be visible in maintaining it would be good (there's Coverity issues and
lack of CI testing, which should be addressed).

--=20
Tom

--LaxymsCNTl+9Sp8F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZM5MIACgkQFHw5/5Y0
tyzdzgwAqH9T6mWDgdF3j4T67sT8hLU6Q5NEYy2QoCf5IK4f2JrCE5y1Ap7amYi9
PBxkPdkSj6Ex7T8+tnhvVBSNkHSalvY4WSWbot7Ez/XpaN7Z0/YQWG47o0pzSrTz
dXBUV3O/vAztcqD9O1BveblSU3duJFTjbaRPDBSLxgY//Qey/d0rrozohhim3eVq
SOrSY+BuGA0/Gq7matOQYcMp1smemuQ//Yp1h3V4A34Ke/ZROeqtZXR7jlsk4hI0
lmfmgh9RjoeoSbDk9k3GEzFE4sWCh3XjqH8tHPfnmn8wv5KeaPd1WH757FootBjC
JxxGSGJRXb3plK6FUBCe6LeYvYlpWqgjmZf2s/jx+5rW4Wegy24o8JPHHdy8MucO
M8y/U0hDOeTk0Rc0fKN8IYF6dYTxU2mstKja7HeYo5aq/NKUM66p3XvdUDhIcN+E
1DQsbLUNBE04Y6tj87tFtW3RJ/f45UXFH+szHM2GhdkHEiNirQX6KfPGz2+RCGMk
NOgwjvFY
=Kw1w
-----END PGP SIGNATURE-----

--LaxymsCNTl+9Sp8F--
