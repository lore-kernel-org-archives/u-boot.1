Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F181C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 07:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C308682C87;
	Mon,  7 Apr 2025 09:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HySSADR4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A6BE82CA2; Mon,  7 Apr 2025 09:08:52 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7595C82C55
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 09:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B6B3A3F592
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 07:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744009729;
 bh=R0k49nMS7pIeHcCMiWeQ3L4Fy1EkqcoBSBxZb5Eioic=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=HySSADR4UD8zqWw+rqasjLWMHGWbsPr80f8Wfs3YxchFQ/4qup6qfFrQmjyhy7yEM
 xtACfImUHBto+JjbHKGv5A6SnGx8xXkFATS2NZtDerScxe6y+mQeJWncl9dCQOeF1L
 YBmOE5WUPkiDAGZIry5y8rLDWEaYawb8nDTfECCkx9HWIV9GxLF5GvXcgdCL1HzCDv
 LXzG1/QCOO4q9LjmNkQkQOBT40mkITMp13RS2FdbLHaMfZJ/1srp3weGaNgruibvud
 /Ik0B355SXGFnbz+5NLWX/EWDtYMZKMlZzcwOn2M9IZmZpgNIiOfV5Y+pJ65UeFxsf
 J320ME1YvR+Kg==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab39f65dc10so530157866b.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 00:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744009728; x=1744614528;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R0k49nMS7pIeHcCMiWeQ3L4Fy1EkqcoBSBxZb5Eioic=;
 b=nIDHLMFhUihRGGSrBq1cmHTYowr1q+/2NPXvHzHqRgKnYKUZu04gU1xaSaIasgL0rl
 /nSm67QqQ2JhStsXrfopk8/AAwlWEE/DiAzjacGI6P/ATyEwGzcXvG2KGbsVBs5LMuq7
 npw5rxyf0OhUwPoi3hBiyy7lWjHr1h7C7qy2qaZTK5oEKLmNJMPW4SeDntpUaKkCquoQ
 fE413qT7Nydnj+npwU/Qxu0F49QUSdHenK4qJ9T5ac5OMUni989nB0QVSwr2uEbiqCCJ
 Se/qSwey2iYrE4dw80u5LlxurihxX1zVqesr5SadKN6CRNA5lL7Zcv8pDi01lRmwDN9N
 8qIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5EaLlwyXdf5WL9hPWHqVGLouMxyM+y8a8u8gjXNKaS+i0+89Sxjqv2jlgzvIDtIJCHOKWQIw=@lists.denx.de
X-Gm-Message-State: AOJu0YzTRIlQUTSIh100WOFK4JUZLckAD6GxFgShGWlyVXDcfvJEwf65
 9AorNYNhKfVf61sPl4xvFEKutbSb519yUCjaxGRRdatUq5pA5Y/vIFE8Fpjm1uJCEM9ipUrQu14
 2t0Tm+SDED2oRNdyMTKZcOFwQTPtpHdKvZgDkKkKWdTfnWMVUFUCZQGdiabcfJlkzask=
X-Gm-Gg: ASbGncvgD0qubFDIEge2higLBVZe2zob8qgUgaWASycPgPIfgjtGAZepyJnc5lSmJp2
 22IEaWe6HCZT0WbMvDph19q6jM6SEAlu1aYXAwb50UOZcaA2+parEhfdorFWMzjtihqlXuBklV9
 0irV5cd8cCbeuLSo0P34NV14uiu8MOGx6qStsYrLZdG7316y5E6Rp+70JP4/p4aw/e2kvo7pCE6
 p5/MsSeCxy9q5eb9UGQLlued25rapKp3jsm6GdjE8qkFYKP2x89ApXzJvYjkDputZSvtfmgwh86
 imr7eA3M/cOXEZst0lZhH+WlA5MLt/8MP5tLujuKjxfKHFp/ZW3ZGwIzG3b1Fq9MUvjFbFo/eJD
 6YnyGWA==
X-Received: by 2002:a17:907:3da2:b0:ac6:bca0:eb70 with SMTP id
 a640c23a62f3a-ac7d1b9fe8dmr1065518866b.56.1744009728191; 
 Mon, 07 Apr 2025 00:08:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlz/qItP/4Cte+l9I7kYdfB/+Unx8YD+n0y4JFv6s0gqfeFw5F0C+tckyLgrSUrHuxlDeOxA==
X-Received: by 2002:a17:907:3da2:b0:ac6:bca0:eb70 with SMTP id
 a640c23a62f3a-ac7d1b9fe8dmr1065516166b.56.1744009727821; 
 Mon, 07 Apr 2025 00:08:47 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:7a3b:d0e7:2fbf:d22c:a220?
 ([2a02:3035:6e0:7a3b:d0e7:2fbf:d22c:a220])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c013e018sm694696166b.115.2025.04.07.00.08.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 00:08:47 -0700 (PDT)
Message-ID: <3c246a22-6128-4208-9396-d33ba69616c2@canonical.com>
Date: Mon, 7 Apr 2025 09:08:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] buildman: update PyYAML requirement
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250407064713.71814-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250407064713.71814-1-heinrich.schuchardt@canonical.com>
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

On 4/7/25 08:47, Heinrich Schuchardt wrote:
> On Ubuntu 25.04 installing the dependency pyyaml 6.0 fails with
> 
>      License classifiers are deprecated
> 
> Update PyYAML to the current release.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

This patch only applies to origin/master. Buildman requirements do not 
include PyYAML in origin/next.

Best regards

Heinrich

> ---
>   tools/buildman/requirements.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/buildman/requirements.txt b/tools/buildman/requirements.txt
> index 052d0ed5c6f..a6b1aecdbe0 100644
> --- a/tools/buildman/requirements.txt
> +++ b/tools/buildman/requirements.txt
> @@ -1,5 +1,5 @@
>   coverage==6.2
>   jsonschema==4.17.3
>   pycryptodome==3.20
> -pyyaml==6.0
> +pyyaml==6.0.2
>   yamllint==1.26.3

