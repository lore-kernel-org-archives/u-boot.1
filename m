Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E20D0C603
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74F5289083;
	Fri, 25 Oct 2024 14:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MSsBDNmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F0E889072; Fri, 25 Oct 2024 14:00:36 +0200 (CEST)
Received: from mail-m11886.qiye.163.com (mail-m11886.qiye.163.com
 [115.236.118.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BBEE8901C
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ebe589d;
 Fri, 25 Oct 2024 20:00:18 +0800 (GMT+08:00)
Message-ID: <06fdb8af-de56-44b9-96d2-fbf7af599cce@rock-chips.com>
Date: Fri, 25 Oct 2024 20:00:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/18] arm64: dts: rockchip: Simplify network PHY
 connection on qnap-ts433
To: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: ukleinek@debian.org, Andrew Lunn <andrew@lunn.ch>
References: <20241013192424.84280-1-heiko@sntech.de>
 <20241013192424.84280-16-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241013192424.84280-16-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU9LSlZMT0sZSEwdHRpJGRhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c38c840409d6kunmebe589d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pkk6Aww5FjIoCxchA1Y1Ngkz
 CkhPCUxVSlVKTElCQ05MTUpCQkpJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTUlPNwY+
DKIM-Signature: a=rsa-sha256;
 b=MSsBDNmtupFc92XHlpPvMx3oUybMOuECihyU4O1DmeMSGDRuAn9/eTzQQBpxm7pZ5HXINejGrvbLiGLjOxpR+WCKMkivC4bEhFz8LF5AEPB7jUbPQ6QkVTx0K7ye9LreZNbuOYYAGP5Uk+wf7CLPwHnYXHx4CFHaf9hCu2YXGTQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Sp4FFkGjbF5BQVNcmP+brgInMJqhFTTRzxNKatbH4Zo=;
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
> From: Uwe Kleine-König <ukleinek@debian.org>
>
> While it requires to have the right phy driver loaded (i.e. motorcomm)
> to make the phy asserting the right delays, this is generally the
> preferred way to define the MAC <-> PHY connection.
>
> Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Link: https://lore.kernel.org/r/20240304084612.711678-2-ukleinek@debian.org
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: e8d45544f806f3b55c30345de84262cbb9504902 ]
>
> (cherry picked from commit e0bbe061fd537bd7b113c53eb046bbcbf0e6597d)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> index 6c4269b3d95..20e4fa6c185 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> @@ -198,15 +198,13 @@
>   	assigned-clock-rates = <0>, <125000000>;
>   	clock_in_out = "output";
>   	phy-handle = <&rgmii_phy0>;
> -	phy-mode = "rgmii";
> +	phy-mode = "rgmii-id";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&gmac0_miim
>   		     &gmac0_tx_bus2
>   		     &gmac0_rx_bus2
>   		     &gmac0_rgmii_clk
>   		     &gmac0_rgmii_bus>;
> -	rx_delay = <0x2f>;
> -	tx_delay = <0x3c>;
>   	status = "okay";
>   };
>   
