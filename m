Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31268CD98C5
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 03:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79B8C839A8;
	Sat, 13 Jun 2026 05:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="Uaa28GO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18EDC83FEC; Sat, 13 Jun 2026 05:51:22 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9123D8063E
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 05:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1781322672; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MV7VFZFCI7gTcx6tbNfCL/TkFnAVX+R7NOY6e8I1HuwflCn/BVpx89Uc8I/uwe2/asSdpBMHaI7obskzYZJ0RMecvKPleR15cXXSVMLe7g8CT9dRBwUTeQmTSUNaDACFTw/QlygUws6A9U3FyDHPLwQj4SXoSlXkXEx0mY1a4gY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781322672;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nwOXM6oHLoAzwHdm8dfecroTrH1V9FJw/PiK4rVgPjs=; 
 b=hmxWyA0KDyDEYnof7UnUEHYuKmq0WLvylZiI/VEX8GsvNB5TBDDEMiBpyIL2QmG4jWG6ACydnBWkhyKlHga47kbyw8sGnWxwUJ+IrVGtA17+8GzfDcz3JDYC1Dke5v4h665AQI+v8iPG1zO3PqWO+pR1+lW9xTnqqbGVMTtnt6s=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781322672; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=nwOXM6oHLoAzwHdm8dfecroTrH1V9FJw/PiK4rVgPjs=;
 b=Uaa28GO6CX/SjnYXgbIMLNrnfXshjDSzNxUlMl9YgcEiP5lP2RlB4XAujSmBDFnw
 jJoUsR35ikhwLZAElJcm0IIohMeGwixu/WNXMvIC8nhrSBBnKUByY30wTywcf/2KPTC
 SJKW5yAxL9AppjBD3yRIRnKZU7n04uD9uJBqPsA8=
Received: by mx.zohomail.com with SMTPS id 1781322669282104.13961428098457;
 Fri, 12 Jun 2026 20:51:09 -0700 (PDT)
Date: Sat, 13 Jun 2026 03:50:52 +0000
From: Yao Zi <me@ziyao.cc>
To: Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, xypron.glpk@gmx.de, randolph@andestech.com,
 dlan@gentoo.org, junhui.liu@pigmoral.tech,
 neil.armstrong@linaro.org, quentin.schulz@cherry.de,
 samuel@sholland.org, Guodong Xu <guodong@riscstar.com>,
 Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH 1/8] spacemit: k1: select boot device via config registers
Message-ID: <aizTnMlko1Pg9pMb@pie>
References: <20260612201901.73657-1-raymondmaoca@gmail.com>
 <20260612201901.73657-2-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612201901.73657-2-raymondmaoca@gmail.com>
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

On Fri, Jun 12, 2026 at 04:18:54PM -0400, Raymond Mao wrote:
> From: Guodong Xu <guodong@riscstar.com>
> 
> Add logic to determine the current boot device by reading the
> SoC's configuration registers, rather than using a hardcoded
> default.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> ---
>  board/spacemit/k1/spl.c | 77 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> index 0db362130e4..d5e87d79fa2 100644
> --- a/board/spacemit/k1/spl.c
> +++ b/board/spacemit/k1/spl.c

...

> @@ -379,7 +401,60 @@ void board_init_f(ulong dummy)
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
> +		sel = readl(boot_strap);
> +		sel >>= BOOT_STRAP_MODE_OFFSET;
> +		sel &= BOOT_STRAP_MODE_MASK;

Is FIELD_GET() helpful here?

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
> +	/* TODO:
> +	 *   The current upstream DTS file only contains the eMMC node. When
> +	 *   the SD node is added via an overlay, the eMMC device ends up as
> +	 *   MMC1 in SPL.

Why not fix this with an extra alias in the overlay dt?

> +	 *   However, the SD device should be the first device (MMC1).
> +	 *   This sequence needs to be corrected once the SD node is merged
> +	 *   into the upstream U-Boot DTS file.
> +	 */
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
> +	return ret;
>  }
>  
>  void spl_board_init(void)
> -- 
> 2.25.1
> 

Regards,
Yao Zi
