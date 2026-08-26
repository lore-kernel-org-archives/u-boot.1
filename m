Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFA0C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB26F405A3;
	Wed, 26 Aug 2026 16:12:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 35cIg9tccdhf; Wed, 26 Aug 2026 16:12:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787760726;
	bh=XSgCGL+a14TJPzUYG8hrhpFBBv7U6fJjWzwIo3Thlug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EZtRTBSIp2Be2tFmsSRn3aDlI5QL1YwsTk+OJx6uGsormyZfXC2PddRLSxtKBzx8q
	 75oAo4pjXHfBq+25G7oEsBHomaaENu2z1ama51oFtGdRUF++WiW5GHk8Fqprl5ud/t
	 UbH5P7G2XlzeDHDXKmeB6QZ37pn2BwkE5ZVpSR16R+JHE/YWz1eux699SgmC/myk0C
	 kntTLDxOPvyjVenrJttrJB0B0fB2YNFSSITqaG33XuQs7gqCPoVbGsModQBxsTKe16
	 IL7iIEoZL/LI6hMw+oVvQ2Q5hevhDlzfvKoLK/3OXLD/SzhiFC8ZxMxD8veFqYOHh4
	 CauvV6bOuz6Ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 098C540555;
	Wed, 26 Aug 2026 16:12:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E47C039E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D66D440118
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:12:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Av2GzRNiHLme for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:12:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=D9YbtX0q
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C747E400C2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:12:03 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e9f69ee6f4so1299512a34.2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787760722; x=1788365522;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XSgCGL+a14TJPzUYG8hrhpFBBv7U6fJjWzwIo3Thlug=;
 b=D9YbtX0qI6XhF1oMQZNx7n34G0jTjhp26j5xWT2cpAsHfQjVNX0+NRiYY9zui1HgCx
 0bG9QQjUPcPOJa97tQDeDKXpcfMS+7m2iWEIdKQeYYN6+JaPzeFO8pLv4qSCnJWHEZmO
 MXqAXP3k46RDmvhC0D/dLxZkojdHTIUEArgaj/ItbYwtKQhVN4FZQ70MKxPocJsXsmZR
 SCJW9LygcnLnIEjY2NlEMvk5ePGQjOOcNV67Pq5FtTV8/1YhpEP9ixD9IvOryHlMdkXj
 bnloIh7G2OZFCFR21dI+7NzjFhL8geQbIcb53OXYm+TxqX6TIuN/+9pdrmqPgSCvrab0
 TMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787760722; x=1788365522;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XSgCGL+a14TJPzUYG8hrhpFBBv7U6fJjWzwIo3Thlug=;
 b=tZiZx1ZQ/jxJCchemuHPsWdl93LNQ4FDnYPJ8lof6PRd9GIcX230lulXHjcTnoupuV
 DMaaSxjEVTEFAfyIPDyAtSJ0QXQEPDbxBxJ5/9Ptsv8HahKAW8CjG02hJA4cCPJBYbQU
 oYx9o+eHPBem8i1AMq38lWYUQckmkLYHXdV+mVadRkd2I83scV/eXHeoGVymbs4UYgRP
 iYTHLLgCW2AKq1gjHo+i4N7cAVwm68RBRhSYdwAIW3T9jRHKUTxuWBvt3MWNtUCQe5C4
 575XKZeuQN4LKbjHQur155Dsaq7o3vn/dtUsIXZy6oFveI1IiRd2e3IM9XaAwmeSK8lJ
 JLYw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqz0KNbxQXn3aAizdTUTYmcimhhYnLMSO6gykSXfnLfUniDqiXOCBkNHkj5qk/FScI8enT4w5E=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kNYIem+u9b6s7kAFEBmJatKcZ2TjFyihVcfPbVxNV0u+BavLIv
 wD5G3sWTGvioX00U88hYCXx322Iucz2nciT+M+fkiVtXc45M1La8/EbTQDTUwHG2t/8=
X-Gm-Gg: AR+sD11IO/ykv+UMHGNdTtSYMzBr85tCnUt1P0XngQOG4O+1ER0ZIbPm5qor9ra9sfQ
 i0QiG6crvWHh7avaY+88n3KE1E/9hG2QVuIGrC9R0j58iAgIgsUkErk2IGMgPc3pJvbKyi2rfxo
 +epPbk3hyN6gs3uqctLGklY8bLs2R35LCRoCgZGSBSMPGXFg25uUjCX9++rQOyUi33Mwu+Lkt0z
 HIE1mI+lZoZy2kXhCqHDN/v38mTx26JcyebfTHpvYwfx/jVJMgLlfxHYOQFu+zil6AbkoCyjQF5
 n1Qjhu1j5QAid4g5mVaSgSXt5QV/bZ/wSzTEZHxgRG+irIOuWYCKuoPb5GBdFH8ZhAOkxrTlstm
 ulylTgWoGztne8wdF7V0aUWeQBIYEVlTRwKgSJMXErL32VHgE/WltsAMsZUEwNZMrsbsK6Frx8p
 qqJzY0EvPa9uoiiABfg94qGtuq6ICPdgMIlmo0BaK3kPAHO9PacgBx7RD9u+PBHGEAncIsEdVsw
 ZrcjD32Y/IpvF5nW6q/BbH85zaqtUNvDCvF9CE=
X-Received: by 2002:a05:6820:2f02:b0:6ae:aa38:a0aa with SMTP id
 006d021491bc7-6b1a053bcb6mr6077250eaf.32.1787760722354; 
 Wed, 26 Aug 2026 09:12:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:162c:81fd:da88:2ea6?
 ([2600:8803:e7e4:500:162c:81fd:da88:2ea6])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1a2655462sm2111358eaf.11.2026.08.26.09.12.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 09:12:01 -0700 (PDT)
