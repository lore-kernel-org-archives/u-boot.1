Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0423AC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 15:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05959810ED;
	Wed,  5 Mar 2025 16:49:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZT1PKFNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F7DF80F9E; Wed,  5 Mar 2025 16:49:54 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E435808B6
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 16:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6ef7c9e9592so53417987b3.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 07:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741189788; x=1741794588; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qCP9wJhStTJNKpvUNbTLh/xY54RQYyJRWDniy9+C/DA=;
 b=ZT1PKFNyaSG0GvIXrwBjumNc3gApFLNxLxBqKc6XSnCb7yacHKLfYo+EpRT9BfolM2
 RgoariFD1FNXyLg208bKr559qAiBtBDv3d9mSFQwXPAELbDURpPMn5iTImUTbsflXe6u
 FLgDf2JtoxdON1BVq4i1QkO+9wQPypvb4ilPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189788; x=1741794588;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qCP9wJhStTJNKpvUNbTLh/xY54RQYyJRWDniy9+C/DA=;
 b=Er51rRec7B0Ncdus2sIFDoLb7xYA8MItEQpYX5Lj/Hoj6monxHqg4NnKbny3Se8aaU
 Tmn8RbGdETcbCyT33J9JOg1nq1P2PEQBNKpG/0PkWjVMVrtGGDlYYyPOr3POoIWFqCEf
 c7VcwmfTHy9Vbj2GLBvByfNDbAFPWvrvMOnPRseILToq0s6ERlql2ll5ObFROIsUmwy+
 YD+d5yb4BITtWHyaBnhFE30zYMAFmO6RjKZRLn+rKXucpO3GMSu0/oIx9VZtnZktEQOb
 cY6+MCZJ1BrI0tKZxJRLPSsI7Bniy3aN+/fyfEnmAbVva4W+u6mJlIyE1GuCPbUe6wDD
 bY7Q==
X-Gm-Message-State: AOJu0YwI8bH/Q0yyN50IO7MGYpRaj6L1z5zo+YSQdgY+3aXgUb4tRY1R
 96Cu6+H8HtqEFJxs+q0SxVw9MhAGjAl8FJN2bLmQidhGrAHTlkuGtFXVxcGnbrc6hHJda5PFztr
 JCKI=
X-Gm-Gg: ASbGnctoxobOEvn0cuJjHfbqtSfLp7HTE0yii37GKPpzBUqqD/94DMUC6ozP5vbKeP1
 BzWQL1Y9yRWeM+YgMCtHLsjqURxvDitw4yK/YdRu9iPOJMaQnEsXLQh6kn96TFLejNH+UEFr41q
 hZXJ5GueWhC2099TyWacS9VzyiCm1A0+Nq0+VKrY1zEUxR5D3Dx7Y9Y8ZurDRnQDi5j0dzNz4SV
 0AgIsKFGy20DmsEfDJ1VSgWEt4Qmv4d+ApnaetmessvuKfAPmFTnwKv1czGdTT5lE4leGPsbQoY
 N9YCSLs51cXyEE1mDFzgavW8DmnF7TPwX3zD4JJJhGhXyw==
X-Google-Smtp-Source: AGHT+IHsKUIfFXRWbejaL7Muxsi51HgBNiUhGIxfbfwjdoYjNLet/02e0zEX/jjIL44EbPStB0PeAQ==
X-Received: by 2002:a05:690c:4c09:b0:6f9:aeee:8f26 with SMTP id
 00721157ae682-6fda2e8e1efmr58178187b3.0.1741189787818; 
 Wed, 05 Mar 2025 07:49:47 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3ca0f3e9sm29411177b3.9.2025.03.05.07.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 07:49:47 -0800 (PST)
