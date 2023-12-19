Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A6DC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B808875F0;
	Tue, 19 Dec 2023 12:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="VPmAuecl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC807875F0; Tue, 19 Dec 2023 12:39:01 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E106B876A2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 12:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231219113854epoutp037711a3d1873a12f0b1dc8f1a9e931b5c~iOK8yW5Kh2373823738epoutp03Q
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:38:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231219113854epoutp037711a3d1873a12f0b1dc8f1a9e931b5c~iOK8yW5Kh2373823738epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1702985934;
 bh=O0OwC2eltDWIw35pQoAP7RAy5B/89PTvEmyGzgrOhUI=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=VPmAuecldhBfcH3qlFKsTeFqcxFcK9yNwaFEKtRH7k4PbmmbhnTNRDeZ3zfV++nJ1
 2lFRcGyYYM4aQpfPtZqsXWIR3QP1qAOGBVUB0zZ9EQpoH3lWJ+WIt/5vrXyw3lrLLt
 9+dSjsFj9bGS6iZodw2B0A2M3KumU4ckgAngdTQM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20231219113853epcas2p3eca21e9c10e3c7bc199d0c6341b2381c~iOK8YxGAm2380123801epcas2p3P;
 Tue, 19 Dec 2023 11:38:53 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SvZTT1jZLz4x9Pp; Tue, 19 Dec
 2023 11:38:53 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 F7.53.09607.DC081856; Tue, 19 Dec 2023 20:38:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20231219113851epcas2p4f4e758bc834255ffd80c31818e2e3343~iOK6rfqpK2454224542epcas2p4b;
 Tue, 19 Dec 2023 11:38:51 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231219113851epsmtrp2616b763c566e54b0d8e770476f02ebdc~iOK6q2nDS2201622016epsmtrp2m;
 Tue, 19 Dec 2023 11:38:51 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-bc-658180cdac7d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 DD.2C.18939.BC081856; Tue, 19 Dec 2023 20:38:51 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20231219113851epsmtip16d0618d829b89216ca1a657f9badab92~iOK6erPzO2571225712epsmtip1j;
 Tue, 19 Dec 2023 11:38:51 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Sam Protsenko'" <semen.protsenko@linaro.org>, "'Minkyu Kang'"
 <mk7.kang@samsung.com>, "'Tom Rini'" <trini@konsulko.com>, "'Lukasz
 Majewski'" <lukma@denx.de>, "'Sean Anderson'" <seanga2@gmail.com>
Cc: "'Simon Glass'" <sjg@chromium.org>, "'Heinrich Schuchardt'"
 <xypron.glpk@gmx.de>, <u-boot@lists.denx.de>
