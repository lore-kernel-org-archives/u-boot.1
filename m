Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB06E7F153
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 03:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DFEA86BF5;
	Wed, 27 Sep 2023 05:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="I5Kkz+7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC8486D6D; Wed, 27 Sep 2023 05:00:27 +0200 (CEST)
Received: from mail-m12748.qiye.163.com (mail-m12748.qiye.163.com
 [115.236.127.48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEA7086BD7
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 05:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=I5Kkz+7BMUWsxOQXWb8bna9Lk9ZX+IEOhD5uNWC3zfYPr9oY9BNRVlWcaMOM53rDUYLrxL0xvFOgIHiqKWe8XAIYjeCZi2Q2eONDnJ2WKU7W1qEhOswaDAk4kyabIIVae59Gwq+8mXHftUJqZkpbyffqahKQlDJr6uyxzw8npZo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=1krxUjC5LIRiaZSMKG/taspqSIyLDPjJsA80/KIPEUQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 923824002BF;
 Wed, 27 Sep 2023 11:00:18 +0800 (CST)
Message-ID: <27cd1bad-144e-303d-6f3c-c10942dce978@rock-chips.com>
Date: Wed, 27 Sep 2023 11:00:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/7] net: dwc_eth_qos: Drop unused rx_pkt from eqos_priv
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de
References: <20230807000817.1701012-1-jonas@kwiboo.se>
 <20230807000817.1701012-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230807000817.1701012-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkkaGVZJSE1MT0hCSU1CTU1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad49489122eb3kusn923824002bf
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N1E6TDo6KDw8EDZPSggyLQEq
 CAEKCwFVSlVKTUJOTENITUpCT0hCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITEtDNwY+
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


On 2023/8/7 08:08, Jonas Karlman wrote:
> rx_pkt is allocated and not used for anything, remove it.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/net/dwc_eth_qos.c | 11 -----------
>   drivers/net/dwc_eth_qos.h |  1 -
>   2 files changed, 12 deletions(-)
>
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 1e92bd9ca9c0..555eaee3bbc3 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1314,22 +1314,12 @@ static int eqos_probe_resources_core(struct udevice *dev)
>   	}
>   	debug("%s: rx_dma_buf=%p\n", __func__, eqos->rx_dma_buf);
>   
> -	eqos->rx_pkt = malloc(EQOS_MAX_PACKET_SIZE);
> -	if (!eqos->rx_pkt) {
> -		debug("%s: malloc(rx_pkt) failed\n", __func__);
> -		ret = -ENOMEM;
> -		goto err_free_rx_dma_buf;
> -	}
> -	debug("%s: rx_pkt=%p\n", __func__, eqos->rx_pkt);
> -
>   	eqos->config->ops->eqos_inval_buffer(eqos->rx_dma_buf,
>   			EQOS_MAX_PACKET_SIZE * EQOS_DESCRIPTORS_RX);
>   
>   	debug("%s: OK\n", __func__);
>   	return 0;
>   
> -err_free_rx_dma_buf:
> -	free(eqos->rx_dma_buf);
>   err_free_tx_dma_buf:
>   	free(eqos->tx_dma_buf);
>   err_free_descs:
> @@ -1348,7 +1338,6 @@ static int eqos_remove_resources_core(struct udevice *dev)
>   
>   	debug("%s(dev=%p):\n", __func__, dev);
>   
> -	free(eqos->rx_pkt);
>   	free(eqos->rx_dma_buf);
>   	free(eqos->tx_dma_buf);
>   	eqos_free_descs(eqos->rx_descs);
> diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
> index a6b719af809f..06a082da72ef 100644
> --- a/drivers/net/dwc_eth_qos.h
> +++ b/drivers/net/dwc_eth_qos.h
> @@ -273,7 +273,6 @@ struct eqos_priv {
>   	unsigned int desc_per_cacheline;
>   	void *tx_dma_buf;
>   	void *rx_dma_buf;
> -	void *rx_pkt;
>   	bool started;
>   	bool reg_access_ok;
>   	bool clk_ck_enabled;
