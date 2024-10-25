Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C874CD0C601
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 11:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D78E88FE2;
	Fri, 25 Oct 2024 13:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="bybXkOnf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA26188FD5; Fri, 25 Oct 2024 13:59:13 +0200 (CEST)
Received: from mail-m12762.qiye.163.com (mail-m12762.qiye.163.com
 [115.236.127.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6C3F88FE2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ebe582b;
 Fri, 25 Oct 2024 19:58:48 +0800 (GMT+08:00)
Message-ID: <41a92353-1b01-43cc-9a47-8ec2813d1534@rock-chips.com>
Date: Fri, 25 Oct 2024 19:58:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/18] arm64: dts: rockchip: enable sata1+2 on
 Qnap-TS433
To: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: ukleinek@debian.org
References: <20241013192424.84280-1-heiko@sntech.de>
 <20241013192424.84280-7-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241013192424.84280-7-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRpIHlZNGksZH01KGR9MQkhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c38b242909d6kunmebe582b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzI6Ehw4PTIeFxcsOQ4iLzFR
 UQIKCj5VSlVKTElCQ05MTklCTUNMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTU9INwY+
DKIM-Signature: a=rsa-sha256;
 b=bybXkOnfUTyO21doSaXPCs8P9SIrAyswrnMLBo/kqM6P+xz+hTsCaVnfy8k/HHJZ89vByfLTTii7rpkT55ijJ40foTUBT2WRfyCs6x2Gp5ftg9mdWbFM9aKWxy/IVlzoV5Fwy11ux3yB76rW7DkxZ4Ky1uA1wffQDLncQqLxtk8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=iDJAPuyV38NYmo/ASj4R0XeeMp7JNL7SDJsxHQllEdE=;
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


On 2024/10/14 03:24, Heiko Stuebner wrote:
> The TS433 has 4 bays. The last two are accessed via a pci-connected
> sata controller, while the first two are accessed via the rk3568's
> sata controllers. Enable these two now.
>
> Tested-by: Uwe Kleine-König <ukleinek@debian.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Link: https://lore.kernel.org/r/20240723195538.1133436-7-heiko@sntech.de
>
> [ upstream commit: 673c1353b3d476b9c5df6b84a777ed171e5594f5 ]
>
> (cherry picked from commit dfa45bbda057851d0c2167b4c311c0301637cc19)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3568-qnap-ts433.dts   | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> index be1c2286c2d..40af4dd0e41 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> @@ -80,6 +80,16 @@
>   	status = "okay";
>   };
>   
> +/* connected to sata1 */
> +&combphy1 {
> +	status = "okay";
> +};
> +
> +/* connected to sata2 */
> +&combphy2 {
> +	status = "okay";
> +};
> +
>   &gmac0 {
>   	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
>   	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>, <&cru CLK_MAC0_2TOP>;
> @@ -156,6 +166,14 @@
>   	};
>   };
>   
> +&sata1 {
> +	status = "okay";
> +};
> +
> +&sata2 {
> +	status = "okay";
> +};
> +
>   &sdhci {
>   	bus-width = <8>;
>   	max-frequency = <200000000>;
