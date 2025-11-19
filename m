Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C80CF58E5
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 20:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29CE483F1F;
	Wed, 19 Nov 2025 21:55:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JzHYikQ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26F4983F26; Wed, 19 Nov 2025 21:55:25 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD3FF83EF9
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 21:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c765f41346so70599a34.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 12:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763585721; x=1764190521; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vfnhxCZ9UJJ4EwwiYVL+wenGiYbA7DpkXXHFc/TSYF8=;
 b=JzHYikQ8XrAjWVY1PgFzGnU0g68AzASZX13F3lqNEfU57M9qKT1bgsJIZyHQGM5AaC
 NIhMRwiRQfiWGs21JMon6sRSMpe+ADesYbB2xQ4bopaYKWBX916aspzTlcG6qS3cmth7
 us8bj8TqFbzeJJpvmZ/Sq/ewkFIaacZicgUZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763585721; x=1764190521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfnhxCZ9UJJ4EwwiYVL+wenGiYbA7DpkXXHFc/TSYF8=;
 b=ZCszYlWj8hPCKJSK8cSJGqTtu6niql8DxtlHD0V5pj01019rp6kKuV43ubwX2fovL8
 cjIJU6q4LtznFkmRfGJvi0tR5AePTr0wydfEkKJHyA+RsHTho7u7UN0IqcePpMivfgfL
 EuUFLuS4iK0Wi4MS0MXYxymb6oU8ytT034y8/ElWoEYb60mWR1+OnDLCwOV2FD3efOuX
 D3Sg+cjA9VLT0zC6RUahNtEZ7OnhAvbN6siB/BRUQngY5uFAOZ4J1KYjwdIrCBlaXqDe
 NKXaM133nQ7bUutYKY2zs1ez33T2e+KZFaoVDbmlxIgg4oF5WIogg5PcHS4mMhaTA1tY
 QGaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnK/t4GPXQHTPG3nrQEl3VXqfWm8iCT0PeYl05pBBWvb5lqpTVaQ1Wn3OTXJudUEwgd/2lfxg=@lists.denx.de
X-Gm-Message-State: AOJu0YxvyiMQtrbTa+tQyvM0rHJ2AJ74jeZHA5K6QYJO+AiTM2ZQgjyH
 Qpvp6mWfT2M2mWuwVVdUUdhIRzqY9ah3O+DT7VgM3KFHt1nXA2xj32iiLKMVq7ySQCQ=
X-Gm-Gg: ASbGnctzBkhebP/z/NKh2o1vOAEEZPHwbCk5jac4kZyoYRnQlAk2lCtSfOSOPe2ePSy
 RmKxsrvnRk2rspZED7dS2wkdYAsXiNw0/PgWO2zbuG1cfHz0hb9/5aQgYotUxH8CTrIrcTyeqI0
 7RPz2WEWSL4QfDfdiubiLZo6kLd/ZzwZ6PVhmqoIQpLwwzg2zC7MUoYdIACQYF39eGUh75OI2JH
 vKl3bCxUFNl2n1eCbWNwox2nKeM9f2QArC5rq0WW8EbNhscWguLnr5iIX7+UA+eoh5ZYr5di6U7
 fkqOuuVWW//fckv4LlF4lDBEZfPBBkHn0Xm7kzvQY72y2x/7aa9/uGtrbRqHFU4GitP6dlAM+70
 eaSv/gtuXJhSwlzc+vL8Ait6SR8LCBK2QusDrxMoA1u15F+sncUQvn9dpUZz6h9sUDyuir1hhUS
 Oqt6OPvZcFTumfLgfhc0DwkSveioReBTYoH77w5JXlM7IHxzz9x3zLFSGWq+Wq
X-Google-Smtp-Source: AGHT+IH3y4op3sw5FValN97j7T1NMktDZ55OeEKu8YRQwd+ietQdK6pMW7GQU06W//BC1GjAXQsvUw==
X-Received: by 2002:a05:6830:277:b0:7c7:58e9:8e16 with SMTP id
 46e09a7af769-7c78e49afdbmr97259a34.14.1763585721555; 
 Wed, 19 Nov 2025 12:55:21 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d3e3bc6sm208881a34.16.2025.11.19.12.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 12:55:20 -0800 (PST)
