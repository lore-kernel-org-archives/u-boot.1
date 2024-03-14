Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B314EC5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 03:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2115D87F40;
	Thu, 14 Mar 2024 04:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="WZGn25nQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59B3D87D42; Thu, 14 Mar 2024 04:33:57 +0100 (CET)
Received: from mail-m6023.netease.com (mail-m6023.netease.com [210.79.60.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3D4C870D2
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 04:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=WZGn25nQlrT6uW+4Y4hx/5TtN5cmgk5ZmWhCfDcDuiL/XsDvGq+anyT+UaOIL1G7rNEzaPGV6iZfYbyFKx6nErTCs59iXk8C/rIWFIoQTpMYIwfh/fdck03ePGSYm8rnCku4t7/vAIK5gjLDvnQld1tVijscFzrM6ClqV6oOkCo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=delGGURG13reJuhU1N2u488ichPcFjvplkkgp8ycY5Y=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 5E0A090018B;
 Thu, 14 Mar 2024 11:33:48 +0800 (CST)
Message-ID: <0330c309-2884-4c66-a46d-9a6f2f8da1ae@rock-chips.com>
Date: Thu, 14 Mar 2024 11:33:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] rng: rockchip: Use same compatible as linux
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de
References: <20240217002304.2141064-1-jonas@kwiboo.se>
 <20240217002304.2141064-11-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217002304.2141064-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhCS1ZKHxlMGEhPTEwYSkpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e3b05f13103a9kunm5e0a090018b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngw6CRw5KDMXOCguKx4cTRNI
 Gi4aCyhVSlVKTEpLSENMSUlCSE5PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQ0JLNwY+
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


On 2024/2/17 08:22, Jonas Karlman wrote:
> Replace the rockchip,cryptov1-rng compatible with compatibles used in
> the linux device tree for RK3288, RK3328 and RK3399 to ease sync of SoC
> device tree from linux.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - No change
> - Collect r-b tag
> ---
>   arch/arm/dts/rk3328-u-boot.dtsi |  2 +-
>   arch/arm/dts/rk3399-u-boot.dtsi |  2 +-
>   drivers/rng/rockchip_rng.c      | 10 +++++++++-
>   3 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
> index 687c16da5135..ea34bf6b78bb 100644
> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> @@ -28,7 +28,7 @@
>   	};
>   
>   	rng: rng@ff060000 {
> -		compatible = "rockchip,cryptov1-rng";
> +		compatible = "rockchip,rk3328-crypto";
>   		reg = <0x0 0xff060000 0x0 0x4000>;
>   		status = "okay";
>   	};
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index 3423b882c437..87b173e59579 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -30,7 +30,7 @@
>   	};
>   
>   	rng: rng@ff8b8000 {
> -		compatible = "rockchip,cryptov1-rng";
> +		compatible = "rockchip,rk3399-crypto";
>   		reg = <0x0 0xff8b8000 0x0 0x1000>;
>   		status = "okay";
>   	};
> diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
> index 705b424cf3dd..e82b5572fec5 100644
> --- a/drivers/rng/rockchip_rng.c
> +++ b/drivers/rng/rockchip_rng.c
> @@ -302,7 +302,15 @@ static const struct dm_rng_ops rockchip_rng_ops = {
>   
>   static const struct udevice_id rockchip_rng_match[] = {
>   	{
> -		.compatible = "rockchip,cryptov1-rng",
> +		.compatible = "rockchip,rk3288-crypto",
> +		.data = (ulong)&rk_cryptov1_soc_data,
> +	},
> +	{
> +		.compatible = "rockchip,rk3328-crypto",
> +		.data = (ulong)&rk_cryptov1_soc_data,
> +	},
> +	{
> +		.compatible = "rockchip,rk3399-crypto",
>   		.data = (ulong)&rk_cryptov1_soc_data,
>   	},
>   	{
