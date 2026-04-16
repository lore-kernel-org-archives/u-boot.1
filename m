Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB214F8E48C
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 23:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51B3F83FC0;
	Fri, 17 Apr 2026 01:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A520F8407E; Fri, 17 Apr 2026 01:26:13 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B2D83EEF
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 01:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wDW5n-000000006tD-2pI3; Thu, 16 Apr 2026 23:25:51 +0000
Date: Fri, 17 Apr 2026 00:25:47 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 David Lechner <dlechner@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Jonas Karlman <jonas@kwiboo.se>, Shiji Yang <yangshiji66@outlook.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 6/7] test: boot: add runtime unit test for
 fit_verity_build_cmdline()
Message-ID: <aeFv-xm5MZ44W3Yn@makrotopia.org>
References: <cover.1776302805.git.daniel@makrotopia.org>
 <97e38b81f2e8f54ec819940d360849e4cf61b875.1776302806.git.daniel@makrotopia.org>
 <CAFLszTgazuTSYbidfn7Q1gEiE1RG2YVkj2Vz9L6fN49QE0bdUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgazuTSYbidfn7Q1gEiE1RG2YVkj2Vz9L6fN49QE0bdUA@mail.gmail.com>
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

On Fri, Apr 17, 2026 at 07:36:37AM +1200, Simon Glass wrote:
> Hi Daniel,
> 
> On 2026-04-16T01:46:15, Daniel Golle <daniel@makrotopia.org> wrote:
> > test: boot: add runtime unit test for fit_verity_build_cmdline()
> >
> > Add test/boot/fit_verity.c with four tests that construct FIT blobs
> > in memory and exercise fit_verity_build_cmdline().
> >
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> >
> > test/boot/Makefile     |   1 +
> >  test/boot/fit_verity.c | 302 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  test/cmd_ut.c          |   2 +
> >  3 files changed, 305 insertions(+)
> 
> > diff --git a/test/boot/fit_verity.c b/test/boot/fit_verity.c
> > @@ -0,0 +1,302 @@
> > +             ret = fdt_setprop_string(buf, verity_node, "algo", "sha256");
> > +             val = cpu_to_fdt32(4096);
> > +             ret = fdt_setprop(buf, verity_node, "data-block-size",
> 
> Please can you use the FIT_VERITY_*_PROP constants from
> include/image.h instead of literal strings? See test/image/spl_load.c
> for an example.

Sure, I'll change that.

I was deliberately not doing it so the test code is as self-contained
as possible.
