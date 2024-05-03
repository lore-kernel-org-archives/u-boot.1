Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415F4C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 08:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 710D5884F3;
	Fri,  3 May 2024 10:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="MddSJIkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54B9488A3F; Fri,  3 May 2024 10:41:21 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 676518826B
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 10:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1714725679; x=1717317679;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o6m/LMKcwfxRi1ajudSf0VgxHpa2ehW+zm5wUW2bs94=;
 b=MddSJIkQf7l35r2J9GhuKwQQZGnab1lMoXb1Ml5apCTxtv7xzqaRCoHRod5tCwH8
 iVfKA//vPbnQI//N18PS67h3xvcVxYVGx35yhCY/n5dPLq9ivyQgUFAlSsX6XC6J
 AJtz/XGO4q8aPYPvRwHzXTUTpCA7spEUi0CjY30cfWU=;
X-AuditID: ac14000a-fbefe7000000290d-79-6634a32ea8ff
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id EE.AB.10509.E23A4366;
 Fri,  3 May 2024 10:41:18 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 3 May 2024
 10:41:17 +0200
Message-ID: <1f633960-1a3e-4336-b8a7-66bfdefc1399@phytec.de>
Date: Fri, 3 May 2024 10:41:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: Make USB_GADGET_MANUFACTURER consistent over all
 PHYTEC boards
To: Benjamin Hahn <B.Hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yannic Moog <y.moog@phytec.de>, Tom Rini <trini@konsulko.com>, Martyn Welch
 <martyn.welch@collabora.com>, Parthiban Nallathambi <parthitce@gmail.com>,
 Fabio Estevam <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
References: <20240503-wip-bhahn-bspimx8m-3196-v1-1-855c7242151f@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240503-wip-bhahn-bspimx8m-3196-v1-1-855c7242151f@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWyRpKBR1d/sUmawe4+ZouHV/0tHlzsYrE4
 s/YUi8XUSZvZLd7u7WS36H6n7sDmsePuEkaPnbPusnu8OrCK3ePsnR2MHv3dLawBrFFcNimp
 OZllqUX6dglcGRM7/jAWbJeqOPP4BGsDY5N4FyMnh4SAicTbi/fZuhi5OIQEljBJdK5sZ4Rw
 7jBKLDr+jhWkilfARuLQ8VXMIDaLgIrEnHM/GCHighInZz5hAbFFBeQl7t+awQ5iCwvESZxt
 bgebKiLQySTxYuteoAYODmYBM4kJn5NBaoQEvCQOtu0Em88sIC5x68l8JhCbTUBd4s6Gb2Bx
 TgFviXVTp7BA1FhILH5zkB3ClpfY/nYOM8QceYkXl5azQHwjLzHt3GtmCDtUYuuX7UwTGIVn
 ITl1FpJ1s5CMnYVk7AJGllWMQrmZydmpRZnZegUZlSWpyXopqZsYQVEjwsC1g7FvjschRiYO
 xkOMEhzMSiK82pON04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzru4IThUSSE8sSc1OTS1ILYLJ
 MnFwSjUwOphO1FYSFluxJq5kn7Fb9EaZ6/vSZlgtz3rzf5f3raMJ26oOLJ+3NpnT6wVno6z1
 9P03tMp+HvjuW/ZeqUswtmO6quD0zOAjL9mPTlv03rRw2qlF0Ucm3NpslKwauW+P2RKd/DVR
 sY1MXzV4gi8I9vlPfNypXWg9WWNRfsGBhWcmh3BZ/72wWomlOCPRUIu5qDgRAKHHm5eIAgAA
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



Am 03.05.24 um 09:00 schrieb Benjamin Hahn:
> Set CONFIG_USB_GADGET_MANUFACTURER to PHYTEC for all PHYTEC boards.
> 
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

Acked-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   configs/phycore-imx8mp_defconfig     | 2 +-
>   configs/phycore_am64x_a53_defconfig  | 2 +-
>   configs/phycore_am64x_r5_defconfig   | 2 +-
>   configs/phycore_pcl063_defconfig     | 2 +-
>   configs/phycore_pcl063_ull_defconfig | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
> index e9a287cb441f..9f42edd72324 100644
> --- a/configs/phycore-imx8mp_defconfig
> +++ b/configs/phycore-imx8mp_defconfig
> @@ -147,7 +147,7 @@ CONFIG_USB_DWC3=y
>   CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_STORAGE=y
>   CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_MANUFACTURER="FSL"
> +CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
>   CONFIG_USB_GADGET_VENDOR_NUM=0x0525
>   CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
>   CONFIG_IMX_WATCHDOG=y
> diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
> index 1a9359773b45..9b52f8ad0644 100644
> --- a/configs/phycore_am64x_a53_defconfig
> +++ b/configs/phycore_am64x_a53_defconfig
> @@ -159,7 +159,7 @@ CONFIG_USB_CDNS3=y
>   CONFIG_USB_CDNS3_GADGET=y
>   CONFIG_USB_CDNS3_HOST=y
>   CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> +CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
>   CONFIG_USB_GADGET_VENDOR_NUM=0x0451
>   CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
>   CONFIG_USB_GADGET_DOWNLOAD=y
> diff --git a/configs/phycore_am64x_r5_defconfig b/configs/phycore_am64x_r5_defconfig
> index 61d784fa17f6..15a7e7089e73 100644
> --- a/configs/phycore_am64x_r5_defconfig
> +++ b/configs/phycore_am64x_r5_defconfig
> @@ -171,7 +171,7 @@ CONFIG_USB_STORAGE=y
>   CONFIG_SPL_USB_STORAGE=y
>   CONFIG_USB_GADGET=y
>   CONFIG_SPL_USB_GADGET=y
> -CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> +CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
>   CONFIG_USB_GADGET_VENDOR_NUM=0x0451
>   CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
>   CONFIG_USB_GADGET_DOWNLOAD=y
> diff --git a/configs/phycore_pcl063_defconfig b/configs/phycore_pcl063_defconfig
> index 017054a8e12b..2f6b158a6772 100644
> --- a/configs/phycore_pcl063_defconfig
> +++ b/configs/phycore_pcl063_defconfig
> @@ -62,7 +62,7 @@ CONFIG_IMX_THERMAL=y
>   CONFIG_USB=y
>   CONFIG_SPL_USB_HOST=y
>   CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_MANUFACTURER="Phytec"
> +CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
>   CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
>   CONFIG_USB_GADGET_PRODUCT_NUM=0x4fff
>   CONFIG_CI_UDC=y
> diff --git a/configs/phycore_pcl063_ull_defconfig b/configs/phycore_pcl063_ull_defconfig
> index b3da43a5bf1e..b42a410da69c 100644
> --- a/configs/phycore_pcl063_ull_defconfig
> +++ b/configs/phycore_pcl063_ull_defconfig
> @@ -53,7 +53,7 @@ CONFIG_IMX_THERMAL=y
>   CONFIG_USB=y
>   CONFIG_SPL_USB_HOST=y
>   CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_MANUFACTURER="Phytec"
> +CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
>   CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
>   CONFIG_USB_GADGET_PRODUCT_NUM=0x4fff
>   CONFIG_CI_UDC=y
> 
> ---
> base-commit: 6fdb021f148f598a67eb3cac5e3eb4a569cdaacd
> change-id: 20240503-wip-bhahn-bspimx8m-3196-c1ebd0bab6ac
> 
> Best regards,
