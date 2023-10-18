Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F77CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 12:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0E2A86F98;
	Wed, 18 Oct 2023 14:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="G61imKWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A10B386F9C; Wed, 18 Oct 2023 14:43:27 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74DEF86F92
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 14:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1D79240622
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 12:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1697633002;
 bh=K3ZboZEL+05qWcIbHP87wt3joY+swzZMAeeVhbq0JOw=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
 In-Reply-To:Content-Type;
 b=G61imKWlboDcMjDi/2SoU0nWmUzKHVdARuqwkL5mtU9CNwjzwR1fyv5hAxm8t2+g9
 D/HsL8Anh3b5wRJ8OluipT3Tx0GeGZYUpj7e1JTbCg83VGiA/LtbM3f0kq+o/JzYg7
 a9g3LDfry62Xo84QOjumycVPxAFx39QKRBQ6AixBadRC7D6FfZWUd/FWBS08XPvM7N
 dkjkImZLdQXxeCgcsiJGNvwR+8nx6sNEJH0ca6p58XMSRT+v5SDvzhZGmbUm3N9iDh
 hHrASuyj9mJWc9PvViw6ek+yeiRmKx4H08DxbO4XsDbautnOZ6N3hPDlK7+mjUMi2N
 QOeN+egoanTIg==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32da7983d20so1975836f8f.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697633001; x=1698237801;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K3ZboZEL+05qWcIbHP87wt3joY+swzZMAeeVhbq0JOw=;
 b=Xb8+Gd3679CfZstDFNlJyYmdcHIIgpvUMREdGb0yNbQvwUFT9dcVDWljZgpCS0VViB
 klvUjskj9XwKaxUAimJyeCRspn/HIvCt/Rl01j668v2vwmi4rtW6MqJkTj5737r9bSNq
 VJkWN6DZx6WvxF1ulOrLOgtjhXQmpTJvsn3pkOuMfwJgiaiw4Ofy/PkqZLZhh3AY3qh0
 DhnkACE2qel6eyrZaPRAY2Bwv1rc/pkaCeK3lGxvt6iQ8UAXGVHQ25Gn0FRnZ8XTOSFw
 Tj8m8gdt+rLFtUfpffv3c0R2IaKGMoa/sr2OqWCZ2LLGIbJ/QG0fREprTjL889pzNVGp
 BJTQ==
X-Gm-Message-State: AOJu0YyQTJGgKJ/d3mUSvFm1nJuUijix/gRB9BiINirivpaxWI80z/wD
 6GX6KCQwnkwYggUDYsSs0+SwN/q5sV3YJvretBsBndjvbOUL6EY0c7BrrAlzEVlpSYMfNo6ODOu
 QFoOJ0TUoyfyF75+0Ul+xestSMrQ3vBF0XUea/1A=
X-Received: by 2002:adf:f5c1:0:b0:32d:c705:3e5 with SMTP id
 k1-20020adff5c1000000b0032dc70503e5mr4474244wrp.15.1697633001655; 
 Wed, 18 Oct 2023 05:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFm0Mw/fnZrMQkVt21gWgw9zTUD0jngwIFZnIPqpNVyss0BjthHdm+jDJN7doEGwpMb2OpFg==
X-Received: by 2002:adf:f5c1:0:b0:32d:c705:3e5 with SMTP id
 k1-20020adff5c1000000b0032dc70503e5mr4474216wrp.15.1697633001310; 
 Wed, 18 Oct 2023 05:43:21 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 y15-20020a5d614f000000b003142e438e8csm2039100wrt.26.2023.10.18.05.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 05:43:20 -0700 (PDT)
Message-ID: <57d4b769-3bb5-4fb3-afa5-43321b8598ce@canonical.com>
Date: Wed, 18 Oct 2023 14:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sphinx: Bump urllib3 version
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
References: <20231018123348.3676562-1-trini@konsulko.com>
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231018123348.3676562-1-trini@konsulko.com>
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

On 10/18/23 14:33, Tom Rini wrote:
> While unlikely to be a direct issue for us, urllib3 before 2.0.7 is
> vulnerable to CVE-2023-45803, so bump our version up.
> 
> Reported-by: GitHub dependabot
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>   doc/sphinx/requirements.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
> index 6d45a3fefffe..39ececb96c2b 100644
> --- a/doc/sphinx/requirements.txt
> +++ b/doc/sphinx/requirements.txt
> @@ -23,4 +23,4 @@ sphinxcontrib-htmlhelp==2.0.0
>   sphinxcontrib-jsmath==1.0.1
>   sphinxcontrib-qthelp==1.0.3
>   sphinxcontrib-serializinghtml==1.1.5
> -urllib3==2.0.6
> +urllib3==2.0.7

