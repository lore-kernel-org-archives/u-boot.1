Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1955ED59F48
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 16:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71FAD88F92;
	Wed,  6 Nov 2024 17:00:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="wBNugmEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A21088F92; Wed,  6 Nov 2024 17:00:42 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A846288F3D
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 17:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1D15E3F84B
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730908838;
 bh=6t2t1NNq3CWxX95OUZ/CPsRa+SUMkWnB06CxejNu7/g=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=wBNugmEeZSfMi0oYycQ+cYtv/djAKcINeVD2ov0qHPxxD8ZwVYIXHGLhT08VFIHxy
 VlKqmqvQc8mJ6iV+urVgp6VETqSiDz71pJmxiDXer2ajD/BhB58NCx7D42YhGAst+Z
 pvzB/3NGHDAes4MFpQyFhqpV9WGDrkd3rGp9IIEdMoVENqGB0U0MCAnhvabR/cgrIn
 u0h2p7y/aZfpDZowvhoneOkeSkdmOIk54do5OMgm7RN0NwljRIra7jMbSy56Np/WcH
 0gWAfyY0ZFgO74MuOkHxpnj0TtQODOz67xc1kcBBdJNfFFN2Ths9lXyn1RiSUN/4UM
 rpsatFDIIfkng==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4314c6ca114so50400495e9.1
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 08:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730908838; x=1731513638;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6t2t1NNq3CWxX95OUZ/CPsRa+SUMkWnB06CxejNu7/g=;
 b=LTCGQ1MSCaZqmbRIDNauWE7AP06zzc9ApKqxFQDIxafRFCPdm3BJqhYA+MN0mrhNj1
 zo8b21Jc8b3eEK8bHMU6F1IFYy7U4HFwt4n5kZQtu/BOGoL/Up4e9i52YAizarZtQq8h
 idTkuqjMk7VZaL5U95KJ7sySPrW0HWiFbMEDjzQFTDEzv9dH2fLCyYBdXRlzxbJsdoJ6
 9hpIUZOc6USe5JnHKEWFHZelBTBvSCzJLkpq+twOtNjinWlenEW8LrO6bdR6EaU9WUlT
 KIPtp5Ld31yFLouWt7kXciO40QsEOmDYV5Xp4Kxor/y85zyz7Pdx6UpTarSFEU4x3P6l
 hT6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiWpx7hbYSQUe7NCPMhK3honBJnHfFwOKMcF2wG7WTK+YylQELJqwnL/tsvCJKuhYzdNZBvEE=@lists.denx.de
X-Gm-Message-State: AOJu0YzA1DsnxpKIKPZeBqbQ3v7siCoUbxLAAmNsLvkq5rtNj7XbskHa
 XB/BmHlvvMm05zUSK+Yu/ZW5/KQgNldVllL7od278SFHTAac60zBs/JkYNLOjPVdqS6DeMj1UXx
 0MMHE92Yev0zDh7tgEcZAJ/qOu0kp3QiG4ptBwPKj47rkvG2N6A9x4YdaE3XrINr8Ag2Ew/03YJ
 3Smg==
X-Received: by 2002:a05:600c:354f:b0:42c:b5f1:44ff with SMTP id
 5b1f17b1804b1-4327b80ce01mr197556505e9.24.1730908835048; 
 Wed, 06 Nov 2024 08:00:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu5TAnrin3p0bneM3sV1Bzg0ehN179uYMY1RMfuyC17Kf3F6JwSkUBQ0EAiM+Hh9JNlIw8/A==
X-Received: by 2002:a05:600c:354f:b0:42c:b5f1:44ff with SMTP id
 5b1f17b1804b1-4327b80ce01mr197556045e9.24.1730908834615; 
 Wed, 06 Nov 2024 08:00:34 -0800 (PST)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5fb1sm29581995e9.8.2024.11.06.08.00.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 08:00:33 -0800 (PST)
Message-ID: <3cda4d67-4ae6-4449-8fe8-6a1eb4c89c0b@canonical.com>
Date: Wed, 6 Nov 2024 17:00:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cmd: upl: initialize unit test state
To: Simon Glass <sjg@chromium.org>
Cc: Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de
References: <20241102143020.129450-1-heinrich.schuchardt@canonical.com>
 <CAFLszTi1r18JmfdZtFLOrUPa1G0m3r5NPajUadkO5tGqXXNTDA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTi1r18JmfdZtFLOrUPa1G0m3r5NPajUadkO5tGqXXNTDA@mail.gmail.com>
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

On 05.11.24 16:12, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sat, 2 Nov 2024 at 08:30, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> do_upl_write() calls upl_get_test_data() which may increment the fail
>> count in the unit test state. We should initialize it.
>>
>> Addresses-Coverity-ID: 510465 Uninitialized scalar variable
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   cmd/upl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/cmd/upl.c b/cmd/upl.c
>> index 4996f36c787..c9a823bbc06 100644
>> --- a/cmd/upl.c
>> +++ b/cmd/upl.c
>> @@ -50,7 +50,7 @@ static int do_upl_write(struct cmd_tbl *cmdtp, int flag, int argc,
>>                          char *const argv[])
>>   {
>>          struct upl s_upl, *upl = &s_upl;
>> -       struct unit_test_state uts;
>> +       struct unit_test_state uts = { 0 };
>>          struct abuf buf;
>>          oftree tree;
>>          ulong addr;
>> --
>> 2.45.2
>>
> 
> This already exists. A memset() is in upl_init() which is called from
> this function.

My patch is about initializing the unit_test_state variable uts (and not 
upl).

upl_init() is called for upl and not for the unit_test_state.

Best regards

Heinrich


