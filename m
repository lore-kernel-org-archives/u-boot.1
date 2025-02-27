Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C45EC197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 20:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61D648144A;
	Thu, 27 Feb 2025 21:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BRDaKvaG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F030081578; Thu, 27 Feb 2025 21:30:26 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8861F81426
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 21:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2feb91a2492so634290a91.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 12:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740688222; x=1741293022; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/OFNDA3N+rwweNMySXw3FHrkOj0eBI+6KzuKLjvvGF0=;
 b=BRDaKvaG6KINhCU6DDMpMzFQiMmJkE6VWmUlFak1lHAE5qdFn7NPAgs2v5jIjt+VVZ
 AK6dxdclTRHduVoDOEcAePpjcrJDqC1Tng37PabWKMdA2OwmX4Haijw/Yu4ouhQD7HSa
 RXCyWDGxu/OLrmbg+wPmCX7hli3DkJA6XVibc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740688222; x=1741293022;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/OFNDA3N+rwweNMySXw3FHrkOj0eBI+6KzuKLjvvGF0=;
 b=lXH+f+vrz8ny2074N6F5IT6s3vs4mUtDHBRo6Gl5x+7oemNAbryZYAEv95YVMziXFQ
 qgpj7UHsaaYirumg47GW8G2OhmwKBKrFHnVEfbMGhPgRUFG0lX+VvwyDDe62FTeE8mvy
 zTku4kRGUD1vzNkuK5bPkLVsZHVsRHixq6niRAllU0RARnw+d8q9D5Xj+1e1Oa01ifEY
 XhKRxgxdIH61qOUdXBj1uVv0UFOmvipUVnsFuMVgSjLVe8tXJcq2IsAV4eQKYKDwYn+B
 xoj+sUDdKlrKTULmxLez7BiXaMGf10OQ+UdLAvPiolQeuhdLbTGeflcw7JI81PPV50Ue
 8iZg==
X-Gm-Message-State: AOJu0YzcI5ZaF2Z6fHr4d7FCtEBokwX1S7Hl73zwKLjH+HiOczc1kMqv
 LNV6K9Mr7E73odDFTUdEr9aDql1iF51MYIANjyL8slh4wvJVEuFBJbNhEsWjBAU=
X-Gm-Gg: ASbGncv4YVlonHnT1aTLPzEc/7BoLdvEYGFcLyn6SEFzr/tx0iLYg1L6WocWovRp3BT
 ZP+FD03+8IBXGygPK9uD3JtKqlBSbVOJMJNpkgnoRmWCJzNiPwI/zVn09I4rECJ797kWWlyBglN
 K5n5yMD4shDRHllq0kFO60dJPte7InFH4tvyJ+IF7O+hEQP9eYAgB3DFoM1cz4zC+f2MHViW1bK
 QUZYGASY5mOdWris/q/Dk+MRU/0PxMefI/l2hTFOBadp+GcHwQe9ypBbPSNI/0a7T6V3Wcjb2PL
 VvCK9ULsJW2pCPSqxq7ed+Yl
X-Google-Smtp-Source: AGHT+IHRrtlzHA/FdpKjWHeD0Pv4P+ivm46AbRkJviycvStt7XsJkTU6qP2H6BhQch4+fzZ3+fOd3g==
X-Received: by 2002:a17:90b:4ac6:b0:2f6:be57:49cd with SMTP id
 98e67ed59e1d1-2febabdcc28mr1059727a91.25.1740688221701; 
 Thu, 27 Feb 2025 12:30:21 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe8284f083sm4241189a91.43.2025.02.27.12.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 12:30:20 -0800 (PST)