In-Reply-To: <20231213031646.28828-8-semen.protsenko@linaro.org>
Subject: RE: [PATCH 07/13] clk: exynos: Add Samsung clock framework
Date: Tue, 19 Dec 2023 20:38:51 +0900
Message-ID: <006e01da326f$f07ea040$d17be0c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
X-Drm-Type: PERSONAL
X-Msg-Type: PERSONAL
Thread-Index: AQJxF1WUQWvk8XWc6dZlUfJtoqni1wJ9/RaGAWZXJTivY401cA==
x-delete-securityphrase: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmue7ZhsZUg+tTOC2ev7vMZNFxpIXR
 Yuu9CUwWz/v2MVl827KN0WLqpM3sFm/3drJbHJ76gdGBw2N2w0UWj3mzTrB47Jx1l93jw8c4
 j1cHVrF73Lm2h83j7J0djB59W1YxBnBEZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoa
 WlqYKynkJeam2iq5+AToumXmAJ2mpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkw
 L9ArTswtLs1L18tLLbEyNDAwMgUqTMjO+DTjCVvBbuuK1v4DzA2MOwy6GDk4JARMJBa2xHcx
 cnEICexglNg/fzorhPOJUaJ353FGOOfE1DVAGU6wjs/vzrJBJHYySlyZdJEdJCEk8IJRYtJ1
 MRCbTUBf4mXHNrBRIgJnGSXO3DoFVsQskCcxY/8MMJtTwEFiyaJHTCC2sICzxJf9V9hAbBYB
 VYld+1ezgtzHK2Apsep0GEiYV0BQ4uTMJywQY+Qltr+dwwxxkILEz6fLWCHi4hIvjx5hh4iL
 SDxc/RHObr13FqxeRMBJYt7E81DPSEnMfv2SHeROCYEXHBJHGy4zQiRcJGZPugRlC0u8Or6F
 Habh87u9bBB2sURX2yUWiOYGRonT7VegiuwlftycAvYAs4CmxPpd+hDH8Ul0HP7LDgl3XomO
 NqEJjCqzkLw2C8lrs5C8Mwth0AJGllWMYqkFxbnpqcVGBSbwyE7Oz93ECE61Wh47GGe//aB3
 iJGJg/EQowQHs5IIr8ui+lQh3pTEyqrUovz4otKc1OJDjKbAsJ7ILCWanA9M9nkl8YYmlgYm
 ZmaG5kamBuZK4rz3WuemCAmkJ5akZqemFqQWwfQxcXBKNTAZlUSoTyj+6r9ohUin5qf2lmNl
 n7pvTLSfz74o9wqfKFdF6cVfdYw2nr4JATaHNY/sOvFzzszUXeqpMu4sojlteQ9cKtQUWDs0
 iv6vOnLJ7ZDl2fCmSTc2syzcI7Sn6ZjMSb6F9h9C3hmGNUi/WhC6by6fxfw5bq+6WU4/KN2w
 6N4Uo/OfevPSZTfkTe9Oz3j+r/TChSjZ2pVTQwx+tz+7P+/X/Mc8/Ha8UTpC95L4miJdzv2J
 2fLwXJGu7M97GbXO4k+1+KU4nyyzzS0Kj7vK/2+K311h1Yt/rltf6juuI6T8ULxG0GXRp8WP
 f7hlOFon2nE2nNArc30stHTHk+f3D54IvprQ1zi75qHW8RIlluKMREMt5qLiRABy29afPgQA
 AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCSnO7phsZUg975phbP311msug40sJo
 sfXeBCaL5337mCy+bdnGaDF10mZ2i7d7O9ktDk/9wOjA4TG74SKLx7xZJ1g8ds66y+7x4WOc
 x6sDq9g97lzbw+Zx9s4ORo++LasYAziiuGxSUnMyy1KL9O0SuDI+zXjCVrDbuqK1/wBzA+MO
 gy5GTg4JAROJz+/OsoHYQgLbGSXOPbKCiMtKPHu3gx3CFpa433KEtYuRC6jmGaNE35XNYAk2
 AX2Jlx3bwBIiAhcZJdY07GQESTALFEhcnH+NDaLjKKNE0+wOZpAEp4CDxJJFj5hAbGEBZ4kv
 +6+ArWYRUJXYtX810CQODl4BS4lVp8NAwrwCghInZz5hAQkzC+hJtG2EGi8vsf3tHGaI4xQk
 fj5dxgpz9J+jc9kgasQlXh49AvWAiMTD1R/hnnl1fAtcvPXeWbA5IgJOEvMmnoeaIyYxc9pl
 qPlSErNfv2SfwCg5C8lFsxAumoXkollINi9gZFnFKJpaUJybnptcYKhXnJhbXJqXrpecn7uJ
 ERz7WkE7GJet/6t3iJGJg/EQowQHs5IIr8ui+lQh3pTEyqrUovz4otKc1OJDjNIcLErivMo5
 nSlCAumJJanZqakFqUUwWSYOTqkGJg/ucl19mf61CvUbLrD7fUv8YRNn/YVDad10/d9aul/v
 3CpQZpu0/Na0n0GscZ51AUL7fHtF1qmE6rXrvdHvqFWQt25Z3xWderagjrUnJX3uRq3MqVPT
 XNLZKhc+6DTLyT4q9ejmhZotnayfWKVeH088kRja+3RffW3w2+kFv5p9T1+p7nt5IlbwlNoM
 4aRHzp+MW/x2Pl8ieXf9/LzF2l6Kf2ylYmfWzmjrYyib879g3XObNKFaf7X+ot7yjalXPY9H
 GBzJZny6lWWPSuTjBe+dnoR1ixn75bmV31ze3uxkG17hkKzTx3cjIOnk3D17F3eIh0qmqD4U
 Uvc48levb9eGVX9e78k6UGajYqTEUpyRaKjFXFScCACVOMZVbAMAAA==
X-CMS-MailID: 20231219113851epcas2p4f4e758bc834255ffd80c31818e2e3343
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213031832epcas2p17caec6a1a70ecdfcef2a359fb732dcb2
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
 <CGME20231213031832epcas2p17caec6a1a70ecdfcef2a359fb732dcb2@epcas2p1.samsung.com>
 <20231213031646.28828-8-semen.protsenko@linaro.org>
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

