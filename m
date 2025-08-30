Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D42ECA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8E09838DD;
	Sat, 30 Aug 2025 17:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="AaKUkITE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E083838DC; Sat, 30 Aug 2025 17:25:06 +0200 (CEST)
Received: from mail-m49238.qiye.163.com (mail-m49238.qiye.163.com
 [45.254.49.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FAAD838A5
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123f9898;
 Sat, 30 Aug 2025 23:25:00 +0800 (GMT+08:00)
Message-ID: <9eb0ecf6-6edf-4edd-922b-d9e05e1b2714@rock-chips.com>
Date: Sat, 30 Aug 2025 23:24:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] usb: dwc3-generic: Use combined glue and ctrl node
 for RK3528
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250730235301.1774089-1-jonas@kwiboo.se>
 <20250730235301.1774089-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250730235301.1774089-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb94f62303afkunm91877a6d415721
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTEIaVk9PSRhJHxlJT05NSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=AaKUkITEBCBrCx6vy25ruwWFrfUgXMdmGJfzLS0pcWv/193Tnq3joacAbFU61wWMrxSL0jFF1xYCEGr3wuopsjOP7m6i15tEaNAqdU392R1DA9MQaqzkIKuAd2w6N1T+q2r5VHivwMTgZgSKIs2pnNdsb29Ds7RfEKbXqpS+ml0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=74JMztFas0a3DXOEekftjYlkaOADDwzRVSwL0Gcg+es=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/7/31 07:52, Jonas Karlman wrote:
> Like Rockchip RK3328, RK3568 and RK3588, the RK3528 also have a single
> node to represent the glue and ctrl for USB 3.0.
>
> Use rk_ops as driver data to select correct ctrl node for RK3528 DWC3.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 3cda2b74b7e3..6b2016c0cd37 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -698,6 +698,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
>   	{ .compatible = "ti,am654-dwc3" },
>   	{ .compatible = "rockchip,rk3328-dwc3", .data = (ulong)&rk_ops },
>   	{ .compatible = "rockchip,rk3399-dwc3" },
> +	{ .compatible = "rockchip,rk3528-dwc3", .data = (ulong)&rk_ops },
>   	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
>   	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
>   	{ .compatible = "qcom,dwc3", .data = (ulong)&qcom_ops },
