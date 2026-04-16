Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94837F8E48C
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 22:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09B9B83FC0;
	Fri, 17 Apr 2026 00:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD6B8407E; Fri, 17 Apr 2026 00:59:19 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5130183EEF
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 00:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wDVfc-000000006lY-3AeT; Thu, 16 Apr 2026 22:58:48 +0000
Date: Thu, 16 Apr 2026 23:58:45 +0100
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
Subject: Re: [PATCH v2 7/7] test: py: add mkimage dm-verity round-trip test
Message-ID: <aeFppbCsfKNDTWuC@makrotopia.org>
References: <cover.1776302805.git.daniel@makrotopia.org>
 <9ceb70fcad4dec6efae1b03297f38665926b6c9f.1776302806.git.daniel@makrotopia.org>
 <CAFLszThhPE9SPOHhjcukPUDsg4Yf+GtPhVWeHdsnKCQE1ysOSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThhPE9SPOHhjcukPUDsg4Yf+GtPhVWeHdsnKCQE1ysOSg@mail.gmail.com>
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

On Fri, Apr 17, 2026 at 07:36:17AM +1200, Simon Glass wrote:
> Hi Daniel,
> 
> On 2026-04-16T01:46:15, Daniel Golle <daniel@makrotopia.org> wrote:
> > test: py: add mkimage dm-verity round-trip test
> >
> > Add test/py/tests/test_fit_verity.py with two tests.
> >
> > Both tests are skipped if veritysetup is not installed on the host.
> >
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> >
> > test/py/tests/test_fit_verity.py | 153 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 153 insertions(+)
> 
> > diff --git a/test/py/tests/test_fit_verity.py b/test/py/tests/test_fit_verity.py
> > @@ -0,0 +1,153 @@
> > +import struct
> 
> The struct import seems to be unused.
> 
> > diff --git a/test/py/tests/test_fit_verity.py b/test/py/tests/test_fit_verity.py
> > @@ -0,0 +1,153 @@
> > +def have_veritysetup():
> > +    return shutil.which('veritysetup') is not None
> > +
> > +
> > +@pytest.mark.requiredtool('dtc')
> > +@pytest.mark.requiredtool('fdtget')
> > +@pytest.mark.skipif(not have_veritysetup(),
> > +                    reason='veritysetup not installed')
> > +def test_mkimage_verity(ubman):
> 
> The test infrastructure supports
> @pytest.mark.requiredtool('veritysetup') which handles the skip
> message consistently. That also means you can drop the
> have_veritysetup() helper.

I have to admit that Python is not one of my strengths...
I'll try to figure it out and address this in v3.
