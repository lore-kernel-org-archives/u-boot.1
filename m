Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7506AC7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 14:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B6D82CCE;
	Thu, 19 Jun 2025 16:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qydpg2vn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3410182CDF; Thu, 19 Jun 2025 16:36:48 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 809DE82CBB
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 16:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2db9e29d3bcso284298fac.1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750343804; x=1750948604; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3wKCZfDo44RviIDq2RdqqBW4feC/zdtiO+NprGt/x4=;
 b=qydpg2vndkCRw3i+wqSU6LTvIi2WNHuyev/jJ3POvb7cbe8+A9i56niOLN3vSSJmj5
 gabvhxubhNrkLC401hOVJHOG/hLZMzcAjhCLgl06dOOWj68Dm4o3I/IhkrbhfRRau9g2
 Lt8KCOwqVr02U6tIH0kUPq+mb/0JcwMUxeR1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750343804; x=1750948604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3wKCZfDo44RviIDq2RdqqBW4feC/zdtiO+NprGt/x4=;
 b=tNRjyixE2fMKN0icjX2/IPhOjggAfMQywTxeSn5vjDvQA718Wo/hgNQp6M9CAJ4JnF
 zUceZg1dvaS076fKj8L3aTvQ4e9UxAWGAi/QOZNG6J8jt9BSCwp9Iu1wrXWGD5vtSPDY
 PeLngUheNFXOh1eSUBxM52iRs7QvnKX5nrAXM7yxPYL4S5RRz0KVzdJLPh/t4Xf8HN8s
 tpXWvdAqaafodx5/MlnSPGLnxRk2T3fWw4mf5b8RUU4WSUKtTQ6ryC3HuCrdRQ9Nhey1
 ddQEOy4W4785K/hDppuElkBqX8svYnOcATjZAEK07di/sLOmMLMKFpviygee3XfEinHC
 pvkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYkT7pNawR5plM/PnX1CAv3Kem2Y+R+n4NucnxoQShbX18idTEtXrTFbzTc6uqzPhqrG8bpaU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzy0sdMyxurD9gtltyPq38DsA5jf7rEm94DvmWKKlzg1ObR6Uav
 sMOHIy3I7wv5b6DuQLDp27pOh4NEA3jZM1kYTDepqXgBEG+j+UBkGer04JH0aX/A57eCuGwXqk/
 1EV3WscM=
X-Gm-Gg: ASbGnct4jwMGX7wbQrWMFve8hrBI/n/+/5spPfPvinfiiiEL3usEKnZCbLFTECy7IhL
 Av6tmGnZeTKWvKbFlRQ8q17LhBuPzX3+8k6kuGbbVrF9CP7xaSysL0MoJiqV7KQRwcprRa5JG4N
 pjzC9oDpUpDaT0TGbXenvvBHZU+DvL0YzpFmwF3wK5Yq2qhbMCFG7QmoBS7fXi6VQT3KMELlnaE
 WBl2d10bEnCkR0V9YlbSXEoRe97SGdyhqBOSctXGEA9UlzMBTmymHFnnUlEhQ/XuBnkvk/RWfa7
 /lcMi2bmmJJ/782McGKBjt4UcSVVoRg3l5sMr6Ba9xnjAKxcIHfNN5mi+OyxLavnDOAljYPvueK
 LUfQPG610SwSBjgigPpni+Ec=
X-Google-Smtp-Source: AGHT+IHVoquuSX5KOWHwK5/9plfdajthM+cBzEZlbuQ2SBDK7XdJJV1BbdWx9v2mj+lrv3De+QRkxQ==
X-Received: by 2002:a05:6870:5d8e:b0:2d5:2955:aa66 with SMTP id
 586e51a60fabf-2eaf083516dmr12559388fac.1.1750343804192; 
 Thu, 19 Jun 2025 07:36:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eba62252b1sm359688fac.40.2025.06.19.07.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 07:36:43 -0700 (PDT)
Date: Thu, 19 Jun 2025 08:36:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Cc: Michal Simek <michal.simek@amd.com>, vtpieter@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH] Improve user feedback in case of FPGA bitstream load
 failure
