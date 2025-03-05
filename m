Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E18FC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 12:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD7D0807B1;
	Wed,  5 Mar 2025 13:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R4aDSwLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FB97808B6; Wed,  5 Mar 2025 13:34:12 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D4A3800C1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 13:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43996e95114so45738665e9.3
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 04:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741178050; x=1741782850; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BkMf25UwI2xUW8BShpSEcMZqt77PSF+CooOXGwLVyfE=;
 b=R4aDSwLKWJWIhXu4iON+WyBb8j2xmPfRM5wHt0EKIk9LdctgSNQans2pnI4iSFAtdD
 SsfzXqjyRSgT3OKRAO0ubg/u8fcnMbzJ1AXrc//UWyi7q3zfQcgzNSsD1eXQmtY6kbIN
 Z3FyzAFc1AaGcJbTUOjoUBbl/GxGrYIZS2acsCwMzjZy97/SaadT0Dvxsq5fF5MuANdN
 b5gWGUyJ+pG0N6lsrwnpiEOA+SlzsnxSvksPO74lKWyB5BOmbwsfltjsBf5ApJs+hsEA
 UdAYbS+UqqZTe2CBgxSejlZGkaceptk8QK00lL0XB2LWYW6KUhl6D3TAHmr9t6fSrTtA
 Z0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741178050; x=1741782850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BkMf25UwI2xUW8BShpSEcMZqt77PSF+CooOXGwLVyfE=;
 b=B1nE7PBXoLJV/2ubbgP+Ha6JCiQ2pFgq9iuuYPwVdOrjHcCXzwiqsrL1KHpZU6ZoQQ
 IEi2hU8wxp+5Rot3jPR4noBQjCKZjLLMY6jqHveDGWmgWY9b/j+PQheUGDbGfkHmO+rZ
 v0DgZip5Sa1sY1Do8FGokMDGWssClBvYlvV4YVSj9Xnm661iTT6HbIss7xsQnPOAKgvZ
 Fj9m1MDDM1fHziG7NdZuTGrWfCPIcHrx5MEYxrIuRJwa5LQ1m6kqB4+YM9uNo+3+yjKU
 7NXHJPntVvORO7/7AHko9dC8k/V6ZuAxIBeOH7xP2pg2mtegmpk4mchdWwOBmrprRR5n
 VB4Q==
X-Gm-Message-State: AOJu0Yx8Mldasx8IvQi3N/d2sqN8UM19XlXT778p2QGEp5qQd8BhzEDa
 nFThg7bP366wBwOC/x9+OeIHg5l488uwnooM4QbfXRhQxakBU/L/4/ccM8G3ZbUTeAEIEmlWK7a
 a
X-Gm-Gg: ASbGncvHY+GQwBIfw54ZryiQ7TKFYl2h2HJHgpukaxKVYj/EhK6BUfwfgL+2+LQtpP3
 7TsKXENQtWPYHzqLpUQ+mq8sKlrPmSndlJbY6Lk0mARduYNK2Yj0kpryjWfmzyRTzHpRN8I45qe
 Hr3eSB4WoYY2R6oEKCaSTW1Z/5zuTywujfCDK0toxQnIYtcR+CnCGLRMbO66HV2o/8LTg3v2iMy
 SvdLBxs9Mso5Mmz41dxSHPUCfJLXELg4JCl2LCsiDjYZKIvNGugdXRs5avEWKer0vYrkcS0Lp6P
 If5v0uivAFohwCrGGTWgYBeUZeeTGvOBIvBp2aRHLjTtKOh78h43qLpexyu1UAaZFPqwJwlgibT
 jceN4My3slCmBRCJcgh2scmTu
X-Google-Smtp-Source: AGHT+IFBnQZrAVM7W8H4Mf6H0tX2BuOye93vFNfnaj/cv7tGayPp7mxh5vyjCwjnTdoyZTLblj0h7Q==
X-Received: by 2002:a05:600c:5119:b0:43b:c390:b773 with SMTP id
 5b1f17b1804b1-43bd29b41f8mr19281085e9.24.1741178049642; 
 Wed, 05 Mar 2025 04:34:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:9358:6683:ed70:95ca?
 ([2a01:e0a:3cb:7bb0:9358:6683:ed70:95ca])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42e402bsm16086115e9.25.2025.03.05.04.34.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 04:34:09 -0800 (PST)
Message-ID: <46a8bea1-733a-4103-bd13-43870b31b194@linaro.org>
Date: Wed, 5 Mar 2025 13:34:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] net: lwip: add support for built-in root certificates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <fc96dd94cb39b60571b43ef80c5c89ff7999e94b.1740672437.git.jerome.forissier@linaro.org>
 <4f570bef-8409-4b82-ad6f-0e060901d7f4@linaro.org>
 <CAC_iWj+-1aJr4dE8v0M7Fq5nxxkkq+sL6jAb1=pMVOPqtS4XPg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWj+-1aJr4dE8v0M7Fq5nxxkkq+sL6jAb1=pMVOPqtS4XPg@mail.gmail.com>
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

On 3/1/25 07:59, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> On Thu, 27 Feb 2025 at 18:38, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Sorry for replying to myself, I spotted a small mistake.
>>
>> On 2/27/25 17:09, Jerome Forissier wrote:
>>> Introduce Kconfig symbols WGET_BUILTIN_CACERT and
>>> WGET_BUILTIN_CACERT_PATH to provide root certificates at build time. The
>>> file may be a DER-encoded (.crt) or PEM-encoded (.pem) X509 collection
>>> of one or more certificates. PEM encoding needs MBEDTLS_LIB_X509_PEM.
> 
> I understand that for downloaded certificates supporting both is
> convenient since DER might not be available. But why don't we limit
> our built-in options to DER only, which is smaller anyway?

