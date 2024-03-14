Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5264C54E5D
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 03:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C7B087F6F;
	Thu, 14 Mar 2024 04:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="G7rcyAl1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7631487F64; Thu, 14 Mar 2024 04:34:30 +0100 (CET)
Received: from mail-m17215.xmail.ntesmail.com (mail-m17215.xmail.ntesmail.com
 [45.195.17.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED2F987F6F
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 04:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=G7rcyAl1tUh7e7NpF5W+90BisvmgFErgS5WaqLLuZa/IYGlRzLW/zU2o11EpERCVBHHnYEI6HVQa0YyjxOZXgqrkCYKLKlYCET9oAePArC8UEOLP+Kt76uQ+CG+EpJ5Ty/gKpcAMbsDglB48l3sv1xb1sLoAxkylsZZiRnWhnFw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=rzPfQRFCkcRvzOZ1slXZN2MHepbS7e99G8+KuxwOgIA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id F21E49001B4;
 Thu, 14 Mar 2024 11:34:20 +0800 (CST)
Message-ID: <e85bf0dc-b431-45bb-96a2-ff4020fde144@rock-chips.com>
Date: Thu, 14 Mar 2024 11:34:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] Revert "rockchip: Allow booting from SPI"
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de
References: <20240217002304.2141064-1-jonas@kwiboo.se>
 <20240217002304.2141064-13-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217002304.2141064-13-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0tCGlZMGUxCQkNIQhhOHxlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e3b0671e203a9kunmf21e49001b4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Njo6Ojo5FjMJPCg4Kx0fTU4a
 C05PCgJVSlVKTEpLSENMSU1JTktCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0hPNwY+
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
> This reverts commit 3523c07867b403d5b3b68812aebac8a5afa5be4c.
>
> Booting from SPI was already allowed before this commit was first
> introduced. A few lines further down the exact same code already existed
> and still does.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - No change
> ---
>   arch/arm/mach-rockchip/spl-boot-order.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
> index 2c39a215c107..79c856d2a0ac 100644
> --- a/arch/arm/mach-rockchip/spl-boot-order.c
> +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> @@ -65,9 +65,6 @@ static int spl_node_to_boot_device(int node)
>   		default:
>   			return -ENOSYS;
>   		}
> -	} else if (!uclass_get_device_by_of_offset(UCLASS_SPI_FLASH, node,
> -		&parent)) {
> -		return BOOT_DEVICE_SPI;
>   	}
>   
>   	/*
