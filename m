Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8F7E77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 08:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FCEB8031D;
	Thu,  2 Jan 2025 09:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GV9YzXX2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79ED880352; Thu,  2 Jan 2025 09:55:08 +0100 (CET)
Received: from mail-m11877.qiye.163.com (mail-m11877.qiye.163.com
 [115.236.118.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5831480196
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 09:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 77de8ccc;
 Thu, 2 Jan 2025 16:55:00 +0800 (GMT+08:00)
Message-ID: <e5044da0-d0e1-4ff4-bd49-297ea7436944@rock-chips.com>
Date: Thu, 2 Jan 2025 16:54:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] arm64: dts: rockchip: enable eMMC HS200 mode for
 NanoPi R3S
To: Tianling Shen <cnsztl@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20241226092043.419511-1-cnsztl@gmail.com>
 <20241226092043.419511-6-cnsztl@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241226092043.419511-6-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk9PQlZDTUhDHh0fTBlPTktWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942639a6e003afkunm77de8ccc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBA6FBw6CzISEygwGDosKBFK
 TjgaCQxVSlVKTEhOQ0tDSktKTk1IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSU1NNwY+
DKIM-Signature: a=rsa-sha256;
 b=GV9YzXX2WPlp1dRWfxDSfdtW3xmSszOY30Q321B10z+g37BzIs0a9Fvpw88UEmLRjdV2y/61rtJ3tA8qOdU3Lc5zN240LDhTmBCGJCjchvNl2p3ETXb3p9PC1QGOrfKkit+/MsfmGsoge305LPXQ89Q6jHE6GVJYmq2S1tKfC+k=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=0Fn2mAfFG2WjyLXaRZTHmz7EIDHa0GK+e5ekHbZfL8I=;
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
> It is required to boot from eMMC without additional patch in u-boot.
>
> Fixes: 50decd493c83 ("arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board")
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> Link: https://lore.kernel.org/r/20241022193537.1117919-5-cnsztl@gmail.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 1b5365034410f1ca21adadadd492b99bdf4f2c55 ]
>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
> index 243574f8da..03a2f90f62 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
> @@ -491,6 +491,7 @@
>   &sdhci {
>   	bus-width = <8>;
>   	max-frequency = <200000000>;
> +	mmc-hs200-1_8v;
>   	non-removable;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
