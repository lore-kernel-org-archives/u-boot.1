Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4233DE7718B
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 08:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C73F5803C6;
	Thu,  2 Jan 2025 09:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="aX0T0J5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1D0180379; Thu,  2 Jan 2025 09:55:18 +0100 (CET)
Received: from mail-m12770.qiye.163.com (mail-m12770.qiye.163.com
 [115.236.127.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB04A80352
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 09:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 77de8d13;
 Thu, 2 Jan 2025 16:55:09 +0800 (GMT+08:00)
Message-ID: <d732b053-6364-4c5e-bd0f-52bb95be80bc@rock-chips.com>
Date: Thu, 2 Jan 2025 16:55:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] arm64: dts: rockchip: reorder mmc aliases for NanoPi
 R3S
To: Tianling Shen <cnsztl@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20241226092043.419511-1-cnsztl@gmail.com>
 <20241226092043.419511-7-cnsztl@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241226092043.419511-7-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx5CTFZJSU1MTxpDGkxKHhhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942639ccc103afkunm77de8d13
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OS46GDo4ODISAyg1Nj86KEMr
 PyJPFBdVSlVKTEhOQ0tDSkpKTEtOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSE1NNwY+
DKIM-Signature: a=rsa-sha256;
 b=aX0T0J5X4q3+65ufQvu8wcObjoBrCx5Xfi9FGUl9p4baZ6w24iuE8rnrg8ssR9+XTE4o02f6Sdff/A/eXfQn3qxtCvb0Bg1iaoBPY5/9WKaJJ6gGkuJfq9gQIihln4picdYj+qdzDIMWY0KFEKFRcwkK7tk5gHQjAmvx/7ndFOA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=DelzvQ6xwisHfAERiWN9+RW+uR47YJ0suPPARmKCuCw=;
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
> Typically any non-removable storage (emmc) is listed before removable
> storage (sd-card) options. Also U-Boot will try to override and use
> mmc0=sdhci and mmc1=sdmmc0 for all rk356x boards.
>
> Fixes: 50decd493c83 ("arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board")
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> Link: https://lore.kernel.org/r/20241022193537.1117919-6-cnsztl@gmail.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: b7cd1115456d312f8c5e60c80fdc35fd35ea6eab ]
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
> index 03a2f90f62..fb1f65c868 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
> @@ -22,8 +22,8 @@
>   
>   	aliases {
>   		ethernet0 = &gmac1;
> -		mmc0 = &sdmmc0;
> -		mmc1 = &sdhci;
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc0;
>   	};
>   
>   	chosen: chosen {
