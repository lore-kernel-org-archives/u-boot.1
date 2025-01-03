Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A64E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 09:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B554D8035E;
	Fri,  3 Jan 2025 10:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SGVKTnSi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16E90801A0; Fri,  3 Jan 2025 10:25:53 +0100 (CET)
Received: from mail-m12787.qiye.163.com (mail-m12787.qiye.163.com
 [115.236.127.87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1FB4803E4
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 10:25:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79d1fb1e;
 Fri, 3 Jan 2025 17:25:44 +0800 (GMT+08:00)
Message-ID: <621a15f9-b4a9-476e-aa18-ef1fb145c3be@rock-chips.com>
Date: Fri, 3 Jan 2025 17:25:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 11/12] rockchip: rk3399-gru: Include pinctrl and
 regulators in SPL
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-12-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20241212235735.164272-12-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHxlMVkxCQ0NLSU8dGU9LGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a942b7c265e03afkunm79d1fb1e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N0k6Njo6AjIUHyxNKzVLDxEN
 Cj5PCklVSlVKTEhOQ0JNSE9OQklDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhKTkk3Bg++
DKIM-Signature: a=rsa-sha256;
 b=SGVKTnSi3zbVn62DDXuZ6cNJrRancwPy4JIi/w8i8ddvW1Sp8IrZ2wvuzH2bmsHMD/0i+ENHOfhHH8gDrGrWH4OL8TnIrdRlf57ytCXMn2oBqCLYhSNp02x+jtwB5GxsrpfVFwOdI2+ip1+e3aW0tZz7oKvf7yZ65rWXLw0MsZo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=6okOI02ARjBBOa7McmUPO8swTxW1rkIFnDIGHTkmhEA=;
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


On 2024/12/13 07:57, Jonas Karlman wrote:
> Add bootph props and enable related Kconfig options to include vital
> regulators in SPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-gru-u-boot.dtsi | 19 +++++++++++++++++++
>   configs/chromebook_bob_defconfig    |  3 ++-
>   configs/chromebook_kevin_defconfig  |  3 ++-
>   3 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-gru-u-boot.dtsi b/arch/arm/dts/rk3399-gru-u-boot.dtsi
> index 5f44327736df..5517176aa4a0 100644
> --- a/arch/arm/dts/rk3399-gru-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-gru-u-boot.dtsi
> @@ -33,12 +33,31 @@
>   	/delete-property/ bootph-pre-ram;
>   };
>   
> +&gpio0 {
> +	bootph-pre-ram;
> +};
> +
> +&pp1500_ap_io {
> +	bootph-pre-ram;
> +};
>   
>   &pp1800_audio {
>   	regulator-min-microvolt = <1800000>;
>   	regulator-max-microvolt = <1800000>;
>   };
>   
> +&pp1500_en {
> +	bootph-pre-ram;
> +};
> +
> +&pp3000 {
> +	bootph-pre-ram;
> +};
> +
> +&pp3000_en {
> +	bootph-pre-ram;
> +};
> +
>   &ppvar_bigcpu_pwm {
>   	regulator-init-microvolt = <900000>;
>   };
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index af9df4700e35..8cdfb64462f1 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -47,7 +47,7 @@ CONFIG_CMD_PMIC=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_LOG=y
>   CONFIG_SPL_OF_CONTROL=y
> -CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
> @@ -73,6 +73,7 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_TYPEC=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_DM_REGULATOR_GPIO=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_CROS_EC=y
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index cc51722b521b..3992b3da092f 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -48,7 +48,7 @@ CONFIG_CMD_PMIC=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_LOG=y
>   CONFIG_SPL_OF_CONTROL=y
> -CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
> @@ -74,6 +74,7 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_TYPEC=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_DM_REGULATOR_GPIO=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_CROS_EC=y
