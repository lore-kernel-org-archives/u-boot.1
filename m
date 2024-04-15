Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAEDC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A618688134;
	Mon, 15 Apr 2024 08:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="sLuDA15V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8A8D8813C; Mon, 15 Apr 2024 08:58:07 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3E8E874B1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240415065758epoutp0359e4e29f9259f6f486dc9bea4f84b7a0~GYdWUcARD3228932289epoutp03c
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 06:57:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240415065758epoutp0359e4e29f9259f6f486dc9bea4f84b7a0~GYdWUcARD3228932289epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713164278;
 bh=b3HGF2Wp7puqY2JAmBh1faa7Zg82FKMf38w/1kqLGTI=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=sLuDA15V/p5YJw7UTQox0XP8OAdJzXWaMBtWbkBV7oZV6WEynNnS4wgoDLmj2Sxw4
 1btR+A8Z1UgrnxpRAVp0zrWMhfMnq+bAji8+3OMiE590T3sp7dPIw5K2a//ze8VJQb
 Xq9jN+BoWEHyaQZIVTBodkMZ5BNAYJy3dyKNsgfo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240415065757epcas1p4de15ef485b798fdf2e6e97366b6a2659~GYdV2G2Ko0474004740epcas1p4w;
 Mon, 15 Apr 2024 06:57:57 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.233]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4VHyfr5HC6z4x9Q7; Mon, 15 Apr
 2024 06:57:56 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 F5.7F.19431.4FFCC166; Mon, 15 Apr 2024 15:57:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240415065756epcas1p40d86926e39b32e3a8a294f52302aa475~GYdUtsBYG1270112701epcas1p4F;
 Mon, 15 Apr 2024 06:57:56 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240415065756epsmtrp2bd1c3171d55b3fa63f85f3e6d9b79846~GYdUtJzNE0926909269epsmtrp2p;
 Mon, 15 Apr 2024 06:57:56 +0000 (GMT)
X-AuditID: b6c32a4c-485ff70000004be7-e7-661ccff487a3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 5F.0A.19234.4FFCC166; Mon, 15 Apr 2024 15:57:56 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240415065756epsmtip2d277188d1e5d0f95670b1898b2e7619b~GYdUhXrNs3253332533epsmtip23;
 Mon, 15 Apr 2024 06:57:56 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Yang Xiwen'" <forbidden405@outlook.com>, "'Peng Fan'" <peng.fan@nxp.com>
Cc: <u-boot@lists.denx.de>
In-Reply-To: <SEZPR06MB69599C34A5A8BF84F87C1CC1963D2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Subject: RE: [PATCH v2 1/3] mmc: hi6220-dwmmc: handle clocks and resets if
 CONFIG_CLK and CONFIG_DM_RESET enabled
