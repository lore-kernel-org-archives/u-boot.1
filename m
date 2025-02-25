Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D78C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 21:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E4880805;
	Tue, 25 Feb 2025 22:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HXbZrVRA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FFF180FD4; Tue, 25 Feb 2025 22:51:09 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8285B801CF
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 22:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-86714f41f5bso1709338241.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 13:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740520265; x=1741125065; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dcYwd79pD3JlPzp3kLsLat+XuJsz8hnG7DW6jfxxfC0=;
 b=HXbZrVRAgbwQAy5yw1yRA/WTsh1yQhSEOLANNHAkHKwLY0p5nHX+55HadndQfTfSEd
 TJkSOatyTfDVpZrE6cuZFzvjMrjLrN38xLNrUE8gENKo1VAQVPqCDBIKPCctfCExktOy
 He/ihxT3rkk3cVPV0MGkdhS/CHyPbZDAhtFIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740520265; x=1741125065;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcYwd79pD3JlPzp3kLsLat+XuJsz8hnG7DW6jfxxfC0=;
 b=dRCGz7CdMGjiOZTqpG9lvjDr0pPSZeny9s4P1m+OlSxbNBWU/EJThD/qTd4uV8FTdl
 W/Y4oouaCJGGJGz/6CB9oQdY6O4rF046PogY4XSIQB02JQ4co6csrpDGlSP4/N+EmWX2
 X5Rf3phidZthERWlug7asfqeRiC+wvC/UNfdWwQCjWGMP0nv76M8o4SoIhRyrUWQxcan
 wHGLMlQlLYPZVdG6qGIiGqhakQA5EEfrRG8IX1WR34mez6YsLTUW6sr5mJU2WAnn0KAu
 cM9rcEK7b8PZ39MKD0Z+oRONjNISp4wEmfptCDBYGvFw3uQ5eN0cNl1rBJ1KvWjXV9DW
 CA9Q==
X-Gm-Message-State: AOJu0Yz6+BWahJndw/W3WjWtes8yWTj1qpBlEu6mVP1sZJNqrRwmZxrN
 6fVsvUDBCT+vOxx7h1ht78Qvs842e8tajyihBO6o7g+vw6qj+5DMgOfom2RjQ5I=
X-Gm-Gg: ASbGnctuRTcJeHIDcxWv0StiDacM/vHhDbl3cvC0HNSNVycro8e7u/NBeW6/ojvA9Cc
 nB0Ef6ZdAHHv3qHvAJABmDvXEzQYWJce9K6MruP8h02GWhfYNBBUJYLZdVFO2IgzdXfsWp4t3Ru
 9ume7TFZQ5EvaDu/g8Ux+PJqD2uanG9hyUZAUX/YG4kJGbtmGpge+OYIFx4CVDIolSOGBS08n+p
 QHE4z+gz4rWwE5QoDWP05xcseyqZDACeH7NOBcOicdoJAC55yEkOWlRbZ5LjXSTfDOQkbdTmUB1
 Fpk7qbMc2G6kZeIDkOsCERgw
X-Google-Smtp-Source: AGHT+IGdgmQrHNoAI4L1GZnfSyJYgn2imYtgrotlSYAmc/Q6ArBbbjtzLEKPymGCoCUe+mIxOZrX6Q==
X-Received: by 2002:a05:6102:2907:b0:4b6:18b3:a4db with SMTP id
 ada2fe7eead31-4c01e1cef57mr542669137.8.1740520265173; 
 Tue, 25 Feb 2025 13:51:05 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4c00c5ac733sm410962137.12.2025.02.25.13.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 13:51:04 -0800 (PST)
Date: Tue, 25 Feb 2025 15:51:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250225215100.GC2640854@bill-the-cat>
References: <20250221232005.GV1233568@bill-the-cat>
 <CAFLszTjDukiu-06gRxWmahXB6gKiTQjGPfT1D9TqeMZcG+h_yw@mail.gmail.com>
 <20250222000331.GW1233568@bill-the-cat>
 <CAFLszThbizWn8ja9pwfa6Fn6NBp83BdAUFkoO97PEtUCUuQzBg@mail.gmail.com>
 <20250222010654.GA1233568@bill-the-cat>
 <CAFLszTgS1KtMtuW9vo=F-H5q_km0BLsA5BVU_cZDSV9dgOo_mA@mail.gmail.com>
 <20250224160004.GF1233568@bill-the-cat>
 <CAFLszTjr7DDNdUDDsVyM_+KeFNA9pVu9CYTv12PqGPEad83xkw@mail.gmail.com>
 <20250225140242.GM1233568@bill-the-cat>
 <CAFLszTi6tNhFgXgYdYZpp=1-7P=O8wkAgug5xP2syn=mU==PCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YOeV53a7I5gk6muc"
