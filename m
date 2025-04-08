Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D498AC36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB3E083371;
	Tue,  8 Apr 2025 05:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KfAjvFdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ED438334C; Tue,  8 Apr 2025 05:22:37 +0200 (CEST)
Received: from mail-m81251.xmail.ntesmail.com (mail-m81251.xmail.ntesmail.com
 [156.224.81.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0FF382CE7
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 110208a14;
 Tue, 8 Apr 2025 11:22:29 +0800 (GMT+08:00)
Message-ID: <c1779998-5eb0-4e7b-9fec-c425650847d8@rock-chips.com>
Date: Tue, 8 Apr 2025 11:22:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/30] arm64: dts: rockchip: Enable onboard eMMC on
 Radxa E20C
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-14-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-14-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU4dSFYfGR5CSEhPSh9CTU1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136bb9d603afkunm110208a14
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODo6Dww4HTICE0IPARYWTg1M
 NxwaCVZVSlVKTE9PS0NJTk5LSkJDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT01INwY+
DKIM-Signature: a=rsa-sha256;
 b=KfAjvFdurJJHDD9oclpJcvlO8796NWUQhawLzlBKJz6o1e7dORDgeEnGgy77+1I6Wr8Q+g1YIFw1JlnMqPogSfPV1mbSOqMCzTOsG0lqSptfipIE4ZwZz68qXW1cKiMS/d3jD/4CrGgJWtwniC39quzxtDFS2aeS143gtxgwyAw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=z74HIRWpfobPozgAkQK78L0D6/lGzv5PW27s0JpMwg4=;
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
> The Radxa E20C may come with an onboard eMMC (8GB / 16GB / 32GB / 64GB).
>
> Enable support for the onboard eMMC on Radxa E20C.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20250305214108.1327208-4-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 3a01b5f14a8ae2d45aea5aeed30001ac1655de86 ]
>
> (cherry picked from commit bd4c8a1c08f92d863d89c0ddff59e5f5bc6a1e34)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3528-radxa-e20c.dts      | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts b/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
> index 5346ef457c2a..57a446b5cbd6 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
> @@ -15,6 +15,10 @@
>   	model = "Radxa E20C";
>   	compatible = "radxa,e20c", "rockchip,rk3528";
>   
> +	aliases {
> +		mmc0 = &sdhci;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial0:1500000n8";
>   	};
> @@ -133,6 +137,17 @@
>   	status = "okay";
>   };
>   
> +&sdhci {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	no-sd;
> +	no-sdio;
> +	non-removable;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
>   &uart0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&uart0m0_xfer>;