Message-ID: <c969185e-1e95-49ef-ab20-a02871ab2a67@baylibre.com>
Date: Wed, 26 Aug 2026 11:12:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] video: mediatek: add ethdr component
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
 <20260826-add-genio-510-and-genio-700-hdmi-v2-2-68ebb1bf17df@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-2-68ebb1bf17df@baylibre.com>
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
> The ETHDR is one of the components of the video pipeline on some
> MediaTek SoCs, such as the MT8188. Only its mixer sub-block is used,
> which is the block's first register window.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/video/mediatek/mtk_ethdr.c | 76 ++++++++++++++++++++++++++++++++++++++
>  drivers/video/mediatek/mtk_ethdr.h | 16 ++++++++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/drivers/video/mediatek/mtk_ethdr.c b/drivers/video/mediatek/mtk_ethdr.c
> new file mode 100644
> index 00000000000..531c95f53a1
> --- /dev/null
> +++ b/drivers/video/mediatek/mtk_ethdr.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Mediatek Video ETHDR support
> + *
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + */
> +
> +#include <dm.h>
> +
> +#include "mtk_disp_comp.h"
> +#include "mtk_ethdr.h"
> +
> +#define MIX_EN			0xc
> +#define MIX_ROI_SIZE		0x18
> +#define MIX_DATAPATH_CON	0x1c
> +#define OUTPUT_NO_RND		BIT(3)
> +#define SOURCE_RGB_SEL		BIT(7)
> +#define BACKGROUND_RELAY	(4 << 9)
> +#define MIX_ROI_BGCLR		0x20
> +#define BGCLR_BLACK		0xff000000
> +#define MIX_SRC_CON		0x24
> +
> +#define MIX_SRC_L2_EN		BIT(2)
> +#define L2_SRC_SEL		(2 << 20)
> +#define L2_OUT_SEL		(2 << 22)
> +
> +#define MIX_FUNC_DCM0		0x120
> +#define MIX_UPD_REG_CK_EN	BIT(0)
> +#define MIX_FUNC_DCM1		0x124
> +#define BG_CLR_CK_EN		BIT(7)
> +#define MIX_CK_EN		BIT(9)
> +#define MIX_FUNC_DCM_ENABLE	0xffffffff
> +
> +#define MIX_L2_CON		0x58
> +#define NON_PREMULTI_SOURCE	(2 << 12)
> +#define MIX_L2_SRC_SIZE		0x60

A few of these macros are unused compare to the Linux implementation. If
that was on purpose we, should probably just remove those macros.

> +
> +void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height)
> +{
> +	/* enable internal clocks */
> +	mtk_disp_comp_write(dev, MIX_FUNC_DCM0, MIX_FUNC_DCM_ENABLE);
> +	mtk_disp_comp_write(dev, MIX_FUNC_DCM1, MIX_FUNC_DCM_ENABLE);
> +
> +	/* enable mixer */
> +	mtk_disp_comp_write(dev, MIX_EN, 0x1);
> +
> +	mtk_disp_comp_write(dev, MIX_ROI_SIZE, (height << 16) | width);
> +	mtk_disp_comp_write(dev, MIX_DATAPATH_CON,
> +			    OUTPUT_NO_RND | SOURCE_RGB_SEL);
> +	mtk_disp_comp_write(dev, MIX_L2_SRC_SIZE, (height << 16) | width);
> +	mtk_disp_comp_write(dev, MIX_ROI_BGCLR, BGCLR_BLACK);
> +
> +	/* only configure L2 since only rdma4 and rdma5 are used */
> +	mtk_disp_comp_write(dev, MIX_L2_CON, NON_PREMULTI_SOURCE);
> +	mtk_disp_comp_write(dev, MIX_SRC_CON,
> +			    MIX_SRC_L2_EN | L2_SRC_SEL | L2_OUT_SEL);
> +}
> +
> +static const struct udevice_id mtk_ethdr_ids[] = {
> +	{ .compatible = "mediatek,mt8188-disp-ethdr" },

We should be able to make this "mediatek,mt8195-disp-ethdr" (the fallback)
so that we don't have to keep adding more compatibles.

> +	{}

nit: patches are inconsistent with style for this. I would prefer `{ }`
as that seems to be the most common.

> +};
> +
> +/*
> + * The mixer is the first register window ("mixer" in reg-names) of the
> + * ethdr block, so binding the ethdr node with default register index 0
> + * gives the mixer registers.
> + */
> +U_BOOT_DRIVER(mtk_ethdr) = {
> +	.name	   = "mtk_ethdr",
> +	.id	   = UCLASS_MISC,
> +	.of_match  = mtk_ethdr_ids,
> +	.probe	   = mtk_disp_comp_probe,
> +	.priv_auto = sizeof(struct mtk_disp_comp_priv),
> +};
> diff --git a/drivers/video/mediatek/mtk_ethdr.h b/drivers/video/mediatek/mtk_ethdr.h
> new file mode 100644
> index 00000000000..038c658a704
> --- /dev/null
> +++ b/drivers/video/mediatek/mtk_ethdr.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Mediatek Video ETHDR support
> + *
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + */
> +
> +#ifndef _MTK_ETHDR_H
> +#define _MTK_ETHDR_H
> +
> +struct udevice;
> +
> +void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height);
> +
> +#endif
> 

