Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC65103A9A4
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 10:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B3783BC7;
	Wed, 25 Mar 2026 11:50:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="fQ56N0Vw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C93AD83CE3; Wed, 25 Mar 2026 11:50:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0FA008352B
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 11:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DD441CDD;
 Wed, 25 Mar 2026 03:50:04 -0700 (PDT)
Received: from localhost (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 542673F836;
 Wed, 25 Mar 2026 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1774435810; bh=uV1UvHSuI3tgbLFX2ZTV8n3+CVL2V4b7aAd0ZmdzjL8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fQ56N0VwZrfxEeZPauvTnvH5qqevK/jIaoJovEq9vPurR75vTGYNLwoXS3qbbeRRJ
 DYgjLWj1eXLvxcHh0LaPTrbckw7K2eTUhuSKUhN7bK4bdExrNitKuo7zzqkarRQd6Q
 qeTfDX0/hydFxVF1iLf4y/0RW7iO35fg1RC9/s6o=
Date: Wed, 25 Mar 2026 16:20:06 +0530
From: Sughosh Ganu <sughosh.ganu@arm.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 alif.zakuan.yuslaimi@altera.com, arturs.artamonovs@analog.com,
 daniel@makrotopia.org, duje@dujemihanovic.xyz, e@freeshell.de,
 hs@nabladev.com, ilias.apalodimas@linaro.org,
 jan.kiszka@siemens.com, l.anderweit@phytec.de, malysagreg@gmail.com,
 me@ziyao.cc, mkorpershoek@kernel.org, nathan.morrison@timesys.com,
 patrice.chotard@foss.st.com, paul.henrys_ext@softathome.com,
 peng.fan@nxp.com, raymondmaoca@gmail.com, sjg@chromium.org,
 stefan.roese@mailbox.org, sumit.garg@kernel.org,
 thomas.petazzoni@bootlin.com, trini@konsulko.com,
 u-boot@lists.denx.de, utsav.agarwal@analog.com,
 vasileios.bimpikas@analog.com, xypron.glpk@gmx.de, yangshiji66@outlook.com
Subject: Re: [PATCH v4 0/6] Add support for fwumdata
Message-ID: <acO93svFN3un3TfS@a079122.arm.com>
References: <20260223-feature_fwumdata-v4-0-680ea4ad6ce6@bootlin.com>
 <20260318112800.21578-1-dario.binacchi@amarulasolutions.com>
 <20260325112916.7000ec98@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325112916.7000ec98@kmaincent-XPS-13-7390>
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

On Wed, Mar 25, 2026 at 11:29:16AM +0100, Kory Maincent wrote:
> On Wed, 18 Mar 2026 12:27:54 +0100
> Dario Binacchi <dario.binacchi@amarulasolutions.com> wrote:
> 
> > Hi Kory,
> > 
> > Thanks for the series.
> > 
> > I have tested the fwumdata tool on a STM32MP257F-EV1 board using
> > metadata with banks containing 3 images, and everything works as
> > expected.
> > 
> > Tested-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> Thank you.
> 
> Ilias, Sughosh any new on this series?

All good from my side. Ilias, can you please send a PR from one of
your tree. Thanks.

-sughosh
