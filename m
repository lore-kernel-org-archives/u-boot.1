Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE400C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 16:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F3D980F3F;
	Mon, 24 Feb 2025 17:00:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gny97YK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 293BB805C3; Mon, 24 Feb 2025 17:00:19 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FC3A80017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 17:00:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-222e8d07dc6so19401085ad.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 08:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740412815; x=1741017615; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uWWuDp0/4J00uFxbqecnulBcK2KAyYvfoY7eFl10UBw=;
 b=gny97YK9jIeMldJ2SXjidho9sR7hxhRWqnuySCvJLmio+ON5XxlF+EcKXWthaBLRfZ
 u6yT8fNESgbzAVmhNnoFO4aYXj+FvvpcPSVudA6+L8xonVjPl6Du9MESZZaqcuWwi120
 fwMdqmCF+C2AJUbZR2WSsj3jbtn0b5Mi9zc+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740412815; x=1741017615;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWWuDp0/4J00uFxbqecnulBcK2KAyYvfoY7eFl10UBw=;
 b=kGIPULTinXAF2wX5/CeGEYzPpBEjVxgX2L8/zjuuki5UTPTLJXP2RfJSZgKdAL9MuV
 8rpOASX7up+Uam0gSLPJyr5JCJWmCjHBDqbzaGb7snGt7gwt/iAGqAAIKs94q3Xg6nv6
 GTMImWIYnc33/FWp3nVA7nK87I08lK42fTRb0rSnhuFvjJtjyWq/PbQu723bfdBOOBP8
 8cCahoICiIr0BCaFQiYpdBFE+/4/LG407nJpH3d8EytsjqAoU+3zuUF4rji1vsX4glGg
 hdyBcQ3mQK75002qfMc19hxqZKKhWbKnaT7FCZc3LIvsEn07vPR9IXK6LzKSnDdXonlZ
 3G6w==
X-Gm-Message-State: AOJu0Yzgla6U+yKbELXL5b/j96ScmCCGaCKRkxVmlSsdgO7qVut/kfu0
 65WUiSkP4nUWC/khVDzqgJ18M6VsFMyujLIlJ7brfR+X+Sc0c9lhrIaIPVaZUq8=
X-Gm-Gg: ASbGnctCcJ2WOOlH9gMpsXzUDoDWQQKpXbwuTPHZz0LMjiMQNAnlsWTFBgEXHCuzJRD
 g4qv9LOGYNRLS7HNgY6QR+7Wo4pbN5WVtE4HufOlrUm7c2MU7Qidt4z6nP0JrwXrfNy/c0JXJ/k
 j6cAQ3lpq33eVRqrcKo18mEIAk0hFrQGVX4ENOviApCkVxNpVHGGgUeY4ntQ5Qw3ciWrS4FbFIV
 ZgwxpBj3k6zIzMPoef23N2mNNAiqcKtdYcvbr+LehT26wp9CDJJwF5JboRp5xt/+bNxh3shMKFe
 vss7lR4NVq7dNt3s937xC6Sx
X-Google-Smtp-Source: AGHT+IH4e14PfQ8Ok+Yfkli8O9mxKhCygaPodoGUG0UqOQjEg8zWirdN4uADROTamAYGLSLttiGl6g==
X-Received: by 2002:a17:902:cec1:b0:215:58be:3349 with SMTP id
 d9443c01a7336-2219ffa04dcmr258545455ad.14.1740412808445; 
 Mon, 24 Feb 2025 08:00:08 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d43dsm182513365ad.158.2025.02.24.08.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 08:00:07 -0800 (PST)
Date: Mon, 24 Feb 2025 10:00:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250224160004.GF1233568@bill-the-cat>
References: <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
 <20250221192556.GP1233568@bill-the-cat>
 <CAFLszTicfTaAih-h6zgUD2ND2584quCmiayOZ__3t2Y+Ps0Lpg@mail.gmail.com>
 <20250221232005.GV1233568@bill-the-cat>
 <CAFLszTjDukiu-06gRxWmahXB6gKiTQjGPfT1D9TqeMZcG+h_yw@mail.gmail.com>
 <20250222000331.GW1233568@bill-the-cat>
 <CAFLszThbizWn8ja9pwfa6Fn6NBp83BdAUFkoO97PEtUCUuQzBg@mail.gmail.com>
 <20250222010654.GA1233568@bill-the-cat>
 <CAFLszTgS1KtMtuW9vo=F-H5q_km0BLsA5BVU_cZDSV9dgOo_mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O0HEE3b+BE3EX0Fb"
