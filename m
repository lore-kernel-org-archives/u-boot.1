Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D988CEBF61
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 01:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 795E983B99;
	Tue, 18 Nov 2025 02:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E8A283C16; Tue, 18 Nov 2025 02:20:32 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C13D483B91
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:20:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id DB1DE340B29;
 Tue, 18 Nov 2025 01:20:26 +0000 (UTC)
Date: Tue, 18 Nov 2025 09:20:22 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 04/11] sunxi: a733: uart: setup serial console
Message-ID: <20251118012022-GYC1719757@gentoo.org>
References: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
 <20251116-01-a733-soc-support-v1-4-fb4c8db78e75@gentoo.org>
 <20251118005608.1361184b@minigeek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118005608.1361184b@minigeek.lan>
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

Hi Andre,

On 00:56 Tue 18 Nov     , Andre Przywara wrote:
> On Sun, 16 Nov 2025 14:43:55 +0000
> Yixun Lan <dlan@gentoo.org> wrote:
> 
> > Setup correct UART base address for A733 SoC.
> > 
> > According to Allwinner's board design, A733 SoC use the UART0 port
> > for serial console, so config PB9-10 pins to setup pinmux.
> > 
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > ---
> >  arch/arm/include/asm/arch-sunxi/serial.h | 2 +-
> >  arch/arm/mach-sunxi/board.c              | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/arch-sunxi/serial.h b/arch/arm/include/asm/arch-sunxi/serial.h
> > index 9386287b65e..57b62ac8c7e 100644
> > --- a/arch/arm/include/asm/arch-sunxi/serial.h
> > +++ b/arch/arm/include/asm/arch-sunxi/serial.h
> > @@ -17,7 +17,7 @@
> >  #elif defined(CONFIG_MACH_SUNIV)
> >  #define SUNXI_UART0_BASE		0x01c25000
> >  #define SUNXI_R_UART_BASE		0
> > -#elif defined(CONFIG_SUNXI_GEN_NCAT2)
> > +#elif defined(CONFIG_SUNXI_GEN_NCAT2) || defined(CONFIG_MACH_SUN60I_A733)
> 
> Just using this as an example: Have you checked how much it would take
> to declare the A733 as a GEN_NCAT2? My feeling is that a lot of the
> code that GEN_NCAT2 guards would be applicable to the A733 as well,
> since it's mostly about the updated basic design and memory map, which
> the A733 mostly inherited. I mean in this case this whole patch could
> go away.
> 
> If there are exceptions, you could handle them like:
> #elif defined(CONFIG_MACH_SUN60I_A733)
> .... A733 specific definitions ...
> #elif defined(CONFIG_SUNXI_GEN_NCAT2)
> .... existing NCAT2 definitions ....
> #endif
> 
Ok, I thought above this, but wasn't sure..

I will take your advice and update the patch accordingly next time:
 using CONFIG_MACH_SUN60I_A733 to override if there is exceptions

Thanks
-- 
Yixun Lan (dlan)
