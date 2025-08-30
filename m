Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE44BCA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727A783893;
	Sat, 30 Aug 2025 16:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="RAn9NPFj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88689838B7; Sat, 30 Aug 2025 16:57:02 +0200 (CEST)
Received: from mail-m49206.qiye.163.com (mail-m49206.qiye.163.com
 [45.254.49.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 670C48380E
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123c4c68;
 Sat, 30 Aug 2025 22:56:53 +0800 (GMT+08:00)
Message-ID: <585ba226-c6d7-4432-bbb8-db57feb6f880@rock-chips.com>
Date: Sat, 30 Aug 2025 22:56:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] usb: dwc3-generic: Use combined glue and ctrl node
 for RK3576
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
References: <20250801203255.2590535-1-jonas@kwiboo.se>
 <20250801203255.2590535-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250801203255.2590535-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb7b39fd03afkunmbe6a424840d5be
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHh9IVhlDGExJSk8fSEMYSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=RAn9NPFjHDGfwLXPy8TR5dWN+2B0hb+1QX0rGRbsV62SqkXln7gtageu6PLscxT0PDlWZuHn3ZqdtGgAfH2KVgXvwFyucKl9am8DFzS3DrmfAvOzIiX9HlpHwxpcv4jlJxVzEzi0bdCYCHhIN0dFQvNOVmJ7H6L11HDzSsRPnDA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=47D9onTcAlYNXbmxrlfOCjZYdD+6mmUTuz/E53fuawI=;
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


On 2025/8/2 04:32, Jonas Karlman wrote:
> Like Rockchip RK3328, RK3568 and RK3588, the RK3576 also have a single
> node to represent the glue and ctrl for USB 3.0.
>
> Use rk_ops as driver data to select correct ctrl node for RK3576 DWC3.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: New patch
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 3cda2b74b7e3..cdb997ea6e48 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -699,6 +699,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
>   	{ .compatible = "rockchip,rk3328-dwc3", .data = (ulong)&rk_ops },
>   	{ .compatible = "rockchip,rk3399-dwc3" },
>   	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
> +	{ .compatible = "rockchip,rk3576-dwc3", .data = (ulong)&rk_ops },
>   	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
>   	{ .compatible = "qcom,dwc3", .data = (ulong)&qcom_ops },
>   	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
