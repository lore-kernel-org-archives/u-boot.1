Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6A7E7F154
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 03:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7EAB86D8D;
	Wed, 27 Sep 2023 05:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jchCAVfc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8F4286D9A; Wed, 27 Sep 2023 05:00:40 +0200 (CEST)
Received: from mail-m49220.qiye.163.com (mail-m49220.qiye.163.com
 [45.254.49.220])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 857BB86D8F
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 05:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=jchCAVfcu/c//cJg7/D4Gz/9QRG3/uHdDYb6VOWhQfnuON+Ys08TrDZeD2N3xUO5SR9jo4XITneEk/vcVzxPak4GJM3VN9TJ43yypfTBIjiKOWmZVmXPjS2Hqdj7VuHbL2DD5zMUtn4vWzwBIw4nq6x7sYegk77eBkJnb9scPa8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=+W2AHC9L4zcr40DdYWVSw42JfPu2lNZ38cfMTb11PMc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 473ED4002D3;
 Wed, 27 Sep 2023 11:00:32 +0800 (CST)
Message-ID: <12fc93a7-b8db-bf87-46bd-7aeb5b2e2571@rock-chips.com>
Date: Wed, 27 Sep 2023 11:00:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/7] net: dwc_eth_qos: Return error code when start fails
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de
References: <20230807000817.1701012-1-jonas@kwiboo.se>
 <20230807000817.1701012-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230807000817.1701012-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpOQ1ZKTUtJTkMdTB5CTBpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad494bee12eb3kusn473ed4002d3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MEk6NSo5Mzw#CDY3IwwXKAst
 NzcwCy5VSlVKTUJOTENITUhISk9MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTUNJNwY+
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
> Return error code when phy_connect fails or no link can be established.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/net/dwc_eth_qos.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 555eaee3bbc3..7565e716823a 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -811,6 +811,7 @@ static int eqos_start(struct udevice *dev)
>   
>   		if (!eqos->phy) {
>   			pr_err("phy_connect() failed");
> +			ret = -ENODEV;
>   			goto err_stop_resets;
>   		}
>   
> @@ -838,6 +839,7 @@ static int eqos_start(struct udevice *dev)
>   
>   	if (!eqos->phy->link) {
>   		pr_err("No link");
> +		ret = -EAGAIN;
>   		goto err_shutdown_phy;
>   	}
>   