Date: Mon, 15 Apr 2024 15:57:56 +0900
Message-ID: <008501da8f02$3e8b15e0$bba141a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG10PZhwJPp9GmYju4dCS4VuJkgUQLMQqScAO4yJRICPK2E9QL3HAYmsWrwHrA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmnu6X8zJpBjN7tSz+3dzDbvFj1RdW
 i7d7O9kdmD3O3tnB6LHx3Q4mj82vXzAHMEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
 6hpaWpgrKeQl5qbaKrn4BOi6ZeYAbVJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTk
 FJgW6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdMOWpeMEW74tCPb8wNjI1KXYycHBICJhKv/yxm
 6mLk4hAS2MMosfzDaSjnE5CzbyMbnLPj5DyWLkYOsJZ/Wy0g4jsZJZYd74PqeMkocW3NbEaQ
 uWwCehL/Fy1kBmkQEQiQeHJRASTMLCAl0XRyF1gJp0CsxKl7e9lASoQFiiVunLQBCbMIqEq0
 fbkPtopXwFLi72YJkDCvgKDEyZlPWCCmyEtsfzuHGeIBBYmfT5exgtgiAn4SN3YeZYWoEZGY
 3dnGDHKZhMAjdol5jxdANbhIrJ93BcoWlnh1fAs7hC0l8fndXjaIhmZGiaVLDrJCOD2MEv8a
 rrNBVBlL7F86mQnkOmYBTYn1u/QhtvFJvPvawwoJH16JjjYhiGoViUuvXzLBzL/75D8rhO0h
 8e3xbPYJjIqzkPw2C8lvs5D8MAth2QJGllWMUqkFxbnpqcmGBYa6eanl8OhOzs/dxAhOhlo+
 Oxi/r/+rd4iRiYPxEKMEB7OSCO81Ock0Id6UxMqq1KL8+KLSnNTiQ4ymwACfyCwlmpwPTMd5
 JfGGJpYGJmZGxiYWhmaGSuK8Z66UpQoJpCeWpGanphakFsH0MXFwSjUwcc2ZlrtyllPN+r0x
 txfGhUx0X/WUmftqzMJlE8yi4hYsvDB3m58Nf7zLqos53M/y/3daHfzMpfTwrMexebnf77SE
 nT18K7bt6v/ee3aHpss/ZSnp2hTxr2UjT0p+hN+1AyyLpN40FOZut1fM+36xROeX+/PYM4J8
 F51WMsfz7jVJ/CCkvnnWhKo5VbX1sfnhghcOTfncz/z4lsB7l5uxm095B26ZxqgvxXmjdKfa
 XJYVidfibHZdl8l7emdGxtoOmXL5mTNPCdu7PalteXRHYebzZAuJO5sjnWyTn/M8XZEVZLLO
 LuP6pvXL/Ne7Zz481264136r6Z7Z+3b/XH28kfFMOP/Br2c+9AnePp2wu0qJpTgj0VCLuag4
 EQD7mD6aDwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSvO6X8zJpBpu/iVn8u7mH3eLHqi+s
 Fm/3drI7MHucvbOD0WPjux1MHptfv2AOYI7isklJzcksSy3St0vgyphy1LxginbFoR/fmBsY
 G5W6GDk4JARMJP5ttehi5OIQEtjOKLFn0XPWLkZOoLiUxOenU9kgaoQlDh8uhqh5zigx8foT
 ZpAaNgE9if+LFoLZIgIBEgt3tjGC2MxAvU0ndzFCNOxmktjw4BoTSIJTIFbi1L29bCC2sECh
 xOfHl8HiLAKqEm1f7rOALOMVsJT4u1kCJMwrIChxcuYTFoiZ2hJPbz6FsuUltr+dwwxxp4LE
 z6fLWCFu8JO4sfMoK0SNiMTszjbmCYzCs5CMmoVk1Cwko2YhaVnAyLKKUTS1oDg3PTe5wFCv
 ODG3uDQvXS85P3cTIzgOtIJ2MC5b/1fvECMTB+MhRgkOZiUR3mtykmlCvCmJlVWpRfnxRaU5
 qcWHGKU5WJTEeZVzOlOEBNITS1KzU1MLUotgskwcnFINTNl/0ves+ffavfpv0naunYfTpj1d
 4z1da84JrQK3bdsSfDLknUJfb224ObmP67GKjhz/gfePLHcw3Gi6qGcSJlHzRNyzZfZe/X1d
 TL9kxdal2Ty8Wn3+VWXEprzmp5fjAno/JjzVZxE8rFjloWUW39TCf5t9hehD42aemLTDFiw8
 EyMsohoT/+2eEX4gOqFhwlwhjvZPS2qD35dnnjG9/k7faFKkpuncrrprkscnG1mtspx5oPPM
 s1cXT5aLh8998HZ/6d2/W782h6edu2P6WvngS20x9oWrF6hJWC698fTA37rJ/ZNm15Y6Spnd
 uXF+Q32kaMcZRus/9qfX1TX/Xego0L75ROt1Ho6vfK4bu5RYijMSDbWYi4oTAXFdzZbyAgAA
