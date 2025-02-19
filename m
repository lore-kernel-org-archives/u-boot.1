Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30ECC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 00:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A21A800B3;
	Wed, 19 Feb 2025 01:25:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uZYUbfSu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D50C80C8F; Wed, 19 Feb 2025 01:25:34 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F3DF80077
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 01:25:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220c8cf98bbso123888985ad.1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 16:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739924730; x=1740529530; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=To0FqxPAHbwq7W+KoXBgcAndGj+fJWPVYLtpMbYXP3c=;
 b=uZYUbfSumzgBffaMOjguvHqMIBQ1BMx0HBHngpCvh82RxRbk6sYrJ91thZ9sG48Tta
 sP8zIx3j4vjdqavnyfFqMbr6JXZ3dLtsJBwgM5t3GieRiE34UBZZDAwAcpRg53XPeTzS
 YrvCRadltW4Q2iO3KQg+7Cj5biwxwStVFWw1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739924730; x=1740529530;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=To0FqxPAHbwq7W+KoXBgcAndGj+fJWPVYLtpMbYXP3c=;
 b=xSnqy1FXPsnMSu2PNlG5K4SqjB9lkhU2J86fjaJRS7/TcCaeb6QAyyBxKrWsy35mZj
 3rkgVJKwSsHrALYAF4cZZiFqp4fwLS9wf3P6q04Tv2jpYbmUqvdaiwr0wShzgRuEJFqm
 rLJ/DxgbtAVa+SZTqwbu6F9l+A6ie8WwtJAQmYt7E8idZOoa4bcLE3NuhP8p6ASUni7j
 g/8Ss0ttelzmvEva+1uNRWOmPZfi/90pIPcCAXv4FsFyerandxyGSLn/1gMOXfgpymj9
 L54lp3H8TsAgFdG3u4BVlNniYzZ6vPLVI+bh/GU83xQ9qsM3OckynKMlgIDeQt8lT141
 P/ag==
X-Gm-Message-State: AOJu0YzOR1Ejlds39UP1ZCTLtQxjXGTl/enH3Ytk2fCcy6Q9KbJxNESz
 RaN/nvm6G+1MbWywZunCdxv+1QDEEq3ZVcsPEUUxHjCs4Ignmi7JP0R3Kzw2WCg=
X-Gm-Gg: ASbGncsXA3p585WkdpcMuTcKfqfMM4OzvCbZKIcaDcHppS5tbwZ6NgDxrMJ+0MmF5dB
 yt4Yj8moPQ0Q5AZbVBORGa5/XHPQOrgxA9ZVCat1cfXnSlXuiRlRsCV81zblf3QZ6FfFkq6k7Pc
 Ue4m8H4hMpo3rPnq4r2YCCnOcYNCyLT8u/FWLxGDuhSHrzlOg3AKuCitFqZQeAnXmEWBcXD/hX6
 INVQ5EghModcoT2Jh3bJ5Ifk5GMHTdicqScSe80OJC7B9/YWxuivqBM3h+haLdNbiNechg+S3bD
 9AhlPDxd0x3OPw==
X-Google-Smtp-Source: AGHT+IFLUjAkD7rR3hWlY2knNkTp6OaxcVsHc0h+Jkt69jhaVlJ4fOHKs+Z7i+kSRcjwbv8J10CIfw==
X-Received: by 2002:a17:903:1c5:b0:221:283:5884 with SMTP id
 d9443c01a7336-221040559cbmr277374495ad.29.1739924730087; 
 Tue, 18 Feb 2025 16:25:30 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53499fesm93767145ad.34.2025.02.18.16.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 16:25:29 -0800 (PST)
Date: Tue, 18 Feb 2025 18:25:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 26/28] test/py: Allow tests to be filtered by role
Message-ID: <20250219002526.GP1233568@bill-the-cat>
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-27-sjg@chromium.org>
 <20250217174805.GQ1233568@bill-the-cat>
 <CAFLszTjr_oNvawcWSgAMC6EVqvTXNntg5fwjp2fm5Enhq_1m0g@mail.gmail.com>
 <20250218151224.GE1233568@bill-the-cat>
 <CAFLszTi132O0-yODOVOZ0_8HOKwA1JPn=xZBMovLma42GM+eng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uhh/bg7L+srLqRu4"
