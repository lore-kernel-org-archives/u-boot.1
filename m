Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0BA606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WWvrvJ0s;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=SnGDVnCY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D60FB80E32;
	Mon, 16 Nov 2026 16:43:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5WYj1pW0CMBm; Mon, 16 Nov 2026 16:43:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3BA0D80EB3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794847425;
	b=Yv2kuyFIAyrbA2lQn6U26ERROrm8DmdZhRPqrwK0XeCAC+wqcZr++DfTJEj8lbnYYoRr
	 ANgsmqN4HZ3FlhJih35oknhcro9y0KfsQ5kCKYHOLcLO2LKn1GkkA6gisHvK4go+jWD/Z
	 BlQkii8kE2pSp6faPjOnTNv20fxk+bZoPDgBUpkbtM/+T0bpRb+rAtfmod39yDlnWlhe6
	 Djzp8uiAe9yEz/eDS6FuiH3dL0xCfhKmeUCvVGv0AdfK73e6hzhq2JLE8ZiEbwygjcQrx
	 htR1dTr9eNo6tG2bmUHUyyT1DsB5L1LQWsHdMo8zjwGvXpptrbw2OH3dl3QMrSEEgMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794847425;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d5jmKbeuz1Nx228j7ud5N6Nh73HSwmPMVKf3pYajnbU=;
	b=k+wBZK2JGi8vbNoPzqh/saymGomQb+jrxiYNksDzWwGyOLhjrLExLDl+Py0s+SJuNeBo
	 haOyuP1qGnbwcf73hvxKpoyPSVZpvS/HKxvB25L0RPFvcK/VIOsVaDi/DDNGmXgMKEyGx
	 uKEClyHH0ss0w008L2rHUPwMAb347c+9t3OPdFoW/dwl+WJH0fPy2liyojL1YWvG9d7CP
	 A1RYmzVtKFShOCR5XNXL75LmQaKSSVmhqmg29TdjcEyYjpGwbUESVCWoGllb7fSpVnIwM
	 yIbtYnhHH7J6/E2ps5GkY1uCXDwPn3t5nifCMjhEvEp4mkx7y8/l79g5UxrXaCB9FFw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794847425;
	bh=d5jmKbeuz1Nx228j7ud5N6Nh73HSwmPMVKf3pYajnbU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WWvrvJ0sfnrX7/QTAHrDRpcOXE9XzseeImAnMihSvOzn0gCR4zMhJJYxkdGyKad1B
	 lw4eHk9haNmvbYKcDsBZxfxqig8U8lWRBjq5aeishdyV1SaWzyY2BaOkdBTouh1h96
	 jM9HHDfjJVB8NKhbg8kyOKN5vjEx1Q3JMf2r+EMEZO+CZmBumvMnHKig6GrJ1/K9+q
	 LuWTx5j+SDrwkDseVbt3jUQr2tZna4yPRtxE7yauIDeF1AXdp/jFLJKfzzrBt8VfSI
	 QjO5H+IeNrVg3pjVXz+MaW8OvGUWTM476auXS66CBe6dBzj3kIKIATO06M5OmkwBZy
	 o4qhk3VsYeltw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BA0D80EB3;
	Mon, 16 Nov 2026 16:43:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4ED011E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34B92607EB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kE1tMoqk--be for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:43:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8722B607CE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=SnGDVnCY
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8722B607CE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:43:42 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-71ada4644f8so998731eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 08:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794847422; x=1795452222;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=d5jmKbeuz1Nx228j7ud5N6Nh73HSwmPMVKf3pYajnbU=;
 b=SnGDVnCYm5cT2NneNlqP5rRlXLgum+vjrHqPdyDBitGyDyox4uun4vpZC7gAY9DNRu
 da5Ln3c8ZcdZql0wHOOcbiqPClDKBEm3diLpNPERFJ2++mD4Ps7t0rohsWKx7wxPp9sW
 WAGzz79ynRCrCB1Di5/Ait1HZ3RpgioI2XI726MDRNyfpWWUrYsS1wNVcuwcUDynvKY/
 LrP9N6jaubrYe7ooYguVzjjzHgar46xgwToMqzLlRvhQZSFaBXilpp2yt7b7AMBU99Ud
 00lmP0nHrWH8Bzdjy/k0W1BjojilKbSvN+IJlUD6vHveYKNq0x4bxzDyCdrgaQGfM4uB
 AKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794847422; x=1795452222;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d5jmKbeuz1Nx228j7ud5N6Nh73HSwmPMVKf3pYajnbU=;
 b=lpOqeqfMA5DTUmHmYJziVU06n+fthbBQigreS8ToRbzsazC6o0msrqJ9D0JMXwoyV4
 isfyvxvz9QDw1ylSpE42cUvCyoT5JuD/zYNC9pCy+NfSR+xl9KmobmYHnSTG8gb4F1R/
 D0F4Rw2SCzSkpgW2aoxo53dmyGZhOR1ptekL90H76zunDw5g3iveMYeOE/js656R/C9Z
 IgvZpXtVHdXdXZ0oxxKFRqLujhchNLdv1bctO+4/AFQCmiv97/LlCVEEfSpXkGCTnm9z
 3hpytRS5F2Zsbv34uQYEfbORp9EihYLhXZ7tfNsDqtg/YAC9ZdnBBYDNWIB7eQxdPlTF
 8vNw==
