Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865BFC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5681760767;
	Wed, 26 Aug 2026 16:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N09LCLnpQSOj; Wed, 26 Aug 2026 16:17:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787761075;
	bh=CKY2nj/9E4zn5uYqktcgILMyHPJ+2ZuUUsGpA63tI4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VYJeTZ5EJclRnx4s5GSmUBDOY0vjnfOqzQ6sARUvkZ9EeVGYU/njXC54y7erHrdYX
	 jtD/PfLMl7vw/+AY5s1+g1xFI9AVx8m6oUjT2ZxJ02OxXq/hYL8U8LlZoHXvp3jXjK
	 SIHejeuGMT1qa1SgjXjwiASPVEO78f49EFqJ3woE6hcUuq6gqcstgn4rxzmSQo1iWM
	 bJd4TLQWRnE1y/knoYB0b14Xu6SNx1AoKf64abCQV9q/1NYzza+PUy+gOdy8cHzi5h
	 CYOaNzNofpgfa/jMbrzuMr9jDkIq+1Z2nqi4hCNoIqee4eNTz7aguuiv93W5RS83qz
	 Cd96d7qpKGU8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB4D86073D;
	Wed, 26 Aug 2026 16:17:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B0E329B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C7F14056F
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qkwgjciFHo0V for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:17:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lFBA1RwX
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29FA940437
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:17:51 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4472500e25fso677073fac.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787761071; x=1788365871;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CKY2nj/9E4zn5uYqktcgILMyHPJ+2ZuUUsGpA63tI4A=;
 b=lFBA1RwXWQatjgUjwyFFnRBckFpP58MN8Xqlk/+ony6YYwlJoGczfqjQs+m61PIeDb
 yAvOC8a/CZHmnAwr4aEOr+7ttGi0F4zVw+g+73tQXGgikS4ZPCuQVuYeMv4kTTG7fQ4/
 CZIacUz5BjIbknoc6EToLPcG0hqI+O3mjcebf82boobvkpoWQOvJqYFpIxLTnXyE6TEr
 Jnq6jKFQZUaaB6oikkQ8ZY7gVAuNLZTamr1taU9/gnFOsDz/fvsidCQ36vMzmkpqUHla
 30+MsmYz8IfvVllE9uKQf9nOlNsS274ssFawO+4p4Gi8ayiqHwMgJHcFxUBUqSwyJHQ5
 57cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787761071; x=1788365871;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CKY2nj/9E4zn5uYqktcgILMyHPJ+2ZuUUsGpA63tI4A=;
 b=mNdCrREokREp91teV2dJ8g9sb/mIgFyNUQKCVmexcWe8y6iS0ItAjDdEIjnuk3r2zm
 h3xIDKUBF/A6asvs1U/9m1eF3sEmWECEg1pRm2X0xS+qH1sv4Mw0OCrbl3E92fRo/V+m
 yeuDxUy8TjZdBrKzwXraLhuQroQf14l9H794Mg/B+/V1Y+cXJwKt299qeju0kKNMWPtr
 f0lArBaY3audYEX3G48iE5iGBcC/6OqsuBdyjmkWa/K8eZrBVrcEUBoThEhUiHtAah0d
 LQ0iPBtBDVaSWcHiaVzwC2JM2ZkEmO7uwYPBekUF5+tbmSsMMAi/rqKok4Xr+9TXuQFf
 JtNg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoykUXuFJG2qeKtko53cPE+Z3pugZR7S83kW2SCGJzmbgC+9IFLtInjIjF5noNc82BmSIjK2Zg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nGA0B1kHFGLkFtzw5jygcg0v6vo3ezfF8Iu5FDW5Se52ZG+fJY
 5p1eaq2qtoP4jSpXi840kbefJ3weYE/8XJXaXnzPzbEZDmuwd4rNW4vjsqcTzpmQ/XI=
X-Gm-Gg: AR+sD11ynVphDLD8X9ThUsPx3Ma22Ni+Seks19qLDrEvEZEmIiLuGbF65ZTuedrNCeX
 S010ocG8yIQ1TzcITe/f20jawPrB1KyesOdIHwTAVm4mnALEDfZZk9go6Oh4dK7MOE/aYZhERTd
 U6fAyvk3FMvdJh/2dAcIh+ZvWmymEixUD/wK8W0DsLnWybe7RdsQx+1Vob5enob2xrc+7pZ3pJ9
 7KyGgIu/65FGDh0P4lmvZFkfl0XXt9SEIOeqEVMtHSjfHWqcUZ3Nwd5pZkzWGxXbDAs37+CB+CY
 eLx2UXrcK2v9bT7tRv86E3F8QhBwO/J+LWEBVfCUQfCRI3rnD6sxmwwggKKCgRTa1X2kcWS3vxF
 ijDFCE2zBG1wHowiZu+gROYYousuFiKXaypl0ecks3d7qqu3V8KJYohCr97dMEhnTT6ogVRKbeu
 L0Kvlr9CxZcm3Nw93wpuSACqFG3VJNZh0sYd8sj/89OVhBjyGU+3KO55YUiZVC5NHaye79N/8YF
 +VWmmjySw0E08Irw3LJ9qPxuyho3K//Pem1CyrtNwbotGWTMw==
X-Received: by 2002:a05:6870:148c:b0:45e:d529:40cc with SMTP id
 586e51a60fabf-4659b6add19mr8564209fac.18.1787761070737; 
 Wed, 26 Aug 2026 09:17:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:162c:81fd:da88:2ea6?
 ([2600:8803:e7e4:500:162c:81fd:da88:2ea6])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465afa1f342sm2494920fac.9.2026.08.26.09.17.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 09:17:50 -0700 (PDT)
