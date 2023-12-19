Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE30C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1D4686EEB;
	Tue, 19 Dec 2023 12:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="S+kwdlQ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 312A586EEB; Tue, 19 Dec 2023 12:32:58 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45A8786D4C
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 12:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231219113248epoutp0480952a2b18d3728fcf52d23610a2c134~iOFoOXVOd1345613456epoutp04z
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:32:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231219113248epoutp0480952a2b18d3728fcf52d23610a2c134~iOFoOXVOd1345613456epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1702985568;
 bh=oL+QxswGDxOL/ZWz0X4f0uK/s3mdi1SpD34xNquADEg=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=S+kwdlQ0JysfyKWk6o+lRk08pCwiGu3N1YbOiZ0q+RyC9A2k/IxFEtjh92XgBWwHD
 6uba8qEAmLyDM009DBqRvg8fGoZ/4dZ1bsSS4V9g3vmLrvmpLx/heQyooMJey0i058
 NyAclLepRZD3IfyCz2dQ6w9fhUvo5WmhpB2RkQs4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20231219113247epcas2p33e4887a208041ffed3fb4d7c39efdcf8~iOFnjT-lh0487404874epcas2p3S;
 Tue, 19 Dec 2023 11:32:47 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.89]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SvZLR211Kz4x9Pv; Tue, 19 Dec
 2023 11:32:47 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 65.2A.10006.F5F71856; Tue, 19 Dec 2023 20:32:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20231219113246epcas2p40332c24a18d3a549751bc7c54701cdd3~iOFmdEM5g1885318853epcas2p42;
 Tue, 19 Dec 2023 11:32:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231219113246epsmtrp1174f705ed9126734cc941df1b52eaad6~iOFmbqg8P2015920159epsmtrp1O;
 Tue, 19 Dec 2023 11:32:46 +0000 (GMT)
X-AuditID: b6c32a45-3ebfd70000002716-2c-65817f5f57ff
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 E0.80.08755.E5F71856; Tue, 19 Dec 2023 20:32:46 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20231219113246epsmtip16a74f15b8937a7aaf35bb9baeab6c76a~iOFmLxrlp2787727877epsmtip1L;
 Tue, 19 Dec 2023 11:32:46 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Sam Protsenko'" <semen.protsenko@linaro.org>, "'Minkyu Kang'"
 <mk7.kang@samsung.com>, "'Tom Rini'" <trini@konsulko.com>, "'Lukasz
 Majewski'" <lukma@denx.de>, "'Sean Anderson'" <seanga2@gmail.com>
Cc: "'Simon Glass'" <sjg@chromium.org>, "'Heinrich Schuchardt'"
 <xypron.glpk@gmx.de>, <u-boot@lists.denx.de>
