Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B112C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 00:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3FC98844B;
	Wed, 17 Apr 2024 02:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="tnNrLXPh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F712881DD; Wed, 17 Apr 2024 02:25:46 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A7D888442
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 02:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240417002532epoutp034ed321cf1dcb46a4ab9705d93508d5e6~G6ZSTxnDg0503305033epoutp03G
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 00:25:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240417002532epoutp034ed321cf1dcb46a4ab9705d93508d5e6~G6ZSTxnDg0503305033epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713313532;
 bh=3HEDoXBAbmBc06bMcSEHhXE8s63pqxwulkpFLMr6sv8=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=tnNrLXPhT2hHON7ArOScoYpKh4sRk+cL5x+NhfqCJjsuo9TXEX0F4jA90z+jXklpM
 IM0kjyVGlkvIDiLSgdw03ztR53C4HkSysnZBMp0axlbPsqkMZ+d6lOmZ0uO5xONoHL
 mZABw3ghog1UOYigTpDRSIshNVdjBEi3JltMlnkM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240417002532epcas1p1006a725edecbdcc336ecb7ee86533e4b~G6ZR_Swi-1618516185epcas1p1W;
 Wed, 17 Apr 2024 00:25:32 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.133]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4VK1s729S8z4x9Q2; Wed, 17 Apr
 2024 00:25:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 B8.64.10158.BF61F166; Wed, 17 Apr 2024 09:25:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20240417002530epcas1p124ece203dc31bc75acd78b9313d426d4~G6ZQQYhxW3093530935epcas1p1C;
 Wed, 17 Apr 2024 00:25:30 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240417002530epsmtrp108c66f0950d86564b7e59d21b82be560~G6ZQPo8yx1794417944epsmtrp1R;
 Wed, 17 Apr 2024 00:25:30 +0000 (GMT)
X-AuditID: b6c32a38-b41fa700000027ae-0a-661f16fbeeee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 3A.9D.19234.AF61F166; Wed, 17 Apr 2024 09:25:30 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240417002530epsmtip270d94c204e390973e45d0d1eaca43c0a~G6ZQAkWX-0147501475epsmtip2e;
 Wed, 17 Apr 2024 00:25:30 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Greg Malysa'" <greg.malysa@timesys.com>, <u-boot@lists.denx.de>,
 "'Peng Fan'" <peng.fan@nxp.com>
Cc: "'Ian Roberts'" <ian.roberts@timesys.com>, "'Nathan Barrett-Morrison'"
 <nathan.morrison@timesys.com>, "'Jonas	Karlman'" <jonas@kwiboo.se>, "'Kever
 Yang'" <kever.yang@rock-chips.com>, "'Peter	Geis'" <pgwipeout@gmail.com>,
 "'Sean Anderson'" <sean.anderson@seco.com>, "'Simon	Glass'"
 <sjg@chromium.org>, "'Tom Rini'" <trini@konsulko.com>
In-Reply-To: <20240326021819.770-1-greg.malysa@timesys.com>
Subject: RE: [PATCH] mmc: sdhci: introduce adma_write_desc() hook to struct
 sdhci_ops
