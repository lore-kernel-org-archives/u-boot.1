Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B114CFC29A
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 19:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFB2283A8C;
	Fri, 21 Nov 2025 20:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H2irQemc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD5DD83A9F; Fri, 21 Nov 2025 20:24:05 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7773783A8A
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 20:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c71cca8fc2so1374658a34.1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763753042; x=1764357842; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U/aIpVd/xznu+0FDgqVwWaqqBkNbCiMm2W5tkHZEHFk=;
 b=H2irQemcXPkFZszFWiWhkLRSYnnZSke/ITBc48OD/8SpIi0JXdY33QJ5i61YTa0L7C
 LRrwwpGssm9TkLKzQMO5vlVt9/EsrRR0e41+1L8jk3F/IUZYP/RAqQPvoXOMCwrncYx+
 bh9RgFLzjhHIEhkxYPMRgl/zhVCd1WEDWRxXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763753042; x=1764357842;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/aIpVd/xznu+0FDgqVwWaqqBkNbCiMm2W5tkHZEHFk=;
 b=mc0c1nrrOFuWp30fq+u3fF/rKAcKaVFyGoeWCF6ZQIloZyV5PL4E0fgxKgf8R2b+e2
 ZcEvzK5MEFw8xNZc6zMGypoBf0w6lDsbV3zz+c4otIjN1yQsltemrWrEHaWSFz7dUpe0
 WpURX8LrDxYj8MFf1tU3DVMFlfK0BejtrjWWa46imdOpv3UxUfDNmVjrTlOQi1oa6Y7N
 LbRsicZmjC3eWAwdRkQnnqg5Ps9L0nagVASbMeQV4pzYfWSptL6u27aU61pJh3YhV08D
 hpo1O+mxHicxjktsph4NE0Ao+SHm61NKoSJ7jvJhYLHmRIUEy8Du+RfLRgJ8vBdFEuJQ
 hFsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWZJ4EHsGl2QHn/NxePhOLSoQGTwM4sKtmaCbMqEtSSrFVH1Z6dUgY8ztrgKYBEnLV3HH7wec=@lists.denx.de
X-Gm-Message-State: AOJu0YwR0FOwrB16JSTU5+wUo1u2r9e8zlUbt3pw7vMYBeOtG/usIexl
 Hc88dwiCHUteEV9lZgftM44+6femlAn8k+UEECERZ6etHimOsg5MogkvvI4sp0j+0d4=
X-Gm-Gg: ASbGncsGOY3rTM22ig8RJFAeL4I4XLA2XBt1JV5O8A59C3VOA65NUbOuZTXqznjiwxe
 f47BELUnD9OPlO1NxeqwPExGLnkOUs+ywdB2643fuyEP0dpIKLMHzR4KmIXCvgeehZWpPfzeZxi
 2/Cw221t7aD78mDqO996Ihm5EXL4z1ICm0vs4foBeMAYtZzA/HquGRM5qvWQVWkwfE5qYqLIK+H
 RefdBVI4i21vvEZI1kMb3vOS4jtdp/0HxjjXIZayORFNX/7mZ1H/z2K4SpoILL8aN0DPB3BJRzS
 UUmAxaJuigajudTxuT451NtbV0yYhPvtaqgJvjE73/KlQ9DUGffZq/f3DVbE+tL9gIfrDUVtuU9
 0AI0trqmyCMkdWaAgVAqOQVxdLaILnw03ZYQpysMMQsDhRnzvfvsCDxbbkqLFStJTdC4x1QIEfq
 wMOvLKZPT03cxNsjCSW55foFFweS14K1d0myoMwmCUoa9/HXqyqA==
X-Google-Smtp-Source: AGHT+IHhuzDX7kD5piPZRMmJKdW4Cz7NWP8fe9YwTWSjvk47Jc7y3/nQZ8fH058Wj8FUMn2fZI0Maw==
X-Received: by 2002:a05:6830:4494:b0:7c7:5f6e:f26e with SMTP id
 46e09a7af769-7c798db1c7fmr1673859a34.24.1763753042019; 
 Fri, 21 Nov 2025 11:24:02 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d3e2c1asm2595395a34.14.2025.11.21.11.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 11:24:01 -0800 (PST)
