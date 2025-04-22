Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19082C369D3
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 15:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0037C8144A;
	Tue, 22 Apr 2025 17:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="UzxppIXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0250F82063; Tue, 22 Apr 2025 17:28:23 +0200 (CEST)
Received: from mail-m49217.qiye.163.com (mail-m49217.qiye.163.com
 [45.254.49.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B4A380FF7
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 17:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.69.12] (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12bfc6173;
 Tue, 22 Apr 2025 23:28:15 +0800 (GMT+08:00)
Message-ID: <17404dd1-184c-42d3-b54f-8c5fcb2c09a8@rock-chips.com>
Date: Tue, 22 Apr 2025 23:28:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: rockchip: Add rng node to RK3588
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <20250408221151.2762853-1-jonas@kwiboo.se>
 <20250408221151.2762853-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250408221151.2762853-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ08eVk1CQ09NHUxNQxhCTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NJVUpLS1
 VLWQY+
X-HM-Tid: 0a965e1d39d403afkunm12bfc6173
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxg6PQw5VjJJOEkvUQFWPzAz
 GSowC0tVSlVKTE9OSEhOTUJMSElDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUlPQ0s3Bg++
DKIM-Signature: a=rsa-sha256;
 b=UzxppIXk/kPdUZS27UCYd6bfD8BQ2iNw7IUWzVnZCFRtEYW8XEehhu6i6eV7AHeZH3a+4kJbyVdv3Mggtb29Pgnz/8XLQQSrEAeVrWcbX3gHBhVlNe1n2nEuYepWgEVc0flLvfyJQKMHjiAUfONswnps0PGp/uk8Ea0B+69ue2E=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=6SL/Vywe9ntwQUW+tlcO8ChXyLHq5TAgWXaNA5HV3Ow=;
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


On 2025/4/9 06:11, Jonas Karlman wrote:
> From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>
> Add the RK3588's standalone hardware random number generator node to its
> device tree, and enable it.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Link: https://lore.kernel.org/r/20250204-rk3588-trng-submission-v2-6-608172b6fd91@collabora.com
> [changed reset-id to its numeric value while the constant makes its
>   way through the crypto tree]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
>
> [ upstream commit: 6ee0b9ad3995ee5fa229035c69013b7dd0d3634b ]
>
> (cherry picked from commit 4800c4aaad00ffdc053850f130e8504a04dd110d)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   dts/upstream/src/arm64/rockchip/rk3588-base.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
> index c3abdfb04f8f..2623afa79634 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-base.dtsi
> @@ -1921,6 +1921,14 @@
>   		status = "disabled";
>   	};
>   
> +	rng@fe378000 {
> +		compatible = "rockchip,rk3588-rng";
> +		reg = <0x0 0xfe378000 0x0 0x200>;
> +		interrupts = <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&scmi_clk SCMI_HCLK_SECURE_NS>;
> +		resets = <&scmi_reset 48>;
> +	};
> +
>   	i2s0_8ch: i2s@fe470000 {
>   		compatible = "rockchip,rk3588-i2s-tdm";
>   		reg = <0x0 0xfe470000 0x0 0x1000>;
