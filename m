Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7983E77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 08:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2359280107;
	Thu,  2 Jan 2025 09:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LUb5okqF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84BA080352; Thu,  2 Jan 2025 09:45:21 +0100 (CET)
Received: from mail-m127210.xmail.ntesmail.com
 (mail-m127210.xmail.ntesmail.com [115.236.127.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BA8E80087
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 09:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 77d8c036;
 Thu, 2 Jan 2025 16:45:14 +0800 (GMT+08:00)
Message-ID: <058318a7-fdb3-4fef-b8de-96b9a54e4646@rock-chips.com>
Date: Thu, 2 Jan 2025 16:45:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] arm64: dts: rockchip: fix model name for FriendlyElec
 NanoPi R3S
To: Tianling Shen <cnsztl@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20241226092043.419511-1-cnsztl@gmail.com>
 <20241226092043.419511-3-cnsztl@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241226092043.419511-3-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkNCSlZCT0JOGh1OHhkYShhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942630b7ce03afkunm77d8c036
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRA6Oio4VjISPSgZT1YQDQIq
 HzMKCQNVSlVKTEhOQ0tMTkpOTUNJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTUlLNwY+
DKIM-Signature: a=rsa-sha256;
 b=LUb5okqFa/IHQW8hhNYl0z29m2nTXb4rMwahZPvA76EWPN70lpiMyaMhltsphgSx53mn0F/z1JkdO58uwtxkJKMIM+phHXku2aZPtS1EwB+V3s1jvgDfIq0JSkIiwHfv+f26Vn8GoJuQ8EZtrtBU6MAutEHLdSEG84+kIjE2Rs8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=C0p1ygkmCZDtMjeJEkxcvxpgbGnPNlri9Df68o4kFTY=;
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


On 2024/12/26 17:20, Tianling Shen wrote:
> Use the marketing name for model name, this matches the dt-binding.
> Also update the website url in copyright.
>
> Fixes: 50decd493c83 ("arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board")
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> Link: https://lore.kernel.org/r/20241022193537.1117919-2-cnsztl@gmail.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: b5bf84206a5c77528f9dd4cbca4e72caa063c102 ]
>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
> index a7a55d68db..6bc17f755b 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
> @@ -3,7 +3,7 @@
>    * Copyright (c) 2020 Rockchip Electronics Co., Ltd.
>    *
>    * Copyright (c) 2024 FriendlyElec Computer Tech. Co., Ltd.
> - * (http://www.friendlyarm.com)
> + * (http://www.friendlyelec.com)
>    *
>    * Copyright (c) 2024 Tianling Shen <cnsztl@gmail.com>
>    */
> @@ -17,7 +17,7 @@
>   #include "rk3566.dtsi"
>   
>   / {
> -	model = "FriendlyARM NanoPi R3S";
> +	model = "FriendlyElec NanoPi R3S";
>   	compatible = "friendlyarm,nanopi-r3s", "rockchip,rk3566";
>   
>   	aliases {