Message-ID: <20250619143641.GP6521@bill-the-cat>
References: <20250617092333.335908-1-vtpieter@gmail.com>
 <eb9be150-5298-4929-94e2-ace2f095eb84@amd.com>
 <20250618135728.GA6521@bill-the-cat>
 <ef7de176-5beb-4a7f-9663-a2757b85b86c@cern.ch>
 <20250618161622.GG6521@bill-the-cat>
 <405c6a76-d2f2-4842-9d0c-b74888834c78@cern.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bHOJDUCrIUOQt55t"
Content-Disposition: inline
In-Reply-To: <405c6a76-d2f2-4842-9d0c-b74888834c78@cern.ch>
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


--bHOJDUCrIUOQt55t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 09:30:24PM +0200, Pieter Van Trappen wrote:
> On 6/18/25 18:16, Tom Rini wrote:
> > On Wed, Jun 18, 2025 at 05:44:29PM +0200, Pieter Van Trappen wrote:
> > > On 18/06/2025 15:57, Tom Rini wrote:
> > > > On Wed, Jun 18, 2025 at 09:15:54AM +0200, Michal Simek wrote:
> > > > >=20
> > > > >=20
> > > > > On 6/17/25 11:23, vtpieter@gmail.com wrote:
> > > > > > From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> > > > > > -		debug("fpga: incorrect parameters passed\n");
> > > > > > +		puts("fpga: incorrect parameters passed\n");
> > > > >=20
> > > > > I think all of these should be moved to log_err that you should b=
e able to
> > > > > control verbosity.
> > > > >=20
> > > > > Tom: I think this is where you want to go right?
> > > >=20
> > > > Sounds right, thanks.
> > > >=20
> > >=20
> > > Right I will amend accordingly in a v2.
> > >=20
> > > I'm trying to compile now that it's more than some tweaks and I notic=
e many
> > > (fixable) errors in the drivers/fpga files such as missing time.h inc=
ludes,
> > > spotted by gcc 14.2 (x86_64). I'm on the next branch.
> > >=20
> > > Is this due to my gcc being too recent or is something else going on?=
 I
> > > don't mind patching these in case that's welcomed; let me know.
> >=20
> > Just further changes on the next branch which your changes are exposing
> > I guess, separate patches for them would be much appreciated, thanks!
> >=20
>=20
> Thanks but that's not the case; I switched to the latest `next` HEAD which
> is your commit ce2a7fcb and I get the same error, see below (one of many).
> Maybe due to my config in which I enabled all FPGA-related configs? Is is
> there a `allyesconfig` pipeline somewhere? Sorry I'm new to u-boot
> development and I don't think patchwork is running pipelines. I'm further
> investigating, I'm probably doing something wrong although the gcc errors
> are correct AFAIK.

Yes, it's related to changing the configs and no we don't have an
allyesconfig option in the pipeline. It's still somewhere on the TODO
list as there's a lot of issues to sort out there.

--=20
Tom

--bHOJDUCrIUOQt55t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhUIHUACgkQFHw5/5Y0
tyzZ3gv7B7SPCAP634wGF8mQpIRVIobpaDi/vDyEB8yM9DJwMCo0IEMj5gLDoZ3M
q57bzkS/me5CpLVV8qcAF71jm+LCxWDvwC97Czd7SjqvtYX4765IrAam4OMysIPV
bWJPtgEQTdodc1CwfzIhEMCCn4jlQY2NN/FMcdPcDfVWpeBVNfzI46jJnv63ns+o
+iOxAuVt9QNaNBfFbmppkYXBMk9mrMZJwGcKMRWcq8bP57PHsIoyJAhbQE7jkGW1
WMEIXhduYpPHMNXB4nmKSdIJEqC+s9kPs2vcVztKomAtFAtJCUK2K/J4rNDnH+2y
mLu+lhHA1DC+/bTLng1iI/8CsUpOQFVYgtAQ5qVb0uEs3UBVypvY3+MLIcZprcYA
g5e3hjL1zTTMyeRsYVRnxkT/cP149B+eiiib0JOEP//qgbV/gSdtW/OQBUYqEz/U
uvlyG7Cu3wu3BUADnlXvuMnzMH6StoO0DBHV32Q6KCjqaG29PQwIWfIz1Nb6WRNa
cHul95bu
=UqLj
-----END PGP SIGNATURE-----

--bHOJDUCrIUOQt55t--
