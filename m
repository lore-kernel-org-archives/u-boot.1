Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38780C77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 23:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A11782977;
	Wed, 25 Jun 2025 01:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hAQSz7+n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A3D82C84; Wed, 25 Jun 2025 01:06:06 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD576803CC
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 01:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8D2533F57B
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 23:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1750806362;
 bh=VSqRQGsR4kssC/HaGHOubUgmS0zEOF4PJVVPzXHjgKo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=hAQSz7+nL/t/Ig1Fb85MUlYh8xWPTk44F4DMuEYJINyg4uJJfWiPCxIII1VgPWwaV
 Bnrr6sUPhQWUzGjJkDpcXrgfCmSnO8UWsgznNvNzOI16/4jUA1TiWcCmsaVx5jw3xy
 /se5aE3kaEgod8TuK+hQVTM4x4do3dsdTRkUTvqY5gbjBAPG7NpvXk1Plt+ZlMUSRF
 +IieXAhgXq+oaszWJPjoXVKrMIXQHn7KapsmDLtK4jBYniZ9U3qYM+QSDsF1QqIgGz
 emKUlBWlPFeHRVZTXyfLp6tStNcv6tFZZ6Ok8XYUouF4avrpDo4keHwMLQpzsDM6vf
 1C/CJKPU8KdWg==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45311704cdbso39683905e9.1
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 16:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750806362; x=1751411162;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VSqRQGsR4kssC/HaGHOubUgmS0zEOF4PJVVPzXHjgKo=;
 b=fTagr3miSHdRaLmRqgfHtvxAHdYuCflk1ibEEoODS0Sywiip13zH6anXIgO/YfoL3T
 8cTbmtQnc4HFetkzZdoJA54w4eZypoOzb/jAjMm2bug5nYfapBbH2YspOoe53LuGM6GC
 x26ZZJrloqyfyA6fADlHr4BPFlBOTLCq76hsziQ2nXFg/w9n1S3A7G71LpRfQHIuOsKw
 oE8mg8zmJI8X15kK2n262OLLcjM5JtkyyDjQgORuSxXT3J3JG7aLrM2Fx+lpVcEdURfJ
 lU5DtH+DqwJKs8GIllVLMpBZQStMqB5T8T6rB45NQyoYofndduaf2+JRbMB+3ujb0Is4
 p9Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ/Swem8w0Eij05LsLLX3C6nItDnBr8ONxfAV9a5NJqDO8uRy7tkIR/XjtpcAkVR3RDWGCeiM=@lists.denx.de
X-Gm-Message-State: AOJu0YyiLa7yRHoD758hAdiBvlbNK2QuFcugsUSySwhsk2kjAjOaZ7eL
 y4Q8DFz3lBI761uFcnh1JE1q/0P3uhmqkgJFUPGu5PXr6H8DtPd/So3FnF/+CO1DTgEGEtd8Kbk
 9PnIFjTpiqSSiNOtsRN6YF9KVS4f6/JXgizH/hGg9eSBXlUA+EsR0rUTMwcLyjAATj4fGB5I=
X-Gm-Gg: ASbGncu+4/I6svHgXiLIYn+2pFdznCDUlXMrD6gpbmy1YDxAU/6HJD3ZktQ41hfs7S8
 6LNd5KCVlKJ3GZ85NrKZPEJArstaK6ScEJHFCOH6+/DAoDVpA9f1ZEpiajhxDCxmM8w8hBDtqL6
 kb57H6/e7kapeTEGHs/y6XeuAnGvXmodfnjhb+wEYsqTs3IVCG2jw2haglnF/liw2AsCCSnXsWe
 769d8WY6duuFkQwJ2jC5NnXY0t+YWgciRW9sl6srxKBeQatUZkR/zjQl2rs99NcQGBQXT5/z8Dg
 0Cwm5eGo2dDV8qKT5/mZurNklwR8X3yzYl/1AczdEgilnCYkfJBV7l61bNUDGz2NmoxWEy4g96b
 qiKrUrTW6+U/HNDoRrd8=
X-Received: by 2002:a05:6000:2c0d:b0:3a1:fa6c:4735 with SMTP id
 ffacd0b85a97d-3a6ed64506bmr449629f8f.35.1750806361986; 
 Tue, 24 Jun 2025 16:06:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjyMimoak9+Z3Fq81ZiCUEmP/cWIFnuL1mkpYgbIexoC8cquffP6Q2GHmJKrlFCsAya7MAJg==
X-Received: by 2002:a05:6000:2c0d:b0:3a1:fa6c:4735 with SMTP id
 ffacd0b85a97d-3a6ed64506bmr449614f8f.35.1750806361611; 
 Tue, 24 Jun 2025 16:06:01 -0700 (PDT)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8051677sm3032391f8f.15.2025.06.24.16.06.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 16:06:00 -0700 (PDT)
Message-ID: <3637667b-d7af-4e2c-b79d-fa20fda232ba@canonical.com>
Date: Wed, 25 Jun 2025 01:05:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] common/spl: guard against buffer overflow in
 spl_fit_get_image_name()
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Simon Glass <sjg@chromium.org>, Sam Edwards <cfsworks@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20250624153431.46986-1-heinrich.schuchardt@canonical.com>
 <20250624153431.46986-3-heinrich.schuchardt@canonical.com>
 <62500d98-9489-49e0-9c34-b8033c708687@iopsys.eu>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <62500d98-9489-49e0-9c34-b8033c708687@iopsys.eu>
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

On 24.06.25 23:05, Mikhail Kshevetskiy wrote:
> 
> On 24.06.2025 18:34, Heinrich Schuchardt wrote:
>> [You don't often get email from heinrich.schuchardt@canonical.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> A malformed FIT image could have an image name property that is not NUL
>> terminated. Reject such images.
>>
>> Reported-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   common/spl/spl_fit.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
>> index e250c11ebbd..25f3c822a49 100644
>> --- a/common/spl/spl_fit.c
>> +++ b/common/spl/spl_fit.c
>> @@ -73,7 +73,7 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
>>                                    const char **outname)
>>   {
>>          struct udevice *sysinfo;
>> -       const char *name, *str;
>> +       const char *name, *str, *end;
>>          __maybe_unused int node;
>>          int len, i;
>>          bool found = true;
>> @@ -83,11 +83,17 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
>>                  debug("cannot find property '%s': %d\n", type, len);
>>                  return -EINVAL;
>>          }
>> +       /* A string property should be NUL terminated */
>> +       end = name + len - 1;
>> +       if (!len || *end) {
>> +               debug("malformed property '%s'\n", type);
>> +               return -EINVAL;
>> +       }
>>
>>          str = name;
>>          for (i = 0; i < index; i++) {
>>                  str = strchr(str, '\0') + 1;
>> -               if (!str || (str - name >= len)) {
>> +               if (str > end) {
> 
> and if strchr() will return NULL, then str will be equal to 1. In this
> case str will be less then end, so the loop will not terminate.

strchr() searching for NUL will never return NULL but search until it 
hits NUL.

And as the patch adds checks that the buffer pointed to by str is NUL 
terminated we will not read outside of the buffer.

Best regards

Heinrich

> 
> 
>>                          found = false;
>>                          break;
>>                  }
>> --
>> 2.48.1
>>

