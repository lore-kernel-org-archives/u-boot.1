Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD8AC87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 14:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0818E839A1;
	Fri, 25 Jul 2025 16:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="KScte3+T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C57D839B5; Fri, 25 Jul 2025 16:42:32 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D2428398B
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 16:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 12FBE14846E2; Fri, 25 Jul 2025 16:42:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1753454548; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=tDXD/mTFNSd8EOC3NVbhdZvV/n1tY5aNuVHe952bYZU=;
 b=KScte3+T6uW/kSHbej498c8btTIW5ZnA8Kj2clq1hDWsw/8SZJ/yYFfB9Lww1Z2Az2aEb5
 SEXWPQa0xpZk11QsvvzmYGwzpl3yt3ealX8+Czb8L7KHrn4H5mPFDPcwnnDi6CpbZh5b4K
 9y25Asd1HAN5n+vPxamff2zhlyh+7W8OqNmfqcGyJxRtVJpCKkNAofSTaaYtQ/53EWVFdf
 JbZZ5OLsG7acM+4sJJgmM8kci60h8L4rsD8x7uZCoC11R69lhyumCGGEmy4QEmR5IAmh6o
 KsVksiUeTkxbydCp5Id0KQA/mhG10R0SMgMa/wqpOL4dJ+xA+SxF2Vc6Kv7evw==
Date: Fri, 25 Jul 2025 16:42:23 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de, git@xilinx.com, p.bruenn@beckhoff.com,
 Alexander Graf <agraf@csgraf.de>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH 0/3] fpga: Remove lattice and ACEX1 support
Message-ID: <20250725-gleeful-citadel-7a5ce2daa2ae@thorsis.com>
Mail-Followup-To: Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com, p.bruenn@beckhoff.com,
 Alexander Graf <agraf@csgraf.de>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
References: <cover.1753442748.git.michal.simek@amd.com>
 <20250725-residence-stingray-818201348f2f@thorsis.com>
 <5d481eb2-801e-4771-93b8-e2c6877df4d6@amd.com>
 <20250725140035.GD1807455@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725140035.GD1807455@bill-the-cat>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Tom,

Am Fri, Jul 25, 2025 at 08:00:35AM -0600 schrieb Tom Rini:
> On Fri, Jul 25, 2025 at 02:03:12PM +0200, Michal Simek wrote:
> > 
> > 
> > On 7/25/25 14:00, Alexander Dahl wrote:
> > > Hello Michal,
> > > 
> > > Am Fri, Jul 25, 2025 at 01:25:51PM +0200 schrieb Michal Simek:
> > > > Hi,
> > > > 
> > > > when fpga drivers were enabled via sandbox some coverity issues came and
> > > > make no sense to fix them when there is no user of these drivers that's why
> > > > it is easier just remove them completely.
> > > > 
> > > > Another candidate for removal is FPGA_CYCLON2 which is enabled only by
> > > > mx53cx9020_defconfig.
> > > 
> > > We use FPGA_CYCLON2 downstream with devices containing Altera Cyclone
> > > III and IV or Efinix Trion T20 chips.  These are _not_ legacy devices,
> > > few quantities per year, but still produced and sold.
> > > 
> > > If you need board code to keep the upstream support, I would need
> > > to talk to some people here if we can upstream our board code, or at
> > > least some of it.  That might be difficult though, so if there are
> > > alternatives, please advise.  O:-)
> > 
> > CYCLON2 is enabled in one board that's why it is fine until that board is around.
> 
> Heck, we can just leave it on for sandbox *but* that does mean someone
> needs to step up to maintain the driver part. The report is at
> https://lore.kernel.org/u-boot/20250725132645.GA1807455@bill-the-cat/
> and it's that there's some dead code. 

I can look into that report and at the generic fpga code, or at least
some of it, maybe next week.

> It's also been not quite 3 years
> since the last "real" change made to the driver by you, so are there any
> other general fixes / improvements that should be upstreamed? Thanks!

Just looked into my patch stack again, there are only two things which
are not board code:

1. return value wrapping in cmd/fpga.c which I submitted as a patch
some years ago, was denied back then.

2. a generic dm driver for passive serial configuration over spi.
upstreaming that driver would make sense together with some board code
using it. ;-)

Which means: I sent patches for everything which is not board code,
and most of them were accepted. :-)

Greets
Alex