Content-Disposition: inline
In-Reply-To: <CAFLszTgS1KtMtuW9vo=F-H5q_km0BLsA5BVU_cZDSV9dgOo_mA@mail.gmail.com>
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


--O0HEE3b+BE3EX0Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 07:07:06PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 21 Feb 2025 at 18:06, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Feb 21, 2025 at 05:24:35PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 21 Feb 2025 at 17:03, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Feb 21, 2025 at 04:35:16PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 21 Feb 2025 at 16:20, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Feb 21, 2025 at 03:54:52PM -0700, Simon Glass wrote:
> > > > > > > Hi  Tom,
> > > > > > >
> > > > > > > On Fri, 21 Feb 2025 at 12:26, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, Feb 21, 2025 at 08:19:40AM -0600, Tom Rini wrote:
> > > > > > > > > On Thu, Feb 20, 2025 at 06:30:18PM -0700, Simon Glass wro=
te:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Thu, 20 Feb 2025 at 13:40, Tom Rini <trini@konsulko.=
com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Feb 20, 2025 at 11:13:34AM -0700, Simon Glass=
 wrote:
> > > > > > > > [snip]
> > > > > > > > > > > I will look at "splg4" once it's somewhere on source.=
denx.de and I can
> > > > > > > > > > > look at it, and refrain from otherwise assuming how i=
t solves the
> > > > > > > > > > > problems I had seen previously.
> > > > > > > > > >
> > > > > > > > > > I pushed an updated version to dm/splg-working but it i=
s not very
> > > > > > > > > > updated. Still needs more work.
> > > > > > > > >
> > > > > > > > > Thanks.
> > > > > > > >
> > > > > > > > So, after doing the remaining CONFIG_TEXT_BASE -> CONFIG_PP=
L_TEXT_BASE
> > > > > > > > changes, here's another example of the problem with your ap=
proach. What
> > > > > > > > stops xilinx_zynqmp_kria from building in splg-working is t=
hat
> > > > > > > > BUTTON was missing from scripts/conf_nospl. Annoyingly, a m=
rproper (or
> > > > > > > > since I always use O=3D, rm -rf) is needed for changes ther=
e to be picked
> > > > > > > > up, but that's maybe just a missing Makefile dependency lin=
e. But that
> > > > > > > > just makes it easier to see the next problem, which I don't=
 see the
> > > > > > > > answer to. For PPL, we can build drivers/spi/zynqmp_gqspi.o=
 just fine.
> > > > > > > > For SPL however:
> > > > > > > >   CC      spl/drivers/spi/zynqmp_gqspi.o
> > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c: =
In function 'zynqmp_qspi_of_to_plat':
> > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:2=
03:22: warning: cast to pointer from integer of different size [-Wint-to-po=
inter-cast]
> > > > > > > >   203 |         plat->regs =3D (struct zynqmp_qspi_regs *)(=
dev_read_addr(bus) +
> > > > > > > >       |                      ^
> > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:2=
05:26: warning: cast to pointer from integer of different size [-Wint-to-po=
inter-cast]
> > > > > > > >   205 |         plat->dma_regs =3D (struct zynqmp_qspi_dma_=
regs *)
> > > > > > > >       |                          ^
> > > > > > > >
> > > > > > > > And I don't see, really, what's even getting us down this e=
rror path.
> > > > > > >
> > > > > > > It's the FDT_64BIT in conf_nospl - that symbol needs to be th=
e same
> > > > > > > across all phases.
> > > > > > >
> > > > > > > I pushed a new tree which builds without the warning. Note th=
at
> > > > > > > SPL_SPI is enabled.
> > > > > >
> > > > > > So, the "what" is FDT_64BIT wasn't correct. I think this is sho=
wing that
> > > > > > scripts/conf_nospl is going to be a problem in and of itself, a=
nd likely
> > > > > > as confusing if not more-so than any of the in-the-end visible =
changes.
> > > > >
> > > > > Yes, perhaps the key point I've been trying to get across is this=
 confusion.
> > > > >
> > > > > As you know, at present we have two types of options:
> > > > > a) those for which each phase has its own value
> > > > > b) those for which there is a single value shared across all phas=
es
> > > >
> > > > Agreed.
> > > >
> > > > > The only way today that you can tell them apart is by looking for=
 uses