X-CMS-MailID: 20240415065756epcas1p40d86926e39b32e3a8a294f52302aa475
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403003945epcas1p4bb700e4390a5c5d29dbe241cb621db7a
References: <20240201-mmc-v2-0-9f09dc1335fd@outlook.com>
 <20240201-mmc-v2-1-9f09dc1335fd@outlook.com>
 <CGME20240403003945epcas1p4bb700e4390a5c5d29dbe241cb621db7a@epcas1p4.samsung.com>
 <01f712ed-a07c-4db7-b7c1-9dc0f7efd898@samsung.com>
 <SEZPR06MB69599C34A5A8BF84F87C1CC1963D2@SEZPR06MB6959.apcprd06.prod.outlook.com>
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
> From: Yang Xiwen <forbidden405@outlook.com>
> Sent: Wednesday, April 3, 2024 10:16 AM
> To: Jaehoon Chung <jh80.chung@samsung.com>; Peng Fan <peng.fan@nxp.com>
> Cc: u-boot@lists.denx.de
> Subject: Re: [PATCH v2 1/3] mmc: hi6220-dwmmc: handle clocks and resets if CONFIG_CLK and
> CONFIG_DM_RESET enabled
> 
> On 4/3/2024 8:39 AM, Jaehoon Chung wrote:
> > Hi,
> >
> > On 2/1/24 23:05, Yang Xiwen via B4 Relay wrote:
> >> From: Yang Xiwen <forbidden405@outlook.com>
> >>
> >> This can avoid hardcoding a clock rate in driver. Also can enable the
> >> clocks and deassert the resets if the pre-bootloader does not do this
> >> for us.
> >>
> >> Currently only enabled for Hi3798MV200.
> >>
> >> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>