Date: Wed, 17 Apr 2024 09:25:30 +0900
Message-ID: <002d01da905d$c0d03600$4270a200$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKEAxbe5xUMRNPs0ZNxHEQLPRoWwAGNs8ZDsAxHlNA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmge5vMfk0g/Zd3BanP91gsXh5/x6T
 xck3V1kstk3/yWZxeeFlRosfq76wWpx95m0x734Lk8W3LdsYLaZO2sxu8XZvJ7sDt8fshoss
 Hjtn3WX3eHVgFbvHiQmXmDzO3tnB6LHx3Q4mj7+z9rN4PPv3jd1j7/YfTAGcUdk2GamJKalF
 Cql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDnKimUJeaUAoUCEouL
 lfTtbIryS0tSFTLyi0tslVILUnIKTAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM/79/85WsMqm
 YuKS+4wNjN8Muhg5OSQETCT6Hs9g6mLk4hAS2MEosXfaQ1YI5xOjxNtN7awgVWDO2v0ZMB2z
 JvRBdexklGi+towRwnnJKNG2YjoTSBWbgJ7E/0ULmbsYOThEBDIkNrxhA6lhFrjFJHHnwGaw
 Gk4Ba4mL04+C2cIC4RIzeo4wg9gsAqoSh+btYwGxeQUsJd7uX88EYQtKnJz5BCzOLCAvsf3t
 HGaIixQkfj5dBnapiICVxL3Jm5ggakQkZne2MYMslhC4wCGxZ8dJRogGF4llRzugmoUlXh3f
 wg5hS0m87G9jh2hoZpRYuuQgK4TTwyjxr+E6G0SVscT+pZOZQF5jFtCUWL9LH2Ibn8S7rz2s
 IGEJAV6JjjYhiGoViUuvXzLBzL/75D8rhO0h8WD2f+YJjIqzkPw2C8lvs5D8MAth2QJGllWM
 YqkFxbnpqcWGBSbw6E7Oz93ECE7LWhY7GOe+/aB3iJGJg/EQowQHs5IIb4uwbJoQb0piZVVq
 UX58UWlOavEhRlNgaE9klhJNzgdmhrySeEMTSwMTMyNjEwtDM0Mlcd4zV8pShQTSE0tSs1NT
 C1KLYPqYODilGph43E/59kyuci5M+De7wffuBN+WjTb7TKP4LrLv//6qV2Ga8YXLWxnme+yL
 uKNiW3Pq8a/Z71+s8ZafKtc49faxzj29rc5Gee8j37je3nCkfKrfeZMJkUI/L3tIHeBuamuW
 FIkP1FV8u+fJhJsH9nTHKgdrGM23dfdRfvHdqkV+X0i7jXOyuOXFvrk6l+X83m3t9pLJXXV2
 5+t/M89v7J4ls83rokFulmxkxjrliYXpJknCqpFzZr98Znm+QIQ5OfloqNzZD+tVn0zZnnjn
 2hODv93JmwzVyxv3/W2awf3IrsZqV3SwBe+6lBMtx01nTU17/9hi/bpDR2xkMt5qf1bQ0Xbb
 vpDfSVMgUGrdhnVKLMUZiYZazEXFiQAC+VRuVAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSvO4vMfk0g0sPBS1Of7rBYvHy/j0m
 i5NvrrJYbJv+k83i8sLLjBY/Vn1htTj7zNti3v0WJotvW7YxWkydtJnd4u3eTnYHbo/ZDRdZ
 PHbOusvu8erAKnaPExMuMXmcvbOD0WPjux1MHn9n7WfxePbvG7vH3u0/mAI4o7hsUlJzMstS
 i/TtErgy/v3/zlawyqZi4pL7jA2M3wy6GDk5JARMJGZN6GPqYuTiEBLYzijxct8jdoiElMTn
 p1PZuhg5gGxhicOHi0HCQgLPGSXmzkkAsdkE9CT+L1rIDGKLCGRJdH/9wwwyh1ngAZPE6anP
 2CGG9jBKHNyzAayKU8Ba4uL0o0wgtrBAqMSkjW9YQGwWAVWJQ/P2gdm8ApYSb/evZ4KwBSVO
 znwCFmcW0JZ4evMplC0vsf3tHGaIQxUkfj5dxgpxhZXEvcmbmCBqRCRmd7YxT2AUnoVk1Cwk
 o2YhGTULScsCRpZVjKKpBcW56bnJBYZ6xYm5xaV56XrJ+bmbGMFxqRW0g3HZ+r96hxiZOBgP
 MUpwMCuJ8LYIy6YJ8aYkVlalFuXHF5XmpBYfYpTmYFES51XO6UwREkhPLEnNTk0tSC2CyTJx
 cEo1MPHPNHCrXvwqUmv9+a8/TgQfsVh/dLb+s0btlPOfAsX86j/ka8qdjP2+8eyL5+6Hp4eG
 sVxiyDpv8HtRh695e3HQeY6IKY3mfOarF+tO1ki12N6tYZVprGFtWXDj3NWi5n9L6+0mKnLs
 LnftX5PnvEzaVtp4zWOVL12FM7fytMsqvuCy+7TrXOjWQ1V/Vm/jPvK+7IPhz/OLNrzQXpvM
 xd8purv7054tW3Yu1mfr8UjYuue9u0K4un7ZdQ3NjwZiepXsk8o7Lkesv6DwIV3ClcEw2/GM
 yhtTw+WnpRVXyjj1X7qyQ1XDf+tpxl/tebpPTNc0aNYfWl2/MW56mCxTmuSe++/mHGn+ZSO6
 8tCfG0osxRmJhlrMRcWJADb+/y46AwAA
