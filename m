Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893A5CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 15:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B905F87FAC;
	Tue,  2 Apr 2024 17:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="RiqGyat5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6D1B87E78; Tue,  2 Apr 2024 17:38:52 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F12C988153
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 17:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1712072330;
 bh=cTjgyr03ZNbYYTI9wLY6y5aKQUuR0Pa6YL/tGUPIgVk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RiqGyat5wspHhdruoXv+tCxRKYPGnhI2SNR1davR/X3UPNd/a3XzmQo0ZSsDCnbFh
 o2oBc5k2TFZmb/9KEColRJHTmAGERZ1Ff2dxLjSVihY/j5Hw9pp+R9ODQBxKoC3whT
 exS4fJupRrqLd+h3mgapkIct1fTH+CL7KwkPMKLeVzj9bozxZXGP0aFYQKvIvakA9g
 BgKuVZb0r6bI1L7vKT9D3KheLe0TqZGTgGeIIsv5OeFok0ixVgqC6I/Xaa3Q4sdM2y
 IOzIsuOcrYCyJLnG8Bgypep9dBBaAkRCRw4Qy9Z+5oCHzJaNsyDsN2nZ36U2QReSCs
 rpKL5KA6CQ2KA==
Received: from arisu.localnet (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id D22AC37820E7;
 Tue,  2 Apr 2024 15:38:48 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] rockchip: Add a board_gen_ethaddr() function
Date: Tue, 02 Apr 2024 11:38:41 -0400
Message-ID: <3001977.mvXUDI8C0e@arisu>
Organization: Collabora
In-Reply-To: <55dcdf42-b446-4718-a99a-1e454d14c5cf@kwiboo.se>
References: <20240314144403.491850-1-detlev.casanova@collabora.com>
 <20240314144403.491850-3-detlev.casanova@collabora.com>
 <55dcdf42-b446-4718-a99a-1e454d14c5cf@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12686403.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
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

--nextPart12686403.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH 2/3] rockchip: Add a board_gen_ethaddr() function
Date: Tue, 02 Apr 2024 11:38:41 -0400
Message-ID: <3001977.mvXUDI8C0e@arisu>
Organization: Collabora
In-Reply-To: <55dcdf42-b446-4718-a99a-1e454d14c5cf@kwiboo.se>
MIME-Version: 1.0

Hi Jonas,

On Thursday, March 14, 2024 2:38:30 P.M. EDT Jonas Karlman wrote:
> Hi Detlev,
> 
> On 2024-03-14 15:43, Detlev Casanova wrote:
> > Set the MAC address based on the CPU ID only if the ethernet device has
> > no ROM or DT address set.
> 
> This patch changes behavior and once again require CONFIG_NET to fixup
> the device tree with local-mac-address for the ethernet0/1 alias nodes.
> 
> I.e. reverts one of the intentions with the commit 628fb0683b65
> ("rockchip: misc: Set eth1addr mac address"), fixup of ethaddr in DT
> should not depend on enabled and working ethernet in U-Boot.

I see the intention, that makes sense.

> Maybe just having a Kconfig to control if ENV ethaddr should overwrite
> ROM ethaddr could as easily solve your issue?

If that is ok for everybody, it would indeed be enough for this issue and keep 
the eth driver less complex.

