Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBC4C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46E43800D7;
	Tue,  6 May 2025 09:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KSz3P2G5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75655800D7; Tue,  6 May 2025 09:56:05 +0200 (CEST)
Received: from mail-m49245.qiye.163.com (mail-m49245.qiye.163.com
 [45.254.49.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64C7C800C1
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 14172c088;
 Tue, 6 May 2025 15:55:52 +0800 (GMT+08:00)
Message-ID: <18914da6-fc64-45bf-b6f4-984114cb5f7a@rock-chips.com>
Date: Tue, 6 May 2025 15:55:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] pinctrl: rockchip: constify rockchip_pin_ctrl
 for RK3228
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250131-rockchip-pinctrl-const-v2-0-59bf93968ce7@cherry.de>
 <20250131-rockchip-pinctrl-const-v2-7-59bf93968ce7@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250131-rockchip-pinctrl-const-v2-7-59bf93968ce7@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ0NOVhpCGEhCSUpNQ0NMHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96a49813f803afkunm14172c088
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Phg6Nww6HjJIFRceOQ8TCB4S
 KTFPCSlVSlVKTE9NTkpDSk5ITk1CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlLTkw3Bg++
DKIM-Signature: a=rsa-sha256;
 b=KSz3P2G5EJRECdQkWeUv0hE7W9GegD/BaH0yzU1M2mYx8Z21H9kdhavLQ9nbnzRsj9zPd/y+SaDnzDlUfZfZz7qgx5aJKcHkDkw93RSY4R8aDRX9zaUPF4Ur6lL+XGDJDAl9Tq3Fo3QmDnfJyQhiNXymzyW5qTnH+iMnc8tialk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=NGklXobQ06dpNH5nWHVPyX1533fa8VWIK5ETroknVQg=;
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


On 2025/1/31 18:31, Quentin Schulz wrote:
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
>   drivers/pinctrl/rockchip/pinctrl-rk322x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk322x.c b/drivers/pinctrl/rockchip/pinctrl-rk322x.c
> index b804597c048415f3875222b201442fc025b35658..a80978685d4c84edf4297e24958b52a147b3c1f7 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rk322x.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk322x.c
> @@ -257,7 +257,7 @@ static struct rockchip_pin_bank rk3228_pin_banks[] = {
>   	PIN_BANK(3, 32, "gpio3"),
>   };
>   
> -static struct rockchip_pin_ctrl rk3228_pin_ctrl = {
> +static const struct rockchip_pin_ctrl rk3228_pin_ctrl = {
>   	.pin_banks		= rk3228_pin_banks,
>   	.nr_banks		= ARRAY_SIZE(rk3228_pin_banks),
>   	.grf_mux_offset		= 0x0,
>
