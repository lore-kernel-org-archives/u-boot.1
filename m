Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3EAC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:20:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE12D4055C;
	Wed, 26 Aug 2026 16:20:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eNbHPIstpnJ1; Wed, 26 Aug 2026 16:20:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787761226;
	bh=xEMNSiwg3AmMaMlNBx1ortkYw5Q4YIe4d57eJ7ub6kw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SxNR5lpYU9Nv3NDUtIZtRYKuNWWpaL7DrJeMD5aov1oR1E9gpRoJ0WgWKb/sGaVQX
	 AnwHkLWs5ORkSHrdQ/o5jQdt1insroUItgTzSql8WacArzrvQyTbjEPY2s+WKeAZKZ
	 5aSFrDgkHnx+CnExaE0MSWJ+Yk/mZ3lQ1TDdzEpI46VDtx/QdJfSTELBfg5GwsM3Bf
	 8ITDzxdlxbRukq29lkAJ49P6Fov3PLdClCvkz+RJ97fj5c/Y0prQIdqcE8UKrVK/Fr
	 KZrJsDeSGEG1nukfnabZKlHs7I8qsiYlXE2DyIFLy2FaXAyu8R2+yBK697IaNfC74m
	 HXdF/LtafDNuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D7584051D;
	Wed, 26 Aug 2026 16:20:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7213D341
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:20:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58436400DC
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:20:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g-RkISPHVIuY for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:20:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=PM6NCciB
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7124C400C2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:20:23 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7eb6573bd52so1256610a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787761222; x=1788366022;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xEMNSiwg3AmMaMlNBx1ortkYw5Q4YIe4d57eJ7ub6kw=;
 b=PM6NCciBX7/JQtEXuI1SpHdX/CvAg+xBdOv0QYZUckMyRKiJm9mff9jmIoqq9EY0HD
 6kpfH8sAwi8jBMvYDbKhiQH5u4nEN8GfBMkhkMXG0aOzDA0lgZUcE/R/jMFDHN3RInb4
 EMZ5tESzO3wR0O5UneR9WvS0kk5ORCROc3G3icbTwoDlwBS9GkYVnT4o17ACdB/f8PGk
 VWRkVkPJQ2Z/IRcr6PqeYUmoHLkNfOjdb5d81bkUnw1Z19blOpPQBNpOob+9DZ/Q3Fwp
 SCx3vt9dDUvVPg6ElL7Vd9PT14wpy1xop+nXtOv27IPa8C2IEySFO73QWNRdr+mnAUBh
 zlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787761222; x=1788366022;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xEMNSiwg3AmMaMlNBx1ortkYw5Q4YIe4d57eJ7ub6kw=;
 b=Z2X9LO5nCoQ0cOEs1I+RZFGR1NM9akQb0iBk/RBNobY7kXRMzwmVe+pX3i3owS9NA6
 NG85W8MG42mo75DRbUnwjLynSHyd0YWphazuDxgREnT+GMbjdyemghh3+QTLT0MqiKK4
 81XO8qRZQfKjxvsFihgmyr/cLZLQK9Ui1IVj/24p6koWWdUY1pTb7Uke3gez48C4Nbzq
 LJz4i8oAEnLW2SGg43B+mFt8Ac5aO5WqAv/LeVDJMmijRxr8kVg/akdSTACvDOLPxy6J
 7h0XhBqo1kg5gP6VkqZsjc9F1ICkPk5f+/iRfAev5pp4lkkL2tCxVTdhL6A2kGQoViWo
 UZew==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqz/+pm9TjG7q3VhVjWCa50kdoapESIPQpB1ouRFUWsqnhixBgHryhpZA8bLea66soeRDqmcno=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++llGoUt7VNS5Ax6TTh98t0XrDcSjIby0JSleqMwJ73V7lUaVjeh
 GIaGhhlp96/b/BnuvGavnEEnKGdDHFZnbbEwLQo2XAKx8RTnuPE6R7Jq/C0okwaRSUk=
