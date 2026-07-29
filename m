Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A346C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 20:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B553280E4E;
	Wed, 29 Jul 2026 20:05:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tAZIuvVOg8OC; Wed, 29 Jul 2026 20:05:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE29980E36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785355555;
	bh=7vCraEqzgqhrvrdtBgnmpW7K6qMHfGOVpFOSd7JM8Cs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vpTak7be5/UZcwlV1wiwgu9RN9MCdsIwBKWaSx7tmtwy1FVZq5nXiWH1ErsKPiLNu
	 CvuFX7n9G5EqFlgM96wewM24pi/gxWYK3yfrtfOcfbc7hzHm/ssgepJpIEBAezxzvz
	 pSyHP1oL7qFiz2ghoSzBC+Nc3/LrEsJpgNyGW4cR9dnBU/GNtfWDeITT073sv1PHfy
	 AIiswPJMollY07oJyYu6j75N+Y9rKTcUoE1L7UZOvyr80w0TOK8jwo/ktEaxjTNSAu
	 V4MeqXGA1MEUOp14+GypbmS5Y6h9K8hpE6/hhfY44/6grhaY+sxAXQc8RsRZ5NveI7
	 tqC0C4cQcz0Lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE29980E36;
	Wed, 29 Jul 2026 20:05:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC0B02CE
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BDCC140395
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:05:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F9uak92FwFlV for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 20:05:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org ACB344009C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ACB344009C
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ACB344009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:05:52 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-446f87b6de1so731658fac.3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785355551; x=1785960351;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7vCraEqzgqhrvrdtBgnmpW7K6qMHfGOVpFOSd7JM8Cs=;
 b=E7HIapTk3vY5mm8nzo56LtY8JHS9W86Z84qqZzRXcYLbtQKUEDODfGdiyFtD5ZeKmD
 jHMuKsnP273rBSay9nHSMg/IL2F6Iq+eJsdGsaI/zo4X/SUFZiYdKhOxAzkxTHS3gL8L
 wPuVEVTjrRPtNv8m0lY9txGina5NvoDsQyMynL4JnhG2mX960qtAXnKFDKkcHFMwi2Zs
 A3WKNs5OC+NRv+SbHUG+BNt36QNXbCbpxkvImOZHu/VOVYxlA9gfEw+rsv710yKX+0O8
 ivIxnBjYs0WMiGTfmIfHUOpVqARdv1p5COvGMAkcP6QbzkNPngrJRzRFPn30HbuW84WC
 1p1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFWu3zjClv5ddtu06mMDtWddh5El0bv1Pyh3KC4Z1Vt+Ekbc3X5BYcU5Gt8Harxxd+jMSqUkI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzGdw3xxyKLz1cLM71847wTrijfZz4dxMGaxYPFsz/UTuFhlRMe
 UeqYmanXDZhKuKoFlfyIRDMtGpSVqk1MFNEcMkh690FKv5RoV25S1PHRCrIdxw78POQ=
X-Gm-Gg: AR+sD11aj78E1LFMP53qmHg2OvPju4q3lylUOz0wiVI3abUF7LwuyLB6/Z/uWqvnW5f
 Tgdrkebt9VlAp7Ekbj4DLjfvQAwv0TgUjV4YANvlpgKkYxXe8Oomh6hFUU/hhy+p6Zr6v6IL2i4
 c11huXuUJr6Vbw74c9ckZ1AvxV7TD9za9WdJyw7kz8rBVlkNym2QuvYuAH6sEzB948uOpa4TqDU
 USD1UtBZ8srato0bsYyt3LUhYZdmpZHRkosAv5l5B9rfXlyLr4ROVS6SDjVySMzi7M0kN843mxm
 oWoXWYdYojNIbecRSoC6LnnRj2lfRSwaCEM6SebojiARiijPdYQj0uyPNK9Zo90HJ1PVHwlTJCe
 eLzmUufaoXCuKRu2o3EDjNCxl+2m/Sr+moLdf3SEDoCOsKi4NPOuqAwnQpFhPV2QTQXOaFy8DbB
 asx1mC2ZyaqJjCC+Hyls+X3fExkQ/DjNmkLp3c5ECatYSf3RuXMmqehy25f6ihrMLrXvsaj5vuw
 DQXeZ9wJGmKwqBJDhgCbtsZKSqQyoh4RSp6rZs=
X-Received: by 2002:a05:6808:c1f7:b0:4ab:2abe:f031 with SMTP id
 5614622812f47-4ad86bcddc1mr34696b6e.6.1785355551177; 
 Wed, 29 Jul 2026 13:05:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3096:ee5f:6f57:afe1?
 ([2600:8803:e7e4:500:3096:ee5f:6f57:afe1])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ad6ecb596dsm2588823b6e.4.2026.07.29.13.05.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 13:05:50 -0700 (PDT)
