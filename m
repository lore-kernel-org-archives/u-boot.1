Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D591C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 19:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6F7082A9E;
	Thu, 15 May 2025 21:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="odJYB38c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66FB482AB2; Thu, 15 May 2025 21:33:03 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76AAD8129F
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 21:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7302a769534so1161932a34.1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 12:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747337578; x=1747942378; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lbvey1dMEir2i3Tqd71E1GBpRrK1sAKaE3a8urqYzeo=;
 b=odJYB38ceXe61cIX4axgtaTexwiQdd3+LDIy+lco8TvEUv/6wJFytK8d7f+g9xttJG
 gFVIPri6yGv7Qv6fG3JI15nwJMa8qMFLOjoIHiMUH4jHexYd0Uhy1D46X123LiXNe0Kx
 OeeJ7URFZIfrJs1nYkPM1pEl+oDnaz5DhGJAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747337578; x=1747942378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lbvey1dMEir2i3Tqd71E1GBpRrK1sAKaE3a8urqYzeo=;
 b=JfIqc/y2AhKHrLvr9dI2xjk8G8euBx9pNelZ3BDbfXRATw1bo7Sl7yjE5FEviNciFK
 Z7SaeoYyviqgSpc6Jo9MyoBi71yROg/QyzYKUKoNbMtQypRlGy3yB1qNymvVoEPNz4Hr
 pTIYC0cljDn4KQiWyjLWr4e+lJ8LM1Pk5GDjiPueGxb2soALSu/Dfsvaabd+Qce8HvgZ
 vSgQvp4i6MnAJatqlcBssjS8yzkdLVhTDz8X2JWUA8n6MuRZsbbAHfXKFEFZmhoaPuF5
 nlg+CUefkCdKsLzipUKK1lMetQHAMYCpfDgt4Z6d/CV+LJ/u81eoAbuIg54MQAt/yxgt
 Z/tQ==
X-Gm-Message-State: AOJu0Yw5CmtJgCaCnxZe3DhZECse+3x5xKykq9lHQb3W7xCu6TkB1vUX
 hokg80tjnGK47ITIXMA0aZDQlErr9N9b0zun01nTAOOAjrQOYpve57TX8cvsA1sddR4=
X-Gm-Gg: ASbGncsXXjhz2CteoRzrOWDROHSkdKhMlRFQqs2RrL5Z1IjnlpmEklStltJodjbU1gO
 Hk7+RUtChdf94ro+7hU3ZGEp12IlU3j+IxsdVe6YNK9VfvPN72zYB3GcI6LdH+OnHfARVYs/lAs
 GBAi+TPy6FAu1NC05BvGtInYbESFtFsfWaU4uM719l/k2EUlrvE16kRerQ1XapSzipcbRDotTs2
 wMGKU1Dh5YVHmxrrGHphw2dhTMSU6mld2Zz3jjRPwASXLToHpIa+/+WCaZfMIhTrf0EEwS9s3sE
 mml2xhOo+UMxULtVSFxVf9ZFJN4cXfrCv466SCTQ+W6v6DAGO0R22hJ3AtMdCf6xnwngfinRJ40
 Nyo3KAyveLCqA
X-Google-Smtp-Source: AGHT+IFbb9C2PaEQ/DkW+zHS4+58eeDc7QOHtNzXLlhmG5ZL6mGyWDcGqz2AG/i8Eor6jpQMv9pk+w==
X-Received: by 2002:a05:6830:3685:b0:72a:449e:2b6e with SMTP id
 46e09a7af769-734f6aae24dmr674004a34.5.1747337578044; 
 Thu, 15 May 2025 12:32:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b60076sm72459a34.62.2025.05.15.12.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 12:32:57 -0700 (PDT)
Date: Thu, 15 May 2025 13:32:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Uma Shankar <uma.shankar@samsung.com>,
 =?utf-8?Q?=C5=81ukasz?= Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v3 00/10] ext4: Overflow fixes
Message-ID: <20250515193254.GA100073@bill-the-cat>
References: <20250510130642.1575114-1-sjg@chromium.org>
 <20250514215004.GC603748@bill-the-cat>
 <CAFLszTi+EZQENhvzVfJfwp1E6g3i5_HzdcFOTaTvhnneMONjBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fJ1sXo4skFTlsMSY"
