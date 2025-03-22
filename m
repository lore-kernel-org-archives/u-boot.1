Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E73C36005
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 02:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F5D81E13;
	Sat, 22 Mar 2025 03:50:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742611812;
	bh=ZTDE7fsnoZ4E+WyTfCvLygiZjOGPNanAqBqAxlcXouM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WkZRf0QD5Hhdr4KRnhuPV9mYFVjQE6kUvGbGeF8rVxHmuQi7dL5KWoORj9sFm8qz7
	 F9vhzMxUw1jUANXJt2RQK4hZ1o2mnznJrEJbN9yPfZLxSpYU+tAjskL72UASE9Eg38
	 lDbg/KoGFcKvUcjOasURZkIoisua/zEp+yeXgLMUOHEQs6IjXAkAHzvyFf/LT5Os/W
	 ifJ7ZVVOiiQPbVTC3L1+pWUuOgYCq6m8ifDsUYLAzk7kb6CPXzDUMAxndfcT0zJpno
	 2m/A4BmedLpq/zxpSWijv7qDI+i0ZgKI0d3gpkAktJyPl9uVQMK691RMNQKlgImuLa
	 heIKAuY6HjXYg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D60A281DDF; Sat, 22 Mar 2025 03:50:10 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7AAB81DCD
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 03:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="HSPUBmvW"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 92D7C101E8F68; Sat, 22 Mar 2025 03:50:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742611805; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ZTDE7fsnoZ4E+WyTfCvLygiZjOGPNanAqBqAxlcXouM=;
 b=HSPUBmvWVxtRIQPdk5QyTj5XFPOTVTVVRq8CBwmsfBxN0bB6tSUlOI9e/LkQr+Hm5YFhPE
 5kVjZpBhU5a45ptqW5gn0Vgmy+Ut9MXJoty9CL1PRJGEk/SoWT4Ebf/FIG14xq3Pzy/1RL
 nUCBhqpB7+H3Q/ULnJeWyYTN8xvRzgSbtIJxMpFU/QHZpjvjXjq9dfbZV+42IqDutZzyoI
 8Oq93qL48L63ipzWCSZno3sVhIz4uedUbg4MwfRueLplONLmDbGiX2ELmU8Pp9P98ECORO
 btbrdYvk3ENX3WBGsDZWBHJGOFwtbkTI2i65miWVJcPIw07AwI2+z2DKb5vj0w==
Message-ID: <f704ab4b-2223-440f-affd-8a9ffcd2236b@denx.de>
Date: Sat, 22 Mar 2025 03:15:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/19] imx: Kconfig: IMX8_ROMAPI is not configured for
 i.MX95
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?=
 <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-13-f2c8ba815f89@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250321-imx95-v1-13-f2c8ba815f89@oss.nxp.com>
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

On 3/21/25 8:15 AM, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> i.MX95 only supports low power boot, which means A55 is kicked by M33.
> There is no ROM runs on A55 in such case so that deselect IMX8_ROMAPI
> for i.MX95.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>   arch/arm/mach-imx/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 134e42028c3..f38f3b2d338 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -180,7 +180,7 @@ config DDRMC_VF610_CALIBRATION
>   
>   config IMX8_ROMAPI
>   	def_bool y
> -	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
> +	depends on IMX8MN || IMX8MP || IMX8ULP || IMX93 || IMX91
Keep the list sorted, MX91 goes before MX93