Date: Thu, 27 Feb 2025 14:30:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250227203017.GK2640854@bill-the-cat>
References: <20250224160004.GF1233568@bill-the-cat>
 <CAFLszTjr7DDNdUDDsVyM_+KeFNA9pVu9CYTv12PqGPEad83xkw@mail.gmail.com>
 <20250225140242.GM1233568@bill-the-cat>
 <CAFLszTi6tNhFgXgYdYZpp=1-7P=O8wkAgug5xP2syn=mU==PCg@mail.gmail.com>
 <20250225215100.GC2640854@bill-the-cat>
 <CAFLszTiP3=FyUm36aLPfdwObQT0WPS_+Y486VRmV41cxEkA93w@mail.gmail.com>
 <20250226145255.GJ2640854@bill-the-cat>
 <CAFLszTgMdR6fSDxUTKO3Mru3YU6=HK52tU2+rgri3J_TXWiTUg@mail.gmail.com>
 <20250227171753.GG2640854@bill-the-cat>
 <CAFLszTg1A0HiaqVPxY3utpztOw6QFNQGZwPgtN9tZBN+3E9TiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lxrnaCzYd6xwI6ar"
Content-Disposition: inline
In-Reply-To: <CAFLszTg1A0HiaqVPxY3utpztOw6QFNQGZwPgtN9tZBN+3E9TiQ@mail.gmail.com>
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


--lxrnaCzYd6xwI6ar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 12:32:42PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 27 Feb 2025 at 10:17, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 27, 2025 at 09:24:45AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 26 Feb 2025 at 07:53, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Feb 25, 2025 at 07:51:07PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 25 Feb 2025 at 14:51, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 25, 2025 at 02:33:17PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 25 Feb 2025 at 07:02, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Mon, Feb 24, 2025 at 04:38:50PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 24 Feb 2025 at 09:00, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Feb 21, 2025 at 07:07:06PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 21 Feb 2025 at 18:06, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, Feb 21, 2025 at 05:24:35PM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 21 Feb 2025 at 17:03, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 04:35:16PM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Fri, 21 Feb 2025 at 16:20, Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 03:54:52PM -0700, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Hi  Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Fri, 21 Feb 2025 at 12:26, Tom Rini <t=
rini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 08:19:40AM -060=
0, Tom Rini wrote:
> > > > > > > > > > > > > > > > > > > On Thu, Feb 20, 2025 at 06:30:18PM -0=
700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Thu, 20 Feb 2025 at 13:40, Tom R=
ini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Thu, Feb 20, 2025 at 11:13:34A=
M -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > [snip]
> > > > > > > > > > > > > > > > > > > > > I will look at "splg4" once it's =
somewhere on source.denx.de and I can
> > > > > > > > > > > > > > > > > > > > > look at it, and refrain from othe=
rwise assuming how it solves the
> > > > > > > > > > > > > > > > > > > > > problems I had seen previously.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > I pushed an updated version to dm/s=
plg-working but it is not very
> > > > > > > > > > > > > > > > > > > > updated. Still needs more work.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Thanks.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > So, after doing the remaining CONFIG_TE=
XT_BASE -> CONFIG_PPL_TEXT_BASE
> > > > > > > > > > > > > > > > > > changes, here's another example of the =
problem with your approach. What
> > > > > > > > > > > > > > > > > > stops xilinx_zynqmp_kria from building =
in splg-working is that
> > > > > > > > > > > > > > > > > > BUTTON was missing from scripts/conf_no=
spl. Annoyingly, a mrproper (or
> > > > > > > > > > > > > > > > > > since I always use O=3D, rm -rf) is nee=
ded for changes there to be picked
> > > > > > > > > > > > > > > > > > up, but that's maybe just a missing Mak=
efile dependency line. But that
> > > > > > > > > > > > > > > > > > just makes it easier to see the next pr=
oblem, which I don't see the
> > > > > > > > > > > > > > > > > > answer to. For PPL, we can build driver=
s/spi/zynqmp_gqspi.o just fine.
> > > > > > > > > > > > > > > > > > For SPL however:
> > > > > > > > > > > > > > > > > >   CC      spl/drivers/spi/zynqmp_gqspi.o
> > > > > > > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/=
spi/zynqmp_gqspi.c: In function 'zynqmp_qspi_of_to_plat':
> > > > > > > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/=
spi/zynqmp_gqspi.c:203:22: warning: cast to pointer from integer of differe=
nt size [-Wint-to-pointer-cast]
> > > > > > > > > > > > > > > > > >   203 |         plat->regs =3D (struct =
zynqmp_qspi_regs *)(dev_read_addr(bus) +
> > > > > > > > > > > > > > > > > >       |                      ^
> > > > > > > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/=
spi/zynqmp_gqspi.c:205:26: warning: cast to pointer from integer of differe=
nt size [-Wint-to-pointer-cast]
> > > > > > > > > > > > > > > > > >   205 |         plat->dma_regs =3D (str=
uct zynqmp_qspi_dma_regs *)
> > > > > > > > > > > > > > > > > >       |                          ^
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > And I don't see, really, what's even ge=
tting us down this error path.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > It's the FDT_64BIT in conf_nospl - that s=
ymbol needs to be the same
> > > > > > > > > > > > > > > > > across all phases.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > I pushed a new tree which builds without =
the warning. Note that
> > > > > > > > > > > > > > > > > SPL_SPI is enabled.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > So, the "what" is FDT_64BIT wasn't correct.=
 I think this is showing that
> > > > > > > > > > > > > > > > scripts/conf_nospl is going to be a problem=
 in and of itself, and likely
> > > > > > > > > > > > > > > > as confusing if not more-so than any of the=
 in-the-end visible changes.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes, perhaps the key point I've been trying t=
o get across is this confusion.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > As you know, at present we have two types of =
options:
> > > > > > > > > > > > > > > a) those for which each phase has its own val=
ue
> > > > > > > > > > > > > > > b) those for which there is a single value sh=
ared across all phases
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Agreed.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The only way today that you can tell them apa=
rt is by looking for uses
> > > > > > > > > > > > > > > of CONFIG_IS_ENABLED() and $(PHASE_) with the=
 option. If you see them,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Partially agreed. Those are strong indicators t=