> -----Original Message-----
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Sam Protsenko
> Sent: Wednesday, December 13, 2023 12:17 PM
> To: Minkyu Kang <mk7.kang@samsung.com>; Tom Rini <trini@konsulko.com>;
> Lukasz Majewski <lukma@denx.de>; Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>; Heinrich Schuchardt
> <xypron.glpk@gmx.de>; u-boot@lists.denx.de
> Subject: [PATCH 07/13] clk: exynos: Add Samsung clock framework
> 
> Heavily based on Linux kernel Samsung clock framework, with some changes
> to accommodate the differences in U-Boot CCF implementation. It's also
> quite minimal as compared to the Linux version.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/clk/exynos/Makefile  |   9 +-
>  drivers/clk/exynos/clk-pll.c | 167 +++++++++++++++++++++++++
>  drivers/clk/exynos/clk-pll.h |  23 ++++
>  drivers/clk/exynos/clk.c     | 121 +++++++++++++++++++
>  drivers/clk/exynos/clk.h     | 228 +++++++++++++++++++++++++++++++++++
>  5 files changed, 546 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/clk/exynos/clk-pll.c
>  create mode 100644 drivers/clk/exynos/clk-pll.h
>  create mode 100644 drivers/clk/exynos/clk.c
>  create mode 100644 drivers/clk/exynos/clk.h
> 
> diff --git a/drivers/clk/exynos/Makefile b/drivers/clk/exynos/Makefile
> index 7faf238571ef..04c5b9a39e16 100644
> --- a/drivers/clk/exynos/Makefile
> +++ b/drivers/clk/exynos/Makefile
> @@ -1,6 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  #
>  # Copyright (C) 2016 Samsung Electronics
> -# Thomas Abraham <thomas.ab@samsung.com>
> +# Copyright (C) 2023 Linaro Ltd.
> +#
> +# Authors:
> +#   Thomas Abraham <thomas.ab@samsung.com>
> +#   Sam Protsenko <semen.protsenko@linaro.org>
> 
> -obj-$(CONFIG_CLK_EXYNOS7420)	+= clk-exynos7420.o
> +obj-$(CONFIG_$(SPL_TPL_)CLK_CCF)	+= clk.o clk-pll.o
> +obj-$(CONFIG_CLK_EXYNOS7420)		+= clk-exynos7420.o
> diff --git a/drivers/clk/exynos/clk-pll.c b/drivers/clk/exynos/clk-pll.c
> new file mode 100644
> index 000000000000..9e496ff83aaf
> --- /dev/null
> +++ b/drivers/clk/exynos/clk-pll.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2016 Samsung Electronics
> + * Copyright (C) 2023 Linaro Ltd.
> + *
> + * Authors:
> + *   Thomas Abraham <thomas.ab@exynos.com>

Need to correct Thomas's email to samsung.com if you want to keep his
original credit even though his e-mail was already stale since he left the
company.

