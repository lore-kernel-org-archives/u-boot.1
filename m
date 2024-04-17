Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F9DC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 11:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7999E88456;
	Wed, 17 Apr 2024 13:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="gyPvsXVm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D8EB8845E; Wed, 17 Apr 2024 13:34:17 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04FB088442
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 13:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240417113410epoutp042186ef9d0683664dbc906bb19b38316f~HDhFY7GpW2503525035epoutp04s
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 11:34:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240417113410epoutp042186ef9d0683664dbc906bb19b38316f~HDhFY7GpW2503525035epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713353650;
 bh=P0OrdxjKCzAZNViIPdiawiedAB9MzG1aVPqZ6rnyNxc=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=gyPvsXVmV5GbbzdFj7Klelf8fJ3sJRtLtDjn5MGN0RjoQ3duczReXDabZ+WylGF/d
 cBKiQL70XTsyl0TUKCJasbtU6sQGM1g3H+O7eRjSGGQ5z1uY6IHxWHyKf0MBMpvElQ
 i85cF32s8phVIiKXKMvbYqkZfRQN+G+TpcHelTeU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240417113409epcas1p1e0658291f903036955a699b8f244d6bb~HDhETLmu30147001470epcas1p1E;
 Wed, 17 Apr 2024 11:34:09 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.237]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4VKJhc5rpRz4x9Ps; Wed, 17 Apr
 2024 11:34:08 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 53.47.08627.0B3BF166; Wed, 17 Apr 2024 20:34:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240417113408epcas1p410c1f25bc371fea21d9e2e60c8c28a7f~HDhDFa4iS1198711987epcas1p46;
 Wed, 17 Apr 2024 11:34:08 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240417113408epsmtrp2bc79e01755bc63e930cec591ac29ab84~HDhDEuMYl1865418654epsmtrp2w;
 Wed, 17 Apr 2024 11:34:08 +0000 (GMT)
X-AuditID: b6c32a33-d59fa700000021b3-ac-661fb3b0944e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 FB.17.19234.0B3BF166; Wed, 17 Apr 2024 20:34:08 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240417113408epsmtip1c71f6324ea76af495e993f912df8ae38~HDhC2PJxv1813918139epsmtip1b;
 Wed, 17 Apr 2024 11:34:08 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Judith Mendez'" <jm@ti.com>, "'Peng Fan'" <peng.fan@nxp.com>, "'Tom
 Rini'" <trini@konsulko.com>
Cc: "'Nitin Yadav'" <n-yadav@ti.com>, "'Simon Glass'" <sjg@chromium.org>,
 <u-boot@lists.denx.de>
In-Reply-To: <20240415212747.2678974-4-jm@ti.com>
Subject: RE: [PATCH 3/5] mmc: am654_sdhci: Add itap_del_ena[] to store
 itapdlyena bit