X-CMS-MailID: 20240417002530epcas1p124ece203dc31bc75acd78b9313d426d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240326022044epcas1p4c22b3f79421ca2ba3e93988d29016192
References: <CGME20240326022044epcas1p4c22b3f79421ca2ba3e93988d29016192@epcas1p4.samsung.com>
 <20240326021819.770-1-greg.malysa@timesys.com>
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
> From: Greg Malysa <greg.malysa@timesys.com>
> Sent: Tuesday, March 26, 2024 11:18 AM
> To: u-boot@lists.denx.de; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Ian Roberts <ian.roberts@timesys.com>; Nathan Barrett-Morrison <nathan.morrison@timesys.com>; Greg
> Malysa <greg.malysa@timesys.com>; Jonas Karlman <jonas@kwiboo.se>; Kever Yang <kever.yang@rock-
> chips.com>; Peter Geis <pgwipeout@gmail.com>; Sean Anderson <sean.anderson@seco.com>; Simon Glass
> <sjg@chromium.org>; Tom Rini <trini@konsulko.com>
> Subject: [PATCH] mmc: sdhci: introduce adma_write_desc() hook to struct sdhci_ops
> 
> From: Ian Roberts <ian.roberts@timesys.com>
> 
> Add this hook so that it can be overridden with driver specific
> implementations. We also let the original sdhci_adma_write_desc()
> accept &desc so that the function can set its new value. Then export
> the function so that it could be reused by driver's specific
> implementations.
> 
> The above is a port of Linux kernel commit 54552e4948cbf
> 
> In addition, allow drivers to allocate their own ADMA descriptor
> tables if additional space is required.
> 
> Finally, fix the assignment of adma_addr to fix compiler warning
> on 64-bit platforms that still use 32-bit DMA addressing.
> 
> Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
> Signed-off-by: Ian Roberts <ian.roberts@timesys.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com> 

Best Regards,
Jaehoon Chung

