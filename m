Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572B7C4167D
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 10:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86FD386A6B;
	Mon,  6 Nov 2023 11:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="u4gj/BM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E389386B02; Mon,  6 Nov 2023 11:24:19 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A183786A4C
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 11:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231106102410epoutp04453ecf0c33c8d0f2dc79a56dd443e619~VAabTx_PR2287922879epoutp04W
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 10:24:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231106102410epoutp04453ecf0c33c8d0f2dc79a56dd443e619~VAabTx_PR2287922879epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1699266250;
 bh=aTYm7lhXM+fOVDVk2jfTARD+l8HAfIbl7+Yc+xBL388=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=u4gj/BM+3cwsjHp5qpc8fI3vRQo7veTr+xDwBbVpxQ3Inwv8kP9bSvw9vB7T2S0G1
 T2jm/+JBfOxD9a12YKbjbWb4g/ANozkdRNQSBWIjnNTzShvOCFnuxKtzRAuNhkkEd9
 wyBm07fY1IerEeZi6+YKRfTO36us8cN/5C/5aNP4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20231106102409epcas1p13eddd604bf27ee416069c936b3603615~VAaa0ij3L1239512395epcas1p1e;
 Mon,  6 Nov 2023 10:24:09 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.135]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SP6s44SWdz4x9Pt; Mon,  6 Nov
 2023 10:24:08 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 E1.9D.10025.8CEB8456; Mon,  6 Nov 2023 19:24:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20231106102407epcas1p245cf460db89d2033e14d8f14b3e09251~VAaYx7WAk0070000700epcas1p2z;
 Mon,  6 Nov 2023 10:24:07 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231106102407epsmtrp27cc357b1a91c4e23586ffbcd4558ac38~VAaYsvc2a0867308673epsmtrp2z;
 Mon,  6 Nov 2023 10:24:07 +0000 (GMT)
X-AuditID: b6c32a39-c2bf870000002729-8c-6548bec89098
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 CD.D6.18939.7CEB8456; Mon,  6 Nov 2023 19:24:07 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20231106102407epsmtip107de6d1a7574b4e72f60524b24270e64~VAaYd-wWa0536905369epsmtip1l;
 Mon,  6 Nov 2023 10:24:07 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Marek Vasut'" <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
Cc: "'Nobuhiro Iwamatsu'" <iwamatsu@nigauri.org>, "'Paul	Barker'"
 <paul.barker.ct@bp.renesas.com>, "'Peng Fan'" <peng.fan@nxp.com>
In-Reply-To: <20231105224304.103997-1-marek.vasut+renesas@mailbox.org>
Subject: RE: [PATCH] mmc: renesas-sdhi: Disable clock after tuning reset
 when possible
