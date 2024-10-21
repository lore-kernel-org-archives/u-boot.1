Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A827D3C934
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 01:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB08A892B8;
	Mon, 21 Oct 2024 03:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="EW09wCQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AE0E892A9; Mon, 21 Oct 2024 03:32:44 +0200 (CEST)
Received: from mail-m3275.qiye.163.com (mail-m3275.qiye.163.com
 [220.197.32.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C48AF892B8
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 03:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=EW09wCQV8Cp+7m+uOJPPgwKPW6n0yMQSU/V5AsungMz8fWf/z8wbVcyXkmhaSeCs6V9I6n320Q95b0crV1fmERd40/LOOlNOik+8Hh0sXjPLBTJ6cKY02nAtqnYK2NVDlVCryTzADE9A43R0+lf/HngTst88zoFectCU78DuAMA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=xW7oyjtW8Mq1iO3twhnWKswf/8hEWrq9VlccNbyKRqs=;
 h=date:mime-version:subject:message-id:from;
Received: from yk?rock-chips.com
 (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with SMTP id 3E83E52020F;
 Mon, 21 Oct 2024 09:32:14 +0800 (CST)
Message-ID: <1bfc1d61-9f0c-4458-9063-fe27eb5c7808@rock-chips.com>
Date: Mon, 21 Oct 2024 09:32:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v2 01/18] arm64: dts: rockchip: add PCIe supply regulator
 to Qnap-TS433
To: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: ukleinek@debian.org
References: <20241013192424.84280-1-heiko@sntech.de>
 <20241013192424.84280-2-heiko@sntech.de>
Content-Language: en-US
In-Reply-To: <20241013192424.84280-2-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hOSVYdTkseTklJSxgZQk5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92acb4120903afkunm3e83e52020f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBw6UTo4CDIsAyhKKDgpGi4w
 MBIaFDZVSlVKTElCT0xPSEhNSE9PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISUhPNwY+
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
> Add the vcc3v3-supply regulator and its link to the pcie controllers.
>
> Tested-by: Uwe Kleine-König <ukleinek@debian.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Link: https://lore.kernel.org/r/20240723195538.1133436-2-heiko@sntech.de
>
> [ upstream commit: e0ec6d48226fb3d4df18895b56f0b7a94c0fe474 ]
>
> (cherry picked from commit 59939b4343db08fa08098238160007e6ded72be9)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3568-qnap-ts433.dts  | 21 +++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> index 6a998166003..07b4f095d76 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> @@ -12,6 +12,25 @@
>   / {
>   	model = "Qnap TS-433-4G NAS System 4-Bay";
>   	compatible = "qnap,ts433", "rockchip,rk3568";
> +
> +	dc_12v: regulator-dc-12v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "dc_12v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	vcc3v3_pcie: regulator-vcc3v3-pcie {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_pcie";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&dc_12v>;
> +	};
>   };
>   
>   &gmac0 {
> @@ -62,9 +81,11 @@
>   	status = "okay";
>   };
>   
> +/* Connected to a JMicron AHCI SATA controller */
>   &pcie3x1 {
>   	/* The downstream dts has: rockchip,bifurcation, XXX: find out what this is about */
>   	reset-gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_pcie>;
>   	status = "okay";
>   };
>   
