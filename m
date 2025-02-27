Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EF2C282C1
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 17:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBD1B811E0;
	Thu, 27 Feb 2025 18:18:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kzCJpCv5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0701811E0; Thu, 27 Feb 2025 18:18:02 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 798708121A
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 18:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22328dca22fso20135905ad.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 09:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740676678; x=1741281478; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R8CHgWMtwWJe2x5NMcqmB4GWmLE+OneVwSjxqVPGFgg=;
 b=kzCJpCv5fvIAGupLNevLRaMNZLhE7857Bz0i1kcThySTkxhDl25AttWWaX08VEBny+
 8u2M4gFRNhhWsL+ZTWEelB6xJRdrNHed0EkHcLCeidfRqjrkfiOZULF7hckkxyST7Rrf
 QUl8CHNcvWrft5q/dD2lp2ljTNlIu5ed4Bhnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740676678; x=1741281478;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8CHgWMtwWJe2x5NMcqmB4GWmLE+OneVwSjxqVPGFgg=;
 b=JL3R1opmXN/gzZcCSq18OXFfweAubLypnpQ5dnxRvH3bjNde267St/r5Si01In0QBG
 g43+1qlhiBB8YvPnishyjv+DyuZ9+pSuASe0oiMOJZnSQQJbhKVf+Igh4LZ7KNayWEc9
 lLQP4B3rilxitBCw708XTst7JJbYsGlB3hFOhRWeFSzg31dASNgaKINCapokQ6Y31RUO
 40UaBHQdIgUG0y0z89tLS2Ew7qp2JzaqF1gbtUbNvKgGuFw1nTRrHqK2QKVn+qFJ4UqB
 tHgBKgqzTypDuXOegoYqLHfzivPDsvxqBgd/vnIn3mXFsGvbZEGXfsUXHQ4yqmji0xmV
 joOQ==
X-Gm-Message-State: AOJu0YzQQ++HO+olfeG7aei2AhnEm+Oz4r+BWUzMvpBJfflTESfW+kpJ
 Edt/IOQ+Nw1TDm9YmT4qk6ltvk+KgdasuYgOhcOG34VwXjnNk3szHC8MjHfoOA8=
X-Gm-Gg: ASbGncsRheDXaaOGJUcdRPcfPa/j+t2cEpI4vGxePvt8spn0AtPbv2dBxptEVL862Yq
 zIDTYbg6A0LEiEMr9cLLTz1suz4DnEOVUAXputx+KKICqi/ZnRVIe2eBq6HccGA4ckxCxC6uOIu
 9N2RZX//yrQjt8F4nypIOOCTG91YqujenOdXCWSI8NF1X+edCdLPc7bhJuSP+qaH0nITYSgNHA8
 OPf6AvCfr2YGtePAu6uWFjZ+YxPYrq7ffQSIvMcMK0wOJNpny8NBPn/3FzXDXPSXdSdtondUaP7
 yWjpm955hhmyrl/epftjn0vC
X-Google-Smtp-Source: AGHT+IGq8Qb7VW55DudNyJcX6sIsZ9dNXHmTSouL56KVwhCywjOYNmZwP17S6H6ZYPO4ZlEmwnkGxw==
X-Received: by 2002:a17:903:191:b0:21f:6a36:7bf3 with SMTP id
 d9443c01a7336-22307b4bd13mr197623285ad.12.1740676676829; 
 Thu, 27 Feb 2025 09:17:56 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2235050f210sm17469745ad.205.2025.02.27.09.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 09:17:56 -0800 (PST)
Date: Thu, 27 Feb 2025 11:17:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250227171753.GG2640854@bill-the-cat>
References: <20250222010654.GA1233568@bill-the-cat>
 <CAFLszTgS1KtMtuW9vo=F-H5q_km0BLsA5BVU_cZDSV9dgOo_mA@mail.gmail.com>
 <20250224160004.GF1233568@bill-the-cat>
 <CAFLszTjr7DDNdUDDsVyM_+KeFNA9pVu9CYTv12PqGPEad83xkw@mail.gmail.com>
 <20250225140242.GM1233568@bill-the-cat>
 <CAFLszTi6tNhFgXgYdYZpp=1-7P=O8wkAgug5xP2syn=mU==PCg@mail.gmail.com>
 <20250225215100.GC2640854@bill-the-cat>
 <CAFLszTiP3=FyUm36aLPfdwObQT0WPS_+Y486VRmV41cxEkA93w@mail.gmail.com>
 <20250226145255.GJ2640854@bill-the-cat>
 <CAFLszTgMdR6fSDxUTKO3Mru3YU6=HK52tU2+rgri3J_TXWiTUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i+HUeVLepr2VAq7N"
