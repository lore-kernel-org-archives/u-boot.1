Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A2EC25B4F
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 02:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9375885AF;
	Wed,  8 May 2024 04:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715133769;
	bh=ReK57ZHXJ2MBVQtRDDtoPYARs0pSHI1A8YB7zBL+/iY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j0JdwKh4KT9gckpE1hDRBflNc+e0C8QUY7JmIJ4WpNKtp5jrFbTUp90Ac2wEZlXB/
	 He35++Lg0oFXE148xSDYFFu2WDxr2G2BzFV7nL75ezESWakN7+Nn9wGSZrdJq8qhzv
	 ugY/VWeA+J4IKz0nifrDAaSAHQZ2opU2xWqWFK5y1XOi1/7o3WdNLSKTt81JAbDvqg
	 2vBtNWynGxvcRV2TfmB+IL6Omfp+iVP/xlTWEucg2A0TKQe1BljwaxE2s/sm/wmkrH
	 WtDs8/vtdP8lrpYOeFW2xoWGPuIOld0pJMUTPTnO2KNV8BkBdl9HTIyujCW4Yt4+Ht
	 zpNuWi8kCHnRg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 171BE8843D;
 Wed,  8 May 2024 04:02:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715133766;
 bh=ReK57ZHXJ2MBVQtRDDtoPYARs0pSHI1A8YB7zBL+/iY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iXGjOSDHH2NNuQNQ4VxmwujcnWvfMWtQuwP5NiiJJKpr1FMHLoVM/O32RUytMCC0I
 +tGNZ/MgGhrYsjEJlpZbglye4w6/vImylLgwoiwlvhCcuBQiFyLr8bmeFUllLfHR/A
 6f8HTUtIFKQZshmmi+o493LencdZGe9oQ+6m1Y9mhZpu7JWwpgdGbBora7+wZMwx1y
 o9FwXONic1b6BMCXc1thRR8JNUzCgxylcBb9NWnVbycGfZqH0F6OZHnCTV3hOxPmDy
 F73GksL8134A9kKb0hFHTp+08+MU2MjQ59dhkxUWOMrocO9HSDgD3hBE4UiJurcK+r
 uSj+ofhkkZ3FA==
Message-ID: <31783bbc-5efe-4721-aff7-53933c87baf5@denx.de>
Date: Wed, 8 May 2024 03:36:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/7] MAINTAINERS: Update Starfive visionfive2 maintain
 files.
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
 <20240504150358.19600-8-minda.chen@starfivetech.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240504150358.19600-8-minda.chen@starfivetech.com>
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

On 5/4/24 5:03 PM, Minda Chen wrote:
> Add USB related files to Starfive visionfive2 MAINTAINERS.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>   board/starfive/visionfive2/MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
> index d7f638f9b4..1faf83f581 100644
> --- a/board/starfive/visionfive2/MAINTAINERS
> +++ b/board/starfive/visionfive2/MAINTAINERS
> @@ -6,3 +6,5 @@ F:	board/starfive/visionfive2/
>   F:	include/configs/starfive-visionfive2.h
>   F:	configs/starfive_visionfive2_defconfig
>   F:	drivers/pci/pcie_starfive_jh7110.c
> +F:	drivers/phy/starfive/
> +F:	drivers/usb/cdns3/cdns3-starfive.c

Thanks !

Reviewed-by: Marek Vasut <marex@denx.de>
