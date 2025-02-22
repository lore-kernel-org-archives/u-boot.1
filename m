Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDC3C021B3
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 01:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68CBF80F5C;
	Sat, 22 Feb 2025 02:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A9G/mJUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60E8A80017; Sat, 22 Feb 2025 02:07:03 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BA6D806FE
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 02:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fc4418c0b9so4269430a91.0
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 17:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740186418; x=1740791218; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k4crOjSw3bn308Q87HQ25uDuc9QGIwxjhWB+cQEvb0k=;
 b=A9G/mJUuwExJG2CjfHDpWCthMrDLc757L1kA2IkeWidqita/sKAZUPzjamSxhNju0A
 tJrMnygZABmh3fPYD2KAUKrlmWjgh428h/LKOwyZL7qjZtfvp8vB8Hge4Dlx0BAtQh1P
 pwKFv/Z23HSb5QfSKsx5YfO/9YpWwyGKVaQE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740186418; x=1740791218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k4crOjSw3bn308Q87HQ25uDuc9QGIwxjhWB+cQEvb0k=;
 b=bGkLlSYVf9BNcQ7RY/H5rForOvUGu50Iu+eQjRBEwexImCRej+oOYvOIIZJUm6gie3
 2wMgQFdWfXv4rbIQ7vtojZeQ1vad/w/oInm5m0Ti98Q9HhqzJrrJDyopbBuk1cuVdYPB
 ORBW8wQapTKuCmiPFW67sF8JGCPgrxL6MuFXIJh53bVTUEYkSbdAPoFViCa+TfXfnud1
 5+ExldTDrFs5mcLooPhPQ9Ke4sV3OK7sPzPXfKcImWLQBtAxzATyyCEU9YzDVL0saLX9
 i54njutEIWo2bIGnN8YMm8lywEtV+tTPR3eTXEkPz0J7IlMa47Ckm/HZ+Wac2NII9P/b
 9iTg==
X-Gm-Message-State: AOJu0YyNRJVWY5hlYFovVc3M1NAzAv4/e4yXxyhVmmZvRSFbzkFBrK7k
 C1h1aAOAIL6yhG0dKj2Kb8juQZipf1CKTZoRvdFcK9EVbQtopboAM7pWWEJUZRs=
X-Gm-Gg: ASbGncsUtQpoxFgiSQjFiLhPfJ3JACm4JnzqDHfTfIXKJsS9d1wrKXHTbzxqVPWYKaU
 LHxQbO7AjbFeVorO7o9UG/N/0M/tnxZeupS0K+1C9V2Hy8X5YqNExSx8TJrsltIIg3YDpI/S1n0
 Ng+6Hz/l+Q94kp60lOU72F0/PcMmoubjQ+9NLod4ESldRK4KBS7yAYPhxBsUfZxxK0JlnAtYaRV
 oBWpvq0WU4elVjge+Ydgd9m+nbaZJlHjMSkN5ELKM7Ch02iXebiNtXQSgKvbrvX3P7p+O191YE2
 69Wl1ERvFwd95M1MuRoYFr9l
X-Google-Smtp-Source: AGHT+IGawIlWa2yguHl+8ZwDN1nV1LJsfYfYXfk5U0uSyEFSQA6RR3IiCBW4SeXtA/Z4IfpvwDZskA==
X-Received: by 2002:a17:90b:1f81:b0:2ef:67c2:4030 with SMTP id
 98e67ed59e1d1-2fce7b11203mr8601664a91.27.1740186417938; 
 Fri, 21 Feb 2025 17:06:57 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb5a92d3basm14991900a12.75.2025.02.21.17.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 17:06:57 -0800 (PST)
Date: Fri, 21 Feb 2025 19:06:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250222010654.GA1233568@bill-the-cat>
References: <CAFLszTh=Mn9Hxe41KBB+8xjBBxVv=spV=g26tY+Hq6q43EM4=w@mail.gmail.com>
 <20250220204001.GC1233568@bill-the-cat>
 <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
 <20250221192556.GP1233568@bill-the-cat>
 <CAFLszTicfTaAih-h6zgUD2ND2584quCmiayOZ__3t2Y+Ps0Lpg@mail.gmail.com>
 <20250221232005.GV1233568@bill-the-cat>
 <CAFLszTjDukiu-06gRxWmahXB6gKiTQjGPfT1D9TqeMZcG+h_yw@mail.gmail.com>
 <20250222000331.GW1233568@bill-the-cat>
 <CAFLszThbizWn8ja9pwfa6Fn6NBp83BdAUFkoO97PEtUCUuQzBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kjgIEFzbQQb4zv43"
Content-Disposition: inline
In-Reply-To: <CAFLszThbizWn8ja9pwfa6Fn6NBp83BdAUFkoO97PEtUCUuQzBg@mail.gmail.com>
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