Date: Wed, 17 Apr 2024 20:34:08 +0900
Message-ID: <01fd01da90bb$28fc5300$7af4f900$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG5/NRqE0+DtqCkK0jpqvLeJwVynALHebNjApiKWpCxgnukAA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmnu6GzfJpBj+e6Fl8+pBp8bnpCLPF
 j1VfWC2+bdnGaDF10mZ2i7d7O9kd2DxmN1xk8Xh1YBW7x9k7Oxg9Nr7bweRx/MZ2pgDWqGyb
 jNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKALlBTKEnNK
 gUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFpgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGe/f
 7WMp2K5a0friH2MD4yy5LkZODgkBE4nHT26xdTFycQgJ7GCU+D3pKBOE84lR4tHqSyxwzuPZ
 95hhWtbN+gXVspNRomn/RCjnJaPErsvn2UGq2AT0JP4vWgjWISKQLtG+7RWYzSyQJPHqwl4m
 EJtTwFDi9N6TYLawQLjExYV7wXpZBFQljlzZzAZi8wpYSixZOoURwhaUODnzCQvEHHmJ7W/n
 QF2kIPHz6TJWiF1OElvvXWCDqBGRmN3ZxgxynIRAJ4fE+83vGCEaXCR2zp7MBGELS7w6voUd
 wpaS+PxuLxtEQzOjxNIlB1khnB5GiX8N19kgqowl9i8F6eYAWqEpsX6XPsQ2Pol3X3tYQcIS
 ArwSHW1CENUqEpdev2SCmX/3yX9WCNtD4lnLL5YJjIqzkPw2C8lvs5D8MAth2QJGllWMYqkF
 xbnpqcmGBYbw+E7Oz93ECE6fWsY7GC/P/6d3iJGJg/EQowQHs5IIb4uwbJoQb0piZVVqUX58
 UWlOavEhRlNgaE9klhJNzgcm8LySeEMTSwMTMyNjEwtDM0Mlcd4zV8pShQTSE0tSs1NTC1KL
 YPqYODilGpiC1u1v8/jjwJTLFhlpN4s3MlMoVNpN2oPV5su9HvfJl5uSUlO5A59+b1bZXe9x
 vsfc0Wu5y8/fzOcXT/7YeVw4a02XtcKXrmOluR7VhtME1pm1r+z1XP3pb/bkQ+VGfv4pKQZe
 PnJay4PYgmzb/3Is2XPq+6oYW4Ot181FJ9t+P3DYSsCP1eL6hB8bl/25NFWpRKLFoWXqhj6p
 WcoWXxIzLt3j2t/QedR0hcFnzm8LGTu2iVfcu1P0sc34l7vd1onrlu/a37wkuaLjw4ozs+vV
 p2iktpwv+hdbeDhH2Ln3/KqIRPEY3mdL5ome26DIcffWR+ZW5d8rlnYsYTHObpedfz7rnMa9
 DoHY2vcz1ZVYijMSDbWYi4oTAcFN4dIoBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnO6GzfJpBnNWC1l8+pBp8bnpCLPF
 j1VfWC2+bdnGaDF10mZ2i7d7O9kd2DxmN1xk8Xh1YBW7x9k7Oxg9Nr7bweRx/MZ2pgDWKC6b
 lNSczLLUIn27BK6M9+/2sRRsV61offGPsYFxllwXIyeHhICJxLpZv9i6GLk4hAS2M0rMad/A
 DpGQkvj8dCpQggPIFpY4fLgYouY5o0Tjrn9gNWwCehL/Fy1kBqkREciU6JwXCxJmFkiR+Ppn
 KitE/XJGib+d55hAEpwChhKn954Es4UFQiU2XfsFZrMIqEocubKZDcTmFbCUWLJ0CiOELShx
 cuYTFoih2hJPbz6FsuUltr+dwwxxp4LEz6fLWEFsEQEnia33LrBB1IhIzO5sY57AKDwLyahZ
 SEbNQjJqFpKWBYwsqxhFUwuKc9NzkwsM9YoTc4tL89L1kvNzNzGCY0craAfjsvV/9Q4xMnEw
 HmKU4GBWEuFtEZZNE+JNSaysSi3Kjy8qzUktPsQozcGiJM6rnNOZIiSQnliSmp2aWpBaBJNl
 4uCUamAyjZv2MCnbKvTIxqO/1itKHtFIk6janaT52KXdObJd/5Xv26RjB1tMXVRUcr3C9034
 ZJ77YM+Tdxvu57yNfrFeNdZW98SeTaVsNzhE9xXWrExg+ej5iu/Eoa8rd9ekf96/W2/eBOYN
 NXX39zsZ13OWMpwXeX9k5uSsBjU3iyPqrNMV7lR0rCv6+ZE1+5As8xulF6wGix8freq5ck7R
 XPXHhO1Hjqb0xD7Xdf3Zvdc46fKNdQd/RgUbn49O27lnUnHytq7pU7jfFy6d5Tl/wcm3G3LO
 ca7dfrP4Qo9z9qEDFV8/PuLR0HdYfnABw8H3HgmH1T8eNeJ4bBU4WaIu+PKlVcwyjQuOfz1f
 HvL1i++jQ0osxRmJhlrMRcWJAFgbPK0MAwAA
X-CMS-MailID: 20240417113408epcas1p410c1f25bc371fea21d9e2e60c8c28a7f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240415212756epcas1p1c70934056512b8c4186e6cdde3fbc376
References: <20240415212747.2678974-1-jm@ti.com>
 <CGME20240415212756epcas1p1c70934056512b8c4186e6cdde3fbc376@epcas1p1.samsung.com>
 <20240415212747.2678974-4-jm@ti.com>
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

Hi,

