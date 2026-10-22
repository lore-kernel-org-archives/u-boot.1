Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1184B606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 00:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Fu7vGol2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nd7mk0VM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D206980D92;
	Thu, 22 Oct 2026 00:58:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FPNWQQ3mNcsy; Thu, 22 Oct 2026 00:58:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5408080D9D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792630681;
	b=ZIdkkRNj9kb1vRML4qAUfZ1OWK/3WAhocW731SL+gfhq7zYUJqhU/Y/Uz7Dzj29Ib2Pf
	 0rihn8IERD1zefA7UDZMJrXpMXhWvdyRVItN3yPXxjVMZHPbz8ygmx1SRZ6U3IxEvhBDF
	 UkHYZRm63fQe8Q8A6hRiT8jy3tBzQnzY1u5U0c/AT7PY9bb0CzDp4c/HpnSX27tOz7L7b
	 qWYc56ICaykuj1VaQPTwi9i32vrPDrAPMpS212OVzAlWcCUYA5taQ05vp7pJbYEieyTTE
	 n2qHeVG419Pu4Z2mmw4/yd7ZnAWVHCrotUQFJ1Y8vaVr9k/TNtA7OdAK3rGDQhgS55w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792630681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wMNyhZKCHGNDIZw6B6X5cY89mpDJIjtZYz3YEa0sg1o=;
	b=Eimj3ykrwjZqPf8ugK4c2+bstNZRla6wcend+oP/sTHvPvoDm/bkSQGd6kb6ZuClTrQw
	 MM0u6dr44cOw7Ywk5yoi03sK5fAOrOdZ+Snv9cKYUEPr+Ms8c0Z2RVSLZ6Kz+5Tc8NuTB
	 ethxeDWNWEEaL6EaOzSa3rOuSrDCrBoU8baNkbRKtB75bW5swat+i4z1Vdbbq7/3Ls8nc
	 plURRM3GT8lNgjTz1FjD7dYvH1GfopiVgmhHPkGNoPrI0yjiNocX8v5ZhE3G41X1pC6ti
	 nSW/LSbs81C7ef675SFR6DT5WEQJBe1kZYLgc2qbqoEwNQpL8bEOng3uCiKVHIqYZtg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792630681;
	bh=wMNyhZKCHGNDIZw6B6X5cY89mpDJIjtZYz3YEa0sg1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fu7vGol29Nc2qRHRie7XtsCM10nxx8HlqBUcWmVot2sZ9KHMasoSu86pzTwcz50oi
	 UTCTTBxW5jq5EwvJKuG0J1ZD9c6JsnQmenVT4DaehlclMzGcmSHX+OOgCEFbKU7LoS
	 d0GsKjCubOokS8Xx0RioGh3+JYnc7cUBXBz0xwAl/w3I0k1F1pJR9/ju9M1h1RLZsR
	 usWT8dxKGYI8zuLdU0BMePVyPAPwYMNqf9DdORbG9LzM6JwJu1D546/4RnrKMAIKlx
	 ZrIP5Iz4YxUrp4lL88xjZ2zXHWspaVL7iDNmApPHNji1JrcJp0VMrjG3hw9MhDQb92
	 DRRfSvGAl1kwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5408080D9D;
	Thu, 22 Oct 2026 00:58:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 022A8371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7BEA408F0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:57:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BGho8nEKAl3J for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 00:57:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E2E65408EB
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792630679;
 b=kDY32FD/JjHujLzRDuCtBT5lIaXHxrdn1igmN4Jc6DoMChgK87Z9fDQQcSRiI85kiXX5
 WMa3iCOhC98FKefpjkeAuhlJKflJeGE7cFTn/cafpSY2qpTvrYwM6E3WeHizimD3TR5J1
 IbEujNQrqunQFvmHsjkPDvBRcB0cQ3KwcceYUQcjnEKS4+35DnAf1w+BSW/AcR3vPJa7R
 oAQ2Vyk909DZZPfJE6lSEyhtA0o74hHwlRmB8UvJWiwnL/8RoBa/LQvAHvYJFbX3XGbKb
 iW24CIt9KgIpolH9sujHIPxoKj+itksqzIYFPw2ceF9mfVeDzoA7EDOtCbLTO9uX60g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792630679;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=wMNyhZKCHGNDIZw6B6X5cY89mpDJIjtZYz3YEa0sg1o=;
 b=Q88t7t3YaaRKaXTxlcDFgmVnIlMaQ4aDdIk6vymeMJrsb1leLCtuCbB9hcfyQxFEusZj
 C0Pg7531xSecWba4KfKgSRdCNbN+BfrqBZu9fBr/LiIC9uXUaZIoxaXXDXo9Sz5HtxiH/
 /DbUu1jdGm8jgkvyuVkjcipzGdBQ8upeR4hffZ5Tu33Cacijt3q9NdbSmI+oaSByeTfPa
 wiWEmR7N8MO5rF0BCX4l9rtn6fWxBi2mG1H4t7bNmKAWcx/qJ7bIhosKs6LpSURyGlcRY
 SY45nCmVI/DJdDhUOQcJJ4jOJaBBHXK1AouDmj8OyjXLy/WwSrBbyjckEi7D9gDmW/w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Nd7mk0VM; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Nd7mk0VM
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2E65408EB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:57:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6EFD360098;
 Thu, 22 Oct 2026 00:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82A11F000C1;
 Thu, 22 Oct 2026 00:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792630676;
 bh=wMNyhZKCHGNDIZw6B6X5cY89mpDJIjtZYz3YEa0sg1o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Nd7mk0VMuYDhIdLkQe8mcmM/QzOT1Szl4DdY+8L2JOsJs4lMnKpSxXG5rsIDXbA5/
 aRJvKuKfEyBxeAHSHaWoeVzNowywZV6GrDOpFOsAO0FztEOvHkqz5btvhQQazNe4gX
 n9JpUHCdcV1t2MErQfZsWM2U/t8euLBs4qexCDGGcJvcLrnaCw8xGpkHIE0Ypq7NWp
 x/vhlurdX9CJWPg9KcZPBPcDxbQ9d/NpOP1NX8zWKT0YADncSzPgNoCcxUQWs80bbI
 avTNTC/nzT3himW6ziLR14S4IPDjUPFLAF2Rwmu9ColZVexeUD+67UtfYB1BNaZEQs
 qNPBoTsJXJ8Vw==