Date: Wed, 5 Mar 2025 09:49:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250305154944.GP2640854@bill-the-cat>
References: <20250225215100.GC2640854@bill-the-cat>
 <CAFLszTiP3=FyUm36aLPfdwObQT0WPS_+Y486VRmV41cxEkA93w@mail.gmail.com>
 <20250226145255.GJ2640854@bill-the-cat>
 <CAFLszTgMdR6fSDxUTKO3Mru3YU6=HK52tU2+rgri3J_TXWiTUg@mail.gmail.com>
 <20250227171753.GG2640854@bill-the-cat>
 <CAFLszTg1A0HiaqVPxY3utpztOw6QFNQGZwPgtN9tZBN+3E9TiQ@mail.gmail.com>
 <20250227203017.GK2640854@bill-the-cat>
 <CAFLszTgA9G8pueG5w6Vjq8Qg3Qqwivs=9J2ZiuBk2dv+tr1pOg@mail.gmail.com>
 <20250304162521.GB2640854@bill-the-cat>
 <CAFLszTivskvEa2YRQu0YKDUVxFcUZ611Z=PiU2v=mKpfEsapew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LMfF4zB7KnrAT37m"
Content-Disposition: inline
In-Reply-To: <CAFLszTivskvEa2YRQu0YKDUVxFcUZ611Z=PiU2v=mKpfEsapew@mail.gmail.com>
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


--LMfF4zB7KnrAT37m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 07:17:51AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 4 Mar 2025 at 09:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Mar 04, 2025 at 08:35:29AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 27 Feb 2025 at 13:30, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Feb 27, 2025 at 12:32:42PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 27 Feb 2025 at 10:17, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Feb 27, 2025 at 09:24:45AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Wed, 26 Feb 2025 at 07:53, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Tue, Feb 25, 2025 at 07:51:07PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Tue, 25 Feb 2025 at 14:51, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Feb 25, 2025 at 02:33:17PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Tue, 25 Feb 2025 at 07:02, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, Feb 24, 2025 at 04:38:50PM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Mon, 24 Feb 2025 at 09:00, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 07:07:06PM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Fri, 21 Feb 2025 at 18:06, Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 05:24:35PM -0700, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Fri, 21 Feb 2025 at 17:03, Tom Rini <t=
rini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 04:35:16PM -070=
0, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Fri, 21 Feb 2025 at 16:20, Tom Rin=
i <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 03:54:52PM =
-0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > Hi  Tom,
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Fri, 21 Feb 2025 at 12:26, Tom=
 Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > On Fri, Feb 21, 2025 at 08:19:4=
0AM -0600, Tom Rini wrote:
> > > > > > > > > > > > > > > > > > > > > > > On Thu, Feb 20, 2025 at 06:30=
:18PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > On Thu, 20 Feb 2025 at 13:4=
0, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > On Thu, Feb 20, 2025 at 1=
1:13:34AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > > [snip]
> > > > > > > > > > > > > > > > > > > > > > > > > I will look at "splg4" on=
ce it's somewhere on source.denx.de and I can
> > > > > > > > > > > > > > > > > > > > > > > > > look at it, and refrain f=
rom otherwise assuming how it solves the
> > > > > > > > > > > > > > > > > > > > > > > > > problems I had seen previ=
ously.
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > I pushed an updated version=
 to dm/splg-working but it is not very
> > > > > > > > > > > > > > > > > > > > > > > > updated. Still needs more w=
ork.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > Thanks.
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > So, after doing the remaining C=
ONFIG_TEXT_BASE -> CONFIG_PPL_TEXT_BASE
> > > > > > > > > > > > > > > > > > > > > > changes, here's another example=
 of the problem with your approach. What
> > > > > > > > > > > > > > > > > > > > > > stops xilinx_zynqmp_kria from b=
uilding in splg-working is that
> > > > > > > > > > > > > > > > > > > > > > BUTTON was missing from scripts=
/conf_nospl. Annoyingly, a mrproper (or
> > > > > > > > > > > > > > > > > > > > > > since I always use O=3D, rm -rf=
) is needed for changes there to be picked
> > > > > > > > > > > > > > > > > > > > > > up, but that's maybe just a mis=
sing Makefile dependency line. But that
> > > > > > > > > > > > > > > > > > > > > > just makes it easier to see the=
 next problem, which I don't see the
