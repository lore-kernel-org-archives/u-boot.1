Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B387E9D41F
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 17:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A7688341A;
	Wed,  4 Feb 2026 18:35:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="D/5CbX9d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE51D8341A; Wed,  4 Feb 2026 18:35:02 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD9BD83015
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 18:34:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so463635e9.1
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 09:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770226499; x=1770831299; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ZL9njVTgql5g4k/lW9mBX5q7BvsRlrcs4utCWh9sIzM=;
 b=D/5CbX9df1tk4rQX2jXwf63Qem1+4SkzyHT3szVOdUuGfgSWAWgfshyN4yCfIKacHm
 G5p2tvKtbZZl0w2PnA9/wOBkOqEoAiAd+rmP4492gWuJfl961hvbO70fioGlryvIDuGt
 gMhtTXQvN8eIxXHfewiXqeuzu+k70L4/FZURBlSxlkkBx/CHBa61KhHF875s1PxuRqOx
 p1Ti/WOhemnHx74Z5w4hykLOxrdOHGzLoysuAP0f/+WOmDkhf1vWzCvmyVfrxfzZgqWs
 gVvqNV6XtkigKi19OakT/GzpYZT5FCE3XZBRCOamRi8Mip8/UALQcJ8ALmNK6gXBWsfA
 /p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770226499; x=1770831299;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZL9njVTgql5g4k/lW9mBX5q7BvsRlrcs4utCWh9sIzM=;
 b=Zr706r4U6XOBIweVKBnncGGDUyFqC/DATVPnIJQI4MonAynWOrm90bh1JK7pKODZGF
 4Qbr5GWIGL5kxn41jQrILIflKQgOLkACtN+zR0ANLZivdfAnwHfd6zO7YYu+zcg96Y20
 ylyGSZTp8CkuIrwaElJCmpVbBwzErm21KcbB6fYYbILByFGfC3aUx5KgJzuidBDaZiKJ
 oZKiGLmDvaYMzZLNzE1u5qcf1m042ZzDgmkXVw4sfB8gs0r9L/iAfApD7A4x3NzuIAgR
 YbJ3/rXKuTpCydSSEViUbryp1yY+OK2lvvO1Mb16ZX+UhpBabRx32TzlPdp1BfOPPOme
 HW1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgSAP+tRssLRO+HUcwOu/0/nAB5vQbwAlJOQ3YzR/mFwP+ByvTPmpKnf9Ns0CqFuC902P/CiQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzEz7tiUq3pBYtAXIiOKGwCE69fqSzT9NeAzVnEgA4M9zm1huJk
 hOaCgjfeAfZZigqmsuC2I2s3hqQHHXt6vEr8DFEuhP1h4X5wuTGhLvYgfMfocE6iwK8=
X-Gm-Gg: AZuq6aIL9hC3vVAB9n41pnZmVvqMX8fuz5HFxd18vj3TnF71SxQjEtSz5H9eaSTv6xM
 00JzrVCkQroF9liNgd2yg5LZaPLuk9/jIkZSAPCZ7nke89Tg+TA0FzWbIZHEoHC4pBHuhrKR0bx
 W23LJB+vrLpsIhgnWIznHMdHjSFKTs4M3PrxI1zgacWrxPAaPosBPGb9Jqr4xHPE3xoiu6kNsGs
 r2MhG/f6IR5dCvhRB6pWJ4QhV/nRms1qUiFCr6BId3mU/cw+J1CDkETPaxh0ctqjQH6LwYTTLWT
 ljOSwP47Y1bUGV27mNe3+1aBshQdZOYU2sr5whO8E8s6otJlmzQyoEHME8Oz0Ou18dxALfKTFTq
 iCXFbqpum/NyYtDWcJ6svfHklCq79HFwgE/TrddeRKj1w8wnBVv69zzH8O0bdq2uOx8/l9CykAw
 qL1jZvvpJNpn5H6U3ooYc3Pb7lVnMJMykKZHgHK/NXYjW4x+bvIEdz5w==
X-Received: by 2002:a05:600c:c4b8:b0:47e:e712:aa88 with SMTP id
 5b1f17b1804b1-4830e971bddmr61120365e9.31.1770226499095; 
 Wed, 04 Feb 2026 09:34:59 -0800 (PST)
