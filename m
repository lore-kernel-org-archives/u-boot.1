Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF35C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72609807D9;
	Tue,  4 Mar 2025 17:25:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S/rivksS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3D078004F; Tue,  4 Mar 2025 17:25:30 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83D52801CF
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e60cab0f287so2373890276.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 08:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741105525; x=1741710325; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3E+NPO/nEjnTCO0ZaNrXfc4XHkKrfjGTCLT2Tb+a1vs=;
 b=S/rivksSZ+wGoa19FrN0fz1/I257oV94/9/kXR3rFeNxl3XN3kKLuuNXIn4/I2thf3
 MdUFs9h3eSxhfrejv5EY6wBUOrJKzdwvh/LDfuZj3CwsmADJHUXiNcjzTL5GbaDgAPYz
 HaDK+fhMqAlFgd4/cCqQEntTn7YZOI76kqZxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741105525; x=1741710325;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3E+NPO/nEjnTCO0ZaNrXfc4XHkKrfjGTCLT2Tb+a1vs=;
 b=ihZ+PKaHe0oZT+H5GfAOBISX9Kv+Og+DPPNsZnOPp+4eUVo00p4D5YGQMG9UCJI69/
 BfmH5Zo1W310t2c+spMhLMQWWotZiq8bpe83U0Br/eVeUZ902mKuREOnJYqNphw3yQrA
 VRwk8SS6+v7tWyvs5Vct6aoHwVx1GvnG2g3cA+yyIAajf7A2RFRHuChrFt52iSgVrd6x
 XEUjiKT0W+9YgXcPwImVkOVmingBOfRAoHqG3u72/lldLpppbuLyYkRrt3DQ7FzOgbMp
 fFadQ0MCXWvSR11C/b+T+dkOdSDg5MDfepRzrfVsdFcLytH5Vqe5tL9/tCt76DP18SoU
 hRWg==
X-Gm-Message-State: AOJu0YwtjgE0BUBcAOjYTBdASS/aq2A71Ncioxm17hjF5zQx+Sa40x1A
 niQ7R3z0xawr7gOoQVToWmQQXWEf2aGG/lcFA7owR4B/ElMywr9HtVaRPxHOZRU=
X-Gm-Gg: ASbGnctJpz4ThRpR1W9DnceyBZufTzmZ1UFHoahfwRaM4q26jbB406KcdYO4WYfdm9H
 F0YoGP8ZhoMNW6ful335OeKJPKVBwjHEOv0JCqjWdR+kOb9VICuwvEixPVqjH3jJjHIWlA16v5Y
 sY44gkdbY3NjAxf2MiMbQ32IPcuzKZFNbW7JhfJhrlZjjgdJBZPCXBqUg/Bz2/H/q0lEf5zqF4J
 IUv73bdraLLHSwallRA5wX9LQHA7lR1ioyUWMCnTeStBpEg+3Z3G1sc3AzKyscjbVuI1rQ3Vd/H
 bNtQEaRxArFWTfPca1gpOVRT7QCFSkpFFBI3y7R4Jds=
X-Google-Smtp-Source: AGHT+IEMqlZesoKzSVi8PrhjQO9wR/6vcz1H2TqVKMZvgNBFRnDZPrm7mx/t7L3tJLz+IkwV0Tg4yQ==
X-Received: by 2002:a05:690c:288b:b0:6fb:968b:d8f5 with SMTP id
 00721157ae682-6fd4a16c59fmr180730717b3.36.1741105524980; 
 Tue, 04 Mar 2025 08:25:24 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3ca41d89sm25221787b3.31.2025.03.04.08.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 08:25:24 -0800 (PST)
Date: Tue, 4 Mar 2025 10:25:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250304162521.GB2640854@bill-the-cat>
References: <20250225140242.GM1233568@bill-the-cat>
 <CAFLszTi6tNhFgXgYdYZpp=1-7P=O8wkAgug5xP2syn=mU==PCg@mail.gmail.com>
 <20250225215100.GC2640854@bill-the-cat>
 <CAFLszTiP3=FyUm36aLPfdwObQT0WPS_+Y486VRmV41cxEkA93w@mail.gmail.com>
 <20250226145255.GJ2640854@bill-the-cat>
 <CAFLszTgMdR6fSDxUTKO3Mru3YU6=HK52tU2+rgri3J_TXWiTUg@mail.gmail.com>
 <20250227171753.GG2640854@bill-the-cat>
 <CAFLszTg1A0HiaqVPxY3utpztOw6QFNQGZwPgtN9tZBN+3E9TiQ@mail.gmail.com>
 <20250227203017.GK2640854@bill-the-cat>
 <CAFLszTgA9G8pueG5w6Vjq8Qg3Qqwivs=9J2ZiuBk2dv+tr1pOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qqmva4otxBHmPuYF"
