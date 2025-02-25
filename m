Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D925AC021BC
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 14:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 509F480F88;
	Tue, 25 Feb 2025 15:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eBVjPJXJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DED9801CF; Tue, 25 Feb 2025 15:02:51 +0100 (CET)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6D8F807EE
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 15:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4bfb4853a5dso1527403137.2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 06:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740492166; x=1741096966; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mGg+YE5WsROxwW4rzj3iCnLfe8c/E/EqEJuWRK149dY=;
 b=eBVjPJXJLNKDoGICHG66lKHlslRrt2ENNCS0FrmeSQHZaid/j5oWTP9QTJXjLYdyWR
 U5xwxqvwk4iv15It8S17SJy1VvWnc8smmDCrWi9825cTOY60f5kBnTrIIUvmFwb7iHeb
 UEzI0r2t+oeqbt+Jt7MoqqGfhF+2Q5C6GIUlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740492166; x=1741096966;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGg+YE5WsROxwW4rzj3iCnLfe8c/E/EqEJuWRK149dY=;
 b=vmzVNoxDqqL/AqMXLT+4hXqsC8Q6MbQmG4Zq+CDBFhI8QJn7cfgyiEiP/31cZWXYeO
 TrmkxrJ8tO/0XHtMkpz+aT6BKxgMWBiOTVONUvCgEt/7vOkZL55h5PjifAVzAb/pN4P4
 B9HL//p0G4qKDz6OGqEDqpv4qgDTWovgjyQrHB7iN0/nKPuuj5ZeHbVMiu07PTC/TWo0
 MnPHXWFHuWDJ6auehP4hqr4qR2+91A/+FpJG77eqt8XqbhhMqGgpGhTnYvw0ry9ceydx
 6l+KGN5vJ2tmlrlMc48vEiZ49/YWUyhBykf0byf3Xojg9O4+LXVDvPAoYpqVVKFpQMVI
 gctA==
X-Gm-Message-State: AOJu0YwDjGGfVY4KQTmA+FuYJ6fxtWYvH6yyE6gqCpQA0KBBvJW/yP9j
 9JZfetZIknUQasq/RvPqC857xfYLYkLM1Pf6iSkiM603IEILoa5Semp6RJXmAS8=
X-Gm-Gg: ASbGnctn+H/gxoLQz7L3bpMYYSw2IJhztPh55ZX5KJ2EH6FA6oFwA2BAuFBckim+lqM
 9YK4SgRHz1ZoHdK0VfuPJkWS4HYpIi3WHXCpx2CVyDVAP910bQEt4olRAYWLwME/n1dOA/J2iIl
 7lGbI7zhj5BkCPARh4STDW4S/ubRdT1M+g1Nl6ClSu1Vq+uWrPTHpXkAp2mIzbpjjMq6rQKQnmU
 loG2Isuc+2oavixZKP8qqEEEedhzfqZb1Ckun+okDGYkiZ5MYarmGPu+WSztJWnuhiFaDto3OIU
 r6gXw4n76IZGq0jPqxqy2YiK
X-Google-Smtp-Source: AGHT+IG/tahNW0OelP81Fza9mIfi1tNJ3TcH0bOH3ISahBEV7oZ6WHI1jfjSR0wJp2kyo8/TCT86kg==
X-Received: by 2002:a05:6102:2c87:b0:4bb:eb4a:f9ef with SMTP id
 ada2fe7eead31-4bfbffcffe8mr9315707137.4.1740492166260; 
 Tue, 25 Feb 2025 06:02:46 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4c00c57e289sm259797137.4.2025.02.25.06.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 06:02:45 -0800 (PST)
