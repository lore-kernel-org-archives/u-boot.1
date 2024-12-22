Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668A7E77188
	for <u-boot@archiver.kernel.org>; Sun, 22 Dec 2024 23:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED8A80655;
	Mon, 23 Dec 2024 00:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="n6G3bZxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A3EF8069A; Mon, 23 Dec 2024 00:49:24 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5AA080654
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 00:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20241222234918epoutp02b7a12e6fb161495d5c0d1ace21e0eb8f~TpLA82hwW2689926899epoutp02T
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 23:49:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20241222234918epoutp02b7a12e6fb161495d5c0d1ace21e0eb8f~TpLA82hwW2689926899epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1734911358;
 bh=bywPkIJ9QM89JLbae1vEFiDldUk9DUpOmbkDpn1Q/Fg=;
 h=From:To:In-Reply-To:Subject:Date:References:From;
 b=n6G3bZxVWgyxz20h3admakofMj3cBPCCJKEXz7sPYeAm+sznjzzK8j66yI7iGpvyh
 sdMsMizKs/s/FBwvc5xNquVNYZtfgVZJYHCONawAkpy8SW+O0rnmmWvhmY8hgHHcCe
 /fNSETIMEnrslALV+hTC0LOH07RjL1Ti3qXHciEg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20241222234918epcas1p222b47b2ee525d5d978db1329ce2c0669~TpLAykhJc2608526085epcas1p22;
 Sun, 22 Dec 2024 23:49:18 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.231]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4YGdCx3Syxz4x9Q5; Sun, 22 Dec
 2024 23:49:17 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 3C.E8.23253.D75A8676; Mon, 23 Dec 2024 08:49:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20241222234917epcas1p22d24cbdffbec3b423c9f05eacc771aa7~TpK-zPidv2608526085epcas1p2z;
 Sun, 22 Dec 2024 23:49:17 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241222234917epsmtrp1c6feb8f1cabd21ae6d9576c5820030f8~TpK-ypk7T2890828908epsmtrp1O;
 Sun, 22 Dec 2024 23:49:17 +0000 (GMT)
X-AuditID: b6c32a33-5b18370000005ad5-52-6768a57dde5f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 79.30.33707.C75A8676; Mon, 23 Dec 2024 08:49:17 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20241222234916epsmtip1a32ee2d0b88fba4e9d94b48c51cf0c7f~TpK-q6BoS0900709007epsmtip1s;
 Sun, 22 Dec 2024 23:49:16 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Tom Rini'" <trini@konsulko.com>, <u-boot@lists.denx.de>
In-Reply-To: <20241220222612.1757884-2-trini@konsulko.com>
Subject: RE: [PATCH 1/6] drivers/mmc/Kconfig: Remove extraneous BLK
 dependencies
Date: Mon, 23 Dec 2024 08:49:16 +0900
Message-ID: <058e01db54cc$1cacf480$5606dd80$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQIkVCVML01cVW0HS3SbK+GrVTCx/QHn25HaAjgBKaGyP/DLsA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7bCmgW7t0ox0g2evJS2mTtrMbvF2bye7
 A5PHqwOr2D3O3tnBGMAUlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
 aqvk4hOg65aZAzRfSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWqBXnJhbXJqX
 rpeXWmJlaGBgZApUmJCdMWH2XsaCPpGKH7f+MDcw3uLvYuTkkBAwkei5sYOxi5GLQ0hgB6PE
 /VPT2CCcT4wS0+Z+ZIRz3jYuY4ZpefltEzNEYiejxKTHq1ggnJeMEhO2trGDVLEJ6En8X7QQ
 rENEwFZi39y/YHFOASuJhx/+sYLYwgJBEg+al4PFWQRUJVY9Owhm8wpYSnQsXcQCsU1B4ufT
 ZWD1zAIiErM726BmOknsPTEVbLGEwDx2iUVnvzB1MXIAOS4Sl54aQ/QKS7w6voUdwpaSeNkP
 chtIfTOjxNIlB1khnB5GiX8N19kgqowl9i+dDDaIWUBTYv0ufYjFfBLvvvawQsznlehoE4Ko
 VpG49PolE8z8u0/+Q5V4SDz5EgIJk72MEicnnmGcwCg3C8kLsxAWLGBkWsUollpQnJuemmxY
 YAiPvuT83E2M4MSkZbyD8fL8f3qHGJk4GA8xSnAwK4nw8silpgvxpiRWVqUW5ccXleakFh9i
 NAUG5ERmKdHkfGBqzCuJNzSxNDAxMzI2sTA0M1QS5z1zpSxVSCA9sSQ1OzW1ILUIpo+Jg1Oq
 gamixGHD5RUWVZsbux5qc+15smDPYqZwxaAiLienh1fcZ/6fLRq3T/O6Igf7yq8fIp7Ntbh0
 RMzrz9GqlSenZti+S2S6lrhYYfvTmv8Lw4pmMoiK7rFcez5pemJxckrLwUssF3b43kxNXiyy
 pLZ375xnh2e7rhRfVP/hzKP7++aEX1fvqpqx7VP8Cse7gtyX2lYeumkppxIwR+vHhxsBju0K
 G5qvN5xptal/KnrVuvOaW1LaTcPHXhfVuqbIFX5o2PKkuSQtdvXRifvteSc5Mz+53ukyz80q
 TkIo9eXGyf55os4lrE9czutmfPTpahUOPcw6P+jH/qTVp7mvu2m6O17cHOzSfL+XQ2l3+/eC
 iiolluKMREMt5qLiRABFcSAk1QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42LZdlhJTrd2aUa6wdKNjBZTJ21mt3i7t5Pd
 gcnj1YFV7B5n7+xgDGCK4rJJSc3JLEst0rdL4MqYMHsvY0GfSMWPW3+YGxhv8XcxcnJICJhI
 vPy2ibmLkYtDSGA7o8TBMx2sEAkpic9Pp7J1MXIA2cIShw8XQ9Q8Z5TYeesXC0gNm4CexP9F
 C5lBbBEBe4nDXZ1sEEU7GSX2L3nCBJLgFLCSePjhHyvIIGGBAIkjv/JBwiwCqhKrnh1kB7F5
 BSwlOpYuYoHYqyDx8+kysBuYBUQkZne2Qc13kth7YirLBEb+WUhSCxgZVzGKphYU56bnJhcY
 6hUn5haX5qXrJefnbmIEh5NW0A7GZev/6h1iZOJgPMQowcGsJMLLI5eaLsSbklhZlVqUH19U
 mpNafIhRmoNFSZxXOaczRUggPbEkNTs1tSC1CCbLxMEp1cAU8fHigoyyZY9VU6YKRPTNE7dQ
 vlcxw5CnfavF1dZVpyYxmSlr/g4UM36sEOFzca5rtYni4fMrvnIu/2kpdFZn2iab78En/7Od
 Cf7wsiLI7SITY3TgDIWi3TI2+ZvZjfR3OHlG+saKHL+9x/hqQnzaluyyBZKFaqZije77JbPP
 H5m8uqjTwzXj37Ok3WanPsnE9WcvOjqlSFPKY4bwW6aQXIbv1xevqo69Lvd5X3lElmHg0j9J
 Zn4hCdc03+qbb3nH8PTQf4aaHvNnFzdfU6i48WvPw0+pt66mlzkcWVfWb2nz1V+R3fjlQnZJ
 vd+nbuZOvGn0d9796hlW1oeZVysZ9bbwq5SascS7P4o/2q7EUpyRaKjFXFScCAAks/kDlgIA
 AA==