> -----Original Message-----
> From: Judith Mendez <jm@ti.com>
> Sent: Tuesday, April 16, 2024 6:28 AM
> To: Peng Fan <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>
> Cc: Nitin Yadav <n-yadav@ti.com>; Simon Glass <sjg@chromium.org>; u-boot@lists.denx.de
> Subject: [PATCH 3/5] mmc: am654_sdhci: Add itap_del_ena[] to store itapdlyena bit
> 
> Set itap_del_ena if ITAPDLY is found in DT or if the tuning
> algorithm was executed and found the optimal ITAPDLY. Add the
> functionality to save ITAPDLYENA that can be referenced later
> by storing the bit in array itap_del_ena[].
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  drivers/mmc/am654_sdhci.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
> index 1dd032e1e36..38f1ad28ec4 100644
> --- a/drivers/mmc/am654_sdhci.c
> +++ b/drivers/mmc/am654_sdhci.c
> @@ -92,6 +92,7 @@ struct am654_sdhci_plat {
>  	bool non_removable;
>  	u32 otap_del_sel[MMC_MODES_END];
>  	u32 itap_del_sel[MMC_MODES_END];
> +	u32 itap_del_ena[MMC_MODES_END];
>  	u32 trm_icp;
>  	u32 drv_strength;
>  	u32 strb_sel;
> @@ -223,8 +224,10 @@ static int am654_sdhci_setup_dll(struct am654_sdhci_plat *plat,
>  }
> 
>  static void am654_sdhci_write_itapdly(struct am654_sdhci_plat *plat,
> -				      u32 itapdly)
> +				      u32 itapdly, u32 enable)
>  {
> +	regmap_update_bits(plat->base, PHY_CTRL4, ITAPDLYENA_MASK,
> +			   enable << ITAPDLYENA_SHIFT);
>  	/* Set ITAPCHGWIN before writing to ITAPDLY */
>  	regmap_update_bits(plat->base, PHY_CTRL4, ITAPCHGWIN_MASK,
>  			   1 << ITAPCHGWIN_SHIFT);
> @@ -242,7 +245,8 @@ static void am654_sdhci_setup_delay_chain(struct am654_sdhci_plat *plat,
>  	mask = SELDLYTXCLK_MASK | SELDLYRXCLK_MASK;
>  	regmap_update_bits(plat->base, PHY_CTRL5, mask, val);
> 
> -	am654_sdhci_write_itapdly(plat, plat->itap_del_sel[mode]);
> +	am654_sdhci_write_itapdly(plat, plat->itap_del_sel[mode],
> +				  plat->itap_del_ena[mode]);
>  }
> 
>  static int am654_sdhci_set_ios_post(struct sdhci_host *host)
> @@ -443,6 +447,7 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
>  	struct udevice *dev = mmc->dev;
>  	struct am654_sdhci_plat *plat = dev_get_plat(dev);
>  	struct window fail_window[ITAPDLY_LENGTH];
> +	int mode = mmc->selected_mode;
>  	u8 curr_pass, itap;
>  	u8 fail_index = 0;
>  	u8 prev_pass = 1;
> @@ -450,11 +455,10 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
>  	memset(fail_window, 0, sizeof(fail_window));
> 
>  	/* Enable ITAPDLY */
> -	regmap_update_bits(plat->base, PHY_CTRL4, ITAPDLYENA_MASK,
> -			   1 << ITAPDLYENA_SHIFT);
> +	plat->itap_del_ena[mode] = 0x1;

0x1 means "enable"? I want to use a macro with meaning.

> 
>  	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
> -		am654_sdhci_write_itapdly(plat, itap);
> +		am654_sdhci_write_itapdly(plat, itap, plat->itap_del_ena[mode]);
> 
>  		curr_pass = !mmc_send_tuning(mmc, opcode, NULL);
> 
> @@ -478,7 +482,7 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
>  	itap = am654_sdhci_calculate_itap(dev, fail_window, fail_index,
>  					  plat->dll_enable);
> 
> -	am654_sdhci_write_itapdly(plat, itap);
> +	am654_sdhci_write_itapdly(plat, itap, plat->itap_del_ena[mode]);
> 
>  	return 0;
>  }
> @@ -515,6 +519,7 @@ static int j721e_4bit_sdhci_set_ios_post(struct sdhci_host *host)
>  	struct am654_sdhci_plat *plat = dev_get_plat(dev);
>  	int mode = host->mmc->selected_mode;
>  	u32 otap_del_sel;
> +	u32 itap_del_ena;
>  	u32 itap_del_sel;
>  	u32 mask, val;
> 
> @@ -524,10 +529,11 @@ static int j721e_4bit_sdhci_set_ios_post(struct sdhci_host *host)
>  	val = (1 << OTAPDLYENA_SHIFT) |
>  	      (otap_del_sel << OTAPDLYSEL_SHIFT);
> 
> +	itap_del_ena = plat->itap_del_ena[mode];
>  	itap_del_sel = plat->itap_del_sel[mode];
> 
>  	mask |= ITAPDLYENA_MASK | ITAPDLYSEL_MASK;
> -	val = (1 << ITAPDLYENA_SHIFT) |
> +	val = (itap_del_ena << ITAPDLYENA_SHIFT) |
>  	      (itap_del_sel << ITAPDLYSEL_SHIFT);
> 
>  	regmap_update_bits(plat->base, PHY_CTRL4, ITAPCHGWIN_MASK,
> @@ -599,9 +605,13 @@ static int sdhci_am654_get_otap_delay(struct udevice *dev,
>  			cfg->host_caps &= ~td[i].capability;
>  		}
> 
> -		if (td[i].itap_binding)
> -			dev_read_u32(dev, td[i].itap_binding,
> -				     &plat->itap_del_sel[i]);
> +		if (td[i].itap_binding) {
> +			ret = dev_read_u32(dev, td[i].itap_binding,
> +					   &plat->itap_del_sel[i]);
> +
> +			if (!ret)
> +				plat->itap_del_ena[i] = 0x1;

Ditto.

Best Regards,
Jaehoon Chung

> +		}
>  	}
> 
>  	return 0;
> --
> 2.43.2