Date: Mon, 6 Nov 2023 19:24:07 +0900
Message-ID: <02b201da109b$5fc2fb00$1f48f100$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFmIhw1QoS27VOomJxv65VNMSZrPQJSYQH3sUJfPUA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTX/fEPo9Ug4vTFC3eNhdbtK68w2bx
 5+QPVosfq76wWrzd28nuwOqx8sVsdo+zd3YweuycvY/J48Dkc6weG9/tYApgjcq2yUhNTEkt
 UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
 VtK3synKLy1JVcjILy6xVUotSMkpMC3QK07MLS7NS9fLSy2xMjQwMDIFKkzIzriw/TNTwU2l
 iqeXP7M3MM6X6WLk5JAQMJFYdbqbFcQWEtjBKPHmmlwXIxeQ/YlRYtnZb0xwzu9bl9lgOg5v
 n8IMkdjJKDF7+SsWCOclo8SidZ1gVWwCehL/Fy1kBrFFBPwl2t8uBitiFmhhlPjzdRMLSIJT
 wE1i4s4rQA0cHMICERKnzjuBhFkEVCS+H7rLDhLmFbCU6NsSCBLmFRCUODnzCVgns4C8xPa3
 c5ghDlKQ+Pl0GStEXERidmcb1ForiZ7NW9hB1koI9HJILHzRwwrR4CJxaOs2JghbWOLVcZAi
 EFtK4vO7vWwQDc2MEkuXHGSFcHoYJf41XIf631hi/9LJTCDXMQtoSqzfpQ8RVpTY+XsuI8QV
 fBLvvoIs4wCK80p0tAlBlKhIXHr9kglm190n/1knMCrNQvLbLCS/zULyzyyEZQsYWVYxiqUW
 FOempxYbFpjCYzs5P3cTIzhhalnuYJz+9oPeIUYmDsZDjBIczEoivH/tPVKFeFMSK6tSi/Lj
 i0pzUosPMZoCA3sis5Rocj4wZeeVxBuaWBqYmBkZm1gYmhkqifOee9ubIiSQnliSmp2aWpBa
 BNPHxMEp1cCktdLf+eSSbRxh0/7m5r0u0/12eunR1UsedPv1Xvd+7XebX42nqjZlw5qK9Qnm
 R7efKHDbr7hprqfDUtdpwfz3vfN9Bde8a1h2KEfScgefZVg+S2s/80r217EnVgasKY6Rk7yT
 ZKq4zEP9lPDMHHufZ4v0Svt3ngvpdP4fwdbBUfrJ7moNn9ytN30/bYKvc1RumvBmllLJ3t7v
 WZb/9Wvm+E6vKbpdZJHu2XOn/HPJn6LiJ7KWs3MMXhz68/b5JL2WSMGDiefXrnnAXHpmb+V6
 1xA+kzWTalsWurJt3hD+8cvap2t/N5Wnzcmw3Xv3psxp20eHVMw+HUtSZ82eFWbYPcff5Nba
 ry9dJv89fuymEktxRqKhFnNRcSIAK299oiEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSnO7xfR6pBjenKVq8bS62aF15h83i
 z8kfrBY/Vn1htXi7t5PdgdVj5YvZ7B5n7+xg9Ng5ex+Tx4HJ51g9Nr7bwRTAGsVlk5Kak1mW
 WqRvl8CVcWH7Z6aCm0oVTy9/Zm9gnC/TxcjJISFgInF4+xTmLkYuDiGB7YwS/64/ZIJISEl8
 fjqVrYuRA8gWljh8uBgkLCTwnFGi5YENiM0moCfxf9FCZhBbRMBfov3tYhaQOcwCbUA1/zvZ
 IIZOZ5Ro3rGUHaSKU8BNYuLOK2wgtrBAmMSxBedZQWwWARWJ74fusoMs4xWwlOjbEggS5hUQ
 lDg58wkLiM0soC3R+7CVEcKWl9j+dg4zxJ0KEj+fLmOFiItIzO5sgzrISqJn8xb2CYzCs5CM
 moVk1Cwko2YhaV/AyLKKUTS1oDg3PTe5wFCvODG3uDQvXS85P3cTIzhitIJ2MC5b/1fvECMT
 B+MhRgkOZiUR3r/2HqlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZVzOlOEBNITS1KzU1MLUotg
 skwcnFINTOvjYuLsshc6Bq+t2n7gQPsZqw0/zITLIq6v+lc/f6L3vLtlO1tyb5/oPv83vPjy
 K6vXt58wWTiH/LgleoxtzrKA6YEPTZbvsZkUxHS2cfXBn6+lnz7l/lQqqtQW4VXg+9/tA//t
 GTevXtWefHfLlf9WAlauCdrsdc8U3mlqT091U8lkzm7qfpriwxAq4l5T3lnw9cDdTk2p3iPG
 Nhfd5ixpueqqsciARdyB0XfmTUWrJL8W+dI92dZnp96ofDZv7m2/59OP7n/Ldm7ZJL+WSyLr
 lbas47V7ta1feOua3fXsaoqKunPqtJ9PKz3itWanbNHcTUUtJ37LP/Pbkx2tMfFUrfrtzfkx
 fUk/PrpIeimxFGckGmoxFxUnAgAamEHeBwMAAA==