hat both CONFIG_FOO and
> > > > > > > > > > > > > > CONFIG_SPL_FOO exist, but not always. We have, =
intentionally, both the
> > > > > > > > > > > > > > inverse case (CONFIG_SPL_BAR and CONFIG_TPL_BAR=
 exist, CONFIG_BAR does
> > > > > > > > > > > > > > not) and some future-proofing (CONFIG_SPL_BAZ m=
ay exist in the future,
> > > > > > > > > > > > > > but not yet).
> > > > > > > > > > > > >
> > > > > > > > > > > > > OK
> > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > then the option is a) otherwise it is b). The=
re is no way to tell from
> > > > > > > > > > > > > > > Kconfig.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Kconfig will happily allow "depends on BOGUS_SY=
MBOL" yes, and a linter
> > > > > > > > > > > > > > would be a handy thing to have. But you're ment=
ioning this in another
> > > > > > > > > > > > > > context, why we need some additional knowledge =
somewhere.
> > > > > > > > > > > > >
> > > > > > > > > > > > > What I meant was that we don't have anything in t=
he Kconfig for FOO
> > > > > > > > > > > > > that says this is a global option or an xPL-speci=
fic one. We have to
> > > > > > > > > > > > > hunt for SPL_FOO, etc.
> > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Also, some parts of the code may use CONFIG_I=
S_ENABLED() for
> > > > > > > > > > > > > > > an option, some may use IS_ENABLED() for that=
 same option. Some may
> > > > > > > > > > > > > > > use $(PHASE_) and some may not. It's a bit of=
 a mess.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I'm sure you can find some examples where we ha=
ve CONFIG_IS_ENABLED(FOO)
> > > > > > > > > > > > > > and IS_ENABLED(CONFIG_FOO) and it's not intenti=
onal, but that's not a
> > > > > > > > > > > > > > big deal, and should be fixed.
> > > > > > > > > > > > >
> > > > > > > > > > > > > But this is largely the point of my series. It's =
the reason why
> > > > > > > > > > > > > qconfig is able to locate these cases and warn ab=
out them. It is a big
> > > > > > > > > > > > > deal, IMO, or at least big enough for me to attem=
pt this.
> > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I'm only going to rant slightly that checkpatch=
=2Epl telling people to use
> > > > > > > > > > > > > > these macros has made the situation worse, not =
better, out of an
> > > > > > > > > > > > > > ingrained need to silence checkpatch.pl.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > And what you're missing is that sometimes we in=
tentionally don't want
> > > > > > > > > > > > > > $(PHASE_), or would need to rewrite the Makefil=
e to make use of it.
> > > > > > > > > > > > > > fs/Makefile is an example of this.
> > > > > > > > > > > > >
> > > > > > > > > > > > > The next step from my side would be to get rid of=
 the 'ifdef
