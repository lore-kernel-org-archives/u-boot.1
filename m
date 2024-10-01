Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91E3CEB2D0
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:19:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDDEC891C0;
	Tue,  1 Oct 2024 15:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E576891B3; Tue,  1 Oct 2024 14:11:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id F0CFB891A6
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CBCE339;
 Tue,  1 Oct 2024 05:11:40 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8B7E3F58B;
 Tue,  1 Oct 2024 05:11:04 -0700 (PDT)
Date: Tue, 1 Oct 2024 13:10:51 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, AKASHI
 Takahiro <akashi.tkhro@gmail.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>, Bin Meng
 <bmeng@tinylab.org>, Bryan Brattlof <bb@ti.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, =?UTF-8?B?Q3PDs2vDoXM=?= Bence
 <csokas.bence@prolan.hu>, Dragan Simic <dsimic@manjaro.org>, Eddie James
 <eajames@linux.ibm.com>, Hans de Goede <hdegoede@redhat.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>, Jesse Taube
 <mr.bossman075@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, Johan
 Jonker <jbx6244@gmail.com>, Julien Masson <jmasson@baylibre.com>, Kever
 Yang <kever.yang@rock-chips.com>, "Leon M. Busch-George"
 <leon@georgemail.eu>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek
 Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>, Peter
 Robinson <pbrobinson@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, Stefan Roese <sr@denx.de>, Sumit Garg
 <sumit.garg@linaro.org>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas.weissschuh@linutronix.de>, Tony Dinh <mibodhi@gmail.com>, Venkatesh
 Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v2 0/8] bootstd: sunxi: Migrate to standard boot
Message-ID: <20241001131051.5f72067d@donnerap.manchester.arm.com>
In-Reply-To: <CAFLszTjrxJA_ZmU-Uptb=kYJcvaXwCwNHg0MeGVW=DNUhPoSaw@mail.gmail.com>
References: <20240823204824.443631-1-sjg@chromium.org>
 <CAFLszTjrxJA_ZmU-Uptb=kYJcvaXwCwNHg0MeGVW=DNUhPoSaw@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 01 Oct 2024 15:19:18 +0200
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

On Tue, 1 Oct 2024 05:18:44 -0600
Simon Glass <sjg@chromium.org> wrote:

Hi,

> On Fri, 23 Aug 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
> >
> > This series attempts to migrate all sunxi boards to use standard boot,
> > along with a text environment.
> >
> > Changes in v2:
> > - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
> > - Put the FEL bootmeth before all other global bootmeths
> > - Convert the other DISTRO_DEFAULTS in the Kconfig too
> > - Keep BOOTCMD_SUNXI_COMPAT
> > - Keep bootcmd_sunxi_compat if OLD_SUNXI_KERNEL_COMPAT is enabled
> >
> > Simon Glass (8):
> >   blk: Make functions available unconditionally
> >   bootstd: Avoid calling unavailable block functions
> >   bootstd: Avoid depending on BLK
> >   sunxi: Add a bootmeth for FEL
> >   sunxi: Move to bootstd
> >   sunxi: Drop old distro boot variables
> >   env: Provide a work-around for unquoting fdtfile
> >   sunxi: Move to text environment
> >
> >  Makefile                                      |   1 +
> >  arch/arm/Kconfig                              |  10 +-
> >  board/sunxi/sunxi.env                         | 152 +++++++++++
> >  boot/Kconfig                                  |  16 +-
> >  boot/Makefile                                 |   1 +
> >  boot/bootdev-uclass.c                         |   3 +
> >  boot/bootmeth_fel.c                           |  81 ++++++
> >  .../gardena-smart-gateway-mt7688_defconfig    |   1 +
> >  doc/usage/environment.rst                     |  12 +
> >  include/blk.h                                 |   9 +-
> >  include/configs/sunxi-common.h                | 238 ------------------
> >  11 files changed, 278 insertions(+), 246 deletions(-)
> >  create mode 100644 board/sunxi/sunxi.env
> >  create mode 100644 boot/bootmeth_fel.c
> >
> > --
> > 2.34.1
> >  
> 
> I'm just checking on this series. Are there any comments, or can it be applied?

I gave it a rough look, and it seems like my gripes have been addressed
(many thanks for that!) Could you give me one more day for some testing on
actual boards, to see if everything still works?

Cheers,
Andre