> 
> ---
> 
> 
> ---
>  drivers/mmc/fsl_esdhc.c  |  2 +-
>  drivers/mmc/sdhci-adma.c | 41 +++++++++++++++++++++++++++-------------
>  drivers/mmc/sdhci.c      |  8 +++++---
>  include/sdhci.h          | 12 ++++++++++--
>  4 files changed, 44 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/fsl_esdhc.c b/drivers/mmc/fsl_esdhc.c
> index d506666669..bd0671cc52 100644
> --- a/drivers/mmc/fsl_esdhc.c
> +++ b/drivers/mmc/fsl_esdhc.c
> @@ -252,7 +252,7 @@ static void esdhc_setup_dma(struct fsl_esdhc_priv *priv, struct mmc_data *data)
>  	    priv->adma_desc_table) {
>  		debug("Using ADMA2\n");
>  		/* prefer ADMA2 if it is available */
> -		sdhci_prepare_adma_table(priv->adma_desc_table, data,
> +		sdhci_prepare_adma_table(NULL, priv->adma_desc_table, data,
>  					 priv->dma_addr);
> 
>  		adma_addr = virt_to_phys(priv->adma_desc_table);
> diff --git a/drivers/mmc/sdhci-adma.c b/drivers/mmc/sdhci-adma.c
> index 8213223d3f..8c38448b6a 100644
> --- a/drivers/mmc/sdhci-adma.c
> +++ b/drivers/mmc/sdhci-adma.c
> @@ -9,9 +9,10 @@
>  #include <malloc.h>
>  #include <asm/cache.h>
> 
> -static void sdhci_adma_desc(struct sdhci_adma_desc *desc,
> -			    dma_addr_t addr, u16 len, bool end)
> +void sdhci_adma_write_desc(struct sdhci_host *host, void **next_desc,
> +			   dma_addr_t addr, int len, bool end)
>  {
> +	struct sdhci_adma_desc *desc = *next_desc;
>  	u8 attr;
> 
>  	attr = ADMA_DESC_ATTR_VALID | ADMA_DESC_TRANSFER_DATA;
> @@ -19,17 +20,30 @@ static void sdhci_adma_desc(struct sdhci_adma_desc *desc,
>  		attr |= ADMA_DESC_ATTR_END;
> 
>  	desc->attr = attr;
> -	desc->len = len;
> +	desc->len = len & 0xffff;
>  	desc->reserved = 0;
>  	desc->addr_lo = lower_32_bits(addr);
>  #ifdef CONFIG_DMA_ADDR_T_64BIT
>  	desc->addr_hi = upper_32_bits(addr);
>  #endif
> +
> +	*next_desc += ADMA_DESC_LEN;
> +}
> +
> +static inline void __sdhci_adma_write_desc(struct sdhci_host *host,
> +					   void **desc, dma_addr_t addr,
> +					   int len, bool end)
> +{
> +	if (host && host->ops && host->ops->adma_write_desc)
> +		host->ops->adma_write_desc(host, desc, addr, len, end);
> +	else
> +		sdhci_adma_write_desc(host, desc, addr, len, end);
>  }
> 
>  /**
>   * sdhci_prepare_adma_table() - Populate the ADMA table
>   *
> + * @host:	Pointer to the sdhci_host
>   * @table:	Pointer to the ADMA table
>   * @data:	Pointer to MMC data
>   * @addr:	DMA address to write to or read from
> @@ -39,25 +53,26 @@ static void sdhci_adma_desc(struct sdhci_adma_desc *desc,
>   * Please note, that the table size depends on CONFIG_SYS_MMC_MAX_BLK_COUNT and
>   * we don't have to check for overflow.
>   */
> -void sdhci_prepare_adma_table(struct sdhci_adma_desc *table,
> -			      struct mmc_data *data, dma_addr_t addr)
> +void sdhci_prepare_adma_table(struct sdhci_host *host,
> +			      struct sdhci_adma_desc *table,
> +			      struct mmc_data *data, dma_addr_t start_addr)
>  {
> +	dma_addr_t addr = start_addr;
>  	uint trans_bytes = data->blocksize * data->blocks;
> -	uint desc_count = DIV_ROUND_UP(trans_bytes, ADMA_MAX_LEN);
> -	struct sdhci_adma_desc *desc = table;
> -	int i = desc_count;
> +	void *next_desc = table;
> +	int i = DIV_ROUND_UP(trans_bytes, ADMA_MAX_LEN);
> 
>  	while (--i) {
> -		sdhci_adma_desc(desc, addr, ADMA_MAX_LEN, false);
> +		__sdhci_adma_write_desc(host, &next_desc, addr,
> +					ADMA_MAX_LEN, false);
>  		addr += ADMA_MAX_LEN;
>  		trans_bytes -= ADMA_MAX_LEN;
> -		desc++;
>  	}
> 
> -	sdhci_adma_desc(desc, addr, trans_bytes, true);
> +	__sdhci_adma_write_desc(host, &next_desc, addr, trans_bytes, true);
> 
> -	flush_cache((dma_addr_t)table,
> -		    ROUND(desc_count * sizeof(struct sdhci_adma_desc),
> +	flush_cache((phys_addr_t)table,
> +		    ROUND(next_desc - (void *)table,
>  			  ARCH_DMA_MINALIGN));
>  }
> 
> diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> index 0178ed8a11..65090348ae 100644
> --- a/drivers/mmc/sdhci.c
> +++ b/drivers/mmc/sdhci.c
> @@ -111,7 +111,7 @@ static void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data,
>  	}
>  #if CONFIG_IS_ENABLED(MMC_SDHCI_ADMA)
>  	else if (host->flags & (USE_ADMA | USE_ADMA64)) {
> -		sdhci_prepare_adma_table(host->adma_desc_table, data,
> +		sdhci_prepare_adma_table(host, host->adma_desc_table, data,
>  					 host->start_addr);
> 
>  		sdhci_writel(host, lower_32_bits(host->adma_addr),
> @@ -897,8 +897,10 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
>  		       __func__);
>  		return -EINVAL;
>  	}
> -	host->adma_desc_table = sdhci_adma_init();
> -	host->adma_addr = (dma_addr_t)host->adma_desc_table;
> +	if (!host->adma_desc_table) {
> +		host->adma_desc_table = sdhci_adma_init();
> +		host->adma_addr = virt_to_phys(host->adma_desc_table);
> +	}
> 
>  #ifdef CONFIG_DMA_ADDR_T_64BIT
>  	host->flags |= USE_ADMA64;
> diff --git a/include/sdhci.h b/include/sdhci.h
> index a1b74e3bd7..4bde7db5c7 100644
> --- a/include/sdhci.h
> +++ b/include/sdhci.h
> @@ -291,6 +291,11 @@ struct sdhci_ops {
>  	 * Return: 0 if successful, -ve on error
>  	 */
>  	int	(*set_enhanced_strobe)(struct sdhci_host *host);
> +
> +#if CONFIG_IS_ENABLED(MMC_SDHCI_ADMA)
> +	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
> +				   dma_addr_t addr, int len, bool end);
> +#endif
>  };
> 
>  #define ADMA_MAX_LEN	65532
> @@ -526,8 +531,11 @@ extern const struct dm_mmc_ops sdhci_ops;
>  #else
>  #endif
> 
> +void sdhci_adma_write_desc(struct sdhci_host *host, void **next_desc,
> +			   dma_addr_t addr, int len, bool end);
>  struct sdhci_adma_desc *sdhci_adma_init(void);
> -void sdhci_prepare_adma_table(struct sdhci_adma_desc *table,
> -			      struct mmc_data *data, dma_addr_t addr);
> +void sdhci_prepare_adma_table(struct sdhci_host *host,
> +			      struct sdhci_adma_desc *table,
> +			      struct mmc_data *data, dma_addr_t start_addr);
> 
>  #endif /* __SDHCI_HW_H */
> --
> 2.43.2


