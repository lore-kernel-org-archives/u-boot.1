Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A304C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 10:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 680B087536;
	Mon, 23 Oct 2023 12:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="cSEZmg/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02E1A878CF; Mon, 23 Oct 2023 12:13:50 +0200 (CEST)
Received: from mail-m49210.qiye.163.com (mail-m49210.qiye.163.com
 [45.254.49.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F0E887024
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 12:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=cSEZmg/1+MDFJOQ2AWveVT+NeoYyvKk3DwTxdfvx2T8pTZUSuGLkySxQDJeEfgpBzTssMkoQTpoeBulJebnBTN213ckvUYY1ezShSPEJaL30yLm+3l/tkJJ3Qkpt8Tk2STx2qmZXPRJfffyKd97FRpe6//UcsEdp3ZIrMG0NrYU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=7/Vt6KOAt0vkn4qY8mWdXaXrYg5i/5ADdebG2SlbxMQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 1B068400493
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 18:13:43 +0800 (CST)
Message-ID: <077c6662-3187-4e7d-b111-09ee4e6ddd67@rock-chips.com>
Date: Mon, 23 Oct 2023 18:13:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: import common led bindings from
 linux v6.5
Content-Language: en-US
To: u-boot@lists.denx.de
References: <20231017155943.127659-1-tom@tom-fitzhenry.me.uk>
 <20231017155943.127659-2-tom@tom-fitzhenry.me.uk>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231017155943.127659-2-tom@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhkZHVYdSR0YTkweTk1LGR5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8b5c06ac5f2eb3kusn1b068400493
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxQ6DSo*Sjw4Azg4Mk0YTyot
 CC5PCwtVSlVKTUJDS05NS0lITk1CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSUJINwY+
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


On 2023/10/17 23:59, Tom Fitzhenry wrote:
> This brings in more colours, e.g. ORANGE needed for the QuartzPro64 DT.
>
> Linux commits:
> 472d7b9e8141 ("dt-bindings: leds: Expand LED_COLOR_ID definitions")
>
> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   include/dt-bindings/leds/common.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
> index 3be89a7c20a..9a0d33d027f 100644
> --- a/include/dt-bindings/leds/common.h
> +++ b/include/dt-bindings/leds/common.h
> @@ -33,7 +33,12 @@
>   #define LED_COLOR_ID_MULTI	8	/* For multicolor LEDs */
>   #define LED_COLOR_ID_RGB	9	/* For multicolor LEDs that can do arbitrary color,
>   					   so this would include RGBW and similar */
> -#define LED_COLOR_ID_MAX	10
> +#define LED_COLOR_ID_PURPLE	10
> +#define LED_COLOR_ID_ORANGE	11
> +#define LED_COLOR_ID_PINK	12
> +#define LED_COLOR_ID_CYAN	13
> +#define LED_COLOR_ID_LIME	14
> +#define LED_COLOR_ID_MAX	15
>   
>   /* Standard LED functions */
>   /* Keyboard LEDs, usually it would be input4::capslock etc. */
