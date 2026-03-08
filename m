Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AD6EA852E
	for <u-boot@archiver.kernel.org>; Sun,  8 Mar 2026 15:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0857283F8A;
	Sun,  8 Mar 2026 16:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Ahprn5u1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 894E283F75; Sun,  8 Mar 2026 16:42:23 +0100 (CET)
Received: from mail-m1973176.qiye.163.com (mail-m1973176.qiye.163.com
 [220.197.31.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7E8780517
 for <u-boot@lists.denx.de>; Sun,  8 Mar 2026 16:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3] (unknown
 [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3])
 by smtp.qiye.163.com (Hmail) with ESMTP id 362542e6e;
 Sun, 8 Mar 2026 23:42:17 +0800 (GMT+08:00)
Message-ID: <404d6688-e568-447e-aa14-811d766946ac@rock-chips.com>
Date: Sun, 8 Mar 2026 23:42:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] ARM: dts: rockchip: move edp assigned-clocks to
 edp node on rk3288
To: Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, hl@rock-chips.com,
 jagan@amarulasolutions.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jonas@kwiboo.se, michael@amarulasolutions.com
References: <a6eba53c-a2db-44fc-9785-d817dbb4ef11@gmail.com>
 <31a98155-90cd-4896-9dad-002e6a53b4fa@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <31a98155-90cd-4896-9dad-002e6a53b4fa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cce1d10a703afkunm5fac21ba15be971
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTEoaVk8YQh1NQ01CTR5ITlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJT0tCQUNCSE9BHh5BSUJNHUFCGEIeQUJPQ0tBGU5NT0FIQh1IWVdZFh
 oPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Ahprn5u1Eexrc49p+nnmiNBelZMgDXN/86lv1izOhkMZ4LidSAut/ApmNvtbzS/clQbesyyESUUwisXInR0flWTwk7s6NzlKNcnyGUECDFBPZc1AKKFUhmPuHdUUaK+PQSImfhCdBlJ1q8zQzME03aTfkDpqCBG0Hl6SPi93gwc=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=wi2U4mHqoq4JVvhBIECPCkXMsDfZrp8syaS/8KwYaVA=;
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


On 2026/1/17 06:12, Johan Jonker wrote:
> The rk3288 power-controller node contains an assigned-clocks property
> that conflicts with the bindings. From the git history it shows that they
> wanted to assign the rk3288 EDP_24M clock input centrally before an edp
> node was available. Move the edp assigned-clocks property to the edp node
> to reduce dtbs_check output.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Link: https://patch.msgid.link/7d6fa223-ab90-4c44-9180-54df78467ea5@gmail.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 10712ce694a67304a99dbba20f8cb146ca5f4fd6 ]
>
> (cherry picked from commit e1b4137b6bbc9998b13cde2eba0655cfdd358c69)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm/rockchip/rk3288.dtsi | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/dts/upstream/src/arm/rockchip/rk3288.dtsi b/dts/upstream/src/arm/rockchip/rk3288.dtsi
> index 7e284b4fecdc..7477fc5da3ec 100644
> --- a/dts/upstream/src/arm/rockchip/rk3288.dtsi
> +++ b/dts/upstream/src/arm/rockchip/rk3288.dtsi
> @@ -741,9 +741,6 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>
> -			assigned-clocks = <&cru SCLK_EDP_24M>;
> -			assigned-clock-parents = <&xin24m>;
> -
>   			/*
>   			 * Note: Although SCLK_* are the working clocks
>   			 * of device without including on the NOC, needed for
> @@ -1193,6 +1190,8 @@
>   		compatible = "rockchip,rk3288-dp";
>   		reg = <0x0 0xff970000 0x0 0x4000>;
>   		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +		assigned-clocks = <&cru SCLK_EDP_24M>;
> +		assigned-clock-parents = <&xin24m>;
>   		clocks = <&cru SCLK_EDP>, <&cru PCLK_EDP_CTRL>;
>   		clock-names = "dp", "pclk";
>   		phys = <&edp_phy>;
> --
> 2.39.5
>
>
