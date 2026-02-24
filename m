Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73529E9B25F
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 12:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D20083642;
	Tue, 24 Feb 2026 13:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 025DA83BC9; Tue, 24 Feb 2026 13:41:44 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B25982BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 13:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vuris-000000004ux-03lG; Tue, 24 Feb 2026 12:41:06 +0000
Date: Tue, 24 Feb 2026 12:41:02 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
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
Subject: Re: [RFC PATCH 09/20] boot: fit: support on-demand loading in
 fit_image_load()
Message-ID: <aZ2cXgp4zah9Ko2E@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <ab7837536e4567b90d7cb662984dd7e637ef4361.1771275704.git.daniel@makrotopia.org>
 <CAFLszTi3r_6VynzrZKkDNbcucntoEW=4nLCV_q8kv3+vQojLBg@mail.gmail.com>
 <aZc-tSa3jkduf9aJ@makrotopia.org>
 <CAFLszTi_2pnkayQyCTayOqfJCwMcvdxzY72JenWJij1ZksRGuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTi_2pnkayQyCTayOqfJCwMcvdxzY72JenWJij1ZksRGuQ@mail.gmail.com>
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

On Mon, Feb 23, 2026 at 10:51:07AM -0700, Simon Glass wrote:
> On Thu, 19 Feb 2026 at 09:48, Daniel Golle <daniel@makrotopia.org> wrote:
> > [...]
> > Yes, I agree with that. A single property won't be enough, so what I
> > came up with and currently test is a node under the image, ie.
> >
> > dm-verity {
> >         block-size = <0x1000>;
> >         data-blocks = <0xdead>;
> >         algo = "sha256";
> >         root-hash = "averylonghashasstring";
> >         salt = "anotherverylonghashasstring";
> > };
> >
> > This is sufficient to then let U-Boot generate the dm-mod.create="..."
> > parameter handed over to the kernel.
> >
> > Currently I'm just putting this in the its source file, but of course we
> > could also extend 'mkimage' to call 'veritysetup format ...' and
> > populate such section like it is done for the hashes.
>
> Yes this looks very nice to me. Don't forget a PR for the FIT spec too.

https://github.com/open-source-firmware/flat-image-tree/pull/37

I hope this is the correct repo. There are quite a few open PR there
which seemingly nobody has ever looked at, all of them opened by the
same user (@sjg20), one of them open for more than 3 years (#5).
They all look very useful too...