Date: Wed, 19 Nov 2025 14:55:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 U-Boot-Denx <u-boot@lists.denx.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <stlin2@winbond.com>
Subject: Re: [PATCH] mtd: spinor: winbond: Describe several chips
Message-ID: <20251119205518.GG2125796@bill-the-cat>
References: <20250703170253.1231818-1-miquel.raynal@bootlin.com>
 <87frcwexyt.fsf@bootlin.com> <875xbegt1x.fsf@bootlin.com>
 <20251113142745.GI6688@bill-the-cat>
 <CAOf5uwn_ggFp-KW6qDcKYn1kKA6+FabyQLCT1ecVoBdv9s3UqQ@mail.gmail.com>
 <20251118143405.GA527619@bill-the-cat>
 <CAOf5uw=jx7jTgkeZytjU0t7VFHSVrXfntxrpapUSWrYh5z8exg@mail.gmail.com>
 <CAOf5uwmygi5z3ae_wgJxu4LSKWfEHfAzPTWzN3TUCk22pHqikQ@mail.gmail.com>
 <87cy5ecpd8.fsf@bootlin.com>
 <CAOf5uw=oRJEKu3FQZ253OrHDczmJrunXTjchzDfXvKQ6vr=xhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gPBNLRRLpGDZZbmA"
Content-Disposition: inline
In-Reply-To: <CAOf5uw=oRJEKu3FQZ253OrHDczmJrunXTjchzDfXvKQ6vr=xhg@mail.gmail.com>
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


--gPBNLRRLpGDZZbmA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 11:08:29AM +0100, Michael Nazzareno Trimarchi wrote:
> Hi Miquel
>=20
> On Wed, Nov 19, 2025 at 11:01=E2=80=AFAM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Michael,
> >
> > On 19/11/2025 at 10:06:42 +01, Michael Nazzareno Trimarchi <michael@ama=
rulasolutions.com> wrote:
> >
> > > Hi Tom, and Miguel
> > >
> > > I pick a large part of the patches now, and check them and rebase all
> > > of them. I will prepare one pull request today and another later this
> > > week
> >
>=20
> First of all I make a mistake with your name
>=20
> > What do you mean by "a large part"? Can you be more specific about
> > which patches you would not be picking and why?
> >
>=20
> Yes some of the patches are connected to Altera one and I need to look be=
tter
> on them and I will look the next two days. Some of the patches are trivia=
l:
>=20
> - mtd: spinor: winbond: Describe several chips
> - nand: raw: Kconfig: Correct some dependency issues
> - cmd: mtd: benchmark: use lldiv() instead of 64-bit division
> - spl: nand: typo 'destintion'
> - mtd: spinand: add support for FudanMicro FM25S01A
> - mtd: nand: raw: Drop SYS_NAND_SOFT_ECC from NAND_SANDBOX
> - spi: spi-mem: fix coverity report CID 537478
>=20
> Then I have applied the airoha spi patches on top of my queue.
>=20
>=20
> > I am not comfortable with this sentence given for how long these have
> > been reviewed and applied in Linux and also submitted to
> > U-Boot. Custodians are supposed to work in best effort mode, but
> > delaying, delaying and further delaying is not what I would qualify as
> > an adapted behaviour. I understand you have other work to do. I also
> > take my responsibility in reviewing and collecting and merging patches,
>=20
> I will not delay anymore I will be more active regarding my duties
>=20
> This is the branch u-boot-nand-20250918 . If you still want to go further
> in the discussion and make the process better, I'm more then happy to
> follow your suggestions.
>=20
> > I may do errors and I correct them when that happens, but try not to put
> > all the pressure on my very own shoulders, down to the situation where
> > nothing moves anymore. Tom has been regularly trying to provide support
> > and help. I would friendly suggest Amarula folks to adopts a softer/more
> > progressive approach regarding maintainance roles.
>=20
> We will try to work better.

Please, yes. And while a lot of the patches have been around for a while
I think at this point things that are left need to go in to the -next
branch as well. Which is unfortunate as they have been out for some
time, but given the point in the release cycle this is at, is the best
choice I think. And this also goes for "spi" patches as well, as the
split between "nand", "mtd' and "spi" is not always logically easy and
compounded by our custodians being at the same company with presumably
similar things vying for time. Thanks!

--=20
Tom

--gPBNLRRLpGDZZbmA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR4uswAKCRAr4qD1Cr/k
CmUxAQC5Q21sD5v/AwkS9YUJyotYDb3Dgb/SfkI6kA5LEHbF4QEAuWOt0VFJ2jsq
c2uNXq15Jnfyz+EjMZJgrOMJ4zHzUgQ=
=GFHh
-----END PGP SIGNATURE-----

--gPBNLRRLpGDZZbmA--