Content-Disposition: inline
In-Reply-To: <CAFLszTi6tNhFgXgYdYZpp=1-7P=O8wkAgug5xP2syn=mU==PCg@mail.gmail.com>
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


--YOeV53a7I5gk6muc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 02:33:17PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 25 Feb 2025 at 07:02, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Feb 24, 2025 at 04:38:50PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 24 Feb 2025 at 09:00, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Feb 21, 2025 at 07:07:06PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 21 Feb 2025 at 18:06, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Feb 21, 2025 at 05:24:35PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 21 Feb 2025 at 17:03, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, Feb 21, 2025 at 04:35:16PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Fri, 21 Feb 2025 at 16:20, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Feb 21, 2025 at 03:54:52PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi  Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 21 Feb 2025 at 12:26, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, Feb 21, 2025 at 08:19:40AM -0600, Tom Rini =
wrote:
> > > > > > > > > > > > > On Thu, Feb 20, 2025 at 06:30:18PM -0700, Simon G=
lass wrote:
> > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, 20 Feb 2025 at 13:40, Tom Rini <trini@k=
onsulko.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Thu, Feb 20, 2025 at 11:13:34AM -0700, Sim=
on Glass wrote:
> > > > > > > > > > > > [snip]
> > > > > > > > > > > > > > > I will look at "splg4" once it's somewhere on=
 source.denx.de and I can
> > > > > > > > > > > > > > > look at it, and refrain from otherwise assumi=
ng how it solves the
> > > > > > > > > > > > > > > problems I had seen previously.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I pushed an updated version to dm/splg-working =
but it is not very
> > > > > > > > > > > > > > updated. Still needs more work.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Thanks.
> > > > > > > > > > > >
> > > > > > > > > > > > So, after doing the remaining CONFIG_TEXT_BASE -> C=
ONFIG_PPL_TEXT_BASE
> > > > > > > > > > > > changes, here's another example of the problem with=
 your approach. What
> > > > > > > > > > > > stops xilinx_zynqmp_kria from building in splg-work=
ing is that
> > > > > > > > > > > > BUTTON was missing from scripts/conf_nospl. Annoyin=
gly, a mrproper (or
> > > > > > > > > > > > since I always use O=3D, rm -rf) is needed for chan=
ges there to be picked
> > > > > > > > > > > > up, but that's maybe just a missing Makefile depend=
ency line. But that
> > > > > > > > > > > > just makes it easier to see the next problem, which=
 I don't see the
