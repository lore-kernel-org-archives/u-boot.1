Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B40C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 18:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB80D8718A;
	Wed, 31 Jan 2024 19:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kLu/tPSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E54B86FB2; Wed, 31 Jan 2024 19:02:48 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E2FC87078
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 19:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CE1063FE35
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 18:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706724162;
 bh=qI6AtNSEk03npfFDfz9lbDgCIvMwyJEkaRuEHSp82CE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=kLu/tPSwDZHRmoF9QyivbB+qbPNqn/DoeqNamPpBtxTkCylBbCOLPyCfehuYFwLd5
 42Gu6+va5/IyhSpCG3C5kGrWowVg74kBc8g8cJ8opWLywdczHZP/zx74E8nZZI6F2j
 uVvn1dTW5b+xCEHQ4zobrvaDd2sYZWlMIwk+K06JRLFofsVCyMeuvhr2bjRcaOxKFh
 FxcslKT/cqEgmZX/xp/PfzXV+2a1DUYYdonr2pRlupExsJiKXMMDugXvf89EraF+sw
 FYRPi0oQlnpHSouNR38q5Z2BcQZ1j7fScB7Mjjf6RN4caUU23yyA7f8hj3pXp8Rxm4
 QV8XKeAL6uayA==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40ef75bea84so451355e9.2
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 10:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706724162; x=1707328962;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qI6AtNSEk03npfFDfz9lbDgCIvMwyJEkaRuEHSp82CE=;
 b=Jrxnw9rmiASMlbYl5Ak7NiKFuj66bjGOZ/onVm+zAAZLDM6LJBPJMSaJFwG4shplVf
 dvI9vYTEF+06pG7SOGaYwlfGP3OvJpH59GZW4+9eTpMjI3RiBeWQj9f8A7oi7DVlpthe
 zawV/FtJQLgGV3czzFpD0mygQ0qTYqQ3nIWQbXsEWoC+UnFkDwOLb53stDGLcc5S3BIJ
 VLbFRfPG8YgVe4bVcQxxCQglrY4lDFxEUnwM/qi8dJjsdkAbuf7mhUDm+1z48bbtuVwh
 jjlVx+hqrTihvPjPc7o4kbySkqFqv6Jn6wfG82Z9T/63aIKaaOn1PpVLEDrHNX0ZlCNl
 wI2Q==
X-Gm-Message-State: AOJu0YwuW7jVAwqDPIRd3YNmKDDXtOD9Y+53gHh4eW454fjykPKp+Wxg
 2sDhzw2+y3U3YVSK7O7WBp5OPEJBaj2jF0PhyUI/5B5qjGddWlEzTIqIaMsLFVJlelyegPJyncQ
 /2vogtQGa50AVF/c3BZyXL1YpAdw1zpcWA/YfK7S3Uo7EOGWMUut+VM+VY0AZrnxqMnM=
X-Received: by 2002:a05:600c:3b93:b0:40f:b64e:d28a with SMTP id
 n19-20020a05600c3b9300b0040fb64ed28amr1358912wms.10.1706724162414; 
 Wed, 31 Jan 2024 10:02:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfDkaHAfqyrCHF02f0Rbm/+rAYHF8oR170QcHaLphiKUhwM0pvoUKMaK+kRPST/tjIj/bRFA==
X-Received: by 2002:a05:600c:3b93:b0:40f:b64e:d28a with SMTP id
 n19-20020a05600c3b9300b0040fb64ed28amr1358895wms.10.1706724162029; 
 Wed, 31 Jan 2024 10:02:42 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUSOylZQ36etOKcnvSALhjMsh/AMK/EDhGdctxuG9Kt4+zFFhA7M0ZQ6zlksjsGLHsCW0S4psVQdUxWJ1PKzxwkn7p3AsJm+aTJHkdqLJEhp53zcPXQ5cBJ39KjPXkeBmwqMth0SKnC0XpeH2PgvN9l7p5JaVyrmz8y14RKDwOx/z9WTXy3D5bykR8Fg0sdforhjRUr1NXAw20bBH8gKcwqrL7f+6EVgj4WdDWd
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 10-20020a05600c22ca00b0040ef8aa4822sm2184503wmg.38.2024.01.31.10.02.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 10:02:41 -0800 (PST)
Message-ID: <47db57e3-300e-44a9-9304-84a4607cd3fa@canonical.com>
Date: Wed, 31 Jan 2024 19:02:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] smbios: string table always needs two terminating NUL
 bytes
Content-Language: en-US
To: Matthias Brugger <matthias.bgg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de
References: <20240129210453.31070-1-heinrich.schuchardt@canonical.com>
 <20240129210453.31070-5-heinrich.schuchardt@canonical.com>
 <ZbqAP_PL9lidp5ru@ziggy.stardust>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ZbqAP_PL9lidp5ru@ziggy.stardust>
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

On 31.01.24 18:15, Matthias Brugger wrote:
> On Mon, Jan 29, 2024 at 10:04:50PM +0100, Heinrich Schuchardt wrote:
>> The string section of the different SMBIOS structures is always terminated
>> by two NUL bytes even if there is no string at all. This is described in
>> section 6.1.3 "Text string" of the SMBIOS 3.7.0 specification.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> I send the very same patch some years ago [1], unfortunately it got
> somehow lost. Happy to see you trying to fix the same problem, so:
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> 
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20210406090435.19357-1-matthias.bgg@kernel.org/

Thanks for the pointer. I assume not answering Simon's question lead to 
your patch not being merged.

To answer it:

 >> But where are the \0 bytes
 >> actually written? Perhaps that should be in smbios_set_eos()?

We have defined SMBIOS_STRUCT_EOS_BYTES as 2 and we have an array
char eos[SMBIOS_STRUCT_EOS_BYTES];
at the end of each SMBIOS structure.

We call memset(t, 0, sizeof(struct smbios_typeX)); for each table.
This is enough to ensure two zero bytes exist if there are no strings.

Best regards

Heinrich

> 
>> ---
>>   lib/smbios.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/lib/smbios.c b/lib/smbios.c
>> index 7bd9805fec0..81908e89610 100644
>> --- a/lib/smbios.c
>> +++ b/lib/smbios.c
>> @@ -311,6 +311,9 @@ int smbios_update_version(const char *version)
>>    */
>>   static int smbios_string_table_len(const struct smbios_ctx *ctx)
>>   {
>> +	/* If the structure contains no string it is followed by two NUL bytes */
>> +	if (ctx->next_ptr == ctx->eos)
>> +		return 2;
>>   	/* Allow for the final \0 after all strings */
>>   	return (ctx->next_ptr + 1) - ctx->eos;
>>   }
>> -- 
>> 2.43.0