Content-Disposition: inline
In-Reply-To: <CAFLszTgMdR6fSDxUTKO3Mru3YU6=HK52tU2+rgri3J_TXWiTUg@mail.gmail.com>
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


--i+HUeVLepr2VAq7N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 09:24:45AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 26 Feb 2025 at 07:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 25, 2025 at 07:51:07PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 25 Feb 2025 at 14:51, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Feb 25, 2025 at 02:33:17PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 25 Feb 2025 at 07:02, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 24, 2025 at 04:38:50PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 24 Feb 2025 at 09:00, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, Feb 21, 2025 at 07:07:06PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Fri, 21 Feb 2025 at 18:06, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Feb 21, 2025 at 05:24:35PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 21 Feb 2025 at 17:03, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, Feb 21, 2025 at 04:35:16PM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 21 Feb 2025 at 16:20, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 03:54:52PM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi  Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Fri, 21 Feb 2025 at 12:26, Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 08:19:40AM -0600, T=
om Rini wrote:
> > > > > > > > > > > > > > > > > On Thu, Feb 20, 2025 at 06:30:18PM -0700,=
 Simon Glass wrote:
> > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Thu, 20 Feb 2025 at 13:40, Tom Rini =
<trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Thu, Feb 20, 2025 at 11:13:34AM -0=
700, Simon Glass wrote:
> > > > > > > > > > > > > > > > [snip]
> > > > > > > > > > > > > > > > > > > I will look at "splg4" once it's some=
where on source.denx.de and I can
> > > > > > > > > > > > > > > > > > > look at it, and refrain from otherwis=
e assuming how it solves the
> > > > > > > > > > > > > > > > > > > problems I had seen previously.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I pushed an updated version to dm/splg-=
working but it is not very
> > > > > > > > > > > > > > > > > > updated. Still needs more work.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Thanks.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > So, after doing the remaining CONFIG_TEXT_B=
ASE -> CONFIG_PPL_TEXT_BASE
> > > > > > > > > > > > > > > > changes, here's another example of the prob=
lem with your approach. What
> > > > > > > > > > > > > > > > stops xilinx_zynqmp_kria from building in s=
plg-working is that
> > > > > > > > > > > > > > > > BUTTON was missing from scripts/conf_nospl.=
 Annoyingly, a mrproper (or
> > > > > > > > > > > > > > > > since I always use O=3D, rm -rf) is needed =
for changes there to be picked
> > > > > > > > > > > > > > > > up, but that's maybe just a missing Makefil=
e dependency line. But that
> > > > > > > > > > > > > > > > just makes it easier to see the next proble=
m, which I don't see the
> > > > > > > > > > > > > > > > answer to. For PPL, we can build drivers/sp=
i/zynqmp_gqspi.o just fine.
> > > > > > > > > > > > > > > > For SPL however:
> > > > > > > > > > > > > > > >   CC      spl/drivers/spi/zynqmp_gqspi.o
> > > > > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/=
zynqmp_gqspi.c: In function 'zynqmp_qspi_of_to_plat':
> > > > > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/=
zynqmp_gqspi.c:203:22: warning: cast to pointer from integer of different s=
ize [-Wint-to-pointer-cast]
> > > > > > > > > > > > > > > >   203 |         plat->regs =3D (struct zynq=
mp_qspi_regs *)(dev_read_addr(bus) +
> > > > > > > > > > > > > > > >       |                      ^
> > > > > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/=
zynqmp_gqspi.c:205:26: warning: cast to pointer from integer of different s=
ize [-Wint-to-pointer-cast]
> > > > > > > > > > > > > > > >   205 |         plat->dma_regs =3D (struct =
zynqmp_qspi_dma_regs *)
> > > > > > > > > > > > > > > >       |                          ^
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > And I don't see, really, what's even gettin=
g us down this error path.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > It's the FDT_64BIT in conf_nospl - that symbo=
l needs to be the same
> > > > > > > > > > > > > > > across all phases.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I pushed a new tree which builds without the =
warning. Note that
> > > > > > > > > > > > > > > SPL_SPI is enabled.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > So, the "what" is FDT_64BIT wasn't correct. I t=
hink this is showing that
> > > > > > > > > > > > > > scripts/conf_nospl is going to be a problem in =
and of itself, and likely
> > > > > > > > > > > > > > as confusing if not more-so than any of the in-=
the-end visible changes.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, perhaps the key point I've been trying to ge=
t across is this confusion.
> > > > > > > > > > > > >
> > > > > > > > > > > > > As you know, at present we have two types of opti=
ons:
> > > > > > > > > > > > > a) those for which each phase has its own value
> > > > > > > > > > > > > b) those for which there is a single value shared=
 across all phases
