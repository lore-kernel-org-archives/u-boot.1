Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1C6C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1AAD82CEA;
	Tue,  8 Apr 2025 05:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dGhhFjTV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C110882F29; Tue,  8 Apr 2025 05:17:04 +0200 (CEST)
Received: from mail-m49246.qiye.163.com (mail-m49246.qiye.163.com
 [45.254.49.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 144E582CE7
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1101c67ac;
 Tue, 8 Apr 2025 11:16:55 +0800 (GMT+08:00)
Message-ID: <5fba7052-9c64-49ed-a24f-d02b711a874e@rock-chips.com>
Date: Tue, 8 Apr 2025 11:16:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] pinctrl: rockchip: constify rockchip_pin_ctrl for
 RK3308
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de>
 <20250129-rockchip-pinctrl-const-v1-10-450ccdadfa7e@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250129-rockchip-pinctrl-const-v1-10-450ccdadfa7e@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUtMQlYYTBgaT0MeSh1NTUNWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a961366a42303afkunm1101c67ac
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzI6EQw5KTJKH0IvPzMdFzAY
 HBwaCTxVSlVKTE9PS0NJSUpNQk1IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS05NNwY+
DKIM-Signature: a=rsa-sha256;
 b=dGhhFjTV9lJHrK6xOGn3Cj4dEkgJ2vv3qdB+m9DA9b23aB7ct0xc7LEZmsu9hD9WLg3/tTGjk1UNHxCLf0HalqG/45O0EeR00uNHeo0kJbEP2DXBL8B9S/E8TRSXvle1i1zPmeM2/lvLl8JPr2o6+26qkjwgs9Kr2mUcI3gbDZw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=DppiLYZX/PE4Uz7OYpBNqtiL84fTXSKXoGAAFxiNjcs=;
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


On 2025/1/29 20:42, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> There's no need to modify private data from the controller, so let's
> make that struct const.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/pinctrl/rockchip/pinctrl-rk3308.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3308.c b/drivers/pinctrl/rockchip/pinctrl-rk3308.c
> index 2cd91b10a3bdbb55cf1e1a56a1b3a240a2899047..5c0e34a7baad835c54f6975017d7e183db5cd84d 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rk3308.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk3308.c
> @@ -421,7 +421,7 @@ static struct rockchip_pin_bank rk3308_pin_banks[] = {
>   					     IOMUX_8WIDTH_2BIT),
>   };
>   
> -static struct rockchip_pin_ctrl rk3308_pin_ctrl = {
> +static const struct rockchip_pin_ctrl rk3308_pin_ctrl = {
>   	.pin_banks		= rk3308_pin_banks,
>   	.nr_banks		= ARRAY_SIZE(rk3308_pin_banks),
>   	.grf_mux_offset		= 0x0,
>
