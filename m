Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC07E7C4F4
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 07:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4E186EC9;
	Thu,  5 Oct 2023 09:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696492492;
	bh=yrz/NsTb6S7Ejs1II5/LgtklT4iSWjvnF1UU8xDzSMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bhR/QJrog+JxUxJY9AGXbLyrd+m4xrU5hU8FOlbzpxEsZKUSscrSU0kHAN8egNWDF
	 AWCka6TSPSmmbTSf5ndaIOruoSa54jCTYiKpJDioAjiVRXBpmnhacYi96oPi+u8MMi
	 gUG/l1yTry3Hk4m2usf4SZkkqpPrLJjxd0JHXgeoUZGyXrXnZKj70mIrNfe7JNejAQ
	 tz1agAh9aZ0FbaOK6fmkiBIdWBiB+uOPgQDkXa5SgIv5oNMcsIXo+mqWg+72m2DNJR
	 516UqDBnSTykY+x8Qh3cBcXoL47rL/qbApE2BfmCW7btJgX6UwvVrY/2/bQdzl0eDR
	 dBk2yx+ocHoIw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB64E86ECA; Thu,  5 Oct 2023 09:54:49 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCD0786B87
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 09:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4S1P3R0ql8z9sS6;
 Thu,  5 Oct 2023 09:54:43 +0200 (CEST)
Message-ID: <99db8b85-b47d-450c-b525-743f379fecf6@denx.de>
Date: Thu, 5 Oct 2023 09:54:42 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] Revert "arm: mvebu: x240: Use i2c-gpio instead of
 built in controller"
Content-Language: en-US
To: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
References: <20231003035800.2626121-1-judge.packham@gmail.com>
 <20231003035800.2626121-2-judge.packham@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231003035800.2626121-2-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/3/23 05:57, Chris Packham wrote:
> This reverts commit 5c1c6b7306f2b4c0fd50c7cb5d757e245b93606e. The reason
> for switching to i2c-gpio was due to an issue we were seeing in the
> Linux kernel where the CPU would lock up on certain adverse I2C bus
> conditions. We were never able to reproduce the lockup in U-Boot but
> assumed that was probably just luck.
> 
> Since then we have discovered that the lock up was due to the I2C
> transaction offload engine in the I2C controller not coping with the
> adverse bus conditions (basically it thinks there's another master and
> waits for a STOP condition that never comes). U-Boot doesn't use the I2C
> offload feature so is not susceptible to the lockup.
> 
> We can therefore safely return to using the built-in I2C controller.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   arch/arm/dts/ac5-98dx35xx-atl-x240.dts | 30 ++++++--------------------
>   configs/x240_defconfig                 |  1 -
>   2 files changed, 7 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/dts/ac5-98dx35xx-atl-x240.dts b/arch/arm/dts/ac5-98dx35xx-atl-x240.dts
> index c19b25925ba2..820ec18b4355 100644
> --- a/arch/arm/dts/ac5-98dx35xx-atl-x240.dts
> +++ b/arch/arm/dts/ac5-98dx35xx-atl-x240.dts
> @@ -16,7 +16,7 @@
>   		gpio0 = &gpio0;
>   		gpio1 = &gpio1;
>   		spi0 = &spi0;
> -		i2c0 = &i2cgpio;
> +		i2c0 = &i2c0;
>   		usb0 = &usb0;
>   		pinctrl0 = &pinctrl0;
>   	};
> @@ -40,19 +40,6 @@
>   			default-state = "on";
>   		};
>   	};
> -
> -	i2cgpio: i2c-gpio-0 {
> -			compatible = "i2c-gpio";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			pinctrl-names = "default";
> -			pinctrl-0 =  <&i2c0_gpio>;
> -			scl-gpios = <&gpio0 26 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -			sda-gpios = <&gpio0 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> -			i2c-gpio,delay-us = <2>;
> -			status = "okay";
> -		 };
>   };
>   
>   &nand {
> @@ -83,7 +70,9 @@
>   	status = "okay";
>   };
>   
> -&i2cgpio {
> +&i2c0 {
> +	status = "okay";
> +
>   	mux@71 {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> @@ -188,8 +177,8 @@
>   	 * LED_OE_N              [23]
>   	 * USB_PWR_FLT_N         [24]
>   	 * SFP_INT_N             [25]
> -	 * I2C0_SCL              [26] (GPIO)
> -	 * I2C0_SDA              [27] (GPIO)
> +	 * I2C0_SCL              [26]
> +	 * I2C0_SDA              [27]
>   	 * USB_EN                [28]
>   	 * MONITOR_INT_N         [29]
>   	 * XM1_MDC               [30]
> @@ -212,7 +201,7 @@
>   	/*	     0    1    2    3    4    5    6    7    8    9 */
>   	pin-func = < 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
>   		     0xff 0xff 1    1    1    1    0xff 0xff 0    0
> -		     0    0    0    0    0    0    0xff 0xff 0    0
> +		     0    0    0    0    0    0    1    1    0    0
>   		     1    1    1    1    0    0    0    0    0    0
>   		     0    0    0    1    1    1    >;
>   
> @@ -220,9 +209,4 @@
>   		marvell,pins = <0 1 2 3 4 5 6 7 8 9 10 11 16 17>;
>   		marvell,function = <2>;
>   	};
> -
> -	i2c0_gpio: i2c0-gpio-pins {
> -		marvell,pins = <26 27>;
> -		marvell,function = <0>;
> -	};
>   };
> diff --git a/configs/x240_defconfig b/configs/x240_defconfig
> index 0d5a19df25aa..4b1a761a9086 100644
> --- a/configs/x240_defconfig
> +++ b/configs/x240_defconfig
> @@ -42,7 +42,6 @@ CONFIG_CLK_MVEBU=y
>   CONFIG_GPIO_HOG=y
>   CONFIG_DM_PCA953X=y
>   CONFIG_DM_I2C=y
> -CONFIG_DM_I2C_GPIO=y
>   CONFIG_SYS_I2C_MVTWSI=y
>   CONFIG_I2C_MUX=y
>   CONFIG_I2C_MUX_PCA954x=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