Content-Disposition: inline
In-Reply-To: <CAFLszTgA9G8pueG5w6Vjq8Qg3Qqwivs=9J2ZiuBk2dv+tr1pOg@mail.gmail.com>
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


--Qqmva4otxBHmPuYF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 08:35:29AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 27 Feb 2025 at 13:30, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 27, 2025 at 12:32:42PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 27 Feb 2025 at 10:17, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Feb 27, 2025 at 09:24:45AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 26 Feb 2025 at 07:53, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 25, 2025 at 07:51:07PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 25 Feb 2025 at 14:51, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Tue, Feb 25, 2025 at 02:33:17PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Tue, 25 Feb 2025 at 07:02, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Feb 24, 2025 at 04:38:50PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 24 Feb 2025 at 09:00, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, Feb 21, 2025 at 07:07:06PM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 21 Feb 2025 at 18:06, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 05:24:35PM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Fri, 21 Feb 2025 at 17:03, Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 04:35:16PM -0700, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Fri, 21 Feb 2025 at 16:20, Tom Rini <t=
rini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 03:54:52PM -070=
0, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > Hi  Tom,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Fri, 21 Feb 2025 at 12:26, Tom Rin=
i <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 08:19:40AM =
-0600, Tom Rini wrote:
> > > > > > > > > > > > > > > > > > > > > On Thu, Feb 20, 2025 at 06:30:18P=
M -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > On Thu, 20 Feb 2025 at 13:40, T=
om Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > On Thu, Feb 20, 2025 at 11:13=
:34AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > [snip]
> > > > > > > > > > > > > > > > > > > > > > > I will look at "splg4" once i=
t's somewhere on source.denx.de and I can
> > > > > > > > > > > > > > > > > > > > > > > look at it, and refrain from =
otherwise assuming how it solves the
> > > > > > > > > > > > > > > > > > > > > > > problems I had seen previousl=
y.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > I pushed an updated version to =
dm/splg-working but it is not very
> > > > > > > > > > > > > > > > > > > > > > updated. Still needs more work.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Thanks.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > So, after doing the remaining CONFI=
G_TEXT_BASE -> CONFIG_PPL_TEXT_BASE
> > > > > > > > > > > > > > > > > > > > changes, here's another example of =
the problem with your approach. What
> > > > > > > > > > > > > > > > > > > > stops xilinx_zynqmp_kria from build=
ing in splg-working is that
> > > > > > > > > > > > > > > > > > > > BUTTON was missing from scripts/con=
f_nospl. Annoyingly, a mrproper (or
> > > > > > > > > > > > > > > > > > > > since I always use O=3D, rm -rf) is=
 needed for changes there to be picked
> > > > > > > > > > > > > > > > > > > > up, but that's maybe just a missing=
 Makefile dependency line. But that
