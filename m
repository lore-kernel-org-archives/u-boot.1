Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA31C021B3
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 00:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D619806FE;
	Sat, 22 Feb 2025 01:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pNuep8+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B3D280F56; Sat, 22 Feb 2025 01:03:40 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F329F8056B
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 01:03:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2fc1c80cdc8so4365369a91.2
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 16:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740182615; x=1740787415; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yk+vBiO1rXULSUx2hGcXkHz8ZcLShIh1kA1YoK4S8oY=;
 b=pNuep8+x6pac/8WQGNp820zxTEu3a+LqAnANN+JzVBpl+ZeyG0CLiJP0p2ZkhziME7
 sH13X2SM9jRsqxOxfm/rFuv/Ss3u8G6Wm7j4Gx7ohdNZrNwc+DzbOsSR9MwsVlbBC7Wz
 dZ7YIsxq35IExSsbbXCs2+piewatDeAvMN4JA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740182615; x=1740787415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yk+vBiO1rXULSUx2hGcXkHz8ZcLShIh1kA1YoK4S8oY=;
 b=sbxKHlgYmjZTwDiLFgTY8kW/oAylnJmNp3kf8r8uhbF4Svl6Ju+M0M+aPJJruYrUYZ
 7VQyuD6BzKy5eZwm7GTUqllw4tkgisRfFc7AJ5zn4tRKkrwTTnE47GsYFqACb3xhwA1/
 dnbI47+T+95vMU0koxOe2sdKAI2CQUL3ieql6gjzay0ESD8T2YJdEPoA304ah30IFHOV
 AgYTOcDb1epauOA6AV2P2B+2EKheUxoYTLAdXD+ufUMx28JE2jpgKiPc1f2fV5EaTxm1
 vGHAi8CjTgHf5wfIbQAD0zymzKDSdqeTcWQ45URweXgtn8/MXsr2KAl6SczxHupgfk+i
 wsGQ==
X-Gm-Message-State: AOJu0YzJlJZnaq+ruxUGtkXe6IPPd0GUNvyKBZVApl0M4IWLqLpw2+nm
 ry6idQoOx5eIynKBxfMaVYPE+Oa/CICvLu6m1C00kW1njgSzsX45MFmGnUAVyUKo7vnxoorikM8
 t
X-Gm-Gg: ASbGncu7tuWzHbWL03TDd3Te5ilD1p2kxcaVlR0DOmO+2LyqJNMsxfqY4pg7b6vqPZQ
 fSmEdMZY9cDkNSWuTLTIo2/AzMmhDc1gsZBOQt7JkjeRers6u4Gn3uQYuw/GxXisDP3XoTh7VAn
 tjujuOWe/w3OOuc0WlLYWEvusNlspndICD1SHyrBqXGbeXqGPiqGNwJBUvEW5M2/lNshlhXVP0A
 eGt8OESvnfCON5OgjSgA8whqeaSeX01nfrK1yi7dqPXON+ggJ+LEKLJeXz8CSyWjXHorvMPMWPO
 9+Zmg1mvjz2aJvuoCquCOZWr
X-Google-Smtp-Source: AGHT+IHpnswVpB0q3d8FxWafjBntvJ4jisn7gtJaQM8XQcHnE1gXmwRUNmEm4Vb3nm5ClUcfB7lG1g==
X-Received: by 2002:a05:6a00:4f8f:b0:730:9242:e68 with SMTP id
 d2e1a72fcca58-73426d96062mr7108709b3a.23.1740182615327; 
 Fri, 21 Feb 2025 16:03:35 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324277f388sm16877999b3a.174.2025.02.21.16.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 16:03:34 -0800 (PST)
Date: Fri, 21 Feb 2025 18:03:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250222000331.GW1233568@bill-the-cat>
References: <CAFLszTiKbg2twYpJJTFb9bFya+5D2DsVPBGKXuw9pw6Y+cvUbg@mail.gmail.com>
 <20250220174005.GA1233568@bill-the-cat>
 <CAFLszTh=Mn9Hxe41KBB+8xjBBxVv=spV=g26tY+Hq6q43EM4=w@mail.gmail.com>
 <20250220204001.GC1233568@bill-the-cat>
 <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
 <20250221192556.GP1233568@bill-the-cat>
 <CAFLszTicfTaAih-h6zgUD2ND2584quCmiayOZ__3t2Y+Ps0Lpg@mail.gmail.com>
 <20250221232005.GV1233568@bill-the-cat>
 <CAFLszTjDukiu-06gRxWmahXB6gKiTQjGPfT1D9TqeMZcG+h_yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2LyN+SlSGO4zmiTS"