> Please also note that misc.c is merging into board.c in another pending
> series, see custodian u-boot-rockchip/for-next branch.
> 
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> > 
> >  arch/arm/Kconfig                          |  1 +
> >  arch/arm/include/asm/arch-rockchip/misc.h |  1 +
> >  arch/arm/mach-rockchip/board.c            | 30 ++++++++++++++++++-----
> >  arch/arm/mach-rockchip/misc.c             | 22 ++++++++++++-----
> >  4 files changed, 42 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 01d6556c42b..21b41675ef6 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -2003,6 +2003,7 @@ config ARCH_ROCKCHIP
> > 
> >  	select DM_SPI_FLASH
> >  	select DM_USB_GADGET if USB_DWC3_GADGET
> >  	select ENABLE_ARM_SOC_BOOT0_HOOK
> > 
> > +	select NET_BOARD_ETHADDR
> 
> You are selecting here, so why the need for IS_ENABLED checks below?
> 
> >  	select OF_CONTROL
> >  	select MTD
> >  	select SPI
> > 
> > diff --git a/arch/arm/include/asm/arch-rockchip/misc.h
> > b/arch/arm/include/asm/arch-rockchip/misc.h index
> > 4155af8c3b0..6e972de6279 100644
> > --- a/arch/arm/include/asm/arch-rockchip/misc.h
> > +++ b/arch/arm/include/asm/arch-rockchip/misc.h
> > @@ -10,5 +10,6 @@ int rockchip_cpuid_from_efuse(const u32 cpuid_offset,
> > 
> >  			      const u32 cpuid_length,
> >  			      u8 *cpuid);
> >  
> >  int rockchip_cpuid_set(const u8 *cpuid, const u32 cpuid_length);
> > 
> > +int rockchip_gen_macaddr(int dev_num, u8 *mac_addr);
> > 
> >  int rockchip_setup_macaddr(void);
> >  void rockchip_capsule_update_board_setup(void);
> > 
> > diff --git a/arch/arm/mach-rockchip/board.c
> > b/arch/arm/mach-rockchip/board.c index 2620530e03f..283d3b9ed3a 100644
> > --- a/arch/arm/mach-rockchip/board.c
> > +++ b/arch/arm/mach-rockchip/board.c
> > @@ -296,8 +296,8 @@ int fastboot_set_reboot_flag(enum
> > fastboot_reboot_reason reason)> 
> >  }
> >  #endif
> > 
> > -#ifdef CONFIG_MISC_INIT_R
> > -__weak int misc_init_r(void)
> > +#if IS_ENABLED(CONFIG_MISC_INIT_R) ||
> > IS_ENABLED(CONFIG_NET_BOARD_ETHADDR)
> 
> NET_BOARD_ETHADDR is selected so this #if will always be true.
> 
> > +static int set_cpuid(void)
> > 
> >  {
> >  
> >  	const u32 cpuid_offset = CFG_CPUID_OFFSET;
> >  	const u32 cpuid_length = 0x10;
> > 
> > @@ -309,10 +309,6 @@ __weak int misc_init_r(void)
> > 
> >  		return ret;
> >  	
> >  	ret = rockchip_cpuid_set(cpuid, cpuid_length);
> > 
> > -	if (ret)
> > -		return ret;
> > -
> > -	ret = rockchip_setup_macaddr();
> > 
> >  	return ret;
> >  
> >  }
> > 
> > @@ -349,3 +345,25 @@ __weak int board_rng_seed(struct abuf *buf)
> > 
> >  	return 0;
--nextPart12686403.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEonF9IvGrXNkDg+CX5EFKUk4x7bYFAmYMJoEACgkQ5EFKUk4x
7bbSBQf+PExI0UcUZRrv10J/j/jnts/8Mu8EdBifScvNlhwygcxDtsPbDhYw/KRw
LsRHYPqcr2ZUKIsBo+PBR18aeQdtFqseZeUCBg5jidvC3CEGzjPGqY3EnqYaV5Mj
gPTuKyzBgrzV/gzIX8Ry7s8XeSM3XKRUKH/dq0Aum3mzGQhSJqcDGe1reShEH8Wx
UtVoQ+/IFwC5YwJJ5AKgMYNTJuK0/FHJdHP0j9Q4whH9MPa9LPQNjxXAIosrzmkn
AkGEKpwGVYjWSHUBFuF1RflW1osOieQAE7btJl+p5vESdwLF+oo2N24ULha2RB8T
bRbVnARTuyuOPS/OUN3Av3sYXFBL+g==
=vWPF
-----END PGP SIGNATURE-----

--nextPart12686403.O9o76ZdvQC--



