Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193B8CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F31B686EA1;
	Thu, 12 Oct 2023 04:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QEXkqD9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD5F986DAF; Thu, 12 Oct 2023 04:20:08 +0200 (CEST)
Received: from mail-m12798.qiye.163.com (mail-m12798.qiye.163.com
 [115.236.127.98])
 by phobos.denx.de (Postfix) with ESMTP id 48E5786E37
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 04:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=QEXkqD9Nh40oP9qiF7RM8C2ibq4Of/mnTRhcPkK++i9ikkZ3TLl78enthqiP2KPRLqKqhWqx0goh8cNAUxEd5eCePBC9Wif4VZZCHDlxVZ17RdYcy8YImugF4tyKAXrjw9LqwLnWeP/BieYGisLhh9bQFamvnSxdVn7pNV28di4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=95R5zu+rnIhOcZtKdLy5xSvQpzxz9hqNYK5JVgba3fg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 65837400291;
 Thu, 12 Oct 2023 10:18:19 +0800 (CST)
Message-ID: <b7bd9415-3611-ab9e-f65c-d879319377b0@rock-chips.com>
Date: Thu, 12 Oct 2023 10:18:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] usb: dwc3-generic: Use combined glue and ctrl node
 for RK3588
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
References: <20231010222344.3436526-1-jonas@kwiboo.se>
 <20231010222344.3436526-5-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231010222344.3436526-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxIS1ZNGU5LQ01JHR9PHxpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b21ad7c532eb3kusn65837400291
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhQ6Nyo6PTw8DBQLEz1MFw0i
 Iz8aFBVVSlVKTUJMS0xMSktLSEtKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTU9CNwY+
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


On 2023/10/11 06:23, Jonas Karlman wrote:
> Like Rockchip RK3328 and RK3568, the RK3588 also have single node to
> represent the glue and ctrl for USB 3.0.
>
> Use rk_ops as driver data to select correct ctrl node for RK3588 DWC3.
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
> index 744fde806948..6fb2de8a5ace 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -610,6 +610,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
>   	{ .compatible = "rockchip,rk3328-dwc3", .data = (ulong)&rk_ops },
>   	{ .compatible = "rockchip,rk3399-dwc3" },
>   	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
> +	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
>   	{ .compatible = "qcom,dwc3" },
>   	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
>   	{ .compatible = "fsl,imx8mq-dwc3" },