> > > > > > > > > > > > > > > > > > > > > > answer to. For PPL, we can buil=
d drivers/spi/zynqmp_gqspi.o just fine.
> > > > > > > > > > > > > > > > > > > > > > For SPL however:
> > > > > > > > > > > > > > > > > > > > > >   CC      spl/drivers/spi/zynqm=
p_gqspi.o
> > > > > > > > > > > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/=
drivers/spi/zynqmp_gqspi.c: In function 'zynqmp_qspi_of_to_plat':
> > > > > > > > > > > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/=
drivers/spi/zynqmp_gqspi.c:203:22: warning: cast to pointer from integer of=
 different size [-Wint-to-pointer-cast]
> > > > > > > > > > > > > > > > > > > > > >   203 |         plat->regs =3D =
(struct zynqmp_qspi_regs *)(dev_read_addr(bus) +
> > > > > > > > > > > > > > > > > > > > > >       |                      ^
> > > > > > > > > > > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/=
drivers/spi/zynqmp_gqspi.c:205:26: warning: cast to pointer from integer of=
 different size [-Wint-to-pointer-cast]
> > > > > > > > > > > > > > > > > > > > > >   205 |         plat->dma_regs =
=3D (struct zynqmp_qspi_dma_regs *)
> > > > > > > > > > > > > > > > > > > > > >       |                        =
  ^
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > And I don't see, really, what's=
 even getting us down this error path.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > It's the FDT_64BIT in conf_nospl =
- that symbol needs to be the same
> > > > > > > > > > > > > > > > > > > > > across all phases.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > I pushed a new tree which builds =
without the warning. Note that
> > > > > > > > > > > > > > > > > > > > > SPL_SPI is enabled.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > So, the "what" is FDT_64BIT wasn't =
correct. I think this is showing that
> > > > > > > > > > > > > > > > > > > > scripts/conf_nospl is going to be a=
 problem in and of itself, and likely
> > > > > > > > > > > > > > > > > > > > as confusing if not more-so than an=
y of the in-the-end visible changes.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Yes, perhaps the key point I've been =
trying to get across is this confusion.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > As you know, at present we have two t=
ypes of options:
> > > > > > > > > > > > > > > > > > > a) those for which each phase has its=
 own value
> > > > > > > > > > > > > > > > > > > b) those for which there is a single =
value shared across all phases
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Agreed.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > The only way today that you can tell =
them apart is by looking for uses
> > > > > > > > > > > > > > > > > > > of CONFIG_IS_ENABLED() and $(PHASE_) =
with the option. If you see them,
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Partially agreed. Those are strong indi=
cators that both CONFIG_FOO and
> > > > > > > > > > > > > > > > > > CONFIG_SPL_FOO exist, but not always. W=
e have, intentionally, both the
> > > > > > > > > > > > > > > > > > inverse case (CONFIG_SPL_BAR and CONFIG=
_TPL_BAR exist, CONFIG_BAR does
> > > > > > > > > > > > > > > > > > not) and some future-proofing (CONFIG_S=
PL_BAZ may exist in the future,
> > > > > > > > > > > > > > > > > > but not yet).
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > OK
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > then the option is a) otherwise it is=
 b). There is no way to tell from
> > > > > > > > > > > > > > > > > > > Kconfig.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Kconfig will happily allow "depends on =
BOGUS_SYMBOL" yes, and a linter
> > > > > > > > > > > > > > > > > > would be a handy thing to have. But you=
're mentioning this in another
> > > > > > > > > > > > > > > > > > context, why we need some additional kn=
owledge somewhere.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > What I meant was that we don't have anyth=
ing in the Kconfig for FOO
> > > > > > > > > > > > > > > > > that says this is a global option or an x=
PL-specific one. We have to
> > > > > > > > > > > > > > > > > hunt for SPL_FOO, etc.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Also, some parts of the code may use =
CONFIG_IS_ENABLED() for
> > > > > > > > > > > > > > > > > > > an option, some may use IS_ENABLED() =
for that same option. Some may
> > > > > > > > > > > > > > > > > > > use $(PHASE_) and some may not. It's =
a bit of a mess.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I'm sure you can find some examples whe=
re we have CONFIG_IS_ENABLED(FOO)
> > > > > > > > > > > > > > > > > > and IS_ENABLED(CONFIG_FOO) and it's not=
 intentional, but that's not a
