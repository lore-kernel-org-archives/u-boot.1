Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83EDD3B7F4
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1413288D56;
	Mon, 25 Nov 2024 09:56:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zCnxGJh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 090E788815; Mon, 25 Nov 2024 09:56:35 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 041C8895FB
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa549f2f9d2so140401066b.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 00:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732524992; x=1733129792; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Z6/oRnMffVhBAcZR9TPPrjFHTugsG+81tcott3kFns=;
 b=zCnxGJh37P4tGnPxbT+KMz3A1JjdCi6vH/gyevrGW3NoMMeSVHFF9U6qUJxyIGCD59
 /vlzy/+5cUC5skqr+LZ0qCbe/lJ0wPx6onZog9yyYgTAhrBS5aa+FlXWc148FhQXIsqZ
 Av3a9TDN1amMLwAl4ANqc00J+ttc4eBRaNgyM7e1TIa5i/jnyA2UW31L4PTp1D7sP2PX
 fl3UreseoRRsh2PFpDEMLpFq+KCxOqbhKxpRPWx2dThvSxgFZ9ziX/3lDLoN2MZZxbFH
 7RGS8uW0CWInuNSwg7yIYNn6B23K5YClFEKAJGKbhexA9kr+k7OhAN4/sxE/Qe18QuNT
 yS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732524992; x=1733129792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Z6/oRnMffVhBAcZR9TPPrjFHTugsG+81tcott3kFns=;
 b=B3IHA62HDck2mOH67OqpH8i+e1olTsHHuRrkudA2StLMXaequw3gWLpo+PtS+7Uj9W
 8MtBhTl6u1gyrG921v6gPU22nyT3ffQ7WKv9YOPXBzmkBGX47xLM4aEy4OatVSgMzx41
 TmfBeV+sBdvTOa80Et3q45uHwmQCbwkaOfdtGSETsrpXparAz+tMhuRfxw7kSVV2JWc0
 XM910uER9gJgNRt0pxNZHKvXyoJQYgxDNNAtobixGbiXafNEvAJIOLOjRXoPMCnRrBKd
 hOFshtSj+CA6iplFn2bfRuPM+2yPAiqs/pq5Od+uXV9CaIBmJHsJdQkykaQ1X4eqtTXM
 vUhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpWCpliH5lFnGYQPZDwneIVodQxDmaIeANXQH+d6rQKCetfRTXrMXSE8DwejrA7IapSQnS7z8=@lists.denx.de
X-Gm-Message-State: AOJu0YzWtYYqcUia+Yj0KUpyfpPSHpCCyByDyp8+TcOwbvyokgCpKHFW
 374mEeRWiJ7MjdeULcVWglCrd3atlmmnMqvI95Bwa/NeZawr+P1sWcWz+h2+MIQ=
X-Gm-Gg: ASbGncukLx4kWUsK5btL7JtRzO6eBC4S63Z2MT9T9xYtH8OkMeE7f5rte6gKcrJBqmD
 12imA/zEe6cN4uecAUiEpgUhcZjGi42IHiIBlqDoK3fu07jzhJLphccSrrsc3OR0I7NZ/R/sH0y
 uoNJKV1rmBm4QLLObmHPo0+aGaiKtml1yjLocpi7EKnm3CxaXhcNqFe30rM8OW/rGrJOudRiYQ8
 Ep0dNwxswgm+zsrlS5OqAHC1jJ0egDy2FqSMqOOZ2WYTVes1jsW2qgAMoNpCaJEorz/eAdeFhk/
 7TJMuv32s2oi7qHZqpYtC93cfmSr0A==
X-Google-Smtp-Source: AGHT+IG7CITgR5By5yUKEgykGgC/AI2AGtq0xl7womz7KkdCSS9uf8DmDP6tThjOyo7DTPv0x3hJhg==
X-Received: by 2002:a17:906:cc9:b0:aa5:459e:2db with SMTP id
 a640c23a62f3a-aa5459e03bcmr397708366b.53.1732524992461; 
 Mon, 25 Nov 2024 00:56:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:208d:e9ad:3f7f:556b?
 ([2a01:e0a:3cb:7bb0:208d:e9ad:3f7f:556b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b52ffe3sm443563766b.126.2024.11.25.00.56.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 00:56:32 -0800 (PST)
Message-ID: <04d797f8-1004-41c0-b395-8310a8315571@linaro.org>
Date: Mon, 25 Nov 2024 09:56:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/14] net: wget: let wget_with_dns work with dns
 disabled
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
References: <20241125005814.236669-1-adrianox@gmail.com>
 <20241125005814.236669-2-adrianox@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241125005814.236669-2-adrianox@gmail.com>
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

On 11/25/24 01:58, Adriano Cordova wrote:
> This was marked as TODO in the code:
>  - Enable use of wget_with_dns even if CMD_DNS is disabled if
>    the given uri has the ip address for the http server.
>  - Move the check for CMD_DNS inside wget_with_dns.
>  - Rename wget_with_dns to wget_do_request
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
> 
> (no changes since v3)
> 
> v3: 
>  Removed console output inside efi routine.
> 
> (no changes since v2)
> 
>  include/net-common.h         |  7 +++++--
>  lib/efi_loader/efi_bootmgr.c |  2 +-
>  net/lwip/wget.c              |  4 ++--
>  net/net-common.c             |  2 +-
>  net/wget.c                   | 34 ++++++++++++++++++++--------------
>  5 files changed, 29 insertions(+), 20 deletions(-)

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