> > > > > > > > > > > >
> > > > > > > > > > > > Agreed.
> > > > > > > > > > > >
> > > > > > > > > > > > > The only way today that you can tell them apart i=
s by looking for uses
> > > > > > > > > > > > > of CONFIG_IS_ENABLED() and $(PHASE_) with the opt=
ion. If you see them,
> > > > > > > > > > > >
> > > > > > > > > > > > Partially agreed. Those are strong indicators that =
both CONFIG_FOO and
> > > > > > > > > > > > CONFIG_SPL_FOO exist, but not always. We have, inte=
ntionally, both the
> > > > > > > > > > > > inverse case (CONFIG_SPL_BAR and CONFIG_TPL_BAR exi=
st, CONFIG_BAR does
> > > > > > > > > > > > not) and some future-proofing (CONFIG_SPL_BAZ may e=
xist in the future,
> > > > > > > > > > > > but not yet).
> > > > > > > > > > >
> > > > > > > > > > > OK
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > > then the option is a) otherwise it is b). There i=
s no way to tell from
> > > > > > > > > > > > > Kconfig.
> > > > > > > > > > > >
> > > > > > > > > > > > Kconfig will happily allow "depends on BOGUS_SYMBOL=
" yes, and a linter
> > > > > > > > > > > > would be a handy thing to have. But you're mentioni=
ng this in another
> > > > > > > > > > > > context, why we need some additional knowledge some=
where.
> > > > > > > > > > >
> > > > > > > > > > > What I meant was that we don't have anything in the K=
config for FOO
> > > > > > > > > > > that says this is a global option or an xPL-specific =
one. We have to
> > > > > > > > > > > hunt for SPL_FOO, etc.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > > Also, some parts of the code may use CONFIG_IS_EN=
ABLED() for
> > > > > > > > > > > > > an option, some may use IS_ENABLED() for that sam=
e option. Some may
> > > > > > > > > > > > > use $(PHASE_) and some may not. It's a bit of a m=
ess.
> > > > > > > > > > > >
> > > > > > > > > > > > I'm sure you can find some examples where we have C=
ONFIG_IS_ENABLED(FOO)
> > > > > > > > > > > > and IS_ENABLED(CONFIG_FOO) and it's not intentional=
, but that's not a
> > > > > > > > > > > > big deal, and should be fixed.
> > > > > > > > > > >
> > > > > > > > > > > But this is largely the point of my series. It's the =
reason why
> > > > > > > > > > > qconfig is able to locate these cases and warn about =
them. It is a big
> > > > > > > > > > > deal, IMO, or at least big enough for me to attempt t=
his.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > I'm only going to rant slightly that checkpatch.pl =
telling people to use
> > > > > > > > > > > > these macros has made the situation worse, not bett=
er, out of an
> > > > > > > > > > > > ingrained need to silence checkpatch.pl.
> > > > > > > > > > > >
> > > > > > > > > > > > And what you're missing is that sometimes we intent=
ionally don't want
> > > > > > > > > > > > $(PHASE_), or would need to rewrite the Makefile to=
 make use of it.
> > > > > > > > > > > > fs/Makefile is an example of this.
> > > > > > > > > > >
> > > > > > > > > > > The next step from my side would be to get rid of the=
 'ifdef
> > > > > > > > > > > CONFIG_XPL_BUILD' in the Makefiles. It's confusing an=
d annoying.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > > Stepping back a bit, perhaps the goal of my serie=
s is to identify
> > > > > > > > > > > > > options in b) so we can deal with them in a bette=
r way. They are all
> > > > > > > > > > > > > listed in conf_nospl, in preparation for some fut=
ure action.
> > > > > > > > > > > >
> > > > > > > > > > > > There are two big problems here. The first of which=
 is that conf_nospl,
