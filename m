Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AA0C28B2E
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 08:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98355811B2;
	Mon, 10 Mar 2025 09:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w8MG9t+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A9748122F; Mon, 10 Mar 2025 09:05:33 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7313E80107
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 09:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac27cb35309so228463266b.2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741593931; x=1742198731; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1XKyO3fPMPnghjFiJ5cKfRfBIM9V0zBFRK4BpGzKk1s=;
 b=w8MG9t+hg6HXzRLUOOUQXYysheuadPFmK8h8wgojXYETDOkcOXvqBsRxorB3loa0RH
 GMQPGmuVYFfp9S4EXKGcd1uK9Fss/qHhKA7Hnnz9vyPHZRGXFEZu3UYYPf/qVQlqMGMZ
 I8m8ludAUx+faZlQleXjg/MvG/Jn6C1Kpw3TVZKdGywAXLlJtaMdN3OTC/j6uPcZ1lwi
 4aOw0wERLOpQJc/R+AJ7ioc0xQvn2wd6RORKByz9bQRX7JpwtzKNYI8jlHckMrHt+xxl
 bDqSoqNzEBwLswCcdkn/atD4l1TeKcB7F7opdx17O1BhPOC33yhGWhNq8VLX5mXzl2LH
 VtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741593931; x=1742198731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1XKyO3fPMPnghjFiJ5cKfRfBIM9V0zBFRK4BpGzKk1s=;
 b=lCJNJ6dAPlIFO/eyWGz/MdTVzUdLGTY2O5729x8+qXL55XxOp4jSw0YhNFhKejNra0
 fd0NoFtNL2wK8lkPziHTAFPg4SRyiCFHzU013wiaQAcCrL3Qx/cro6oexSXsfnCGs2YS
 cXDV82x3x30bqt+5kanOPOzHvyqN1z115VOaTSA5+o5Kf1NvizhRwmlcGVRk9QwgGqDo
 cOrFQ7RZwbX0AYvbUAc8Vz1EGIrOZ4mMO/XUBM9RoM3WsThHrm4mnn+HS8by1SmvM5hQ
 nItxqdYAg1B2mZeeRWBQysL6yAbwbPGT5Llj5GEKdVO+RE5QTYFaBSmMmNkwlWIAm3dw
 bnzA==
X-Gm-Message-State: AOJu0Yz9Er4VOsDety4z/y350X3Kh9QVMLxRd9It3pSxIQzZwduvGWGI
 UHnJXwivg+xkEUg9fxFVJrfGwpAkueKfIUbMEMv8L0b5HYCON+NKrfrVV5m5v8g=
X-Gm-Gg: ASbGnctQhGJ5R6+7pY0PsQDKvpAQMOsvj9mBQpYJwfypJwRTNzmY+2QPek3E3WHCcz5
 KKk2Noj+D6NdWXYbUGbKavrfRg0t4xt63wh30pMrciLqIR/uKEt7I4HoKSEfAFa1NZo8abYYCzf
 CdjN+JIiDYVP122kIPc7127m04vRRoAyb62qk1Qf5nATA8BPPKHve2xGQg7Zvcy+UySuxeTrMlb
 Oen3ifyvVTu9KMaI/VgjLShjDXeBIu8xzaBgpJEd5n2KhEBsAHioxlFcLWYQXVkqolU3BAqp8C3
 nfU8dPVzHAaS+VK/M5xY+FpLvt3duIrWTz6q6vVoV9ouHm8qsGUt77Hbx9spAxdFQo5AjJlTs1m
 lqTaN9RevE1Jxz1r/6akwSnSV
X-Google-Smtp-Source: AGHT+IEtZQOftxa2KSDDXWAwKO/U99UyvH4lGf0Ov5dLqSe5qXfPvkjELzxSRExHJX791zU7msqgYw==
X-Received: by 2002:a17:907:9494:b0:ac1:e1a7:44af with SMTP id
 a640c23a62f3a-ac252fb9c50mr1468987866b.49.1741593930763; 
 Mon, 10 Mar 2025 01:05:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:72e5:c885:a214:4261?
 ([2a01:e0a:3cb:7bb0:72e5:c885:a214:4261])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac27e11c470sm348079666b.128.2025.03.10.01.05.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 01:05:30 -0700 (PDT)