Received: from [192.168.0.29] (static-95-59-231-77.ipcom.comunitel.net.
 [77.231.59.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4831084d9d2sm59818045e9.5.2026.02.04.09.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 09:34:58 -0800 (PST)
Message-ID: <c7dea041-832b-4dbd-9d5d-c823b29672ce@suse.com>
Date: Wed, 4 Feb 2026 18:34:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: bcm283x: Fix GPIO pull state register values for
 BCM2711
To: Cibil Pankiras <cibil.pankiras@egym.com>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20260129151509.548538-1-cibil.pankiras@egym.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSRNYXR0aGlhcyBC
 cnVnZ2VyIDxtYnJ1Z2dlckBzdXNlLmNvbT7CwXgEEwECACIFAlV6iM0CGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAAAoJENkUC7JWEwLx6isQAIMGBgJnFWovDS7ClZtjz1LgoY8skcMU
 ghUZY4Z/rwwPqmMPbY8KYDdOFA+kMTEiAHOR+IyOVe2+HlMrXv/qYH4pRoxQKm8H9FbdZXgL
 bG8IPlBu80ZSOwWjVH+tG62KHW4RzssVrgXEFR1ZPTdbfN+9Gtf7kKxcGxWnurRJFzBEZi4s
 RfTSulQKqTxJ/sewOb/0kfGOJYPAt/QN5SUaWa6ILa5QFg8bLAj6bZ81CDStswDt/zJmAWp0
 08NOnhrZaTQdRU7mTMddUph5YVNXEXd3ThOl8PetTyoSCt04PPTDDmyeMgB5C3INLo1AXhEp
 NTdu+okvD56MqCxgMfexXiqYOkEWs/wv4LWC8V8EI3Z+DQ0YuoymI5MFPsW39aPmmBhSiacx
 diC+7cQVQRwBR6Oz/k9oLc+0/15mc+XlbvyYfscGWs6CEeidDQyNKE/yX75KjLUSvOXYV4d4
 UdaNrSoEcK/5XlW5IJNM9yae6ZOL8vZrs5u1+/w7pAlCDAAokz/As0vZ7xWiePrI+kTzuOt5
 psfJOdEoMKQWWFGd/9olX5ZAyh9iXk9TQprGUOaX6sFjDrsTRycmmD9i4PdQTawObEEiAfzx
 1m2MwiDs2nppsRr7qwAjyRhCq2TOAh0EDRNgYaSlbIXX/zp38FpK/9DMbtH14vVvG6FXog75
 HBoOzsFNBF3VOUgBEACbvyZOfLjgfB0hg0rhlAfpTmnFwm1TjkssGZKvgMr/t6v1yGm8nmmD
 MIa4jblx41MSDkUKFhyB80wqrAIB6SRX0h6DOLpQrjjxbV46nxB5ANLqwektI57yenr/O+ZS
 +GIuiSTu1kGEbP5ezmpCYk9dxqDsAyJ+4Rx/zxlKkKGZQHdZ+UlXYOnEXexKifkTDaLne6Zc
 up1EgkTDVmzam4MloyrA/fAjIx2t90gfVkEEkMhZX/nc/naYq1hDQqGN778CiWkqX3qimLqj
 1UsZ6qSl6qsozZxvVuOjlmafiVeXo28lEf9lPrzMG04pS3CFKU4HZsTwgOidBkI5ijbDSimI
 CDJ+luKPy6IjuyIETptbHZ9CmyaLgmtkGaENPqf+5iV4ZbQNFxmYTZSN56Q9ZS6Y3XeNpVm6
 FOFXrlKeFTTlyFlPy9TWcBMDCKsxV5eB5kYvDGGxx26Tec1vlVKxX3kQz8o62KWsfr1kvpeu
 fDzx/rFpoY91XJSKAFNZz99xa7DX6eQYkM2qN9K8HuJ7XXhHTxDbxpi3wsIlFdgzVa5iWhNw
 iFFJdSiEaAeaHu6yXjr39FrkIVoyFPfIJVyK4d1mHe77H47WxFw6FoVbcGTEoTL6e3HDwntn
 OGAU6CLYcaQ4aAz1HTcDrLBzSw/BuCSAXscIuKuyE/ZT+rFbLcLwOQARAQABwsF2BBgBCAAg
 FiEE5rmSGMDywyUcLDoX2RQLslYTAvEFAl3VOUgCGwwACgkQ2RQLslYTAvG11w/+Mcn28jxp
 0WLUdChZQoJBtl1nlkkdrIUojNT2RkT8UfPPMwNlgWBwJOzaSZRXIaWhK1elnRa10IwwHfWM
 GhB7nH0u0gIcSKnSKs1ebzRazI8IQdTfDH3VCQ6YMl+2bpPz4XeWqGVzcLAkamg9jsBWV6/N
 c0l8BNlHT5iH02E43lbDgCOxme2pArETyuuJ4tF36F7ntl1Eq1FE0Ypk5LjB602Gh2N+eOGv
 hnbkECywPmr7Hi5o7yh8bFOM52tKdGG+HM8KCY/sEpFRkDTA28XGNugjDyttOI4UZvURuvO6
 quuvdYW4rgLVgAXgLJdQEvpnUu2j/+LjjOJBQr12ICB8T/waFc/QmUzBFQGVc20SsmAi1H9c
 C4XB87oE4jjc/X1jASy7JCr6u5tbZa+tZjYGPZ1cMApTFLhO4tR/a/9v1Fy3fqWPNs3F4Ra3
 5irgg5jpAecT7DjFUCR/CNP5W6nywKn7MUm/19VSmj9uN484vg8w/XL49iung+Y+ZHCiSUGn
 LV6nybxdRG/jp8ZQdQQixPA9azZDzuTu+NjKtzIA5qtfZfmm8xC+kAwAMZ/ZnfCsKwN0bbnD
 YfO3B5Q131ASmu0kbwY03Mw4PhxDzZNrt4a89Y95dq5YkMtVH2Me1ZP063cFCCYCkvEAK/C8
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20260129151509.548538-1-cibil.pankiras@egym.com>
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



On 29/01/2026 16:15, Cibil Pankiras wrote:
> BCM2711 has different pull-up/down register values compared to BCM2835
> 
> - BCM2835: NONE=0, DOWN=1, UP=2
> - BCM2711: NONE=0, UP=1, DOWN=2
> 
> This patch fixes the pull state register values for BCM2711.
> 
> Fixes: 2c39d975f87c ("pinctrl: bcm283x: Add GPIO pull-up/down control for BCM2835 and BCM2711")
> Signed-off-by: Cibil Pankiras <cibil.pankiras@egym.com>
> ---
>   drivers/pinctrl/broadcom/pinctrl-bcm283x.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> index 4ecc8bac645a..33638515b5db 100644
> --- a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> +++ b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> @@ -30,6 +30,11 @@ struct bcm283x_pinctrl_priv {
>   
>   #define MAX_PINS_PER_BANK 16
>   
> +/* pull states for BCM2711 */
> +#define BCM2711_PULL_NONE 0
> +#define BCM2711_PULL_UP   1
> +#define BCM2711_PULL_DOWN 2
> +
>   static void bcm2835_gpio_set_func_id(struct udevice *dev, unsigned int gpio,
>   				     int func)
>   {
> @@ -84,7 +89,7 @@ static void bcm2835_gpio_set_pull(struct udevice *dev, unsigned int gpio, int pu
>    * bcm2711_gpio_set_pull: Set GPIO pull-up/down resistor for BCM2711
>    * @dev: the pinctrl device
>    * @gpio: the GPIO pin number
> - * @pull: pull setting (BCM2835_PUD_OFF, BCM2835_PUD_DOWN, BCM2835_PUD_UP)
> + * @pull: pull setting (BCM2711_PULL_NONE, BCM2711_PULL_DOWN, BCM2711_PULL_UP)

Why call it BCM2711_PULL_x instead of BCM2711_PUD_x?

>    */
>   static void bcm2711_gpio_set_pull(struct udevice *dev, unsigned int gpio, int pull)
>   {
> @@ -108,10 +113,19 @@ static void bcm2711_gpio_set_pull(struct udevice *dev, unsigned int gpio, int pu
>   
>   static void bcm283x_gpio_set_pull(struct udevice *dev, unsigned int gpio, int pull)
>   {
> -	if (device_is_compatible(dev, "brcm,bcm2835-gpio"))
> +	if (device_is_compatible(dev, "brcm,bcm2835-gpio")) {
>   		bcm2835_gpio_set_pull(dev, gpio, pull);
> -	else
> +	} else {
> +		/* BCM2711's pull values differ from BCM2835 */
> +		if (pull == BCM2835_PUD_UP)
> +			pull = BCM2711_PULL_UP;
> +		else if (pull == BCM2835_PUD_DOWN)
> +			pull = BCM2711_PULL_DOWN;
> +		else
> +			pull = BCM2711_PULL_NONE;
> +

That code should go into bcm2711_gpio_set_pull().

Regards,
Matthias

>   		bcm2711_gpio_set_pull(dev, gpio, pull);
> +	}
>   }
>   
>   /*

