Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3BAC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 14:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FC0680C6F;
	Sat, 15 Feb 2025 15:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iBPqCxAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BC6580C77; Sat, 15 Feb 2025 15:59:31 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2812580756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 15:59:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-220dc3831e3so41488035ad.0
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 06:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739631568; x=1740236368; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pmV0UKCbmWMdg9i5Mpc7ss3DIJ396sevXj8nSxJ3ex0=;
 b=iBPqCxASD4FpDn2rt337sLgDNnwHzl44UZO+IaD+nvG64qUab3sPDIiyX1fSg3XQUQ
 TfMWPnsq4heHAl/lphVE7h/hQQQUHhj9lyrLGNjOxjjbMwkEIlv6j88tzqrZeyzP8pG1
 GuRi8FOBdM74LFUfnplSm6OgrR7itHYw7p8lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739631568; x=1740236368;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmV0UKCbmWMdg9i5Mpc7ss3DIJ396sevXj8nSxJ3ex0=;
 b=S8/E6Olj41q2eqaPQwmR7+MFu8bWP5Pfg0x0B8SBHw2dYSECiWzFjS8mMI+Acv0Ttd
 9VFAXDEYHAG+gk3o7NH1yhW+UP2aAxZ8iiezSTE02raIbVNVP4YurhI0qHZUx5k7PIu0
 AengehWLGIH4wKWUIq8BQlbqtnH+PUg+0dI+bg8xBstpJM8bv6PZaLHi3vEfqKB7ejTF
 VrjJnkrn/9rUD9pgw6ryt73eR/ugvJwL0hTYivfCkzyxP7BCkPxJvpcz7am32XHdl0rF
 ArYxTVKu5UfF3LQLgcjsNvjaoXWfd1VWoPcA1d/GPDMy0oOItYJ7ZbC3K0A/4egSRz5L
 UxkA==
X-Gm-Message-State: AOJu0YzHhGJnZSsN2YHVWsvrUKYReDyFuGiTDf7P2gBW8YhluMTqXx8+
 JLVf+jAwhl59ziihw52g/Ri+WFTT+4oh3J7heeYrcmDiRGUIy6iXvAQn1lWxJtNDIIoakMJ6WfA
 fqkM=
X-Gm-Gg: ASbGncsLDJU4mBCmYXSnvMkpU3lMxuD7AaatRgWw0RCKpClTiDDinkw2er6HcJi8lUm
 bkWEuYsVfjNUDzHIZ6RPdlWuvfKqXK5wPMacS9a/fFXbGBJ2G8PnrMBgYtLIeXLVQ0TOwJCn7QF
 Kwr2XwYJJozPU4kIPXoSj8HK4EZZLzgs9S4Y9gw1pKiQpbMEqzcJiZKntcZ9csuBTJTDatiqX/j
 6GLkv/NXHbZQ5eexjnKMi5Uf4NYxwokjM1Py5FTo3PiqxEhK3XsRKkRIlZZxN0HTYt/npmLn//d
 hlFJExkfVbl8wQ==
X-Google-Smtp-Source: AGHT+IFJ/u7xRKIf/ix9eRbdkCSyKvrNyiC2y0o+8s754B6GR6COvrukjFpGy7edylzqo6GPp0oDHQ==
X-Received: by 2002:a05:6a20:7351:b0:1ee:5cf2:9c01 with SMTP id
 adf61e73a8af0-1ee6c61abe9mr18074892637.5.1739631567616; 
 Sat, 15 Feb 2025 06:59:27 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-add21f2149fsm2356126a12.1.2025.02.15.06.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 06:59:26 -0800 (PST)
Date: Sat, 15 Feb 2025 08:59:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>, Levi Yun <yeoreum.yun@arm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v2 35/35] bloblist: Allow using a different bloblist
 address
Message-ID: <20250215145923.GR1233568@bill-the-cat>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-36-sjg@chromium.org>
 <20250210143312.GB1233568@bill-the-cat>
 <CAFLszTiX-rNzEmrLOZ4PMMa9m3fHiLkchbJ=xtGh3RpZLmZ6Cw@mail.gmail.com>
 <20250211140755.GA1233568@bill-the-cat>
 <CAFLszTj+LnHXX5E1Yh8hqzu_uc2c1HeyzqCxOdAUu1XQBO0W0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L4GT2UKQI1TBEh6c"