Content-Disposition: inline
In-Reply-To: <CAFLszTi132O0-yODOVOZ0_8HOKwA1JPn=xZBMovLma42GM+eng@mail.gmail.com>
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


--uhh/bg7L+srLqRu4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 05:04:09PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 18 Feb 2025 at 08:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 18, 2025 at 05:09:06AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 17 Feb 2025 at 10:48, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Feb 16, 2025 at 01:44:11PM -0700, Simon Glass wrote:
> > > >
> > > > > Some test can only be run by a particular board in a lab, e.g. be=
cause
> > > > > they are loaded with an OS image used by the test. Add a way to s=
pecify
> > > > > this in tests.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > > - Add new patch to allow tests to be filtered by role
> > > > >
> > > > >  test/py/conftest.py | 22 ++++++++++++++++++++++
> > > > >  test/py/pytest.ini  |  1 +
> > > > >  2 files changed, 23 insertions(+)
> > > >
> > > > This seems duplicative of the existing functionality we have, all
> > > > hardware tests can only be run on platforms which configure what the
> > > > test requires, in the boardenv file.
> > >
> > > I was afraid you would say that, and yes you are right, it is duplica=
tive.
> > >
> > > With my lab I am trying to use Labgrid's configuration and not need
> > > anything else. For example, the params on how to launch QEMU and where
> > > to find the OS file are there, rather than in u-boot-test-hooks. It
> > > allows me to run a session interactively just as easily (and with the
> > > same flow) as I run the pytests and gitlab.
> > >
> > > In my lab, I actually don't have any Python things, apart from what I
> > > added for that tftp test.
> > >
> > > I wonder if I could create a way to pass the env__ stuff in from Labg=
rid?
> >
> > Well, I was also afraid that was going to be part of your answer. A
> > challenge I see with the way you're using labgrid is that details are
> > kept there, instead. Is there some way to publish your configs so
> > they're also available for reference? I indeed have been lax in doing so
> > for the way I use it and so posted:
> > https://patchwork.ozlabs.org/project/uboot/patch/20250217200638.356583-=
1-trini@konsulko.com/
> > yesterday.
>=20
> Yes, that's great. It is a big help to have all the lab stuff in one
> place and not being able to get things into that repo was one reason I
> gave up with my local lab that used the hook scripts. Just too many
> local branches and hacks, and too hard.
>=20
> Anyway, yes I'd like to get it in u-boot-test-hooks. I last pushesd it
> to Labgrid 7 months ago [1]. I thought I did it at the end of November
> but must have imagined it. Perhaps I could put the config files, etc.
> into u-boot-test somewhere, like in a labgrid/sjg directory? Could you
> give me access to that repo?

I've updated the permissions and you should update the "bin/ellesmere"
directory and add "py/ellesmere".

--=20
Tom

--uhh/bg7L+srLqRu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme1JPYACgkQFHw5/5Y0
tyxvJwv+KjoWZ/yXL0WbMMoRv3FpgoNDGXfgGY3ekMfrOhoWJBjUtVF7HX/1LNUE
SpRJg2DUbB2js1CHhnN536CLgQYsWXG3x2c2A47dVM2NxGImZB1w3Kq7QXttJNDC
JEralEF3CnzhvYlQ5WGD/mTQ17gCeufuYSd7scGz/K7xIQ0ZT7+eYJZ2q7/4xJDG
Yckez4uHIaEaiIZeyemL7rhqOSTX0UHfMPt+ef/IWQiTyBFPbeKQPxU1KZwnLJIU
CshThSy4j9HxhYPpAHro25RSZb8HG2agajQ1TfqoS/mki3E4mhHQvEmFyyPQReN4
zhdIatXyuQ9oyIfKPTwRAKshg4daG5nkcx0PC0wFlohlkXItRraSiwDc1zowQnYX
+Ee01pZgmwzntIzSOGsjsv/sN9PSWQfrZ/795S4Bniq0Fhoxy3dz5Xwx3Yz/1fkw
u4q6X6bYxJ9j6rSEyZ3aDD0Wv8GenI0f0hGyyczsUd4Jv5izL1X3VnkQb5efYEgW
5BF+qiq6
=WCV2
-----END PGP SIGNATURE-----

--uhh/bg7L+srLqRu4--
