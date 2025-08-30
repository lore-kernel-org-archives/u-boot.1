Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED73CA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81F5B83881;
	Sat, 30 Aug 2025 17:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IYHbYnXu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41423838B7; Sat, 30 Aug 2025 17:24:17 +0200 (CEST)
Received: from mail-m49221.qiye.163.com (mail-m49221.qiye.163.com
 [45.254.49.221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD47D83881
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123f987a;
 Sat, 30 Aug 2025 23:24:11 +0800 (GMT+08:00)
Message-ID: <5ec2277b-3e27-49e5-b1ae-936c4416a83c@rock-chips.com>
Date: Sat, 30 Aug 2025 23:24:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] arm: dts: rockchip: Set init-microvolt for
 pwm-regulators on Radxa E20C
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250730235301.1774089-1-jonas@kwiboo.se>
 <20250730235301.1774089-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250730235301.1774089-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb94390903afkunm2d15760641532d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGE5CVkxPHUgdHksfS0IaH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=IYHbYnXu0nMjY98vSlh71QZtuARubFxsmuv1Zfnye803xW6sSScZePYui3/QoytVB8WIIpVkA7/2DLRQSmNmwSArcy4e9AIXbD+pvdfpckxvAp//wd0lYEoP1mflJmPlIqV7E2dWuULXCcNxBPtzn1DVdOot8rPFodayJdz5WyA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=bYyFdsz32z1Uclb4DrIHiP8ZGCJ8PH+MQ0pPho3IiS4=;
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


On 2025/7/31 07:52, Jonas Karlman wrote:
> Radxa E20C has two main pwm-regulators, vdd_arm and vdd_logic.
>
> Add init-microvolt props to ensure the regulators are initialized at
> the recommended power-on sequence voltage instead of at max voltage.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
> index 05a58c136bcd..16c47e6b9a9e 100644
> --- a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
> +++ b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
> @@ -5,3 +5,11 @@
>   &sdhci {
>   	mmc-hs200-1_8v;
>   };
> +
> +&vdd_arm {
> +	regulator-init-microvolt = <953000>;
> +};
> +
> +&vdd_logic {
> +	regulator-init-microvolt = <900000>;
> +};