Date: Tue, 25 Feb 2025 08:02:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250225140242.GM1233568@bill-the-cat>
References: <20250221192556.GP1233568@bill-the-cat>
 <CAFLszTicfTaAih-h6zgUD2ND2584quCmiayOZ__3t2Y+Ps0Lpg@mail.gmail.com>
 <20250221232005.GV1233568@bill-the-cat>
 <CAFLszTjDukiu-06gRxWmahXB6gKiTQjGPfT1D9TqeMZcG+h_yw@mail.gmail.com>
 <20250222000331.GW1233568@bill-the-cat>
 <CAFLszThbizWn8ja9pwfa6Fn6NBp83BdAUFkoO97PEtUCUuQzBg@mail.gmail.com>
 <20250222010654.GA1233568@bill-the-cat>
 <CAFLszTgS1KtMtuW9vo=F-H5q_km0BLsA5BVU_cZDSV9dgOo_mA@mail.gmail.com>
 <20250224160004.GF1233568@bill-the-cat>
 <CAFLszTjr7DDNdUDDsVyM_+KeFNA9pVu9CYTv12PqGPEad83xkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X1JIclY1x8sthzb4"
Content-Disposition: inline
In-Reply-To: <CAFLszTjr7DDNdUDDsVyM_+KeFNA9pVu9CYTv12PqGPEad83xkw@mail.gmail.com>
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


--X1JIclY1x8sthzb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 04:38:50PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 24 Feb 2025 at 09:00, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Feb 21, 2025 at 07:07:06PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 21 Feb 2025 at 18:06, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Feb 21, 2025 at 05:24:35PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 21 Feb 2025 at 17:03, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Feb 21, 2025 at 04:35:16PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 21 Feb 2025 at 16:20, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, Feb 21, 2025 at 03:54:52PM -0700, Simon Glass wrote:
> > > > > > > > > Hi  Tom,
> > > > > > > > >
> > > > > > > > > On Fri, 21 Feb 2025 at 12:26, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Feb 21, 2025 at 08:19:40AM -0600, Tom Rini wrot=
e:
> > > > > > > > > > > On Thu, Feb 20, 2025 at 06:30:18PM -0700, Simon Glass=
 wrote:
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, 20 Feb 2025 at 13:40, Tom Rini <trini@konsu=
lko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, Feb 20, 2025 at 11:13:34AM -0700, Simon G=
lass wrote:
> > > > > > > > > > [snip]
> > > > > > > > > > > > > I will look at "splg4" once it's somewhere on sou=
rce.denx.de and I can
> > > > > > > > > > > > > look at it, and refrain from otherwise assuming h=
ow it solves the
> > > > > > > > > > > > > problems I had seen previously.
> > > > > > > > > > > >
> > > > > > > > > > > > I pushed an updated version to dm/splg-working but =
it is not very
> > > > > > > > > > > > updated. Still needs more work.
> > > > > > > > > > >
> > > > > > > > > > > Thanks.
> > > > > > > > > >
> > > > > > > > > > So, after doing the remaining CONFIG_TEXT_BASE -> CONFI=
G_PPL_TEXT_BASE
> > > > > > > > > > changes, here's another example of the problem with you=
r approach. What
> > > > > > > > > > stops xilinx_zynqmp_kria from building in splg-working =
is that
> > > > > > > > > > BUTTON was missing from scripts/conf_nospl. Annoyingly,=
 a mrproper (or
> > > > > > > > > > since I always use O=3D, rm -rf) is needed for changes =
there to be picked
> > > > > > > > > > up, but that's maybe just a missing Makefile dependency=
 line. But that