Message-ID: <4723911e-66f3-4cea-86b2-1dc0befd8c6e@baylibre.com>
Date: Wed, 29 Jul 2026 15:05:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] video: mediatek: add mutex component
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>
References: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
 <20260728-add-genio-510-and-genio-700-hdmi-v1-4-ac54bd75f960@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260728-add-genio-510-and-genio-700-hdmi-v1-4-ac54bd75f960@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785355551; x=1785960351;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7vCraEqzgqhrvrdtBgnmpW7K6qMHfGOVpFOSd7JM8Cs=;
 b=EgTuTnL6+nhcuqFnJc39j7iuPwODC73iPW5cfVPTnVH0vjN8ynGoXURHAq0fSoUYyM
 sig6BP5Y1yN9OQLLrsh57ZBfNyAxjLxFs2KYFa3vo7HMbS7Amt/HoU1Cu1FejHV3ac1N
 UDIv+56UCIux7QANL4nLlJvSn7KjMJNHdPI1JxK1/aLVRGKQRc34Qz/BEKQrGLN5gyg+
 6x9DnfQHDnx/VFIXJg2Fr0TIjr9pO/TSqBbgk8lko7WvOgXufAvRxra7iF+XsDf7LMKo
 KctRlKBCDjeFJUtIBKbkOj9U+f/LDDbtX8q6L86HW9o+CRDedLpOwjZvapbIz2LrrE8Y
 lvag==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=EgTuTnL6
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/28/26 7:29 AM, Julien Stephan wrote:
> The display mutex synchronizes the components of the video pipeline
> on some MediaTek SoCs, such as the MT8188. Only the modules of the
> DPI1 pipeline are attached to mutex1; the module bit indices follow
> the Linux mtk-mutex driver (MT8188_MUTEX_MOD_DISP1_*).
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/video/mediatek/mtk_disp_mutex_mt8188.c | 63 ++++++++++++++++++++++++++
>  drivers/video/mediatek/mtk_disp_mutex_mt8188.h | 14 ++++++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/drivers/video/mediatek/mtk_disp_mutex_mt8188.c b/drivers/video/mediatek/mtk_disp_mutex_mt8188.c
> new file mode 100644
> index 00000000000..f7e52cd25bb
> --- /dev/null
> +++ b/drivers/video/mediatek/mtk_disp_mutex_mt8188.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Mediatek Video Disp Mutex Support
> + *
> + * Copyright (c) 2025 BayLibre, SAS.
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + */
> +
> +#include <dm.h>
> +
> +#include "mtk_disp_comp.h"
> +#include "mtk_disp_mutex_mt8188.h"
> +
> +#define DISP_MUTEX1_EN		0x40
> +#define DISP_MUTEX1_CTL		0x4c
> +#define MUTEX_SOF_DPI1		0x5
> +#define MUTEX_EOF_DPI1		(0x5 << 7)
> +#define DISP_MUTEX1_MOD0	0x50
> +#define DISP_MUTEX1_MOD1	0x54
> +
> +/*
> + * Modules attached to mutex1, bit indices as in the Linux mtk-mutex
> + * driver (MT8188_MUTEX_MOD_DISP1_*). MOD0 holds modules 0-31, MOD1
> + * holds modules 32-63.
> + */
> +#define MUTEX_MOD0_MDP_RDMA4	BIT(4)
> +#define MUTEX_MOD0_MDP_RDMA5	BIT(5)
> +#define MUTEX_MOD0_PADDING4	BIT(12)
> +#define MUTEX_MOD0_PADDING5	BIT(13)
> +#define MUTEX_MOD0_VPP_MERGE2	BIT(22)
> +#define MUTEX_MOD0_VPP_MERGE4	BIT(24)
> +#define MUTEX_MOD0_DISP_MIXER	BIT(30)
> +#define MUTEX_MOD1_DPI1		BIT(38 - 32)
> +
> +void mtk_disp_mutex_config(struct udevice *dev)
> +{
> +	/* the pipeline for the hdmi connection ends with DPI1 -> HDMI */
> +	mtk_disp_comp_write(dev, DISP_MUTEX1_CTL,
> +			    MUTEX_EOF_DPI1 | MUTEX_SOF_DPI1);
> +
> +	/* attach the modules of the DPI1 pipeline to mutex1 */
> +	mtk_disp_comp_write(dev, DISP_MUTEX1_MOD0,
> +			    MUTEX_MOD0_MDP_RDMA4 | MUTEX_MOD0_MDP_RDMA5 |
> +			    MUTEX_MOD0_PADDING4 | MUTEX_MOD0_PADDING5 |
> +			    MUTEX_MOD0_VPP_MERGE2 | MUTEX_MOD0_VPP_MERGE4 |
> +			    MUTEX_MOD0_DISP_MIXER);
> +	mtk_disp_comp_write(dev, DISP_MUTEX1_MOD1, MUTEX_MOD1_DPI1);
> +
> +	mtk_disp_comp_write(dev, DISP_MUTEX1_EN, 0x1);
> +}
> +
> +static const struct udevice_id mtk_disp_mutex_ids[] = {
> +	{ .compatible = "mediatek,mt8188-disp-mutex" },
> +	{}
> +};
> +
> +U_BOOT_DRIVER(mtk_disp_mutex) = {
> +	.name	   = "mtk_disp_mutex",
> +	.id	   = UCLASS_MISC,
> +	.of_match  = mtk_disp_mutex_ids,
> +	.probe	   = mtk_disp_comp_probe,
> +	.priv_auto = sizeof(struct mtk_disp_comp_priv),
> +};
> diff --git a/drivers/video/mediatek/mtk_disp_mutex_mt8188.h b/drivers/video/mediatek/mtk_disp_mutex_mt8188.h
> new file mode 100644
> index 00000000000..1739c0e2381
> --- /dev/null
> +++ b/drivers/video/mediatek/mtk_disp_mutex_mt8188.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 BayLibre, SAS.
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + */
> +
> +#ifndef _MTK_DISP_MUTEX_MT8188_H
> +#define _MTK_DISP_MUTEX_MT8188_H
> +
> +struct udevice;
> +
> +void mtk_disp_mutex_config(struct udevice *dev);

If this is really specific to mt8188, I would expect _mt8188
to be in the function name. Otherwise, if it is generic, I would
expect _mt8188 to not be in the file name.

> +
> +#endif
> 