> > > > > > > > > > > > answer to. For PPL, we can build drivers/spi/zynqmp=
_gqspi.o just fine.
> > > > > > > > > > > > For SPL however:
> > > > > > > > > > > >   CC      spl/drivers/spi/zynqmp_gqspi.o
> > > > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_g=
qspi.c: In function 'zynqmp_qspi_of_to_plat':
> > > > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_g=
qspi.c:203:22: warning: cast to pointer from integer of different size [-Wi=
nt-to-pointer-cast]
> > > > > > > > > > > >   203 |         plat->regs =3D (struct zynqmp_qspi_=
regs *)(dev_read_addr(bus) +
> > > > > > > > > > > >       |                      ^
> > > > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_g=
qspi.c:205:26: warning: cast to pointer from integer of different size [-Wi=
nt-to-pointer-cast]
> > > > > > > > > > > >   205 |         plat->dma_regs =3D (struct zynqmp_q=
spi_dma_regs *)
> > > > > > > > > > > >       |                          ^
> > > > > > > > > > > >
> > > > > > > > > > > > And I don't see, really, what's even getting us dow=
n this error path.
> > > > > > > > > > >
> > > > > > > > > > > It's the FDT_64BIT in conf_nospl - that symbol needs =
to be the same
> > > > > > > > > > > across all phases.
> > > > > > > > > > >
> > > > > > > > > > > I pushed a new tree which builds without the warning.=
 Note that
> > > > > > > > > > > SPL_SPI is enabled.
> > > > > > > > > >
> > > > > > > > > > So, the "what" is FDT_64BIT wasn't correct. I think thi=
s is showing that
> > > > > > > > > > scripts/conf_nospl is going to be a problem in and of i=
tself, and likely
> > > > > > > > > > as confusing if not more-so than any of the in-the-end =
visible changes.
> > > > > > > > >
> > > > > > > > > Yes, perhaps the key point I've been trying to get across=
 is this confusion.
> > > > > > > > >
> > > > > > > > > As you know, at present we have two types of options:
> > > > > > > > > a) those for which each phase has its own value
> > > > > > > > > b) those for which there is a single value shared across =
all phases
> > > > > > > >
> > > > > > > > Agreed.
> > > > > > > >
> > > > > > > > > The only way today that you can tell them apart is by loo=
king for uses
> > > > > > > > > of CONFIG_IS_ENABLED() and $(PHASE_) with the option. If =
you see them,
> > > > > > > >
> > > > > > > > Partially agreed. Those are strong indicators that both CON=
FIG_FOO and
> > > > > > > > CONFIG_SPL_FOO exist, but not always. We have, intentionall=
y, both the
> > > > > > > > inverse case (CONFIG_SPL_BAR and CONFIG_TPL_BAR exist, CONF=
IG_BAR does
> > > > > > > > not) and some future-proofing (CONFIG_SPL_BAZ may exist in =
the future,
> > > > > > > > but not yet).
> > > > > > >
> > > > > > > OK
> > > > > > >
> > > > > > > >
> > > > > > > > > then the option is a) otherwise it is b). There is no way=
 to tell from
> > > > > > > > > Kconfig.
> > > > > > > >
> > > > > > > > Kconfig will happily allow "depends on BOGUS_SYMBOL" yes, a=
nd a linter
> > > > > > > > would be a handy thing to have. But you're mentioning this =
in another
> > > > > > > > context, why we need some additional knowledge somewhere.
> > > > > > >
> > > > > > > What I meant was that we don't have anything in the Kconfig f=
or FOO
> > > > > > > that says this is a global option or an xPL-specific one. We =
have to
> > > > > > > hunt for SPL_FOO, etc.
> > > > > > >
> > > > > > > >
> > > > > > > > > Also, some parts of the code may use CONFIG_IS_ENABLED() =
for
> > > > > > > > > an option, some may use IS_ENABLED() for that same option=
=2E Some may
> > > > > > > > > use $(PHASE_) and some may not. It's a bit of a mess.
> > > > > > > >
> > > > > > > > I'm sure you can find some examples where we have CONFIG_IS=
_ENABLED(FOO)
> > > > > > > > and IS_ENABLED(CONFIG_FOO) and it's not intentional, but th=
at's not a
> > > > > > > > big deal, and should be fixed.
> > > > > > >
> > > > > > > But this is largely the point of my series. It's the reason w=
hy
> > > > > > > qconfig is able to locate these cases and warn about them. It=
 is a big
> > > > > > > deal, IMO, or at least big enough for me to attempt this.
> > > > > > >
> > > > > > > >
> > > > > > > > I'm only going to rant slightly that checkpatch.pl telling =
people to use
> > > > > > > > these macros has made the situation worse, not better, out =
of an
> > > > > > > > ingrained need to silence checkpatch.pl.
> > > > > > > >
> > > > > > > > And what you're missing is that sometimes we intentionally =
don't want
> > > > > > > > $(PHASE_), or would need to rewrite the Makefile to make us=
e of it.
> > > > > > > > fs/Makefile is an example of this.
> > > > > > >
> > > > > > > The next step from my side would be to get rid of the 'ifdef
> > > > > > > CONFIG_XPL_BUILD' in the Makefiles. It's confusing and annoyi=
ng.
> > > > > > >
> > > > > > > >
> > > > > > > > > Stepping back a bit, perhaps the goal of my series is to =
identify
> > > > > > > > > options in b) so we can deal with them in a better way. T=
hey are all
> > > > > > > > > listed in conf_nospl, in preparation for some future acti=
on.
> > > > > > > >
> > > > > > > > There are two big problems here. The first of which is that=
 conf_nospl,