--kjgIEFzbQQb4zv43
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 05:24:35PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 21 Feb 2025 at 17:03, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Feb 21, 2025 at 04:35:16PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 21 Feb 2025 at 16:20, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Feb 21, 2025 at 03:54:52PM -0700, Simon Glass wrote:
> > > > > Hi  Tom,
> > > > >
> > > > > On Fri, 21 Feb 2025 at 12:26, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Feb 21, 2025 at 08:19:40AM -0600, Tom Rini wrote:
> > > > > > > On Thu, Feb 20, 2025 at 06:30:18PM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Thu, 20 Feb 2025 at 13:40, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Feb 20, 2025 at 11:13:34AM -0700, Simon Glass wro=
te:
> > > > > > [snip]
> > > > > > > > > I will look at "splg4" once it's somewhere on source.denx=
=2Ede and I can
> > > > > > > > > look at it, and refrain from otherwise assuming how it so=
lves the
> > > > > > > > > problems I had seen previously.
> > > > > > > >
> > > > > > > > I pushed an updated version to dm/splg-working but it is no=
t very
> > > > > > > > updated. Still needs more work.
> > > > > > >
> > > > > > > Thanks.
> > > > > >
> > > > > > So, after doing the remaining CONFIG_TEXT_BASE -> CONFIG_PPL_TE=
XT_BASE
> > > > > > changes, here's another example of the problem with your approa=
ch. What
> > > > > > stops xilinx_zynqmp_kria from building in splg-working is that
> > > > > > BUTTON was missing from scripts/conf_nospl. Annoyingly, a mrpro=
per (or
> > > > > > since I always use O=3D, rm -rf) is needed for changes there to=
 be picked
> > > > > > up, but that's maybe just a missing Makefile dependency line. B=
ut that
> > > > > > just makes it easier to see the next problem, which I don't see=
 the
