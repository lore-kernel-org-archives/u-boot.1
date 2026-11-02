Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373C1606CEC1
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PpXjEewE;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=dJPdDm6j
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 068A48111D;
	Mon,  2 Nov 2026 16:42:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1EEgH_Z4PKXr; Mon,  2 Nov 2026 16:42:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 22D01810F9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793637759;
	b=CAaTzP7G8w7gIPQCbtL/sGakJ7fIkaTE3Fk+2Hk1owaOIY2ZvIYHLFUwKeiK2219BD7k
	 RWWOXy4T9+Rd/y6dlAkgEM8LCw3poNDLRBax97b0N8YkU2+l1XNUYevobLvDnFQVneYBc
	 9gUUW/PFZsFvNCISxeDGD8vMfNIpCbJEW+LnPfRY8dkk9J61N+zrErdOKoyPsRZmS3U/K
	 2TwoLLubPYRZTKEK0AoqUDeUhZxNCEU77oYnOp33uX0KrVRpb7HYR9rk2mKsJA8SQaKU7
	 b4YIMSHpH4aObtdEHd4y5cgZa6eMnVQw9spysdw7yRVKOiwhEKQGYniHwUducb9qEPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793637759;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iJXNxmTTiwEzl9fphRNHT/oaRo1ETliBYLxl2LOjVP8=;
	b=LxwhNwOZ+OcHRxJKOgOtbRgQKrGfdE0vK1Noa8BjSInhqoewTVC0PDeEmlu4A7Rm5LZT
	 7hJk2gbfKnk12BEKfVamjoWjWVSnhumH3F6f8etQnSptR/KxO6Sz8HyBLaIYtrULL3gKl
	 QfmNXij2veMwJ+as7pvvqrEo3+7XztctLWxPCMno+OglzN4ogtt2PRuJUqPWQ882VvrVe
	 Au0MteaG+XdkmbWskvpJOKIWC8x5tDg8t+RttifAuOa0tcjB5YQ7eXmq2PTNgCEOg37NC
	 cjNxYJefCKS3UkEz+O42JXba5k7TpKe+8lZfi/uK4xTYaMgBe2iFbaWvoWN4sMOQwsg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=dJPdDm6j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793637759;
	bh=iJXNxmTTiwEzl9fphRNHT/oaRo1ETliBYLxl2LOjVP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PpXjEewEzxoGMH04FqQZD9Pyxu/Z8AN6fcazN/rgh2KYg1YILkw+8aZx7CjKEB/8W
	 VAyQ467EoNr7QAroc/XdbyRBtorMpEK14NBe419CyiBoPzD/1IgBOa/ABJYnQ/eA14
	 Sv9CD9dLQH1ltk5a+ajaw1Qcbgu6qWuXYet71YEskVnAvWVwT89XPycH1/X3G5mtTo
	 IO694Y1sZPrrofIbrqlLeUtoRbTC8/qCPT9vHWTZ2GbQD5j47fNohsvaFY9ABkHgfp
	 HFTT73YGmiVZ62UuDEorm9dcXWvohlj5VdcVYrS0p8+hpg4e8IFJQdZmi5iBJK0DgN
	 QpLcCGiFFxS1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22D01810F9;
	Mon,  2 Nov 2026 16:42:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C664120
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 81BBA810F9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:42:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vk1wA3AoClsP for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:42:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4AFAC809BE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793637754;
 b=ZHYBuWYaW/90iTX42fPhYFPk85kV16itrmNjkig+sUhCfYQW4qwLiypXnitLKwDb/CMy
 NK68trvVPTpit0hUzyv64kIqqMj8tf2fQQA6/V4pVfdLmscM0gL71QSNIMvqzVbSACbfK
 oEuT/lOlGnncoBWZUb6dBBlWY0MN9dUargOWTNN5DWmcs57hXylwoEgFep1mcOTnO3ONJ
 vNQwvgREBQhEGzFl+IpeMqFHIIaNSZID4/vj8HaEc+ypQjc76wgljtcYHuPu9EDuW5YQL
 gQfoIJu+/rHPhyr5t9k/gLg/LIRBk7OYsC0E3JGtUgk2u39a3LwHWrnivdrSG+UpJGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793637754;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=iJXNxmTTiwEzl9fphRNHT/oaRo1ETliBYLxl2LOjVP8=;
 b=CqvZVMeqXialAqZGhwXt5UQGyuO+rQTtDuU58fYHiwTMm4ZwP4UmPInI8zjAvMlCzye9
 Jd02WaoXH3bdiak8WBoUZW1uIkuw7qJTg9i8ek2HxWVdbYzzDm2NTJDaIGg5xg9/0/as0
 0jZDIafmyCtqC05YRKIQN9bjr9iYAXtAptPPCuswlQwjMOpHbMYgrpeVNL5fCuHSsTzbD
 MBaBI4MlfjFx2rTRlNkcxhryUppukTZ/oKAndvKinZUhub/OAS4VfqVBu3njv/A07bHCW
 TafpisI/CiT+Jhenj+ykHIE8meQoUAyKm8tckIVjkwCs+M4pu+SZ7n0B83Pids0KljQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dJPdDm6j; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dJPdDm6j
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4AFAC809BE
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:42:32 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-833e671ee9fso3381795a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 08:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793637751; x=1794242551;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iJXNxmTTiwEzl9fphRNHT/oaRo1ETliBYLxl2LOjVP8=;
 b=dJPdDm6jIQ3ZzuwFbqJGkc6+IyCb5ATskwXvM3AtJrMHJLsqwsJlsNeeQQ9/3/Rac4
 H3Uw+ZxbjQtRv952UymPcoYHMlpFqFmlGK+BoRUltfHqcYYed0K5jPig1xAFZsc8tkcj
 Gok0UJcOs1jguGMaNFNVHos3vLd1RWXt6Ie2lwgkxomqUrkU2A4RfQiwggN/Mfc9bmhc
 UXQcmPrx7yYDmHfJ9TUhablX8Eaz810CoD58Agib9qY/wDwVYyW+ZjT7feAKSO+eZhsk
 O75xljtO9u4CuU0aBBe0Ileqic3kywyb3qYQ+9N7B9iYm6m5uLpMveJc2w4HQP2h2iY5
 f5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793637751; x=1794242551;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iJXNxmTTiwEzl9fphRNHT/oaRo1ETliBYLxl2LOjVP8=;
 b=zxCIYi2ibJuRtDmXKjqNXXfR5qklaLfWFtyE9NOXaik05DCs9C5LzZM1qzlpJfEIO/
 BjP2w+EJksRgZVRW6CpLD7CwzCGzPRPVD08J3dI+aRIisr4sJaVuBWK4vjoiaUlhKgxE
 RyN1ujAIcKDZYpbCGDfaVxoaDHJ9QPRMi3DaQlk1Iz+R8EvYOFRPFuWCSAhYq8G9Tvf8
 z7gitq7CP5/Fyq2bsGfroI+gdirpvmcK1OWoz0GrkVwAD5dwmH8ZL34CfD8wLpiGRNHu
 1J0/B4a9epMTNybIzOQ3gycJ52ok22Fj/APew/uHbkhP5FFEqCJPuICsllC21wDH/DrX
 NwDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy96dYFvv23Lot+O1XafdF4FvuHjNeCrTLiaJEvXFMhtwCBsalhFj4uGvP/Q1CUOp1nM0xZw3s=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLkVNLqQnVzKK6lN5P7CG6cO3QbbQwh7u5qvt+vwhKLb3gmFjU1
 z0lDo5iiXigo8Ik8XTpbYMs+3UDYAY6AwCypTC4c0RhwY2GQQ6B+W4MUOfjW3+RT2no=
