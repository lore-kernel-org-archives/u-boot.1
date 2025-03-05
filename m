Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F15C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 12:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7576D807B1;
	Wed,  5 Mar 2025 13:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CvBwM8dU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF0D58083E; Wed,  5 Mar 2025 13:09:15 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 616558004F
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 13:09:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e0813bd105so10638623a12.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 04:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741176552; x=1741781352; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TkBL8jHn6J+WcmbkI4LCTBrx14Zj0823/faYO2JV1aA=;
 b=CvBwM8dUkMmbSNkxMcE7ZC/jtKvPuVDhClvJRa22dF78ri5VVOMheg51L9vZg3tGnq
 wofGfF+iVK/m+7fcFwqubgCwer1eXfrBFqcRqE4p7XlowzBP7mdUOxI0F2MKNcjGP1j3
 RdzUgIpdRI2sLkw74HdK9KHRgk0h2nYlHPRkxuP07SgITcKe5ZJ2mL7Srrz4g2UrXiBg
 GofZhJFj7kzo6q59vkB7CUxuitPF8MJ8k7sWd2EW1Y6ucztwIwEBxmz3so+9ndxQWK4Z
 LgK4KaeiimV/nFxu+IH7YnbC7gF9HlhJyEWVP08qqfy6KM+Azn6RkX1yrbX+0RUaLTN/
 o9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741176552; x=1741781352;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TkBL8jHn6J+WcmbkI4LCTBrx14Zj0823/faYO2JV1aA=;
 b=r4zL+THOY2/2NlJXbRSe7vhuHkUvTX9kT6X1HAWQDJdHZhcQYbeNWNnJZ7u4wFTdw1
 PI0cX+TyZcquCrU70ePjLfK9PR0GN19QlOHWQQN+zD/HPjtUyox3ALo9DOcBFyp1ElVT
 5Ob5qnaovgbUeL/YEEcsa+ZldN9Uiu1myEVLQ7+UpxSTeyzdCJhtoOvyq7mDKl8Otn6y
 e1QLbCwJEdSk2K1xbylRiZS/QgfWsHnUjcxNLzZs7sM26dmpgYvk14iq5Z+GlL6queHz
 6RKo84A1D46+BTKkya/desB3DZeOdMEdlFq8PDgAoooLWiWgq6dJ1bR7m1K8EW8Iyhmg
 AdVg==
X-Gm-Message-State: AOJu0YxhuTY5ZbhO0hOH0zDL2+htWYeef4YN+xMW2FIGhXk19P+ZWtjD
 SSGFD0Yd/V4SobjBecOMxUnObKs7DxT0FtGAG6WpxvYqU3yoIInGcwfD612oqpI=
X-Gm-Gg: ASbGncsQr2LS2yJ6nYrBDZ+RcrMnBbvE5lLDtmmHZmiE51TWyiUysYwUtGMgSPSPeWC
 dIaqjbVG8rDzztm20LXEEIsTuwAwTcT00YnDLfEoULiIIhg3vKoRJe1J5G3UW0Z6rZ+01ILu8dj
 u8iYfeDfLNdce/7MyQQC94OkPYzVODv5ZcZVNBEXPXJAppGmOZyUoJkPltcUR553hqIvRlG8MQP
 WnjGxC3W0t7Usu/ONqknX7wUYNHcfLZkuHdIiazV/TeW0Hkucj6DQjMyNPZmK+FLpC3t2geNldJ
 5bMO7yTb8ZmmYscg6daCvG9tzytgd6RfuJaJsTVkNllnm3gFvPb1W4ELF7WZytZIOwdFQMVfFRO
 UeqvIGXuKpY8E5VABkflasZHW
X-Google-Smtp-Source: AGHT+IHzRDycLusgBaa0YBMdZRSz8qBGgPeCNMm8qtedTOCuUeCftFpDMxRjWxH3QfrvOJr2QyRbaw==
X-Received: by 2002:a05:6402:5214:b0:5e5:3610:8b70 with SMTP id
 4fb4d7f45d1cf-5e59f4c83f9mr2735403a12.23.1741176552493; 
 Wed, 05 Mar 2025 04:09:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:9358:6683:ed70:95ca?
 ([2a01:e0a:3cb:7bb0:9358:6683:ed70:95ca])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e59413e719sm1989745a12.64.2025.03.05.04.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 04:09:12 -0800 (PST)
Message-ID: <cbec73a4-d97a-4c26-a478-0458183522ee@linaro.org>
Date: Wed, 5 Mar 2025 13:09:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] net: lwip: extend wget to support CA (root)
 certificates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Adriano Cordova <adrianox@gmail.com>
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <3a93751157801fe709d995eae1883f9e3219733c.1740672437.git.jerome.forissier@linaro.org>
 <CAC_iWjKuEyFCAeqFSv2u6iN9TFzsod7xZVG6EZeSgK88C78AkQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjKuEyFCAeqFSv2u6iN9TFzsod7xZVG6EZeSgK88C78AkQ@mail.gmail.com>
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

On 2/28/25 22:24, Ilias Apalodimas wrote:
> Hi Jerome
> 
>>
>> +config WGET_CACERT
>> +       bool "wget cacert"
>> +       depends on CMD_WGET
>> +       depends on WGET_HTTPS
>> +       help
>> +         Adds the "cacert" sub-command to wget to provide root certificates
>> +         to the HTTPS engine.
>> +
>> +config MBEDTLS_LIB_X509_PEM
>> +       depends on WGET_CACERT
>> +       bool "Support for PEM-encoded X509 certificates"
>> +       help
>> +         This option enables MbedTLS to parse PEM-encoded X509 certificates.
>> +         When disabled, only DER format is accepted.
>> +
>>  endif  # if CMD_NET
> 
> I guess that's needed because most of the RootCAs you can download are in PEM?

Yes, but thinking about it I'll just drop the PEM support for now as it makes
things a bit more complex (the `\0` issue) for no good reason.


> 
> [...]
> 
>>  }
>>
>> +#if defined CONFIG_WGET_HTTPS
> 
> you can do #if IS_ENABLED() here

Better yet: #if CONFIG_IS_ENABLED(WGET_HTTPS) I suppose.
 
>> +static char *cacert;
>> +size_t cacert_size;
>> +#endif
>> +
>> +#if defined CONFIG_WGET_CACERT
>> +static int set_cacert(char * const saddr, char * const ssz)
>> +{
>> +       mbedtls_x509_crt crt;
>> +       ulong addr, sz;
>> +       int ret;
>> +
>> +       if (cacert)
>> +               free(cacert);
>> +
>> +       addr = hextoul(saddr, NULL);
>> +       sz = hextoul(ssz, NULL);
>> +       sz++; /* For the trailing '\0' in case of a text (PEM) file */
>> +
>> +       if (!addr) {
>> +               cacert = NULL;
> 
> cacert is already allocated. Can't we just free it here if it's
> supposed to be removed and reuse the memory otherwise, instead of
> doing free/alloc on every command?

The size of the certificates may change so it's easier to free/malloc
every time.


Thanks,
-- 
Jerome
