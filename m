Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C4DE95A87
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 01:46:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2884A86DFA;
	Sun,  8 Oct 2023 03:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696728642;
	bh=v2Nsubm/7tHBruxQ1rUy/Jwzi3k+FZdknhPTCcxLIp0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pj8jYdmP8iSml6h66xxHKzN5bjcnDKksO18d5Y3iz/BR63CZ9H8ZXXAsU04FpyjQR
	 e9aBMqbylR4ugjaZ9VWbhILshjcUUe5jyXDpwfdQ/E51iDKabjg7q4ao8X8ef854UT
	 AhKx0XS74Dy/Cylk3yTSXnvK2JrpufLuAoDa4YoGNO7xKzyFOV+K4tp1TTfp1LlWMu
	 t3vf2K2MYXXMG2Zz5fLjP6lXqXSl2IMNyf9yC68jk9m6zndgyVEV4D0fMvEh7SGAsm
	 +/Lzyy4xg956m9OolqffjbN2vTWsnzkJGIWr4mdE8A+LmDSL9hNz6ifxTAbN6N2BjL
	 0IqRCMtOXctAw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D18FE86DD8;
 Sun,  8 Oct 2023 03:30:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696728624;
 bh=v2Nsubm/7tHBruxQ1rUy/Jwzi3k+FZdknhPTCcxLIp0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vZ19VzuTVVkpS7KX1H2czR8gnhnO1RMAEtgMJ9cCEqqDvRpsX+cLSbAhFt++BCw5s
 8ogrDB8qCQoJPq/68nPFoWqCamHr47T3H8dvFBCDTqfMBAp4rcGpjxIsMyA+8+0S10
 2LyFexeBEmHkKJVYdUqq8cOjjlmr3MTsFyqjadNUZjUilG7crXu2q5bb/PZKlhr1qr
 xIz0iRmDiGpvfLFZWX2l+Z/R0PCSnxALnUVFfxjOx8dHrexMm+zFwDdN7hJOaPohxp
 7Hx2+sFZdw/3gKtVEbmWKyw4vr8fMkTMlOgVchB94W9LMjrEX37N8rKLiJy2DDnmB2
 CNxNoZmsUvh1Q==
Message-ID: <5c8382f1-6406-4843-bc3a-2cf7e4eb032c@denx.de>
Date: Sun, 8 Oct 2023 03:30:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mx28evk: Add USB Mass Storage support
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
References: <20231007215648.3156877-1-festevam@gmail.com>
 <20231007215648.3156877-3-festevam@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231007215648.3156877-3-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/7/23 23:56, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Select the USB options to allow running "ums 0 mmc 0".
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>   configs/mx28evk_defconfig | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/configs/mx28evk_defconfig b/configs/mx28evk_defconfig
> index df0cceaea719..15cc99684c05 100644
> --- a/configs/mx28evk_defconfig
> +++ b/configs/mx28evk_defconfig
> @@ -32,6 +32,9 @@ CONFIG_CMD_DM=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_NAND_TRIMFFS=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_SDP=y

This seems to be doing more than just enabling UMS, right ?
SDP is enabled too, but not mentioned in commit message.

> +CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_DATE=y
>   CONFIG_CMD_EXT4=y
> @@ -65,3 +68,14 @@ CONFIG_RTC_MXS=y
>   CONFIG_DM_SERIAL=y
>   CONFIG_SPI=y
>   CONFIG_USB=y
> +CONFIG_SPL_USB_HOST=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_MAX_CONTROLLER_COUNT=2
> +CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y

This SPL USB gadget is not related to UMS either .

Please fix, either document the full amount of changes, or drop 
unrelated changes.

[...]
