Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2A5E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419DA801E8;
	Tue,  7 Jan 2025 16:11:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GIlGzGJo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AFCA8036B; Tue,  7 Jan 2025 16:11:41 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3C40801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6dce7263beaso137880736d6.3
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736262695; x=1736867495; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sdE7sw68jVDE84wXeB3tm612mH5vBVdTVaA6lH+oGfI=;
 b=GIlGzGJoPNolhC1CgLbqNm2RgN6QbuFRnibEqSoLTrKWyTURA3S7z1SK+qUnq7GU2s
 MbRWIP9lF/O8+3T3rpVbWs1vIWL/d/4rOG+cchRSgsD/znU93qMIY9ikye9dWpj49/zd
 oqATG3xQdZUE2Z92+Hp+DTXHp2R1/AU3nrGQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736262695; x=1736867495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdE7sw68jVDE84wXeB3tm612mH5vBVdTVaA6lH+oGfI=;
 b=HQNsW3k+2GTbvVqkaKUEaFUnZwtkL5iuawNIDZHhVcZeIG5QcaSA2o9V3Gq4Dkck1D
 P2fs5HvBx3bgod5bT4BvgsIbxV/dshWTZ3saXpNY+k4VnzXZGc/+f8A0WU2RENhUHxBU
 Wzx7N7zfLMHUMXGCyMDN3MVA1pre2DC0rXBaFfTO8VDaPkFCg+GCz6w9t5HDjV672wuu
 qgMu+KQbQ2es+mSxqv2x6KsrDdXWDmKggGBVgORI2OF8XaUfiRkIkq0XWu3lhKbuP6IX
 XX/J3E6JXIkUr5IFAjPoWfkVEE7S6O+ep3zAAEDTCh695nENwYA8Pen3btA94YzyJLMo
 bZlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDbRgsrmgpl4mobmO8kCaPDxXDvH65MXp38ChBJu8ws1FoI+UvqUKWRXtrgoUGY4p6c0O78WQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyUgyOrhZhqfmexYRq0n4+wMRStM987kJgS6CoGg9B7XHKrKiWd
 Uc7YuSm+nLph/A8JzBK3N/B24A/ue9kMpmlfZRIhyirGIS75DzIN2SV8VOBQCRI=
X-Gm-Gg: ASbGncu4XYG0ckPPHu7CUVPuYBcVLRHdoSF/LjL6ROfFadfARUvgHV1NfN7hCZG/NP2
 ssrCJUvnNTNE8ecC6SMIxkS4Z2GDwGRrgzt2HInzVbCFYI8JIOJ7f+aqiM7NYUmt21xxU4WpWR3
 xUTXNZ1dpU7O1mqH9Rog3oVns/RJL89NumbDNcMIOzJKkS35Se5jho0ol1NSvWTB9kv9s1fis2a
 6ka4MpwbGbTIxKDQGCDBtgGqZih05+q2w1NTmRPTMggB50MYV8moLE=
X-Google-Smtp-Source: AGHT+IGu0ooCGlnPsbdUOPEYnsfz5D+DSqeZwBhnJz0Qt8TVXjUuIx87YLuQJ64JLDO5Hsz7JzjytA==
X-Received: by 2002:a05:6214:19c6:b0:6d4:2910:7f13 with SMTP id
 6a1803df08f44-6dd23397b81mr929308226d6.32.1736262691290; 
 Tue, 07 Jan 2025 07:11:31 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd22f025ebsm176790916d6.82.2025.01.07.07.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 07:11:30 -0800 (PST)
Date: Tue, 7 Jan 2025 09:11:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
Message-ID: <20250107151127.GI3476@bill-the-cat>
References: <20250106144755.3054780-1-sjg@chromium.org>
 <51c61e63-82ae-4660-b2c8-987a63c7d091@gmx.de>
 <CAFLszTi5dxQyf_wRpGWRz9S7YsETpeRxA3_YJrhm+Lp0uw7bmw@mail.gmail.com>
 <3b854695-990e-47f3-a9b8-34b1b2790d28@gmx.de>
 <CAFLszTieNX4-JJqQrdNdm+sBhnBHZrAwawvQ+J-D3s118uob2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FdTur/se4Q3VLylX"
Content-Disposition: inline
In-Reply-To: <CAFLszTieNX4-JJqQrdNdm+sBhnBHZrAwawvQ+J-D3s118uob2w@mail.gmail.com>
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


--FdTur/se4Q3VLylX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2025 at 06:57:50AM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Tue, 7 Jan 2025 at 06:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wro=
te:
> >
> > On 07.01.25 13:15, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Mon, 6 Jan 2025 at 10:00, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
> > >>
> > >> On 06.01.25 15:47, Simon Glass wrote:
> > >>> This test was hamstrung in code review so this series is an attempt=
 to
