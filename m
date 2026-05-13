Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CCBCD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 12:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA30684099;
	Wed, 13 May 2026 14:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 735BA845E3; Wed, 13 May 2026 14:13:30 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C5AB836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 14:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wN8SZ-000000005Fg-1oQK; Wed, 13 May 2026 12:13:07 +0000
Date: Wed, 13 May 2026 13:13:01 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 5/8] doc: fit: add dm-verity boot parameter
 documentation
Message-ID: <agRqzY-Ya9g36xP7@makrotopia.org>
References: <cover.1778637233.git.daniel@makrotopia.org>
 <731b6abb01956fa028697aad167e6f705b187ecd.1778637233.git.daniel@makrotopia.org>
 <489A2B5F-17AB-4220-AEEF-705C544F973D@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <489A2B5F-17AB-4220-AEEF-705C544F973D@gmx.de>
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

On Wed, May 13, 2026 at 06:13:14AM +0200, Heinrich Schuchardt wrote:
> Am 13. Mai 2026 04:09:29 MESZ schrieb Daniel Golle <daniel@makrotopia.org>:
> >Add documentation for CONFIG_FIT_VERITY which allows U-Boot to
> >construct dm-mod.create= and dm-mod.waitfor= kernel command-line
> >parameters from dm-verity metadata embedded in FIT filesystem
> >sub-images.
> >
> > [...]
> >
> >+Prerequisites
> >+-------------
> >+
> >+* **Linux uImage.FIT block driver** – the kernel must include the FIT block
> >+  driver that exposes loadable sub-images as ``/dev/fit0``, ``/dev/fit1``,
> 
> 
> The dtb file format of FIT images only guarantees 4 byte alignment. Does that match with the requirement of file-system drivers including dma access if the FIT is for example on eMMC? Or do we need a mechanism to enforce higher alignment in FIT images?

The fitblk driver requires the 'filesystem' image to start and end on block
boundaries of the underlying block device. As the 'filesystem' image is
outside of the FIT structure itself (external data) this can be achieved
by having `mkimage -E -B 0x1000`.

This is a restriction of the current implementation of the fitblk
driver to avoid the complexity (and computation overhead) which comes
with unaligned access (a lot of memcpy, basically...). Future
implementations may no longer have that restriction, while of course
performance will always slightly suffer from the image not being
aligned with the block size of the lower device.

Hence I consider this current resitriction something to be documented along
with the fitblk driver, and outside of the scope of what U-Boot itself is
involved with.