> > > > > > > > > > just makes it easier to see the next problem, which I d=
on't see the
> > > > > > > > > > answer to. For PPL, we can build drivers/spi/zynqmp_gqs=
pi.o just fine.
> > > > > > > > > > For SPL however:
> > > > > > > > > >   CC      spl/drivers/spi/zynqmp_gqspi.o
> > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi=
=2Ec: In function 'zynqmp_qspi_of_to_plat':
> > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi=
=2Ec:203:22: warning: cast to pointer from integer of different size [-Wint=
-to-pointer-cast]
> > > > > > > > > >   203 |         plat->regs =3D (struct zynqmp_qspi_regs=
 *)(dev_read_addr(bus) +
> > > > > > > > > >       |                      ^
> > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi=
=2Ec:205:26: warning: cast to pointer from integer of different size [-Wint=
-to-pointer-cast]
> > > > > > > > > >   205 |         plat->dma_regs =3D (struct zynqmp_qspi_=
dma_regs *)
> > > > > > > > > >       |                          ^
> > > > > > > > > >
> > > > > > > > > > And I don't see, really, what's even getting us down th=
is error path.
> > > > > > > > >
> > > > > > > > > It's the FDT_64BIT in conf_nospl - that symbol needs to b=
e the same
> > > > > > > > > across all phases.
> > > > > > > > >
> > > > > > > > > I pushed a new tree which builds without the warning. Not=
e that
> > > > > > > > > SPL_SPI is enabled.
> > > > > > > >
> > > > > > > > So, the "what" is FDT_64BIT wasn't correct. I think this is=
 showing that
> > > > > > > > scripts/conf_nospl is going to be a problem in and of itsel=
f, and likely
> > > > > > > > as confusing if not more-so than any of the in-the-end visi=
ble changes.
> > > > > > >
> > > > > > > Yes, perhaps the key point I've been trying to get across is =
this confusion.
> > > > > > >
> > > > > > > As you know, at present we have two types of options:
> > > > > > > a) those for which each phase has its own value
> > > > > > > b) those for which there is a single value shared across all =
phases
> > > > > >
> > > > > > Agreed.
> > > > > >
> > > > > > > The only way today that you can tell them apart is by looking=
 for uses
> > > > > > > of CONFIG_IS_ENABLED() and $(PHASE_) with the option. If you =
see them,
> > > > > >
> > > > > > Partially agreed. Those are strong indicators that both CONFIG_=
FOO and
> > > > > > CONFIG_SPL_FOO exist, but not always. We have, intentionally, b=
oth the
> > > > > > inverse case (CONFIG_SPL_BAR and CONFIG_TPL_BAR exist, CONFIG_B=
AR does
> > > > > > not) and some future-proofing (CONFIG_SPL_BAZ may exist in the =
future,
> > > > > > but not yet).
> > > > >
> > > > > OK
> > > > >
> > > > > >
> > > > > > > then the option is a) otherwise it is b). There is no way to =
tell from
> > > > > > > Kconfig.
> > > > > >
> > > > > > Kconfig will happily allow "depends on BOGUS_SYMBOL" yes, and a=
 linter
> > > > > > would be a handy thing to have. But you're mentioning this in a=
nother
> > > > > > context, why we need some additional knowledge somewhere.
> > > > >
> > > > > What I meant was that we don't have anything in the Kconfig for F=
OO
> > > > > that says this is a global option or an xPL-specific one. We have=
 to
> > > > > hunt for SPL_FOO, etc.
> > > > >
> > > > > >
> > > > > > > Also, some parts of the code may use CONFIG_IS_ENABLED() for
> > > > > > > an option, some may use IS_ENABLED() for that same option. So=
me may
> > > > > > > use $(PHASE_) and some may not. It's a bit of a mess.
> > > > > >
> > > > > > I'm sure you can find some examples where we have CONFIG_IS_ENA=
BLED(FOO)
> > > > > > and IS_ENABLED(CONFIG_FOO) and it's not intentional, but that's=
 not a
> > > > > > big deal, and should be fixed.
> > > > >
> > > > > But this is largely the point of my series. It's the reason why
> > > > > qconfig is able to locate these cases and warn about them. It is =
a big
> > > > > deal, IMO, or at least big enough for me to attempt this.
> > > > >
> > > > > >
> > > > > > I'm only going to rant slightly that checkpatch.pl telling peop=
le to use
> > > > > > these macros has made the situation worse, not better, out of an
> > > > > > ingrained need to silence checkpatch.pl.
> > > > > >
> > > > > > And what you're missing is that sometimes we intentionally don'=
t want
> > > > > > $(PHASE_), or would need to rewrite the Makefile to make use of=
 it.
