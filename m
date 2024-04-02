Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24FDCD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 23:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 479AB881A5;
	Wed,  3 Apr 2024 01:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="NLq2ERUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66FA3879F3; Wed,  3 Apr 2024 01:30:53 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8974881A7
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 01:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240402233048epoutp029241141cadfd931cf327454244d8ed8f~Cmnf8kAFb2423824238epoutp02a
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 23:30:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240402233048epoutp029241141cadfd931cf327454244d8ed8f~Cmnf8kAFb2423824238epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1712100648;
 bh=KVRGdFYcQfLVwEZyhrkK3tT9dMaxpC84v/wnFeq+efg=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=NLq2ERUH4QzApyviPHc+HWrMzBuhM6/zbz8H5HKbVnSlh6L17PTvY2oCcuq1JCV+I
 jwLCnXWVMkYHvtRT+oQh9JFF4aX2OPYAZeN0X53iYyp4Qm6m59X/dCYW0SskHKe/7d
 dKLz4tHTGgpftQAbWXCBKvBoSC8x0xZumtqrJNuI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240402233048epcas1p44ea051f15ab5cbd07874b5accc910c32~Cmnff70ST0446004460epcas1p48;
 Tue,  2 Apr 2024 23:30:48 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.232]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4V8PJQ4jkbz4x9Pt; Tue,  2 Apr
 2024 23:30:46 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 85.1D.09662.6259C066; Wed,  3 Apr 2024 08:30:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240402233046epcas1p4da66434b8d34a61b737a1f9443898e9d~Cmnd6BfGC0425204252epcas1p4z;
 Tue,  2 Apr 2024 23:30:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240402233046epsmtrp156a4657a7bb94c6bec37eac210af4854~Cmnd5Va-81892718927epsmtrp1C;
 Tue,  2 Apr 2024 23:30:46 +0000 (GMT)
X-AuditID: b6c32a35-053ff700000025be-03-660c9526ae67
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 FA.0C.08924.6259C066; Wed,  3 Apr 2024 08:30:46 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240402233045epsmtip26c6f4a94ebad087b3a83e20df7183316~CmndmMuq02121621216epsmtip2v;
 Tue,  2 Apr 2024 23:30:45 +0000 (GMT)
Message-ID: <8a8cbae0-65fc-4d41-952a-ab5aa68b8159@samsung.com>
Date: Wed, 3 Apr 2024 08:30:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mmc: Don't suggest to build modules in Kconfig.
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Peng Fan
 <peng.fan@nxp.com>
Cc: Patrice Chotard <patrice.chotard@st.com>, Arun Parameswaran
 <arun.parameswaran@broadcom.com>, Jassi Brar <jaswinder.singh@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240123161816.108839-1-heinrich.schuchardt@canonical.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmvq7aVJ40g3M/lCwO7L3CZHGh8Sa7
 xeRN9xkt5py4ymjxY9UXVou3ezvZLRpenGZ2YPeYdf8sm8eshl42jzvX9rB5nL2zg9Gj5eR+
 Fo+N73YweTz9sZc5gD0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfV
 VsnFJ0DXLTMH6CIlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFpgV5xYm5xaV66
 Xl5qiZWhgYGRKVBhQnbGxONvGQu2iFZ83yPRwHhaoIuRk0NCwETiccMR9i5GLg4hgR2MEu9/
 z2CGcD4xSvz8PwvK+cYoMePrE3aYlvn/lrJCJPYySjy6u58RwnnPKHHuWAMrSBWvgJ3Eup1b
 GUFsFgEViUstHUwQcUGJkzOfsIDYogLyEvdvzQCbKizgIXGx8zZYvYhAlMTE6zfAVjMLnGSU
 2LetG6yIWUBc4taT+WCD2AR0JLZ/Ow5mcwI1z+ydywhRIy+x/e0csGYJgbkcEst+7mKDuNtF
 4tmEn1C2sMSr41ug/pGSeNnfxg7R0MwosXTJQVYIp4dR4l/DdagOY4n9SycDreMAWqEpsX6X
 PsQ2Pol3X3tYQcISArwSHW1CENVAH79+yQQz/+6T/6wQtofE+8nf2SDBNRvos097mCYwKsxC
 CplZSB6dheShWQibFzCyrGIUSy0ozk1PLTYsMIRHeHJ+7iZGcILVMt3BOPHtB71DjEwcjIcY
 JTiYlUR4f3pzpgnxpiRWVqUW5ccXleakFh9iNAXGz0RmKdHkfGCKzyuJNzSxNDAxMzI2sTA0
 M1QS5z1zpSxVSCA9sSQ1OzW1ILUIpo+Jg1OqgSnVJGO2/HarjQ332QNexIY1d8ldEG3tc3X1
 1G7sktlxbLFpVsx3Mbv6kxZdoT+6xGKlstL2nbp9col6zM6CuPZ7B3fOycx/99M790z4HgP/
 vXLaUzxrvFjC57VkvI3YYcR3tX/a292t02/esBOKv/260CDtY56X4rEN3bYbxZI9tx916yoo
 613IXaNW/GVSa1fEQo8z+b1H4rieBszk01AKNn4VL2apcuuGhszZqb94Dplf4qj/07ciStb8
 02PnbsmgbuVPN5ZrZ+zP/34lr79SxUwhvoXbLbXvrfibpd3/S5YzV/H/Wnpf5ABr1kf7L1L7
 /kw4whj3r/d1/YKpE3/NPTSjdnK7RJZKjMsBJZbijERDLeai4kQAqOcATjkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSvK7aVJ40g2OfuC0O7L3CZHGh8Sa7
 xeRN9xkt5py4ymjxY9UXVou3ezvZLRpenGZ2YPeYdf8sm8eshl42jzvX9rB5nL2zg9Gj5eR+
 Fo+N73YweTz9sZc5gD2KyyYlNSezLLVI3y6BK2Pi8beMBVtEK77vkWhgPC3QxcjJISFgIjH/
 31LWLkYuDiGB3YwS8w4sZYFISEl8fjqVrYuRA8gWljh8uBii5i2jxNJj1xlBangF7CTW7dwK
 ZrMIqEhcaulggogLSpyc+QRsjqiAvMT9WzPYQWxhAQ+Ji523wepFBKIkDh+dxQgylFngNKPE
 4y1nwBJCAu4ST79OA2tgFhCXuPVkPthQNgEdie3fjoPZnECDZvbOZQQ5jllAXWL9PCGIcnmJ
 7W/nME9gFJqF5IxZSCbNQuiYhaRjASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M
 4DjS0tzBuH3VB71DjEwcjIcYJTiYlUR4f3pzpgnxpiRWVqUW5ccXleakFh9ilOZgURLnFX/R
 myIkkJ5YkpqdmlqQWgSTZeLglGpgYl6Yf+e1U6jYl5X1C4r5XHK785aETOdTD4yK2NOXtd9d
 xX/iFedVV799eyKnXNsqdjUr+duFJ4f3umZxTN/CfPlf7zrVvG8Z09udttV+m3pU05Rx0plw
 3TevDFWTFzQ+4+SeU65Y/+OS2tW6okNl3Eumzvu+YctxfUfRDZMES1/9ZZuufSNMm93j1NZF
 Feni6fxnhe1OTrBVfqCWqbJGMXPBZ4HrF4yO3Fvp06naamf40qzvZG7/+ogU0Rlmiy/fPn3I
 xOv9n+sFSU5Pr2ddPqLIe3zLrvXZfVah9eoF1R7m9mKG8w1nJJhfPFe+qYSHa9PeFtc78mYs
 kz/VHcsKfvpNJbrrrMHls1Uz/pbdUmIpzkg01GIuKk4EACOCDO4SAwAA
