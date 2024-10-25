Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF213D0C606
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60A1D89021;
	Fri, 25 Oct 2024 14:40:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DrQnpkro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BDC889058; Fri, 25 Oct 2024 14:40:27 +0200 (CEST)
Received: from mail-m1973188.qiye.163.com (mail-m1973188.qiye.163.com
 [220.197.31.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4C8A88F64
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ec47490;
 Fri, 25 Oct 2024 20:40:16 +0800 (GMT+08:00)
Message-ID: <d966f05d-0eea-4c6c-a4e4-037f3911872e@rock-chips.com>
Date: Fri, 25 Oct 2024 20:40:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] arm64: dts: rockchip: add SPI flash on NanoPC-T6
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, u-boot@lists.denx.de, 
 Heiko Stuebner <heiko@sntech.de>
References: <20241017200039.1235524-1-jonas@kwiboo.se>
 <20241017200039.1235524-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241017200039.1235524-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh1CT1YeHUJCQk9KQhlOS0tWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c3b119be09d6kunmec47490
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRg6Kww5VjIfKRc0ATgdLzMq
 SzQwCQ9VSlVKTElCQ01LS0pMTkpMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTU1KNwY+
DKIM-Signature: a=rsa-sha256;
 b=DrQnpkrosq7GQfBbBsnHkyYx/P1LTv9rb6sbCYVqMTA9uZFLkJUMrs9vFBUSfDQewW2XtxDyVenKjjXOd2QvWjxjjg2xIzeEWcoLjtUsLQWQL6RmnO0mvdIbiR8M6Ds2P/qGibHOKf6eZhqYNp0hvC9gl4wM1biHZ8HfBPODYvI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=w8+c0wUpr3VOfnH5BPcGEUIwOJtb3N4Hq5SrcUT5DLM=;
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


On 2024/10/18 04:00, Jonas Karlman wrote:
> From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>
> FriendlyELEC NanoPC-T6 has optional SPI flash chip on-board.
> It is populated with 32MB one on LTS version.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20240829-friendlyelec-nanopc-t6-lts-v6-5-edff247e8c02@linaro.org
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: a22a629c63b1addcf2d81eaf30383c1deca5b7a9 ]
>
> (cherry picked from commit 7588da65fdf09c7de9f903780c212a8ae96f2866)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3588-nanopc-t6.dtsi      | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi
> index d199f51a220c..77580c671b36 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi
> @@ -560,6 +560,21 @@
>   	status = "okay";
>   };
>   
> +/* optional on non-LTS, populated on LTS version */
> +&sfc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&fspim1_pins>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <104000000>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <1>;
> +	};
> +};
> +
>   &spi2 {
>   	status = "okay";
>   	assigned-clocks = <&cru CLK_SPI2>;
