Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51845CD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFBDF8758B;
	Thu, 11 Apr 2024 06:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="sOnyi5Hk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0E4788233; Thu, 11 Apr 2024 06:33:43 +0200 (CEST)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com
 [95.215.58.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D3088216
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
Date: Thu, 11 Apr 2024 14:32:51 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712810021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0vp6VFGdgH9XTi6gtYm5gZ4KpTOaZvcqBb/5xP88oQE=;
 b=sOnyi5Hkh6ovzl6aGfi8KihJqd4bP64yp3Tqqd42w3ONMZKKJBuez3UDTA0dyjgoCpbfIG
 6kersXq5L0ulzV2qvP6C0O5qoEuNjZTkkn5/8RSoAWKy0Us7K+HUzuGc9/9Kmo0QZyk8pv
 Bo4MRyqWaDz6esbWAavhNuW5Itlhlc/GYYC1veydywUDQIY1h9466cdjQM8aoAxa1o5tKS
 mHi654DLgOjp12SP5FsOjR+qGsB6kRpmgp1IIXawG8rjWAJyQ0Ix2LQbZ8XLZe3j3wPghH
 Eug29nVhxuuvWU2CY6H/6/dfUp9NrlB3WPgPEbyenNhqjy4EzSNiVEDuX84lCA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Samuel Holland <samuel@sholland.org>,
 Jesse Taube <mr.bossman075@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/8] SUNIV SPI NAND support in SPL
Message-ID: <Zhdn80xBMENcfnwM@titan>
References: <20221014030520.3067228-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014030520.3067228-1-uwu@icenowy.me>
X-Migadu-Flow: FLOW_OUT
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

Hello,

I've used this code extensively, incorporated it in to an RFC branch of
mine during development and reviewed it in the process.

John.

Reviewed-by: John Watts <contact@jookia.org>
Tested-by: John Watts <contact@jookia.org>

On Fri, Oct 14, 2022 at 11:05:12AM +0800, Icenowy Zheng wrote:
> This patchset tries to extend SPI-based boot code in sunxi SPL to
> support SPI NAND, following the same principle with current SPI NOR code
> (mimicking the behavior of sunxi BROM). In addition, as part of test to
> this patchset, some patches for Source Parts Inc. PopStick is attached,
> although marked DO NOT MERGE because the DT should come from Linux after
> it's ready.
> 
> To keep thr code that accesses SPI NAND as simple as possible, it
> assumes fixed page size, which is also what sunxi BROM does. The SUNIV
> SPL assumes 0x400 page size, but here to utilize the space better, in
> the attached example of PopStick, U-Boot main part is assumed to be
> with 0x800 page size (which is the real situation of the W25N01 flash
> used by PopStick).
> 
> Icenowy Zheng (8):
>   sunxi: SPL SPI: extract code for doing SPI transfer
>   sunxi: SPL SPI: add support for read command with 2 byte address
>   sunxi: SPL SPI: allow multiple boot attempt
>   sunxi: SPL SPI: add initial support for booting from SPI NAND
>   sunxi: enable support for SPI NAND booting on SUNIV
>   [DO NOT MERGE] sunxi: sync DT from my tree for PopStick
>   [DO NOT MERGE, DIRTY HACK] sunxi: use UBI for environement storage
>   [DO NOT MERGE] sunxi: add a defconfig for PopStick
> 
>  arch/arm/dts/Makefile                        |   3 +-
>  arch/arm/dts/suniv-f1c100s-licheepi-nano.dts |  16 ++
>  arch/arm/dts/suniv-f1c100s.dtsi              |  26 ++
>  arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts | 101 ++++++++
>  arch/arm/mach-sunxi/Kconfig                  |  16 ++
>  arch/arm/mach-sunxi/board.c                  |   4 +-
>  arch/arm/mach-sunxi/spl_spi_sunxi.c          | 247 ++++++++++++++-----
>  board/sunxi/board.c                          |   1 +
>  configs/popstick_defconfig                   |  35 +++
>  9 files changed, 377 insertions(+), 72 deletions(-)
>  create mode 100644 arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts
>  create mode 100644 configs/popstick_defconfig
> 
> -- 
> 2.37.1
> 
