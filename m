Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C422C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 13:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82CB3871BE;
	Tue,  7 Nov 2023 14:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LsThrPWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A2B871BE; Tue,  7 Nov 2023 14:49:56 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D5EB871ED
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 14:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-41cd7a3e8f8so38997061cf.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 05:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699364990; x=1699969790; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7/ZkpN4upd0dzwiD6BDYwetNDjkcrcOiuSEySLG6wrU=;
 b=LsThrPWdj93Z5rr8JZ1gUTYpQCQSu9ZgXSPcI9KJF66tKZOLFOTV0LR7xWcE9Outeb
 ogmumqzlS5jgQyLyw9YVGiMasjsngFMSQjpDxXuYBj3dzRKQQVwJTf0hkpnR1HD/SVpb
 d0EQeO1wCKSzm0QIFSL01HCtrS6n5NjkV2M38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699364990; x=1699969790;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/ZkpN4upd0dzwiD6BDYwetNDjkcrcOiuSEySLG6wrU=;
 b=M3cyxKROOhN7KM8wp1/4u+IkOoVoVCH6g8Pqf7owtc3+gPtk7r+kZfUtiZgNVctj9c
 SquZst057pTo2CL5j6Ea2lEysYsgZWzOVY7irO4TTmSIxEhRcpC2IlDTGFsM5TJsAGxJ
 ypbN9wBIQ6kklmnztxdtVwOXFu77I16REFP1HnlghIjQEq1rIs2Ui69rYHVzupftdnZL
 zsX/ZeKdZEOUzLg86JaytBr6TSoocy2h0Bp7vkmB7hOD4jkr9eaNpo4AKcElkxoTKVT6
 iEd7X9hw216Iz9TlvxrrizhjoU3crFmeAwEhol/47C/NfoNLwalhLw+8HrADyzcfVkvL
 Pg5w==
X-Gm-Message-State: AOJu0Ywn93Nw0rJyI1EWtL/9WGOx+bGTdM+cW3JDAIyWla7sCRV2ft3r
 nH9w0MEA7Dpy6ed4/nOvhFZqhA==
X-Google-Smtp-Source: AGHT+IHoUjpl7V6B2JQmRvm8O4fZu0iT/a4Trv/ruXwDAObeY8HbXmAHPnBuo8adl4343SZPHLqQEQ==
X-Received: by 2002:ac8:7e96:0:b0:419:5309:20fd with SMTP id
 w22-20020ac87e96000000b00419530920fdmr37747897qtj.25.1699364989745; 
 Tue, 07 Nov 2023 05:49:49 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2fee-489d-8907-1a68.res6.spectrum.com.
 [2603:6081:7b00:6400:2fee:489d:8907:1a68])
 by smtp.gmail.com with ESMTPSA id
 t10-20020ac8738a000000b00417fa0cd77esm4342067qtp.80.2023.11.07.05.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 05:49:49 -0800 (PST)
Date: Tue, 7 Nov 2023 08:49:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marex@denx.de>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 0/4] bootm: Handle compressed arm64 images with bootm
Message-ID: <20231107134946.GD6601@bill-the-cat>
References: <20231105200453.1887418-1-sjg@chromium.org>
 <7a1345b9-8844-48e9-a1b5-8c7508cefeb1@prevas.dk>
 <CAPnjgZ1BbpM_Ksr5aKg2zWLv1FPy-N_Kz6fbrkZoh=i7LfpMUA@mail.gmail.com>
 <20231107130450.GA6601@bill-the-cat>
 <CAPnjgZ0jFTG-Rq0u5yaMjSxcxdQvr578W2P+nzFx0g0GbQHjNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3tKs1Z06yrRFwE3i"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0jFTG-Rq0u5yaMjSxcxdQvr578W2P+nzFx0g0GbQHjNQ@mail.gmail.com>
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


