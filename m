Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAADC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 18:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 871A387DE3;
	Tue, 12 Mar 2024 19:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WP9WXrMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 602DF87C86; Tue, 12 Mar 2024 16:51:54 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF53D87F16
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.henderson@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dc1ff3ba1aso174735ad.3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710258710; x=1710863510; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yNG88tuUhCLTwDobEsgLhUoIXnZmG0E3LryYft1Yfxs=;
 b=WP9WXrMItiX+B4TXGOEd9LQeTse/gNy9B51OAAAvfYNbFPjqKDZ9Yx6yNfB/AD2JI8
 6tBGMo4JaM4FFHtJ5PQXxKIUvRfjAteVxMrnwL3S8Fo/0c2etvkEN3N7t8RT7bZAsaTA
 66nwrMsZ04VF5c6eTAV0NGt6rSmAR8eMddznzoZPKgQV9jGyG6RdreZabbM0YjIyFJbJ
 BGGHx4a6mVn8sxSgi+H/IdVSHBXZZFtekXiTu6Dozkw4peQ2/X6UVBlwlovGZBZbncDO
 hd99dKpDTQAhXppDI08FbYOVlnNm1wZ+uzCZ3bYWPmScbSSgrvtNGNmxxt0DfYWjNq7F
 B9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710258710; x=1710863510;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yNG88tuUhCLTwDobEsgLhUoIXnZmG0E3LryYft1Yfxs=;
 b=AV8ZcyHd8Wq013gL5OQqHl9VHF0/bIVTUHtLOaxRZ008VRcBCuLzmg9No2Xqew3ndB
 6G8EMMDcxG7lDozGJNg3ol0Csmd5vamORpBpbq2q6vmADISg4PGoJkg/2/Mny86WJ+RS
 9bM0zh5bvDLWuehMbWIgvvOzovinxkJc3Ums2KmPt6Ef0RH1C4wvAjb6wHUvfAq9wmwS
 Q157MwMNTGbb+ojptjKjYDQ4/BZVpZ/Cj0nKmH1o0IRMxnYPP3Zhp9nxTuBUcztinWdL
 1Dk62xM1E3JgReOd23jfl34lZj2Wo14VA4DMGVgyGRnzvSuVSmnrKu8X68yzql5g6L7v
 LksA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUARK+xgq+kwMd4FDjZfrhkrcwA8/PccMr715qKOwSCyI7NcK+cNgDXxp0zJhe9zRaeNAw5tA0qASj8YyEMxt/cSjaPZg==
X-Gm-Message-State: AOJu0YwjmSrVkRNWlTlbBGqJ2sYm/nZA1O7Cap3CAibVNwTmlaMPwuIr
 hGB3Ul+MfQcrI6d8YMd6HRgg+ResYvpuQoMATnZJIjaU5fkHGnta3JzZXZpIKlM=
X-Google-Smtp-Source: AGHT+IF34uhn0DKDDjYw6PYkaoijjn8feEy8ITThM90YbLeqMQ3m6NWR9BOnh6mVb9bTx87oh09vhQ==
X-Received: by 2002:a17:902:f552:b0:1dd:8a51:7b17 with SMTP id
 h18-20020a170902f55200b001dd8a517b17mr747940plf.8.1710258710060; 
 Tue, 12 Mar 2024 08:51:50 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 b5-20020a170902650500b001db499c5c12sm7029459plk.143.2024.03.12.08.51.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 08:51:49 -0700 (PDT)
Message-ID: <f3b6a70b-8476-4542-9429-67d5d34d27ce@linaro.org>
Date: Tue, 12 Mar 2024 05:51:43 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7 v2] arm: clean up v7 and v8 linker scripts for
 bss_start/end
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 trini@konsulko.com, cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
References: <20240312140832.1968215-1-ilias.apalodimas@linaro.org>
 <20240312140832.1968215-3-ilias.apalodimas@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240312140832.1968215-3-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 12 Mar 2024 19:54:32 +0100
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

On 3/12/24 04:08, Ilias Apalodimas wrote:
> -	.bss_start (NOLOAD) : {
> -		. = ALIGN(8);

This alignment got lost.

> -		KEEP(*(.__bss_start));
> -	} >.sdram
> -
> -	.bss (NOLOAD) : {
> +	.bss : {

If it is required, the best replacement would be here on the output section definition.

> -	. = ALIGN(8);
> -
> -	.bss_start : {
> -		KEEP(*(.__bss_start));
> -	}
> -
> -	.bss : {
> +	.bss ALIGN(8): {

Like you did here.


r~
