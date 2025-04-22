Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0000C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C4A481E25;
	Tue, 22 Apr 2025 16:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jxRUmtzD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00CD982047; Tue, 22 Apr 2025 16:52:11 +0200 (CEST)
Received: from mail-m15593.qiye.163.com (mail-m15593.qiye.163.com
 [101.71.155.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FDE18070C
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.69.12] (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12bf5b42e;
 Tue, 22 Apr 2025 22:52:03 +0800 (GMT+08:00)
Message-ID: <e4ebaebd-e542-4565-a8a7-b1b9e96d227d@rock-chips.com>
Date: Tue, 22 Apr 2025 22:52:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/15] rockchip: otp: Add support for RK3576
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
References: <20250415215128.1475593-1-heiko@sntech.de>
 <20250415215128.1475593-9-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250415215128.1475593-9-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSEpNVk9NSEJOTB9JTB9CQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NMVUpLS1
 VLWQY+
X-HM-Tid: 0a965dfc148003afkunm12bf5b42e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Phw6Ixw5UTJOLEk9AQIVAzQU
 EwgwC01VSlVKTE9OSEhITklOSkxLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUlJQkg3Bg++
DKIM-Signature: a=rsa-sha256;
 b=jxRUmtzDI7fezAIPlVyxqN6p7mYSzlr1/HoXj/zJfm5qcdg2njLQiIy3uSYNkBPLzwGJ+qMIQnweQdG3LO9kkDCz1MkxeGXQhI8qWRoC/ZrJTPdjOL+DZXuKtThh0JLMEEgRfGZV/sen2yn+PKURarLBMCBCrjnR0PKAogM/GN4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=6Nqq79f8NYwJ399SZLQy3dKSCB5KbrUXx4ijME/KYjU=;
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


On 2025/4/16 05:51, Heiko Stuebner wrote:
> Add support for RK3576 compatible.
> The RK3576 OTP uses the same read mechanism as the RK3588, just
> with different values for offset and size.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/misc/rockchip-otp.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/misc/rockchip-otp.c b/drivers/misc/rockchip-otp.c
> index b5597de39ac..46820425a84 100644
> --- a/drivers/misc/rockchip-otp.c
> +++ b/drivers/misc/rockchip-otp.c
> @@ -361,6 +361,13 @@ static const struct rockchip_otp_data rk3568_data = {
>   	.block_size = 2,
>   };
>   
> +static const struct rockchip_otp_data rk3576_data = {
> +	.read = rockchip_rk3588_otp_read,
> +	.offset = 0x700,
> +	.size = 0x100,
> +	.block_size = 4,
> +};
> +
>   static const struct rockchip_otp_data rk3588_data = {
>   	.read = rockchip_rk3588_otp_read,
>   	.offset = 0xC00,
> @@ -391,6 +398,10 @@ static const struct udevice_id rockchip_otp_ids[] = {
>   		.compatible = "rockchip,rk3568-otp",
>   		.data = (ulong)&rk3568_data,
>   	},
> +	{
> +		.compatible = "rockchip,rk3576-otp",
> +		.data = (ulong)&rk3576_data,
> +	},
>   	{
>   		.compatible = "rockchip,rk3588-otp",
>   		.data = (ulong)&rk3588_data,