Message-ID: <b878c1c0-4e70-4a98-9242-e0edcaea091b@baylibre.com>
Date: Wed, 26 Aug 2026 11:17:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] video: mediatek: add merge component
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
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
 <20260826-add-genio-510-and-genio-700-hdmi-v2-3-68ebb1bf17df@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-3-68ebb1bf17df@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 8/26/26 8:09 AM, Julien Stephan wrote:
> The merge block is one of the components of the video pipeline on
> some MediaTek SoCs, such as the MT8188. It combines two half-width
> inputs into one output.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/video/mediatek/mtk_disp_merge.c | 106 ++++++++++++++++++++++++++++++++
>  drivers/video/mediatek/mtk_disp_merge.h |  19 ++++++
>  2 files changed, 125 insertions(+)
> 
> diff --git a/drivers/video/mediatek/mtk_disp_merge.c b/drivers/video/mediatek/mtk_disp_merge.c
> new file mode 100644
> index 00000000000..185e75231fc
> --- /dev/null
> +++ b/drivers/video/mediatek/mtk_disp_merge.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Mediatek Video Disp Merge Support
> + *
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + */
> +
> +#include <dm.h>
> +
> +#include "mtk_disp_comp.h"
> +#include "mtk_disp_merge.h"
> +
> +/* MERGE registers */
> +#define SUBDISP_DISP_MERGE_ENABLE	0x000
> +#define SUBDISP_DISP_MERGE_CFG_0	0x010
> +#define SUBDISP_DISP_MERGE_CFG_1	0x014
> +#define SUBDISP_DISP_MERGE_CFG_4	0x020
> +#define SUBDISP_DISP_MERGE_CFG_10	0x038
> +#define SUBDISP_DISP_MERGE_CFG_12	0x040
> +#define CFG_10_10_2PI_2PO_BUF_MODE	0x08
> +#define CFG_11_10_1PI_2PO_MERGE		0x12

nit: these CFG macros use decimal format in linux.

> +#define SUBDISP_DISP_MERGE_CFG_24	0x070
> +#define SUBDISP_DISP_MERGE_CFG_25	0x074
> +#define SUBDISP_DISP_MERGE_CFG_26	0x078
> +#define SUBDISP_DISP_MERGE_CFG_27	0x07C
> +#define SUBDISP_DISP_MERGE_CFG_30	0x088
> +#define SUBDISP_DISP_MERGE_MUTE_0	0xf00
> +
> +void mtk_disp_merge_config(struct udevice *dev,
> +			   u16 width1, u16 height1,
> +			   u16 width2, u16 height2,
> +			   u16 output_width, u16 output_height)
> +{
> +	bool dual_input = (width2 != 0 && height2 != 0);
> +
> +	/* input 1 */
> +	if (width1 != 0 && height1 != 0)
> +		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_0,
> +				    height1 << 16 | width1);
> +
> +	/* input 2 */
> +	if (dual_input)
> +		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_1,
> +				    height2 << 16 | width2);
> +
> +	/* output */
> +	mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_4,
> +			    output_height << 16 | output_width);
> +
> +	/* no pixel/channel swap */
> +	mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_10, 0x0);
> +
> +	if (dual_input)
> +		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_12,
> +				    CFG_11_10_1PI_2PO_MERGE);
> +	else
> +		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_12,
> +				    CFG_10_10_2PI_2PO_BUF_MODE);
> +
> +	/* size in sram of inputs 0 and 1 */
> +	if (width1 != 0 && height1 != 0)
> +		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_24,
> +				    height1 << 16 | width1);
> +
> +	if (dual_input)
> +		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_25,
> +				    height2 << 16 | width2);
> +	else
> +		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_25,
> +				    height1 << 16 | width1);
> +
> +	/* merged size of inputs 0 and 1 */
> +	if (width1 != 0 && height1 != 0)
> +		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_26,
> +				    height1 << 16 | width1);
> +
> +	if (dual_input)
> +		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_27,
> +				    height2 << 16 | width2);
> +	else
> +		mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_27,
> +				    height1 << 16 | width1);
> +
> +	/* 12 bit lsb off */
> +	mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_CFG_30, 0x0);
> +
> +	/* unmute */
> +	mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_MUTE_0, 0x0);
> +
> +	/* enable */
> +	mtk_disp_comp_write(dev, SUBDISP_DISP_MERGE_ENABLE, 0x1);
> +}
> +
> +static const struct udevice_id mtk_disp_merge_ids[] = {
> +	{ .compatible = "mediatek,mt8188-disp-merge" },

This can use the mt8195 fallback too.

> +	{}
> +};
> +
> +U_BOOT_DRIVER(mtk_disp_merge) = {
> +	.name	   = "mtk_disp_merge",
> +	.id	   = UCLASS_MISC,
> +	.of_match  = mtk_disp_merge_ids,
> +	.probe	   = mtk_disp_comp_probe,
> +	.priv_auto = sizeof(struct mtk_disp_comp_priv),
> +};
> diff --git a/drivers/video/mediatek/mtk_disp_merge.h b/drivers/video/mediatek/mtk_disp_merge.h
> new file mode 100644
> index 00000000000..cac3982c74e
> --- /dev/null
> +++ b/drivers/video/mediatek/mtk_disp_merge.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Mediatek Video Disp Merge Support
> + *
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + */
> +
> +#ifndef _MTK_DISP_MERGE_H
> +#define _MTK_DISP_MERGE_H
> +
> +struct udevice;
> +
> +void mtk_disp_merge_config(struct udevice *dev,
> +			   u16 width1, u16 height1,
> +			   u16 width2, u16 height2,
> +			   u16 output_width, u16 output_height);
> +
> +#endif
> 