Content-Disposition: inline
In-Reply-To: <CAFLszTjDukiu-06gRxWmahXB6gKiTQjGPfT1D9TqeMZcG+h_yw@mail.gmail.com>
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


--2LyN+SlSGO4zmiTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 04:35:16PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 21 Feb 2025 at 16:20, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Feb 21, 2025 at 03:54:52PM -0700, Simon Glass wrote:
> > > Hi  Tom,
> > >
> > > On Fri, 21 Feb 2025 at 12:26, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Feb 21, 2025 at 08:19:40AM -0600, Tom Rini wrote:
> > > > > On Thu, Feb 20, 2025 at 06:30:18PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 20 Feb 2025 at 13:40, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Thu, Feb 20, 2025 at 11:13:34AM -0700, Simon Glass wrote:
> > > > [snip]
> > > > > > > I will look at "splg4" once it's somewhere on source.denx.de =
and I can
> > > > > > > look at it, and refrain from otherwise assuming how it solves=
 the
> > > > > > > problems I had seen previously.
> > > > > >
> > > > > > I pushed an updated version to dm/splg-working but it is not ve=
ry
> > > > > > updated. Still needs more work.
> > > > >
> > > > > Thanks.
> > > >
> > > > So, after doing the remaining CONFIG_TEXT_BASE -> CONFIG_PPL_TEXT_B=
ASE
> > > > changes, here's another example of the problem with your approach. =
What
> > > > stops xilinx_zynqmp_kria from building in splg-working is that
> > > > BUTTON was missing from scripts/conf_nospl. Annoyingly, a mrproper =
(or
> > > > since I always use O=3D, rm -rf) is needed for changes there to be =
picked
> > > > up, but that's maybe just a missing Makefile dependency line. But t=
hat
> > > > just makes it easier to see the next problem, which I don't see the
> > > > answer to. For PPL, we can build drivers/spi/zynqmp_gqspi.o just fi=
ne.
> > > > For SPL however:
> > > >   CC      spl/drivers/spi/zynqmp_gqspi.o
> > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c: In funct=
ion 'zynqmp_qspi_of_to_plat':
> > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:203:22: w=
arning: cast to pointer from integer of different size [-Wint-to-pointer-ca=
st]
> > > >   203 |         plat->regs =3D (struct zynqmp_qspi_regs *)(dev_read=
_addr(bus) +
> > > >       |                      ^
> > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:205:26: w=
arning: cast to pointer from integer of different size [-Wint-to-pointer-ca=
st]
> > > >   205 |         plat->dma_regs =3D (struct zynqmp_qspi_dma_regs *)
> > > >       |                          ^
> > > >
> > > > And I don't see, really, what's even getting us down this error pat=
h.
> > >
> > > It's the FDT_64BIT in conf_nospl - that symbol needs to be the same
> > > across all phases.
> > >
> > > I pushed a new tree which builds without the warning. Note that
> > > SPL_SPI is enabled.
> >
> > So, the "what" is FDT_64BIT wasn't correct. I think this is showing that
> > scripts/conf_nospl is going to be a problem in and of itself, and likely
> > as confusing if not more-so than any of the in-the-end visible changes.
>=20
> Yes, perhaps the key point I've been trying to get across is this confusi=
on.
>=20
> As you know, at present we have two types of options:
> a) those for which each phase has its own value
> b) those for which there is a single value shared across all phases

Agreed.

> The only way today that you can tell them apart is by looking for uses
> of CONFIG_IS_ENABLED() and $(PHASE_) with the option. If you see them,

Partially agreed. Those are strong indicators that both CONFIG_FOO and
CONFIG_SPL_FOO exist, but not always. We have, intentionally, both the
inverse case (CONFIG_SPL_BAR and CONFIG_TPL_BAR exist, CONFIG_BAR does
not) and some future-proofing (CONFIG_SPL_BAZ may exist in the future,
but not yet).