> > > > > > > > > > > > as a concept, is going to be incomplete. Do you lis=
t every CMD in there?
> > > > > > > > > > > > Why? They'll never be in a non-PPL phase. It will b=
e its own nightmare
> > > > > > > > > > > > to keep correct, once it is bug-compatible with wha=
t we have today.
> > > > > > > > > > >
> > > > > > > > > > > This is actually the *nice* thing about conf_nospl. W=
e should reduce
> > > > > > > > > > > it to empty, just like we did with the Kconfig whitel=
ist.
> > > > > > > > > > >
> > > > > > > > > > > We have this rule:
> > > > > > > > > > >
> > > > > > > > > > > libs-$(CONFIG_CMDLINE) +=3D cmd/
> > > > > > > > > > >
> > > > > > > > > > > which is enough for most things. The only issue is th=
at sometimes,
> > > > > > > > > > > e.g. with CONFIG_CMD_DHCP it doesn't mean the command=
 at all.
> > > > > > > > > > >
> > > > > > > > > > > So I don't agree at all that my series is a 'big prob=
lem'. It is a
> > > > > > > > > > > solution to the current confusion and it shows up wha=
t is broken and
> > > > > > > > > > > needs to be fixed.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > The second big problem is that it doesn't make it a=
ny easier to solve
> > > > > > > > > > > > what I keep calling the DWC3 problem. It's a valid =
use case that two
> > > > > > > > > > > > developers have hit independently of wanting to ena=
ble USB gadget
> > > > > > > > > > > > support (and the HW uses DWC3) in SPL and not PPL. =
Not only are you not
> > > > > > > > > > > > solving this problem, it gets worse to solve. Today=
 it's "OK, I need to