> > > > > > > > > > > > > > > > > > > > just makes it easier to see the nex=
t problem, which I don't see the
> > > > > > > > > > > > > > > > > > > > answer to. For PPL, we can build dr=
ivers/spi/zynqmp_gqspi.o just fine.
> > > > > > > > > > > > > > > > > > > > For SPL however:
> > > > > > > > > > > > > > > > > > > >   CC      spl/drivers/spi/zynqmp_gq=
spi.o
> > > > > > > > > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/driv=
ers/spi/zynqmp_gqspi.c: In function 'zynqmp_qspi_of_to_plat':
> > > > > > > > > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/driv=
ers/spi/zynqmp_gqspi.c:203:22: warning: cast to pointer from integer of dif=
ferent size [-Wint-to-pointer-cast]
> > > > > > > > > > > > > > > > > > > >   203 |         plat->regs =3D (str=
uct zynqmp_qspi_regs *)(dev_read_addr(bus) +
> > > > > > > > > > > > > > > > > > > >       |                      ^
> > > > > > > > > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/driv=
ers/spi/zynqmp_gqspi.c:205:26: warning: cast to pointer from integer of dif=
ferent size [-Wint-to-pointer-cast]
> > > > > > > > > > > > > > > > > > > >   205 |         plat->dma_regs =3D =
(struct zynqmp_qspi_dma_regs *)
> > > > > > > > > > > > > > > > > > > >       |                          ^
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > And I don't see, really, what's eve=
n getting us down this error path.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > It's the FDT_64BIT in conf_nospl - th=
at symbol needs to be the same
> > > > > > > > > > > > > > > > > > > across all phases.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > I pushed a new tree which builds with=
out the warning. Note that
> > > > > > > > > > > > > > > > > > > SPL_SPI is enabled.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > So, the "what" is FDT_64BIT wasn't corr=
ect. I think this is showing that
> > > > > > > > > > > > > > > > > > scripts/conf_nospl is going to be a pro=
blem in and of itself, and likely
> > > > > > > > > > > > > > > > > > as confusing if not more-so than any of=
 the in-the-end visible changes.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Yes, perhaps the key point I've been tryi=
ng to get across is this confusion.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > As you know, at present we have two types=
 of options:
> > > > > > > > > > > > > > > > > a) those for which each phase has its own=
 value
> > > > > > > > > > > > > > > > > b) those for which there is a single valu=
e shared across all phases
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Agreed.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > The only way today that you can tell them=
 apart is by looking for uses
> > > > > > > > > > > > > > > > > of CONFIG_IS_ENABLED() and $(PHASE_) with=
 the option. If you see them,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Partially agreed. Those are strong indicato=
rs that both CONFIG_FOO and
> > > > > > > > > > > > > > > > CONFIG_SPL_FOO exist, but not always. We ha=
ve, intentionally, both the
> > > > > > > > > > > > > > > > inverse case (CONFIG_SPL_BAR and CONFIG_TPL=
_BAR exist, CONFIG_BAR does
> > > > > > > > > > > > > > > > not) and some future-proofing (CONFIG_SPL_B=
AZ may exist in the future,
> > > > > > > > > > > > > > > > but not yet).
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > OK
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > then the option is a) otherwise it is b).=
 There is no way to tell from
> > > > > > > > > > > > > > > > > Kconfig.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Kconfig will happily allow "depends on BOGU=
S_SYMBOL" yes, and a linter
> > > > > > > > > > > > > > > > would be a handy thing to have. But you're =
mentioning this in another
> > > > > > > > > > > > > > > > context, why we need some additional knowle=
dge somewhere.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > What I meant was that we don't have anything =
in the Kconfig for FOO
> > > > > > > > > > > > > > > that says this is a global option or an xPL-s=
pecific one. We have to
> > > > > > > > > > > > > > > hunt for SPL_FOO, etc.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Also, some parts of the code may use CONF=
IG_IS_ENABLED() for
> > > > > > > > > > > > > > > > > an option, some may use IS_ENABLED() for =
that same option. Some may
> > > > > > > > > > > > > > > > > use $(PHASE_) and some may not. It's a bi=
t of a mess.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I'm sure you can find some examples where w=
e have CONFIG_IS_ENABLED(FOO)
> > > > > > > > > > > > > > > > and IS_ENABLED(CONFIG_FOO) and it's not int=
entional, but that's not a
> > > > > > > > > > > > > > > > big deal, and should be fixed.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > But this is largely the point of my series. I=
t's the reason why
> > > > > > > > > > > > > > > qconfig is able to locate these cases and war=
n about them. It is a big
> > > > > > > > > > > > > > > deal, IMO, or at least big enough for me to a=
ttempt this.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I'm only going to rant slightly that checkp=
atch.pl telling people to use
> > > > > > > > > > > > > > > > these macros has made the situation worse, =
not better, out of an
> > > > > > > > > > > > > > > > ingrained need to silence checkpatch.pl.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > And what you're missing is that sometimes w=
e intentionally don't want
> > > > > > > > > > > > > > > > $(PHASE_), or would need to rewrite the Mak=
efile to make use of it.
> > > > > > > > > > > > > > > > fs/Makefile is an example of this.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The next step from my side would be to get ri=
d of the 'ifdef
> > > > > > > > > > > > > > > CONFIG_XPL_BUILD' in the Makefiles. It's conf=
using and annoying.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Stepping back a bit, perhaps the goal of =
my series is to identify
> > > > > > > > > > > > > > > > > options in b) so we can deal with them in=
 a better way. They are all