> > > > > > > > > > > > > CONFIG_XPL_BUILD' in the Makefiles. It's confusin=
g and annoying.
> > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Stepping back a bit, perhaps the goal of my s=
eries is to identify
> > > > > > > > > > > > > > > options in b) so we can deal with them in a b=
etter way. They are all
> > > > > > > > > > > > > > > listed in conf_nospl, in preparation for some=
 future action.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > There are two big problems here. The first of w=
hich is that conf_nospl,
> > > > > > > > > > > > > > as a concept, is going to be incomplete. Do you=
 list every CMD in there?
> > > > > > > > > > > > > > Why? They'll never be in a non-PPL phase. It wi=
ll be its own nightmare
> > > > > > > > > > > > > > to keep correct, once it is bug-compatible with=
 what we have today.
> > > > > > > > > > > > >
> > > > > > > > > > > > > This is actually the *nice* thing about conf_nosp=
l. We should reduce
> > > > > > > > > > > > > it to empty, just like we did with the Kconfig wh=
itelist.
> > > > > > > > > > > > >
> > > > > > > > > > > > > We have this rule:
> > > > > > > > > > > > >
> > > > > > > > > > > > > libs-$(CONFIG_CMDLINE) +=3D cmd/
> > > > > > > > > > > > >
> > > > > > > > > > > > > which is enough for most things. The only issue i=
s that sometimes,
> > > > > > > > > > > > > e.g. with CONFIG_CMD_DHCP it doesn't mean the com=
mand at all.
> > > > > > > > > > > > >
> > > > > > > > > > > > > So I don't agree at all that my series is a 'big =
problem'. It is a
> > > > > > > > > > > > > solution to the current confusion and it shows up=
 what is broken and
> > > > > > > > > > > > > needs to be fixed.
> > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The second big problem is that it doesn't make =
it any easier to solve
> > > > > > > > > > > > > > what I keep calling the DWC3 problem. It's a va=
lid use case that two
> > > > > > > > > > > > > > developers have hit independently of wanting to=
 enable USB gadget
> > > > > > > > > > > > > > support (and the HW uses DWC3) in SPL and not P=
PL. Not only are you not
> > > > > > > > > > > > > > solving this problem, it gets worse to solve. T=
oday it's "OK, I need to
> > > > > > > > > > > > > > find where to move obj-$(CONFIG_FOO) to be more=
 visible and
