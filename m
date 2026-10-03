Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B412CA5FED
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 17:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDD536063A;
	Sat,  3 Oct 2026 17:12:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x3fcHYdqdzkM; Sat,  3 Oct 2026 17:12:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C693E6064C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791047560;
	b=n9dwtOWOU9c1lPqjs2EDDJMNq5eKoOE7cw98oV3ZvEqU6W8p3Qq6COfiMXpyEorei1zN
	 T73vVaWGcvhiX/BMEQDS3imfF1jywwel8HEiHp2tDQnIjGtUtPxdm7o26OoWfyJGCzhWI
	 1WTQxTTh0olKMDij8kfHViff0KodRNaFxWjn6Q+R42Dhpz5Djbhi6S4rKrRq4fC/Yy+jr
	 ieJjrQ9G9hB/RdS1um/hpXJvyA1trA5d23IX/4UU4m4BxKANhMxuToBHEMTIjkZNowHG+
	 fNVLdZkzjzyMAQWtHngdZiVQfi1LvdheQ7QZku3+QYusNo9h8nh+zfiTUeTnWwf6Xiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791047560;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7z0ngooR1ZvoIzatuppZOwP3eM0MHSNjL0pIjodq+3U=;
	b=M33h2djO6euKW+Cp11GGOnp5Q4WEVNQX6gizDR7jNmqO7DSLpKRL14miXRGUm0Jiq5yN
	 CRL2crtxjpXfRU2j2vAxAn1k71MXkFhYk7asbS2vW30HgPV7j0ZTcG/tQdal1fwDSiOtL
	 gZgtA0CV06DXg6R2lHGD2wwAgJelX1+SA3LIY9VCFDYNX1zacUePLn7LVRcaPqj78yp7Z
	 necoh2ClrcQ1WyMIKJ8dMN6lWBvEo4xbH6StjU0x48+wxXD6uqlqF1kfBIq1Ixz5uoVhZ
	 aokQuaaqIKMmP5lnjKkotMorOkASfUp3o7+OVzTrdX5bDidxBbphH56OBGgK9gntBcw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=g6f9QOja;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791047560;
	bh=7z0ngooR1ZvoIzatuppZOwP3eM0MHSNjL0pIjodq+3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UpSgW1rRPdx2gBz8gxZGdU/47AjtWsbKqvr1vd4gLD9+6ltWFhT/tjr6u6ehfJy8I
	 YowPA+NwKRAN5KSr4wVWWrEpW/6y5eWDFm/moWjVY7D1B1m3FzfF7ZF269C4M/NQRG
	 fOO6jfhm5w7U1YdOr2PU0IKCHwvgBPmCO4T7Jpo39Dsa7ZPZH9urrHex0P5IYJCRts
	 LKgrY6inISJEDH6t4//QlAKBriHaC4C8OUSVAXbj/sf2+ElcnOZ6XqQ+CU7Ha1kMG8
	 RcR/9r3TBz0dVpIBKgbaAobqzeJ1RI4GsD/nVRACMSznEDmUYMBsEXn8Ggv67GbEi3
	 vxuPJonQQwz5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C693E6064C;
	Sat,  3 Oct 2026 17:12:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F732435
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 17:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3524F6062A
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 17:12:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VrJAeWq0PXe0 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 17:12:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 755B160623
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:3a::20"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791047559;
 b=DTKjh5aBDjRGu5FuOLlm5SqiV4XSphdtHo9GMqyqUP6oLGl6jwu2xWiyMRVZF4h14Sc5
 JSsn+ahI0kN8GEm7wj/DymSPpdoyoty6E9JBh5jax3NU+iAHKa6s004dMQldqnTHKDCQ7
 RV7KOEQtbBd24Gq+U86/jdVtuoELIRP7FU+Rzs061v5Sf6EWMZLWUIo/r98T3+07WMuoH
 OFIIX9ftmymaJDhOwEf98RSisvYcM/Iv2mY+r4s26+tCZ9ZlMJ0iBE9wVVXy2EGVZh8Rx
 MCNBGrfUOb0BRANN8vccAQ18Vcv0TU3ihkx590xcY/2X0GBNOqnrATnMNq6mmmB4Iig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791047559;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=7z0ngooR1ZvoIzatuppZOwP3eM0MHSNjL0pIjodq+3U=;
 b=kRgYvmbc5Hna69ekty0WBE4DT3xi56k8zvzaHN5MqO0Y2pOKU9g1C1Byii+rIBHHwxl9
 hvb1Ct372r6BJnyfhIiy7IOQF2xdO5Ers8cjIzAhyz56JqpGY3iPLxnPSPHViU4ryWw5D
 YPrvMbk0qlcZ3K3w9hPK9C5aBeNHnu+tbbqyODWnDZyJj1C32gA95/zrnmnAsW2zu5f0j
 J4Xcs3WR7XCtdprp+qj4o2bWS+L51N+US1pJjtIhmME0Ibjv5ttveblaCWFHLOkDwdyj9
 XVRHFA0JiZnDFPXT2tKYjET3KnPBbi3229DlrFce8KFISqbvagn+kTOPY+KRv4ItiXQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=g6f9QOja; 
 arc=none smtp.remote-ip="2a00:1450:4864:3a::20"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:3a::20; helo=mail-vs2-x20.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=g6f9QOja
