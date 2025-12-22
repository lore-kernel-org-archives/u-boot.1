Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118FFE6748D
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 11:41:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A7AA83D3C;
	Mon, 22 Dec 2025 12:41:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="I655xJtn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1DDF83E88; Mon, 22 Dec 2025 12:41:50 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4FED83BF1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7F0083F66D
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766403708;
 bh=witEHh+5uuGQdCNX01xDBehLeW56KVRRVwOuArqifhs=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=I655xJtny9Us9mC4hgbPnRtk1UuPJIspPONz5jg1MlliLyerVAZWYX/kSd0J+myLI
 dOIQDTh9kC/6jQh6BNGnrACP0jQ2ONTbH3DZkpy3wEjVZjN6SSHi5DVIw64X+cbw3M
 TE9S+HOkwwYN9iX3snZ/HJrkEWB0YETPJK3r2FmqEsOv2X+CKpxYVeH9NJJHQJqqXi
 vzEjxB2PJLLlGwZhq1neiCq/xCLTh/gPwRxjRI5oJxhQUSVI59F1Un9Ym6fDG70mEV
 t56XTO7L2EwYjZ+MWeitkVd3Jhzo7LG8Cj2SGgZcv6pqBPTfh6AO1ho+Wpj+nCJ4Pe
 PlEj3imD5bXYgzUjWZQak52KWBUqaOYXvxh+xy7s1s/ZkQQ+lHVUM5lPKm/REsjzBj
 xCxiUlLdcyFaiszrB52KIuWm/xBXELnf+SF/kar4YV3/3z7W+uEzu7AM5RSLGH62JH
 qwpnoNQaPGcVwolam+Fj2z0mOWnNNqO2dJAmIEnKWVXVjMdXCwwJxAzbS9ap7EKnF1
 aYzinPS8qk1DxIO2gnvEmCEVKVOuca0pJKc9GtCtHcicScgL+3AVsaOZZaJu2aXJua
 KdTBF/UG4GqGeX8gj1DAAbyqxt+ASME6MLiFQqvxGRj97RXlj/Gna+fh35xPFeywLx
 5vpRoQB33rBoY6pIoy+EYcdg=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477a1e2b372so29577445e9.2
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 03:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766403708; x=1767008508;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=witEHh+5uuGQdCNX01xDBehLeW56KVRRVwOuArqifhs=;
 b=Qe1EPDg31bvu/550/HyHUBHZrSoLm8fan6IE3GCof+kJAzrU/Zh1+B/uMxxVq2D58d
 j14yAMwi7SBw2x4hbT0bpn2yEp+J7Dw3vDRN6ZOyJtCgnbSzq3sQPpko2Exew36nS0MX
 tQm6mRwS33QQNoZqQrqgW3HC4WwCxZhfzkqAHLFINL1poiRJTqdS54bToj4c8raIE8Rn
 NkWlRUEGmGZKXMjHjwLTgbCsOuxPeolgFHvwfzvxlUez0dOimiZTfLDqLHFAUTCIxfn7
 3kQMMnXmAdPoi+rftEOfC2X+b7oGQua/d30FB0n4qJzJj/1sRHGIWP60OUrxjcQwgcXP
 7f7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs1/mmQADqRWnX8uHK/MJZ/z9gpmJJoKYI5cjaXJbi1k8rKKGQgwPwUxiEGR7Cf09HJdEzx8U=@lists.denx.de
X-Gm-Message-State: AOJu0Yy13B9KaYViCmkGbwwMLse/MM74paqdmpb0L2ZlRAL3DeFmaCZz
 BeKbxd/2HAcwwchA0YF+yzcnZ0ykRJVY2rEkJTbUkdtsoLqNjQnjAiVtoibjEanZNiSUHB7G2PN
 oCercFmDKxS8Q+XqG5wLfpSI3Z+smh4gL7oSrom0fRPy9ggBYToB8hrmHW7X+MkXzH+RNJOU=
