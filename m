Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699BAD41C14
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C59D83D92;
	Thu, 11 Dec 2025 11:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l+T9GeC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EFFB83C9F; Thu, 11 Dec 2025 09:39:20 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E4E183C7B
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 35A88601A0;
 Thu, 11 Dec 2025 08:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF02C4CEFB;
 Thu, 11 Dec 2025 08:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765442355;
 bh=VY85uMaZpIzwxf3exszgw6rPkpvs1jLhXFySVqVZ8GY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=l+T9GeC5MGw2eUpiUUTL6wygFpYNcfIRZhg6+dh4GjIQbDXkAk2jh5nP2cMInWCX/
 WTdSUC/qgGnW3CcSKhEQwb+mmUWtVl/a0bU1v5S9swXhe7tWb1VNjf9FkDkJQxKvNl
 ElDsX1pk9Emji+EW45YUmfMXk4/40HJ36LXbCb03FXHbCtl+fZwvv2+3YQ9OaAo65M
 f+HCiKfUhMzUufnGtKGhoHowKZZLqfA8WbuzpSl0/rp+ovG7I9a6mYP4qHUSW9cEzS
 VEvvMdM0F/z87gjvloKyDiaQEEz6ABAyfSOXMNycAss+gwXxOzmvcBOFeh3aOAmxl7
 XHIW/kpPHHhRg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, Stefan Roese
 <stefan.roese@mailbox.org>, Greg Malysa <malysagreg@gmail.com>, Vasileios
 Bimpikas <vasileios.bimpikas@analog.com>, Arturs Artamonovs
 <arturs.artamonovs@analog.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Peng Fan
 <peng.fan@nxp.com>, "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Yao Zi <ziyao@disroot.org>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Alif Zakuan Yuslaimi
 <alif.zakuan.yuslaimi@altera.com>, Sumit Garg <sumit.garg@kernel.org>,
 Julien Masson <jmasson@baylibre.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sam Shih <sam.shih@mediatek.com>, David
 Lechner <dlechner@baylibre.com>, Ian Roberts <ian.roberts@timesys.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Heiko Schocher
 <hs@nabladev.com>, Duje =?utf-8?Q?Mihanovi=C4=87?=
 <duje@dujemihanovic.xyz>, Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH v2 2/2] clk: mediatek: add MT8188 clock driver
In-Reply-To: <20251209-add-mt8188-support-v2-2-31dbfcf7303c@baylibre.com>
References: <20251209-add-mt8188-support-v2-0-31dbfcf7303c@baylibre.com>
 <20251209-add-mt8188-support-v2-2-31dbfcf7303c@baylibre.com>
Date: Thu, 11 Dec 2025 09:39:13 +0100
Message-ID: <878qf95s5q.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

Hi Julien,

Thank you for the patch.

On Tue, Dec 09, 2025 at 11:22, Julien Stephan <jstephan@baylibre.com> wrote:

> From: Julien Masson <jmasson@baylibre.com>
>
> The following clocks have been added for MT8188 SoC:
> apmixedsys, topckgen, infracfg, pericfg and imp_iic_wrap
>
> These clocks driver are based on the ones present in the kernel:
> drivers/clk/mediatek/clk-mt8188-*
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/clk/mediatek/Makefile     |    1 +
>  drivers/clk/mediatek/clk-mt8188.c | 1840 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 1841 insertions(+)
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 12893687b68fc6c136a06e19305b1dd0c8a8101a..68b3d6e9610d8e7f4c4c625f52e525174e92787a 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_TARGET_MT7981) += clk-mt7981.o
>  obj-$(CONFIG_TARGET_MT7988) += clk-mt7988.o
>  obj-$(CONFIG_TARGET_MT7987) += clk-mt7987.o
>  obj-$(CONFIG_TARGET_MT8183) += clk-mt8183.o
> +obj-$(CONFIG_TARGET_MT8188) += clk-mt8188.o
>  obj-$(CONFIG_TARGET_MT8365) += clk-mt8365.o
>  obj-$(CONFIG_TARGET_MT8512) += clk-mt8512.o
>  obj-$(CONFIG_TARGET_MT8516) += clk-mt8516.o
> diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..55dfadddfe3cf743602533de30275bc93d4f15a5
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8188.c
> @@ -0,0 +1,1840 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MediaTek clock driver for MT8188 SoC
> + *
> + * Copyright (C) 2025 BayLibre, SAS
> + * Copyright (c) 2025 MediaTek Inc.
> + * Authors: Julien Masson <jmasson@baylibre.com>
> + *          Garmin Chang <garmin.chang@mediatek.com>
> + */
> +
> +#include <clk-uclass.h>
> +#include <dm/device_compat.h>
> +#include <dm.h>
> +#include <asm/io.h>
> +#include <dt-bindings/clock/mediatek,mt8188-clk.h>
> +
> +#include "clk-mtk.h"
> +
> +#define MT8188_PLL_FMAX		(3800UL * MHZ)
> +#define MT8188_PLL_FMIN		(1500UL * MHZ)
> +
> +/* Missing topckgen clocks definition in dt-bindings */
> +#define CLK_TOP_ADSPPLL		206
> +#define CLK_TOP_CLK13M		207
> +#define CLK_TOP_CLK26M		208
> +#define CLK_TOP_CLK32K		209
> +#define CLK_TOP_IMGPLL		210
> +#define CLK_TOP_MSDCPLL		211
> +#define CLK_TOP_ULPOSC1_CK1	212
> +#define CLK_TOP_ULPOSC_CK1	213

Why are these clock definitions missing from the dt-bindings?
Were they just forgotten, or is there another reason?

Could we (long term) add these definitions to the dt-bindings by
contributing them to the kernel?

Note: I'm not requesting to change this patch, I'm just curious as of
why we need to add these definitions here.

Note that I also don't see these CLKs in the linux driver so why are
they needed for U-Boot ?
(I searched for CLK_TOP_CLK13M in Linux master commit e7c375b18160 ("Merge tag 'vfs-6.18-rc7.fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs"))

> +
> +/* apmixedsys */
> +#define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,	\
> +	    _pd_shift, _pcw_reg, _pcw_shift) {				\
> +		.id = _id,						\
> +		.reg = _reg,						\
> +		.pwr_reg = _pwr_reg,					\
> +		.en_mask = _en_mask,					\
> +		.rst_bar_mask = BIT(23),				\
> +		.fmin = MT8188_PLL_FMIN,				\
> +		.fmax = MT8188_PLL_FMAX,				\
> +		.flags = _flags,					\
> +		.pcwbits = _pcwbits,					\
> +		.pcwibits = 8,						\
> +		.pd_reg = _pd_reg,					\
> +		.pd_shift = _pd_shift,					\
> +		.pcw_reg = _pcw_reg,					\
> +		.pcw_shift = _pcw_shift,				\
> +	}
> +
