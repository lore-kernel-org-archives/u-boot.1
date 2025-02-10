Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05F3C0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 14:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF4E80A55;
	Mon, 10 Feb 2025 15:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TjYry/VJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5E0680A55; Mon, 10 Feb 2025 15:33:03 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0617180BAE
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 15:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6f9e78593b8so10064897b3.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 06:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739197980; x=1739802780; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vc5PfpYtPdTzntqd9XOEaQW70iVK5lR6LooUscugPpU=;
 b=TjYry/VJa6F/bzdYJyJfqdarF+5Q9RSTV6C1CBZDCPF4BoaV5BJPRicBx37m9jTnnJ
 i25hBfZQPBqTW7Pp3QCVx/GZxICz8xaC4fYtfNH7trFuLli+7WAQXuGfQLhKFAHoqVVk
 lz5lN+u+3pFTa6U8NUU8su5lLHPXvYXHPWPJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739197980; x=1739802780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vc5PfpYtPdTzntqd9XOEaQW70iVK5lR6LooUscugPpU=;
 b=rYcB/hfvvo9QIn1/zLQXmQezeuTusYQewog9GXwnQwuxGwrv0Xw37LML9YIXh9LhFi
 EETEXR+Q6woBIOkWtGcL6zdfIoyuWvXrB/94X2F8C1Jq+/DjJ38gAFAsVVOOSFVF2BKP
 rt/w6Wp7kFGxjKvh1V21Ep57LisDfssvB8OT0QVej5LovDv50mefWVfQs/F+UL1xseFo
 LYMh6X+Np3ZZ/KbzE66qnAlecfaTGOS8Fui/s6UR6Uwom/7i577RFmJpBpcmW/5TizEr
 TtK2aM4z86FQIx1t+8iDYO6Ke6zvbHVjIyXrdb+MrpiRIp8484rYwxGRZIU2mNfVxGfd
 EXZw==
X-Gm-Message-State: AOJu0Yz06Qg3nryY9mSf2W0fAt2UUFZkJiuK2O6zH4ZaGZ2U2D6VH6ax
 grpnEHjPfiyPEleOM4f/UyqlqG2LLttsNpL5H9GKL7ud+/Pw07W8e9mNcQbT7WygOQLRtMwOB+W
 M
X-Gm-Gg: ASbGncvOHCeJlfGPEinNvKgFH2bVfbSjOpChAliyJ0MNYs9XiBpc2QHvR7Sv2xFAnpu
 Dfd3nqKZlihYvwXv4F2WnNlPVFG1OK5tyTMmp2f2dc+BUboTa+Sgsm95UI4hLk8CcdGOF+BHLCk
 t1lQPz/lZLSS1UTeMxhne1EbIsadafTgLvWCrJFGNfcbiEJHhWu6jsWLc3mvzrYFrJNk17RQ0fj
 IjA7sv8iF+n+uk045p8mEgfznVoidqQT0jiG4YNDOeTSyOGjJpK3nQNzM8gxkQJ3wuglO//sdCm
 7VMKeomZNfjEzB0=
X-Google-Smtp-Source: AGHT+IHRrQFPBgMkb3ZH8BPTwDMQ3DBR6NsiOVl3NRK1DlNMVG7drEACr284+diXI7fgicDonLAEAg==
X-Received: by 2002:a05:690c:25c3:b0:6f9:d615:9707 with SMTP id
 00721157ae682-6f9d615a3damr60466237b3.17.1739197979858; 
 Mon, 10 Feb 2025 06:32:59 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fcf20edsm16668207b3.6.2025.02.10.06.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 06:32:59 -0800 (PST)
Date: Mon, 10 Feb 2025 08:32:56 -0600
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
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 29/29] bloblist: Allow relocation at the end of the SPL
 phase
Message-ID: <20250210143256.GZ1233568@bill-the-cat>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-30-sjg@chromium.org>
 <20250205135232.GO1233568@bill-the-cat>
 <CAFLszTg_vYrNRzWWAJbNDifZyv=4NwpBFBa4q3jdtcQ7GLOmyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KGxoX8gBN/H22y7q"
Content-Disposition: inline
In-Reply-To: <CAFLszTg_vYrNRzWWAJbNDifZyv=4NwpBFBa4q3jdtcQ7GLOmyA@mail.gmail.com>
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


--KGxoX8gBN/H22y7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 03:38:12PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 5 Feb 2025 at 06:52, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 04, 2025 at 06:55:19PM -0700, Simon Glass wrote:
> >
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
> > > +     bool "Relocate the bloblist before existing SPL"
> > > +     depends on BLOBLIST_FIXED
> > > +     help
> > > +       Some platforms locate the bloblist in SRAM in SPL. In some ca=
ses,
> > > +       the TF-A BL31 blob removes access to SRAM, e.g. with Rockchip=
 RK3399.
> > > +
> > > +       Enable this option to make U-Boot copy the bloblist from SRAM=
 to SDRAM
> > > +       before leaving SPL.
> >
> > Isn't this because TF-A is (re?-)initializing SDRAM? I'll let one of the
> > Rockchip people chime in here, thanks.
>=20
> Not so far as I know. The DRAM init is in U-Boot on this platform.

OK, but the question is where, since we have we have
drivers/ram/rockchip/sdram_rk3399.c being built in TPL, SPL and full
U-Boot. That should likely be tidied up but again, I'll let one of the
Rockchip people chime in here.

--=20
Tom

--KGxoX8gBN/H22y7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqDhgACgkQFHw5/5Y0
tyy5vgv+Ihb7qkI9YnjAl7tFxgYQUZ8zAxOlFEvAvRXsRSfnx7DSYnS+9bcYEqob
ixBAP0AFhmAUr9Ee+8nliQo1X56YHuNFjiksp8kcWjrrkHPt0aAC6Y2i14aDpBZx
toL6q5BPYn2WBUXsoDUmGu7RiXpeinBbMEvQkn+FbnZzr9oZLbpqptdLPuSizrwT
rq9mJ4u4onp63cNYbmX/3u1dUoXyazBkRQqctWEB2PzSDaYDuo4FVe15t7AbaBA3
MBtwBzuq7OoxZonyfTfDcXmEwZ62oVIAtceiTH9sToRMsbkCmwtaRgemd5xi4+7k
Jbs6QGGeugaVSCafHu0i3SVDtvtY2eE18HbOEAckErUxWIfh797icyYHqFhnyZ1b
ZNO1TzywG3+dvOL6/wr6P6m0e831dcpwkjm9HgUSlRHChSk1/6dD3ZesiIInyHLO
81Vj66xc/5U1FEVxGixTTo6mXB1h2eSRFovpje7JFSW/ZgrpATqEBtOcAhF/X9Cz
D6LSjkfa
=EhY1
-----END PGP SIGNATURE-----

--KGxoX8gBN/H22y7q--