> > > > > > > > > > > > > > > > > > big deal, and should be fixed.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > But this is largely the point of my serie=
s. It's the reason why
> > > > > > > > > > > > > > > > > qconfig is able to locate these cases and=
 warn about them. It is a big
> > > > > > > > > > > > > > > > > deal, IMO, or at least big enough for me =
to attempt this.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I'm only going to rant slightly that ch=
eckpatch.pl telling people to use
> > > > > > > > > > > > > > > > > > these macros has made the situation wor=
se, not better, out of an
> > > > > > > > > > > > > > > > > > ingrained need to silence checkpatch.pl.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > And what you're missing is that sometim=
es we intentionally don't want
> > > > > > > > > > > > > > > > > > $(PHASE_), or would need to rewrite the=
 Makefile to make use of it.
> > > > > > > > > > > > > > > > > > fs/Makefile is an example of this.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > The next step from my side would be to ge=
t rid of the 'ifdef
> > > > > > > > > > > > > > > > > CONFIG_XPL_BUILD' in the Makefiles. It's =
confusing and annoying.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Stepping back a bit, perhaps the goal=
 of my series is to identify
> > > > > > > > > > > > > > > > > > > options in b) so we can deal with the=
m in a better way. They are all
> > > > > > > > > > > > > > > > > > > listed in conf_nospl, in preparation =
for some future action.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > There are two big problems here. The fi=
rst of which is that conf_nospl,
> > > > > > > > > > > > > > > > > > as a concept, is going to be incomplete=
=2E Do you list every CMD in there?
> > > > > > > > > > > > > > > > > > Why? They'll never be in a non-PPL phas=
e. It will be its own nightmare
> > > > > > > > > > > > > > > > > > to keep correct, once it is bug-compati=
ble with what we have today.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > This is actually the *nice* thing about c=
onf_nospl. We should reduce
> > > > > > > > > > > > > > > > > it to empty, just like we did with the Kc=
onfig whitelist.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > We have this rule:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > libs-$(CONFIG_CMDLINE) +=3D cmd/
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > which is enough for most things. The only=
 issue is that sometimes,
> > > > > > > > > > > > > > > > > e.g. with CONFIG_CMD_DHCP it doesn't mean=
 the command at all.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > So I don't agree at all that my series is=
 a 'big problem'. It is a
> > > > > > > > > > > > > > > > > solution to the current confusion and it =
shows up what is broken and
> > > > > > > > > > > > > > > > > needs to be fixed.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > The second big problem is that it doesn=
't make it any easier to solve
> > > > > > > > > > > > > > > > > > what I keep calling the DWC3 problem. I=
t's a valid use case that two
> > > > > > > > > > > > > > > > > > developers have hit independently of wa=
nting to enable USB gadget
> > > > > > > > > > > > > > > > > > support (and the HW uses DWC3) in SPL a=
nd not PPL. Not only are you not
> > > > > > > > > > > > > > > > > > solving this problem, it gets worse to =
solve. Today it's "OK, I need to
> > > > > > > > > > > > > > > > > > find where to move obj-$(CONFIG_FOO) to=
 be more visible and
