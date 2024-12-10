Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCE2E7717D
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 02:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B679389250;
	Tue, 10 Dec 2024 03:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BD348932C; Tue, 10 Dec 2024 03:15:34 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE5289250
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 03:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Date: Tue, 10 Dec 2024 10:15:25 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Huan Zhou <pericycle.cc@gmail.com>
Cc: u-boot@lists.denx.de, Ben Dooks <ben.dooks@codethink.co.uk>,
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>
Subject: Re: [PATCH v5 1/2] riscv: spacemit: bananapi_f3: initial support added
Message-ID: <20241210021525-GYA1905152@gentoo>
References: <20241209-pickup-bpif3-v5-0-92f801b7c6c1@gmail.com>
 <20241209-pickup-bpif3-v5-1-92f801b7c6c1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-pickup-bpif3-v5-1-92f801b7c6c1@gmail.com>
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

Hi Huan:

Please rebase this patch on top of most recent master branch
as it fail to apply due to changes of arch/riscv/dts/Makefile

On 10:00 Mon 09 Dec     , Huan Zhou wrote:
> From: Kongyang Liu <seashell11234455@gmail.com>
> 
> Add basic support for SpacemiT's Banana Pi F3 board.
> Update the k1.dtsi align with mainline.
> Note that the device tree files follow the mainline Linux source[1].
> 
> [1]. https://patches.linaro.org/project/linux-serial/patch/20240730-k1-01-basic-dt-v5-8-98263aae83be@gentoo.org/
suggest style: Link: https://.. [1]
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
> ---
..
> diff --git a/include/configs/bananapi-f3.h b/include/configs/bananapi-f3.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..aecf69cd4cf8ddaea7dee57bf1a8ce8dc5db513d
> --- /dev/null
> +++ b/include/configs/bananapi-f3.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> + *
> + */
> +
> +#ifndef __CONFIG_H
> +#define __CONFIG_H
> +
> +#define CFG_SYS_SDRAM_BASE         0x0
> +#define CFG_SYS_NS16550_IER        0x40
I'd suggest to keep the comment..
#define CFG_SYS_NS16550_IER        0x40 /* UART Unit Enable */
> +
> +#endif /* __CONFIG_H */
> 
> -- 
> 2.39.5
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