X-CMS-MailID: 20241222234917epcas1p22d24cbdffbec3b423c9f05eacc771aa7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241220222641epcas1p464e8f25f80aa301ae7df288d250bba9f
References: <20241220222612.1757884-1-trini@konsulko.com>
 <CGME20241220222641epcas1p464e8f25f80aa301ae7df288d250bba9f@epcas1p4.samsung.com>
 <20241220222612.1757884-2-trini@konsulko.com>
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
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Tom Rini
> Sent: Saturday, December 21, 2024 7:22 AM
>
> At this point in time, MMC will always have BLK enabled, so we do not
> need to list that as a dependency for MMC drivers.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index f4fdf15242ce..9f2fecce3826 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -338,7 +338,7 @@ config MMC_MXC
>
>  config MMC_OWL
>  	bool "Actions OWL Multimedia Card Interface support"
> -	depends on ARCH_OWL && DM_MMC && BLK
> +	depends on ARCH_OWL && DM_MMC
>  	help
>  	  This selects the OWL SD/MMC host controller found on board
>  	  based on Actions S700/S900 SoC.
> @@ -633,7 +633,7 @@ config MMC_SDHCI_AM654
>  	bool "SDHCI Controller on TI's Am654 devices"
>  	depends on ARCH_K3
>  	depends on MMC_SDHCI
> -	depends on DM_MMC && OF_CONTROL && BLK
> +	depends on DM_MMC && OF_CONTROL
>  	depends on REGMAP
>  	select MMC_SDHCI_IO_ACCESSORS
>  	help
> @@ -716,7 +716,7 @@ config MMC_SDHCI_PIC32
>  config MMC_SDHCI_ROCKCHIP
>  	bool "Arasan SDHCI controller for Rockchip support"
>  	depends on ARCH_ROCKCHIP
> -	depends on DM_MMC && BLK
> +	depends on DM_MMC
>  	depends on MMC_SDHCI
>  	help
>  	  Support for Arasan SDHCI host controller on Rockchip ARM SoCs platform
> @@ -764,7 +764,7 @@ config MMC_SDHCI_XENON
>
>  config MMC_SDHCI_TANGIER
>  	bool "Tangier SDHCI controller support"
> -	depends on DM_MMC && BLK
> +	depends on DM_MMC
>  	depends on MMC_SDHCI
>  	help
>  	  This selects support for SDHCI controller on Tanginer
> @@ -800,7 +800,7 @@ config TEGRA124_MMC_DISABLE_EXT_LOOPBACK
>
>  config MMC_SDHCI_ZYNQ
>  	bool "Arasan SDHCI controller support"
> -	depends on DM_MMC && OF_CONTROL && BLK
> +	depends on DM_MMC && OF_CONTROL
>  	depends on MMC_SDHCI
>  	help
>  	  Support for Arasan SDHCI host controller on Zynq/ZynqMP ARM SoCs platform
> @@ -842,7 +842,7 @@ config MMC_SUNXI_HAS_MODE_SWITCH
>
>  config MMC_PITON
>  	bool "MMC support for OpenPiton SoC"
> -	depends on DM_MMC && BLK
> +	depends on DM_MMC
>  	help
>  	  This selects support for the SD host controller on OpenPiton SoC.
>  	  Note that this SD controller directly exposes the contents of the
> --
> 2.43.0



