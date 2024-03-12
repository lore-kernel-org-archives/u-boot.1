Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1FBC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 03:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 063DC87F28;
	Tue, 12 Mar 2024 04:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GdHC8iSp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBA7687F49; Tue, 12 Mar 2024 04:50:42 +0100 (CET)
Received: from mail-m19731112.qiye.163.com (mail-m19731112.qiye.163.com
 [220.197.31.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7610287F1C
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 04:50:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=GdHC8iSpCdGeWebf/NtYPOpQ9ugpSBrPS8klY3iTwHabZiJZ4YZn3WQ0uJ7/CiI5Bb/sVsNkOi3XQZW9zezhCnaICaRVYae+RhVeje6v2jfloF6Kz+mfkWuV/JYYVt4o+q3zX7NhIaRIaokh2gp7C7frhBBg+xpQwB7bFvLblj4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=4C2D/Y3oX7D8aWsTyDfZtAdzc6bX02bFPnRfwJzVEOE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 0A80E900273;
 Tue, 12 Mar 2024 11:50:28 +0800 (CST)
Message-ID: <04030fa5-1334-4e6f-87ef-35ae9bf97409@rock-chips.com>
Date: Tue, 12 Mar 2024 11:50:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/16] button: add missing ADC dependency for BUTTON_ADC
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
 <20240304-rk3588-saradc-v3-15-7424e2ed5d3b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240304-rk3588-saradc-v3-15-7424e2ed5d3b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx8aHVYeQ01DT00fSElPH0JVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e30c87e8203a9kunm0a80e900273
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kww6GCo4EzMPMDYDIjUKDwE1
 Pw4wCh9VSlVKTEpLSUpOT0hLSkpIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS0lCNwY+
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


On 2024/3/4 19:30, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> The BUTTON_ADC symbol guards the compilation of button-adc driver whose
> name very well makes it explicit that it requires ADC support to be
> enabled.
>
> Fix build issue of button-adc driver when ADC support isn't enabled by
> making sure it cannot be built without ADC support.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/button/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
> index 097b05f822e..3918b05ae03 100644
> --- a/drivers/button/Kconfig
> +++ b/drivers/button/Kconfig
> @@ -12,6 +12,7 @@ config BUTTON
>   config BUTTON_ADC
>   	bool "Button adc"
>   	depends on BUTTON
> +	depends on ADC
>   	help
>   	  Enable support for buttons which are connected to Analog to Digital
>   	  Converter device. The ADC driver must use driver model. Buttons are
>