> > > > > > > > > > > > find where to move obj-$(CONFIG_FOO) to be more vis=
ible and
> > > > > > > > > > > > obj-$(CONFIG_$(PHASE_)FOO". Tomorrow it's "Why isn'=
t obj-$(CONFIG_FOO)
> > > > > > > > > > > > working here but not there?".
> > > > > > > > > > >
> > > > > > > > > > > Is that because some Makefile higher in the hierarchy=
 is not building
> > > > > > > > > > > that subdir? I don't know what this is about.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > To me, at absolute best case here, we're making a l=
ot of changes and
> > > > > > > > > > > > spending a lot of time to not really address the un=
derlying problems,
> > > > > > > > > > > > just making some questionable value visibility chan=
ges. We could reduce
> > > > > > > > > > > > ourselves to one macro by saying only ever use CONF=
IG_IS_ENABLED(FOO)
> > > > > > > > > > > > and IS_ENABLED(CONFIG_FOO) goes back to an ifdef fo=
r the case where it
> > > > > > > > > > > > must only be tested on CONFIG_FOO.
> > > > > > > > > > >
> > > > > > > > > > > Or we could finish and apply my series, which does th=
is.
> > > > > > > > > > >
> > > > > > > > > > > > I'm 80% sure we could simplify all of
> > > > > > > > > > > > $(PHASE_)/$(XPL_)/$(SPL_) down to just $(PHASE_) an=
d that eliminates the
> > > > > > > > > > > > which to use of those question.
> > > > > > > > > > >
> > > > > > > > > > > Again, let's apply my series, which actually gets rid=
 of PHASE_, SPL_
> > > > > > > > > > > and XPL_ altogether.
> > > > > > > > > > >
> > > > > > > > > > > > And update / expand upon the existing
> > > > > > > > > > > > documentation we have as it's not clear enough for =
everyone. Then we can
> > > > > > > > > > > > think, again, about how to solve the problems that =
are introduced by
> > > > > > > > > > > > building our entire source tree N times from a sing=
le configuration
> > > > > > > > > > > > file. Or if we need to do something radical there.
> > > > > > > > > > >
> > > > > > > > > > > At this point I'm getting the feeling that you imagin=
e my series is
> > > > > > > > > > > some grand unified plan for Kconfig. It really isn't =
and this thread
> > > > > > > > > > > is reminding me of why I originally wrote it. Bear in=
 mind it was over
> > > > > > > > > > > two years ago and I have mostly forgotten all the iss=
ues. It is a
> > > > > > > > > > > clean-up series. It isn't the second coming but it is=
n't the
> > > > > > > > > > > antichrist either.
> > > > > > > > > >
> > > > > > > > > > I worry you're going to spend another month of effort t=
o get this to 1:1
> > > > > > > > > > compatibility (modulo fixing bugs) with what we have to=
day and get
> > > > > > > > > > disappointed once it rolls out to -next. But I guess I'=
ve already spent
> > > > > > > > > > too much time trying to convince you this is a bad idea=
 and that your
> > > > > > > > > > cure is worse than the disease.
> > > > > > > > >
> > > > > > > > > To me the core issue is whether to completely split the d=
efconfig
> > > > > > > > > files. I am quite worried about that. You are quite worri=
ed about the
> > > > > > > > > confusion my series will cause.
> > > > > > > > >
> > > > > > > > > I think it is reasonable, if we go with my series, that I=
 drive
> > > > > > > > > conf_nospl down to zero lines (and remove the feature) be=
fore going
> > > > > > > > > any further. Would that make you more comfortable? It wou=
ld be a fair
> > > > > > > > > bit of work, but could be done over a few releases.
> > > > > > > >
> > > > > > > > Here is my core concern. Can macros be tricky? Yes. Do we n=
eed a
> > > > > > > > checkpatch.pl test for 'IS_ENABLED(FOO)' ? Yes. But the rea=
l problem is
> > > > > > > > bugs like:
> > > > > > > > - Take pinebook-pro-rk3399_defconfig
> > > > > > > > - Enable all 3 of: CONFIG_SPL_USB_DWC3_GENERIC CONFIG_SPL_U=
SB_GADGET
> > > > > > > >   CONFIG_SPL_USB_SDP_SUPPORT
> > > > > > > >
> > > > > > > > Your proposal neither fixes that bug nor makes it easier to=
 understand
> > > > > > > > why that bug happens. And this is the category of build pro=
blems that we
> > > > > > > > get that aren't "you missed using the right macro".
> > > > > > >
> > > > > > > Honestly, what on earth does this have to do with my series?
> > > > > >
> > > > > > It's that your series doesn't address the real problems we keep=
 having.
> > > > > >
> > > > > > > The problem happens before and after my series, from what I c=
an tell.
> > > > > >
> > > > > > Yes, I've said that numerous times.
> > > > > >
> > > > > > > If you want these sorts of combinations to be tested, perhaps=
 add a
> > > > > > > board that enables them, or even rethink your opposition to my
> > > > > > > buildman proposal?[4]
> > > > > >
> > > > > > This isn't relevant to the point I've raised several times now.=
 The
> > > > > > failure mode above was reported by two different developers, ne=
ither of
> > > > > > whom saw how to correctly solve the problem.
> > > > >
> > > > > That surprises me a little, as the problem seems pretty fundament=
al.
> > > > > If you don't enable USB_GADGET, then symbols which depend on it d=
on't
> > > > > exist.
> > > >
> > > > But they don't want USB_GADGET in PPL. They only want it in SPL.
> > >
> > > That seems to be splitting hairs, but OK. So why not make
> > > USB_GADGET_MANUFACTURER depend on USB_GADGET || SPL_USB_GADGET ?
> >
> > Yes, the solution today involves reworking drivers/usb/gadget/Kconfig so
> > that USB_GADGET_MANUFACTURER, USB_GADGET_VENDOR_NUM,
> > USB_GADGET_PRODUCT_NUM, USB_GADGET_VBUS_DRAW and that might be it, are
> > exposed to USB_GADGET || SPL_USB_GADGET and possibly down the line
> > VPL_USB_GADGET.
>=20
> OK
>=20
> >
> > > It wouldn't make sense to add SPL_USB_GADGET_MANUFACTURER as surely it
> > > would be the same value? This is once good thing about what we have:
> > > we can share values between phases without typing them in separately.
> >
> > Most of these should be, there may or may not be the questionable case
> > where one of the ID changes so the host knows what stage things are at.
> > But that's just an aside.
> >
> > My point is that drivers/usb/gadget/Kconfig is yet another case where we
> > need to make it much more complicated so that it works for all the use
> > cases. And that it's a more common and harder for developers to fix
> > problem than "Do I use $(SPL_TPL_) I mean $(PHASE_) or $(XPL_) in the
> > Makefile?"
>=20
> Yes, I understand that, but this is a tradeoff between that complexity
> and the one we would introduce by splitting the defconfigs. Given all
> the Kconfig churn it would require just to get things to work, it
> isn't a clear win, to say the least.

Since we would be removing stuff from Kconfig with the larger idea I
proposed, I'm not sure what you mean. We wouldn't have this problem at
all with the larger idea.

> > > > > > And again, if you tried to solve this problem on your series yo=
u might
> > > > > > see how what you're proposing will make things worse, not bette=
r.
> > > > >
> > > > > At least with my scheme you can do something like this:
> > > > >
> > > > > config SPL_USB_GADGET
> > > > >    bool "USB Gadget Support in SPL"
> > > > >    depends on USB_GADGET
> > > >
> > > > That symbol already exists. The problems are around all of the gadg=
et
> > > > symbols that don't exist.
> > >
> > > OK. But we have to move in steps. We can't do everything at once.
> >
> > Yes, which is why we have so many of these duplicative symbols
> > (USB_GADGET, SPL_USB_GADGET) and keep needing to add more.
>=20
> Yes, I don't like it either. I believe that if I had been able to land
> my solution last time, we would be having different discussions by
> now, e.g. how to tidy up the Kconfig without changing the build
> system.

I strongly doubt it.

> > > > > I normally make the SPL symbols depend on PPL, since it normally
> > > > > doesn't make a lot of sense to have the feature in SPL unless it =
is in
> > > > > PPL. Is this an exception to that rule?
> > > >
> > > > This half of the problem (you're still missing the other half of the
> > > > problem, the DWC3 code being built in TPL now and throwing
> > > > warnings-turned-error with -Werror and then discarded at link time)=
 is
> > > > one of many examples where we keep having to duplicate symbols in
> > > > Kconfig.
> > >
> > > >
> > > > > If we do go ahead and enhance Kconfig, then we can combine the two
> > > > > symbols, which is something.
> > > >
> > > > Or, we go the direction I suggested instead. Where we never duplica=
te
> > > > symbols, because we never need to anymore.
> > > >
> > > > Or, we step back because believe you're missing the bigger problems.
> > >
> > > At this point I'm not sure where to go. You are determined to split
> > > the defconfig files and have grace concerns about my schema. Vice
> > > versa for me.
> > >
> > > But my scheme takes us forward without needing to split the
> > > defconfigs. It does offer some benefits IMO. Once we split the
> > > defconfigs we can never put them back together.
> >
> > My continued strongest preference is to do the minimal effort to better
> > document what we are doing today and add the missing tooling so we don't
> > keep getting wrong macros in the code.
>=20
> I did actually do the tooling in qconfig - give it a try and see what
> you think. For documentation, we can discuss that as part of myt
> series.

The missing tooling is things like:
https://patchwork.ozlabs.org/project/uboot/patch/20250226153346.2736160-1-t=
rini@konsulko.com/

I'm not sure what qconfig features you're talking about.

> > If you're hellbent on doing this
> > and do it against master and not your personal tree, I'm expecting you
> > to be available to help clarify problems for developers if they report
> > them.
>=20
> That's fine. I do my development on my own tree, but once I actually
> do the series and it is reviewed, I can do a version against -next. As
> you know, there are a lot of moving parts, so I would want it to go in
> quickly to avoid a lot of rework.

Just don't post things that aren't against next, when you have something
as that makes review impossible for the rest of us.

--=20
Tom

--i+HUeVLepr2VAq7N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfAnjcACgkQFHw5/5Y0
tyylIQv/fUY+J/KA50qQvQkKAornAQfqEY0X3SWUtmp42ENQZ9XZEMekn9HFUTPd
tvg9SssxIzzl2ssThC9p2yZ5BgGYQ2+6KMnI0pfVr9RobWl3uJ8pcQZJZM48FzQX
bh2Etq9HffXzTrZNPZ6BKPqJbOy7cbew66R7gZbyuqUwvSkqDuT3flWgHafQwKkd
IHbe85pM/8Em6+eoemyQQQhAm+6a+pqmGQ7TxVntvs4t6AMmhnom3AF1t8BqtrsU
7GlIUETUXdKyk3hGWGJ49DIDJ0/ChRonPkOqlZJCXqvNS61ESO7uhGrqGF5GXlln
B4BK0B5EYL1ooD1W17b0rUrxllMXTtMQzoFFnoUkBa7ciJir57r/fTE5wbmsCdIN
bLPdex+HzgqGYolSm7/yh7PrmTs4p2eb001W2+DwXvpwrpFxFwLLY7pzo4iKx27u
ypEqxuKg2sYdCnUOGF6p5jflUKunZ2xP6JgONTwJ3glhG/0Rv2sU39Ey0O988vC4
H+zlVdf+
=euhU
-----END PGP SIGNATURE-----

--i+HUeVLepr2VAq7N--
