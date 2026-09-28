Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A852CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CBF880ADA;
	Mon, 28 Sep 2026 22:43:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vD5Ohttk2CZS; Mon, 28 Sep 2026 22:43:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 813D380A50
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635412;
	b=tQ0BECR6YXnF3KxgivysXni6xrxJCcbgWhht3vGUfjxNnkJfqlY9MUk2IkpGtx8Z3UKI
	 Gqh8UYh1jgftvgDWGmVg7ZtyQSbcZowoekKk3ixzGn1J1yLpAgdMJrwCb+c1UXbCH6wc5
	 ZSWthnu2d2COYsrmyziELF4cd8EbhGuFnyPzGRygshkaSZ/fXiUbjR8iOovovvRJFL4r1
	 BpnkdLri7IZNmqCGa/tUkZUsHJvBZFcwUzlLpXfza7J0KrILD58YE00PfbwtTU/0hWGn0
	 gPT3i8SIQIfhoC98V6eneMWK7Nd/DMTvYWUxQkkrN/NG/q2AI9qoB7VSdDE9/w+w7qA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790635412;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6Km1WyJ0muBos2YU6T+5d8bqFwKedLPnLEmw4aF+G4k=;
	b=C5iRcq+v9ykoFv5QO1vE96whlFPBw6hPQzfvIftF94qntQ4JnJiECVHFmhzcd0hqcuBq
	 jVxKBd05aeLrKHQ9zNSVRkgFhPrl84hZeWdjWk8gWmcCeUwlrPUFGpTQ4ZT6Fs8uVznJR
	 d4GAD7qNuPMXRNytx1GZ9LIxJaZ9qnFbR+CIDbrBdvSR9dY7WTTq03gkAAjbqASQGwDGj
	 hKbwY+VlDcNci7PQN7VxTtYjAgl3EhPHu2hqS6ccIPCEbTr/LsTZGh7/r6svhRdFx58C+
	 mA/oQ0bVn3EW51snGBK+dvgp47sg38LoLu20HUri8PMiQ5shDK9MiA6V9tdHi/n+USw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790635412;
	bh=6Km1WyJ0muBos2YU6T+5d8bqFwKedLPnLEmw4aF+G4k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IPDqvRcg7n/XdJRWNKD6id31QNWJNcNmCVW9eIyA3F4I3JCOspo2EBCkze4p991Oo
	 0aB1yXVe3r07AQeGPmHl8Q2TX/9JSSKB5LKTQ6xyJCzeiq8VvBiiPLMBoQHyv3B1LZ
	 3HF6l1CXzhgRjnZJDEj8K908rUBnw6n7ahdefBibZLYnQHJQMgLeRhXBOayZxYxdCW
	 I3hyOwan09Mhex1Dx+vi3vQdnQl6kz15LodUhZNSLqsNlXLa/7ejDEiB3v5Gci5mo6
	 w2MXumYpDpS/3RF+Q0vnycT5n7vGRUlp1nBEVaCfDtFlpbM17oMdqs9+VCIlwYhs8Q
	 0Di98yUxJtUFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 813D380A50;
	Mon, 28 Sep 2026 22:43:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 29AB2335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B6B640090
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:43:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sKUQJzzJLOwu for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:43:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 56EB84008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790635409;
 b=rP2H34yslUgp5ZYgkli2iNYTPm1RxPNNePLcHmNJTSs/i2wagVHot7keym/VNMp8BdcK
 qeQ7SF5sMIOV/EhpBUH4j0Ftvs+KrKcR0vAtVP/RE3XmpVNYW1KefVkGVpewPqASLas7L
 f731C9Mq6/jwKtHm0Z65yPSyxMKYBulY9wVFR7eemfMSjmJtT+pQn/K7X4eP5ZUhoGcej
 Ff8bgjoSOgFE9Tc5+GV8apEkUJOkRtjzl6/mhjnrRiH4pbYRw72ju1N1GZ2Wy+uRFSwxu
 Yn45Rk7og8IFqYdDkhIN2j5iu7vi0qbXWjF44LM9hVuQZGdGRJVevHGmKgIrNTdKFaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790635409;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=6Km1WyJ0muBos2YU6T+5d8bqFwKedLPnLEmw4aF+G4k=;
 b=OzQNK74acs9s0MHiLQgE4B6FKeVBDBy8bNu4IH/KLNQj0Wkb1x5exl7TCb5vl2fNgB2L
 9WhSxDvW48hsenmMHVGhGcCTgXCFw71NEKOZTF9U3deyNia7mr21R51oLXNVuc1D6n56c
 aNvx8f6gaBzxm7orO5FAy3+8ubP7AevhcvE/5oHqBKeNVDICHuLsIiMMHZSvvxaPjvnqK
 j15JTl7XIAbPkxCMZbckqjMRDP5yYkw+LVSneI2+1PuVxx6QOsojnzafUWaDnBPXXnEfG
 7EgztYDXbUglutfEjv9weIELLrZ83vP3KUhTKwnBJEiLDxrHEau3TzUbU1i/o9NqmiA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Nly5gQjN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Nly5gQjN
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56EB84008A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:43:28 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6d8d3336db0so481152eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790635407; x=1791240207;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6Km1WyJ0muBos2YU6T+5d8bqFwKedLPnLEmw4aF+G4k=;
 b=Nly5gQjNWcKZVRSth9B1Yck7zGY7F+FVPGE9OmZ8Bh6G2wHPS279p9mVWpqR2ovNN7
 9S0aOSqb6dLztFVEyfqle1Bym22i2tD/BlD0NhYhuDMd4sHKPaAHBs1Kc04hiawesZa3
 Z4ZXXk358l1hxxCYHy0A+sDBQCr+g1z0xCJZA4HuRLUAa7NuBHFFQEy9Jw4TqDAPhvvm
 cGF6moV8D7z2MMTHwDWXAJQWhe7dGqMxnQPOnqypNuoU2004e1mO2DHyOn7ogtUyMDRO
 r7M8chFN4icibkmc+oGrIUeOFHBlrKRjxqYl3N4IntwAqR+L18xB0nghEHS+FroMatcD
 gEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790635407; x=1791240207;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Km1WyJ0muBos2YU6T+5d8bqFwKedLPnLEmw4aF+G4k=;
 b=jX3Be3qlA2WI3Ghgzjrif6RIoQXIbd1QW+/ikr/r0zdr+fgEqgeGM0HGCcFjvQCbkh
 czkQPXIrz8YPeOL6qpOe/nsHoalMvuXj2XbJtapdLHlm6TR95g3f9OlVaaqJnZJLCtGS
 HM/5mWLO3pSJjuG5fYswVS9dhC7spIDZtVs4ysji6croPUm1N/rV2AczBemL8Ip9TJKP
 hUpsLzGeXo5MEhSCfgyZ//FZXocOLg7FdHsFCOeo7u2dNFZ1nAUFO5LEYP7vG++97waP
 WtSq2RlxsGLdj/LSPNvVda8136MjRJbV5ty8HxiOteUc93AVEbeDW0Gmx2nNYfSi3zdf
 4Tug==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5okYgyZaw1lm8pGuW4qLGnlLZU7oXrL8YPqji2K7CvhCJOGtb+vDDD/46uw1AaDAbXCALYLM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m01xo/Qq5Y/m4AQY2nGj9I5QTxJkyjoJlqt5+8UxwQT0eLoRS/
 BOAnSGGX57xktPG5IW/bI6ONiU/uWr7fT0IU5CWuuxGpt/L8BxXUwuQsUJueHRy1Axs=
