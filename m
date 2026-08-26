Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3768C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85B7640550;
	Wed, 26 Aug 2026 16:29:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iN8TIVTH2C_S; Wed, 26 Aug 2026 16:29:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787761781;
	bh=s26RSoHhq6cgOJVWWihO/N0LYxghjKozD3sg7VlIAc8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ziOHPcZ246pS/uHgznAVmlYwjua5DorealtLTYi5SrgJEsU9dcDKOrq2DWbr+iCo6
	 tq250qCWf7SaN5wlP29cz9XPt41dzXeDlobC4e/oGQDZaWV/e/0skFQSGT7hpUOpQb
	 /bjmbxacInhtfdzGGGQOk8I3EAYwbD6IX9leqDswwxFSHG6k6MrfLtPiDggzucN/Aj
	 YrqTkWe68Ntj9sHtX2DHrXgF9R/51W8ZSUBNUZ0OaMeLx5XxFbeJ378BZ6Qn0TEX0c
	 eHmLZcIQvd1S3LWWp2XJH0va+qDoHTcLQbi4zOKcDIgFW4u5Xt8MotCIE0pX35HoPd
	 TyivFaZa12qaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2DF44052E;
	Wed, 26 Aug 2026 16:29:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BED2B341
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A546F80AEA
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:29:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qb_k5esIOehW for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:29:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=c7lSWtOA
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9921F80AAB
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:29:39 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-44cf70de986so911000fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787761778; x=1788366578;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s26RSoHhq6cgOJVWWihO/N0LYxghjKozD3sg7VlIAc8=;
 b=c7lSWtOADCBtMbhZa3pllYw59qSHXyVHQBoNg94rx+dumJxoQsE7fsvdR8jAn42HgC
 DklDJ3RklzJ2XODcPPZY40BlWivgfzzJ56TRNQD31B7JI3Ve2bE2TlHKcpnMdw4MxEv6
 NaN576vqIoi3BSebAhBGFkLgqoeZRNf/m5jSsSgwG05w/q6oY3M7PoQOLho0/+Kknyni
 oz0LKRCVNZ41GZqk/VSnBnVQ4BPKaeXSkFnndjTC/emx+ZIq93f0sxCoaPPPd04TgZhn
 e4Qge+zaDZLvP+xF0bUWUGNUijO6ehuVjgOXrXl5ZzIh3W9ZyNaYBTNmtWNHdzpSrA4n
 h7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787761778; x=1788366578;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s26RSoHhq6cgOJVWWihO/N0LYxghjKozD3sg7VlIAc8=;
 b=eV+d11XFtCMIRmnNmgP/zuEpwAVvNJRhH3iGwDD9+23BP6FqDP0S01jCiCVFgzIljd
 L437/V6tCPNGSGifVZ2XHpeVq1fDlux4dH5JJAOsh8uGSaB+YwupoPW1N2R7Fvqss1gL
 7Vc3IbXQJgq8L4/eaE9iXlc4+QB6T/ZzHeNEYrHKce2YfWsvHreV6Xpza/2qaLHpjrkg
 J4mE7J3V6aasS0bI0TkY5bQFEsL13CQidAvLD1dQWp0J0TJT3IYfuM2vcP2HWOR8NCan
 AMV9clMv4a1YkcrALJg0YbaI6ud8NTkZGoyBXtEZxAcMZLoxyMY8fIy+vI1ovOsQ6/wb
 ybvw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9IgqTBvTHTvNcrDzONOxksNrXsqxZf+g2XDGOTNBhznNTI+5pACnji1OOOKpPO9F0Fghk0P8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lBsLIalK1zGmSou9HdTkudbrv+RBaXnam7ajyDkVmkqJkSowKI
 4Ht70VCyYUp3E2yeIckEmKRh43+mpvjWvLFiaeSwVTT9M6rlMNmo7yugjQ2fh7TqVCc=