> >> ---
> >>   drivers/mmc/hi6220_dw_mmc.c | 61 ++++++++++++++++++++++++++++++++++++++++++++-
> >>   1 file changed, 60 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/hi6220_dw_mmc.c b/drivers/mmc/hi6220_dw_mmc.c
> >> index 71962cd47e..a4b8072976 100644
> >> --- a/drivers/mmc/hi6220_dw_mmc.c
> >> +++ b/drivers/mmc/hi6220_dw_mmc.c
> >> @@ -5,15 +5,24 @@
> >>    */
> >>
> >>   #include <common.h>
> >> +#include <clk.h>
> >>   #include <dm.h>
> >>   #include <dwmmc.h>
> >>   #include <errno.h>
> >>   #include <fdtdec.h>
> >>   #include <malloc.h>
> >> +#include <reset.h>
> >>   #include <asm/global_data.h>
> >> +#include <dm/device_compat.h>
> >>
> >>   DECLARE_GLOBAL_DATA_PTR;
> >>
> >> +enum hi6220_dwmmc_clk_type {
> >> +	HI6220_DWMMC_CLK_BIU,
> >> +	HI6220_DWMMC_CLK_CIU,
> >> +	HI6220_DWMMC_CLK_CNT,
> >> +};
> >> +
> >>   struct hi6220_dwmmc_plat {
> >>   	struct mmc_config cfg;
> >>   	struct mmc mmc;
> >> @@ -21,6 +30,8 @@ struct hi6220_dwmmc_plat {
> >>
> >>   struct hi6220_dwmmc_priv_data {
> >>   	struct dwmci_host host;
> >> +	struct clk *clks[HI6220_DWMMC_CLK_CNT];
> >> +	struct reset_ctl_bulk rsts;
> >>   };
> >>
> >>   struct hisi_mmc_data {
> >> @@ -32,7 +43,29 @@ static int hi6220_dwmmc_of_to_plat(struct udevice *dev)
> >>   {
> >>   	struct hi6220_dwmmc_priv_data *priv = dev_get_priv(dev);
> >>   	struct dwmci_host *host = &priv->host;
> >> +	int ret;
> > If CONFIG_CLK and DM_RESET aren't enabled, this value is a dead code.
> > It also needs to initialize.
> 
> 
> I think a alternative solution is replacing the if stmt below with some
> `#ifdef`s just like some unittests code. So we can mask variable `ret'
> out if it's not used However, this seems not favored by checkpatch.pl.

It's not a critical thing. If possible to change more generic, I will change them.
Thanks!

Best Regards,
Jaehoon Chung

> 
> 
> >
> >>
> >> +	if (CONFIG_IS_ENABLED(CLK) && CONFIG_IS_ENABLED(DM_RESET)) {
> >> +		priv->clks[HI6220_DWMMC_CLK_BIU] = devm_clk_get(dev, "biu");
> >> +		if (IS_ERR(priv->clks[HI6220_DWMMC_CLK_BIU])) {
> >> +			ret = PTR_ERR(priv->clks[HI6220_DWMMC_CLK_BIU]);
> >> +			dev_err(dev, "Failed to get BIU clock(ret = %d).\n", ret);
> >> +			return log_msg_ret("clk", ret);
> >> +		}
> >> +
> >> +		priv->clks[HI6220_DWMMC_CLK_CIU] = devm_clk_get(dev, "ciu");
> >> +		if (IS_ERR(priv->clks[HI6220_DWMMC_CLK_CIU])) {
> >> +			ret = PTR_ERR(priv->clks[HI6220_DWMMC_CLK_CIU]);
> >> +			dev_err(dev, "Failed to get CIU clock(ret = %d).\n", ret);
> >> +			return log_msg_ret("clk", ret);
> >> +		}
> >> +
> >> +		ret = reset_get_bulk(dev, &priv->rsts);
> >> +		if (ret) {
> >> +			dev_err(dev, "Failed to get resets(ret = %d)", ret);
> >> +			return log_msg_ret("rst", ret);
> >> +		}
> >> +	}
> >>   	host->name = dev->name;
> >>   	host->ioaddr = dev_read_addr_ptr(dev);
> >>   	host->buswidth = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
> >> @@ -56,11 +89,37 @@ static int hi6220_dwmmc_probe(struct udevice *dev)
> >>   	struct hi6220_dwmmc_priv_data *priv = dev_get_priv(dev);
> >>   	struct dwmci_host *host = &priv->host;
> >>   	struct hisi_mmc_data *mmc_data;
> >> +	int ret;
> > Ditto.
> >
> >
> > Best Regards,
> > Jaehoon Chung
> >
> >>
> >>   	mmc_data = (struct hisi_mmc_data *)dev_get_driver_data(dev);
> >>
> >> -	/* Use default bus speed due to absence of clk driver */
> >>   	host->bus_hz = mmc_data->clock;
> >> +	if (CONFIG_IS_ENABLED(CLK) && CONFIG_IS_ENABLED(DM_RESET)) {
> >> +		ret = clk_prepare_enable(priv->clks[HI6220_DWMMC_CLK_BIU]);
> >> +		if (ret) {
> >> +			dev_err(dev, "Failed to enable biu clock(ret = %d).\n", ret);
> >> +			return log_msg_ret("clk", ret);
> >> +		}
> >> +
> >> +		ret = clk_prepare_enable(priv->clks[HI6220_DWMMC_CLK_CIU]);
> >> +		if (ret) {
> >> +			dev_err(dev, "Failed to enable ciu clock(ret = %d).\n", ret);
> >> +			return log_msg_ret("clk", ret);
> >> +		}
> >> +
> >> +		ret = reset_deassert_bulk(&priv->rsts);
> >> +		if (ret) {
> >> +			dev_err(dev, "Failed to deassert resets(ret = %d).\n", ret);
> >> +			return log_msg_ret("rst", ret);
> >> +		}
> >> +
> >> +		host->bus_hz = clk_get_rate(priv->clks[HI6220_DWMMC_CLK_CIU]);
> >> +		if (host->bus_hz <= 0) {
> >> +			dev_err(dev, "Failed to get ciu clock rate(ret = %d).\n", ret);
> >> +			return log_msg_ret("clk", ret);
> >> +		}
> >> +	}
> >> +	dev_dbg(dev, "bus clock rate: %d.\n", host->bus_hz);
> >>
> >>   	dwmci_setup_cfg(&plat->cfg, host, host->bus_hz, 400000);
> >>   	host->mmc = &plat->mmc;
> 
> 
> --
> Regards,
> Yang Xiwen