X-Gm-Gg: AY/fxX5a7Y/3ByJPHCYAer2V61nKvnPppNi9k0008nPBZyPyTSORCLcFWXCP32Dp0Rc
 i1VrR5cMzke2D6TdwpEe+6Job1EW+YB3x9EYFaXFVX3b+VmsHxcDeHI9eUuG953H8WLi/x2Doz6
 j1zWEN/q1eWCRRxk4gZZ9Ngj2K9rCFDW+6GoSBRvyI5Bhbd4RlFuizO6zoFup8UHqIRGkCZik1x
 QQxujV1GFzKYSfykE2K5SHg8hE0iA4tbvRddeHOUQ9/rUyeF2dvdRZmYHuLWGOPwXHALYzmzsI8
 L/xMfvpNfoK0n5INPYs3GZuo14OIGXy0CYOkhJYYj/TZKubDhX3bCQPdaLCpD9aET57csFTg8gS
 YoyEiSdQJjwf5nD94m+flPsTSmC2cAdgRxOm2EF0QkGeS1Z81p0WZT1Jt3h2Rskn321O/Afa9hi
 idDnewiFg=
X-Received: by 2002:a05:600c:8107:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-47d19595f6dmr115885445e9.17.1766403708075; 
 Mon, 22 Dec 2025 03:41:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzmvgkMeDmdM1DyKy57QKdFVuDbjJPzcKG0KpDBc3cY8jL6NJXzpct4dDrUx2dtqSRHaMABQ==
X-Received: by 2002:a05:600c:8107:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-47d19595f6dmr115885105e9.17.1766403707714; 
 Mon, 22 Dec 2025 03:41:47 -0800 (PST)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea22674sm22262204f8f.10.2025.12.22.03.41.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 03:41:47 -0800 (PST)
Message-ID: <1626dd9c-30ca-4275-9688-b79a8110ba01@canonical.com>
Date: Mon, 22 Dec 2025 12:41:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] test: The LMB test depends on CONFIG_LMB
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
References: <20251219224326.195190-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjL94aX+9dGfYsG6ut0MSXB97Ta_C20nkj1SEeQGiErSiQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjL94aX+9dGfYsG6ut0MSXB97Ta_C20nkj1SEeQGiErSiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/22/25 09:17, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> On Sat, 20 Dec 2025 at 00:43, Heinrich Schuchardt 
> <heinrich.schuchardt@canonical.com 
> <mailto:heinrich.schuchardt@canonical.com>> wrote:
> 
>     We cannot build the LMB test without the LMB library.
> 
> 
> This was always building LMB. do we need to adjust any Kconfigs with 
> this change?

We should be able to enable CONFIG_UNIT_TEST on any board.

Many boards use CONFIG_LMB=y but not all, e.g.
amd_versal2_mini_defconfig. Building this board with CONFIG_UNIT_TEST=y 
fails:

aarch64-linux-gnu-ld:
test/lib/lmb.c:411:(.text.test_noreserved+0x428):
undefined reference to `lmb_free'

With this patch on top there is no build issue.

Best regards

Heinrich

> 
> 
>     Signed-off-by: Heinrich Schuchardt
>     <heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>>
>     ---
>       test/lib/Makefile | 2 +-
>       1 file changed, 1 insertion(+), 1 deletion(-)
> 
>     diff --git a/test/lib/Makefile b/test/lib/Makefile
>     index 7c9dc180c8d..f25383a40e5 100644
>     --- a/test/lib/Makefile
>     +++ b/test/lib/Makefile
>     @@ -16,7 +16,7 @@ obj-$(CONFIG_USE_PRIVATE_LIBGCC) += test_ctz.o
>       endif
>       obj-y += hexdump.o
>       obj-$(CONFIG_SANDBOX) += kconfig.o
>     -obj-y += lmb.o
>     +obj-$(CONFIG_LMB) += lmb.o
>       obj-$(CONFIG_HAVE_SETJMP) += longjmp.o
>       obj-$(CONFIG_SANDBOX) += membuf.o
>       obj-$(CONFIG_HAVE_INITJMP) += initjmp.o
>     -- 
>     2.51.0
> 

