Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4273ECA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65519836B2;
	Sat, 30 Aug 2025 16:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gnkgg+wz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52F6B83837; Sat, 30 Aug 2025 16:43:18 +0200 (CEST)
Received: from mail-m32110.qiye.163.com (mail-m32110.qiye.163.com
 [220.197.32.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B59AB8341A
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 21239872a;
 Sat, 30 Aug 2025 22:43:12 +0800 (GMT+08:00)
Message-ID: <d6986cdf-3591-44bc-8747-6d0c6e245670@rock-chips.com>
Date: Sat, 30 Aug 2025 22:43:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] arm64: dts: rockchip: add RK3576 RNG node
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <20250711222132.204344-1-jonas@kwiboo.se>
 <20250711222132.204344-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250711222132.204344-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb6eb19a03afkunm074d49d2409578
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ00aVkofSRhNH0xIGEJMSFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=gnkgg+wzTKY/EWeRmMTvZEf7jNBjodGk+Ym6xOqvZamfM/aoTRup1ZSSUqdJToX3PG3CCmLsVuNeRtrr5xuzp8Zcr/OA36Aig4itlwTRBRY5DI8k1f4zGqwb/ioaa55KVlVPJO0/9NH2m6eECGo0Y/ewnr4jBKmM8Ob4S2rjaBE=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=p3qsAG1nR2V8kadQr75E0rpJ9K18EKU57II5yQ0onrA=;
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


On 2025/7/12 06:21, Jonas Karlman wrote:
> From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>
> The RK3576 has a hardware random number generator IP built into the SoC.
>
> Add it to the SoC's .dtsi, now that there's a binding and driver for it.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Link: https://lore.kernel.org/r/20250430-rk3576-hwrng-v1-3-480c15b5843e@collabora.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 5268f3b5d29887480011b44567bcbf0d422cda94 ]
>
> (cherry picked from commit 25cfcb091747900639f2b5df297d26b3a6ca3989)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch
> ---
>   dts/upstream/src/arm64/rockchip/rk3576.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3576.dtsi b/dts/upstream/src/arm64/rockchip/rk3576.dtsi
> index ebb5fc8bb8b1..50332ec6e0de 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3576.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3576.dtsi
> @@ -1419,6 +1419,14 @@
>   			status = "disabled";
>   		};
>   
> +		rng: rng@2a410000 {
> +			compatible = "rockchip,rk3576-rng";
> +			reg = <0x0 0x2a410000 0x0 0x200>;
> +			clocks = <&cru HCLK_TRNG_NS>;
> +			interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&cru SRST_H_TRNG_NS>;
> +		};
> +
>   		otp: otp@2a580000 {
>   			compatible = "rockchip,rk3576-otp";
>   			reg = <0x0 0x2a580000 0x0 0x400>;