Message-ID: <4c723e83-5287-4c94-8859-e1c49d6af927@linaro.org>
Date: Mon, 10 Mar 2025 09:05:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] net: lwip: add support for built-in root
 certificates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
 <20250305142650.2966738-5-jerome.forissier@linaro.org>
 <CAC_iWj+kn1Ah98XthW_kGmNQHjKy=VEL9kd+PjVKV9phwJeVcQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWj+kn1Ah98XthW_kGmNQHjKy=VEL9kd+PjVKV9phwJeVcQ@mail.gmail.com>
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

Hi Ilias,

On 3/9/25 12:33, Ilias Apalodimas wrote:
> Hi Jerome
> 
> On Wed, 5 Mar 2025 at 16:27, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
> 
> [...]
> 
>> @@ -304,28 +304,34 @@ static int set_auth(enum auth_mode auth)
>>
>>         return CMD_RET_SUCCESS;
>>  }
>> +#endif
>>
>> -static int set_cacert(char * const saddr, char * const ssz)
>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
>> +extern const char builtin_cacert[];
>> +extern const size_t builtin_cacert_size;
>> +static bool cacert_initialized;
>> +#endif
> 
> These are better off under WGET_CACERT || WGET_BUILTIN_CACERT ?

No, because one can build with BUILTIN_CACERT=y and CACERT=n (the latter is for
the "wget cacert" command, which is not mandatory for built-in certs).

> 
>> +
>> +#if CONFIG_IS_ENABLED(WGET_CACERT) || CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
>> +static int _set_cacert(const void *addr, size_t sz)
>>  {
>>         mbedtls_x509_crt crt;
>> -       ulong addr, sz;
>> +       void *p;
>>         int ret;
>>
>>         if (cacert)
>>                 free(cacert);
>>
>> -       addr = hextoul(saddr, NULL);
>> -       sz = hextoul(ssz, NULL);
>> -
>>         if (!addr) {
>>                 cacert = NULL;
>>                 cacert_size = 0;
>>                 return CMD_RET_SUCCESS;
>>         }
>>
>> -       cacert = malloc(sz);
>> -       if (!cacert)
>> +       p = malloc(sz);
>> +       if (!p)
>>                 return CMD_RET_FAILURE;
>> +       cacert = p;
>>         cacert_size = sz;
>>
>>         memcpy(cacert, (void *)addr, sz);
>> @@ -340,10 +346,32 @@ static int set_cacert(char * const saddr, char * const ssz)
>>                 return CMD_RET_FAILURE;
>>         }
>>
>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
>> +       cacert_initialized = true;
>> +#endif
>>         return CMD_RET_SUCCESS;
>>  }
>> +
>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
>> +static int set_cacert_builtin(void)
>> +{
>> +       return _set_cacert(builtin_cacert, builtin_cacert_size);
>> +}
>>  #endif
>>
>> +#if CONFIG_IS_ENABLED(WGET_CACERT)
>> +static int set_cacert(char * const saddr, char * const ssz)
>> +{
>> +       ulong addr, sz;
>> +
>> +       addr = hextoul(saddr, NULL);
>> +       sz = hextoul(ssz, NULL);
>> +
>> +       return _set_cacert((void *)addr, sz);
>> +}
>> +#endif
>> +#endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
>> +
>>  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>>  {
>>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
>> @@ -373,8 +401,15 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>>         memset(&conn, 0, sizeof(conn));
>>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
>>         if (is_https) {
>> -               char *ca = cacert;
>> -               size_t ca_sz = cacert_size;
>> +               char *ca;
>> +               size_t ca_sz;
>> +
>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
>> +               if (!cacert_initialized)
>> +                       set_cacert_builtin();
>> +#endif
> 
> The code and the rest of the patch seems fine, but the builtin vs
> downloaded cert is a bit confusing here.
> Since the built-in cert always gets initialized in the wget loop it
> would overwrite any certificates that are downloaded in memory?

The built-in certs are enabled only when cacert_initialized is false.
set_cacert_builtin() will set it to true (via _set_cacert()), so it will
happen only once. Note also that any successful "wget cacert" command
will also do the same. So effectively these two lines enable the
built-in certificates by default, that's all they do.

Cheers,
-- 
Jerome

> 
> [...]
> 
> Cheers
> /Ilias
