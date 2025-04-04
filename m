Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC18C3601A
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 17:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32389829C3;
	Fri,  4 Apr 2025 19:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="akZb9HzZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C7582A16; Fri,  4 Apr 2025 19:55:42 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C968215B
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 19:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2c72cb91e9cso1895205fac.1
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 10:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743789339; x=1744394139; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UnNbzE33DTzHPwYOiMcvwTX99K+lMBMg5yg9XiZyi78=;
 b=akZb9HzZm216GZqKwVJ8Lz9rf6N0b3ZLlQVW/MIkp6v+n/MC5h6MS1hxHExz8HZByK
 w2mwNl6N/JERbCjzdVa2K3f8320zNdknq4ff9aeqcSLmWsArL/RJeACWxdnEF0TFMaQp
 IJUMq7FcfCNB5Ls574yaoaepYOggGaZJJMVG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743789339; x=1744394139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UnNbzE33DTzHPwYOiMcvwTX99K+lMBMg5yg9XiZyi78=;
 b=uqW+zoM0W3bKvWxJiTuP+gujtnd/e6Swp3v1scqTarOS7OBlQ0QVv4jTt0T8rfJBzC
 zvzYhW4tQVyZkE8s59NJX1/nNRI8c401y5i8WFTCqpz9euN9s1qEl56QAP1hjJkb6lEI
 q/7KGFGnBmzFv/nF7unfQl5AnUcSgPFOFEGcwtUAGlLYHwqjEXcSrYWjfmmjX0hVJZ7X
 lDDwvVZKEugF7GqbyLCzWTff6C9PeP347HKbDq/L8iTiExwFjDuA/kyqwONREHF8tiNI
 QP78OUCp3/6KHBjbmEkcOexFxGKZLwfB1l/rWrsm7JduY5o5AZgeX2p1M6CVTo18tZp8
 GgDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDdl5W1rErnpS5emUuMW4bstu5Z3JWToThSbmR+mjvZHefFwdUXcZVUcEN3apXCvk3iRNTaEs=@lists.denx.de
X-Gm-Message-State: AOJu0YwDd0tnrT0eOAHR8C2CQSK17Mk0RDC33z4Ysnl8rJWzD4VhqunI
 F++2upEvNkYz/I3CADihXbex5+18sMmbW3kHIBtG/+nMAF5f07SFM1Kiex4bmp8=
X-Gm-Gg: ASbGncvic7/o989abJlHr+LzrQiEYcM9d4cttpEf62FkT5TcGN2yMLNLUb+Xmo+1mlq
 BYkJlxGT0M2gwO5tqnqXs+yziRTOCCcgVPNhXfbq0QlrVQbXcqanL7RJWi3xq8omVMYCpWYFZ6z
 ULwZgV81rpYJWKSBCHQvKKbDcp53DewLBR5cjyZAP1/yVp8YRLC9MSmPMJY5c7x7KyQdmdS7V+9
 mUO2+MBS3WShvSjxpoGD2l4PA6kb0aKC2dUau2t3s5p9nzWrY0XMWOwVSl6DU6EsKi0EfJh2wTi
 fODJBnlnb8EBLDKeJTI30TP2PXm4VsCd8J4TGjLb9o09O6RoL78p04zRF2ZqLT/xJ9CQnlYKHNg
 TmrhiUg==
X-Google-Smtp-Source: AGHT+IHvRMqi8FGBIubijVIHoCQ69vILlBGTHGqBUoM9eUgn9UKn0ugTnYQilR3LMwt2usA9YpJW0g==
X-Received: by 2002:a05:6871:8082:b0:29f:d993:a4cb with SMTP id
 586e51a60fabf-2cc7a88e9afmr4795696fac.14.1743789338863; 
 Fri, 04 Apr 2025 10:55:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc845c69d6sm818468fac.13.2025.04.04.10.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 10:55:38 -0700 (PDT)
Date: Fri, 4 Apr 2025 11:55:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@kernel.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
Message-ID: <20250404175535.GT5495@bill-the-cat>
References: <20250328154401.3563921-1-sjg@chromium.org>
 <20250328161845.GB93000@bill-the-cat>
 <CAFLszThKn0xTmLdR7Hs_oKO_paYTtr-Y1xA_eoNY2rcjeuHX9g@mail.gmail.com>
 <20250329000211.GH93000@bill-the-cat>
 <CAEfUkUJo6AA_SESSYj6Bgq=tUHRc5MQ+sAqtURkbNRafK+=SiA@mail.gmail.com>
 <CAEfUkUJOu_nw0j3EvSpAgrSZ+wy_g=CLdY5yo9uWuc6j3NfnbQ@mail.gmail.com>
 <CAFLszTjo8HEzKbZAbO=neF57e69vGbWYsDVV_dD=kO6j_VH39w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9RP6P55oZIvZmLY/"