X-Gm-Gg: AR+sD10ClnNg8ofMZJxr8mgsdpL9R73IC3eGA/NNrCuqQ3WYCLOGFZurRrt9Qscszv7
 1jBcpI9JpIDhfA9tnkesl+tLIY2enz/Qxg3j+hKcQY9opaz4/ODW2jJbmdY3OvPfU7Cm8zjBUB2
 PbL1tWORCrV799orbcONDiAufSUBzTviovp+B44QG8l9wE8W9H71BcqjFa4AKH9bp0x4MEaawD0
 vfF5wPMstU/Tax2p/Rl/WjrlxQX5tGDDMOK3myuWgtrz1W+JMEVorF+K1+aLi1lkUBx09ibUG/+
 HJaZxbWs1IMmyq9RWh2cau6WQ/vDNCvTcwKiHz4eCqAZ09ygUJFwDdBSwMEiYZUFcmFUqNQ1hJ1
 DDmq4b8tAXmnCUL74gvk7kHmAWNqOmauyMwOHAy27+FVk8TZBfLR/VMlZnKqiXBVBuEhj3q5AEz
 kbh/Q0w1bdqIRY01bQvOmHASgu0i2WrL0we+V68yS9meIou1zgT7DmRnim8Eeq58I9f4Wui6Kuy
 axX+dwiaYEpUoyCkvSG8Wvj6UQaHbZUTFKS7m5I5qYOcgSOBw==
X-Received: by 2002:a05:6870:c251:b0:456:9fdc:a86 with SMTP id
 586e51a60fabf-4659a8d9ff8mr7790522fac.10.1787761777843; 
 Wed, 26 Aug 2026 09:29:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:162c:81fd:da88:2ea6?
 ([2600:8803:e7e4:500:162c:81fd:da88:2ea6])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465ad9f3711sm2612766fac.3.2026.08.26.09.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 09:29:29 -0700 (PDT)
Message-ID: <27ca94c2-f4d3-4bc0-862c-6077ed33e0c6@baylibre.com>
Date: Wed, 26 Aug 2026 11:29:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] video: mediatek: add rdma component
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
 <20260826-add-genio-510-and-genio-700-hdmi-v2-6-68ebb1bf17df@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-6-68ebb1bf17df@baylibre.com>
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
> The MDP RDMA is the DMA engine reading the framebuffer on some
> MediaTek SoCs, such as the MT8188. Two instances are used, each
> reading one half of the frame; the second one starts at the middle of
> the line (apply_offset).
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/video/mediatek/mtk_mdp_rdma.c | 97 +++++++++++++++++++++++++++++++++++
>  drivers/video/mediatek/mtk_mdp_rdma.h | 20 ++++++++
>  2 files changed, 117 insertions(+)
> 
> diff --git a/drivers/video/mediatek/mtk_mdp_rdma.c b/drivers/video/mediatek/mtk_mdp_rdma.c
> new file mode 100644
> index 00000000000..eb8b673477f
> --- /dev/null
> +++ b/drivers/video/mediatek/mtk_mdp_rdma.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Mediatek Video MDP RDMA Support
> + *
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + */
> +
> +#include <dm.h>
> +#include <video.h>
> +
> +#include "mtk_disp_comp.h"
> +#include "mtk_mdp_rdma.h"
> +
> +/* MDP RDMA registers */
> +#define MDP_RDMA_EN				0x0000
> +#define MDP_RDMA_EN_ENABLE			BIT(0)
> +#define MDP_RDMA_EN_DISABLE			0
> +#define MDP_RDMA_EN_INTERNAL_DCM_EN		GENMASK(23, 4)
> +
> +#define MDP_RDMA_SRC_CON			0x0030
> +#define MDP_RDMA_SRC_FORMAT_BGRA8888		2

Shouldn't this be XRGB888?

