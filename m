Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0212C3ABC3
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 02:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD00E820EB;
	Thu,  8 May 2025 04:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="B8GqOF++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6148C820EB; Thu,  8 May 2025 04:24:37 +0200 (CEST)
Received: from mail-m10218.netease.com (mail-m10218.netease.com
 [154.81.10.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9040381FAB
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 04:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.223] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 145041398;
 Thu, 8 May 2025 10:24:28 +0800 (GMT+08:00)
Message-ID: <256a099d-80ff-4d24-8dbc-6fe658c450d9@rock-chips.com>
Date: Thu, 8 May 2025 10:24:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] rockchip: rk3576: Add rng node to u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, u-boot@lists.denx.de
References: <20250422211216.3727559-1-jonas@kwiboo.se>
 <20250422211216.3727559-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250422211216.3727559-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0kZTVYfSxgaTh8dH0JCSUxWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96adb5645803afkunm145041398
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Njo6GRw6PTJMGQgwLQ8VKxoz
 FhUwCzxVSlVKTE9NTUxKS01CSEtMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSk5NNwY+
DKIM-Signature: a=rsa-sha256;
 b=B8GqOF++CfgYwhd8LxvXErgi/3HUNTpOcRbwGi7QE5mFxWYiaFN5ZqiNO1NTCFNMEn/0eEWzW4qIUPgl6mhQMIY0+u5s1z7YmNCATo2VVCQxKHFwAqafzl+7tVZsVhdETorpPxgMExclbfP8kSP7GgRFbUp8tz+mc0m8uek5auQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=UBLf0krR6JVXAqZ0lanpf0KZbPam686h4019UlSCUgw=;
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


On 2025/4/23 05:12, Jonas Karlman wrote:
> The RK3576 SoC contains a RKRNG block that can be used to generate
> random numbers using the rockchip_rng driver.
>
>    => rng list
>    RNG #0 - rng@2a410000
>
>    => rng
>    00000000: 36 dd ab 98 ec fb fe d1 cf 36 b3 e1 9b 3d 00 90  6........6...=..
>    00000010: f5 84 de 75 6b 27 48 9e 13 62 12 6c 50 ca 47 1a  ...uk'H..b.lP.G.
>    00000020: b3 4d fc 43 c5 b5 2d be 07 27 03 26 bb 69 61 2a  .M.C..-..'.&.ia*
>    00000030: 6f 70 01 83 4e ce 91 7a 5a 6c 7c 00 43 87 3e c5  op..N..zZl|.C.>.
>
> Add a rng node to the SoC specific u-boot.dtsi until full support has
> landed in a device tree from dts/upstream.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3576-u-boot.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
> index be99a48a630f..928960862597 100644
> --- a/arch/arm/dts/rk3576-u-boot.dtsi
> +++ b/arch/arm/dts/rk3576-u-boot.dtsi
> @@ -14,6 +14,13 @@
>   		compatible = "rockchip,rk3576-dmc";
>   		bootph-all;
>   	};
> +
> +	soc {
> +		rng: rng@2a410000 {
> +			compatible = "rockchip,rkrng";
> +			reg = <0x0 0x2a410000 0x0 0x200>;
> +		};
> +	};
>   };
>   
>   &cru {
