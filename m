Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD0EF4BB62
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 17:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D141C83642;
	Tue, 24 Feb 2026 18:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nd+xTGyZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A40EE83981; Tue, 24 Feb 2026 18:24:52 +0100 (CET)
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD05C82A9E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 18:24:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc42.google.com with SMTP id
 006d021491bc7-6786b13984fso3903894eaf.2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 09:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771953888; x=1772558688; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Drzi52zggqR19JsLciuLQeUFEFbVAI4g2ZLKI27iBWI=;
 b=Nd+xTGyZYQzHbD17TuJnJ9/OTvHfI8ofJhMJt6HcbLBsddUkTXbE7F2Ub/o5otbJ3/
 vuFSc6BtbNAzh8gxC8GqcJgMwfR9XoLbC0Vuaz7qjGdkemcLTBuELN8J+XjXIpymXE8/
 sfE29pGBToZv7ALniSNj6irZoI53uO93OGJ7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771953888; x=1772558688;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Drzi52zggqR19JsLciuLQeUFEFbVAI4g2ZLKI27iBWI=;
 b=TdxkIeH5FjCSteaGRpG/Ry+bxRfS9o1DXy+bDGAeTME8tjespVoh41iPyKBJkkdbAM
 kChrB1YzmQop+QoZtIT8wIqeaFNZoZjmfcRKJAAyMH4SKuFnxfF5cpDcyVZL1jTjVC8C
 5HjlXOGXATtRUqogydAKAdAKJHsbaF9QiljZks7s87NcZNDmbxgF6r3OqqtPWH0TbCJ7
 WLYG1L7sGYzd7KDWntoLkAqnGKDlgG2N81DBvg5Y+60pe/nkpx2AIDnGPbpAlsnaoRws
 VP8xzi1OGTjibIqYmzWSfaFznpxBHREzB9XZcDeAw02+S1U7ybK2b0MXYzgzQvXLPwyC
 rnJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7fm8wA51YJ/48QP3uB+dJ5BRsZI4Dx/4UT0GMT5Ew6xRz4TAqAQQDl1WkApeN+wq+zVvRFb8=@lists.denx.de
X-Gm-Message-State: AOJu0YypDKn7Gjd9n7R1mVl3CWUG48o/lnOWV0VgQG9J/2gteoKDii+/
 GBgIzexJn2CasID+qPCiHEqRMAyb3VvixTGBrggxgFolBh9Tp2Aw4uD6rfOED9ojucM=
X-Gm-Gg: AZuq6aI2iCoRcGqFqda/f0wdWs536xuH3q+muZrrHSDCbbvINRJMpDZQlzIfEd/976M
 RBkrby0XcTtxFUXL7TeOLxWCYbxaOPfB53IahZ8kQt3ovEZElHOK0GnocAEFnVbiFs5ADhhj1OI
 i6nez7lOiQyxyu31k5SQFuf0Zu1QMu3Lhwecrr28WvDyCm5qMHV9CUfxV8KsSr1QKInmudrMm2p
 Zht/8JIGIwpTH24+62Fd1hC9cQq3V0xaet+xLDk9iFKCqGPvPn8VmPrjdC+zqWA4YIlbPyR9uiM
 IqBhpg5QR58UPz4lbixVuCYxY/tRLun2i8fi9xbPkQBvye4C2KYiKgI8Z4gIz2arxiYbhAfU0FG
 2z1ayeaTPWt/RGgKoH+n4djqQuyoFTTsMohtg+xG34rpyZojb76+ZcoPW87weZKGRJulkM1Ijpo
 9N/caWYt4MnjQZpOdasQFokte8IYfGnRi1xhPJEk2E3U3IDngT911+GkZ3s0sjFP073Hs4ogfHK
 LB123NXdblgfTRxcwtb2VtWRtzZjXSmHlSG8hm7HJJAXGAkI/8=
X-Received: by 2002:a05:6820:162b:b0:664:85db:66bf with SMTP id
 006d021491bc7-679c4709218mr6750343eaf.66.1771953888196; 
 Tue, 24 Feb 2026 09:24:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679c5630a56sm9251843eaf.1.2026.02.24.09.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 09:24:47 -0800 (PST)
Date: Tue, 24 Feb 2026 11:24:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand
 FIT loading
Message-ID: <20260224172444.GA3233182@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <20260217174617.GD2747538@bill-the-cat>
 <20260223193219.GF3233182@bill-the-cat>
 <aZ2SI0rKuMEgSq1F@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z8MEdNvOpmbKHoGG"
Content-Disposition: inline
In-Reply-To: <aZ2SI0rKuMEgSq1F@makrotopia.org>
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


--z8MEdNvOpmbKHoGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 11:57:23AM +0000, Daniel Golle wrote:
> On Mon, Feb 23, 2026 at 01:32:19PM -0600, Tom Rini wrote:
> > On Tue, Feb 17, 2026 at 11:46:17AM -0600, Tom Rini wrote:
> > > On Mon, Feb 16, 2026 at 09:21:14PM +0000, Daniel Golle wrote:
> > >=20
> > > > Hi all,
> > > >=20
> > > > This RFC series adds a new boot method for OpenWrt's "uImage.FIT wi=
th
> > > > embedded rootfs" firmware model, along with the underlying infrastr=
ucture
> > > > to load FIT images on-demand directly from storage devices without =
copying
> > > > them entirely to RAM first.
> > > [snip]
> > > > AI tool disclosure
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >=20
> > > > Major parts of this series were developed with assistance from GitH=
ub
> > > > Copilot (Claude Opus 4.6, Anthropic). The AI was used as a coding
> > > > partner for scaffolding boilerplate, drafting documentation and com=
mit
> > > > messages, running checkpatch sweeps, and iterating on review feedba=
ck.
> > > > All architectural decisions, U-Boot subsystem integration, hardware
> > > > testing, and final review were done by the human author. Every line=
 of
> > > > code was reviewed and tested on real hardware before inclusion.
> > >=20
> > > First, I appreciate your honesty and explanation in the disclosure he=
re.
> > >=20
> > > This topic comes up, and will keep coming up, and as a project we have
> > > not yet decided on a position. I know that the Linux Kernel has come =
up
> > > with:
> > > https://docs.kernel.org/next/process/generated-content.html
> > > so far. But I think that:
> > > https://docs.postmarketos.org/policies-and-processes/development/cont=
ributing-and-ai.html
> > > brings up points that are quite relevant too. Absolutely no one has b=
een
> > > happy with when gitlab or patchwork were unusable / unreachable (and =
for
> > > some people are still unusable) but it's because of all the AI scrape=
rs
> > > that things were unusable or now have anubis in front of them (blocki=
ng
> > > other humans now).
> > >=20
> > > With that said, I want to stress the "human is responsible" portion of
> > > what both links say, and that given where exactly these changes are
> > > aimed for, extra scrutiny is required. Things like:
> > > https://cyberplace.social/@GossiTheDog/116080909947754833
> > > show just how bad they are about introducing security bugs these days.
> >=20
> > Following up on this part I suppose, I see in CI you're working on v2
> > but please make sure to follow up with the other outstanding questions
> > I've asked before posting that. Thanks!
>=20
> I've carefully reiterated over all your emails regarding the series and
> my replies to them. Apart from your request to share an image making use
> of the proposal to include dm-verity parameters in uImage.FIT (and use
> the presence to decide whether has varifications of that subimage may be
> skipped) I haven't found anything which hasn't been answered. But maybe
> I missed something, of course.

There's:
https://lore.kernel.org/u-boot/20260217150820.GB2747538@bill-the-cat/
And I see you're using CI, but I didn't see an ack about the size
investigations portion.

There's:
https://lore.kernel.org/u-boot/20260217192000.GH2747538@bill-the-cat/
And I didn't see anything about that.

There's:
https://lore.kernel.org/u-boot/20260217190554.GF2747538@bill-the-cat/
https://lore.kernel.org/u-boot/20260219153100.GL3233182@bill-the-cat/
Which go together and I think "human written only commit message" might
well be a good policy as it helps ensure the patch in question has been
read and summarized by the human author (and enforcement is on the
honor system).

Finally there's:
https://lore.kernel.org/u-boot/20260217191536.GG2747538@bill-the-cat/
where I was hoping for more feedback.

I don't recall if we came to a conclusion, or just look again later,
about if we should have this functionality both exposed via "bootm" and
the new distro bootmeth, or not. It might be "talk more" and I'm leaning
currently on saying the migration path is something openwrt holds
downstream while getting things migrated?

And in sum, this series will need to be split up a bit I strongly
suspect. Being clear about the end goal is good but implementing each of
the backends as well in a single series will make this too large to
review.

--=20
Tom

--z8MEdNvOpmbKHoGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ3e2AAKCRAr4qD1Cr/k
CsuxAQCy/uhSo6DRfWYhF4vzkSGr7nr/5prH50qj/U2LmIxS/wEAle1i2YWE66D+
7k4lLQBPS/rCR7OHhuWd/gNwLB1jLgA=
=JYLj
-----END PGP SIGNATURE-----

--z8MEdNvOpmbKHoGG--