> +#define MDP_RDMA_SRC_CON_SRC_FORMAT(x)		((x) & GENMASK(3, 0))
> +#define MDP_RDMA_ENABLE_UNIFORM_CONFIG		BIT(17)
> +#define MDP_RDMA_ENABLE_ARGB_OUTPUT		BIT(25)
> +
> +#define MDP_RDMA_SRC_BASE_0			0x0f00
> +#define MDP_RDMA_MF_BKGD_SIZE_IN_BYTE		0x0060
> +#define MDP_RDMA_MF_SRC_SIZE			0x0070
> +#define MDP_RDMA_MF_CLIP_SIZE			0x0078
> +#define MDP_RDMA_SRC_OFFSET_0			0x0118
> +
> +#define MDP_RDMA_CON				0x0020
> +#define MDP_RDMA_CON_SIMPLE_MODE		BIT(4)
> +
> +#define MDP_RDMA_TRANSFORM_0			0x0200
> +#define MDP_RDMA_TRANSFORM_BITEXTEND_ZERO	BIT(15)
> +
> +#define FB_BYTES_PER_PIXEL			4
> +
> +void mtk_mdp_rdma_config(struct udevice *dev, struct video_uc_plat *plat,
> +			 const struct display_timing *timing,
> +			 bool apply_offset)
> +{
> +	u32 width = timing->hactive.typ;
> +	u32 height = timing->vactive.typ;
> +	u32 fb = plat->base;

This breaks if base is ever above 4GB. It probably shouldn't be since it is
used with DMA, but might not hurt to error if it is out of range rather
than silently using the wrong address.

> +	int offset = apply_offset ? ((width / 2) * FB_BYTES_PER_PIXEL) : 0;
> +
> +	mtk_disp_comp_write(dev, MDP_RDMA_EN, MDP_RDMA_EN_INTERNAL_DCM_EN);
> +
> +	/* set source format and output bit depth */
> +	mtk_disp_comp_write(dev, MDP_RDMA_SRC_CON,
> +			    MDP_RDMA_SRC_CON_SRC_FORMAT(MDP_RDMA_SRC_FORMAT_BGRA8888) |
> +			    MDP_RDMA_ENABLE_ARGB_OUTPUT |
> +			    MDP_RDMA_ENABLE_UNIFORM_CONFIG);
> +
> +	/* set base address */
> +	mtk_disp_comp_write(dev, MDP_RDMA_SRC_BASE_0, fb);
> +
> +	/* stride: aligned width * bytes-per-pixel */
> +	mtk_disp_comp_write(dev, MDP_RDMA_MF_BKGD_SIZE_IN_BYTE,
> +			    ALIGN(width, 4) * FB_BYTES_PER_PIXEL);

Should we be using priv->line_length here" from patch 11 (and make sure
line_length is aligned)?

> +
> +	/*
> +	 * each of the two RDMAs reads one half of the frame: size and
> +	 * clip cover half the width, and the second RDMA (apply_offset)
> +	 * starts at the middle of the line
> +	 */
> +	mtk_disp_comp_write(dev, MDP_RDMA_MF_SRC_SIZE,
> +			    (height << 16) | (width / 2));
> +	mtk_disp_comp_write(dev, MDP_RDMA_MF_CLIP_SIZE,
> +			    (height << 16) | (width / 2));
> +	mtk_disp_comp_write(dev, MDP_RDMA_SRC_OFFSET_0, offset);
> +
> +	/* simple mode + zero bit extension for 8bit -> 10bit */
> +	mtk_disp_comp_write(dev, MDP_RDMA_CON, MDP_RDMA_CON_SIMPLE_MODE);
> +	mtk_disp_comp_write(dev, MDP_RDMA_TRANSFORM_0,
> +			    MDP_RDMA_TRANSFORM_BITEXTEND_ZERO);
> +
> +	/* enable engine */
> +	mtk_disp_comp_write(dev, MDP_RDMA_EN,
> +			    MDP_RDMA_EN_INTERNAL_DCM_EN | MDP_RDMA_EN_ENABLE);
> +}
> +
> +static const struct udevice_id mtk_mdp_rdma_ids[] = {
> +	{ .compatible = "mediatek,mt8188-vdo1-rdma" },

Another one where the mt8189 fallback should work.

> +	{}
> +};
> +
> +U_BOOT_DRIVER(mtk_mdp_rdma) = {
> +	.name	   = "mtk_mdp_rdma",
> +	.id	   = UCLASS_MISC,
> +	.of_match  = mtk_mdp_rdma_ids,
> +	.probe	   = mtk_disp_comp_probe,
> +	.priv_auto = sizeof(struct mtk_disp_comp_priv),
> +};
> diff --git a/drivers/video/mediatek/mtk_mdp_rdma.h b/drivers/video/mediatek/mtk_mdp_rdma.h
> new file mode 100644
> index 00000000000..aa2585e9c27
> --- /dev/null
> +++ b/drivers/video/mediatek/mtk_mdp_rdma.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Mediatek Video MDP RDMA Support
> + *
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + */
> +
> +#ifndef _MTK_MDP_RDMA_H
> +#define _MTK_MDP_RDMA_H
> +
> +struct udevice;
> +struct video_uc_plat;
> +struct display_timing;
> +
> +void mtk_mdp_rdma_config(struct udevice *dev, struct video_uc_plat *plat,
> +			 const struct display_timing *timing,
> +			 bool apply_offset);
> +
> +#endif
> 