> > > > > > answer to. For PPL, we can build drivers/spi/zynqmp_gqspi.o jus=
t fine.
> > > > > > For SPL however:
> > > > > >   CC      spl/drivers/spi/zynqmp_gqspi.o
> > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c: In f=
unction 'zynqmp_qspi_of_to_plat':
> > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:203:2=
2: warning: cast to pointer from integer of different size [-Wint-to-pointe=
r-cast]
> > > > > >   203 |         plat->regs =3D (struct zynqmp_qspi_regs *)(dev_=
read_addr(bus) +
> > > > > >       |                      ^
> > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:205:2=
6: warning: cast to pointer from integer of different size [-Wint-to-pointe=
r-cast]
> > > > > >   205 |         plat->dma_regs =3D (struct zynqmp_qspi_dma_regs=
 *)
> > > > > >       |                          ^
> > > > > >
> > > > > > And I don't see, really, what's even getting us down this error=
 path.
> > > > >
> > > > > It's the FDT_64BIT in conf_nospl - that symbol needs to be the sa=
me
> > > > > across all phases.
> > > > >
> > > > > I pushed a new tree which builds without the warning. Note that
> > > > > SPL_SPI is enabled.
> > > >
> > > > So, the "what" is FDT_64BIT wasn't correct. I think this is showing=
 that
> > > > scripts/conf_nospl is going to be a problem in and of itself, and l=
ikely
> > > > as confusing if not more-so than any of the in-the-end visible chan=
ges.
> > >
> > > Yes, perhaps the key point I've been trying to get across is this con=
fusion.
> > >
> > > As you know, at present we have two types of options:
> > > a) those for which each phase has its own value
> > > b) those for which there is a single value shared across all phases
> >
> > Agreed.
> >
> > > The only way today that you can tell them apart is by looking for uses
> > > of CONFIG_IS_ENABLED() and $(PHASE_) with the option. If you see them,
> >
> > Partially agreed. Those are strong indicators that both CONFIG_FOO and
> > CONFIG_SPL_FOO exist, but not always. We have, intentionally, both the
> > inverse case (CONFIG_SPL_BAR and CONFIG_TPL_BAR exist, CONFIG_BAR does
> > not) and some future-proofing (CONFIG_SPL_BAZ may exist in the future,
> > but not yet).
>=20
> OK
>=20
> >
> > > then the option is a) otherwise it is b). There is no way to tell from
> > > Kconfig.
> >
> > Kconfig will happily allow "depends on BOGUS_SYMBOL" yes, and a linter
> > would be a handy thing to have. But you're mentioning this in another
> > context, why we need some additional knowledge somewhere.
>=20
> What I meant was that we don't have anything in the Kconfig for FOO
> that says this is a global option or an xPL-specific one. We have to
> hunt for SPL_FOO, etc.
>=20
> >
> > > Also, some parts of the code may use CONFIG_IS_ENABLED() for
> > > an option, some may use IS_ENABLED() for that same option. Some may
> > > use $(PHASE_) and some may not. It's a bit of a mess.
> >
> > I'm sure you can find some examples where we have CONFIG_IS_ENABLED(FOO)
> > and IS_ENABLED(CONFIG_FOO) and it's not intentional, but that's not a
> > big deal, and should be fixed.
>=20
> But this is largely the point of my series. It's the reason why
> qconfig is able to locate these cases and warn about them. It is a big
> deal, IMO, or at least big enough for me to attempt this.
>=20
> >
> > I'm only going to rant slightly that checkpatch.pl telling people to use
> > these macros has made the situation worse, not better, out of an
> > ingrained need to silence checkpatch.pl.
> >
> > And what you're missing is that sometimes we intentionally don't want
> > $(PHASE_), or would need to rewrite the Makefile to make use of it.
> > fs/Makefile is an example of this.
>=20
> The next step from my side would be to get rid of the 'ifdef
> CONFIG_XPL_BUILD' in the Makefiles. It's confusing and annoying.
>=20
> >
> > > Stepping back a bit, perhaps the goal of my series is to identify
> > > options in b) so we can deal with them in a better way. They are all
> > > listed in conf_nospl, in preparation for some future action.
> >
> > There are two big problems here. The first of which is that conf_nospl,
> > as a concept, is going to be incomplete. Do you list every CMD in there?
> > Why? They'll never be in a non-PPL phase. It will be its own nightmare
> > to keep correct, once it is bug-compatible with what we have today.
>=20
> This is actually the *nice* thing about conf_nospl. We should reduce
> it to empty, just like we did with the Kconfig whitelist.
>=20
> We have this rule:
>=20
> libs-$(CONFIG_CMDLINE) +=3D cmd/
>=20
> which is enough for most things. The only issue is that sometimes,
> e.g. with CONFIG_CMD_DHCP it doesn't mean the command at all.
>=20
> So I don't agree at all that my series is a 'big problem'. It is a
> solution to the current confusion and it shows up what is broken and
> needs to be fixed.
>=20
> >
> > The second big problem is that it doesn't make it any easier to solve
> > what I keep calling the DWC3 problem. It's a valid use case that two
> > developers have hit independently of wanting to enable USB gadget
> > support (and the HW uses DWC3) in SPL and not PPL. Not only are you not
> > solving this problem, it gets worse to solve. Today it's "OK, I need to
> > find where to move obj-$(CONFIG_FOO) to be more visible and
> > obj-$(CONFIG_$(PHASE_)FOO". Tomorrow it's "Why isn't obj-$(CONFIG_FOO)
> > working here but not there?".
>=20
> Is that because some Makefile higher in the hierarchy is not building
> that subdir? I don't know what this is about.
>=20
> >
> > To me, at absolute best case here, we're making a lot of changes and
> > spending a lot of time to not really address the underlying problems,
> > just making some questionable value visibility changes. We could reduce
> > ourselves to one macro by saying only ever use CONFIG_IS_ENABLED(FOO)
> > and IS_ENABLED(CONFIG_FOO) goes back to an ifdef for the case where it
> > must only be tested on CONFIG_FOO.
>=20
> Or we could finish and apply my series, which does this.
>=20
> > I'm 80% sure we could simplify all of
> > $(PHASE_)/$(XPL_)/$(SPL_) down to just $(PHASE_) and that eliminates the
> > which to use of those question.
>=20
> Again, let's apply my series, which actually gets rid of PHASE_, SPL_
> and XPL_ altogether.
>=20
> > And update / expand upon the existing
> > documentation we have as it's not clear enough for everyone. Then we can
> > think, again, about how to solve the problems that are introduced by
> > building our entire source tree N times from a single configuration
> > file. Or if we need to do something radical there.
>=20
> At this point I'm getting the feeling that you imagine my series is
> some grand unified plan for Kconfig. It really isn't and this thread
> is reminding me of why I originally wrote it. Bear in mind it was over
> two years ago and I have mostly forgotten all the issues. It is a
> clean-up series. It isn't the second coming but it isn't the
> antichrist either.

I worry you're going to spend another month of effort to get this to 1:1
compatibility (modulo fixing bugs) with what we have today and get
disappointed once it rolls out to -next. But I guess I've already spent
too much time trying to convince you this is a bad idea and that your
cure is worse than the disease.

--=20
Tom

--kjgIEFzbQQb4zv43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme5Iy4ACgkQFHw5/5Y0
tyxTlgwAh2rbo2tEbWKbcv5vMmVahFieFPg/OizveV6hWuh3XoqJsG2ZMUcqym0m
G9UGCmp1WMeDHhvuJVoeK8WTOvXEsO78FCEWChNZULal022ZE2M38q33Um0dSXbJ
YiKvA63XbOVthy9wtqWkkCNtfwx7t/TvGFIwA6Pwi8bR3JW4248rY06tSgpsflaC
1CLZkD3pec2oYkGW0flo8VD22OaMvsZQ00z5JR07NXQDIYbX62ISz6yPa4yX+pum
5v1Ww1UB2kx39PGtpTWuj9EuDBLZ9PdZ5fin1XkCjTGICJUPyzBJY6JckCoshAjB
nm1rBocvT3FZbu8X83pXxeD4L2b5/EHgWU+gWOcCsdeb4EetXQ2PrNTpXMEP/gco
J8/66o1MABQoyoBeaBqKjXbKSGqFTGa7yWmfHwj3ba8AXZ3Vheaq5hGI/vGDzx8E
3CF+rRL0bhaq8rgsl1j88Y9Q8zbcP+BmqckV91r2uFuEevOXti2OPkZsTIgO6Gt8
GEW9NmzS
=IBy4
-----END PGP SIGNATURE-----

--kjgIEFzbQQb4zv43--