X-Gm-Gg: AYBFou01jFUz1nWYUmb1uBKkv7eC+/Magcoagew78Xw0RMrRsCtkNs0cU6hmdHqqOrw
 IqjAKIjlHKOlXGi9iA32drgfMrXmBfwqgXPxnqly6N7c7fEvZUIBIysMwlEHiB97BgolJOZjkPo
 9YhBVKe9UqzqkNotVQMicoGh+1/4+sfMhuDXha7vqOELY+8hKTSkPoWIxBW5OOH1Mpdta7DTykn
 4sPa8nBlSn3E44Q/SWgz9j2M6LapeuEm4qtT7McL7ZboHpOuxnEeuEvdhvoOCQq7JswMCaoGnf9
 pj/EbpRsdhYHaw10blQ4NFbX4R2gHVWWrYZBSxNku/ADUGa9+vSTGKrhGeGQkrJLzhbACNIAZfJ
 GuvQwOvoEYlLVdOx8lNFaXX44YXl1/4ks5peaibl/wKcRsR6xI+okReWEsc6hmrWK6OTfzrJxXu
 nJBjMlMal7NH1Kb+BONPawNquBYaCY4ihGXIcc658IiZESbjXZjpeHBmY4S/8Mrn1kynnOKio8r
 CphlBTkg+cma3HnX8TLNqnoTB3U3rGnioZr40c7qYhaHiErivhvOoktdaXCM4aPe6WbPU/ia6RN
 jTQr2B3NfmX4IBmtJsbyRrjfao28bKeTkZGP82x2XTBHa1qkWHMdVK3uZKhGKoeKHvvLHumz2l1
 6hlU=
X-Received: by 2002:a05:6808:6508:b0:53b:11c7:2da0 with SMTP id
 5614622812f47-5640ddf5cc2mr6910427b6e.21.1793637751224; 
 Mon, 02 Nov 2026 08:42:31 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1432:12c3:1aa3:969f?
 ([2600:8803:e7e4:500:1432:12c3:1aa3:969f])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fd9888bsm8803640b6e.5.2026.11.02.08.42.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 08:42:30 -0800 (PST)
Message-ID: <a5c37c1d-45a4-429c-bdd3-f68ab5030b9f@baylibre.com>
Date: Mon, 2 Nov 2026 10:42:28 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: mediatek: mt8188: run board_init_f() with the
 caches on