> > > > > > > > > > > > > > > > > > obj-$(CONFIG_$(PHASE_)FOO". Tomorrow it=
's "Why isn't obj-$(CONFIG_FOO)
> > > > > > > > > > > > > > > > > > working here but not there?".
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Is that because some Makefile higher in t=
he hierarchy is not building
> > > > > > > > > > > > > > > > > that subdir? I don't know what this is ab=
out.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > To me, at absolute best case here, we'r=
e making a lot of changes and
> > > > > > > > > > > > > > > > > > spending a lot of time to not really ad=
dress the underlying problems,
> > > > > > > > > > > > > > > > > > just making some questionable value vis=
ibility changes. We could reduce
> > > > > > > > > > > > > > > > > > ourselves to one macro by saying only e=
ver use CONFIG_IS_ENABLED(FOO)
> > > > > > > > > > > > > > > > > > and IS_ENABLED(CONFIG_FOO) goes back to=
 an ifdef for the case where it
> > > > > > > > > > > > > > > > > > must only be tested on CONFIG_FOO.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Or we could finish and apply my series, w=
hich does this.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I'm 80% sure we could simplify all of
> > > > > > > > > > > > > > > > > > $(PHASE_)/$(XPL_)/$(SPL_) down to just =
$(PHASE_) and that eliminates the
> > > > > > > > > > > > > > > > > > which to use of those question.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Again, let's apply my series, which actua=
lly gets rid of PHASE_, SPL_
> > > > > > > > > > > > > > > > > and XPL_ altogether.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > And update / expand upon the existing
> > > > > > > > > > > > > > > > > > documentation we have as it's not clear=
 enough for everyone. Then we can
> > > > > > > > > > > > > > > > > > think, again, about how to solve the pr=
oblems that are introduced by
> > > > > > > > > > > > > > > > > > building our entire source tree N times=
 from a single configuration
> > > > > > > > > > > > > > > > > > file. Or if we need to do something rad=
ical there.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > At this point I'm getting the feeling tha=
t you imagine my series is
> > > > > > > > > > > > > > > > > some grand unified plan for Kconfig. It r=
eally isn't and this thread
> > > > > > > > > > > > > > > > > is reminding me of why I originally wrote=
 it. Bear in mind it was over
> > > > > > > > > > > > > > > > > two years ago and I have mostly forgotten=
 all the issues. It is a
> > > > > > > > > > > > > > > > > clean-up series. It isn't the second comi=
ng but it isn't the
> > > > > > > > > > > > > > > > > antichrist either.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I worry you're going to spend another month=
 of effort to get this to 1:1
> > > > > > > > > > > > > > > > compatibility (modulo fixing bugs) with wha=
t we have today and get
> > > > > > > > > > > > > > > > disappointed once it rolls out to -next. Bu=
t I guess I've already spent
> > > > > > > > > > > > > > > > too much time trying to convince you this i=
s a bad idea and that your
> > > > > > > > > > > > > > > > cure is worse than the disease.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > To me the core issue is whether to completely=
 split the defconfig
> > > > > > > > > > > > > > > files. I am quite worried about that. You are=
 quite worried about the
> > > > > > > > > > > > > > > confusion my series will cause.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I think it is reasonable, if we go with my se=
ries, that I drive
> > > > > > > > > > > > > > > conf_nospl down to zero lines (and remove the=
 feature) before going
> > > > > > > > > > > > > > > any further. Would that make you more comfort=
able? It would be a fair
> > > > > > > > > > > > > > > bit of work, but could be done over a few rel=
eases.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Here is my core concern. Can macros be tricky? =
Yes. Do we need a
> > > > > > > > > > > > > > checkpatch.pl test for 'IS_ENABLED(FOO)' ? Yes.=
 But the real problem is
> > > > > > > > > > > > > > bugs like:
> > > > > > > > > > > > > > - Take pinebook-pro-rk3399_defconfig
> > > > > > > > > > > > > > - Enable all 3 of: CONFIG_SPL_USB_DWC3_GENERIC =
CONFIG_SPL_USB_GADGET
> > > > > > > > > > > > > >   CONFIG_SPL_USB_SDP_SUPPORT
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Your proposal neither fixes that bug nor makes =
it easier to understand
> > > > > > > > > > > > > > why that bug happens. And this is the category =
of build problems that we
> > > > > > > > > > > > > > get that aren't "you missed using the right mac=
ro".
> > > > > > > > > > > > >
> > > > > > > > > > > > > Honestly, what on earth does this have to do with=
 my series?
> > > > > > > > > > > >
> > > > > > > > > > > > It's that your series doesn't address the real prob=
lems we keep having.
> > > > > > > > > > > >
> > > > > > > > > > > > > The problem happens before and after my series, f=
rom what I can tell.
> > > > > > > > > > > >
> > > > > > > > > > > > Yes, I've said that numerous times.
> > > > > > > > > > > >
> > > > > > > > > > > > > If you want these sorts of combinations to be tes=
ted, perhaps add a
> > > > > > > > > > > > > board that enables them, or even rethink your opp=
osition to my
> > > > > > > > > > > > > buildman proposal?[4]
> > > > > > > > > > > >
> > > > > > > > > > > > This isn't relevant to the point I've raised severa=
l times now. The
> > > > > > > > > > > > failure mode above was reported by two different de=
velopers, neither of
> > > > > > > > > > > > whom saw how to correctly solve the problem.
> > > > > > > > > > >
> > > > > > > > > > > That surprises me a little, as the problem seems pret=
ty fundamental.
> > > > > > > > > > > If you don't enable USB_GADGET, then symbols which de=
pend on it don't
> > > > > > > > > > > exist.
> > > > > > > > > >
> > > > > > > > > > But they don't want USB_GADGET in PPL. They only want i=
t in SPL.
> > > > > > > > >
> > > > > > > > > That seems to be splitting hairs, but OK. So why not make
> > > > > > > > > USB_GADGET_MANUFACTURER depend on USB_GADGET || SPL_USB_G=
ADGET ?
> > > > > > > >
> > > > > > > > Yes, the solution today involves reworking drivers/usb/gadg=
et/Kconfig so
> > > > > > > > that USB_GADGET_MANUFACTURER, USB_GADGET_VENDOR_NUM,
> > > > > > > > USB_GADGET_PRODUCT_NUM, USB_GADGET_VBUS_DRAW and that might=
 be it, are
> > > > > > > > exposed to USB_GADGET || SPL_USB_GADGET and possibly down t=
he line
> > > > > > > > VPL_USB_GADGET.
> > > > > > >
> > > > > > > OK
> > > > > > >
> > > > > > > >
> > > > > > > > > It wouldn't make sense to add SPL_USB_GADGET_MANUFACTURER=
 as surely it
> > > > > > > > > would be the same value? This is once good thing about wh=
at we have:
> > > > > > > > > we can share values between phases without typing them in=
 separately.
> > > > > > > >
> > > > > > > > Most of these should be, there may or may not be the questi=
onable case
> > > > > > > > where one of the ID changes so the host knows what stage th=
ings are at.
> > > > > > > > But that's just an aside.
> > > > > > > >
> > > > > > > > My point is that drivers/usb/gadget/Kconfig is yet another =
case where we
> > > > > > > > need to make it much more complicated so that it works for =
all the use
> > > > > > > > cases. And that it's a more common and harder for developer=
s to fix
> > > > > > > > problem than "Do I use $(SPL_TPL_) I mean $(PHASE_) or $(XP=
L_) in the
> > > > > > > > Makefile?"
> > > > > > >
> > > > > > > Yes, I understand that, but this is a tradeoff between that c=
omplexity
> > > > > > > and the one we would introduce by splitting the defconfigs. G=
iven all
> > > > > > > the Kconfig churn it would require just to get things to work=
, it
> > > > > > > isn't a clear win, to say the least.
> > > > > >
> > > > > > Since we would be removing stuff from Kconfig with the larger i=
dea I
> > > > > > proposed, I'm not sure what you mean. We wouldn't have this pro=
blem at
> > > > > > all with the larger idea.
> > > > >
> > > > > But we have other problems, mainly that we cannot easily use an o=
ption
> > > > > from one phase in another, so need to duplicate all such options,=
 then
