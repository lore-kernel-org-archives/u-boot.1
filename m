Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5DEC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 23:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D504E80EFE;
	Fri,  7 Feb 2025 00:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hb5fO2rF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E6D80F06; Fri,  7 Feb 2025 00:09:35 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AD4580CB0
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 00:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f3c119fe6so26931915ad.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 15:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738883371; x=1739488171; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qcSO2rb7lmr3h8+PSEtaXCB5j6fv8RJYXjFyUCOZhm8=;
 b=hb5fO2rFjsn+asl8n7ZbKkUwpe4Q0+/Y8FNjN8y494kUKKKXPIu68sysszKVcQMwEV
 M8ec/1f+fOVPFBtxh23tE+sDvbUCXiLJ5ZN8W7Eg52xtocRxVsZcq6Cfy9CB7YB55K1a
 XbebPqbuinZdvBkHRb8nw1l2fibcB0EcmfIf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738883371; x=1739488171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qcSO2rb7lmr3h8+PSEtaXCB5j6fv8RJYXjFyUCOZhm8=;
 b=R7IQBAVDNyPniByjsnhD/nEvaCPYIFzLfEuX7yuBjb8Ikvo8DY0mha/jj9h3eNCI4J
 E5rAAiktOH5Htr1zqdINjVnZHOdG7g/kpKao6yxUjURUaxG2E9FLM8I0F3icJ9fbyfxV
 JcHb7oBuRZJjk9QTYnHu2laxXZY2TarGXY8ROpk5GE29R8hgjp5CojWiP33e6vxOKuCt
 nf1i4PLZt+RIF9iTIewdiFuI1ErsFsZr3oMXSa98GaYubhwILrGc5mmOn31fUDw0Cl7m
 qxkk1cY1doHFanog4WIlM+K16OwwB2Cx14XXdeTYRN/CH3CWqd7oeiSWjNoOjCexKr9Y
 yiYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa3Oqs+pCB7FsVC/NNKu40BsE2HTsmKKzPujD0K6b2xuX5b5p5sXm2vV+0j+9Su3VLTiuu6W8=@lists.denx.de
X-Gm-Message-State: AOJu0YxYHN95R8MNo/mAh/t7W+0HIg+BvitAcMPsY/Dm8FHe0w7u/skl
 QyejnNj8yY3ogzFKiBY6L3uXqoIiJpf49xx6gAkWdNjKJhyWHnt8NzFwpZGqMyI=
X-Gm-Gg: ASbGncssiI9gSRpVB4l9eqmd1cWPn0/Z0TzBDO5F+3g0Q+G3RwH7LYFpwigAltlGAvu
 GFTN+CHDEb3MBlczTujJB9gsnzpzPfDWj7K0JzmJVgeFrF+50x3TWndrNJhG1iV3oS2mQGpVZYP
 mbaRmHT5kYAjP9VbfoyQkE6np6gC2DW73bEut8cEpWFi1s8XdQ+RNPvSlFDTadohUoXuV0bkeB/
 0hm+NTqCjOHoP89th2ML7yM4RO7OP3dW7W2UB+1Kf9gVmmgkHDgawYcDa+/SUIJNc82kBw9LrMr
 ciW7jcB7EA4KkxY=
X-Google-Smtp-Source: AGHT+IEFBugn2W6Wn7CYk8sKNWh5DvC22cnOUHn5Ss8JIOObTtqtlfeifsIFHUUsyi83wx9O3tPDkQ==
X-Received: by 2002:a05:6a21:9996:b0:1e1:9f77:da92 with SMTP id
 adf61e73a8af0-1ee03bacb93mr1735867637.33.1738883371556; 
 Thu, 06 Feb 2025 15:09:31 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048a9d179sm1830603b3a.27.2025.02.06.15.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 15:09:30 -0800 (PST)
Date: Thu, 6 Feb 2025 17:09:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>, Levi Yun <yeoreum.yun@arm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 29/29] bloblist: Allow relocation at the end of the SPL
 phase
Message-ID: <20250206230926.GL1233568@bill-the-cat>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-30-sjg@chromium.org>
 <CAEfUkUKqhf0Y9v9U9bTw0A3_odkDVpbfXLKM08qtrcdARyOsbA@mail.gmail.com>
 <CAFLszTj3-1KSRqgDyvdKFt0V9=Nt8Rksd5+j88Rp+_oAZDKxVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jNUe2gUjCy1igHbn"
