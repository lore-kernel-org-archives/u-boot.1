Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3AEC4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 16:56:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67195848BA;
	Sun, 19 Jul 2026 18:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="anhGN4Zf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB77684A0B; Sun, 19 Jul 2026 18:56:14 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AEEC838D7
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 18:56:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1784480167; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=heGk+cioKSaYmvllXgFYaBDzhyS9OrfuSz8GpyLES1vHGF13OzumW+4cwNlyHoB5g7e5hSFzwzC3ocy/qvyVOegEz0dQ/qA8sqqP47q2OgoEOCU2WmrX208s2sMdO0aL1GzFC6YwuLsPE34dKwte7uw6JzuTZNH5dHHA4reUmlE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784480167;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=OqdwIHNpo9Rd9EF1IyA+TKpLiO0LTeCbjtRc8mWdQLw=; 
 b=bpESrM8hFaaRFD6zLA5+qo2QIVE53XMJ30f+PDpWQbyK+FMoNjkTpYgl+8v72foYxmC9iETKjk/ZBSM7ILN36JhjaHNfChxKnGNYjLuvJYUHtxQe/qOQqaUUX1idLtSxKH+1CjZX88Rp5f2PedNjck+5TuYvSE8BC/rIgHHLGZo=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784480167; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=OqdwIHNpo9Rd9EF1IyA+TKpLiO0LTeCbjtRc8mWdQLw=;
 b=anhGN4Zfbn4NQ0gu5Ueljks6emxh8zp8sIoPmzuOjh5zT5i4WxbXY7yDkTiMsO8g
 LTc1rNcx8lGh0yyA/E/tkZcKTbTVepTH8OMSAxBt5gQUWtDYijVhgItxpPXXciIX9Mr
 F2HNX+g082AEOEc7+PVwKo/mgDjNlJTShrOt2+d0=
Received: by mx.zohomail.com with SMTPS id 1784480164555489.23344660941746;
 Sun, 19 Jul 2026 09:56:04 -0700 (PDT)
Date: Sun, 19 Jul 2026 16:55:51 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v4 01/10] spacemit: k1: select boot device via config
 registers
Message-ID: <al0Bl_Uxd3SvfoJR@pie>
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
 <20260707-m4-v4-1-dbd01185f911@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-m4-v4-1-dbd01185f911@riscstar.com>
X-ZohoMailClient: External
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

On Tue, Jul 07, 2026 at 11:21:42PM +0800, Eric Chung wrote:
> Add logic to determine the current boot device by reading the
> SoC's configuration registers, rather than using a hardcoded
> default.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> 
> ---
> v2:
> - Use FIELD_GET() to parse boot strap mode.
> - Remove comments on hacking. Since the sequence between eMMC
>   and SD device is exchanged in the upstream DTS. So it isn't
>   a hacking any more.
> ---
>  board/spacemit/k1/spl.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> index 0db362130e4..70579637b5e 100644
> --- a/board/spacemit/k1/spl.c
> +++ b/board/spacemit/k1/spl.c

...

> @@ -379,7 +402,51 @@ void board_init_f(ulong dummy)
>  
>  u32 spl_boot_device(void)
>  {
> -	return BOOT_DEVICE_SPI;
> +	void __iomem *boot_dev = (void __iomem *)BOOT_DEV_FLAG_REG;
> +	void __iomem *boot_strap = (void __iomem *)BOOT_PIN_SEL_REG;
> +	u32 mode, sel, ret = 0;
> +
> +	mode = readl(boot_dev);
> +	if (mode == BOOT_MODE_NONE || mode > BOOT_MODE_SD) {
> +		sel = FIELD_GET(BOOT_STRAP_MODE_MASK << BOOT_STRAP_MODE_OFFSET,
> +				readl(boot_strap));
> +		switch (sel) {
> +		case BOOT_STRAP_MODE_EMMC:
> +			mode = BOOT_MODE_EMMC;
> +			break;
> +		case BOOT_STRAP_MODE_NAND:
> +			mode = BOOT_MODE_NAND;
> +			break;
> +		case BOOT_STRAP_MODE_SPI:
> +			mode = BOOT_MODE_SPI;
> +			break;
> +		case BOOT_STRAP_MODE_SD:
> +		default:
> +			mode = BOOT_MODE_SD;
> +			break;
> +		}
> +	}
> +	switch (mode) {
> +	case BOOT_MODE_EMMC:
> +		ret = BOOT_DEVICE_MMC1;
> +		break;
> +	case BOOT_MODE_NAND:
> +		ret = BOOT_DEVICE_NAND;
> +		break;
> +	case BOOT_MODE_SPI:
> +		ret = BOOT_DEVICE_SPI;
> +		break;
> +	case BOOT_MODE_USB:
> +		ret = BOOT_DEVICE_USB;
> +		break;
> +	case BOOT_MODE_SD:
> +		ret = BOOT_DEVICE_MMC2;
> +		break;
> +	default:
> +		ret = BOOT_DEVICE_MMC1;
> +		break;
> +	}

Adding empty lines before and after this switch might make the code a
little cleaner. Though being a little strange to me, checkpatch.pl
doesn't complain about it, so I don't have a strong opinion for this.

Reviewed-by: Yao Zi <me@ziyao.cc>

Best regards,
Yao Zi