Content-Disposition: inline
In-Reply-To: <CAFLszTjo8HEzKbZAbO=neF57e69vGbWYsDVV_dD=kO6j_VH39w@mail.gmail.com>
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


--9RP6P55oZIvZmLY/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 05, 2025 at 06:40:08AM +1300, Simon Glass wrote:
> Hi Raymond,
>=20
> On Sat, 5 Apr 2025 at 03:49, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Tom and Simon,
> >
> > On Fri, 28 Mar 2025 at 21:00, Raymond Mao <raymond.mao@linaro.org> wrot=
e:
> > >
> > > Hi Tom and Simon,
> > >
> > > On Fri, 28 Mar 2025 at 20:02, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Mar 28, 2025 at 11:38:14PM +0000, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 28 Mar 2025 at 10:18, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 28, 2025 at 09:43:54AM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > The bloblist code took what I consider to be a wrong turn a y=
ear or so
> > > > > > > ago. As discussed with Tom, this series proposes a way to arr=
ange things
> > > > > > > so that it is simpler to understand and manage.
> > > > > > >
> > > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > > > - Create a deterministic OF_BLOBLIST option rather than using=
 guesswork
> > > > > > >
> > > > > > > It is to be hoped that we can get a platform which uses OF_BL=
OBLIST into
> > > > > > > CI at some point. In the meantime, the standard passage serie=
s[1] could
> > > > > > > be resurrected to give some coverage.
> > > > > > >
> > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=
=3D281465&state=3D*
> > > > > >
> > > > > > Based on how it's documented to be run in
> > > > > > doc/board/armltd/vexpress64.rst in the next branch, have you co=
nfirmed
> > > > > > that platforms using the handoff spec still work?
> > > > >
> > > > > I believe so, yes. I don't have that board to test it though. Ray=
mond
> > > > > may be able to test this series on QEMU?
> > > >
> > > > I was pointing you at the docs so that you would have access to tes=
ting
> > > > it. That's part of the docs, running the emulator.
> > > >
> > >
> > > I can help to test the firmware handoff on qemu.
> > > I have all the necessary changes and unit tests for the OP-TEE repo
> > > qemu v8 build to test this.
> > > I will try to find some time early next week to review and test this
> > > series before turning back to you.
> > >
> >
> > Just a follow-up on the testing with TF-A and OP-TEE.
> > Unfortunately, the patch series breaks the transfer list handoff to
> > U-Boot completely and just end up with below error when U-Boot boots:
> > ```
> > No valid device tree binary found at 0000000000000000
> > initcall failed at call 0000000060097bcc (err=3D-2)
> > ### ERROR ### Please RESET the board ###
> > ```
> >
> > U-Boot test version:
> > 'next' branch + this series + my patch [1] to point fdt_addr to gd->fdt=
_blob.
> >
> > [1]: https://lore.kernel.org/u-boot/20250331224011.2734284-2-raymond.ma=
o@linaro.org/
>=20
> I suppose the FDT address in the register is not being read correctly.
>=20
> Do you have a test case for this, e.g. in QEMU? Even if it is just
> binary blobs for now, not suitable for CI, I'd like to get it in my
> lab.
>=20
> I did create a test back when I did standard passage, but that series
> seems to have not been applied. I'll see if I can resurrect it.

This problem should also be visible with running vexpress64 as
documented in doc/board/armltd/vexpress64.rst which is not yet in CI
(it's straight forward but non-trivial), which is why I was asking about
it earlier in the thread.

--=20
Tom

--9RP6P55oZIvZmLY/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfwHRMACgkQFHw5/5Y0
tyyusAv/aGFDqYsX2JuFN+ZdY2kavXEYiLZXlDpET+ddzBfbe91v3gxJERaiyNGp
R6m69Bkz/dBj57/21NcvEyRW7wlqWDs28756r3eW8AE3zBwd5xBZP0B9tzEnvCHx
N/nOHL5ZgoeYa8YnE0qq4KPsrrNRdIFfp50FZZ2+p9nBwHqjY8uXPg/XXjAf6NKn
Dgsj2C9AQWEPQOovQfKUpaobxub9/uPssTSSefqvYYJK17B6bi2NN1qpIq/RkZFd
iZ9Nvzl3YDFVjzG/aOQqcMvXCLrHetfy4UxABSi1x0zT8o9I1Liy/o/bGTZpcaPn
M4XNA1JT5x7UfZbX6PzyNWlpqNK/AyTD4HWQ08nzr/P7C7OHzAozsqAVOGSPAxxK
SKR3Pqt3uMiAJmMOBLZwXh4q/GSWz3+lsIa7iwd5gR1b1tHaHloz7ld3eKzNXUVk
CI2FBYR7Envshzl5/sFFbDznXJuFZKBmWNV//C72bjR6r1vceGuWQFJhzvR51NP9
xcJarBOq
=I1wm
-----END PGP SIGNATURE-----

--9RP6P55oZIvZmLY/--