Content-Disposition: inline
In-Reply-To: <CAFLszTi+EZQENhvzVfJfwp1E6g3i5_HzdcFOTaTvhnneMONjBQ@mail.gmail.com>
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


--fJ1sXo4skFTlsMSY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 09:26:59PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 14 May 2025 at 23:50, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, May 10, 2025 at 03:06:06PM +0200, Simon Glass wrote:
> >
> > > This series fixes some potential overflows in the ext4 code with inva=
lid
> > > or malicious filesystems.
> > >
> > > To assist with this and future work, it brings in overflow.h and part=
 of
> > > limits.h from Linux.
> > >
> > > Changes in v3:
> > > - Split out into separate patches for easier review
> > >
> > > Changes in v2:
> > > - Add new patch to bring in linux/limits.h
> > > - Add new patch to bring in linux/overflow.h
> > > - Use Linux macros instead of gcc built-ins
> > >
> > > Simon Glass (10):
> > >   Bring in linux/limits.h
> > >   Bring in linux/overflow.h
> > >   ext4: Avoid expr in declaration in ext4fs_get_bgdtable()
> > >   ext4: Create a var for the number of blocks to allocate
> > >   ext4: Check for overflow of block count
> > >   ext4: Bail out of no_blk_pergdt() if there are no blocks
> > >   ext4: Replace multiplication with an existing variable
> > >   ext4: Set a max limit on block-size in ext4fs_init()
> > >   ext4: Make sure there is at least one sector per block
> > >   ext4: Check for overflow when allocating tables
> > >
> > >  fs/ext4/ext4_write.c     |  25 ++-
> > >  include/limits.h         |   2 +
> > >  include/linux/kernel.h   |  12 --
> > >  include/linux/limits.h   |  21 ++
> > >  include/linux/overflow.h | 443 +++++++++++++++++++++++++++++++++++++=
++
> > >  5 files changed, 487 insertions(+), 16 deletions(-)
> > >  create mode 100644 include/linux/limits.h
> > >  create mode 100644 include/linux/overflow.h
> > >
> > > --
> > > 2.43.0
> > >
> > > base-commit: c5a631df96de7421d10ee03dceed1b79db213026
> > > branch: sec3
> >
> > Since this commit isn't mainline, there's nothing further to do with it.
>=20
> If you'd like to review the series, please do. I just checked again
> and it applies fine to your tree.

Then you shouldn't have based it on your tree to start with. Having
failed to apply the otherwise almost trivial strim series, but it failed
because it was against your tree, I'm not inclined to look at anything
not based on mainline. And this is feedback others have given you as
well.

--=20
Tom

--fJ1sXo4skFTlsMSY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgmQWIACgkQFHw5/5Y0
tywwvQv+I4MUD/3mpAvWi2iyxhp7wgOdEN7Y+/O2Tq5B0ohlH/ziu3N1PseSJRbn
oD0o9+RLCBBrJjz8PaWVFAJ1rU+SCy3sFsDWXIEVmANh4OOdYmjD+BnX8xmHrZWd
0MfJaBfuHPNQ0oDdvPY/oy+VPGY/RCQwv24tBSUadG31vGNbcQ0mBwr95Rhrm6zv
hXW5lA02RA1tcVicGhnMvKPC1iPND3oGzOiuuO53T6T1C7GAYr1Qckg6JgVDyWYt
6Viv9FzlJK2Jap9TYjqgSiSxN6hw73iKy5/c4w8n0uER47nl4FGSfKu0AzFWTNAN
7MYBIIWtb4EBKCEn4TQ+TjEzKC24x+AiTBfjhvmQWsxsy8vdr9TKMWkwLBjXqbKG
bUnGEsxGrFiNTaQbnTrrqav2PzaAd1TZUxBCvVXG5cdSjgkV+v+NttqxsuUy39sy
Mw2qWjja0SbDgjVTk+Hz/m91ZncSbMKYblAZKGp88gCfgf3HscYFlwoFTG1QaZqK
757noMJo
=tsfb
-----END PGP SIGNATURE-----

--fJ1sXo4skFTlsMSY--