In-Reply-To: <20231213031646.28828-10-semen.protsenko@linaro.org>
Subject: RE: [PATCH 09/13] pinctrl: exynos: Add pinctrl support for Exynos850
Date: Tue, 19 Dec 2023 20:32:46 +0900
Message-ID: <006c01da326f$16b59ad0$4420d070$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
X-Drm-Type: PERSONAL
X-Msg-Type: PERSONAL
Thread-Index: AQJxF1WUQWvk8XWc6dZlUfJtoqni1wN7CWSIASQQbF+vXbWwEA==
x-delete-securityphrase: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmuW58fWOqwZMmbovn7y4zWXQcaWG0
 2HpvApPF8759TBbftmxjtJg6aTO7xdu9newWh6d+YHTg8JjdcJHFY96sEyweO2fdZff48DHO
 49WBVewed67tYfM4e2cHo0ffllWMARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqG
 lhbmSgp5ibmptkouPgG6bpk5QKcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrM
 C/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz1v/6wl4wT6zi/amFrA2M14S6GDk5JARMJHZ1nmbr
 YuTiEBLYwSixZfpaJgjnE6PEryUfWSCcb4wSC77tYoZpmbr4FlTVXkaJdx92QvW/YJR4s/A0
 C0gVm4C+xMuObawgCRGBs4wSZ26dYgdJMAvkSczYPwPI5uDgFHCUaGyvBAkLC/hLtP1YyQhi
 swioSlyY2w9m8wpYSsz+/5cdwhaUODnzCQvEGHmJ7W/nQF2kIPHz6TJWiLi4xMujR9gh4iIS
 D1d/hLNb750FqxcRcJJ4OH8FK0RcSmL265fsIHdKCLzhkFjeeYUNIuEi0TZpFZQtLPHq+BZ2
 mIaX/W1QdrFEV9slFojmBkaJ0+1XoBL2Ej9uTmEFeZJZQFNi/S59iOP4JDoO/wX7XUKAV6Kj
 TWgCo8osJK/NQvLaLCTvzEIYtICRZRWjWGpBcW56arFRgSE8upPzczcxgtOtlusOxslvP+gd
 YmTiYDzEKMHBrCTC67KoPlWINyWxsiq1KD++qDQntfgQoykwsCcyS4km5wMTfl5JvKGJpYGJ
 mZmhuZGpgbmSOO+91rkpQgLpiSWp2ampBalFMH1MHJxSDUz5ry9q+x21znTf1PlH7WlZ5t19
 C9lrm2RuqKcF7CurUppTesXhb1HGRIs5XvwyFx7xTYu9vJtj3ubta/J4Hz6pyTh5N1SzlGN1
 f6DCy+qJCwXvux1J2e7BaqpVrXFkjsVjAW7tj781dS797ZH7s+WB6gG5qMePuh+dd/b+4bFQ
 2TV7w7dA/7+JGjwilqdq1Oz4/P63/TL+6+7WFxLkobV9/uuQL0y6bht3Pnj8bZGh47/ogCD2
 H6fnKvi8sTNSSb/LIy+X86fi5PHIB/0n/mjdO7lH0D4oi23JY2Wx5d+VBORtFU+tORT9R/Fc
 R8Mtr5eFP3MnzlsTUTAlt/v4HRu31Qs5md0+1ycXWrumMCqxFGckGmoxFxUnAgB6MjiIQAQA
 AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWy7bCSnG5cfWOqwYanshbP311msug40sJo
 sfXeBCaL5337mCy+bdnGaDF10mZ2i7d7O9ktDk/9wOjA4TG74SKLx7xZJ1g8ds66y+7x4WOc
 x6sDq9g97lzbw+Zx9s4ORo++LasYAziiuGxSUnMyy1KL9O0SuDLW//rCXjBPrOL9qYWsDYzX
 hLoYOTkkBEwkpi6+xdTFyMUhJLCbUeJP5342iISsxLN3O9ghbGGJ+y1HWCGKnjFK9G5uZgZJ
 sAnoS7zs2AaWEBG4yCixpmEnI0iCWaBA4uL8a2wQHccYJebdbgSq4uDgFHCUaGyvBKkRFvCV
 uPz1Gtg2FgFViQtz+8F6eQUsJWb//8sOYQtKnJz5hAWklVlAT6JtI9R4eYntb+cwQxynIPHz
 6TJWmKP/HJ3LBlEjLvHy6BGoB0QkHq7+CPfMq+Nb4OKt986CzRERcJJ4OH8F1BwxiZnTLkPN
 l5KY/fol+wRGyVlILpqFcNEsJBfNQrJ5ASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT8
 3E2M4CSgpbmDcfuqD3qHGJk4GA8xSnAwK4nwuiyqTxXiTUmsrEotyo8vKs1JLT7EKM3BoiTO
 K/6iN0VIID2xJDU7NbUgtQgmy8TBKdXApMF+Rlj8tjfPxjv7Awpm3X97/XvfWY3rm6P/KWoY
 L4kwYks32WrH3VDAH6dYpaPW9r1EqGnpvKtTvRo2/2JVY55rrGKW9W/eThGnnSvtp67Yv/OY
 +c1n1vUNDTM2bPg3J8xh49TgWev++750MVwcdJCBk++055W7b2YYM7R5JRe+l7d+tOyIlvdf
 3ehHRdY71h/uWBMfdWIpk+r+m3t/hDiKL/GbtG3//nnrtCdVhlTnffxQz1Gx2W79xI8pObMY
 Atm4rlRPXin3bvYih4f9ku0n1H9WmxYfD5fdtqc8XTCVY3/kgXXte2OU7Bbb7ShRZ+pYHCO8
 +ekajdzbJzK87UQSq35M22uu5a3AXzFHQ4mlOCPRUIu5qDgRAJZlhvlxAwAA