> > > > > > > > as a concept, is going to be incomplete. Do you list every =
CMD in there?
> > > > > > > > Why? They'll never be in a non-PPL phase. It will be its ow=
n nightmare
> > > > > > > > to keep correct, once it is bug-compatible with what we hav=
e today.
> > > > > > >
> > > > > > > This is actually the *nice* thing about conf_nospl. We should=
 reduce
> > > > > > > it to empty, just like we did with the Kconfig whitelist.
> > > > > > >
> > > > > > > We have this rule:
> > > > > > >
> > > > > > > libs-$(CONFIG_CMDLINE) +=3D cmd/
> > > > > > >
> > > > > > > which is enough for most things. The only issue is that somet=
imes,
> > > > > > > e.g. with CONFIG_CMD_DHCP it doesn't mean the command at all.
> > > > > > >
> > > > > > > So I don't agree at all that my series is a 'big problem'. It=
 is a
> > > > > > > solution to the current confusion and it shows up what is bro=
ken and
> > > > > > > needs to be fixed.
> > > > > > >
> > > > > > > >
> > > > > > > > The second big problem is that it doesn't make it any easie=
r to solve
> > > > > > > > what I keep calling the DWC3 problem. It's a valid use case=
 that two
> > > > > > > > developers have hit independently of wanting to enable USB =
gadget
> > > > > > > > support (and the HW uses DWC3) in SPL and not PPL. Not only=
 are you not
> > > > > > > > solving this problem, it gets worse to solve. Today it's "O=
K, I need to
> > > > > > > > find where to move obj-$(CONFIG_FOO) to be more visible and
> > > > > > > > obj-$(CONFIG_$(PHASE_)FOO". Tomorrow it's "Why isn't obj-$(=
CONFIG_FOO)
> > > > > > > > working here but not there?".
> > > > > > >
> > > > > > > Is that because some Makefile higher in the hierarchy is not =
building
> > > > > > > that subdir? I don't know what this is about.
> > > > > > >
> > > > > > > >
> > > > > > > > To me, at absolute best case here, we're making a lot of ch=
anges and
> > > > > > > > spending a lot of time to not really address the underlying=
 problems,
> > > > > > > > just making some questionable value visibility changes. We =
could reduce
> > > > > > > > ourselves to one macro by saying only ever use CONFIG_IS_EN=
ABLED(FOO)
> > > > > > > > and IS_ENABLED(CONFIG_FOO) goes back to an ifdef for the ca=
se where it
> > > > > > > > must only be tested on CONFIG_FOO.
> > > > > > >
> > > > > > > Or we could finish and apply my series, which does this.
> > > > > > >
> > > > > > > > I'm 80% sure we could simplify all of
> > > > > > > > $(PHASE_)/$(XPL_)/$(SPL_) down to just $(PHASE_) and that e=
liminates the
> > > > > > > > which to use of those question.
> > > > > > >
> > > > > > > Again, let's apply my series, which actually gets rid of PHAS=
E_, SPL_
> > > > > > > and XPL_ altogether.
> > > > > > >
> > > > > > > > And update / expand upon the existing
> > > > > > > > documentation we have as it's not clear enough for everyone=
=2E Then we can
> > > > > > > > think, again, about how to solve the problems that are intr=
oduced by
> > > > > > > > building our entire source tree N times from a single confi=
guration
> > > > > > > > file. Or if we need to do something radical there.
> > > > > > >
> > > > > > > At this point I'm getting the feeling that you imagine my ser=
ies is
> > > > > > > some grand unified plan for Kconfig. It really isn't and this=
 thread
> > > > > > > is reminding me of why I originally wrote it. Bear in mind it=
 was over
> > > > > > > two years ago and I have mostly forgotten all the issues. It =
is a
> > > > > > > clean-up series. It isn't the second coming but it isn't the
> > > > > > > antichrist either.
> > > > > >
> > > > > > I worry you're going to spend another month of effort to get th=
is to 1:1
> > > > > > compatibility (modulo fixing bugs) with what we have today and =
get
> > > > > > disappointed once it rolls out to -next. But I guess I've alrea=
dy spent
> > > > > > too much time trying to convince you this is a bad idea and tha=
t your
> > > > > > cure is worse than the disease.
> > > > >
> > > > > To me the core issue is whether to completely split the defconfig
> > > > > files. I am quite worried about that. You are quite worried about=
 the
