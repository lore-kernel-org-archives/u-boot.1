Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EEAC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 12:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4F3D82B70;
	Thu, 12 Jun 2025 14:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="D6zj7IIt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A5DA82B7C; Thu, 12 Jun 2025 14:59:17 +0200 (CEST)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0DF780050
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 14:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
 :Date:subject:date:message-id:reply-to;
 bh=N0+2hvFQJe+bdlK2bZrGM+0W4khvMIaKVJvaNvXSvTM=; b=D6zj7IItw4sfJnW9abYSBgyjqq
 wUg3ldd8LTzYT8hd+3S7EbBorMOPXtB71BUJVUJWNykvdvQ6ORdNGlMLT/2hs70EOPRTrlSDnLz6a
 u/J3b2aEZ5KGlq1hJEPTXY7KZvwYeoRjvN4bAbw8mjQ0LTRMztzXrN6PCTeZXyTKCKns=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:56764
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1uPhWR-0006r5-AM; Thu, 12 Jun 2025 08:59:12 -0400
Date: Thu, 12 Jun 2025 08:59:10 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de, Sven Dembiann
 <Sven.Dembianny@bshg.com>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Simon Holesch <simon.holesch@bshg.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>, Peng Fan
 <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Message-Id: <20250612085910.ec469b7d14b05b6bf8173ae7@hugovil.com>
In-Reply-To: <CAOMZO5As4Uxmunk4-LGFC71mR2mCZdJDYWtYk0wM565tpM1_wA@mail.gmail.com>
References: <20250520085436.925901-1-dario.binacchi@amarulasolutions.com>
 <20250520085436.925901-5-dario.binacchi@amarulasolutions.com>
 <CAOMZO5As4Uxmunk4-LGFC71mR2mCZdJDYWtYk0wM565tpM1_wA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH v3 4/5] board: bsh: imx8mn_bsh_smm_s2/s2pro: enlarge
 CONFIG_SPL_SYS_MALLOC_F_LEN
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

On Tue, 20 May 2025 09:11:26 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Hi Dario and Michael,
> 
> On Tue, May 20, 2025 at 5:55 AM Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
> >
> > The commit dda454e933c6 ("serial: mxc: Support bulk enabling clocks")
> > breaks the booting of the BSH SMM S2 board. The analysis of the issue
> > revealed memory allocation failures during the registration of UART4
> > clocks as well as other peripherals. Increasing SYS_MALLOC_F_LEN to
> > 0x10000 fixed the issue.
> >
> > Dropping this option allows it to be set to the default value of
> > CONFIG_SYS_MALLOC_F_LEN, which is set by default to 0x10000 on
> > i.MX8M platforms.
> >
> > Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> > (no changes since v1)
> >
> >  configs/imx8mn_bsh_smm_s2_defconfig    | 1 -
> >  configs/imx8mn_bsh_smm_s2pro_defconfig | 1 -
> >  2 files changed, 2 deletions(-)
> >
> > diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
> > index 1c11d4705419..206d216394db 100644
> > --- a/configs/imx8mn_bsh_smm_s2_defconfig
> > +++ b/configs/imx8mn_bsh_smm_s2_defconfig
> > @@ -15,7 +15,6 @@ CONFIG_SYS_MONITOR_LEN=524288
> >  CONFIG_SPL_SERIAL=y
> >  CONFIG_SPL_DRIVERS_MISC=y
> >  CONFIG_SPL_STACK=0x980000
> > -CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
> 
> Thanks for investigating this issue and getting to the root cause.
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> 
> I'm adding Hugo to the Cc as the imx8mn_var_som_defconfig target also
> uses CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000.
> 
> Hugo, please consider doing the same change on  imx8mn_var_som_defconfig.

Hi Fabio,
sorry for the late response.

Yes, I also ran into the same problem and manually set
CONFIG_SPL_SYS_MALLOC_F_LEN to 128kB, as was done in commit 
52472504e9c4 ("rockchip: rk3568: Fix alloc space exhausted in SPL").

I have now tested with the default value of 64kB (0x10000) by
removing CONFIG_SPL_SYS_MALLOC_F_LEN and it also works fine.

I will submit a patch for this.

Thank you,
Hugo.