X-CMS-MailID: 20231219113246epcas2p40332c24a18d3a549751bc7c54701cdd3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213031852epcas2p26c39b053e650e928ff43ad569e8da76c
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
 <CGME20231213031852epcas2p26c39b053e650e928ff43ad569e8da76c@epcas2p2.samsung.com>
 <20231213031646.28828-10-semen.protsenko@linaro.org>
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
> Subject: [PATCH 09/13] pinctrl: exynos: Add pinctrl support for Exynos850
> 
> Add pinctrl support for Exynos850 SoC. It was mostly extracted from
> corresponding Linux kernel code [1]. Power down modes and external
> interrupt data were removed while converting the code for U-Boot, but
> everything else was kept almost unchanged.
> 
> [1] drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/pinctrl/exynos/Kconfig             |   8 ++
>  drivers/pinctrl/exynos/Makefile            |   1 +
>  drivers/pinctrl/exynos/pinctrl-exynos850.c | 125 +++++++++++++++++++++
>  3 files changed, 134 insertions(+)
>  create mode 100644 drivers/pinctrl/exynos/pinctrl-exynos850.c
> 
> diff --git a/drivers/pinctrl/exynos/Kconfig
> b/drivers/pinctrl/exynos/Kconfig
> index a60f49869b45..1b7fb62bc4ba 100644
> --- a/drivers/pinctrl/exynos/Kconfig
> +++ b/drivers/pinctrl/exynos/Kconfig
> @@ -16,3 +16,11 @@ config PINCTRL_EXYNOS78x0
>  	help
>  	  Support pin multiplexing and pin configuration control on
>  	  Samsung's Exynos78x0 SoC.
> +
> +config PINCTRL_EXYNOS850
> +	bool "Samsung Exynos850 pinctrl driver"
> +	depends on ARCH_EXYNOS && PINCTRL_FULL
> +	select PINCTRL_EXYNOS
> +	help
> +	  Support pin multiplexing and pin configuration control on
> +	  Samsung's Exynos850 SoC.
> diff --git a/drivers/pinctrl/exynos/Makefile
> b/drivers/pinctrl/exynos/Makefile
> index 07db970ca942..3abe1226eb74 100644
> --- a/drivers/pinctrl/exynos/Makefile
> +++ b/drivers/pinctrl/exynos/Makefile
> @@ -6,3 +6,4 @@
>  obj-$(CONFIG_PINCTRL_EXYNOS)		+= pinctrl-exynos.o
>  obj-$(CONFIG_PINCTRL_EXYNOS7420)	+= pinctrl-exynos7420.o
>  obj-$(CONFIG_PINCTRL_EXYNOS78x0)	+= pinctrl-exynos78x0.o
> +obj-$(CONFIG_PINCTRL_EXYNOS850)		+= pinctrl-exynos850.o
> diff --git a/drivers/pinctrl/exynos/pinctrl-exynos850.c
> b/drivers/pinctrl/exynos/pinctrl-exynos850.c
> new file mode 100644
> index 000000000000..2445dd752ea8
> --- /dev/null
> +++ b/drivers/pinctrl/exynos/pinctrl-exynos850.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Linaro Ltd.
> + * Author: Sam Protsenko <semen.protsenko@linaro.org>
> + *
> + * Samsung Exynos USI driver (Universal Serial Interface).

Typo. It should be a subject for the pinctrl driver.

Otherwise,
Reviewed-by: Chanho Park <chanho61.park@samsung.com>

