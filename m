Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A31CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 04:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0269C86E0F;
	Thu, 12 Oct 2023 06:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eU2Ge1RW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8593C86D80; Thu, 12 Oct 2023 06:30:19 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B4B186E0F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 06:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-417f872fb94so4076841cf.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 21:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697085014; x=1697689814; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d7wxEsy7f5GztuJ8S+Buy53wrG3bL7T/mwrR4uENxDQ=;
 b=eU2Ge1RWPl5MSMRoBQMb6MTjjMlHu2XhHWv/0jfOZCk5bz7VjVqNiYCG6oVFzeB7J6
 Voupy8AU3172zfM5D0+v7bYeA4ZvpHZvBha+6kpwB0q/FrciYl/k3TDhV+agMjOEoDYU
 YAp0YHAv6ymrchRfgrJS/iuY1MyD/RuhQwGOsuVtyx8I0LZiNa1CngAloIXCpIUJHwIU
 E1DnCfn5R07RxxaSW2ajRiF9qeaHSKo2iMp8Yr1z/aVK2fq5FwrCE21jcXmXu72e0rmC
 qrzosQXv369Cy4aL72E4aScqbD1NqlMWM+slnuZKQyc/Z2eeKKu63VeEgWx3+Y1aWetY
 spLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697085014; x=1697689814;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d7wxEsy7f5GztuJ8S+Buy53wrG3bL7T/mwrR4uENxDQ=;
 b=WS7lAjfNVC83pXvunxKsOwfMdpzkNhdr97AnC4KEOPI9BlPIfHoUxCHV7fUD6MvxEk
 NdSlfxA4Jx3EExuM8kHT3wn6/JD8fcc9gJ+H7hr4lNoxA9tO84x32aiNuBNhFf0pBtuz
 wdrHcDTqEbOGZF0C7Ofxq9H713r7LJ9TjIvYVsZPUVu1zgNVwmhoEOVFbinbThe6BQgw
 u8spaZh0seKIKkHFNTJQhwDEslvzABL5NiRBjkRrpviFIDiItFkkXl7R9D1v8csI8TTb
 jtZkGJ1+mvdhpW6vimw6GJIk1o142xsvA0TpJh8EA+tC3BAB8w66wfvsqOqxdUb3yF/p
 8zUA==
X-Gm-Message-State: AOJu0YxGsrnseVJLaCIsr7hlvBocxj6+qeVBKTB1jYFZ/e/nv30FSPjR
 280W9fZrWYhgdgHXw1zpozs=
X-Google-Smtp-Source: AGHT+IH5GgoPOlJW8Uc3TGPLszppVp4t8YB6xK8NCdFafNXxlRINx4PDmaUdHmj4R1N6Riz/GAoPnw==
X-Received: by 2002:a05:622a:1001:b0:417:922b:f05f with SMTP id
 d1-20020a05622a100100b00417922bf05fmr25969569qte.57.1697085013986; 
 Wed, 11 Oct 2023 21:30:13 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 r5-20020ac85205000000b004181aa90b46sm5910957qtn.89.2023.10.11.21.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 21:30:13 -0700 (PDT)
Message-ID: <8611e3da-7232-1149-8f7b-7106b6cc9d0b@gmail.com>
Date: Thu, 12 Oct 2023 00:30:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/26] spl: legacy: Fix referencing _image_binary_end
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Fabio Estevam <festevam@denx.de>, Marek Vasut <marex@denx.de>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-2-seanga2@gmail.com>
 <CAPnjgZ07k1UeQDT6Ci9Dhtz6oKajGKoP5zr3-55UNHaJsN28=A@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ07k1UeQDT6Ci9Dhtz6oKajGKoP5zr3-55UNHaJsN28=A@mail.gmail.com>
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

On 10/11/23 23:41, Simon Glass wrote:
> On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> On non-arm architectures, _image_binary_end is defined as a ulong and not a
>> char[]. Dereference it when accessing it, which is correct for both.
> 
> Is 'dereference' the right word?

Yeah...

"Take the address of it when accessing it"?

--Sean

>>
>> Fixes: 1b8a1be1a1f ("spl: spl_legacy: Fix spl_end address")
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> ---
>>
>>   common/spl/spl_legacy.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> 
>>
>> diff --git a/common/spl/spl_legacy.c b/common/spl/spl_legacy.c
>> index 095443c63d8..e9564e5c2a5 100644
>> --- a/common/spl/spl_legacy.c
>> +++ b/common/spl/spl_legacy.c
>> @@ -19,7 +19,7 @@
>>   static void spl_parse_legacy_validate(uintptr_t start, uintptr_t size)
>>   {
>>          uintptr_t spl_start = (uintptr_t)_start;
>> -       uintptr_t spl_end = (uintptr_t)_image_binary_end;
>> +       uintptr_t spl_end = (uintptr_t)&_image_binary_end;
>>          uintptr_t end = start + size;
>>
>>          if ((start >= spl_start && start < spl_end) ||
>> --
>> 2.37.1
>>