Received: from mail-vs2-x20.google.com (mail-vs2-x20.google.com
 [IPv6:2a00:1450:4864:3a::20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 755B160623
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 17:12:36 +0000 (UTC)
Received: by mail-vs2-x20.google.com with SMTP id
 71dfb90a1353d-5c9031e714dso150486e0c.3
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 10:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791047555; x=1791652355;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7z0ngooR1ZvoIzatuppZOwP3eM0MHSNjL0pIjodq+3U=;
 b=g6f9QOjacix+qqpPX3csVbpjMSe03OnsbOniDiCmEU1lUDrCrHoExGshlxn2WhSIcW
 TwMRHAUwS0IRuYpaZYT8gEUN5qIji0eccyLcxXHOsU2QdIAyk/Ftpqnp+S74jNLEXGPh
 Cgt6rizXSkCkxy+541W4EIf216OtkwzivhJ1UfLtq7tCTuk4NTzvi25fL0ReJO05NTzz
 ArIBJOzn61mqSrE/7qjOBs1uxWHNCzWi+2u+jD64pHlAMK9CkNZ8iJLwpRdqnkxMKjwf
 anRifB2d0XKfXdpKk5K6SvfAT3OjhgahwLJOqxE87IYgYcZNRS+bgCNGQOXBOnuulWd9
 JFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791047555; x=1791652355;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7z0ngooR1ZvoIzatuppZOwP3eM0MHSNjL0pIjodq+3U=;
 b=gJ11kbSYsZ65wfccJr1pJD5TPyXEEGOfUyNQ0zlik7NoV0UJ0/0inAFNLy2Qsejrw1
 0ePKoHSmgcOVt1aj3lcProNPDBJnc9ypqCU6uEdw+AKMlUOaa3fx2bYLil2xiK1dbpDw
 Lv94uPWqjbdymqdBnpkvPrtNBuiymLe++vaYcTHpMLidfEOVT8s/tAW5QFwPvdZu8AxB
 GjJrElvn/jSwS3ksjdjo0XsUANyOl9XjgEQk9NWlzZncbkC/crULawKOv0yTUc2TdAWu
 kA7XybA5OziPDo5uea/kKGgBibji2SNrhLOjd5LiVsb5rGxS/X/Tax7Y5wLVRwRJbi9I
 y2aQ==
X-Gm-Message-State: AFq9FYLwX15LR22wQTd/L4XyQZixb+3AmoxKknrAjEJU2w02GG/q0JfI
 7XHAm2dfRxZaF/2Wt2RGHKHw7w/amas7ZavOiFXq/8LYWTgABekyxejAJQGLFGkDxdw=
X-Gm-Gg: AYBFou3lMO9wvikMxcOxDVDMnuOb1aZQ2zW34WUFtpimI53vkdW7dR1W19Ksyl5vU4c
 xSV0kTEK0eL1F7t3Tvs0p8ntciL7OHG+Tiw12YwluBebwmsePDkfQ5zul0xymk723X3DOX4jo5d
 Gv/I26C45YxCoggQUgxgxaMowQAX271OUn5mGrgZT9I6d8lsT9ODiewGWjC0PvcggWGCw0yDXfI
 LzleSDr3SY1ULTYzfLYCgS+PDEgR/9MYSszJSz1ntIFtdKI6zOFIAGtz1hUbPX99ImlBBk4+SzL
 qv5XZyFwyQVhgXhs2gawl7I9f+JowDQXaOaY83W1M1iNoNPLN42QZdRmEL3QvXUexYQ9wjAQmJF
 dJBc5uVlPrwfdYI4grj2B0TIfDwkFeYliYWpV1maDj0yp/c9Dx9YIlvDi88/0V//AV0FyupTSg6
 dlm9a/AzkMr31htS0cMwggLwHL7krfSw/+7vHkk0KUVy3C1mVfTYVBygmuGhpZ1brfbYWuQ+XPA
 IyKQTCt0PDlE8GFMc112h25pmrlhNo/wvMe5yiIOYYfsewW+/w=
X-Received: by 2002:a05:6122:310c:b0:5c9:c60a:e9b6 with SMTP id
 71dfb90a1353d-5dab35b446bmr1777322e0c.22.1791047555605; 
 Sat, 03 Oct 2026 10:12:35 -0700 (PDT)
Received: from hiagonb ([2804:7f0:9541:40e1:2108:ffa6:f94b:baff])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5da6217c3d4sm7685507e0c.10.2026.10.03.10.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 10:12:35 -0700 (PDT)
Date: Sat, 3 Oct 2026 14:12:25 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 Tom Rini <trini@konsulko.com>, Johan Jonker <jbx6244@gmail.com>, 
 Alexander Koch <akoch@initse.com>, Kongyang Liu <seashell11234455@gmail.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, Leo Yu-Chi Liang <leo.liang@sifive.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/3] rtc: cv1800: Add seconds counter support
Message-ID: <asE276QMn3_nWUNp@hiagonb>
References: <20261003-cv18xx-rtc-sysreset-v1-0-c0837e26eb29@zohomail.com>
 <20261003-cv18xx-rtc-sysreset-v1-1-c0837e26eb29@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003-cv18xx-rtc-sysreset-v1-1-c0837e26eb29@zohomail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Zhuxu Ran,

On Sat, Oct 03, 2026 at 07:55:06PM +0800, Zhuxu Ran wrote:
> Add a driver for the CV1800 RTC seconds counter described by the
> upstream devicetree. Map the node's register range, enable the RTC
> clock, and implement reading and setting the 32-bit counter. Bind
> the existing sysreset driver as a child when enabled.
> 
> Adapt the register definitions and seconds-counter sequence from
> Linux drivers/rtc/rtc-cv1800.c by Jingbao Qiu.
> 
> Link: https://git.kernel.org/linus/d9f82683b123ce315cc36c4b20a5bc3d8644f947
> 
> Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>

Overall on this patch I think it is better to have consistent names: the
driver file name is cv1800, but in other places like the config or the
driver name you call it cv1800b. It is better to choose one and stick to
it.

> ---
>  drivers/rtc/Kconfig      |   9 ++++
>  drivers/rtc/Makefile     |   1 +
>  drivers/rtc/rtc-cv1800.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 133 insertions(+)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 5b44cc99c97..547ac1643c9 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -54,6 +54,15 @@ config RTC_ARMADA38X
>  	  This adds support for the in-chip RTC that can be found in the
>  	  Armada 38x Marvell's SoC devices.
>  
> +config RTC_CV1800B
> +	bool "Enable Sophgo CV1800B RTC driver"
> +	depends on DM_RTC
> +	select REGMAP
> +	help
> +	  Enable access to the RTC seconds counter found on Sophgo CV1800
> +	  series SoCs. When system reset support is enabled, the driver also
> +	  binds the reset function provided by the RTC subsystem.
> +
>  config RTC_PCF2127
>  	bool "Enable PCF2127 driver"
>  	depends on DM_RTC
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 742481ce185..961fe5409f0 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_$(PHASE_)DM_RTC) += rtc-uclass.o
>  
>  obj-$(CONFIG_RTC_ARMADA38X) += armada38x.o
> +obj-$(CONFIG_RTC_CV1800B) += rtc-cv1800.o
>  obj-$(CONFIG_RTC_DAVINCI) += davinci.o
>  obj-$(CONFIG_RTC_DS1307) += ds1307.o
>  obj-$(CONFIG_RTC_DS1337) += ds1337.o
> diff --git a/drivers/rtc/rtc-cv1800.c b/drivers/rtc/rtc-cv1800.c
> new file mode 100644
> index 00000000000..3a2b7b25748
> --- /dev/null
> +++ b/drivers/rtc/rtc-cv1800.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 Zhuxu Ran <zhuxu_ran@zohomail.com>
> + *
> + * Based on the Linux driver by Jingbao Qiu <qiujingbao.dlmu@gmail.com>.
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/lists.h>
> +#include <regmap.h>
> +#include <rtc.h>
> +#include <linux/bitops.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +
> +#define SEC_PULSE_GEN		0x1004
> +#define SET_SEC_CNTR_VAL	0x1010
> +#define SET_SEC_CNTR_TRIG	0x1014
> +#define SEC_CNTR_VAL		0x1018
> +#define MACRO_RG_SET_T		0x1498
> +
> +#define SEL_SEC_PULSE		BIT(31)
> +
> +struct cv1800_rtc_priv {
> +	struct regmap *regmap;
> +	struct clk clk;
> +};
> +
> +static int cv1800_rtc_get(struct udevice *dev, struct rtc_time *time)
> +{
> +	struct cv1800_rtc_priv *priv = dev_get_priv(dev);
> +	u32 value;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, SEC_PULSE_GEN, &value);
> +	if (ret)
> +		return ret;
> +	if (value & SEL_SEC_PULSE)
> +		return -EINVAL;
> +
> +	ret = regmap_read(priv->regmap, SEC_CNTR_VAL, &value);
> +	if (ret)
> +		return ret;
> +
> +	rtc_to_tm(value, time);
> +
> +	return 0;
> +}
> +
> +static int cv1800_rtc_set(struct udevice *dev, const struct rtc_time *time)
> +{
> +	struct cv1800_rtc_priv *priv = dev_get_priv(dev);
> +	time64_t seconds;
> +	int ret;
> +
> +	if (time->tm_year < 1970)
> +		return -EINVAL;
> +
> +	seconds = rtc_mktime(time);
> +	if (seconds < 0 || seconds > U32_MAX)
> +		return -ERANGE;
> +
> +	ret = regmap_write(priv->regmap, SET_SEC_CNTR_VAL, seconds);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, SET_SEC_CNTR_TRIG, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MACRO_RG_SET_T, seconds);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(priv->regmap, SEC_PULSE_GEN,
> +				  SEL_SEC_PULSE, 0);
> +}
> +
> +static int cv1800_rtc_bind(struct udevice *dev)
> +{
> +	if (!CONFIG_IS_ENABLED(SYSRESET_CV1800B))
> +		return 0;
> +
> +	return device_bind_driver_to_node(dev, "cv1800b_sysreset",
> +					  "sysreset", dev_ofnode(dev), NULL);
> +}
> +
> +static int cv1800_rtc_probe(struct udevice *dev)
> +{
> +	struct cv1800_rtc_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	priv->regmap = devm_regmap_init(dev, NULL, NULL, NULL);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	ret = clk_get_by_name(dev, "rtc", &priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	return clk_enable(&priv->clk);
> +}
> +
> +static const struct rtc_ops cv1800_rtc_ops = {
> +	.get = cv1800_rtc_get,
> +	.set = cv1800_rtc_set,
> +};
> +
> +static const struct udevice_id cv1800_rtc_ids[] = {
> +	{ .compatible = "sophgo,cv1800b-rtc" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(cv1800b_rtc) = {
> +	.name = "cv1800b_rtc",
> +	.id = UCLASS_RTC,
> +	.of_match = cv1800_rtc_ids,
> +	.bind = cv1800_rtc_bind,
> +	.probe = cv1800_rtc_probe,
> +	.ops = &cv1800_rtc_ops,
> +	.priv_auto = sizeof(struct cv1800_rtc_priv),
> +};
> 
> -- 
> 2.55.0
> 

Best regards,
-- 
Hiago