> > > > > of CONFIG_IS_ENABLED() and $(PHASE_) with the option. If you see =
them,
> > > >
> > > > Partially agreed. Those are strong indicators that both CONFIG_FOO =
and
> > > > CONFIG_SPL_FOO exist, but not always. We have, intentionally, both =
the
> > > > inverse case (CONFIG_SPL_BAR and CONFIG_TPL_BAR exist, CONFIG_BAR d=
oes
> > > > not) and some future-proofing (CONFIG_SPL_BAZ may exist in the futu=
re,
> > > > but not yet).
> > >
> > > OK
> > >
> > > >
> > > > > then the option is a) otherwise it is b). There is no way to tell=
 from
> > > > > Kconfig.
> > > >
> > > > Kconfig will happily allow "depends on BOGUS_SYMBOL" yes, and a lin=
ter
> > > > would be a handy thing to have. But you're mentioning this in anoth=
er
> > > > context, why we need some additional knowledge somewhere.
> > >
> > > What I meant was that we don't have anything in the Kconfig for FOO
> > > that says this is a global option or an xPL-specific one. We have to
> > > hunt for SPL_FOO, etc.
> > >
> > > >
> > > > > Also, some parts of the code may use CONFIG_IS_ENABLED() for
> > > > > an option, some may use IS_ENABLED() for that same option. Some m=
ay
> > > > > use $(PHASE_) and some may not. It's a bit of a mess.
> > > >
> > > > I'm sure you can find some examples where we have CONFIG_IS_ENABLED=
(FOO)
> > > > and IS_ENABLED(CONFIG_FOO) and it's not intentional, but that's not=
 a
> > > > big deal, and should be fixed.
> > >
> > > But this is largely the point of my series. It's the reason why
> > > qconfig is able to locate these cases and warn about them. It is a big
> > > deal, IMO, or at least big enough for me to attempt this.
> > >
> > > >
> > > > I'm only going to rant slightly that checkpatch.pl telling people t=
o use
> > > > these macros has made the situation worse, not better, out of an
> > > > ingrained need to silence checkpatch.pl.
> > > >
> > > > And what you're missing is that sometimes we intentionally don't wa=
nt
> > > > $(PHASE_), or would need to rewrite the Makefile to make use of it.
> > > > fs/Makefile is an example of this.
> > >
> > > The next step from my side would be to get rid of the 'ifdef
> > > CONFIG_XPL_BUILD' in the Makefiles. It's confusing and annoying.
> > >
> > > >
> > > > > Stepping back a bit, perhaps the goal of my series is to identify
> > > > > options in b) so we can deal with them in a better way. They are =
all
> > > > > listed in conf_nospl, in preparation for some future action.
> > > >
> > > > There are two big problems here. The first of which is that conf_no=
spl,
> > > > as a concept, is going to be incomplete. Do you list every CMD in t=
here?
> > > > Why? They'll never be in a non-PPL phase. It will be its own nightm=
are
> > > > to keep correct, once it is bug-compatible with what we have today.
> > >
> > > This is actually the *nice* thing about conf_nospl. We should reduce
> > > it to empty, just like we did with the Kconfig whitelist.
> > >
> > > We have this rule:
> > >
> > > libs-$(CONFIG_CMDLINE) +=3D cmd/
> > >
> > > which is enough for most things. The only issue is that sometimes,
> > > e.g. with CONFIG_CMD_DHCP it doesn't mean the command at all.
> > >
> > > So I don't agree at all that my series is a 'big problem'. It is a
> > > solution to the current confusion and it shows up what is broken and
> > > needs to be fixed.
> > >
> > > >
> > > > The second big problem is that it doesn't make it any easier to sol=
ve
> > > > what I keep calling the DWC3 problem. It's a valid use case that two
> > > > developers have hit independently of wanting to enable USB gadget
> > > > support (and the HW uses DWC3) in SPL and not PPL. Not only are you=
 not
