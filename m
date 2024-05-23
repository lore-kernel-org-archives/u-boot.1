Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F774C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 03:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC1D788538;
	Thu, 23 May 2024 05:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Kr4+5NW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D31E88538; Thu, 23 May 2024 05:46:28 +0200 (CEST)
Received: from mail-m127107.qiye.163.com (mail-m127107.qiye.163.com
 [115.236.127.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D49EA88528
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 05:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Kr4+5NW3zoi+Oj79Bu1tKu/RJadJ8YLt6eBV3Pqk44yGhBx40Rs1ntaVtVEnOQdYYN638cQ64Vd4HNaPF/3+L7+ua7a4LKwniue49YubXcsydcY6m0onrSNsxRAQtcJqnLmlj+KjZwrhuYOVZhnmfndqAbtLj67jmMBQnavSyJw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=W5aRorFP38ay33+jZ+/Hersu6ycl+mJRkwyv60CZYGo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 5D4ED9002F8;
 Thu, 23 May 2024 11:46:18 +0800 (CST)
Message-ID: <24df9743-ef86-4fef-aeba-11e64aad45f6@rock-chips.com>
Date: Thu, 23 May 2024 11:46:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 V2] board: rockchip: rgxx3: Use sdmmc0 as first device
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, Chris Morgan <macromorgan@hotmail.com>
References: <20240521154549.255607-1-macroalpha82@gmail.com>
 <20240521154549.255607-3-macroalpha82@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240521154549.255607-3-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx8ZSFZMHUoeH0NJQk4YSB1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8fa38e8a4a03a9kunm5d4ed9002f8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NQg6Ajo6DDMCVhwULw8QKDAp
 CDUKFDNVSlVKTEpNT0hOQkxCSkxNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTkJONwY+
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


On 2024/5/21 23:45, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Some of the rgxx3 devices do not have a way to recover from a poor
> flash of a bootloader to eMMC. Set the device to always attempt to boot
> from sdmmc0 first which ensures that we can override the boot from
> emmc if we have a card present with a valid fit signature. The
> expectation is that this will protect from the very unlikely chance
> we have a valid FIT signature on the eMMC but the U-Boot stage fails
> for some other reason.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> index 793ed4ae8a..c7e849816a 100644
> --- a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> @@ -4,7 +4,7 @@
>   
>   / {
>   	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc1, &sdmmc0;
> +		u-boot,spl-boot-order = &sdmmc0, &sdhci;
>   	};
>   };
>   