Content-Disposition: inline
In-Reply-To: <CAFLszTj+LnHXX5E1Yh8hqzu_uc2c1HeyzqCxOdAUu1XQBO0W0g@mail.gmail.com>
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


--L4GT2UKQI1TBEh6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 04:58:24AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 11 Feb 2025 at 07:08, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 11, 2025 at 06:09:03AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Feb 09, 2025 at 02:14:56PM -0700, Simon Glass wrote:
> > > >
> > > > > Where the bloblist is located in internal memory and TF-A's BL31 =
blob
> > > > > removes access to this memory, the best option seems to be to rel=
ocate
> > > > > the bloblist just before running TF-A.
> > > > >
> > > > > We can do the relocation in board-specific code, but need an opti=
on to
> > > > > pick up the correct address within U-Boot proper.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > > - Move the actual relocation code to a previous board-specific pa=
tch
> > > > >
> > > > >  common/Kconfig    | 20 ++++++++++++++++++++
> > > > >  common/bloblist.c | 15 ++++++++++++++-
> > > > >  2 files changed, 34 insertions(+), 1 deletion(-)
> > > >
> > > > I'm going to NAK this whole concept. The whole nightmare thread abo=
ut
> > > > these platforms comes from using a fixed address. We need to pass i=
n a
> > > > bloblist or see that one is not passed to us, via register. And the=
n use
> > > > that mechanism to pass the bloblist to the next phase. When we don't
> > > > have a bloblist passed to us, we allocate one, and not at a fixed
> > > > location.
> > >
> > > Well I understand that Linaro may be doing some work to head in that
> > > direction.
> >
> > Are they? I don't know. I know Raymond was doing some clean up based on
> > the idea of treating bloblist and standard passage as two separate
> > things. Which I think is a terrible idea, despite suggesting it. But I
> > think it's also the only way to make progress now that you've decided
> > you can't work with them anymore.
>=20
> Can't work with who? Linaro? If you don't allow me to create patches
> for bloblist within your tree, what am I to do?
>=20
> >
> > > The 'piror-stage' stuff is what has made this all too hard and
> > > confusing. We should think of things from a U-Boot perspective and
> > > make that work. The new case can be handled by standard passage, along
> > > the lines that Raymond suggested, i.e. just checking for it first.
> > >
> > > For x86 we don't need this path as there is no bloblist in TPL, i.e.
> > > it can be placed in DRAM from the start.
> >
> > A fixed address is a bad API for the U-Boot case and is what makes this
> > all so confusing. And no, we can't put it in DRAM on x86 either, that's
> > what had coral broke until I put it back in CAR.
> >
> > Please explain why a fixed address is a better API than passing a known
> > valid location via register, for the U-Boot case. I don't like it
> > because it means that we cannot always safely check if it exists.
> >
> > --
> > Tom
>=20
> Yes I would rather pass the location via register using standard
> passage, at least on ARM, where we have a suitable protocol. For now
> this is the only way for me to provide a series where VBE actually
> works in the lab.

I don't understand why you don't just add what U-Boot is missing then
for passage via register.

--=20
Tom

--L4GT2UKQI1TBEh6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmewq8sACgkQFHw5/5Y0
tyw7mAv/RB6wRD7ZYJo8LylQZjQeRqCi2DoDrO0pwOJYsIBpp4bXofEb8xmB7ek/
i/RwEq8Sqicfolpg/Zyu7hm/ouOIS2y7FQf1zIYA6gdaafV91CzfGvI7snH1A1Li
P0JHTyE+rm7Ahy1Z52KON7eOhT44/Mohi33E6Tk7OFStCYF/66s1s2pQgSq7FWis
NH/nDDKGPWNajuXqIAtN7rn2ZIafLbYOH/ZfgT8AMnhRPeUNlH8NMqVvJKGesWpT
bxaUVcz+Knz5SZeTVebr5WIqG8VMNqh46t/+F5UMPTDZZm5klrmJh6Ph6ZYEwj4Z
KgD7/xLbPSiEsmMns9f55O7PQSfven2Yu3qPi81hzPHH3ab6Dg45FunN93ZsfgUQ
68C1SEGdv37R7TChoXRQOrPGMwb7EqavmH2BDnIkTkcLTByqVWQVZiORyZCliJqq
tGsr2bBClbX2CFuLUv0s/NgARds5Bf1Kwv2jvQv9hW0ifB2vLM2lAsjxYU2yXqGp
TIEvUQxV
=hqeN
-----END PGP SIGNATURE-----

--L4GT2UKQI1TBEh6c--