> > > > > > > > > > > > > > obj-$(CONFIG_$(PHASE_)FOO". Tomorrow it's "Why =
isn't obj-$(CONFIG_FOO)
> > > > > > > > > > > > > > working here but not there?".
> > > > > > > > > > > > >
> > > > > > > > > > > > > Is that because some Makefile higher in the hiera=
rchy is not building
> > > > > > > > > > > > > that subdir? I don't know what this is about.
> > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > To me, at absolute best case here, we're making=
 a lot of changes and
> > > > > > > > > > > > > > spending a lot of time to not really address th=
e underlying problems,
> > > > > > > > > > > > > > just making some questionable value visibility =
changes. We could reduce
> > > > > > > > > > > > > > ourselves to one macro by saying only ever use =
CONFIG_IS_ENABLED(FOO)
> > > > > > > > > > > > > > and IS_ENABLED(CONFIG_FOO) goes back to an ifde=
f for the case where it
> > > > > > > > > > > > > > must only be tested on CONFIG_FOO.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Or we could finish and apply my series, which doe=
s this.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > I'm 80% sure we could simplify all of
> > > > > > > > > > > > > > $(PHASE_)/$(XPL_)/$(SPL_) down to just $(PHASE_=
) and that eliminates the
> > > > > > > > > > > > > > which to use of those question.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Again, let's apply my series, which actually gets=
 rid of PHASE_, SPL_
> > > > > > > > > > > > > and XPL_ altogether.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > And update / expand upon the existing
> > > > > > > > > > > > > > documentation we have as it's not clear enough =
for everyone. Then we can
> > > > > > > > > > > > > > think, again, about how to solve the problems t=
hat are introduced by
> > > > > > > > > > > > > > building our entire source tree N times from a =
single configuration
> > > > > > > > > > > > > > file. Or if we need to do something radical the=
re.
> > > > > > > > > > > > >
> > > > > > > > > > > > > At this point I'm getting the feeling that you im=
agine my series is
> > > > > > > > > > > > > some grand unified plan for Kconfig. It really is=
n't and this thread
> > > > > > > > > > > > > is reminding me of why I originally wrote it. Bea=
r in mind it was over
> > > > > > > > > > > > > two years ago and I have mostly forgotten all the=
 issues. It is a
> > > > > > > > > > > > > clean-up series. It isn't the second coming but i=
t isn't the
> > > > > > > > > > > > > antichrist either.
> > > > > > > > > > > >
> > > > > > > > > > > > I worry you're going to spend another month of effo=
rt to get this to 1:1
> > > > > > > > > > > > compatibility (modulo fixing bugs) with what we hav=
e today and get
> > > > > > > > > > > > disappointed once it rolls out to -next. But I gues=
s I've already spent
> > > > > > > > > > > > too much time trying to convince you this is a bad =
idea and that your
> > > > > > > > > > > > cure is worse than the disease.
> > > > > > > > > > >
> > > > > > > > > > > To me the core issue is whether to completely split t=
he defconfig
> > > > > > > > > > > files. I am quite worried about that. You are quite w=
orried about the
> > > > > > > > > > > confusion my series will cause.
> > > > > > > > > > >
> > > > > > > > > > > I think it is reasonable, if we go with my series, th=
at I drive
> > > > > > > > > > > conf_nospl down to zero lines (and remove the feature=
) before going
> > > > > > > > > > > any further. Would that make you more comfortable? It=
 would be a fair
> > > > > > > > > > > bit of work, but could be done over a few releases.
> > > > > > > > > >
> > > > > > > > > > Here is my core concern. Can macros be tricky? Yes. Do =
we need a
> > > > > > > > > > checkpatch.pl test for 'IS_ENABLED(FOO)' ? Yes. But the=
 real problem is
> > > > > > > > > > bugs like:
> > > > > > > > > > - Take pinebook-pro-rk3399_defconfig
> > > > > > > > > > - Enable all 3 of: CONFIG_SPL_USB_DWC3_GENERIC CONFIG_S=
PL_USB_GADGET
> > > > > > > > > >   CONFIG_SPL_USB_SDP_SUPPORT
> > > > > > > > > >
> > > > > > > > > > Your proposal neither fixes that bug nor makes it easie=
r to understand
> > > > > > > > > > why that bug happens. And this is the category of build=
 problems that we
> > > > > > > > > > get that aren't "you missed using the right macro".
> > > > > > > > >
> > > > > > > > > Honestly, what on earth does this have to do with my seri=
es?
> > > > > > > >
> > > > > > > > It's that your series doesn't address the real problems we =
keep having.
> > > > > > > >
> > > > > > > > > The problem happens before and after my series, from what=
 I can tell.
> > > > > > > >
> > > > > > > > Yes, I've said that numerous times.
> > > > > > > >
> > > > > > > > > If you want these sorts of combinations to be tested, per=
haps add a
> > > > > > > > > board that enables them, or even rethink your opposition =
to my
> > > > > > > > > buildman proposal?[4]
> > > > > > > >
> > > > > > > > This isn't relevant to the point I've raised several times =
now. The
> > > > > > > > failure mode above was reported by two different developers=
, neither of
> > > > > > > > whom saw how to correctly solve the problem.
> > > > > > >
> > > > > > > That surprises me a little, as the problem seems pretty funda=
mental.
> > > > > > > If you don't enable USB_GADGET, then symbols which depend on =
it don't
> > > > > > > exist.
> > > > > >
> > > > > > But they don't want USB_GADGET in PPL. They only want it in SPL.
> > > > >
> > > > > That seems to be splitting hairs, but OK. So why not make
> > > > > USB_GADGET_MANUFACTURER depend on USB_GADGET || SPL_USB_GADGET ?
> > > >
> > > > Yes, the solution today involves reworking drivers/usb/gadget/Kconf=
ig so
> > > > that USB_GADGET_MANUFACTURER, USB_GADGET_VENDOR_NUM,
> > > > USB_GADGET_PRODUCT_NUM, USB_GADGET_VBUS_DRAW and that might be it, =
are
> > > > exposed to USB_GADGET || SPL_USB_GADGET and possibly down the line
> > > > VPL_USB_GADGET.
> > >
> > > OK
> > >
> > > >
> > > > > It wouldn't make sense to add SPL_USB_GADGET_MANUFACTURER as sure=
ly it
> > > > > would be the same value? This is once good thing about what we ha=
ve:
> > > > > we can share values between phases without typing them in separat=
ely.
> > > >
> > > > Most of these should be, there may or may not be the questionable c=
ase
> > > > where one of the ID changes so the host knows what stage things are=
 at.
> > > > But that's just an aside.
> > > >
> > > > My point is that drivers/usb/gadget/Kconfig is yet another case whe=
re we
> > > > need to make it much more complicated so that it works for all the =
use
> > > > cases. And that it's a more common and harder for developers to fix
> > > > problem than "Do I use $(SPL_TPL_) I mean $(PHASE_) or $(XPL_) in t=
he
> > > > Makefile?"
> > >
> > > Yes, I understand that, but this is a tradeoff between that complexity
> > > and the one we would introduce by splitting the defconfigs. Given all
> > > the Kconfig churn it would require just to get things to work, it
> > > isn't a clear win, to say the least.
> >
> > Since we would be removing stuff from Kconfig with the larger idea I
> > proposed, I'm not sure what you mean. We wouldn't have this problem at
> > all with the larger idea.
>=20
> But we have other problems, mainly that we cannot easily use an option
> from one phase in another, so need to duplicate all such options, then
> add tooling to try to keep them in sync, except when we don't want
> them in sync, etc. Are you sure you have thought this through all the
> way?

Yes, I have. Because rarely are there cases where we *need* to share a
value from multiple phases *and* we can't have the default be correct.

> > > > > > > > And again, if you tried to solve this problem on your serie=
s you might
> > > > > > > > see how what you're proposing will make things worse, not b=
etter.
> > > > > > >
> > > > > > > At least with my scheme you can do something like this:
> > > > > > >
> > > > > > > config SPL_USB_GADGET
> > > > > > >    bool "USB Gadget Support in SPL"
> > > > > > >    depends on USB_GADGET
> > > > > >
> > > > > > That symbol already exists. The problems are around all of the =
gadget
> > > > > > symbols that don't exist.
> > > > >
> > > > > OK. But we have to move in steps. We can't do everything at once.
> > > >
> > > > Yes, which is why we have so many of these duplicative symbols
> > > > (USB_GADGET, SPL_USB_GADGET) and keep needing to add more.
> > >
> > > Yes, I don't like it either. I believe that if I had been able to land
> > > my solution last time, we would be having different discussions by
> > > now, e.g. how to tidy up the Kconfig without changing the build
> > > system.
> >
> > I strongly doubt it.
>=20
> I know you do, but I could be right about this.

You could. But you could also be very wrong. And the struggle I've had
with showing you problems other developers have has not left me feeling
great. But I've still said I'll take this but need you to commit to
following up with bug reports.

> > > > > > > I normally make the SPL symbols depend on PPL, since it norma=
lly
> > > > > > > doesn't make a lot of sense to have the feature in SPL unless=
 it is in
> > > > > > > PPL. Is this an exception to that rule?
> > > > > >
> > > > > > This half of the problem (you're still missing the other half o=
f the
> > > > > > problem, the DWC3 code being built in TPL now and throwing
> > > > > > warnings-turned-error with -Werror and then discarded at link t=
ime) is
> > > > > > one of many examples where we keep having to duplicate symbols =
in
> > > > > > Kconfig.
> > > > >
> > > > > >
> > > > > > > If we do go ahead and enhance Kconfig, then we can combine th=
e two
> > > > > > > symbols, which is something.
> > > > > >
> > > > > > Or, we go the direction I suggested instead. Where we never dup=
licate
> > > > > > symbols, because we never need to anymore.
> > > > > >
> > > > > > Or, we step back because believe you're missing the bigger prob=
lems.
> > > > >
> > > > > At this point I'm not sure where to go. You are determined to spl=
it
> > > > > the defconfig files and have grace concerns about my schema. Vice
> > > > > versa for me.
> > > > >
> > > > > But my scheme takes us forward without needing to split the
> > > > > defconfigs. It does offer some benefits IMO. Once we split the
> > > > > defconfigs we can never put them back together.
> > > >
> > > > My continued strongest preference is to do the minimal effort to be=
tter
> > > > document what we are doing today and add the missing tooling so we =
don't
> > > > keep getting wrong macros in the code.
> > >
> > > I did actually do the tooling in qconfig - give it a try and see what
> > > you think. For documentation, we can discuss that as part of myt
> > > series.
> >
> > The missing tooling is things like:
> > https://patchwork.ozlabs.org/project/uboot/patch/20250226153346.2736160=
-1-trini@konsulko.com/
>=20
> Well that's good to have anyway.
>=20
> >
> > I'm not sure what qconfig features you're talking about.
>=20
> It is qconfig --scan-source which prints a lot of warnings.

I'm not sure I saw what that was for when it went in. But I'm not sure
how useful that is either. The first section shows some dead code to
remove, which is good. It complains about cases of CONFIG_$(PHASE_)FOO
being used as future-proofing which is not good. And it caught none of
the errors like:
https://patchwork.ozlabs.org/project/uboot/patch/20250226203123.3831960-1-t=
rini@konsulko.com/

And I'm not sure "CONFIG options used as Proper but without a non-xPL_
variant" is a valid variant at all. I'm sure you've found it useful but
I'm not sure it's something I would suggest people run normally.

> > > > If you're hellbent on doing this
> > > > and do it against master and not your personal tree, I'm expecting =
you
> > > > to be available to help clarify problems for developers if they rep=
ort
> > > > them.
> > >
> > > That's fine. I do my development on my own tree, but once I actually
> > > do the series and it is reviewed, I can do a version against -next. As
> > > you know, there are a lot of moving parts, so I would want it to go in
> > > quickly to avoid a lot of rework.
> >
> > Just don't post things that aren't against next, when you have something
> > as that makes review impossible for the rest of us.
>=20
> I had thought we agreed that to minimise differences you would review
> patches that I sent from my tree?

I said that back when I thought you would default to posting against
the relevant upstream branch and not developer further against your own
tree.

> Anyway I'm going to do what you suggest and see how it goes.

Thanks.

--=20
Tom

--lxrnaCzYd6xwI6ar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfAy04ACgkQFHw5/5Y0
tyz76gv9H+6VFTvXUTsCxeeg0QbdkSG6bogQVdUOtEomH1QofbtJ+tVcCll/fWuW
0b4I2/LHx7cZF1Q31pM3g1KWEwetygIZ4chTUv8eBk5lT9ENK+UypGUxQgnZ0ilP
AxkBINmOxpBJ1xwkVq7E/bdcSaGPr5gGxKTRm0DCE/Lr4PCUDDoRQzKgA+hCJ6Qi
kyJoKyC790CmeSB5kqwgFdkTRb/CKXTW3InikyBSYuSyNjMIG/OmH76eIs90smSr
ErvwPPisY4gGHq2re2UMjDOTNzV7Af/bNnTIEZRe/M98bpMUJTBEpWUusoin5sHh
IZQPaRubzZijkvcq8YxdMEFsaEesoChf26L0kw9wQVJpSjCfwD11qHDLrO0cDsrn
QQnM/QK/CSKYbeFDueIYb6UIE5OExBe/8UfyYkRHMViTlsnt5Fw72Q/17gecLNmE
aeVLn/978dW0Libtznb6k8tZCUqyubeaUmHIOKKjY1d97brfH8pEITOZZ1kj65HP
7cqPIpFE
=uaD+
-----END PGP SIGNATURE-----

--lxrnaCzYd6xwI6ar--
