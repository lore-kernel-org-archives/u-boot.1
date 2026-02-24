Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EE9E9B24E
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 11:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCEFB83642;
	Tue, 24 Feb 2026 12:57:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5C0883BC9; Tue, 24 Feb 2026 12:57:55 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D64782BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 12:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vur2d-000000004ii-3For; Tue, 24 Feb 2026 11:57:27 +0000
Date: Tue, 24 Feb 2026 11:57:23 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>
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
Message-ID: <aZ2SI0rKuMEgSq1F@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <20260217174617.GD2747538@bill-the-cat>
 <20260223193219.GF3233182@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223193219.GF3233182@bill-the-cat>
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

On Mon, Feb 23, 2026 at 01:32:19PM -0600, Tom Rini wrote:
> On Tue, Feb 17, 2026 at 11:46:17AM -0600, Tom Rini wrote:
> > On Mon, Feb 16, 2026 at 09:21:14PM +0000, Daniel Golle wrote:
> > 
> > > Hi all,
> > > 
> > > This RFC series adds a new boot method for OpenWrt's "uImage.FIT with
> > > embedded rootfs" firmware model, along with the underlying infrastructure
> > > to load FIT images on-demand directly from storage devices without copying
> > > them entirely to RAM first.
> > [snip]
> > > AI tool disclosure
> > > ==================
> > > 
> > > Major parts of this series were developed with assistance from GitHub
> > > Copilot (Claude Opus 4.6, Anthropic). The AI was used as a coding
> > > partner for scaffolding boilerplate, drafting documentation and commit
> > > messages, running checkpatch sweeps, and iterating on review feedback.
> > > All architectural decisions, U-Boot subsystem integration, hardware
> > > testing, and final review were done by the human author. Every line of
> > > code was reviewed and tested on real hardware before inclusion.
> > 
> > First, I appreciate your honesty and explanation in the disclosure here.
> > 
> > This topic comes up, and will keep coming up, and as a project we have
> > not yet decided on a position. I know that the Linux Kernel has come up
> > with:
> > https://docs.kernel.org/next/process/generated-content.html
> > so far. But I think that:
> > https://docs.postmarketos.org/policies-and-processes/development/contributing-and-ai.html
> > brings up points that are quite relevant too. Absolutely no one has been
> > happy with when gitlab or patchwork were unusable / unreachable (and for
> > some people are still unusable) but it's because of all the AI scrapers
> > that things were unusable or now have anubis in front of them (blocking
> > other humans now).
> > 
> > With that said, I want to stress the "human is responsible" portion of
> > what both links say, and that given where exactly these changes are
> > aimed for, extra scrutiny is required. Things like:
> > https://cyberplace.social/@GossiTheDog/116080909947754833
> > show just how bad they are about introducing security bugs these days.
> 
> Following up on this part I suppose, I see in CI you're working on v2
> but please make sure to follow up with the other outstanding questions
> I've asked before posting that. Thanks!

I've carefully reiterated over all your emails regarding the series and
my replies to them. Apart from your request to share an image making use
of the proposal to include dm-verity parameters in uImage.FIT (and use
the presence to decide whether has varifications of that subimage may be
skipped) I haven't found anything which hasn't been answered. But maybe
I missed something, of course.

As it is difficult to share large binaries without paying for hosting or
exposing my home router public IP address to a public mailing list I
have sent a decompiled FIT header. If you would like me to share an
actual image (or even the whole SD card image for the BPi-R3, or images
for the OpenWrt One), please contact me off-list and I shall find a way
to share the binaries with you.
