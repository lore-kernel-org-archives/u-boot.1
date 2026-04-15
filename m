Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D383F4213B
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 19:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BD2683C2B;
	Wed, 15 Apr 2026 21:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="qL07nYpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D70783EEF; Wed, 15 Apr 2026 21:27:45 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C473E83B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 21:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dbd08144deso6507470a34.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776281260; x=1776886060;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z9pHAyC2MSXCOGZS4EM/jAg/9KPWyZ8FeYONgRLWmsc=;
 b=qL07nYpJywdssicWDqhc33GoscRks+qYp6ocWulbtTHLANp0jZfSqsQNGVe3gU/r3x
 xOPTrdwX5vK90Fb9scBG28PUowMhL7ezCw6wlpgfYRB+3AGJ6KV2AGaJ/vVAneyviGLh
 oeQ3fkIATPjZQdL5ZOOpW2DJVhIlzQTUorv57mZpTjdWn41Be5dHmaXvY3qH5E+ZR/OH
 SRrrAdNHUgmb1wenFI0YkCjA3Nw3e5lPC5gs+VzE3ai9qq6DbQtafmZ/e+tclDmec2+D
 HPlItjhufeVC7IIzimSxbRQYPChSEMnk2/S8AD/2t7R6WhzXx/xfL1DDlt6tu6GBSqyY
 afLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776281260; x=1776886060;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z9pHAyC2MSXCOGZS4EM/jAg/9KPWyZ8FeYONgRLWmsc=;
 b=EWAKrcMs5be6D9KD5arX2G1/U1g9rFJe7qaLiPGkELBUbQwNORo8wK/qegRn4gt5S8
 US2afe2K+/GnxxVyAZI/d2cANNkJ+XK+fvqpR9VBLfM+S3fiGMMNredYuDeXjhRNGEIO
 TBmqdyCJ6PSTDR5w+6rpSanNl5oQL8Ml006dK+rS2PZ28JHNJNEF2fxNIT8me1B6hFnC
 V9gQo66spvw+znqoULbZgjMgMJpBrZOT/tB23bLNZUXD8ES9IJnM8t1rWkIVR5dvJ1ei
 3DT+AZ6Wf+cT3DzRN1jmEpt9mT/JG8B58G5zXymjFCI5KkaYznQhnHtX2FgBuDabzcAE
 x9Mg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JUQgkzT4FTA8CnKZwduhvl2f4I73qhpymdjq9iBkWOsadyJLaEws5S13HVEpkuwa3msscvYY=@lists.denx.de
X-Gm-Message-State: AOJu0YygSP2x0AauNb9z1ElFygAYz/eHAXGjU+QQgOToZc5VWdHGjTBg
 pOWkoXhsaJ5y2q171MjC+pij5IALHNXfSsNYlXeiZqBBIwVNu3ceGpXaq7B9aJKgcbU=
X-Gm-Gg: AeBDiesR9aZu1R8j19zsjcQPQy0ko4lH9sQz784hrTmRSwU+N5n+jlGNf/5/vqcQBmP
 NJ6k0MCUiGS539rZja4PQEws9vzqEWVzjfdo/ZpkFDgW71YiY3ce1pkJoRG9wCjwaeSCMZ2iM/o
 bn4kuiNYwlorl32jBcJX7b+Ps0rd0pXmZ8QwAhFJVBDE5C40Hb10y4MArW+V26cb2u/jT5Wk66L
 /VFFaiSkaQx55IG1u5dXPeQHblg7UtvHbG7RM8P9Co5+GgIif9WaY6Q5FFCrrfhjVmsnbNGyVbk
 CAUmx5v1UjM6JTj42QRC9F/N91fEVoC+o3vAGv9LLJ1d2t2oEQsKqx1bzGGZnfgr/9ohyjeBT09
 +JMBC3yKP049zp5qNymUcDxrx5uc+b/eWL42d1oGuyz5jfqwQvD9je56dblgvfdiPGeX8r2rCma
 vdC/zygxbOUu2IdqxbkbTEu5Iw3IjwEGUsy2puKiX+OqOYcY1B4h0ZADE6DtgrTRu+7oZ3Q05nH
 aYhRzVrfa59
X-Received: by 2002:a05:6830:8290:b0:7d9:f50f:96cc with SMTP id
 46e09a7af769-7dc27c643e8mr13764339a34.2.1776281260513; 
 Wed, 15 Apr 2026 12:27:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5ab6:1e6d:2337:887c?
 ([2600:8803:e7e4:500:5ab6:1e6d:2337:887c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc76b95a2csm1981183a34.22.2026.04.15.12.27.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 12:27:40 -0700 (PDT)
Message-ID: <0d7ba570-335e-4de7-b272-7152b540def2@baylibre.com>
Date: Wed, 15 Apr 2026 14:27:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mediatek: enable fw loader support
From: David Lechner <dlechner@baylibre.com>
To: Weijie Gao <weijie.gao@mediatek.com>, Tom Rini <trini@konsulko.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
References: <20260410015311.4066075-1-weijie.gao@mediatek.com>
 <d23fec41-0eeb-489f-8c1e-5bb4b974139b@baylibre.com>
Content-Language: en-US
In-Reply-To: <d23fec41-0eeb-489f-8c1e-5bb4b974139b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
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

On 4/15/26 10:02 AM, David Lechner wrote:
> On 4/9/26 8:53 PM, Weijie Gao wrote:
>> Enable SUPPORTS_FW_LOADER to allow the mediatek platform to use ethernet PHY
>> drivers with fw loading.
>>
>> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>> ---
>>  arch/arm/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 03416c55265..aee8e74dace 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -868,6 +868,7 @@ config ARCH_MEDIATEK
>>  	select SPL_LIBGENERIC_SUPPORT if SPL
>>  	select SPL_OF_CONTROL if SPL
>>  	select SUPPORT_SPL
>> +	select SUPPORTS_FW_LOADER
> 
> I don't think this is how this config option is meant to be used.
> 
> Based on [1], it sounds like we just need to make sure CMDLINE and
> ENV_SUPPORT are enabled in any config that also enables PHY_MEDIATEK_2P5GE.
> 
> I don't see any defconfig that enables PHY_MEDIATEK_2P5GE though, so
> I'm not sure there is anything to do here. Unless it makes sense to
> enable this in one of the existing defconfigs or add a new defconfig?
> 
> [1]: https://lore.kernel.org/u-boot/20260310162610.1163833-1-trini@konsulko.com/
> 
>>  	help
>>  	  Support for the MediaTek SoCs family developed by MediaTek Inc.
>>  	  Please refer to doc/README.mediatek for more information.
> 

I thought about this some more and I wonder if we need to do something
like this to make it actually work correctly though...

---
diff --git a/lib/Kconfig b/lib/Kconfig
index 4e6a0c6a1b6..ed37daa28b8 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -73,6 +73,7 @@ config DYNAMIC_CRC_TABLE
 
 config SUPPORTS_FW_LOADER
 	bool
+	default y
 	depends on CMDLINE
 	depends on ENV_SUPPORT
 

