Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B6DC5475B
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 00:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2223875B9;
	Thu,  7 Mar 2024 01:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uJjUpWvs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D71048752B; Thu,  7 Mar 2024 01:11:06 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6B1C87B7C
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 01:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-42a029c8e62so2124281cf.1
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 16:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709770256; x=1710375056; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XVgS+PkkiM1N+fxrrp8dKZPw32Zfeaz7LdfWvkeImhM=;
 b=uJjUpWvseRKFo3Dd417PJ/GFh/VzbZKgTl2JPAgRhzvV8VVtVXds/vKZKaCKHemrTD
 mAlqlkCJNO+tyMgrGdqXi3AXN6QDBxZMCEv0jU9zIrSlEzFUCehruIccHFhTMwBoiL96
 srzJrkNA36friC/25kapryiHHOsy5P1mjNdKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709770256; x=1710375056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XVgS+PkkiM1N+fxrrp8dKZPw32Zfeaz7LdfWvkeImhM=;
 b=F3dboPVe5mxJx5yu8x9DSVLDlqoqAFX9Tn7aZEk4Kn0YD3SRYytZTXjNhMMRdA/32F
 zZbP3SK3Der3PTkb52vy/NFBI0ebk5yjh3VfT7bAW/Hsujt7+dxTqjq82ERMB3bY6qKu
 V9Dp/FU/Ka2x7euzm7k1lX++Q4TYeE10EZwfKmjT3XM4K8CY2wxS01NJwqGz8PZJ5Tj1
 EWTkgwPdBSk2q6EhME/cKKduMhivdmsVVu30h2k/klkiAXIat3mNPX7DODUvMdVxJN++
 QCOzIP5H13b8AzEFHByEVTTV45EThQhpatOX90NcrtulFw1qbdf0Z+MlYXZvpJ2Rqx2y
 0bWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+X+oh5rxflBFNnxn8fABYdl1KhTv2H2q7A8l4A0VEvwNfo00Z1Z/CWWil6l03bLjI0OIrB7LpEwPi/pkTFQAKiemBow==
X-Gm-Message-State: AOJu0YxSpqfx2X1Gpb5+zlj1u9XjgcF6xkAvh27Jod9Budfu3QmcqAcI
 ewnHOhexUj9LbYhVhI/42sRfQqcMZNZDygv2FChvAvB7NO6ZnuCdxzRJ2LULp8c=
X-Google-Smtp-Source: AGHT+IEDFTsruohMEKGm7YY3SjgR+3/9wyu9YO4zPHvbzA+7toCvoy76/dULmFH0bGOk3KtoItIpcA==
X-Received: by 2002:a05:622a:446:b0:42e:bcde:94a9 with SMTP id
 o6-20020a05622a044600b0042ebcde94a9mr7919078qtx.10.1709770256627; 
 Wed, 06 Mar 2024 16:10:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 dn1-20020a05622a470100b0042e5c83cf22sm1912397qtb.69.2024.03.06.16.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 16:10:55 -0800 (PST)
Date: Wed, 6 Mar 2024 19:10:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: Michal Simek <michal.simek@amd.com>, Love Kumar <love.kumar@amd.com>,
 u-boot@lists.denx.de, git@xilinx.com, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3] test/py: reset: Add a test for reset command
Message-ID: <20240307001053.GE1523872@bill-the-cat>
References: <4b7c5e82165b009cf8b28701ca3f1e182fbc3c09.1708414720.git.love.kumar@amd.com>
 <20240302151813.GA1652651@bill-the-cat>
 <bd0b13b0-0554-b280-a40a-17056a1e2c5e@kernel-space.org>
 <c11e1809-b5d1-46cd-a5c8-a5276b83f26f@amd.com>
 <c523aabd-93a4-f9db-2726-7f912a85aef0@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8IxWld1tm4BwgJUT"
Content-Disposition: inline
In-Reply-To: <c523aabd-93a4-f9db-2726-7f912a85aef0@kernel-space.org>
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


--8IxWld1tm4BwgJUT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 12:36:42AM +0100, Angelo Dureghello wrote:
> Hi,
>=20
> On 05/03/24 1:34 PM, Michal Simek wrote:
> >=20
> >=20
> > On 3/3/24 22:58, Angelo Dureghello wrote:
> > > Hi Tom,
> > > > On Tue, Feb 20, 2024 at 01:11:38PM +0530, Love Kumar wrote:
> > > > > Add a test for reset commands which performs resetting of
> > > > > CPU, It does COLD reset by default and WARM reset with -w
> > > > > option. Signed-off-by: Love Kumar <love.kumar@amd.com>
> > > > > Reviewed-by: Tom Rini <trini@konsulko.com> --- Changes in
> > > > > v2: - Set bootmode through boardenv if modeboot is not
> > > > > defined Changes in v3: - Fix the issue with bad pattern
> > > > > found on console --- test/py/tests/test_reset.py | 61
> > > > > +++++++++++++++++++++++++++++++++++++ 1 file changed, 61
> > > > > insertions(+) create mode 100644 test/py/tests/test_reset.py
> > > > I had hoped this was all sorted out now, but both this and the
> > > > saveenv test cause qemu_m68k to fail now. See:
> > > > https://source.denx.de/u-boot/u-boot/-/jobs/791635
> > > looking into this.
> >=20
> > Is reset implemented in qemu? It should be skipped if it is not.
> >=20
> yes, seems not implemented
>=20
> =3D> reset
> =3D> reset -w
> =3D>
> =3D>
>=20
> Not finding any trace in the qemu code related to
>=20
> out_8(&rcm->rcr, RCM_RCR_SOFTRST);

Does reset work on the real HW, or can you not test? What I'm wondering
is if we have a missing feature on the board/arch code (and should
disable the reset command) or a problem with QEMU.

--=20
Tom

--8IxWld1tm4BwgJUT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXpBgMACgkQFHw5/5Y0
tyxyfAv+OeO4Pejl9DiCJYu1JzzR7GBvkEjTyUIxDtTIsM4P2t5ftMIsPPKKQILu
LoScAEFks+1sGnhXLjIRQm0fKiYVzqW9IemwMutkOjVYoWUjLMuDAWsxZat8DOih
mzPWIXLMBnKhh0+rMU3m0yQv7YazebHsEUFBlCl4hzeJJ2HfZjGP/XFaf+LRsAjP
D+U/eXUmzJ6D4xqwOumDleebhmNmvUmBJowWCxEZ+/p//PfE8wW6grMe/UltRfCo
EWttwRzDzQ9kfuYRzODYk4gfzn2JTA/3H52jlAAoHoi2tzUDqa38XaMHIJo6mtzh
7xZc2dLU70UfdoCAK/VwH6mBjBdBiyYuVdIxahcIqx6N9vkcumyHzxJ8WZ22BKBv
t/apPdSRwB1s0xjlxtqkKS1q41IgjzKwKkPmSTj085GA80Cm5Pmug3acJdLeZJJw
dm6KGJjnMvnCuFd4yjw6b1yJNZJO/ZhycXeqKTeISLtuHiTqAvlUSRxh4uERlzsZ
/TbHiRIC
=rRcY
-----END PGP SIGNATURE-----

--8IxWld1tm4BwgJUT--