> > > > > > fs/Makefile is an example of this.
> > > > >
> > > > > The next step from my side would be to get rid of the 'ifdef
> > > > > CONFIG_XPL_BUILD' in the Makefiles. It's confusing and annoying.
> > > > >
> > > > > >
> > > > > > > Stepping back a bit, perhaps the goal of my series is to iden=
tify
> > > > > > > options in b) so we can deal with them in a better way. They =
are all
> > > > > > > listed in conf_nospl, in preparation for some future action.
> > > > > >
> > > > > > There are two big problems here. The first of which is that con=
f_nospl,
> > > > > > as a concept, is going to be incomplete. Do you list every CMD =
in there?
> > > > > > Why? They'll never be in a non-PPL phase. It will be its own ni=
ghtmare
> > > > > > to keep correct, once it is bug-compatible with what we have to=
day.
> > > > >
> > > > > This is actually the *nice* thing about conf_nospl. We should red=
uce
> > > > > it to empty, just like we did with the Kconfig whitelist.
> > > > >
> > > > > We have this rule:
> > > > >
> > > > > libs-$(CONFIG_CMDLINE) +=3D cmd/
> > > > >
> > > > > which is enough for most things. The only issue is that sometimes,
> > > > > e.g. with CONFIG_CMD_DHCP it doesn't mean the command at all.
> > > > >
> > > > > So I don't agree at all that my series is a 'big problem'. It is a
> > > > > solution to the current confusion and it shows up what is broken =
and
> > > > > needs to be fixed.
> > > > >
> > > > > >
> > > > > > The second big problem is that it doesn't make it any easier to=
 solve
> > > > > > what I keep calling the DWC3 problem. It's a valid use case tha=
t two
> > > > > > developers have hit independently of wanting to enable USB gadg=
et
> > > > > > support (and the HW uses DWC3) in SPL and not PPL. Not only are=
 you not
> > > > > > solving this problem, it gets worse to solve. Today it's "OK, I=
 need to
> > > > > > find where to move obj-$(CONFIG_FOO) to be more visible and
> > > > > > obj-$(CONFIG_$(PHASE_)FOO". Tomorrow it's "Why isn't obj-$(CONF=
IG_FOO)
> > > > > > working here but not there?".
> > > > >
> > > > > Is that because some Makefile higher in the hierarchy is not buil=
ding
> > > > > that subdir? I don't know what this is about.
> > > > >
> > > > > >
> > > > > > To me, at absolute best case here, we're making a lot of change=
s and
> > > > > > spending a lot of time to not really address the underlying pro=
blems,
> > > > > > just making some questionable value visibility changes. We coul=
d reduce
> > > > > > ourselves to one macro by saying only ever use CONFIG_IS_ENABLE=
D(FOO)
> > > > > > and IS_ENABLED(CONFIG_FOO) goes back to an ifdef for the case w=
here it
> > > > > > must only be tested on CONFIG_FOO.
> > > > >
> > > > > Or we could finish and apply my series, which does this.
> > > > >
> > > > > > I'm 80% sure we could simplify all of
> > > > > > $(PHASE_)/$(XPL_)/$(SPL_) down to just $(PHASE_) and that elimi=
nates the
> > > > > > which to use of those question.
> > > > >
> > > > > Again, let's apply my series, which actually gets rid of PHASE_, =
SPL_
> > > > > and XPL_ altogether.
> > > > >
> > > > > > And update / expand upon the existing
> > > > > > documentation we have as it's not clear enough for everyone. Th=
en we can
> > > > > > think, again, about how to solve the problems that are introduc=
ed by
> > > > > > building our entire source tree N times from a single configura=
tion
> > > > > > file. Or if we need to do something radical there.
> > > > >
> > > > > At this point I'm getting the feeling that you imagine my series =
is
> > > > > some grand unified plan for Kconfig. It really isn't and this thr=
ead
> > > > > is reminding me of why I originally wrote it. Bear in mind it was=
 over
