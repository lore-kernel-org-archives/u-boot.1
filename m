Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9537C52D70
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 06:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4042C88B62;
	Fri,  2 Aug 2024 08:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OPCeEoVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C10D88B70; Fri,  2 Aug 2024 08:18:34 +0200 (CEST)
Received: from mail-m12737.qiye.163.com (mail-m12737.qiye.163.com
 [115.236.127.37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B88C287C38
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 08:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=OPCeEoViAsIFZcRKnxe9K0EP2SQpYEcdKMVsAOfLVZVVGr4lklKoxv6zAov+d1KDFE+3du/D1fWlbHgp1Gqh0zHW5O6f7ItUk/OAnQpOPywpqAJ93mV29gtq6c832KoQGhW08Gc8Cgy6JartJGsTbf7W9WRt0Gn8b8znq5/V2nU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=nlTl+BFRxzFicBxhRUBvIiTEsJmYI1I/BvSy++ir90w=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 7F7829004A9;
 Fri,  2 Aug 2024 14:18:20 +0800 (CST)
Message-ID: <5aa856fa-db8d-4c6e-8c50-5b7fb64170af@rock-chips.com>
Date: Fri, 2 Aug 2024 14:18:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] arm64: dts: rockchip: Add sdmmc related properties on
 rk3308-rock-pi-s
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>
References: <20240730145148.849245-1-jonas@kwiboo.se>
 <20240730145148.849245-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240730145148.849245-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk9LGFYdTU1NHUoeTR1IGU5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9111bd41bd03a9kunm7f7829004a9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCI6EQw*DjI0HyIIAgwYFVEU
 MClPCw5VSlVKTElJTkxCTktKQkpDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ01MNwY+
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


On 2024/7/30 22:51, Jonas Karlman wrote:
> Add cap-mmc-highspeed to allow use of high speed MMC mode using an eMMC
> to uSD board. Use disable-wp to signal that no physical write-protect
> line is present. Also add vcc_io used for card and IO line power as
> vmmc-supply.
>
> Fixes: 2e04c25b1320 ("arm64: dts: rockchip: add ROCK Pi S DTS support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20240521211029.1236094-5-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: fc0daeccc384233eadfa9d5ddbd00159653c6bdc ]
>
> (cherry picked from commit 39110e4bec51c9ce6bbd342234b288dbfccb9f80)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts b/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
> index 079101cddd65..8ea984906403 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3308-rock-pi-s.dts
> @@ -272,7 +272,10 @@
>   };
>   
>   &sdmmc {
> +	cap-mmc-highspeed;
>   	cap-sd-highspeed;
> +	disable-wp;
> +	vmmc-supply = <&vcc_io>;
>   	status = "okay";
>   };
>   
