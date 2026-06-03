Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D94CD6E60
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 13:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35A1F83EF9;
	Wed,  3 Jun 2026 15:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LpGTkQK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F69183FF5; Wed,  3 Jun 2026 15:12:06 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58E5A839A8
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 15:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49041e84237so6620435e9.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780492322; x=1781097122; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HWxZpnXttjO7QnBgxG7yJ5h2BpycGhjJeTroH+3DKkY=;
 b=LpGTkQK4IYuX5tr73TPeXryXYaYGURk0vm/yZYhynFy8fpj/RXA7ggVWLmz6ebJKgG
 XF2IvcRUj1mRQZSpwiDBo96sHtPKFKEvjWVl89SzkmzvNM3Sawj85AjlOQMtZchU540w
 D+cz2nJXOL3+ByVlm5WYrCntYqaP0TO3e1QO4PbrgcOJEuCVcI2Ej/AH506wHfTQo2DS
 P1LcokXRoTi6GxjSoJowzAmDh4I6hZBiZm98/9/yaCP+HGq9IaaAbbDiW5MfQQHDCxaL
 4ljR8XJqwvtIbxm19qNVOWHTXLGUkOfr8krxI/q3rPm0DeLTQiFeVEGhxP3XzRWtUnaR
 5C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780492322; x=1781097122;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HWxZpnXttjO7QnBgxG7yJ5h2BpycGhjJeTroH+3DKkY=;
 b=ps/SEOX+1JNc+QKbp12ZJdPtjDxtWv6Ip6SR11t3wl1dEKac4ESxF2fWwWi33k2ISo
 2DQNIKRM/SU8aL0EL7dChysrWgN4iIBtLPbWrQIcphU0GPeN75rw+tNE3Q54iD6XKW4x
 U61LiedzirrlqJX/RHxzkuYrcaRSLsW634YUZhn51+uRneoJHrYfLtnYazsX6a3ZADqK
 FvDAgxcWbt2wUmHwMTD5vunfd1/T+5n6rUMT2AvGUmcQg5AS+MvKBeEUKVvis8OpY2Mj
 pOLKuv4eLGXJ7njv6CsVBQ0zWfFxj8DTxMSqNqBglYh3l+2HurFkLlHJ91QJAMAacBFP
 ISBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KjA+3S8eb3AEReIQkXlE5Qltr4QIY65A8Yy405b7RbO9dA9Lz17EXYPqowm8O0UVYj4buImg=@lists.denx.de
X-Gm-Message-State: AOJu0YyVmIneCAJZYBjPIMk5uC+/Yr9STj8XJUwRvkZbYSdhmPbrSdMg
 BadCzDe4qyY1oP8ZFkvyo7rByYimcjG39IKASOwx9xeAYEBEBqeM0uxYwUTG3KD0rHI=
X-Gm-Gg: Acq92OHQtxuXqsIlH04dwtpplzq+7xG1rRlh6KZkEOtLyr/u/a/ZGfEz8fUD5RCUG0J
 IJpxe+F3v3I6827d/4zF2uJgFxgjMsPZueXel5PbRHzz5O/4cCPpw8S7BpUblPWpWwQIgZz1K3t
 rnuyUBEX1JxDd6jBD2bjXG8VSXrSVTddwm6AovvLsJ+c8t996af7RNHPO9p7RS7Ihfl0Hxk5Yxy
 FnO47isyJA9/TwbKzm6BOTl79jsoyna7a5ZBEN4jPa8VFfjuSPJb2qaRLv5cAPiWKKfXcmd4ld6
 qYfutFfaXExhVWyQDVzSrbT0nwYkdlTn6UkwUHdNi9+Bo+7kG1A42/DULlJvT2MKk1FZlPbYBlC
 Ee1PYWHDxlwza5SG+CFxVzgRDgWy9rhPiUXuwtQWTMPn7ghDyMB9v2HebMPSf7j/Bue2vxSXkoo
 tKDXRTWa1fDGTwmZp5MPEwFCaaOmscJX8crk8smFzSkHZWplTSK+OcH9MGmwSptq/uHbVQgVdcj
 68Xcj8z40Yt
X-Received: by 2002:a05:600c:c492:b0:48f:e230:29f4 with SMTP id
 5b1f17b1804b1-490b615faafmr44292565e9.15.1780492322617; 
 Wed, 03 Jun 2026 06:12:02 -0700 (PDT)
Received: from [172.18.178.88] (ip-185-104-138-128.ptr.icomera.net.
 [185.104.138.128]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b6150bfcsm112043135e9.3.2026.06.03.06.11.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 06:12:01 -0700 (PDT)
Message-ID: <aab00bf2-e4ee-4919-bdd9-892a65ae00d7@linaro.org>
Date: Wed, 3 Jun 2026 15:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: simplefb: fix rot prop handling
To: Sam Day <me@samcday.com>, Rob Clark <robdclark@gmail.com>,
 u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini
 <trini@konsulko.com>, Igor Belwon <igor.belwon@mentallysanemainliners.org>
References: <20260601-simplefb-rot-fix-v1-1-eb65d41ffffd@samcday.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260601-simplefb-rot-fix-v1-1-eb65d41ffffd@samcday.com>
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



On 6/1/26 08:05, Sam Day wrote:
> If the simplefb node lacks a rot property (which would be most of them
> nowadays - it's not actually a valid prop according to kernel's
> simple-framebuffer schema), then the rot local is left uninitialized.
> This causes video_post_probe to fail to locate the vidconsoleN device
> later.
> 
> Strangely enough, simplefb has been working fine on arm64 targets. It
> wasn't until I tried simplefb on my arm32 device (samsung-expressltexx)
> that this issue manifested. AFAICT, ARM64 doesn't have something like
> -ftrivial-auto-var-init=zero enabled, so I suspect this has just been
> working entirely by coincidence until now. Computers are fun.
> 
> Fixes: 91e9687b49e7 ("video: simplefb: modernise DT parsing")
> Signed-off-by: Sam Day <me@samcday.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   drivers/video/simplefb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
> index 8d0772d4e51..ed8d4170cfc 100644
> --- a/drivers/video/simplefb.c
> +++ b/drivers/video/simplefb.c
> @@ -19,7 +19,7 @@ static int simple_video_probe(struct udevice *dev)
>   	int ret;
>   	fdt_addr_t base;
>   	fdt_size_t size;
> -	u32 width, height, stride, rot;
> +	u32 width, height, stride, rot = 0;
>   
>   	base = dev_read_addr_size(dev, &size);
>   	if (base == FDT_ADDR_T_NONE) {
> 
> ---
> base-commit: 30b77f6aa146c96b831cb4ece038130b655b6a41
> change-id: 20260601-simplefb-rot-fix-7afa95d24118
> 
> Best regards,