Date: Thu, 22 Oct 2026 00:57:54 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/2] configs: spacemit: k3: enable mtdparts on Pico-ITX
 in main app
Message-ID: <20261022005754-GKO26088@kernel.org>
References: <20261020195126.1325187-1-e@freeshell.de>
 <20261020195126.1325187-3-e@freeshell.de>
 <20261021075605-GKD65567@kernel.org>
 <d0ce354d-71d0-4dab-9725-70e06998df2b@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0ce354d-71d0-4dab-9725-70e06998df2b@freeshell.de>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E

On 07:35 Wed 21 Oct     , E Shattow wrote:
> Hi Yixun,
> 
> On 10/21/26 00:56, Yixun Lan wrote:
> > Hi E Shattow,
> > 
> > 
> > On 12:51 Tue 20 Oct     , E Shattow wrote:
> >> add default mtdparts and mtdids consistent with k3-pico-itx.dts
> >>
> >> Signed-off-by: E Shattow <e@freeshell.de>
> >> ---
> >>  configs/spacemit_k3_defconfig | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
> >> index b333e708d01b..2ca912556a88 100644
> >> --- a/configs/spacemit_k3_defconfig
> >> +++ b/configs/spacemit_k3_defconfig
> >> @@ -26,6 +26,7 @@ CONFIG_SYS_PBSIZE=276
> >>  CONFIG_HUSH_PARSER=y
> >>  CONFIG_CMD_GPIO=y
> >>  CONFIG_CMD_I2C=y
> >> +CONFIG_CMD_MTD=y
> >>  CONFIG_CMD_DHCP=y
> >>  CONFIG_CMD_DNS=y
> >>  CONFIG_CMD_MII=y
> >> @@ -36,6 +37,9 @@ CONFIG_CMD_PMIC=y
> >>  CONFIG_CMD_REGULATOR=y
> >>  CONFIG_CMD_FAT=y
> >>  CONFIG_CMD_FS_GENERIC=y
> >> +CONFIG_CMD_MTDPARTS=y
> >> +CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
> >> +CONFIG_MTDPARTS_DEFAULT="spi0.0:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)"
> 
> > or make it more specific? s/spi0.0/d420c000.spi/ 
> 
> Yes and no, I do prefer an automatic layout (and layout name) be
> generated from device tree at runtime. I guess that may possibly become
> "qspi.flash0", or "fdt.soc.d420c000.spi.qspi.flash.0", etc.
> 
> The output of 'mtd list' tells us the parent:
> 
> => mtd list
> List of MTD devices:
> * nor0
>   - device: flash@0
>   - parent: spi@d420c000
> 
> Also, then, the output of 'mtdparts' tells us the partition layout:
> 
> => mtdpart
> 
> device nor0 <spi0.0>, # parts = 6
>  #: name                size            offset          mask_flags
>  0: bootinfo            0x00020000      0x00000000      0
>  1: fsbl                0x00080000      0x00020000      0
>  2: env                 0x00010000      0x000a0000      0
>  3: esos                0x00100000      0x000b0000      0
>  4: opensbi             0x00060000      0x001b0000      0
>  5: uboot               0x005f0000      0x00210000      0
> 
> active partition: nor0,0 - (bootinfo) 0x00020000 @ 0x00000000
> 
> defaults:
> mtdids  : nor0=spi0.0
> mtdparts:
> spi0.0:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)
> 
> I consider the partition layout identifier style as you suggest:
> 
> $ egrep --exclude-dir=.git -or 'mtdparts=[^ ]+)' | cut -d: -f2 | sort |
> uniq -c | egrep -v '[0-9a-fA-F]{7}' | sort -k1,1 -n
> 
> ...
>       3 mtdparts=nand_mtd
>       3 mtdparts=uniphier-nand.0
>       4 mtdparts=nand0
>       4 mtdparts=spi-flash.0
>       5 mtdparts=nor0
>       5 mtdparts=spi_flash
>       7 mtdparts=boot
>       7 mtdparts=omap2-nand.0
>       8 mtdparts=nand
>      11 mtdparts=nand.0
>      12 mtdparts=orion_nand
>      13 mtdparts=spi0.0
>      16 mtdparts=gpmi-nand
>      50 mtdparts=atmel_nand
> 
> 
> $ egrep --exclude-dir=.git -or 'mtdparts=[^ ]+)' | cut -d: -f2 | sort |
> uniq -c | egrep '[0-9a-fA-F]{7}' | sort -k1,1 -n
>       1 mtdparts=10b80000.nand.0
>       1 mtdparts=1fc000000.nor_flash
>       1 mtdparts=21e0000.qspi
>       1 mtdparts=30bb0000.qspi
>       1 mtdparts=30bb0000.spi
>       1 mtdparts=8000000.nand
>       1 mtdparts=fe000000.nor_flash
>       1 mtdparts=ffb90000.nand.0
>       1 mtdparts=mtdparts=47040000.spi.0
>       1 mtdparts=[mtdparts=]edb7312-nor
>       1 mtdparts=mtdparts=edb7312-nor
>       2 mtdparts=02008000.spi.1
>       2 mtdparts=8000000.nor
>       4 mtdparts=1550000.spi
>       4 mtdparts=1550000.spi-0
>       4 mtdparts=47040000.spi.0
>       4 mtdparts=ec000000.nor
>       4 mtdparts=ef000000.nor
>       4 mtdparts=fef000000.nor
>      10 mtdparts=ff705000.spi.0
>      16 mtdparts=60000000.nor
>      16 mtdparts=ff800000.flash
>      22 mtdparts=fe8000000.nor
> 
> 
> For the initial patch here I instead prefer the minimal and simple style
> for mtdparts layout template names and to re-use what is popular in
> U-Boot source tree. The use of hexadecimal bus address for the layout
> name is difficult for me to read, and not clear to me what is the
> benefit to doing this manually-entered data address?
> 
> => env print
> ...
> mtddevnum=0
> mtdids=nor0=spi0.0
> mtdparts=spi0.0:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)
> partition=nor0,0
> ...
> 
> Compared to a style of repeating the bus address:
> 
> => env print
> ...
> mtddevnum=0
> mtdids=nor0=d420c000.spi
> mtdparts=d420c000.spi:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)
> partition=nor0,0
> ...
> 
> Let me know if you do yet prefer the bus address repeated for the name
> of partition layout. I'd like to see this as part of a runtime-generated
> mtdparts configuration, so anything is okay with me for the initial
> manual layout here.
> 
I've done a further check.. so quote from <uboot>/cmd/mtdparts.c

 * mtdparts=[mtdparts=]<mtd-def>[;<mtd-def>...]
 *
 * <mtd-def>  := <mtd-id>:<part-def>[,<part-def>...]
 * <mtd-id>   := unique device tag used by linux kernel to find mtd device (mtd->name)

from kernel side, check file drivers/mtd/parsers/cmdlinepart.c which
has the same format, on the linux console (if no mtdparts enabled)

# cat /sys/class/mtd/mtd0/name
d420c000.spi

so with bus address it's able to support cmdlinepart, although we
currently use ofpart, but IMO, it's correct and in case people need it

> > 
> >>  CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"
> >>  CONFIG_ENV_OVERWRITE=y
> >>  CONFIG_ENV_IS_IN_SPI_FLASH=y
> >> @@ -49,6 +53,7 @@ CONFIG_DM_I2C=y
> >>  CONFIG_SYS_I2C_SPACEMIT_K1=y
> >>  CONFIG_MISC=y
> >>  CONFIG_SPI_FLASH_WINBOND=y
> >> +CONFIG_SPI_FLASH_MTD=y
> >>  CONFIG_PHY_GIGE=y
> >>  CONFIG_DWC_ETH_QOS=y
> >>  CONFIG_DWC_ETH_QOS_SPACEMIT=y
> >> -- 
> >> 2.53.0
> >>
> > 
> 
> Thanks,
> 
> -E

-- 
Yixun Lan (dlan)
