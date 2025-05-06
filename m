Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2B9C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D84B2800D7;
	Tue,  6 May 2025 09:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="N8ddq6rk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F13F28212F; Tue,  6 May 2025 09:55:22 +0200 (CEST)
Received: from mail-m81130.netease.com (mail-m81130.netease.com [47.88.81.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFDE6800C1
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 14172bfa6;
 Tue, 6 May 2025 15:55:13 +0800 (GMT+08:00)
Message-ID: <e097b045-b822-4578-9e3c-f6f733045c93@rock-chips.com>
Date: Tue, 6 May 2025 15:55:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] pinctrl: rockchip: constify rockchip_pin_ctrl
 for PX30
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250131-rockchip-pinctrl-const-v2-0-59bf93968ce7@cherry.de>
 <20250131-rockchip-pinctrl-const-v2-2-59bf93968ce7@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250131-rockchip-pinctrl-const-v2-2-59bf93968ce7@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGh5MVh5LGBlLGU9CHkgdTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96a4977ed003afkunm14172bfa6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NSo6Vjo5ITJPIxcUOQsLAgkV
 AjdPFA9VSlVKTE9NTkpDSkpOTElIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlLSkM3Bg++
DKIM-Signature: a=rsa-sha256;
 b=N8ddq6rkMnXTW6dzZIWgDX+quJNp3TPWnCkBuxljqrzn7q3Swa+TA5ForGMTSz2t0v4L2AUHeMl9k8JR5MN5w53BL4XgfR9+kVWx1h+5inUGH7n0nQLB6ppA3jmjLk3D2meLuNI/46xAo/9iPW2YcAMswIN3VcJHMVnCEJ54EEQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=/we4Vo/rdEeQAjkmdHJkG0747gD2lHx9SCAQvpKw+tQ=;
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
>   drivers/pinctrl/rockchip/pinctrl-px30.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-px30.c b/drivers/pinctrl/rockchip/pinctrl-px30.c
> index cc7885bae40802eccfc2cad377727da9ee899139..4595d8a4a23fbf1299ab382fb92eca32527ae637 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-px30.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-px30.c
> @@ -324,7 +324,7 @@ static struct rockchip_pin_bank px30_pin_banks[] = {
>   			    ),
>   };
>   
> -static struct rockchip_pin_ctrl px30_pin_ctrl = {
> +static const struct rockchip_pin_ctrl px30_pin_ctrl = {
>   	.pin_banks		= px30_pin_banks,
>   	.nr_banks		= ARRAY_SIZE(px30_pin_banks),
>   	.grf_mux_offset		= 0x0,
>