X-Forwarded-Encrypted: i=1;
 AL+hErEOvlZ9YZreYNaBlUvubv6twI4aYnKI+9Wqcpbjl9nA0nZ2aSngoUGjJsx/ZbmK8LzkQqgtOvw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+jHaRlpH0oA9eytp49bA/lJP+76QggOCixzi6tBb4dnKziOkun
 JRCut+DQjaKBxM9hW3F5A4KVrYMnUU58o7AN+DKxXXOw0zNloyHIIPoeFso3YLFH6Bw=
X-Gm-Gg: AYBFou1TkcietZRxFE0wvbhK9fZuHbEFM432c1BZvr9HdBPW1KrRjHPw0djJCQkFTDM
 BwHnSGrnzIzeOspi9Ye0I0Js1i+Zoo19VXfqkKdTD4IXncD+3ieEApFDA4SyfbgnWui5Zg9r/n8
 JSCtDc1FCIh63VKMAAAlkLINB4lf1iq1EFtnM7B2wFJbNNtObXMzXjmP6IBR7/ZZyodex4swpjJ
 O9zqMcNFSdIzche2j2Qb503TMr6FbLLaBcg3OcYMqq+pp++jO2M5TtAg1d/PCeUqP4MKzDI3Xnx
 T908Le/1SlomXTIGPvntVv0hROrXcRl0ocVBiHckDfH2fSyIkMn0jmkJ14ARcsmeapWeP+Ix+Zm
 5NM6cJy31/aQc6/kp2VAMSdr2nw8ipmKrETfz5hJNTlhwn1CvYeOPnnhCLmmApYyc6TeykE5IDp
 76b/k4O/8v+mKKywysk+v2wJB4d6GcglR8tDgVFnqQcqJ7VcgXGWjA3KvPfD6Bh3SLl6tswMCPd
 qfxc7CYZO/P5T69IzMeuq0fCIBt3M6+xaWxiDSfVTWwhjLgEYdMkpVhivEfv9T6J6RN5URVr9tb
 YT+xNpNjRstBIYlkYdcLuc89hv0O5KWaho+IUhLFgJCkuOF2I6DSqQQ6N8MbR/JMUoeAyRqQOpR
 A80Mt
X-Received: by 2002:a05:6820:1355:b0:716:bbb5:fd2 with SMTP id
 006d021491bc7-71ab4fe0ec3mr6955983eaf.51.1794847421817; 
 Mon, 16 Nov 2026 08:43:41 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7056:3b5b:7d85:4921?
 ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4afe22f8a17sm7034119fac.15.2026.11.16.08.43.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 08:43:40 -0800 (PST)
Message-ID: <a8d398c2-dc1e-470c-b194-b2fc606fd8dd@baylibre.com>
Date: Mon, 16 Nov 2026 10:43:39 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm: mediatek: enable the caches in SPL
From: David Lechner <dlechner@baylibre.com>
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
References: <20261109-std-upstream-mt8188-spl-caches-v2-0-78cfb3e90c55@beckhoff.com>
 <20261109-std-upstream-mt8188-spl-caches-v2-1-78cfb3e90c55@beckhoff.com>
 <26e0a77c-5188-47c1-a1e5-4caca8fd082d@baylibre.com>
Content-Language: en-US
In-Reply-To: <26e0a77c-5188-47c1-a1e5-4caca8fd082d@baylibre.com>
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 3:46 PM, David Lechner wrote:
> On 11/9/26 9:13 AM, Steffen Dirkwinkel wrote:
>> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>>

...

>> +/*
>> + * MMU and caches before U-Boot sets up its final page tables
>> + */
>> +
>> +#include <cpu_func.h>
>> +#include <asm/global_data.h>
>> +#include <asm/system.h>
>> +#include <asm/arch/misc.h>
>> +#include <linux/sizes.h>
>> +
>> +DECLARE_GLOBAL_DATA_PTR;
>> +
>> +#define EARLY_TLB_SIZE	SZ_32K
> 
> Can we get a comment that explains why this size was chosen?
> 
>> +
>> +static u8 early_tlb[EARLY_TLB_SIZE] __section(".data") __aligned(SZ_4K);
>> +
I was doing some testing with this and adding this to the .data section
makes the image too big for the SPL download agent that Carlo has added
recently. So we might need to use a different way to allocate this memory
in SPL vs. U-Boot proper.

