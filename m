Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4515BC2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 08:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA7C81E72;
	Mon, 19 May 2025 10:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Noj8uwta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52EBA8277D; Mon, 19 May 2025 10:52:56 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 578D6803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 10:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so32994635e9.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 01:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747644774; x=1748249574; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oWUSfOGPdEcW1b4od35IGq01NQuIsRvYaKofMgzcUo4=;
 b=Noj8uwtadQ+GPfOivW7V4FSnsHiFoDq4oqbjq3Pb6buDGv4ErxKjxth2Wl0w0rAA2Q
 JNQ1YTl9pPpu3BUIJaY1zAt9yXj3G74UgjOSnZzdAW+TYlaDeHcbGk5ffBIk5zaJPTeJ
 lsAz8yRfMKkIFxPvYmowhc3Sbrh7cmp/u04aFzAghGSD6QX8u+R0sCByqIwAqVihqIHC
 A4wI4CPTqev6+e/0wM5RNNCmv8H+gGzty6/d4s+iAtZNVT+OALtLYSLrqcp5GXCehAhC
 gtYcYAc1El2cb1FDLl4aCJVAABZZH5q1v09p9eqhm4Sa27vYO76PScw70Y3RTOVu5Pv0
 PSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747644774; x=1748249574;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oWUSfOGPdEcW1b4od35IGq01NQuIsRvYaKofMgzcUo4=;
 b=m8exZ3Mx2EH9OOwoFDtVgKSD6KT1SYfdpgjCqN/XxUU6Ie35GqRZC5iKWWb/X2H/yr
 LnuTbbhmvnE09uRHOHcU8JXZ34Ug+rDF6SrD2/5rP+zwDFKFM8NPBG1oAa0YWoA5BqZC
 UGprA4tIjwIQsy2HgblFIH29c7HnYxQzE5mPl8+dXoWgsEnyGgEdZbUSEXfPX1ufgdnI
 iTpRjmn1bv15eacmaQdSSDTdIHcHGMagNYcaVlD2gp7mjV2NMQdle5nn828j6Xp+eSOp
 fCdeLhFvMgY1OFhPWZjudjv2gorI0udGsiCTm7HYFx7GfmjPPtDfwsjtPNitD/NTlpig
 7umg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTzevLevXV6ieaErRiL7QMus1pqYtJQr0jfuiAv31aMJ5jxnl6C9OHR7EoiRj992Kn8U71YoU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxqdk5fPacMcRIVFUsr1bVKX7OfXfgKAVGWgkeIL0w/yFBv1h7k
 wt3PfK8PQW3nvMk/IF2+0e17jAobwU2WT72RFSNGqNV+CXp8xTxxuSyGv+QFqO2OA7tUEEH/x1O
 rxG2P
X-Gm-Gg: ASbGncub9eh1g5lfPErm60Gt9P5GSCT5FRTBFC8Pxv6T7V/B4dD7YqzSYOet5UrQ/In
 eHGacjkyoW7TJ/N4HTCa+TRP2dWAPXsPQVDbaNCH1ksHfg+t442yeOj+lNamJgHtllFNhgP0bWT
 JKotOlOhtiGc2MhEXysQSPsL16rGowojsJNt27rVLG6G25vnmX7d9c633HWBFp7A8eAxg6caoH6
 HJAFW5hLRv75O8p97sJzwUnmyYlTjE91C8ZG3uBUrvP4SQdKGFP+N/XI5ZuIAw1fH+EKTuazBeO
 O/UOEmDsCHQwc0hvWK5JT2kBcc1BfvXKiFl71ZiocLrs1IDFhDTAO2a/YtmeGCX7e78zZHPjWzq
 yHVpbWGHNSsSC+lPMXDW5lE9TrH20pLk=
X-Google-Smtp-Source: AGHT+IHpxFaM926ErKk9w81k+F5DcRiu3PDsTfzL9lu81YPrtRRYFRQ9W4mzeTve9T4Dks9mz3R3Zg==
X-Received: by 2002:a05:600c:4e42:b0:43c:e70d:4504 with SMTP id
 5b1f17b1804b1-442fd64dfccmr111709195e9.19.1747644773762; 
 Mon, 19 May 2025 01:52:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:f675:6612:8685:2dab?
 ([2a01:e0a:3cb:7bb0:f675:6612:8685:2dab])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd59704esm130150825e9.36.2025.05.19.01.52.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 01:52:53 -0700 (PDT)
Message-ID: <75018ba4-8d4e-4d5d-9faa-813e6d14fb4a@linaro.org>
Date: Mon, 19 May 2025 09:52:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] env: Fix network support when CONFIG_NET_LWIP is set
To: Benjamin ROBIN <dev@benjarobin.fr>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com
References: <20250517200930.78975-1-dev@benjarobin.fr>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250517200930.78975-1-dev@benjarobin.fr>
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


On 5/17/25 21:09, Benjamin ROBIN wrote:
> When lwIP (CONFIG_NET_LWIP) is used instead of legacy stack (CONFIG_NET),
> environment flags support associated with network was not built: restore
> support of "i" and "m" environment flags.
> 
> Signed-off-by: Benjamin ROBIN <dev@benjarobin.fr>
> ---
>  env/flags.c            | 10 +++++-----
>  include/env_callback.h |  2 +-
>  include/env_flags.h    |  6 +++---
>  3 files changed, 9 insertions(+), 9 deletions(-)

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
