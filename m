Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03918C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE33F8329F;
	Tue,  8 Apr 2025 05:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Li3zLfwW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C80098329F; Tue,  8 Apr 2025 05:22:09 +0200 (CEST)
Received: from mail-m3270.qiye.163.com (mail-m3270.qiye.163.com
 [220.197.32.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3602832DD
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 110208975;
 Tue, 8 Apr 2025 11:22:02 +0800 (GMT+08:00)
Message-ID: <b954515f-b2f9-4815-906d-2fd85a48f4b1@rock-chips.com>
Date: Tue, 8 Apr 2025 11:22:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/30] arm64: dts: rockchip: Add uart0 pinctrl to Radxa
 E20C
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-10-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hNHVZPQhkfS0wfHUNOTk1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136b500f03afkunm110208975
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NCI6PTo5FjJRKUIxARVJTjcZ
 DTdPFBxVSlVKTE9PS0NJTklIT0xJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS01JNwY+
DKIM-Signature: a=rsa-sha256;
 b=Li3zLfwWGnL34kH0jNDXKKtgKl2ZXpRw4wQfwIi4RyRHyPA2DomAzIHUHgeua6iX+OvFBr+qWRUXSsQJBYq8qM62T5ol/foV3FIvhSBlJcWaK+YxRR7SOWS1uChnJNwuk4KT2O53FXJ+rpPWiz9LApPzqw1C4mA41rjxfoNDKo4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=uLcFQ0zWwFYGirqMHJBVRICTa2pH2XClsKShG0ijay4=;
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


On 2025/4/8 06:46, Jonas Karlman wrote:
> Radxa E20C route UART0 M0 pins (GPIO4_C7 and GPIO4_D0) to the onboard
> CH340B for debug console use.
>
> Add pinctrl for UART0 M0 pins used for serial console.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20250228064024.3200000-6-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 0d2312f0d3e4ce74af0977c1519a07dfc71a82ac ]
>
> (cherry picked from commit 9bcf6ccdd87c3be48fe7d75150c6e403c5c0a42d)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts b/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
> index d2cdb63d4a9d..5161d22330ab 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
> @@ -18,5 +18,7 @@
>   };
>   
>   &uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0m0_xfer>;
>   	status = "okay";
>   };