X-CMS-MailID: 20240402233046epcas1p4da66434b8d34a61b737a1f9443898e9d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240402233046epcas1p4da66434b8d34a61b737a1f9443898e9d
References: <20240123161816.108839-1-heinrich.schuchardt@canonical.com>
 <CGME20240402233046epcas1p4da66434b8d34a61b737a1f9443898e9d@epcas1p4.samsung.com>
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

On 1/24/24 01:18, Heinrich Schuchardt wrote:
> U-Boot does not support building kernel modules.
> 
> Fixes: 3c0dbed232bd ("mmc: arm_pl180_mmci: adapt driver to DM usage")
> Fixes: 36645f45a048 ("drivers: mmc: Add sdhci driver for Broadcom iProc platform")
> Fixes: dadd43c14368 ("mmc: synquacer: Add SynQuacer F_SDH30 SDHCI driver")
> Fixes: b312c590bcd8 ("mmc: Add MMC support for stm32h7 Socs")
> Fixes: d24b69395949 ("mmc: mtk-sd: add SD/MMC host controller driver for MT7623 SoC")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Applied to u-boot-mmc/master, Thanks! Sorry for late.

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index ffde442cb29..9ce331677b8 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -83,7 +83,7 @@ config ARM_PL180_MMCI
>  	  This selects the ARM(R) AMBA(R) PrimeCell Multimedia Card
>  	  Interface (PL180, PL181 and compatible) support.
>  	  If you have an ARM(R) platform with a Multimedia Card slot,
> -	  say Y or M here.
> +	  say Y here.
>  
>  config MMC_QUIRKS
>  	bool "Enable quirks"
> @@ -592,7 +592,7 @@ config MMC_SDHCI_IPROC
>  	  This selects the iProc SD/MMC controller.
>  
>  	  If you have a Broadcom IPROC platform with SD or MMC devices,
> -	  say Y or M here.
> +	  say Y here.
>  
>  	  If unsure, say N.
>  
> @@ -603,7 +603,7 @@ config MMC_SDHCI_F_SDH30
>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  Needed by some Fujitsu/Socionext SoC for MMC / SD / SDIO support.
> -	  If you have a controller with this interface, say Y or M here.
> +	  If you have a controller with this interface, say Y here.
>  	  If unsure, say N.
>  
>  config MMC_SDHCI_KONA
> @@ -797,7 +797,7 @@ config STM32_SDMMC2
>  	help
>  	  This selects support for the SD/MMC controller on STM32H7 SoCs.
>  	  If you have a board based on such a SoC and with a SD/MMC slot,
> -	  say Y or M here.
> +	  say Y here.
>  
>  config FTSDC010
>  	bool "Ftsdc010 SD/MMC controller Support"
> @@ -817,7 +817,7 @@ config MMC_MTK
>  	depends on OF_CONTROL
>  	help
>  	  This selects the MediaTek(R) Secure digital and Multimedia card Interface.
> -	  If you have a machine with a integrated SD/MMC card reader, say Y or M here.
> +	  If you have a machine with a integrated SD/MMC card reader, say Y here.
>  	  This is needed if support for any SD/SDIO/MMC devices is required.
>  	  If unsure, say N.
>  