To: Steffen Dirkwinkel <lists@steffen.cc>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Carlo Caione <ccaione@baylibre.com>, Chris Chen <chris-qj.chen@mediatek.com>
References: <20261030-std-upstream-mt8188-spl-caches-v1-0-b45905cb19c1@beckhoff.com>
 <20261030-std-upstream-mt8188-spl-caches-v1-2-b45905cb19c1@beckhoff.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261030-std-upstream-mt8188-spl-caches-v1-2-b45905cb19c1@beckhoff.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 3:57 AM, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> Device tree walks and other setup is very slow without caches, so turn
> them on before relocation.
> 
> On an MT8370 module, from bootstage marks before each initcall, two
> boots each:
> 
>   step                            caches off        caches on
>   initf_dm                        349.8 / 349.7     4.6 / 4.6 ms
>   serial_init                     204.7 / 204.7     3.0 / 3.0 ms
>   dram_init                       162.2 / 162.1     2.3 / 2.3 ms
>   relocate_code                   22.0 / 22.0       0.4 / 0.4 ms
>   board_init_f() to main_loop()   819 / 819         87 / 87 ms
> 
> and from the serial console, after power-on (includes 5s debug usb wait):
> 
>   U-Boot banner                   7346 / 7346 ms    6772 / 6777 / 6765 ms
> 
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> ---
>  arch/arm/mach-mediatek/cpu.c         | 14 ++++++++++++++
>  arch/arm/mach-mediatek/mt8188/init.c | 23 ++++++++++++++++++++---
>  2 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mediatek/cpu.c b/arch/arm/mach-mediatek/cpu.c
> index 04ede8823b07..484a50f0a25c 100644
> --- a/arch/arm/mach-mediatek/cpu.c
> +++ b/arch/arm/mach-mediatek/cpu.c
> @@ -7,10 +7,13 @@
>  #include <dm.h>
>  #include <init.h>
>  #include <wdt.h>
> +#include <asm/global_data.h>
>  #include <dm/uclass-internal.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/types.h>
>  
> +DECLARE_GLOBAL_DATA_PTR;
> +
>  #define MTK_SIP_PLAT_BINFO ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64, \
>  					      ARM_SMCCC_OWNER_SIP, 0x529)
>  
> @@ -23,6 +26,17 @@ int arch_cpu_init(void)
>  
>  void enable_caches(void)
>  {
> +#if IS_ENABLED(CONFIG_TARGET_MT8188) && !IS_ENABLED(CONFIG_XPL_BUILD) && \
> +	!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)

instead of checking CONFIG_TARGET_MT8188, this would become the same config
option I suggested in the previous patch so that we don't have to keep adding
additional targets.

And U-boot preferred style is to use if statement instead of #if preprocessor
for things like this. The the compiler will still optimize it out the same.

> +	/* Deactivate the data cache, enabled before relocation in mach_cpu_init() */
> +	dcache_disable();
> +	/*
> +	 * Force the call of setup_all_pgtables() in mmu_setup() by clearing
> +	 * tlb_fillptr, to use the page tables reserved by arch_reserve_mmu()
> +	 */
> +	gd->arch.tlb_fillptr = 0;
> +#endif
> +
>  	/* Enable D-cache. I-cache is already enabled in start.S */
>  	dcache_enable();
>  }
> diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-mediatek/mt8188/init.c
> index 2e6aa041c38f..139412071131 100644
> --- a/arch/arm/mach-mediatek/mt8188/init.c
> +++ b/arch/arm/mach-mediatek/mt8188/init.c

And similarly, we should try to avoid this target-specific boilerplate that
would have to be repeated for every target.

> @@ -49,15 +49,32 @@ int print_cpuinfo(void)
>  	return 0;
>  }
>  
> -#if IS_ENABLED(CONFIG_XPL_BUILD) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
> +#if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
>  /* Early page tables, in DRAM unused by SPL and by U-Boot before relocation */
>  #define MT8188_EARLY_TLB_ADDR	0x4e000000
>  
> -/* Initialize the MMU and activate the data cache in SPL */
> -void mtk_spl_enable_caches(void)
> +/*
> + * Initialize the MMU and activate the data cache in SPL and in the U-Boot
> + * pre-reloc stage. The MMU/TLB is updated in enable_caches() after relocation.
> + */
> +static void mt8188_enable_early_caches(void)
>  {
>  	gd->arch.tlb_addr = MT8188_EARLY_TLB_ADDR;
>  	gd->arch.tlb_size = PGTABLE_SIZE;
>  	dcache_enable();
>  }
> +
> +#if IS_ENABLED(CONFIG_XPL_BUILD)
> +void mtk_spl_enable_caches(void)
> +{
> +	mt8188_enable_early_caches();
> +}
> +#else
> +int mach_cpu_init(void)
> +{
> +	mt8188_enable_early_caches();
> +
> +	return 0;
> +}
> +#endif
>  #endif
> 