X-Gm-Gg: AYBFou3Th5L43zUl6emfzeN6uvgafqaVnX/lxq4ER8C1qieId+XzJKfyZxVxNL2ykg3
 ysQQBJtbzz9n9z604pA9zQWNEIUghhWFNHSe2BzlwqcY/g8y3WyT2FGnpJHERUBb7RLU0sguWfe
 GGokimgHwHjwUq/UQUy7tMQHaPszael7W5EmxlBBUhKPJU7eAKxFPXZHixV/NQZXmRjgRpwPCbJ
 lDzXYNkl6I5HIk2WzUYbExx3EVdkOrLseunEjwDYuIlW/HNL07LJLsPXmyHkVsHRAbcblq/j7fT
 cwMy6/w8TNUxDOe6AAx3SEtLzhaLlZVKcLvFqdbZF0aY6rk8C5K8YM6RZi/vO7oPxgiOES861bx
 2xbdmC8Ld/iC/uHgp4j0luoDx75pEQsZZsDFfr80iHd8PhMYltTIIMhPPUcGTPwjetKWNeoyFPf
 Qcms+W+omSOF+bboezkM5IG+bSGh8fsbj6F27K0GS9aDBcxnkEhJIvW1Fzk6cOX337M7+DVBCrv
 H/wIc4Hq61oBR1iPdHsh/R9ayWXHtyJyxkp9+Yc8k+f86U4
X-Received: by 2002:a05:6820:160e:b0:6d8:ac5f:88af with SMTP id
 006d021491bc7-6d8ac5f892fmr4328971eaf.33.1790635407677; 
 Mon, 28 Sep 2026 15:43:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:9b16:2a1a:ef3f:3700?
 ([2600:8803:e7e4:500:9b16:2a1a:ef3f:3700])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d882bd143asm6950454eaf.8.2026.09.28.15.43.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 15:43:27 -0700 (PDT)
