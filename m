Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5382CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 08:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C225B878A4;
	Mon, 23 Oct 2023 10:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="N75iypx+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD88C878AD; Mon, 23 Oct 2023 10:21:53 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D8987890
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 10:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6144F3F140
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 08:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698049306;
 bh=DhkWHcdLXK/Jn0kLhERoIGt/H51BtTsL5bzmb5w2HX4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=N75iypx+PMoCANdf7KQ5nll3fvC99jipIYE5ROCmLqRMgCq9lwK+jUczvKwvUU8ZD
 SfxAcZx+Hj0EVmaahca6AjxJWLIGvkqcdabDfxEpu/1KiuUAnTLM5RSs3flBj82+JZ
 DebF4eWkhEBvZWISlxHYH4t2Q7FWDGblkpgPQfsvXuHkYyKMEEtHn03wFcOAC1mXJc
 xzETyvg/sY/IY9SAuG+8yMg6mpgp/SIrQfCxYNoZgnG7cMAUP1CQo0jIacZw1JxUXI
 GBH7L98C6WUNOxUXlxCYbmW/bLxMIjAAjiLzqquoH8V1G4Pv5yN448LPwze1fhC5+j
 UjaRkKCjeO5rA==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4084a9e637eso19417245e9.2
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 01:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698049306; x=1698654106;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DhkWHcdLXK/Jn0kLhERoIGt/H51BtTsL5bzmb5w2HX4=;
 b=u5ZBVDl+77Zpk/CBLZKSTF3cC6HhKH63bRTJneo7t7EKELNChJQPDgGCg4sryDhrlf
 2IPvIUgNCAqEUtJrg+MijTdndO/FowvHyZyGTWG+X0Vz+xMcvRZW5VLYbEstU6E9Ej0v
 BRh4cY9KYYIAqLk4KKopYuAOEZm3qPcMDIfErmRNDbfG0jkKZopMfy7LfRGCMmrntbRN
 wUTGIroCCqEaRudBYv3xzpt0uFKKbbaHMKh/q2Wx67R+V8B2/F5TGJ9cu9LXVitpdxqx
 ZZmVPCq1gODJhhZaIOcSAFHHkTFQKaOLtvpXRhFyIUaux3KeECHx8qw9feqmD2ymw830
 ckyA==
X-Gm-Message-State: AOJu0Yx+kLFbagz+zrgDgIVsjJozIZosevLbsxBFZfmkQa0Cc5I9nD4V
 NLhpf3Xx0MXLuIpNjZVj+0v4/V5VD/j07xyti7L2oi2J3EGA7XidjfbgFRffn4DKPGgWy5GP6LB
 zS5cAi51gl8M551QYuo6yUtEn1+cy86Y=
X-Received: by 2002:a05:600c:3b99:b0:407:5ad0:ab5b with SMTP id
 n25-20020a05600c3b9900b004075ad0ab5bmr6622212wms.8.1698049305986; 
 Mon, 23 Oct 2023 01:21:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8LuPGK4a4cpyQLo4RvW9nS/xe5AeWVSLC26jZRmwJleOTegqlXpoV/2x54X/yIyCcKvuBFA==
X-Received: by 2002:a05:600c:3b99:b0:407:5ad0:ab5b with SMTP id
 n25-20020a05600c3b9900b004075ad0ab5bmr6622199wms.8.1698049305538; 
 Mon, 23 Oct 2023 01:21:45 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 q6-20020adfb186000000b0032326908972sm7304796wra.17.2023.10.23.01.21.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 01:21:45 -0700 (PDT)
Message-ID: <62d107c2-7e24-4ae0-972d-9995b796c9f9@canonical.com>
Date: Mon, 23 Oct 2023 10:21:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] general: fix GPL-2.0-or-later SPDX headers
Content-Language: en-US, de-DE
To: Simon Glass <sjg@google.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20231022174707.72695-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3q1im+5GwvZ_U8KMERFczD4EbR9T9gG1aeKews3yyZRg@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ3q1im+5GwvZ_U8KMERFczD4EbR9T9gG1aeKews3yyZRg@mail.gmail.com>
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

On 10/23/23 09:05, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sun, 22 Oct 2023 at 10:48, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> SPDX headers should use GPL-2.0-or-later and not GPL-2.0+.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   Makefile                                                   | 2 +-
>>   README                                                     | 2 +-
>>   api/Makefile                                               | 2 +-
>>   api/api.c                                                  | 2 +-
>>   api/api_display.c                                          | 2 +-
>>   api/api_net.c                                              | 2 +-
>>   api/api_platform-arm.c                                     | 2 +-
>>   api/api_platform-mips.c                                    | 2 +-
> 
> In License/README it shows the identifier as 'GPL-2.0+'.

I know. That file needs to be reworked to remove the redundancy with 
doc/develop/sending_patches.rst (which has some inaccuracies concerning 
SPDX) and moved to HTML. We should handle it in a separate patch.

We will need separate patches for LGPL-2.0+ and LGPL-2.1+, too.

But this should not stop us from merging the current patch.

Best regards

Heinrich