> > > > > add tooling to try to keep them in sync, except when we don't want
> > > > > them in sync, etc. Are you sure you have thought this through all=
 the
> > > > > way?
> > > >
> > > > Yes, I have. Because rarely are there cases where we *need* to shar=
e a
> > > > value from multiple phases *and* we can't have the default be corre=
ct.
> > >
> > > You're likely right about this, but I can imagine it being quite
> > > painful for the cases where we do need something. We could have some
> > > kconfig tooling which prints a list of those cases, perhaps.
> > >
> > > >
> > > > > > > > > > > > And again, if you tried to solve this problem on yo=
ur series you might
> > > > > > > > > > > > see how what you're proposing will make things wors=
e, not better.
> > > > > > > > > > >
> > > > > > > > > > > At least with my scheme you can do something like thi=
s:
> > > > > > > > > > >
> > > > > > > > > > > config SPL_USB_GADGET
> > > > > > > > > > >    bool "USB Gadget Support in SPL"
> > > > > > > > > > >    depends on USB_GADGET
> > > > > > > > > >
> > > > > > > > > > That symbol already exists. The problems are around all=
 of the gadget
> > > > > > > > > > symbols that don't exist.
> > > > > > > > >
> > > > > > > > > OK. But we have to move in steps. We can't do everything =
at once.
> > > > > > > >
> > > > > > > > Yes, which is why we have so many of these duplicative symb=
ols
> > > > > > > > (USB_GADGET, SPL_USB_GADGET) and keep needing to add more.
> > > > > > >
> > > > > > > Yes, I don't like it either. I believe that if I had been abl=
e to land
> > > > > > > my solution last time, we would be having different discussio=
ns by
> > > > > > > now, e.g. how to tidy up the Kconfig without changing the bui=
ld
> > > > > > > system.
> > > > > >
> > > > > > I strongly doubt it.
> > > > >
> > > > > I know you do, but I could be right about this.
> > > >
> > > > You could. But you could also be very wrong. And the struggle I've =
had
> > > > with showing you problems other developers have has not left me fee=
ling
> > > > great. But I've still said I'll take this but need you to commit to
> > > > following up with bug reports.
> > >
> > > I'm happy to follow up with bug reports.
> > >
> > > >
> > > > > > > > > > > I normally make the SPL symbols depend on PPL, since =
it normally
> > > > > > > > > > > doesn't make a lot of sense to have the feature in SP=
L unless it is in
> > > > > > > > > > > PPL. Is this an exception to that rule?
> > > > > > > > > >
> > > > > > > > > > This half of the problem (you're still missing the othe=
r half of the
> > > > > > > > > > problem, the DWC3 code being built in TPL now and throw=
ing
> > > > > > > > > > warnings-turned-error with -Werror and then discarded a=
t link time) is
> > > > > > > > > > one of many examples where we keep having to duplicate =
symbols in
> > > > > > > > > > Kconfig.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > If we do go ahead and enhance Kconfig, then we can co=
mbine the two
> > > > > > > > > > > symbols, which is something.
> > > > > > > > > >
> > > > > > > > > > Or, we go the direction I suggested instead. Where we n=
ever duplicate
> > > > > > > > > > symbols, because we never need to anymore.
> > > > > > > > > >
> > > > > > > > > > Or, we step back because believe you're missing the big=
ger problems.
> > > > > > > > >
> > > > > > > > > At this point I'm not sure where to go. You are determine=
d to split
> > > > > > > > > the defconfig files and have grace concerns about my sche=
ma. Vice
> > > > > > > > > versa for me.
> > > > > > > > >
> > > > > > > > > But my scheme takes us forward without needing to split t=
he
> > > > > > > > > defconfigs. It does offer some benefits IMO. Once we spli=
t the
> > > > > > > > > defconfigs we can never put them back together.
> > > > > > > >
> > > > > > > > My continued strongest preference is to do the minimal effo=
rt to better
> > > > > > > > document what we are doing today and add the missing toolin=
g so we don't
> > > > > > > > keep getting wrong macros in the code.
> > > > > > >
> > > > > > > I did actually do the tooling in qconfig - give it a try and =
see what
> > > > > > > you think. For documentation, we can discuss that as part of =
myt
> > > > > > > series.
> > > > > >
> > > > > > The missing tooling is things like:
> > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20250226153346=
=2E2736160-1-trini@konsulko.com/
> > > > >
> > > > > Well that's good to have anyway.
> > > > >
> > > > > >
> > > > > > I'm not sure what qconfig features you're talking about.
> > > > >
> > > > > It is qconfig --scan-source which prints a lot of warnings.
> > > >
> > > > I'm not sure I saw what that was for when it went in. But I'm not s=
ure
> > > > how useful that is either. The first section shows some dead code to
> > > > remove, which is good. It complains about cases of CONFIG_$(PHASE_)=
FOO
> > > > being used as future-proofing which is not good. And it caught none=
 of
