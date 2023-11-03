Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30282C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 12:40:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE5B58710F;
	Fri,  3 Nov 2023 13:40:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=poczta.fm header.i=@poczta.fm header.b="lndyPzfx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 332F7874A3; Fri,  3 Nov 2023 10:34:55 +0100 (CET)
Received: from smtpo55.interia.pl (smtpo55.interia.pl [217.74.67.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 200998750A
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 10:34:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=poczta.fm
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sst@poczta.fm
Received: from nr200 (unknown [80.68.225.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
 Fri,  3 Nov 2023 10:34:49 +0100 (CET)
Date: Fri, 3 Nov 2023 10:34:48 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Jonas Karlman <jonas@kwiboo.se>, kever.yang@rock-chips.com
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] rockchip: rk3588: Add SPINAND as boot device
Message-ID: <ZUS-uMc7p8xHlISM@nr200>
References: <20231031161327.1104885-1-sst@poczta.fm>
 <775cde64-e33d-48e8-907f-6dbc611a3a50@kwiboo.se>
 <f8152606-c139-4fc4-a4ac-e12b11b30608@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8152606-c139-4fc4-a4ac-e12b11b30608@rock-chips.com>
X-IPL-Priority-Group: 0-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
 t=1699004090; bh=MkkceDe53xTh9azAm7iXnFVyFBle/2aVKltAmdn7Pnk=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
 b=lndyPzfxZefkWjre4UtrzFrYP2qIS1SKvhgesejBmeXTTAajh71JbnA60Av1ceG3R
 mOpLTYyG4ORCWHNpilTweQcqhXP1NXemsmxgGkyPybck4aue3cF9fH31bS6flkPOND
 Ia8RsYA2H1MB4PDQw9AlQdYYFwWlDAjtHmaTR5e4=
X-Mailman-Approved-At: Fri, 03 Nov 2023 13:40:20 +0100
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

Hi Jonas and Kever

Thanks for clarifying the situation Kever! Please see below my proposition. What do you think?

On lis 02, 2023 15:27, Kever Yang wrote:
> Hi Jonas,
> 
> On 2023/11/1 00:45, Jonas Karlman wrote:
> > On 2023-10-31 17:13, Slawomir Stepien wrote:
> > > Mark the flash@0 as BROM_BOOTSOURCE_SPINAND.
> > > Fixes use of same-as-spl in u-boot,spl-boot-order prop on Orange Pi 5
> > > Plus.
> > > 
> > > Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> > > ---
> > >   arch/arm/mach-rockchip/rk3588/rk3588.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> > > index b1f535fad5..0c8f10a97c 100644
> > > --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> > > +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> > > @@ -42,6 +42,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
> > >   	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe2b0000/flash@0",
> > >   	[BROM_BOOTSOURCE_SD] = "/mmc@fe2c0000",
> > >   	[BROM_BOOTSOURCE_SPINOR_RK3588] = "/spi@fe2b0000/flash@0",
> > > +	[BROM_BOOTSOURCE_SPINAND] = "/spi@fe2b0000/flash@0",
> > This is not correct, please see [1] for an open discussion on this issue.
> > 
> > Kever: Do you have any more insights into the question on [1].
> 
> As I reply in another mail, the FSPI M0~M2 is all the option for SPI
> NAND/NOR in rk3588.

So based on that info, something like this?:

1. BROM_BOOTSOURCE_SPINAND - removed (not used at all).
2. BROM_BOOTSOURCE_SPINOR_RK3588 - removed (not needed after this patch).
3. Updated also the rk3568.c since it also has FSPI M0 (only this one mux), so I would assume it
will be value of 3 there too.
4. The BROM_BOOTSOURCE_SPINOR is still there, since the rk3399 does not use the FSPI (that is my
understanding after checking the TRM doc).

diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
index 7dab18fbc3..9f16d28aec 100644
--- a/arch/arm/include/asm/arch-rockchip/bootrom.h
+++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
@@ -46,9 +46,10 @@ enum {
 	BROM_BOOTSOURCE_NAND = 1,
 	BROM_BOOTSOURCE_EMMC = 2,
 	BROM_BOOTSOURCE_SPINOR = 3,
-	BROM_BOOTSOURCE_SPINAND = 4,
+	BROM_BOOTSOURCE_FSPI_M0 = 3,
+	BROM_BOOTSOURCE_FSPI_M1 = 4,
 	BROM_BOOTSOURCE_SD = 5,
-	BROM_BOOTSOURCE_SPINOR_RK3588 = 6,
+	BROM_BOOTSOURCE_FSPI_M2 = 6,
 	BROM_BOOTSOURCE_USB = 10,
 	BROM_LAST_BOOTSOURCE = BROM_BOOTSOURCE_USB
 };
diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index 69ef19cc85..ccb63c6a88 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -83,7 +83,7 @@ static struct mm_region rk3568_mem_map[] = {
 
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/mmc@fe310000",
-	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe300000/flash@0",
+	[BROM_BOOTSOURCE_FSPI_M0] = "/spi@fe300000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/mmc@fe2b0000",
 };
 
diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index b1f535fad5..c36f783d29 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -39,9 +39,10 @@ DECLARE_GLOBAL_DATA_PTR;
 
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/mmc@fe2e0000",
-	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe2b0000/flash@0",
+	[BROM_BOOTSOURCE_FSPI_M0] = "/spi@fe2b0000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/mmc@fe2c0000",
-	[BROM_BOOTSOURCE_SPINOR_RK3588] = "/spi@fe2b0000/flash@0",
+	[BROM_BOOTSOURCE_FSPI_M1] = "/spi@fe2b0000/flash@0",
+	[BROM_BOOTSOURCE_FSPI_M2] = "/spi@fe2b0000/flash@0",
 };
 
 static struct mm_region rk3588_mem_map[] = {

> > Is my assessment about the value BootRom writes to bootsource reg
> > correct, see [1]?
> > 
> > - FSPI (M0): 3
> > - FSPI (M1): 4
> > - FSPI (M2): 6
> > 
> > [1] https://lore.kernel.org/u-boot/b82c02c0-0a37-8553-f498-b03f85394d59@kwiboo.se/
> > 
> > Regards,
> > Jonas
> > 
> > >   };
> > >   static struct mm_region rk3588_mem_map[] = {

-- 
Slawomir Stepien
