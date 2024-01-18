Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DC7C47258
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 01:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2409C878FF;
	Thu, 18 Jan 2024 02:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="mBuAG2a2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74C3A87887; Thu, 18 Jan 2024 02:22:51 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FAF387A18
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 02:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240118012245epoutp02587e468c38492bc0c99fa460842fc03d~rTHit0lle1609616096epoutp02-
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 01:22:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240118012245epoutp02587e468c38492bc0c99fa460842fc03d~rTHit0lle1609616096epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1705540965;
 bh=FZT+gAfYbXJ58AP0B6rPQf1q8adCNf53xhplMmx/cf0=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=mBuAG2a2kW6a9zK6FaT18miunUDz/xNJ4o7M9AoswG+xPqq8WMo6QEYcOGGE1WJgh
 S7C0cGaAPE76sR4K1ZXFWuqEICd74iTkCw+ro840m3pGlwBdZ7BhZ1Y/KBYPYdZVkz
 zpKfA8i8/dxKIq1kDKVNuNdz9nDu20794jGpdzZ4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240118012244epcas1p47cf3b68d0aa391f337dbfad04f960896~rTHiiBE3Q0823308233epcas1p4c;
 Thu, 18 Jan 2024 01:22:44 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.136]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4TFlNh02Clz4x9Q3; Thu, 18 Jan
 2024 01:22:44 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 06.B7.09744.36D78A56; Thu, 18 Jan 2024 10:22:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240118012243epcas1p366a386da9b04ca4c4c8670bc805c6d4d~rTHg_Hwy72974729747epcas1p3E;
 Thu, 18 Jan 2024 01:22:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240118012243epsmtrp11ff5d07f9b62495ee0b2cc8090c7c19b~rTHg9g9pv1169211692epsmtrp1H;
 Thu, 18 Jan 2024 01:22:43 +0000 (GMT)
X-AuditID: b6c32a35-7239ea8000002610-3a-65a87d63b4e7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 16.C7.08817.36D78A56; Thu, 18 Jan 2024 10:22:43 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240118012243epsmtip1d2355b1d3a8864bf5ad5fa41ab908006~rTHgzHhwu1519815198epsmtip1Q;
 Thu, 18 Jan 2024 01:22:43 +0000 (GMT)
Message-ID: <491f8f02-28f4-4b59-b0b9-df490e83e2c1@samsung.com>
Date: Thu, 18 Jan 2024 10:22:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: Unconditionally call mmc_deinit()
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20231202234011.208212-1-marek.vasut+renesas@mailbox.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmrm5y7YpUgy3TZCxaV95hs/ix6gur
 xdu9newOzB5n7+xg9Ng5ex+Tx8Z3O5gCmKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
 dQ0tLcyVFPISc1NtlVx8AnTdMnOANikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1Jy
 CkwL9IoTc4tL89L18lJLrAwNDIxMgQoTsjOmb33EXjBBvOLkwolMDYzrhLoYOTkkBEwkTi9t
 Zuxi5OIQEtjBKPH03B02COcTo8Shu0ugnG+MEoffvmOFaTny/Tk7RGIvo8TZWUug+t8zSiw5
 tYEFpIpXwE5i+qkbYB0sAqoSzw8cg4oLSpyc+QTMFhWQl7h/awY7iC0sYC2x/FormM0sIC5x
 68l8pi5GDg4RAXeJF394IcLyEtNfrQMbySagI7H923EmEJtTwE3i7JWjzDA129/OYYY49B67
 xOV3PiBjJARcJK689IQIC0u8Or6FHcKWknjZ3wb2i4RAM6PE0iUHWSGcHkaJfw3X2SCqjCX2
 L50Mdg+zgKbE+l36ELv4JN597WGFmM8r0dEGDVIViUuvXzLBzL/75D803DwkZj3fDQ23mYwS
 T9r+MU9gVJiFFCqzkHw/C8k7sxA2L2BkWcUollpQnJueWmxYYAiP7eT83E2M4FSoZbqDceLb
 D3qHGJk4GA8xSnAwK4nw+hssSxXiTUmsrEotyo8vKs1JLT7EaAqMm4nMUqLJ+cBknFcSb2hi
 aWBiZmRsYmFoZqgkznvmSlmqkEB6YklqdmpqQWoRTB8TB6dUA1MLc1jzlDfKdoJCIV9sWVft
 fbhZq6576iQ2qQwptklHFLO2Ruqs579cuiBMw6/jTtWCfM62AO2jqj/fvj781OjLkatiPhVa
 a1+81a2/ynlwbsJq8xthhw8cW/Mq7KkaR/XCM0vvJsr+82Py0vOpNck7t7JX5q/7A4eHFg68
 ulOWFt+6cD1Ix/Ojp7qCQLR2GzDzfE+q7Cr5m+ioOC1PRdi1zFtRa7r/Sundbeab+z8Fcm76
 UFZ7yJH3mM2svQv2+4YyRvz/s5bxh3ul5rTV/79+Vp9//Pl62+/mQXq6R51//lmqGfjvz8Ie
 xeJepTfKivdYlpf/lKmLNd7twXElMjx7g+HWU107tz9vOqwvrsRSnJFoqMVcVJwIACjIM6gO
 BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSnG5y7YpUg3fXOSxaV95hs/ix6gur
 xdu9newOzB5n7+xg9Ng5ex+Tx8Z3O5gCmKO4bFJSczLLUov07RK4MqZvfcReMEG84uTCiUwN
 jOuEuhg5OSQETCSOfH/O3sXIxSEksJtR4ueFvawQCSmJz0+nsnUxcgDZwhKHDxdD1LxllJjR
 8QeshlfATmL6qRtgNouAqsTzA8dYIOKCEidnPgGzRQXkJe7fmsEOYgsLWEssv9YKZjMLiEvc
 ejKfCWS+iIC7xIs/vBBheYnpr9aBjRQScJX4cWcjI4jNJqAjsf3bcSYQm1PATeLslaPMIK3M
 AuoS6+cJwbRufzuHeQKj0CwkR8xCsmwWQscsJB0LGFlWMUqmFhTnpucWGxYY5aWW6xUn5haX
 5qXrJefnbmIEB72W1g7GPas+6B1iZOJgPMQowcGsJMLrb7AsVYg3JbGyKrUoP76oNCe1+BCj
 NAeLkjjvt9e9KUIC6YklqdmpqQWpRTBZJg5OqQYmPkfly5aHCwt/PRO+JFm5oCv7i73Jq++q
 euFsbZEd95YIHdqvOuX5BX/R4rkmtu2r5O9v2Ne2hEWA1/3RXm2dDW/+eMq/8OKL/f7u/8bg
 IxlHU8+9+3/iXhqvPr9sy505+ZHnLK7uVtnI68/6oHfjadFjyqLsh4vVzvrpSM+Y7qwUr8hy
 frFlseTDRY+/ZP9y/vqQ+/DPFyc6ikP2BwQyZ7nvnvTxwLX7V2z2qUxepD7r7fYnLkxnHjL5
 fJBq8H+XeczHTfrszHXHMicX9TA0bZob9FOF6+icmO/uNgITOBYLpB2wu3U7feHkBn9ugVdB
 OX26WWV7Suo9NF1PLPeVOe7zfcpbl4qAjHda8z6lKLEUZyQaajEXFScCAMVj0IHpAgAA