> > > > > confusion my series will cause.
> > > > >
> > > > > I think it is reasonable, if we go with my series, that I drive
> > > > > conf_nospl down to zero lines (and remove the feature) before goi=
ng
> > > > > any further. Would that make you more comfortable? It would be a =
fair
> > > > > bit of work, but could be done over a few releases.
> > > >
> > > > Here is my core concern. Can macros be tricky? Yes. Do we need a
> > > > checkpatch.pl test for 'IS_ENABLED(FOO)' ? Yes. But the real proble=
m is
> > > > bugs like:
> > > > - Take pinebook-pro-rk3399_defconfig
> > > > - Enable all 3 of: CONFIG_SPL_USB_DWC3_GENERIC CONFIG_SPL_USB_GADGET
> > > >   CONFIG_SPL_USB_SDP_SUPPORT
> > > >
> > > > Your proposal neither fixes that bug nor makes it easier to underst=
and
> > > > why that bug happens. And this is the category of build problems th=
at we
> > > > get that aren't "you missed using the right macro".
> > >
> > > Honestly, what on earth does this have to do with my series?
> >
> > It's that your series doesn't address the real problems we keep having.
> >
> > > The problem happens before and after my series, from what I can tell.
> >
> > Yes, I've said that numerous times.
> >
> > > If you want these sorts of combinations to be tested, perhaps add a
> > > board that enables them, or even rethink your opposition to my
> > > buildman proposal?[4]
> >
> > This isn't relevant to the point I've raised several times now. The
> > failure mode above was reported by two different developers, neither of
> > whom saw how to correctly solve the problem.
>=20
> That surprises me a little, as the problem seems pretty fundamental.
> If you don't enable USB_GADGET, then symbols which depend on it don't
> exist.

But they don't want USB_GADGET in PPL. They only want it in SPL.

> > And again, if you tried to solve this problem on your series you might
> > see how what you're proposing will make things worse, not better.
>=20
> At least with my scheme you can do something like this:
>=20
> config SPL_USB_GADGET
>    bool "USB Gadget Support in SPL"
>    depends on USB_GADGET

That symbol already exists. The problems are around all of the gadget
symbols that don't exist.

> I normally make the SPL symbols depend on PPL, since it normally
> doesn't make a lot of sense to have the feature in SPL unless it is in
> PPL. Is this an exception to that rule?

This half of the problem (you're still missing the other half of the
problem, the DWC3 code being built in TPL now and throwing
warnings-turned-error with -Werror and then discarded at link time) is
one of many examples where we keep having to duplicate symbols in
Kconfig.

> If we do go ahead and enhance Kconfig, then we can combine the two
> symbols, which is something.

Or, we go the direction I suggested instead. Where we never duplicate
symbols, because we never need to anymore.

Or, we step back because believe you're missing the bigger problems.

--=20
Tom

--YOeV53a7I5gk6muc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme+Oz0ACgkQFHw5/5Y0
tyyCmwv+JSEDHPcLCh6g2Zn4hmN+rAAEzfXISRBMNgpC8uG59PGV67+6HaT8xCOT
yiQ0wBI2AMsYYZmRpMehqJIwZZWnsUBshy6T0ywgmRw7lOeZaT0o6YZQtTSt4fed
9X9LO6TEqsGjMLvQVcA6JPB8AEyGSbABaZo2njtGI9DPLWNzn549Gpmj6bHZgjD5
86J1FALH0qvmFdW1tQH8UPpUcrUOLfmppg/knSyKQe5ayD682RQa8eU4kFZI6QTK
8tv6jYxm133mUzYczE1yE4T9m0KT6bR0Q/pAKK0FZFurDdBXH5u9Iqvn8SsnyXvL
g4NeqSewlhGox0sXQDVWDA85CvQi8mly7dkQb8ZIGj5s4/agot3P52/9Kaasw085
KRvxYZYObDExxJtXxHojuYZBz9lN+HayWZXyHxTRUNDLsJDIOa85YhMHCjSDAs5a
Z9eY01s0jzO3RAFDGJ1btwq5f6IqY6DcWbrcbfTLP2Y8um+eKzH8d3NAUEK5wxwE
fnVJ8KHU
=Lhvq
-----END PGP SIGNATURE-----

--YOeV53a7I5gk6muc--
