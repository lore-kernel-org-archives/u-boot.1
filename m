Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32ABE7F153
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 03:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F16986DB8;
	Wed, 27 Sep 2023 05:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="e5rrawgV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C364186DB1; Wed, 27 Sep 2023 05:00:49 +0200 (CEST)
Received: from mail-m127162.xmail.ntesmail.com
 (mail-m127162.xmail.ntesmail.com [115.236.127.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4006C86DB8
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 05:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=e5rrawgV/o9R2ZZtbtHXxV55Fpl9q55wfWwkxirGh6sCtrUr1s0DwlFpkjIbc1sTn/Xu0KUAUmi7oq3buwtmBUCfqJvm2rbEcAiI2HfMCnma3jUwoYKm/kEsn9WTPVYSGbrulyRxSaqNITr3BVU065wCUz6qV5nT749v8KyGa+g=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=OW+vdjmdZ8KQdpx3wYJ+i3lHdid8a0jv2ERYA3ueSW0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 475B44002DA;
 Wed, 27 Sep 2023 11:00:40 +0800 (CST)
Message-ID: <67a43531-a3e0-dd8c-06f5-8510a47f6ad3@rock-chips.com>
Date: Wed, 27 Sep 2023 11:00:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/7] net: dwc_eth_qos: Stop spam of RX packet not
 available message
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de
References: <20230807000817.1701012-1-jonas@kwiboo.se>
 <20230807000817.1701012-4-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230807000817.1701012-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk1NH1YYGU8aSEtOTEtDQ0tVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad494de662eb3kusn475b44002da
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ND46LSo4STw9TTY0MwxWKBI8
 Th8aCzBVSlVKTUJOTENITU9KSUtLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS0pLNwY+
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
> Remove spam of RX packet not available debug messages when waiting to
> receive a packet.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/net/dwc_eth_qos.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 7565e716823a..24fb3fac1f12 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1193,14 +1193,12 @@ static int eqos_recv(struct udevice *dev, int flags, uchar **packetp)
>   	struct eqos_desc *rx_desc;
>   	int length;
>   
> -	debug("%s(dev=%p, flags=%x):\n", __func__, dev, flags);
> -
>   	rx_desc = eqos_get_desc(eqos, eqos->rx_desc_idx, true);
>   	eqos->config->ops->eqos_inval_desc(rx_desc);
> -	if (rx_desc->des3 & EQOS_DESC3_OWN) {
> -		debug("%s: RX packet not available\n", __func__);
> +	if (rx_desc->des3 & EQOS_DESC3_OWN)
>   		return -EAGAIN;
> -	}
> +
> +	debug("%s(dev=%p, flags=%x):\n", __func__, dev, flags);
>   
>   	*packetp = eqos->rx_dma_buf +
>   		(eqos->rx_desc_idx * EQOS_MAX_PACKET_SIZE);