> + *   Sam Protsenko <semen.protsenko@linaro.org>
> + *
> + * This file contains the utility functions to register the pll clocks.
> + */
> +
> +#include <asm/io.h>
> +#include <div64.h>
> +#include <malloc.h>
> +#include <clk-uclass.h>
> +#include <dm/device.h>
> +#include <clk.h>
> +#include "clk.h"
> +
> +#define UBOOT_DM_CLK_SAMSUNG_PLL0822X	"samsung_clk_pll0822x"
> +#define UBOOT_DM_CLK_SAMSUNG_PLL0831X	"samsung_clk_pll0831x"
> +
> +struct samsung_clk_pll {
> +	struct clk		clk;
> +	void __iomem		*con_reg;
> +	enum samsung_pll_type	type;
> +};
> +
> +#define to_clk_pll(_clk) container_of(_clk, struct samsung_clk_pll, clk)
> +
> +/*
> + * PLL0822x Clock Type
> + */
> +
> +#define PLL0822X_MDIV_MASK		0x3ff
> +#define PLL0822X_PDIV_MASK		0x3f
> +#define PLL0822X_SDIV_MASK		0x7
> +#define PLL0822X_MDIV_SHIFT		16
> +#define PLL0822X_PDIV_SHIFT		8
> +#define PLL0822X_SDIV_SHIFT		0
> +
> +static unsigned long samsung_pll0822x_recalc_rate(struct clk *clk)
> +{
> +	struct samsung_clk_pll *pll = to_clk_pll(clk);
> +	u32 mdiv, pdiv, sdiv, pll_con3;
> +	u64 fvco = clk_get_parent_rate(clk);
> +
> +	pll_con3 = readl_relaxed(pll->con_reg);
> +	mdiv = (pll_con3 >> PLL0822X_MDIV_SHIFT) & PLL0822X_MDIV_MASK;
> +	pdiv = (pll_con3 >> PLL0822X_PDIV_SHIFT) & PLL0822X_PDIV_MASK;
> +	sdiv = (pll_con3 >> PLL0822X_SDIV_SHIFT) & PLL0822X_SDIV_MASK;
> +
> +	fvco *= mdiv;
> +	do_div(fvco, (pdiv << sdiv));
> +	return (unsigned long)fvco;
> +}
> +
> +static const struct clk_ops samsung_pll0822x_clk_min_ops = {
> +	.get_rate = samsung_pll0822x_recalc_rate,
> +};
> +
> +/*
> + * PLL0831x Clock Type
> + */
> +
> +#define PLL0831X_KDIV_MASK		0xffff
> +#define PLL0831X_MDIV_MASK		0x1ff
> +#define PLL0831X_PDIV_MASK		0x3f
> +#define PLL0831X_SDIV_MASK		0x7
> +#define PLL0831X_MDIV_SHIFT		16
> +#define PLL0831X_PDIV_SHIFT		8
> +#define PLL0831X_SDIV_SHIFT		0
> +#define PLL0831X_KDIV_SHIFT		0
> +
> +static unsigned long samsung_pll0831x_recalc_rate(struct clk *clk)
> +{
> +	struct samsung_clk_pll *pll = to_clk_pll(clk);
> +	u32 mdiv, pdiv, sdiv, pll_con3, pll_con5;
> +	s16 kdiv;
> +	u64 fvco = clk_get_parent_rate(clk);
> +
> +	pll_con3 = readl_relaxed(pll->con_reg);
> +	pll_con5 = readl_relaxed(pll->con_reg + 8);
> +	mdiv = (pll_con3 >> PLL0831X_MDIV_SHIFT) & PLL0831X_MDIV_MASK;
> +	pdiv = (pll_con3 >> PLL0831X_PDIV_SHIFT) & PLL0831X_PDIV_MASK;
> +	sdiv = (pll_con3 >> PLL0831X_SDIV_SHIFT) & PLL0831X_SDIV_MASK;
> +	kdiv = (s16)((pll_con5 >> PLL0831X_KDIV_SHIFT) &
> PLL0831X_KDIV_MASK);
> +
> +	fvco *= (mdiv << 16) + kdiv;
> +	do_div(fvco, (pdiv << sdiv));
> +	fvco >>= 16;
> +
> +	return (unsigned long)fvco;
> +}
> +
> +static const struct clk_ops samsung_pll0831x_clk_min_ops = {
> +	.get_rate = samsung_pll0831x_recalc_rate,
> +};
> +
> +static struct clk *_samsung_clk_register_pll(void __iomem *base,
> +					const struct samsung_pll_clock
*pll_clk)
> +{
> +	struct samsung_clk_pll *pll;
> +	struct clk *clk;
> +	const char *drv_name;
> +	int ret;
> +
> +	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pll->con_reg = base + pll_clk->con_offset;
> +	pll->type = pll_clk->type;
> +	clk = &pll->clk;
> +	clk->flags = pll_clk->flags;
> +
> +	switch (pll_clk->type) {
> +	case pll_0822x:
> +		drv_name = UBOOT_DM_CLK_SAMSUNG_PLL0822X;
> +		break;
> +	case pll_0831x:
> +		drv_name = UBOOT_DM_CLK_SAMSUNG_PLL0831X;
> +		break;
> +	default:
> +		kfree(pll);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	ret = clk_register(clk, drv_name, pll_clk->name, pll_clk-
> >parent_name);
> +	if (ret) {
> +		kfree(pll);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return clk;
> +}
> +
> +void samsung_clk_register_pll(void __iomem *base,
> +			      const struct samsung_pll_clock *clk_list,
> +			      unsigned int nr_clk)
> +{
> +	unsigned int cnt;
> +
> +	for (cnt = 0; cnt < nr_clk; cnt++) {
> +		struct clk *clk;
> +		const struct samsung_pll_clock *pll_clk;
> +
> +		pll_clk = &clk_list[cnt];
> +		clk = _samsung_clk_register_pll(base, pll_clk);
> +		clk_dm(pll_clk->id, clk);
> +	}
> +}
> +
> +U_BOOT_DRIVER(samsung_pll0822x_clk) = {
> +	.name	= UBOOT_DM_CLK_SAMSUNG_PLL0822X,
> +	.id	= UCLASS_CLK,
> +	.ops	= &samsung_pll0822x_clk_min_ops,
> +	.flags	= DM_FLAG_PRE_RELOC,
> +};
> +
> +U_BOOT_DRIVER(samsung_pll0831x_clk) = {
> +	.name	= UBOOT_DM_CLK_SAMSUNG_PLL0831X,
> +	.id	= UCLASS_CLK,
> +	.ops	= &samsung_pll0831x_clk_min_ops,
> +	.flags	= DM_FLAG_PRE_RELOC,
> +};
> diff --git a/drivers/clk/exynos/clk-pll.h b/drivers/clk/exynos/clk-pll.h
> new file mode 100644
> index 000000000000..3b477369aeb8
> --- /dev/null
> +++ b/drivers/clk/exynos/clk-pll.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2016 Samsung Electronics
> + * Copyright (C) 2023 Linaro Ltd.
> + *
> + * Authors:
> + *   Thomas Abraham <thomas.ab@exynos.com>

Ditto.

Othewise,
Reviewed-by: Chanho Park <chanho61.park@samsung.com>