> > > > solving this problem, it gets worse to solve. Today it's "OK, I nee=
d to
> > > > find where to move obj-$(CONFIG_FOO) to be more visible and
> > > > obj-$(CONFIG_$(PHASE_)FOO". Tomorrow it's "Why isn't obj-$(CONFIG_F=
OO)
> > > > working here but not there?".
> > >
> > > Is that because some Makefile higher in the hierarchy is not building
> > > that subdir? I don't know what this is about.
> > >
> > > >
> > > > To me, at absolute best case here, we're making a lot of changes and
> > > > spending a lot of time to not really address the underlying problem=
s,
> > > > just making some questionable value visibility changes. We could re=
duce
> > > > ourselves to one macro by saying only ever use CONFIG_IS_ENABLED(FO=
O)
> > > > and IS_ENABLED(CONFIG_FOO) goes back to an ifdef for the case where=
 it
> > > > must only be tested on CONFIG_FOO.
> > >
> > > Or we could finish and apply my series, which does this.
> > >
> > > > I'm 80% sure we could simplify all of
> > > > $(PHASE_)/$(XPL_)/$(SPL_) down to just $(PHASE_) and that eliminate=
s the
> > > > which to use of those question.
> > >
> > > Again, let's apply my series, which actually gets rid of PHASE_, SPL_
> > > and XPL_ altogether.
> > >
> > > > And update / expand upon the existing
> > > > documentation we have as it's not clear enough for everyone. Then w=
e can
> > > > think, again, about how to solve the problems that are introduced by
> > > > building our entire source tree N times from a single configuration
> > > > file. Or if we need to do something radical there.
> > >
> > > At this point I'm getting the feeling that you imagine my series is
> > > some grand unified plan for Kconfig. It really isn't and this thread
> > > is reminding me of why I originally wrote it. Bear in mind it was over
> > > two years ago and I have mostly forgotten all the issues. It is a
> > > clean-up series. It isn't the second coming but it isn't the
> > > antichrist either.
> >
> > I worry you're going to spend another month of effort to get this to 1:1
> > compatibility (modulo fixing bugs) with what we have today and get
> > disappointed once it rolls out to -next. But I guess I've already spent
> > too much time trying to convince you this is a bad idea and that your
> > cure is worse than the disease.
>=20
> To me the core issue is whether to completely split the defconfig
> files. I am quite worried about that. You are quite worried about the
> confusion my series will cause.
>=20
> I think it is reasonable, if we go with my series, that I drive
> conf_nospl down to zero lines (and remove the feature) before going
> any further. Would that make you more comfortable? It would be a fair
> bit of work, but could be done over a few releases.

Here is my core concern. Can macros be tricky? Yes. Do we need a
checkpatch.pl test for 'IS_ENABLED(FOO)' ? Yes. But the real problem is
bugs like:
- Take pinebook-pro-rk3399_defconfig
- Enable all 3 of: CONFIG_SPL_USB_DWC3_GENERIC CONFIG_SPL_USB_GADGET
  CONFIG_SPL_USB_SDP_SUPPORT

Your proposal neither fixes that bug nor makes it easier to understand
why that bug happens. And this is the category of build problems that we
get that aren't "you missed using the right macro".

--=20
Tom

--O0HEE3b+BE3EX0Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme8l4AACgkQFHw5/5Y0
tywmewv/atNX+gVz7mqLid9JCaDDpWlhWoGdo5RiN46bdPwKpI0c9zIFMta5JfB5
I9uChKuLqK3qN24T++5yc0cLFucDM7Ydpkd4rg2icL1Hsm5vayR3cmi9hcN+EXUF
rUWAmPbWngswVaH/7cq/leBll+FJ6Eiz0nJYe+uIHLX6RVeOJhEB5JGTkndyFjsE
btLUVRhH+S5jyna7HxGmOZMPNMxKrNRgE7J6r86crWnaEtheoTF35Yz79wqGsl8A
b4J+xvTDNZ7i8qncVah2QQZGDcgSyO66CaKg9w20yMgrva1hJ/RMaV23x3K6GHrb
HZZnp3wI1s3XBTg6hNw6rjHu7hM4fQXUPrCYLQeMbsegaFK5yBovKxoxhPCrdUjF
o1JalWez6xAzWIkysk06KdMIMLYzri7cMFfaVIOxbabCQiJWk/ZKDhAncAppqKJU
ZE8K/H2r62IagZUtUlX2+ZnYfMko8CgWZ5Zxn67U/4COjNfCAfwKtPXRf1Q7cUjn
nu+iioGy
=F3Zy
-----END PGP SIGNATURE-----

--O0HEE3b+BE3EX0Fb--