X-Gm-Gg: AR+sD117RkKPgBmo/0o1Gk8mGJYyUgg6WevTy95Fx78s+5YIi6/5lvCKea9cdayglx0
 1UiU4NepvkYxMeGJHVbGDMGhGq7ku7tnd3RYCnyPQMEXH5UO76brVJt4sU/do1/o1bFAeSmeZk2
 UYrF7actq6Rt20zZ3kf/NlxJdR6KYR2Eg/yqNP2TEISgjI6kygc1tS+JVg/51P2EdhH+VYSzoFL
 e3dZg16U7S6mu23FHh4WTNfy3fwMo0Mad9ZktgyWOYzeWBHi7WcmSHm45AQkzI0L8ex5U5nOoL4
 Rf/udjNonQQ5D6itLP+QSNy6ffnbS4sWzyDc/TT64lvotEZzYnFmr6JOxgYGQZo/5iCljAnmMxQ
 Q/06BjG6jd1TRlqqIRXOl5scCc6CM8yECNhuG1PIjqsVZMyYaS1oos5kpOo2nP7nBCmLUA5fCvM
 nZwCkwiGGW8AKZlxs2DmCx9HIf98pmHGWG8L4QPK07Wh5J0NTnf4HMRG3mB0gCReqsEH+MAhxlr
 u3/FWzBPKWThofC6kj1AZpqvyPgiZ+aroI+rrf4
X-Received: by 2002:a05:6830:2aa5:b0:7e9:e8a6:6389 with SMTP id
 46e09a7af769-7f4c4bd5adcmr9175752a34.4.1787761221962; 
 Wed, 26 Aug 2026 09:20:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:162c:81fd:da88:2ea6?
 ([2600:8803:e7e4:500:162c:81fd:da88:2ea6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c818350dsm1945446a34.3.2026.08.26.09.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 09:20:21 -0700 (PDT)
Message-ID: <81f26515-d649-4e83-86aa-03a640e2a84c@baylibre.com>
Date: Wed, 26 Aug 2026 11:20:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] video: mediatek: add mutex component
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
 <20260826-add-genio-510-and-genio-700-hdmi-v2-4-68ebb1bf17df@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-4-68ebb1bf17df@baylibre.com>
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
> The display mutex synchronizes the components of the video pipeline
> on some MediaTek SoCs, such as the MT8188. Only the modules of the
> DPI1 pipeline are attached to mutex1; the module bit indices follow
> the Linux mtk-mutex driver (MT8188_MUTEX_MOD_DISP1_*).
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/video/mediatek/mtk_disp_mutex.c | 63 +++++++++++++++++++++++++++++++++
>  drivers/video/mediatek/mtk_disp_mutex.h | 14 ++++++++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/drivers/video/mediatek/mtk_disp_mutex.c b/drivers/video/mediatek/mtk_disp_mutex.c
> new file mode 100644
> index 00000000000..8619d9491a2
> --- /dev/null
> +++ b/drivers/video/mediatek/mtk_disp_mutex.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Mediatek Video Disp Mutex Support
> + *
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + */
> +
> +#include <dm.h>
> +
> +#include "mtk_disp_comp.h"
> +#include "mtk_disp_mutex.h"
> +
> +#define DISP_MUTEX1_EN		0x40
> +#define DISP_MUTEX1_CTL		0x4c

This currently hard-codes use of mutex1, but DSI will also use this driver
with mutex0. Might as well make it support both now to avoid churn later.

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
> diff --git a/drivers/video/mediatek/mtk_disp_mutex.h b/drivers/video/mediatek/mtk_disp_mutex.h
> new file mode 100644
> index 00000000000..cbf8a9f0537
> --- /dev/null
> +++ b/drivers/video/mediatek/mtk_disp_mutex.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + */
> +
> +#ifndef _MTK_DISP_MUTEX_H
> +#define _MTK_DISP_MUTEX_H
> +
> +struct udevice;
> +
> +void mtk_disp_mutex_config(struct udevice *dev);
> +
> +#endif
> 

