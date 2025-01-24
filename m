Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD68C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F64E80BAD;
	Fri, 24 Jan 2025 16:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737732403;
	bh=FiPI5u5Uh0JuVUE8XrgzUEr443EiOz8Q3dzZ/HRh4vs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d8+8pb2ucm/SDhB+Lkvcux9ckwvV4HQHBjERLusWsG9PyoTg2396Gk/3WzVxMtcjP
	 J9GLj8xmpY1iTdZZ9gkYapvxA2mL2DuzbuDqJrHdMCere9YO7HcZUaaxRK02e1OZZv
	 W7xyqovfq9oFRIVsp7v6R81Y2zcUlmcV7Ae6qk69rOak/5s+/WRYZeLQWsxhQqZE/U
	 ozuZZgPLc0YADU7vym00Qr8vjk+x0QA3KdQCSHLJdNbuAprXKVQJdzgDFw5XYPWvjh
	 uWp5g9nNAsmxoGklOIO3eMLHoXcur79Td8v3rWes7srUNM5L5O2bbbCDA2whNB+KES
	 Cbp7DUPmub7QA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C41F80E90; Fri, 24 Jan 2025 16:26:42 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF5FE80B9C
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="QUBtBcM6"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7C6BA101D2386; Fri, 24 Jan 2025 16:26:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737732399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FiPI5u5Uh0JuVUE8XrgzUEr443EiOz8Q3dzZ/HRh4vs=;
 b=QUBtBcM6Fv2Wmwqeb1/IUyAyBkOl9vNAQODIhERKXxnyCNhf1TBcOe7FJpoNNxyZ9aqb/k
 aSkNEhv5hvYWVn8TAqTYRfh19FQqmabUiRBcJMvkLUHhB6d1lZ/80D3xRrBm7d/afU3FBw
 D+yqNrijN1H6J5AG1KTVZUurWFBJkmvF0Ghsg7nVeSEkgPYQdxQ5kwK0h8HJbt1rT0MGZm
 +YHymPtnKHlayUmSR/1RBB0dLAn/h6VIHztOyWwU7kqxJUEy/Jg5QPWMCeCPZzHYPmtAeb
 TP3/XhnEc3mqDMfjc4kN7c+75247LTIUmPD4gcKne4lbZrJYPC/5V5o6rrSUnw==
Message-ID: <e93df1cd-9cc7-415a-a6a9-27d9529e9398@denx.de>
Date: Fri, 24 Jan 2025 15:58:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/20] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo
 <alice.guo@nxp.com>, Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-3-93b28a514dea@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250115-imx95-v1-3-93b28a514dea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/15/25 2:28 PM, Alice Guo wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> This patch provides a pinctrl driver based on SCMI pin control protocol.
> Currently, only the PINCTRL_CONFIG_SET command is implemented.
> 
> Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>   drivers/pinctrl/nxp/Kconfig        |  13 ++++
>   drivers/pinctrl/nxp/Makefile       |   1 +
>   drivers/pinctrl/nxp/pinctrl-imx.c  |   7 +-
>   drivers/pinctrl/nxp/pinctrl-imx.h  |  11 +++
>   drivers/pinctrl/nxp/pinctrl-scmi.c | 136 +++++++++++++++++++++++++++++++++++++
>   include/scmi_protocols.h           |  34 ++++++++++
>   6 files changed, 200 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
> index 06c26f156f6c8f63204604d6065485629cfd9b61..ec63ab595650d0dfab7e3a7dc01d4af7814b6773 100644
> --- a/drivers/pinctrl/nxp/Kconfig
> +++ b/drivers/pinctrl/nxp/Kconfig
> @@ -1,6 +1,19 @@
>   config PINCTRL_IMX
>   	bool
>   
> +config PINCTRL_IMX_SCMI
> +	bool "IMX pinctrl SCMI driver"

i.MX instead of IMX ? Please be sure to use the branding consistently 
across Kconfig entries and various text fields.

> +	depends on ARCH_IMX9 && PINCTRL_FULL

Is this really supposed to be available for all iMX9* or is this limited 
to iMX95 ?

> +	select PINCTRL_IMX
> +	help
> +	  Say Y here to enable the imx pinctrl SCMI driver

This Say Y stuff goes ...

> +	  This provides a simple pinctrl driver for i.MX SoC which supports
> +	  SCMI. This feature depends on device tree configuration. This driver
> +	  is different from the linux one, this is a simple implementation,
> +	  only parses the 'fsl,pins' property and configure related
> +	  registers.

... here, at the end.

>   config PINCTRL_IMX_SCU
>   	bool
I have posted a couple of pinctrl patches to [1] , that should simplify 
this pinctrl implementation. The entire series is also available in [2] 
, the updated mx95 pinctrl patch on top of it is [3] .

[1] https://lore.kernel.org/u-boot/20250124145520.185414-1-marex@denx.de/
[2] 
https://source.denx.de/u-boot/custodians/u-boot-usb/-/commits/test-pinctrl
[3] 
https://source.denx.de/u-boot/custodians/u-boot-usb/-/commit/3191ef0497c629017da4d88bf6a14ff0ad7c0032
