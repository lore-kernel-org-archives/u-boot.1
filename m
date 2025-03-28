Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DFAC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:31:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F0858070C;
	Fri, 28 Mar 2025 13:31:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RioRk+WU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32127810EA; Fri, 28 Mar 2025 13:31:12 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14D5C80079
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so14676375e9.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 05:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743165069; x=1743769869; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4UyAXo2RJukZj0TtZlNUhoMRreDzrfA4L1mAV0/NfUw=;
 b=RioRk+WUwihxSOn88jlrZuv5hgEX3lmEi4bpjK0hjxPpy3MbVp+XervHYVKtj8eo7M
 RTx+7GEiZzsftCRCO1ZOxYRLgilxknwm4DMU/IimJatFczkVI6IPEHnSbxsrf/o4i3CD
 ozY17R7Sn0OQkZLL97lIOPqQUdIB3FLSV+H+W4jeg+NZyL0TBQDVkoaXU7YQ4pIy37kK
 H3xRFQrVylVG15gi/UiODlKKiETZF4Nlmc1xYeo1p6jUT2WunSngJ1KjYsAwaxIACsNw
 fx/37Dsu8/XneiTn6wlYTCoC9C4oHzSWBVvuaQ4L3RgAJxnHYcWtfTYs8T3DTEa1vUwn
 TYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743165069; x=1743769869;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4UyAXo2RJukZj0TtZlNUhoMRreDzrfA4L1mAV0/NfUw=;
 b=Io6HTt3U4iIaI3PpUEhdd+E5bXKYGlIOtVHcbZR8GFOAmDyV66udFbj4SRAp/kibfM
 tkK2HDagApdhbHzBrxNhNEeCm4nBZSEAX3IhNYn2+RNQ/Pn1ZQAU2AumF6Ee/n7mE2Fl
 9/hvqKt7UOi3UUOm2hYSjO9SQxL8iDVAfxGJDwxiz1JefBkerZclodBbaEgGiK7uQk2T
 m5y5jhFPSMtmzUBYC6xaYjVHGTtc/IPqigguMyj4xAXEzgXeFhOyS3RrMPRVes7RnzFp
 S0867blN7/FoTNSEqpQrv0bAPnmz5KDc7RDYoU7Gfp63nltxFYVxym6aL67vGMbeMJq+
 2Ssw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvw0+rIzV6RKYu/hnweR7o5nEf3VKmYbSSvzUviAlysEujZztwgsO80x2EJ5y/K0q1Pag11Uc=@lists.denx.de
X-Gm-Message-State: AOJu0YyuIgbb7wjbnQXQqU3gaBiLGgSCgB6kL/oSdcs0Iw68EHncy9KV
 VVoPjttRHQiZpq/6+Hgnq7UDZOPUSd48+fDiA+LB7Wds7kqpI1R2/G6cYuWkd7w=
X-Gm-Gg: ASbGnctfj4s3HKnbmqgUPRuxbuCvN2H2MUDJ0nNfeNTBiqBrWndtNKIow8drAla9GBV
 zfWp9NcVPd5SQbPUwh0kkdyuEI4rgWBFfkCnsCQ7QhxgmUS3yovSB4SyIW2j/8uDVjm/YLLCPNl
 L/u/HTnuiuCSvWYcHP7Sr9UTDVka40JJ9OK5g9ttC6f9rVoPxM+gt5QxRF4txUs9GqaDJNTjem0
 02dBg70e/raxDwraEpdbFOUMAnkqecPJTS6C/fPDz2Q9qXunIgegN9gno0RZuZ9b7biClDoiXVa
 Nv4od20yKb5yRSDo2jDxK5QpvG+2tZa1vy5WXaHJauSK7YgPGCLqDMsJ8TBkow74OBuZp/p5J6c
 =
X-Google-Smtp-Source: AGHT+IGZF3MFNOQUHHGGH7hr2itWDc+Jn+hsD9AjwWAXXfMutlDW8M+uNzLqud0Pk3PQ+FFfraiXcQ==
X-Received: by 2002:a05:600c:1d87:b0:43c:fe15:41c9 with SMTP id
 5b1f17b1804b1-43d9182abf3mr23310885e9.9.1743165069359; 
 Fri, 28 Mar 2025 05:31:09 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fba4b4fsm26838365e9.1.2025.03.28.05.31.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 05:31:08 -0700 (PDT)
Message-ID: <bd6c671f-a0bb-41b0-92bf-6c02d146a9e0@linaro.org>
Date: Fri, 28 Mar 2025 13:31:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] spmi: msm: fix pid mapping for v5 & v7 controllers
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250328-topic-sm8x50-spmi-fix-v1-0-a7548d3aef0d@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250328-topic-sm8x50-spmi-fix-v1-0-a7548d3aef0d@linaro.org>
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



On 3/28/25 09:53, Neil Armstrong wrote:
> The v5 & v7 controllers has complex mapping for
> different Execution Environment, and v7 supports
> two busses within the same controller so it needs
> some special care when parsing the hardware map
> table to get the proper read & write channels.
> 
> Test are welcome, especially for v5 controllers.
> 
> Tested on HDK8550, QRD8550 & QRD8650.

Buttons still work for me at least :D

Tested-by: <caleb.connolly@linaro.org> # sdm845

Not sure I'm familiar enough with SPMI to leave an R-b, but the patches 
look good!

Kind regards,
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Neil Armstrong (4):
>        spmi: msm: use real number of channels for v5 & v7
>        spmi: msm: factor out channel mapping for v5 & v7
>        spmi: msm: introduce SPMI_CHANNEL_VALID flag
>        spmi: msm: correctly handle multiple mapping entries
> 
>   drivers/spmi/spmi-msm.c | 59 ++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 49 insertions(+), 10 deletions(-)
> ---
> base-commit: 4adbf64ff8d8c730223fd8ae299d770bebb6fe86
> change-id: 20250328-topic-sm8x50-spmi-fix-1e2b433a6ffd
> 
> Best regards,

-- 
Caleb (they/them)