> > > > the errors like:
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20250226203123.383=
1960-1-trini@konsulko.com/
> > > >
> > > > And I'm not sure "CONFIG options used as Proper but without a non-x=
PL_
> > > > variant" is a valid variant at all. I'm sure you've found it useful=
 but
> > > > I'm not sure it's something I would suggest people run normally.
> > >
> > > The tool identifies problems which cause build errors (or changes in
> > > the effective value of Kconfig options).
> >
> > Along with lots of false positives. I'm not saying there's nothing of
> > use here, but I am saying that for example "make this produce no output"
> > is neither a feasible nor good goal.
>=20
> OK. I didn't actually say that it was though.
>=20
> >
> > > > > > > > If you're hellbent on doing this
> > > > > > > > and do it against master and not your personal tree, I'm ex=
pecting you
> > > > > > > > to be available to help clarify problems for developers if =
they report
> > > > > > > > them.
> > > > > > >
> > > > > > > That's fine. I do my development on my own tree, but once I a=
ctually
> > > > > > > do the series and it is reviewed, I can do a version against =
-next. As
> > > > > > > you know, there are a lot of moving parts, so I would want it=
 to go in
> > > > > > > quickly to avoid a lot of rework.
> > > > > >
> > > > > > Just don't post things that aren't against next, when you have =
something
> > > > > > as that makes review impossible for the rest of us.
> > > > >
> > > > > I had thought we agreed that to minimise differences you would re=
view
> > > > > patches that I sent from my tree?
> > > >
> > > > I said that back when I thought you would default to posting against
> > > > the relevant upstream branch and not developer further against your=
 own