X-CMS-MailID: 20240118012243epcas1p366a386da9b04ca4c4c8670bc805c6d4d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240118012243epcas1p366a386da9b04ca4c4c8670bc805c6d4d
References: <20231202234011.208212-1-marek.vasut+renesas@mailbox.org>
 <CGME20240118012243epcas1p366a386da9b04ca4c4c8670bc805c6d4d@epcas1p3.samsung.com>
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

On 12/3/23 08:39, Marek Vasut wrote:
> Place the SDR104/HS200/HS400 checks into the mmc_deinit() and always
> call it. This simplifies the code and removes ifdeffery. No functional
> change is expected.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/mmc/mmc-uclass.c | 13 +------------
>  drivers/mmc/mmc.c        |  9 +++++----
>  2 files changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index 328456831dd..cdead044177 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -494,10 +494,7 @@ static int mmc_blk_probe(struct udevice *dev)
>  	if (ret) {
>  		debug("Probing %s failed (err=%d)\n", dev->name, ret);
>  
> -		if (CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) ||
> -		    CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) ||
> -		    CONFIG_IS_ENABLED(MMC_HS400_SUPPORT))
> -			mmc_deinit(mmc);
> +		mmc_deinit(mmc);
>  
>  		return ret;
>  	}
> @@ -505,9 +502,6 @@ static int mmc_blk_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) || \
> -    CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
> -    CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
>  static int mmc_blk_remove(struct udevice *dev)
>  {
>  	struct udevice *mmc_dev = dev_get_parent(dev);
> @@ -516,7 +510,6 @@ static int mmc_blk_remove(struct udevice *dev)
>  
>  	return mmc_deinit(mmc);
>  }
> -#endif
>  
>  static const struct blk_ops mmc_blk_ops = {
>  	.read	= mmc_bread,
> @@ -532,12 +525,8 @@ U_BOOT_DRIVER(mmc_blk) = {
>  	.id		= UCLASS_BLK,
>  	.ops		= &mmc_blk_ops,
>  	.probe		= mmc_blk_probe,
> -#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) || \
> -    CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
> -    CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
>  	.remove		= mmc_blk_remove,
>  	.flags		= DM_FLAG_OS_PREPARE,
> -#endif
>  };
>  #endif /* CONFIG_BLK */
>  
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index d96db7a0f83..eb5010c1465 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -3010,13 +3010,15 @@ int mmc_init(struct mmc *mmc)
>  	return err;
>  }
>  
> -#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) || \
> -    CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
> -    CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
>  int mmc_deinit(struct mmc *mmc)
>  {
>  	u32 caps_filtered;
>  
> +	if (!CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) &&
> +	    !CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) &&
> +	    !CONFIG_IS_ENABLED(MMC_HS400_SUPPORT))
> +		return 0;
> +
>  	if (!mmc->has_init)
>  		return 0;
>  
> @@ -3034,7 +3036,6 @@ int mmc_deinit(struct mmc *mmc)
>  		return mmc_select_mode_and_width(mmc, caps_filtered);
>  	}
>  }
> -#endif
>  
>  int mmc_set_dsr(struct mmc *mmc, u16 val)
>  {