> then the option is a) otherwise it is b). There is no way to tell from
> Kconfig.

Kconfig will happily allow "depends on BOGUS_SYMBOL" yes, and a linter
would be a handy thing to have. But you're mentioning this in another
context, why we need some additional knowledge somewhere.

> Also, some parts of the code may use CONFIG_IS_ENABLED() for
> an option, some may use IS_ENABLED() for that same option. Some may
> use $(PHASE_) and some may not. It's a bit of a mess.

I'm sure you can find some examples where we have CONFIG_IS_ENABLED(FOO)
and IS_ENABLED(CONFIG_FOO) and it's not intentional, but that's not a
big deal, and should be fixed.

I'm only going to rant slightly that checkpatch.pl telling people to use
these macros has made the situation worse, not better, out of an
ingrained need to silence checkpatch.pl.

And what you're missing is that sometimes we intentionally don't want
$(PHASE_), or would need to rewrite the Makefile to make use of it.
fs/Makefile is an example of this.

> Stepping back a bit, perhaps the goal of my series is to identify
> options in b) so we can deal with them in a better way. They are all
> listed in conf_nospl, in preparation for some future action.

There are two big problems here. The first of which is that conf_nospl,
as a concept, is going to be incomplete. Do you list every CMD in there?
Why? They'll never be in a non-PPL phase. It will be its own nightmare
to keep correct, once it is bug-compatible with what we have today.

The second big problem is that it doesn't make it any easier to solve
what I keep calling the DWC3 problem. It's a valid use case that two
developers have hit independently of wanting to enable USB gadget
support (and the HW uses DWC3) in SPL and not PPL. Not only are you not
solving this problem, it gets worse to solve. Today it's "OK, I need to
find where to move obj-$(CONFIG_FOO) to be more visible and
obj-$(CONFIG_$(PHASE_)FOO". Tomorrow it's "Why isn't obj-$(CONFIG_FOO)
working here but not there?".

To me, at absolute best case here, we're making a lot of changes and
spending a lot of time to not really address the underlying problems,
just making some questionable value visibility changes. We could reduce
ourselves to one macro by saying only ever use CONFIG_IS_ENABLED(FOO)
and IS_ENABLED(CONFIG_FOO) goes back to an ifdef for the case where it
must only be tested on CONFIG_FOO. I'm 80% sure we could simplify all of
$(PHASE_)/$(XPL_)/$(SPL_) down to just $(PHASE_) and that eliminates the
which to use of those question. And update / expand upon the existing
documentation we have as it's not clear enough for everyone. Then we can
think, again, about how to solve the problems that are introduced by
building our entire source tree N times from a single configuration
file. Or if we need to do something radical there.

--=20
Tom

--2LyN+SlSGO4zmiTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme5FEgACgkQFHw5/5Y0
tyzc7QwAldUtl7RJRB5cEVbn6//Nx3mXhf3cWnYute3Hs1u5/FlnCsbzDVWGNwBY
jhOClsTCZmAyxhiKtCoCV0LXn7pjcmVjaXNBQOUEwl/O4bYgG1L/Y3y9ZhGu3DjI
kuK0PenP4O+If7B3Vl0+tF6LBxohf2RtWn+P46rbqacqUPh+gfzBx6JCKRYdlKR4
/58VhJWZzB35HIFNJvY4CFyX4VpK1CEbM5/6dX+uxe7Coe7LM/fdHNLJiklD9Rj9
di7idzU/p4rMYD+exmUsCBwUqix7PcDHXH5XT5J0ajp6ECLuhx6yt2j/TjldnvBT
kzMu1yvKLkuMQqtaK9lP7wVFATqtEtxbuhqlrJtyhGvNpOBgP4XJXV70OhG8lwgq
YvaKBHx5wip29ts2HVaWlGrh5/FlJkp8o+K0omb3QOXt7j3xjNt8DSfBuAdhf2PZ
jVRNM5PeefiCRlIA1jpiLVbEck0JTr4DrAD5IgBMx3YbXp5KGLhB2y0IRkuZ9eet
FPlXCyi8
=/8ng
-----END PGP SIGNATURE-----

--2LyN+SlSGO4zmiTS--