X-CMS-MailID: 20231106102407epcas1p245cf460db89d2033e14d8f14b3e09251
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231105224327epcas1p2d19ccbed6821310bf0f04dcd2a33da3c
References: <CGME20231105224327epcas1p2d19ccbed6821310bf0f04dcd2a33da3c@epcas1p2.samsung.com>
 <20231105224304.103997-1-marek.vasut+renesas@mailbox.org>
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
> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Sent: Monday, November 6, 2023 7:43 AM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>; Jaehoon Chung <jh80.chung@samsung.com>; Nobuhiro
> Iwamatsu <iwamatsu@nigauri.org>; Paul Barker <paul.barker.ct@bp.renesas.com>; Peng Fan
> <peng.fan@nxp.com>
> Subject: [PATCH] mmc: renesas-sdhi: Disable clock after tuning reset when possible
> 
> Currently the renesas_sdhi_reset_tuning() unconditionally leaves SDHI
> clock enabled after the tuning reset. This is not always necessary.
> 
> After the driver performed tuning reset at the end of probe function,
> or in the unlikely case that tuning failed during regular operation,
> the SDHI clock can be disabled after the tuning reset. The following
> set_ios call would reconfigure the clock as needed.
> 
> In case of regular set_ios call which requires a tuning reset, keep
> the clock enabled or disabled according to the mmc->clk_disable state.
> 
> With this in place, the controllers which have not been accessed via
> block subsystem after boot are left in quiescent state. However, if an
> MMC device is used e.g. for environment storage, that controller would
> be accessed during the environment load and left active, including its
> clock which would still be generated. This is due to the design of the
> MMC subsystem, which does not deinit a controller after it was started
> once, the controller is only deinited in case of mmc rescan, or before
> OS boot.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> Note: To address the part where MMC device has been inited once and
>       is never deinited until rescan or OS boot, it would likely be
>       necessary to implement something like runtime PM, possibly
>       based on the cyclic framework. Basically, keep track of when
>       the MMC was accessed last, and if certain time elapsed, deinit
>       the MMC. This could also be used to handle card detect polling
>       at the same time.
> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/mmc/renesas-sdhi.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
> index 8cd501c5f7c..97aaf1e4ec3 100644
> --- a/drivers/mmc/renesas-sdhi.c
> +++ b/drivers/mmc/renesas-sdhi.c
> @@ -318,7 +318,7 @@ static unsigned int renesas_sdhi_init_tuning(struct tmio_sd_priv *priv)
>  		RENESAS_SDHI_SCC_DTCNTL_TAPNUM_MASK;
>  }
> 
> -static void renesas_sdhi_reset_tuning(struct tmio_sd_priv *priv)
> +static void renesas_sdhi_reset_tuning(struct tmio_sd_priv *priv, bool clk_disable)
>  {
>  	u32 reg;
> 
> @@ -350,6 +350,12 @@ static void renesas_sdhi_reset_tuning(struct tmio_sd_priv *priv)
>  	reg = tmio_sd_readl(priv, RENESAS_SDHI_SCC_RVSCNTL);
>  	reg &= ~RENESAS_SDHI_SCC_RVSCNTL_RVSEN;
>  	tmio_sd_writel(priv, reg, RENESAS_SDHI_SCC_RVSCNTL);
> +
> +	if (clk_disable) {
> +		reg = tmio_sd_readl(priv, TMIO_SD_CLKCTL);
> +		reg &= ~TMIO_SD_CLKCTL_SCLKEN;
> +		tmio_sd_writel(priv, reg, TMIO_SD_CLKCTL);
> +	}
>  }
> 
>  static int renesas_sdhi_hs400(struct udevice *dev)
> @@ -629,7 +635,7 @@ int renesas_sdhi_execute_tuning(struct udevice *dev, uint opcode)
>  out:
>  	if (ret < 0) {
>  		dev_warn(dev, "Tuning procedure failed\n");
> -		renesas_sdhi_reset_tuning(priv);
> +		renesas_sdhi_reset_tuning(priv, true);
>  	}
> 
>  	return ret;
> @@ -668,7 +674,7 @@ static int renesas_sdhi_set_ios(struct udevice *dev)
>  	    (mmc->selected_mode != UHS_SDR104) &&
>  	    (mmc->selected_mode != MMC_HS_200) &&
>  	    (mmc->selected_mode != MMC_HS_400)) {
> -		renesas_sdhi_reset_tuning(priv);
> +		renesas_sdhi_reset_tuning(priv, mmc->clk_disable);
>  	}
>  #endif
> 
> @@ -1095,7 +1101,7 @@ static int renesas_sdhi_probe(struct udevice *dev)
>      CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
>      CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
>  	if (priv->caps & TMIO_SD_CAP_RCAR_UHS)
> -		renesas_sdhi_reset_tuning(priv);
> +		renesas_sdhi_reset_tuning(priv, true);
>  #endif
>  	return 0;
> 
> --
> 2.42.0


