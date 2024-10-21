Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B23D3C927
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 01:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB87892DE;
	Mon, 21 Oct 2024 03:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dYWsx6Wc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6566F892A5; Mon, 21 Oct 2024 03:32:47 +0200 (CEST)
Received: from mail-m3273.qiye.163.com (mail-m3273.qiye.163.com
 [220.197.32.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B724A891E6
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 03:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=dYWsx6Wc5bOR63T3ApM5VR7Yok1nSc23JAn2zBmDQcpAaqK8it0iOk42aBqeW0Eek2BxnKXyMXhEc2U3inG0qSinJBSvMQWJZP52XXdF6GLqCxaRKAN3g4EadHr7FlVgiGKxY5V69X+WJzMgmBdRr8wFPRqsINLmM5KoWym22zo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=xOEz8mHIj+1/NldW4g9dHau9Cb82h3NmhF9P8iwXa8Y=;
 h=date:mime-version:subject:message-id:from;
Received: from yk?rock-chips.com
 (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with SMTP id D1898520146;
 Mon, 21 Oct 2024 09:32:10 +0800 (CST)
Message-ID: <21a1fa55-4ce8-4822-a5e8-8bc7adf637ac@rock-chips.com>
Date: Mon, 21 Oct 2024 09:32:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: Correct vendor prefix for
 Hardkernel ODROID-M1
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Aurelien Jarno <aurelien@aurel32.net>,
 Heiko Stuebner <heiko@sntech.de>
References: <20241003194101.328231-1-jonas@kwiboo.se>
 <20241003194101.328231-2-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20241003194101.328231-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkhDHlZMH01MGEwaTkoeT0tWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92acb4094e03afkunmd1898520146
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjY6HBw4MTIqFygDOUlKThQx
 DTUKFAlVSlVKTElCT0xPSEhITEpLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS0tMNwY+
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


On 2024/10/4 03:40, Jonas Karlman wrote:
> The vendor prefix for Hardkernel ODROID-M1 is incorrectly listed as
> rockchip. Use the proper hardkernel vendor prefix for this board, while
> at it also drop the redundant soc prefix.
>
> Fixes: fd3583267703 ("arm64: dts: rockchip: Add Hardkernel ODROID-M1 board")
> Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20240827211825.1419820-3-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 735065e774dcfc62e38df01a535862138b6c92ed ]
>
> (cherry picked from commit e7259a2c4a6f2ebdfc96b8bbffc77fe67604b11f)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3568-odroid-m1.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3568-odroid-m1.dts b/dts/upstream/src/arm64/rockchip/rk3568-odroid-m1.dts
> index a337f547caf5..6a02db4f073f 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3568-odroid-m1.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3568-odroid-m1.dts
> @@ -13,7 +13,7 @@
>   
>   / {
>   	model = "Hardkernel ODROID-M1";
> -	compatible = "rockchip,rk3568-odroid-m1", "rockchip,rk3568";
> +	compatible = "hardkernel,odroid-m1", "rockchip,rk3568";
>   
>   	aliases {
>   		ethernet0 = &gmac0;