> > > > tree.
> > >
> > > That's not what I intended you to think. We should look to find some
> > > way to do this via pull requests.
> >
> > Well, you used to put things in u-boot-dm, that had been reviewed or at
> > least not rejected by others, and send me a pull request. Along the way
> > you stopped doing that. You could start again, and that would be
> > helpful. If you find the "u-boot-dm" part too restrictive adding
> > contributor/sjg/ namespace is easy (and someone else had suggested this
> > in another thread, even).
>=20
> I don't mind creating a PR if it will keep our trees more in sync. I
> do need my own tree though, since some patches have already been
> completely rejected. I finally figured out how to rename it so that
> sjg.u-boot.org doesn't give strange errors anymore.

It's a step in the right direction, yes.

> So it seems to me that this thread is complete. Does that sound right?
> I probably need to wait until you have finished your Kconfig clean-up
> stuff, but then I should take a crack at it?

Do you mean the PHASE_ rename I posted?

--=20
Tom

--LMfF4zB7KnrAT37m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfIcpUACgkQFHw5/5Y0
tywsFgwAoL6TGzV+D0PvG1bxpO4/KoHl4zujJHVDD5a+uM3M3oiJJrwDKhsDM/IK
YrsdvGErL4zUv7P/910WWxqOpTvahfKLVqJYfUtsOqy067pilRhwnAIofhQbVV2B
+nMOO3XEBEarLX5x+x7AY/hu9dMPwl6WVe1oDbdcDfpnUb06SJB2MXEjs90F4qoq
A5miBCtWwp/gfM7q3ayYY9QtGWghm2pzGBrDt3yS0OJ/VDJ49iGA2SSd0KQ3vkwu
pmLDdHiMIa9ayeBHN2NGnBRMGu5fYW0tCWihHNvPX0i9cPLUSP8iZejb2ufd8KMo
d130J/D9dmGM0BgrKvt3CGrBCwcKlklI+Ffm9Ipt11c0uKhGpWa8hcj5Lmnxb5uw
nLGsgputTnp/LgSXFywFdSrOw7JTVGC2nD3eA7YM9aW3ub/cRkvj+W2nzuL4wJDO
3w7eY1m5r/z0liGnus7JQmLSUJuT6o5r0wv21DvR7tui7/2V7sO/TFrUz+yK3etG
UenNY5ax
=l+lQ
-----END PGP SIGNATURE-----

--LMfF4zB7KnrAT37m--