> > > > > > > > > > > > > > > > > listed in conf_nospl, in preparation for =
some future action.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > There are two big problems here. The first =
of which is that conf_nospl,
> > > > > > > > > > > > > > > > as a concept, is going to be incomplete. Do=
 you list every CMD in there?
> > > > > > > > > > > > > > > > Why? They'll never be in a non-PPL phase. I=
t will be its own nightmare
> > > > > > > > > > > > > > > > to keep correct, once it is bug-compatible =
with what we have today.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > This is actually the *nice* thing about conf_=
nospl. We should reduce
> > > > > > > > > > > > > > > it to empty, just like we did with the Kconfi=
g whitelist.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > We have this rule:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > libs-$(CONFIG_CMDLINE) +=3D cmd/
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > which is enough for most things. The only iss=
ue is that sometimes,
> > > > > > > > > > > > > > > e.g. with CONFIG_CMD_DHCP it doesn't mean the=
 command at all.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > So I don't agree at all that my series is a '=
big problem'. It is a
> > > > > > > > > > > > > > > solution to the current confusion and it show=
s up what is broken and
> > > > > > > > > > > > > > > needs to be fixed.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > The second big problem is that it doesn't m=
ake it any easier to solve
> > > > > > > > > > > > > > > > what I keep calling the DWC3 problem. It's =
a valid use case that two
> > > > > > > > > > > > > > > > developers have hit independently of wantin=
g to enable USB gadget
> > > > > > > > > > > > > > > > support (and the HW uses DWC3) in SPL and n=
ot PPL. Not only are you not
> > > > > > > > > > > > > > > > solving this problem, it gets worse to solv=
e. Today it's "OK, I need to
> > > > > > > > > > > > > > > > find where to move obj-$(CONFIG_FOO) to be =
more visible and
> > > > > > > > > > > > > > > > obj-$(CONFIG_$(PHASE_)FOO". Tomorrow it's "=
Why isn't obj-$(CONFIG_FOO)
> > > > > > > > > > > > > > > > working here but not there?".
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Is that because some Makefile higher in the h=
ierarchy is not building
> > > > > > > > > > > > > > > that subdir? I don't know what this is about.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > To me, at absolute best case here, we're ma=
king a lot of changes and
> > > > > > > > > > > > > > > > spending a lot of time to not really addres=
s the underlying problems,
> > > > > > > > > > > > > > > > just making some questionable value visibil=
ity changes. We could reduce
> > > > > > > > > > > > > > > > ourselves to one macro by saying only ever =
use CONFIG_IS_ENABLED(FOO)
> > > > > > > > > > > > > > > > and IS_ENABLED(CONFIG_FOO) goes back to an =
ifdef for the case where it
> > > > > > > > > > > > > > > > must only be tested on CONFIG_FOO.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Or we could finish and apply my series, which=
 does this.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I'm 80% sure we could simplify all of
> > > > > > > > > > > > > > > > $(PHASE_)/$(XPL_)/$(SPL_) down to just $(PH=
ASE_) and that eliminates the
> > > > > > > > > > > > > > > > which to use of those question.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Again, let's apply my series, which actually =
gets rid of PHASE_, SPL_
> > > > > > > > > > > > > > > and XPL_ altogether.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > And update / expand upon the existing
> > > > > > > > > > > > > > > > documentation we have as it's not clear eno=
ugh for everyone. Then we can
> > > > > > > > > > > > > > > > think, again, about how to solve the proble=
ms that are introduced by
> > > > > > > > > > > > > > > > building our entire source tree N times fro=
m a single configuration
> > > > > > > > > > > > > > > > file. Or if we need to do something radical=
 there.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > At this point I'm getting the feeling that yo=
u imagine my series is
> > > > > > > > > > > > > > > some grand unified plan for Kconfig. It reall=
y isn't and this thread
> > > > > > > > > > > > > > > is reminding me of why I originally wrote it.=
 Bear in mind it was over
> > > > > > > > > > > > > > > two years ago and I have mostly forgotten all=
 the issues. It is a
> > > > > > > > > > > > > > > clean-up series. It isn't the second coming b=
ut it isn't the
> > > > > > > > > > > > > > > antichrist either.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I worry you're going to spend another month of =
effort to get this to 1:1
> > > > > > > > > > > > > > compatibility (modulo fixing bugs) with what we=
 have today and get
> > > > > > > > > > > > > > disappointed once it rolls out to -next. But I =
guess I've already spent
> > > > > > > > > > > > > > too much time trying to convince you this is a =
bad idea and that your
> > > > > > > > > > > > > > cure is worse than the disease.
> > > > > > > > > > > > >
> > > > > > > > > > > > > To me the core issue is whether to completely spl=
it the defconfig
> > > > > > > > > > > > > files. I am quite worried about that. You are qui=
te worried about the
> > > > > > > > > > > > > confusion my series will cause.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I think it is reasonable, if we go with my series=
, that I drive
> > > > > > > > > > > > > conf_nospl down to zero lines (and remove the fea=
ture) before going
> > > > > > > > > > > > > any further. Would that make you more comfortable=
? It would be a fair
> > > > > > > > > > > > > bit of work, but could be done over a few release=
s.
> > > > > > > > > > > >
> > > > > > > > > > > > Here is my core concern. Can macros be tricky? Yes.=
 Do we need a
> > > > > > > > > > > > checkpatch.pl test for 'IS_ENABLED(FOO)' ? Yes. But=
 the real problem is
> > > > > > > > > > > > bugs like:
> > > > > > > > > > > > - Take pinebook-pro-rk3399_defconfig
> > > > > > > > > > > > - Enable all 3 of: CONFIG_SPL_USB_DWC3_GENERIC CONF=
IG_SPL_USB_GADGET
> > > > > > > > > > > >   CONFIG_SPL_USB_SDP_SUPPORT
> > > > > > > > > > > >
> > > > > > > > > > > > Your proposal neither fixes that bug nor makes it e=
asier to understand
> > > > > > > > > > > > why that bug happens. And this is the category of b=
uild problems that we
> > > > > > > > > > > > get that aren't "you missed using the right macro".
> > > > > > > > > > >
> > > > > > > > > > > Honestly, what on earth does this have to do with my =
series?
> > > > > > > > > >
> > > > > > > > > > It's that your series doesn't address the real problems=
 we keep having.
> > > > > > > > > >
> > > > > > > > > > > The problem happens before and after my series, from =
what I can tell.
> > > > > > > > > >
> > > > > > > > > > Yes, I've said that numerous times.
> > > > > > > > > >
> > > > > > > > > > > If you want these sorts of combinations to be tested,=
 perhaps add a
> > > > > > > > > > > board that enables them, or even rethink your opposit=
ion to my
> > > > > > > > > > > buildman proposal?[4]
> > > > > > > > > >
> > > > > > > > > > This isn't relevant to the point I've raised several ti=
mes now. The
> > > > > > > > > > failure mode above was reported by two different develo=
pers, neither of
> > > > > > > > > > whom saw how to correctly solve the problem.
> > > > > > > > >
> > > > > > > > > That surprises me a little, as the problem seems pretty f=
undamental.
> > > > > > > > > If you don't enable USB_GADGET, then symbols which depend=
 on it don't
> > > > > > > > > exist.
> > > > > > > >
> > > > > > > > But they don't want USB_GADGET in PPL. They only want it in=
 SPL.
> > > > > > >
> > > > > > > That seems to be splitting hairs, but OK. So why not make
> > > > > > > USB_GADGET_MANUFACTURER depend on USB_GADGET || SPL_USB_GADGE=
T ?
> > > > > >
> > > > > > Yes, the solution today involves reworking drivers/usb/gadget/K=
config so
> > > > > > that USB_GADGET_MANUFACTURER, USB_GADGET_VENDOR_NUM,
> > > > > > USB_GADGET_PRODUCT_NUM, USB_GADGET_VBUS_DRAW and that might be =
it, are
> > > > > > exposed to USB_GADGET || SPL_USB_GADGET and possibly down the l=
ine
> > > > > > VPL_USB_GADGET.
> > > > >
> > > > > OK
> > > > >
> > > > > >
> > > > > > > It wouldn't make sense to add SPL_USB_GADGET_MANUFACTURER as =
surely it
> > > > > > > would be the same value? This is once good thing about what w=
e have:
> > > > > > > we can share values between phases without typing them in sep=
arately.
> > > > > >
> > > > > > Most of these should be, there may or may not be the questionab=
le case
> > > > > > where one of the ID changes so the host knows what stage things=
 are at.
> > > > > > But that's just an aside.
> > > > > >
> > > > > > My point is that drivers/usb/gadget/Kconfig is yet another case=
 where we
> > > > > > need to make it much more complicated so that it works for all =
the use
> > > > > > cases. And that it's a more common and harder for developers to=
 fix
> > > > > > problem than "Do I use $(SPL_TPL_) I mean $(PHASE_) or $(XPL_) =
in the
> > > > > > Makefile?"
> > > > >
> > > > > Yes, I understand that, but this is a tradeoff between that compl=
exity
> > > > > and the one we would introduce by splitting the defconfigs. Given=
 all
> > > > > the Kconfig churn it would require just to get things to work, it
> > > > > isn't a clear win, to say the least.
> > > >
> > > > Since we would be removing stuff from Kconfig with the larger idea I
> > > > proposed, I'm not sure what you mean. We wouldn't have this problem=
 at
> > > > all with the larger idea.
> > >
> > > But we have other problems, mainly that we cannot easily use an option
> > > from one phase in another, so need to duplicate all such options, then
> > > add tooling to try to keep them in sync, except when we don't want
> > > them in sync, etc. Are you sure you have thought this through all the
> > > way?
> >
> > Yes, I have. Because rarely are there cases where we *need* to share a
> > value from multiple phases *and* we can't have the default be correct.
>=20
> You're likely right about this, but I can imagine it being quite
> painful for the cases where we do need something. We could have some
> kconfig tooling which prints a list of those cases, perhaps.
>=20
> >
> > > > > > > > > > And again, if you tried to solve this problem on your s=
eries you might
> > > > > > > > > > see how what you're proposing will make things worse, n=
ot better.
> > > > > > > > >
> > > > > > > > > At least with my scheme you can do something like this:
> > > > > > > > >
> > > > > > > > > config SPL_USB_GADGET
> > > > > > > > >    bool "USB Gadget Support in SPL"
> > > > > > > > >    depends on USB_GADGET
> > > > > > > >
> > > > > > > > That symbol already exists. The problems are around all of =
the gadget
> > > > > > > > symbols that don't exist.
> > > > > > >
> > > > > > > OK. But we have to move in steps. We can't do everything at o=
nce.
> > > > > >
> > > > > > Yes, which is why we have so many of these duplicative symbols
> > > > > > (USB_GADGET, SPL_USB_GADGET) and keep needing to add more.
> > > > >
> > > > > Yes, I don't like it either. I believe that if I had been able to=
 land
> > > > > my solution last time, we would be having different discussions by
> > > > > now, e.g. how to tidy up the Kconfig without changing the build
> > > > > system.
> > > >
> > > > I strongly doubt it.
> > >
> > > I know you do, but I could be right about this.
> >
> > You could. But you could also be very wrong. And the struggle I've had
> > with showing you problems other developers have has not left me feeling
> > great. But I've still said I'll take this but need you to commit to
> > following up with bug reports.
>=20
> I'm happy to follow up with bug reports.
>=20
> >
> > > > > > > > > I normally make the SPL symbols depend on PPL, since it n=
ormally
> > > > > > > > > doesn't make a lot of sense to have the feature in SPL un=
less it is in
> > > > > > > > > PPL. Is this an exception to that rule?
> > > > > > > >
> > > > > > > > This half of the problem (you're still missing the other ha=
lf of the
> > > > > > > > problem, the DWC3 code being built in TPL now and throwing
> > > > > > > > warnings-turned-error with -Werror and then discarded at li=
nk time) is
> > > > > > > > one of many examples where we keep having to duplicate symb=
ols in
> > > > > > > > Kconfig.
> > > > > > >
> > > > > > > >
> > > > > > > > > If we do go ahead and enhance Kconfig, then we can combin=
e the two
> > > > > > > > > symbols, which is something.
> > > > > > > >
> > > > > > > > Or, we go the direction I suggested instead. Where we never=
 duplicate
> > > > > > > > symbols, because we never need to anymore.
> > > > > > > >
> > > > > > > > Or, we step back because believe you're missing the bigger =
problems.
> > > > > > >
> > > > > > > At this point I'm not sure where to go. You are determined to=
 split
> > > > > > > the defconfig files and have grace concerns about my schema. =
Vice
> > > > > > > versa for me.
> > > > > > >
> > > > > > > But my scheme takes us forward without needing to split the
> > > > > > > defconfigs. It does offer some benefits IMO. Once we split the
> > > > > > > defconfigs we can never put them back together.
> > > > > >
> > > > > > My continued strongest preference is to do the minimal effort t=
o better
> > > > > > document what we are doing today and add the missing tooling so=
 we don't
> > > > > > keep getting wrong macros in the code.
> > > > >
> > > > > I did actually do the tooling in qconfig - give it a try and see =
what
> > > > > you think. For documentation, we can discuss that as part of myt
> > > > > series.
> > > >
> > > > The missing tooling is things like:
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20250226153346.273=
6160-1-trini@konsulko.com/
> > >
> > > Well that's good to have anyway.
> > >
> > > >
> > > > I'm not sure what qconfig features you're talking about.
> > >
> > > It is qconfig --scan-source which prints a lot of warnings.
> >
> > I'm not sure I saw what that was for when it went in. But I'm not sure
> > how useful that is either. The first section shows some dead code to
> > remove, which is good. It complains about cases of CONFIG_$(PHASE_)FOO
> > being used as future-proofing which is not good. And it caught none of
> > the errors like:
> > https://patchwork.ozlabs.org/project/uboot/patch/20250226203123.3831960=
-1-trini@konsulko.com/
> >
> > And I'm not sure "CONFIG options used as Proper but without a non-xPL_
> > variant" is a valid variant at all. I'm sure you've found it useful but
> > I'm not sure it's something I would suggest people run normally.
>=20
> The tool identifies problems which cause build errors (or changes in
> the effective value of Kconfig options).

Along with lots of false positives. I'm not saying there's nothing of
use here, but I am saying that for example "make this produce no output"
is neither a feasible nor good goal.

> > > > > > If you're hellbent on doing this
> > > > > > and do it against master and not your personal tree, I'm expect=
ing you
> > > > > > to be available to help clarify problems for developers if they=
 report
> > > > > > them.
> > > > >
> > > > > That's fine. I do my development on my own tree, but once I actua=
lly
> > > > > do the series and it is reviewed, I can do a version against -nex=
t. As
> > > > > you know, there are a lot of moving parts, so I would want it to =
go in
> > > > > quickly to avoid a lot of rework.
> > > >
> > > > Just don't post things that aren't against next, when you have some=
thing
> > > > as that makes review impossible for the rest of us.
> > >
> > > I had thought we agreed that to minimise differences you would review
> > > patches that I sent from my tree?
> >
> > I said that back when I thought you would default to posting against
> > the relevant upstream branch and not developer further against your own
> > tree.
>=20
> That's not what I intended you to think. We should look to find some
> way to do this via pull requests.

Well, you used to put things in u-boot-dm, that had been reviewed or at
least not rejected by others, and send me a pull request. Along the way
you stopped doing that. You could start again, and that would be
helpful. If you find the "u-boot-dm" part too restrictive adding
contributor/sjg/ namespace is easy (and someone else had suggested this
in another thread, even).

--=20
Tom

--Qqmva4otxBHmPuYF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfHKWcACgkQFHw5/5Y0
tywR6Qv8CeZkgOeV620JXEnj+E4ZVG5GNx3I17WNw5IKzGd/287+4sSzmFbdN0G5
dNWI+eu+wmLu70rI8Bn3+fn8nBFUWQZDF7FWlzjblliV4pKN2MG/Y/wQF1turXPK
dEOtL5UsmTwFPuixtoJENay1ZL7NudR/cc/gqyGEarFhK6cwX/jYWYFqiCOf9jeb
fh0RfAhtXx9GvmRF3/iQ+daNqv31c4fCrncRAB+3nbWF62sYxzvHXLo+ac9GBWcf
kNDAZgF10tMxzzX6126sOGK7SXifjGbKR5UuCecCfsXaedKxi1eOrpt96R1Vx+mG
eSg9bXW7asDoM+r386QUyqso7CbXulcv9AwYKKGF4Nme0h9yxKmLMJrGB+HN9W++
PX8eyGX+u9HAE0BQmsPz6ex+QggEn2gnEOdp+rFWQmTfJ5oBW8xzfIvvCJhCXRZn
Y8ZaqBPh78e6IToOeO80SGABx81gabzmA5GjC4FFlBUSZwpNXa+SputNMNG9k7ol
YrR07330
=B3kq
-----END PGP SIGNATURE-----

--Qqmva4otxBHmPuYF--