Yeah v2 will be DER-only.

> 
> [...]
> 
> 
>>> --- a/cmd/net-lwip.c
>>> +++ b/cmd/net-lwip.c
>>> @@ -39,6 +39,10 @@ U_BOOT_CMD(wget, 4, 1, do_wget,
>>>  #if defined(CONFIG_WGET_CACERT)
>>>          "\nwget cacert <address> <length>\n"
>>>          "    - provide CA certificates (0 0 to disable verification)"
>>> +#if defined(CONFIG_WGET_BUILTIN_CACERT)
>>> +        "\nwget cacert builtin\n"
>>> +        "    - use the builtin CA certificates"
>>> +#endif
>>>  #endif
>>>  );
>>>  #endif
>>> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
>>> index 79dd6b3fb50..950c5316bb9 100644
>>> --- a/net/lwip/Makefile
>>> +++ b/net/lwip/Makefile
>>> @@ -6,3 +6,9 @@ obj-$(CONFIG_CMD_DNS) += dns.o
>>>  obj-$(CONFIG_CMD_PING) += ping.o
>>>  obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
>>>  obj-$(CONFIG_WGET) += wget.o
>>> +
>>> +ifeq (y,$(CONFIG_WGET_BUILTIN_CACERT))
>>> +$(obj)/builtin_cacert.c: $(CONFIG_WGET_BUILTIN_CACERT_PATH:"%"=%) FORCE
>>> +     $(call if_changed,bin2c,builtin_cacert)
>>> +obj-y += builtin_cacert.o
>>> +endif
>>> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
>>> index 14466598d7c..f24aa9c2380 100644
>>> --- a/net/lwip/wget.c
>>> +++ b/net/lwip/wget.c
>>> @@ -288,31 +288,34 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
>>>  #if defined CONFIG_WGET_HTTPS
>>>  static char *cacert;
>>>  size_t cacert_size;
>>> +
>>> +#if defined CONFIG_WGET_BUILTIN_CACERT
>>> +extern char builtin_cacert[];
> 
> const as well? IIRC all the bin2 generated variables end up in .rodata

Yep. Will fix.

> 
>>> +extern const size_t builtin_cacert_size;
>>> +static bool cacert_initialized;
>>> +#endif
>>>  #endif
>>>
>>> -#if defined CONFIG_WGET_CACERT
>>> -static int set_cacert(char * const saddr, char * const ssz)
>>> +#if defined CONFIG_WGET_CACERT || defined CONFIG_WGET_BUILTIN_CACERT
>>> +static int _set_cacert(void *addr, size_t sz)
>>>  {
>>>       mbedtls_x509_crt crt;
>>> -     ulong addr, sz;
>>> +     void *p;
>>>       int ret;
>>>
>>>       if (cacert)
>>>               free(cacert);
>>>
>>> -     addr = hextoul(saddr, NULL);
>>> -     sz = hextoul(ssz, NULL);
>>> -     sz++; /* For the trailing '\0' in case of a text (PEM) file */
>>> -
>>>       if (!addr) {
>>>               cacert = NULL;
>>>               cacert_size = 0;
>>>               return CMD_RET_SUCCESS;
>>>       }
>>>
>>> -     cacert = malloc(sz);
>>> -     if (!cacert)
>>
>> HERE...
>>
>>> +     p = malloc(sz);
>>> +     if (!p)
>>>               return CMD_RET_FAILURE;
>>> +     cacert = p;
>>>       cacert_size = sz;
>>>
>>>       memcpy(cacert, (void *)addr, sz - 1);
>>> @@ -328,10 +331,33 @@ static int set_cacert(char * const saddr, char * const ssz)
>>>               return CMD_RET_FAILURE;
>>>       }
>>>
>>> +#if defined CONFIG_WGET_BUILTIN_CACERT
>>> +     cacert_initialized = true;
>>> +#endif
>>>       return CMD_RET_SUCCESS;
>>>  }
>>> +
>>> +#if defined CONFIG_WGET_BUILTIN_CACERT
>>> +static int set_cacert_builtin(void)
>>> +{
>>> +     return _set_cacert(builtin_cacert, builtin_cacert_size);
>>> +}
>>>  #endif
>>>
>>> +#if defined CONFIG_WGET_CACERT
>>> +static int set_cacert(char * const saddr, char * const ssz)
>>> +{
>>> +     ulong addr, sz;
>>> +
>>> +     addr = hextoul(saddr, NULL);
>>> +     sz = hextoul(ssz, NULL);
>>> +     sz++; /* For the trailing '\0' in case of a text (PEM) file */
>>
>> This line should have been moved to _set_cacert() at the place I marked
>> "HERE" above.
>>
>> The reason for this hack is, before even attempting to parse a file as
>> PEM format (which is text-based), mbedtls_x509_crt_parse() checks that
>> buf[buflen - 1] == '\0'. When a text file is obtained via wget there is
>> no null terminator. Same when using bin2c. So adding the '\0' is
>> necessary.
> 
> and if we do DER only for built-in this goes away as well

Indeed.

Thanks,
-- 
Jerome

> 
> Thanks
> /Ilias
