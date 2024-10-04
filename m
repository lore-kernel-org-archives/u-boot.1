Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB3CCFA74C
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 08:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EBAD88F4E;
	Fri,  4 Oct 2024 10:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZDEld41g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB3EA88F94; Fri,  4 Oct 2024 10:01:32 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCD4988EAB
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 10:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8d60e23b33so256609966b.0
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728028890; x=1728633690; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R8+647AMTomFwpTzQFk/YyOJLqP9urO8E1HcLpOj3Hs=;
 b=ZDEld41goB76LPGuoNt9lrjqSSdNzuX72yJ7iHaEmPTB7Ip1ei0d4+zFdMumSITw5c
 4cHIYLLRt+k6yw1Q11Mk4luoAHgL0bp8Xa1y96kYQvGRo+MZ6QlAyClJGSkq48jVMhEe
 0XIffwfoHODO+QhUamJ+htwmus5TyL0EwYryqmsAkWiyJqFA5k5LCy539nZfkok7dgMe
 3GYuaZHkxT/LHSt30hGVD4w1oUxgeu5dYewBVJtTFj8OoLPzaz6M9k1PuaQmj2uAAq1K
 /LrmgsLYytNiS1LFuDgcd9DLsKSmyM6zrYwfLQ5wpF/K1YkafgzovXLzvtscr/Z+ZYg3
 6TLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728028890; x=1728633690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R8+647AMTomFwpTzQFk/YyOJLqP9urO8E1HcLpOj3Hs=;
 b=KSk6MAtAt9CEaRwmRzO0PZsr2sodkOnuOA0J90C3J30Q7eMbcsDYoQxteuSsPJPCSZ
 WniuzReMf2a88OZqCyXpfLcKoqj8BvSKh2QGDqeZ8tJyEd6nTwRlbuo7XesgcGVLRKrn
 L6zzjP9RdIq8/VjCpKqY+pOH95+gRB3yXFL/0tr91qVMrVIj1HJyAEfy2atNXL2Q9cpE
 1b7R6CWXDWsGm47ybPn5frWWnEYvMCWMtaTy7rAmEewLMoyYeujKnjuijnsbFqUtuELL
 YC/HHip/WCsi85EH+ZEdDvi44ejNHnkt5Ox6m4nKr8K62P6CiG3KPxnANLlfK+sbhkE/
 718w==
X-Gm-Message-State: AOJu0YxvuxV447lb22Wn5AkHQIdQCLj200aZJqpJVeAaAfMb+7cJvPA9
 SlIyaEoQkDEMMGtKmo00heGDfpDC3AmKSIZ7WPYvJAqMvVihH72GdbF6wwVtSgA=
X-Google-Smtp-Source: AGHT+IF98lnAQxVFkwiGXJaydR6+UYRyOjlXbPuztdsd0C3RWCYCpDBOy9xk5SmzcSKRgU/S1lGKJw==
X-Received: by 2002:a17:907:f788:b0:a7a:8da1:eb00 with SMTP id
 a640c23a62f3a-a991bcfdb73mr166516366b.7.1728028890175; 
 Fri, 04 Oct 2024 01:01:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c79f:f6d3:6b70:dbe?
 ([2a01:e0a:3cb:7bb0:c79f:f6d3:6b70:dbe])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99102a4b6dsm190255766b.58.2024.10.04.01.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 01:01:29 -0700 (PDT)
Message-ID: <6fce4ddf-611f-4cf6-8de2-ee60ba81fe1f@linaro.org>
Date: Fri, 4 Oct 2024 10:01:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/29] net: move copy_filename() to new file
 net/net-common.c
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <bc7f7365861fb75269f30300d341dafea92d76b5.1727968902.git.jerome.forissier@linaro.org>
 <CAC_iWj+w7YV3W-hMB+X_pcE8vDs8mTwyo-c7feS0e7nvop8Ubg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWj+w7YV3W-hMB+X_pcE8vDs8mTwyo-c7feS0e7nvop8Ubg@mail.gmail.com>
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



On 10/4/24 08:52, Ilias Apalodimas wrote:
> On Thu, 3 Oct 2024 at 18:24, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> copy_filename() can be useful when NET_LWIP is enabled, therefore
>> move it out of net/net.c which is built only when networking choice
>> is NET.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  net/Makefile     |  2 ++
>>  net/net-common.c | 13 +++++++++++++
>>  net/net.c        | 12 ------------
>>  3 files changed, 15 insertions(+), 12 deletions(-)
>>  create mode 100644 net/net-common.c
>>
>> diff --git a/net/Makefile b/net/Makefile
>> index 70eec8caf0d..a9cecee637a 100644
>> --- a/net/Makefile
>> +++ b/net/Makefile
>> @@ -42,3 +42,5 @@ obj-$(CONFIG_CMD_WGET) += wget.o
>>  CFLAGS_eth_common.o += -Wno-format-extra-args
>>
>>  endif
>> +
>> +obj-y += net-common.o
> 
> This seems to belong in the net-common split patch?

The patch you're referring to only splits the headers. But yeah
it would probably make more sense to do this as well. I will combine
the two patches in v12.

>> diff --git a/net/net-common.c b/net/net-common.c
>> new file mode 100644
>> index 00000000000..a7f767d5e9c
>> --- /dev/null
>> +++ b/net/net-common.c
>> @@ -0,0 +1,13 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +void copy_filename(char *dst, const char *src, int size)
>> +{
>> +       if (src && *src && (*src == '"')) {
>> +               ++src;
>> +               --size;
>> +       }
>> +
>> +       while ((--size > 0) && src && *src && (*src != '"'))
>> +               *dst++ = *src++;
>> +       *dst = '\0';
>> +}
>> diff --git a/net/net.c b/net/net.c
>> index 1e0b7c85624..c1d10a77b9e 100644
>> --- a/net/net.c
>> +++ b/net/net.c
>> @@ -1689,18 +1689,6 @@ void net_set_udp_header(uchar *pkt, struct in_addr dest, int dport, int sport,
>>         ip->udp_xsum = 0;
>>  }
>>
>> -void copy_filename(char *dst, const char *src, int size)
>> -{
>> -       if (src && *src && (*src == '"')) {
>> -               ++src;
>> -               --size;
>> -       }
>> -
>> -       while ((--size > 0) && src && *src && (*src != '"'))
>> -               *dst++ = *src++;
>> -       *dst = '\0';
>> -}
>> -
>>  int is_serverip_in_cmd(void)
>>  {
>>         return !!strchr(net_boot_file_name, ':');
>> --
>> 2.40.1
>>
> 
> With the the above fixed
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks,

-- 
Jerome
