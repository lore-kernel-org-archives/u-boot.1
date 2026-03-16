Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78422FD874A
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 11:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC5C484228;
	Tue, 17 Mar 2026 12:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="KHMgD8nZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E5B84068; Tue, 17 Mar 2026 06:07:10 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 508AB84056
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 45F7010D7A0; Tue, 17 Mar 2026 06:07:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1773724027;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=gqcaSJLniXUcSFfH4rBRbFlzEBgjX0wyBd3JN4qBsmA=;
 b=KHMgD8nZFKcPjGSFxgr/Vf++NsVn1+dYF+zV85OEXH2SvGbuYgm766iYdh6CE6QHZNrTvF
 NQk0gEikqIlrvdQovVMdc0SkuDP8Z0RtQ285vBrPtYHwXqoOzbH84KTzKMlHFfLBbi/Q+3
 D9QIc7QZaz8TUpdcioerHn2mxE9jbc/2xsSEpEinhN5leRGRemQWSKhr3Kxhvf8YaHEct+
 Qk0O28Lmq+BNY09GNpFlpSm8Q2xO1M0I/Wfn0Vjy1HMYuh3QLXXzMnaZY9XFKrZsSMPu4I
 WBcHmv/Do3P6mjxloggLdySUvnclglhRKE0mdCcgJypbfjMz6LR8ZW1sqOVqKA==
Message-ID: <ee133e83-8d13-4771-a306-f5f5c2a62b08@nabladev.com>
Date: Mon, 16 Mar 2026 13:22:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] board: nxp: imx9{4,5}_evk: Add qb save option in
 SPL
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, alice.guo@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com,
 viorel.suman@nxp.com, ping.bai@nxp.com, sebastien.szymanski@armadeus.com,
 ravi@prevas.dk, joao.goncalves@toradex.com, ji.luo@nxp.com,
 tharvey@gateworks.com, qijian.guo@nxp.com
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <8f6be77bacc6a9abeaf4e9cf6c6f5e01890bc31a.1773648510.git.simona.toaca@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <8f6be77bacc6a9abeaf4e9cf6c6f5e01890bc31a.1773648510.git.simona.toaca@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 17 Mar 2026 12:56:37 +0100
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

On 3/16/26 9:15 AM, Simona Toaca (OSS) wrote:

[...]

> +++ b/arch/arm/mach-imx/imx9/qb.c
> @@ -428,3 +428,12 @@ int qb(int qb_dev, int qb_bootdev, bool save)
>   
>   	return 0;
>   }
> +
> +void spl_qb_save(void)
> +{
> +	int dev = spl_boot_device();
> +
> +	/* Save QB data on current boot device */
> +	if (qb(dev, dev, true))
> +		printf("QB save failed\n");
> +}

Should be in 1/5 ?

> diff --git a/board/nxp/imx94_evk/spl.c b/board/nxp/imx94_evk/spl.c
> index cc5b7f9ef0f..1d25795eb17 100644
> --- a/board/nxp/imx94_evk/spl.c
> +++ b/board/nxp/imx94_evk/spl.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
> - * Copyright 2025 NXP
> + * Copyright 2025-2026 NXP
>    */
>   
>   #include <hang.h>
> @@ -14,6 +14,7 @@
>   #include <asm/arch/sys_proto.h>
>   #include <asm/mach-imx/boot_mode.h>
>   #include <asm/mach-imx/ele_api.h>
> +#include <asm/mach-imx/qb.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> @@ -44,6 +45,9 @@ void spl_board_init(void)
>   	ret = ele_start_rng();
>   	if (ret)
>   		printf("Fail to start RNG: %d\n", ret);

Use CONFIG_IS_ENABLED() if this is meant to be enabled in different 
U-Boot stages.

> +	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
> +		spl_qb_save();
>   }
>   
>   /* SCMI support by default */
> diff --git a/board/nxp/imx95_evk/spl.c b/board/nxp/imx95_evk/spl.c
> index 761a1a4a0f6..35e4458f2b7 100644
> --- a/board/nxp/imx95_evk/spl.c
> +++ b/board/nxp/imx95_evk/spl.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
> - * Copyright 2025 NXP
> + * Copyright 2025-2026 NXP
>    */
>   
>   #include <hang.h>
> @@ -13,6 +13,7 @@
>   #include <asm/arch/sys_proto.h>
>   #include <asm/mach-imx/boot_mode.h>
>   #include <asm/mach-imx/ele_api.h>
> +#include <asm/mach-imx/qb.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> @@ -41,6 +42,9 @@ void spl_board_init(void)
>   	ret = ele_start_rng();
>   	if (ret)
>   		printf("Fail to start RNG: %d\n", ret);
> +
> +	if (IS_ENABLED(CONFIG_SPL_IMX_QB))

CONFIG_IS_ENABLED() ?

> +		spl_qb_save();
>   }
>   
>   void board_init_f(ulong dummy)
