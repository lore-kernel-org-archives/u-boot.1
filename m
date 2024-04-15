Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B248C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C229E88190;
	Mon, 15 Apr 2024 08:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="FjtKxTUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78A9F88190; Mon, 15 Apr 2024 08:13:41 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20AD487B1A
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A765B148CE80; Mon, 15 Apr 2024 08:13:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1713161614; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=vYJN46gomF1fe8DrLkIUuq5muiXoU6HefrZ8vGFWwUI=;
 b=FjtKxTUZxIl4OFW581+QeCXNIFjh+Ke8sw4qPaFdgW3kP31Uqcy/3eKrGOctvoEnk4uimO
 Ystec+onh9NBtpy40+0/eT7KGdTz/5hHTojqToyz78Rl3l+q4uEJvMJrYddTUQUGbMWZux
 ePiQD6/auCdsn+XQfjXF9P90J3+JQfO+UXUFOlyKLx/JG554PPq0hTwoqRVzjT1rfXgjLg
 gsiDSfXT3875g92qqzQSNfn5xfKtI7NFWY4LJ4fEGY76YAcevGS++B71+Z5y/74PBdz0Vd
 1tS0OR89uQc3mzdAfU0WxiqCuIWSGItL6+GyygxqjD4B2Way9abxmdF9lnDg6w==
Date: Mon, 15 Apr 2024 08:13:25 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Alexander Dahl <ada@thorsis.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Mihai Sain <mihai.sain@microchip.com>,
 Li Bin <bin.li@microchip.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/6] mtd: nand: raw: Collected improvements
Message-ID: <20240415-fruit-theorize-e06b014a60cd@thorsis.com>
Mail-Followup-To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Mihai Sain <mihai.sain@microchip.com>,
 Li Bin <bin.li@microchip.com>, u-boot@lists.denx.de
References: <20240320090214.40465-1-ada@thorsis.com>
 <CABGWkvrF3UxEzw2eh1kb7To+aQ8iaWMyrnU8Qz0tYJGumY0QGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABGWkvrF3UxEzw2eh1kb7To+aQ8iaWMyrnU8Qz0tYJGumY0QGw@mail.gmail.com>
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

Hello Dario,

Am Sun, Apr 14, 2024 at 03:41:38PM +0200 schrieb Dario Binacchi:
> Hi Alexander,
> 
> On Wed, Mar 20, 2024 at 10:02 AM Alexander Dahl <ada@thorsis.com> wrote:
> >
> > Hello everyone,
> >
> > while working on NAND flash support for a custom board based on the at91
> > SAM9X60 SoC I stumbled over some issues in the raw nand subsystem.
> >
> > Four of six patches are minor fixes.
> >
> > Patch 4 introduces a new subcommand for the new atmel nand controller
> > driver.  Patch 6 introduces a new subcommand for the nand command to
> > override ONFI timing mode.  Both are are for debugging purposes only and
> > thus optional, and need to be enabled through menu.  Both helped me a
> > lot when investigating issues.
> >
> > Series is based on upstream next branch, but should also apply to master
> > cleanly.
> >
> > Greets
> > Alex
> >
> > v1:
> >
> > Link: https://lore.kernel.org/u-boot/20240307091014.39796-1-ada@thorsis.com/T/#t
> >
> > v2:
> >
> > - rebased on recent next
> > - collected tags
> > - improved patch 4 after feedback from Mihai
> > - added new patch 5 with another help text fix
> > - added new patch 6 with a new debug command
> > - reworded cover letter
> >
> > See per patch changes in patches for more detailed changes.
> >
> > Alexander Dahl (6):
> >   mtd: nand: raw: Use macro nand_to_mtd() where appropriate
> >   mtd: nand: raw: Port another option flag from Linux
> >   mtd: nand: raw: Fix (most) Kconfig indentation
> >   mtd: nand: raw: atmel: Introduce optional debug commands
> >   mtd: nand: raw: atmel: Fix comment in timings preparation
> >   cmd: nand: Add new optional sub-command 'onfi'
> >
> >  cmd/Kconfig                                  |  10 +
> >  cmd/nand.c                                   |  61 ++++
> >  drivers/mtd/nand/raw/Kconfig                 | 115 +++----
> >  drivers/mtd/nand/raw/atmel/nand-controller.c | 299 ++++++++++++++++++-
> >  drivers/mtd/nand/raw/nand_base.c             |   8 +-
> >  include/linux/mtd/rawnand.h                  |   8 +
> >  6 files changed, 441 insertions(+), 60 deletions(-)
> >
> >
> > base-commit: f048104999db28d49362201eaebfc91adb14f47c
> > --
> > 2.39.2
> >
> Applied to nand-next the first 4 patches.
> For the others, we will conduct further testing before applying them.

Thanks so far.  :-)

I have another fix for the atmel raw nand driver, which I forgot to
send with this series.  I could add it to v3.  Or should I send it
separately?

Greets
Alex