> > >>> complete the intended functionality:
> > >>>
> > >>> - Check memory allocations look correct
> > >>> - Check that exit-boot-services removes active-DMA devices
> > >>> - Check that the bootflow is still present after testapp finishes
> > >>>
> > >>> The EFI functionality duplicates bootm_announce_and_cleanup() and s=
till
> > >>> uses the defunct board_quiesce_devices() so a nice cleanup would be=
 to
> > >>> call the bootm function instead, with suitable modifications. That =
would
> > >>> allow bootstage to work too.
> > >>>
> > >>> This series is based on sjg/master since the EFI logging was reject=
ed so
> > >>> far.
> > >>
> > >> Yes, it was rejected because a solution at the lib/log.c level would=
 be
> > >> more generic.
> > >
> > > As I mentioned, that idea isn't suitable for programmatic use.
> >
> > What can be done with show_addr("mem", rec->memory); that log_debug()
> > does not offer or which you could not do with a new log function in
> > lib/log.c that takes variadic arguments?
>=20
> There are asserts in [1], for example. How do you propose to handle
> that? See [2] for my previous explanation, quoted here:
>=20
> > CONFIG_LOG with a bloblist option would be a great idea, but it's hard
> > to programmatically scan text...plus only the external call sites are
> > actually logged.
>=20
> Also see the discussion on the original patch [3]. There was also your
> reply at [4], but I think you missed that this is intended for use in
> unit tests (i.e. with ut_assert()).
>=20
> You also requested that this be generalised, rather than being
> EFI-loader-specific. I have no objection to that, but don't have a use
> case for it yet, so have deferred that to later. It's a fairly simple
> change, if/when needed. If the series was not NAKed, I'd be happy to
> do it now.
>=20
> > >
> > >>
> > >> Tom suggested not to send patches that are for private enjoyment to =
the
> > >> mailing list.
> > >
> > > My contributions to U-Boot are only ever about private enjoyment :-)
> > >
> > > Do you have any comments on the patches?
>=20
> Regards,
> Simon
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250106144755.30547=
80-6-sjg@chromium.org/
> [2] https://lore.kernel.org/u-boot/CAFLszTjxOE_037+kR0jgdax80sBombYo_k0Yg=
iuVnP=3DKZCOvuA@mail.gmail.com/
> [3] https://lore.kernel.org/u-boot/CAC_iWjKtaN54B98OKbkoXkC_GmKJ=3Dx+M4=
=3DUY_O6roSOpZaDxag@mail.gmail.com/
> [4] https://lore.kernel.org/u-boot/D513D326-41A6-425E-B11F-85958065BCD2@g=
mx.de/

Looking at the logging portions of the original series again, especially
if this was made generic, we probably don't want to print to actual
console every time we're making a note of some memory allocation for
example, that would be unreadable outside of a debug context. The point
of this really seems to be "log things for verifying in tests later".
Does that end up being useful? I don't know. Heinrich or Ilias, do the
tests in [1] look generally useful?

--=20
Tom

--FdTur/se4Q3VLylX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd9RBsACgkQFHw5/5Y0
tyxWewwAkfgiBdw/oadyi9QyLU2aIa1k/9mxStdQRTt47+5IdDqFjoF7Uv+kxRUJ
N6gHbOM0O9WOC/8SY/B/SLNE3A0A82mLqqvu2db2afWM6JM47h3AKe4OT61EtstR
3mWTxtOoI4uM5VZEfRC56b2NaPv2zVmPWAWLADEzmyjhsWx0vUsGZ8C7dqunPAKF
7LR2k7j+TvaHsqF6jfbdYX/JsMBsZ1gjzRv8Auyz3nrJtbt14OaeEPxwWgz4esXT
DmPOXH3qeOX9FmjL7NjsX2VSm2ntF//4KpaTs803hcYL8tE+TFygUv3MjWN3R5vQ
IPJUlDXfKo7OJVhfQx8kPRKX0USRBVYPMwXozU/VIKKCA50/VLHvmD0HU1MH2+WK
OjconNyDvLBSBL0AP1VQE1qqc3LwpOh4Lxcpg9GOhffQwS6CroIoJX4MiGb75F5p
9j2slMp30IeHus30RRp6trxtzRQn7hQxb7LZaJCJPfxJdnmbDr3/9YVW6BQ66dZL
VC0SQVaK
=a1gW
-----END PGP SIGNATURE-----

--FdTur/se4Q3VLylX--
