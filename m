Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E82C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 08:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1074C88B89;
	Fri,  9 Aug 2024 10:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dPTCKShm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A3188B9B; Fri,  9 Aug 2024 10:34:13 +0200 (CEST)
Received: from mail-m25496.xmail.ntesmail.com (mail-m25496.xmail.ntesmail.com
 [103.129.254.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BDF088B81
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 10:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=dPTCKShmDmxzmzGL2kKADtOvhCWDtNn5BGA/yn0xxIkGiU72VhbuuwTFSL07nL5348fvS8s18R8ljX9v0xmhW4FxcYUtO4C6YYANOE/amKA2vsIazhK9GNeVJq8kciM/XupJ3BLF9KJkoCnitpDBWK/KXSkf+XUHFrx1okoxGnM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=otiOlIXMK0WfSPmwZy5R7l1o/+yLmWpXaSvREGPVIDw=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id C936F900189;
 Fri,  9 Aug 2024 16:33:58 +0800 (CST)
Message-ID: <e6ee057c-0f09-43df-aab3-9922643a251b@rock-chips.com>
Date: Fri, 9 Aug 2024 16:33:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add OTP device node for
 RK3308
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>
References: <20240730142751.842772-1-jonas@kwiboo.se>
 <20240730142751.842772-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240730142751.842772-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSB1DVkxCGklNGUkYHUNLTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a913645f2ba03a9kunmc936f900189
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTY6MSo5MjIrCw9OKyoOSjkX
 NktPCzhVSlVKTElISkJJT09LS0pIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhKT003Bg++
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


On 2024/7/30 22:27, Jonas Karlman wrote:
> The RK3308 SoC contains a controller for one-time-programmable memory,
> add a device node for it.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20240521211029.1236094-9-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 36d3bbc8cdbef2f83391f7708888265ac4c37a99 ]
>
> (cherry picked from commit db11d284200d0f811a8f8238dbc9c63daf4e6131)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch
> ---
>   dts/upstream/src/arm64/rockchip/rk3308.dtsi | 24 +++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3308.dtsi b/dts/upstream/src/arm64/rockchip/rk3308.dtsi
> index c00da150a22f..6531ede13af9 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3308.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3308.dtsi
> @@ -556,6 +556,30 @@
>   		status = "disabled";
>   	};
>   
> +	otp: efuse@ff210000 {
> +		compatible = "rockchip,rk3308-otp";
> +		reg = <0x0 0xff210000 0x0 0x4000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
> +			 <&cru PCLK_OTP_PHY>;
> +		clock-names = "otp", "apb_pclk", "phy";
> +		resets = <&cru SRST_OTP_PHY>;
> +		reset-names = "phy";
> +
> +		cpu_id: id@7 {
> +			reg = <0x07 0x10>;
> +		};
> +
> +		cpu_leakage: cpu-leakage@17 {
> +			reg = <0x17 0x1>;
> +		};
> +
> +		logic_leakage: logic-leakage@18 {
> +			reg = <0x18 0x1>;
> +		};
> +	};
> +
>   	dmac0: dma-controller@ff2c0000 {
>   		compatible = "arm,pl330", "arm,primecell";
>   		reg = <0x0 0xff2c0000 0x0 0x4000>;