Date: Fri, 21 Nov 2025 13:23:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Heiko Schocher <hs@nabladev.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] i2c: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
Message-ID: <20251121192359.GC2125796@bill-the-cat>
References: <12ddeda7-f0a6-4cc8-8728-ba979cf6cc49@mailbox.org>
 <CAFLszTghtOKZWaVZH+hYdWvwUWZUTVPZ_mqkW3MCHRH6wRN0iw@mail.gmail.com>
 <b7063159-f5d0-4f8d-be35-2e7fa5f8f750@mailbox.org>
 <CAFLszTjyXo9yh6Jzdaev9GhN8OZ4Z5xz9phgNHnKCvA0ASzbaA@mail.gmail.com>
 <60b12c96-4e63-4cf1-8c27-25eabead529c@mailbox.org>
 <CAFLszThg+6LdxHXOYy9x8-nat+bsspbUT8Dg_vqnmx62aO0a2g@mail.gmail.com>
 <a8fa7ff0-1324-4213-b45b-b4df637e6bee@mailbox.org>
 <CAFLszTgLjRT_x1+tX0xpBzTy9bDJSYXw=5gOBvvNSqdOZDiZoQ@mail.gmail.com>
 <c75bacd5-532a-4783-9f1f-02884eee7918@mailbox.org>
 <CAFLszThKSE7v6TJhfeP2jGTS=GkpVuDpYHNHh_fMFL9TSjrnqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gBIc08RU10BdezKY"
Content-Disposition: inline
In-Reply-To: <CAFLszThKSE7v6TJhfeP2jGTS=GkpVuDpYHNHh_fMFL9TSjrnqA@mail.gmail.com>
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


--gBIc08RU10BdezKY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 12:09:21PM -0700, Simon Glass wrote:
> Hi Marek,
>=20
> On Fri, 21 Nov 2025 at 11:01, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >
> > On 11/21/25 6:40 PM, Simon Glass wrote:
> >
> > Hello Simon,
> >
> > >>>>> - create a new VALID_OFFSET assumption (split out from VALID_DTB)
> > >>>>> which checks offsets in fdt_next_tag()
> > >>>>>
> > >>>>> The latter might be best. It would likely be very cheap in terms =
of
> > >>>>> code size. In fact, I should have thought of this at the time.
> > >>>> Wouldn't it be better to not misuse libfdt ?
> > >>>
> > >>> It actually isn't a misuse. It is perfectly OK to pass an invalid
> > >>> offset and libfdt has defined behaviour in that case, absent any
> > >>> 'assumptions' we force.
> > >>
> > >> It actually isn't OK to pass in invalid offset if we compile FDT with
> > >> disabled tree validity checks.
> > >
> > > We are saying exactly the same thing, if you read both of the above :=
-)
> >
> > What I wrote is, that it is NOT OK to pass invalid offset to libfdt IFF
> > the DT validity checks are disabled. This is yes a misuse.
>=20
> Yes, of course. It IS OK if you enable the validity checks.
>=20
> >
> > >>> Remember, in Linux these checks are enabled. We added the 'assume'
> > >>> thing to reduce code size. Here you have found a situation where it
> > >>> breaks stuff, so we should back off the assumption a bit.
> > >> U-Boot also has those checks enabled, SPL does not, and things break
> > >> when OF_PLATDATA is enabled and there is no valid node associated wi=
th
> > >> the udevice.
> > >
> > > Right, so add SPL_OF_LIBFDT_ASSUME_MASK for SPL and check the code
> > > size. If it is too much, add a new level FDT_ASSUME_EXISTS before
> > > FDT_ASSUME_SANE and use that for the necessary checks (there will only
> > > be a few, from my reading of the code).
> > The SPL assumes the FDT is valid, and disables FDT validation in libfdt,
> > to keep the code size low.
> >
> > U-Boot does enable that validation in libfdt, and grows its size a bit
> > because of that (and also because the DT might come from outside), but
> > SPL can not do that (and control DT does not generally come from outside
> > in SPL).
> >
> > That is why these few fixes actually repair the misuse, instead of
> > re-enabling the validation in libfdt.
>=20
> Enable basic validation if !OF_REAL ? Create a new level of 'assume'
> for just what you need?
>=20
> It just seems really odd to disable validation and then try to not
> call the functions in case they will crash. The next person who comes
> along will have an unexplained crash. It's just too brittle.

You seem to have missed the entire context of the problem here. Today,
in upstream exactly one platform disables validation in full U-Boot.
Exactly zero platforms enable any form of validation in xPL. Upstream
dtc has made a large number of changes since v1.4.6. Whatever we have
been assuming could be done cannot be done anymore.

--=20
Tom

--gBIc08RU10BdezKY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSC8SwAKCRAr4qD1Cr/k
CgcAAQDY45Q4azVhyhTmCti4oVqZV2aN02FQjRquJXiOdkXYqwD/caNWjI0YHmCh
Me8Ok+4VOUQWkGfci/Kpc2Ph/zj5wgw=
=Zb9m
-----END PGP SIGNATURE-----

--gBIc08RU10BdezKY--