> > > > > two years ago and I have mostly forgotten all the issues. It is a
> > > > > clean-up series. It isn't the second coming but it isn't the
> > > > > antichrist either.
> > > >
> > > > I worry you're going to spend another month of effort to get this t=
o 1:1
> > > > compatibility (modulo fixing bugs) with what we have today and get
> > > > disappointed once it rolls out to -next. But I guess I've already s=
pent
> > > > too much time trying to convince you this is a bad idea and that yo=
ur
> > > > cure is worse than the disease.
> > >
> > > To me the core issue is whether to completely split the defconfig
> > > files. I am quite worried about that. You are quite worried about the
> > > confusion my series will cause.
> > >
> > > I think it is reasonable, if we go with my series, that I drive
> > > conf_nospl down to zero lines (and remove the feature) before going
> > > any further. Would that make you more comfortable? It would be a fair
> > > bit of work, but could be done over a few releases.
> >
> > Here is my core concern. Can macros be tricky? Yes. Do we need a
> > checkpatch.pl test for 'IS_ENABLED(FOO)' ? Yes. But the real problem is
> > bugs like:
> > - Take pinebook-pro-rk3399_defconfig
> > - Enable all 3 of: CONFIG_SPL_USB_DWC3_GENERIC CONFIG_SPL_USB_GADGET
> >   CONFIG_SPL_USB_SDP_SUPPORT
> >
> > Your proposal neither fixes that bug nor makes it easier to understand
> > why that bug happens. And this is the category of build problems that we
> > get that aren't "you missed using the right macro".
>=20
> Honestly, what on earth does this have to do with my series?

It's that your series doesn't address the real problems we keep having.

> The problem happens before and after my series, from what I can tell.

Yes, I've said that numerous times.

> If you want these sorts of combinations to be tested, perhaps add a
> board that enables them, or even rethink your opposition to my
> buildman proposal?[4]

This isn't relevant to the point I've raised several times now. The
failure mode above was reported by two different developers, neither of
whom saw how to correctly solve the problem.

And again, if you tried to solve this problem on your series you might
see how what you're proposing will make things worse, not better.

--=20
Tom

--X1JIclY1x8sthzb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme9zYIACgkQFHw5/5Y0
tyzlgAv+L1vCqEtgI3mXYNMjWwwUN/MCD+VDGiM5BUhWNzwgn7FZbnW3QuWtkF+U
Raf3i2gjrJnHCeXBgJ8Vdx6Vy72yTj3G3aEpxaCUFSc/pLCF/5rfKi1DKvFWeu0b
cQzNoB7C2jF2hpBZDH3C8y9+QZR4HpqZBZ0zThe9ur5Oua2XjeBDXfjExgyIO1K7
5DHmzJU6rI93rsgkRdvkuqDuqtIsCymIJ4s/CVMOocui6UP42U6x3AojAi8mgpvC
14mwhzaPXEozKihOctIyhKiK2u6LwTFHzDsGDrdeYjZ5Gtwl54fREHw2np408CcV
n4Dx/WG+TPSUpDHG1h7INBAuiWzlaFvcShWR9FSykZb1JWGDN0YDNnzCd7CK86OM
Mi4p2KKqZy8AFMn1GDw6hUaU6W67+RCV80B0towxLfVuyzcJFyWY8TNA4qFEZ6HX
PbaJBq6GaMkoUXRaHK9UbdDNbjrhzfz7VemuQM2hDzxslFlt4947FGbs1yYvjkZ+
3WUyXDPM
=BOLj
-----END PGP SIGNATURE-----

--X1JIclY1x8sthzb4--
