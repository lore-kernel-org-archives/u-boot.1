Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD787C3601E
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2862482FAA;
	Tue,  8 Apr 2025 05:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="S3gUPmla";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBCF882CE7; Tue,  8 Apr 2025 05:17:14 +0200 (CEST)
Received: from mail-m1973178.qiye.163.com (mail-m1973178.qiye.163.com
 [220.197.31.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5936C82FD4
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1101c67db;
 Tue, 8 Apr 2025 11:17:04 +0800 (GMT+08:00)
Message-ID: <ea030584-05d3-45af-a869-ebcc4212ae03@rock-chips.com>
Date: Tue, 8 Apr 2025 11:17:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] pinctrl: rockchip: constify rockchip_pin_ctrl for
 RK3328
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de>
 <20250129-rockchip-pinctrl-const-v1-11-450ccdadfa7e@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250129-rockchip-pinctrl-const-v1-11-450ccdadfa7e@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxhKGVZMHkhLGhhKQkxKSktWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a961366c46b03afkunm1101c67db
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PjY6Eyo4ATJONUILETM2Fzks
 AhUwCS1VSlVKTE9PS0NJSUlOTEpNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS0hDNwY+
DKIM-Signature: a=rsa-sha256;
 b=S3gUPmlaxa6T1trhuhd+b0kCSPMYT77U5K1/3M/vbQ9zuR407K70b6mo4zl7f2bVDqGK+CRsmYdioOTRXEvlOlCd/bpvngqvSK2ZvmbJtawBM65/3M1zL1242F4dLU7Pt5rC+S0dOvsUVOluUK+qY/WumcdZUYbtfJyYBw+8Ci4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=LWVurJZemQHVOe3yegmQZ8ijE35rzHePf73cNruDP58=;
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
>   drivers/pinctrl/rockchip/pinctrl-rk3328.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3328.c b/drivers/pinctrl/rockchip/pinctrl-rk3328.c
> index 47c2e923a1bb5292bdbe934a91fdb78404c37327..cc9f20a2e43e66d19375b5a112a4abddd81fa2ff 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rk3328.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk3328.c
> @@ -285,7 +285,7 @@ static struct rockchip_pin_bank rk3328_pin_banks[] = {
>   			     0),
>   };
>   
> -static struct rockchip_pin_ctrl rk3328_pin_ctrl = {
> +static const struct rockchip_pin_ctrl rk3328_pin_ctrl = {
>   	.pin_banks		= rk3328_pin_banks,
>   	.nr_banks		= ARRAY_SIZE(rk3328_pin_banks),
>   	.grf_mux_offset		= 0x0,
>