--3tKs1Z06yrRFwE3i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 06:31:15AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 7 Nov 2023 at 06:04, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Nov 07, 2023 at 05:23:05AM -0700, Simon Glass wrote:
> > > Hi Rasmus,
> > >
> > > On Tue, 7 Nov 2023 at 02:56, Rasmus Villemoes
> > > <rasmus.villemoes@prevas.dk> wrote:
> > > >
> > > > On 05/11/2023 21.03, Simon Glass wrote:
> > > > > This little series corrects a problem I noticed with arm64 images,
> > > > > where the kernel is not recognised:
> > > >
> > > > The $subject is misleading, bootm works just fine with compressed a=
rm64
> > > > images, with the type set to "kernel".
> > > >
> > > > >         Type:         Kernel Image (no loading done)
> > > > >         Compression:  gzip compressed
> > > >
> > > > Isn't that a non-sensical combination to begin with? Decompressing =
the
> > > > Image.gz kernel image to any location (however you determine that
> > > > destination) _is_ loading it.
> > >
> > > Yes, I agree.
> > >
> > > >
> > > > If you want XIP, obviously the image must be uncompressed in the FI=
T. I
> > > > don't understand what you're trying to do here.
> > >
> > > Hmmm, I think I have just got confused about all of this, perhaps
> > > because ChromeOS uses kernel_noload with compression. Is that an
> > > invalid combination?
> >
> > Yes, that sounds like an invalid combination.
> >
> > > But then how does loading actually work? We don't want to put the load
> > > address in the FIT, since we don't know what it is...we want to use
> > > the address provided by the board. Which is kernel_noload...so how
> > > should this be implemented?
> >
> > What do you mean, provided by the board? With kernel_noload we XIP the
> > payload, because the board provided (by loading us to) a safe place to
> > execute whatevers in there. In the olden days, that would mean (almost
> > certainly) the zImage which in turn was already compressed and
> > self-relocating. I know technically one could use the raw vmlinux
> > instead. With the Linux Kernel and ARCH=3Darm64 (and a few other arches
> > now too), they dropped the self-decompression part and the whole payload
> > must be decompressed. We handle this case in "booti" today by having to
> > have the board (via environment) say where to decompress to (and how
> > much space is available). Then we move it back to where we started from,
> > which is likely not necessary.
> >
> > Looking at
> > https://www.kernel.org/doc/html/latest/arch/arm64/booting.html and
> > https://www.kernel.org/doc/html/latest/riscv/boot-image-header.html
> > stating "we're just like arm64" we can do better than we do today for
> > this format of OS image. If aren't compressed, we only need to ensure
> > that we are correctly aligned and move (and tell the user) if not. We
> > can even put the 2MB check under some legacy kernel CONFIG option (3.17
> > is over 9 years old). With respect to automatic decompression, if we
> > don't have something telling us where a buffer is and we can't pull from
> > the environment, we should tell the user and stop?
>=20
> With the booti command, the kern_comp_addr_r and kern_comp_size vars
> are used. Perhaps I should update my patch to use those too?

As a fallback, perhaps? But what do we do today in a FIT to handle
compression =3D "gzip" to know where to uncompress things to?

> Do you understand what I am asking about, with bootm? It should be
> possible to ignore the load address. In fact, load addresses in FIT
> are mostly bad these days, IMO. If this is not kernel_noload, then
> what should we use?

Well, your use case needs to be valid. I don't think "kernel_noload" is
valid with anything other than 'compression =3D "none"' because that's our
just execute things in place option. It's very dangerous to use and I
do not recall right now if we fixed the case where it will just let the
device tree be badly aligned and break the kernel, or if we say "no
load, but still fix THAT alignment". And your use case isn't "ignore the
load address" it's "ignore the load address and decompress the
payload(s)".  That needs _something_ to be known somehow. And I'm asking
how we do that today even, before saying we can or can't support
"kernel_noload" along with a compression of the payload.

> "provided by the board" means that the board knows the memory map, not
> the FIT, so only the board can provide the addresses to use for
> loading the kernel.

To be clearer, where does the board document that knowledge and provide
it to be used? I'm not a super fan of environment variables especially
since we aren't always consistent with '_' or just nothing between
"words" of the variable. We have much better documentation these days
(once again, thanks everyone) so we can document environment variables
used here, and also what CONFIG options are used (as
CONFIG_SYS_BOOTM_LEN is part of the equation here and badly named as
been said in other threads about issues wrt decomp and overlap).

--=20
Tom

--3tKs1Z06yrRFwE3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKQHAACgkQFHw5/5Y0
tyxYjwv+LLewPJfUfhE7B6qy2dX0VgrZs8o/hbur3KULehzC6VGuYA6dBykmOwnd
/KQXYnBpo4uPJSUX/5y/5ZpfP3v8ALBjT7kiMq2tvUjTxH1vhGK1xtMPV14exE7U
SPpsp9F1+4Cbg7INzpvGtRoER2cFPT0d2dQkL7JUtXiB3Yq+hh1K1BPUzjjZRYGq
vEbgeyS3SRUylL/JBHuY9Jbi3fvoDkhQlb73XcDOa6wuvFocYUjyHaMBNbRKRgco
6+4qHFCjAzXH5SYVngnrTMQNiTphUQvE9yBeTtczXgpl+g1G1By3ZzLU22loFaOf
ZEkgIy04uy0VMSMbRmC+nQexWCDpE+Xy9eRwdR5QPAUQVwju+aYHq7fqitqqQe6r
OHjQPTgyrZsbu2XSoDqpJghBZlbrLt3MC2x9iDZ/+1xRfyc2z84Dt1EyTauWUscn
bYhMnBT36OXDuQLNBsVpEVPQJoJP4TUIBx6Ot9aZ4l/fZOPM2nKnLLxe3lyhamyD
MVy4DG5Z
=5jyf
-----END PGP SIGNATURE-----

--3tKs1Z06yrRFwE3i--