Message-ID: <898e280a-7af1-4f0f-9d10-a7350e4579bd@baylibre.com>
Date: Mon, 28 Sep 2026 17:43:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm: mediatek: enable U-Boot fastboot DAs on Genio
 510 and 700
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Julien Masson
 <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>
References: <20260923-ccaione-upstream-mt8390-da-v2-0-8f264678ac29@baylibre.com>
 <20260923-ccaione-upstream-mt8390-da-v2-2-8f264678ac29@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260923-ccaione-upstream-mt8390-da-v2-2-8f264678ac29@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/23/26 4:17 PM, Carlo Caione wrote:
> Prefer fastboot in U-Boot proper when the complete download agent fits
> the BootROM SRAM limit. Its shell and boot commands support provisioning
> and recovery beyond the SPL agent's flashing operations, without relying
> on the installed firmware.
> 
> This variant requires BL31 and an external DDR loader.
> 

...

> diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
> index 6f1ec052b95..120a94c6598 100644
> --- a/arch/arm/mach-mediatek/spl.c
> +++ b/arch/arm/mach-mediatek/spl.c
> @@ -33,15 +33,17 @@ void board_init_f(ulong dummy)
>  
>  u32 spl_boot_device(void)
>  {
> -#if defined(CONFIG_SPL_SPI)
> -	return BOOT_DEVICE_SPI;
> -#elif defined(CONFIG_SPL_MMC)
> -	return BOOT_DEVICE_MMC1;
> -#elif defined(CONFIG_SPL_NAND_SUPPORT)
> -	return BOOT_DEVICE_NAND;
> -#elif defined(CONFIG_SPL_NOR_SUPPORT)
> -	return BOOT_DEVICE_NOR;
> -#else
> +	if (IS_ENABLED(CONFIG_MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT))
> +		return BOOT_DEVICE_RAM;
> +
> +	if (CONFIG_IS_ENABLED(SPI))
> +		return BOOT_DEVICE_SPI;
> +	if (CONFIG_IS_ENABLED(MMC))
> +		return BOOT_DEVICE_MMC1;
> +	if (CONFIG_IS_ENABLED(NAND_SUPPORT))
> +		return BOOT_DEVICE_NAND;
> +	if (CONFIG_IS_ENABLED(NOR_SUPPORT))
> +		return BOOT_DEVICE_NOR;
> +
>  	return BOOT_DEVICE_NONE;
> -#endif
>  }

Could be nice to do the CONFIG_IS_ENABLED() conversion as a separate patch
so it is easier to see what is added here.

> diff --git a/configs/mt8370-genio-da-uboot-fastboot.config b/configs/mt8370-genio-da-uboot-fastboot.config
> new file mode 100644
> index 00000000000..5a85b26df0d
> --- /dev/null
> +++ b/configs/mt8370-genio-da-uboot-fastboot.config
> @@ -0,0 +1,28 @@
> +#include <configs/mt8370-genio-da.config>
> +
> +CONFIG_MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT=y
> +CONFIG_SYS_MALLOC_LEN=0x9000000

What is driving the need for such large allocations?

> +CONFIG_CMD_FASTBOOT=y
> +CONFIG_USB_FUNCTION_FASTBOOT=y
> +CONFIG_FASTBOOT_FLASH=y
> +CONFIG_FASTBOOT_FLASH_MMC=y
> +CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> +CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
> +CONFIG_FASTBOOT_MMC_USER_SUPPORT=y

Do we need to enable FASTBOOT_CMD_OEM_PARTCONF and FASTBOOT_CMD_OEM_BOOTBUS
to allow flashing a blank eMMC?

> +CONFIG_SPL_RAM_DEVICE=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x41000000
> +CONFIG_SPL_MAX_SIZE=0x25000
> +CONFIG_SPL_CRC32=y
> +CONFIG_SPL_GZIP=y
> +# CONFIG_SPL_MMC is not set
> +# CONFIG_SPL_LIBDISK_SUPPORT is not set
> +# CONFIG_SPL_EFI_PARTITION is not set
> +# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
> +CONFIG_BOOTDELAY=0
> +CONFIG_USE_BOOTCOMMAND=y
> +CONFIG_BOOTCOMMAND="fastboot usb 0"
> +CONFIG_ENV_IS_NOWHERE=y
> +# CONFIG_ENV_IS_IN_MMC is not set
> +# CONFIG_BOOTSTD_FULL is not set
> +# CONFIG_CMD_BOOTFLOW is not set
> +# CONFIG_EFI_LOADER is not set