Content-Disposition: inline
In-Reply-To: <CAFLszTj3-1KSRqgDyvdKFt0V9=Nt8Rksd5+j88Rp+_oAZDKxVw@mail.gmail.com>
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


--jNUe2gUjCy1igHbn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 02:27:28PM -0700, Simon Glass wrote:
> Hi Raymond,
>=20
> On Wed, 5 Feb 2025 at 08:35, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Where the bloblist is located in internal memory and TF-A's BL31 blob
> > > removes access to this memory, the best option seems to be to relocate
> > > the bloblist just before running TF-A.
> > >
> > > Add an option to select this behaviour and provide a relocation addre=
ss.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  common/Kconfig    | 20 ++++++++++++++++++++
> > >  common/bloblist.c | 15 ++++++++++++++-
> > >  common/spl/spl.c  |  9 +++++++++
> > >  3 files changed, 43 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/common/Kconfig b/common/Kconfig
> > > index 0e8c44f3f74..962e7fd76eb 100644
> > > --- a/common/Kconfig
> > > +++ b/common/Kconfig
> > > @@ -1125,6 +1125,26 @@ config SPL_BLOBLIST_ALLOC
> > >
> > >  endchoice
> > >
> > > +config SPL_BLOBLIST_RELOC
> > > +       bool "Relocate the bloblist before existing SPL"
> > > +       depends on BLOBLIST_FIXED
> > > +       help
> > > +         Some platforms locate the bloblist in SRAM in SPL. In some =
cases,
> > > +         the TF-A BL31 blob removes access to SRAM, e.g. with Rockch=
ip RK3399.
> > > +
> > > +         Enable this option to make U-Boot copy the bloblist from SR=
AM to SDRAM
> > > +         before leaving SPL.
> > > +
> > > +config SPL_BLOBLIST_RELOC_ADDR
> > > +       hex "Relocate the bloblist before existing SPL"
> > > +       depends on SPL_BLOBLIST_RELOC
> > > +       default BLOBLIST_ADDR
> > > +       help
> > > +         Sets the address to which the bloblist is relocated at the =
end of SPL.
> > > +         U-Boot proper uses this address when it starts up. Note tha=
t U-Boot
> > > +         always relocates the bloblist again as part of its own relo=
cation
> > > +         process.
> > > +
> > >  endif # SPL_BLOBLIST
> > >
> >
> > I think the relocation you mentioned is a board-specific behaviour and
> > should not be part of common/Kconfig if only a few boards use them.
>=20
> Where do you suggest this code should go?

What we need is a generic way to pass the bloblist we allocated in one
stage to the next, without saying "Ah, it's a fixed address". Then we
should just normally have each stage have a bloblist in a safe location,
as needed.

--=20
Tom

--jNUe2gUjCy1igHbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmelQSMACgkQFHw5/5Y0
tyyPIwwAnuuuYeEMppXYh8rKB9bAiAtDs+iWaJ4KRXv1HmnITw2+Okzx/ZFzxb3M
r6fdp+TwcfE63KtUVXtBrb/ndKBqKF2QmhmKCePEzoSAj7x08mN+8biEYm4QxvLh
m3UwK/pu+a7rscHU8ZCSxHLk6gI18AH320O/jKcznZxUdebEPrCDwyA1TvjNyKCw
D27mvxlCjDmArAmcxKzKI0X3jUOGxB67S8e5Id0VU1xGifkqa/s+lUmM9SNwG0JW
/E+Pqp7axJMzawfUSufN0cctofZW35J9wpzubnuTbgzwrPU0c+cGSiuWatp9lRgA
OKkKmAaysyNkIsAx5uzn1jB6B+9Hc6KX0xKkyE/cIUecoXlm/uOFz3OuSOV8J0FN
uw6zI4UnnvLHcMMra6p7F9IGILJCw4hMzeSyPJER+LGIPz1Fme74Rcrz4VHhVxsO
MMZaJfhNVlGVPbv5PcmLqqmIBPo3+4Nt+G86sFhvw6OEVNdHCeoWwy2NPf4M7X9/
UJaCAjod
=CNty
-----END PGP SIGNATURE-----

--jNUe2gUjCy1igHbn--
