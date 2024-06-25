Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F925C30653
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 07:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EEE7884BE;
	Tue, 25 Jun 2024 09:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nc+p+sVR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71361884BF; Tue, 25 Jun 2024 09:43:50 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50B35884BC
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 09:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-366df217347so2645170f8f.0
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719301428; x=1719906228; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NU6n1bXXWdYbr0AYb3R22tlEOo/Y1D4HRdTpyiIFoEo=;
 b=Nc+p+sVRbs7oq6wc7hhyGf8UenAIT5G8+lm4axg3uk5yjLDeJqvuBGKOD+8TiRA01F
 vuC7A6jBC+GV69UyPuXvmU3HcRMcdQew3pAUCiPKm0LibuhGYx3j7sh79yChJrF9Ylal
 QaABaP1JaalLODklBSdEzUOzVqYUAlRW3x/0EqxvcLvmwBgjN9AobRvkSmbMVW/XtbA8
 rkS44qDhpq8OdnFoVsLzxIFcKOPWaGPJmmWguvBvHIyRcdoIZEtOk8fW9GO/gzsiPCfN
 kYZfIZgLut+iq8ovQYg02tzkd422nBHs2aJoAkZ+Gm42eDgLkRfOOnUdTpo7XE0ARLzN
 jI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719301428; x=1719906228;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NU6n1bXXWdYbr0AYb3R22tlEOo/Y1D4HRdTpyiIFoEo=;
 b=o+MUKFPdjur/KdLkLI3Ab0Jgw5t8JAxTwS7fAMXSznEcKBuxQ4yrJSr31W4TauJEJl
 IyV52jTWUdkWgsmnFTYMqYtp9DRsRDbdsngaMh6c4cKjhJvxB+d9N4IJcBcmXIVKHwpD
 SVzuCL+0EbU1r4+ycefM7kX3AJWy5XwK5Gf00wOvOHyWsr/9QpvB0NkDtpGgvtgpxgDa
 +KVTAYIUM+PTbyByCsMQbF3JQTd7i71Zf9MJDk2xmz2HlDaJdDWGPAPrDTzoWdlsTjT5
 47lIJkc6GeUpZsgyF3o1O2FxPFwmuTOY1SjG4uDESuOEvuVGsUq25pbR/TO1EqqifBNa
 81Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFls92fHL1//DNlh7+P4msh9xuNDLvwvcYac3AJP5pgLW5eZyn9spjaSsSXYk+QpFAPFpe3wCUfYCWG5LeBa+GIIrJWw==
X-Gm-Message-State: AOJu0Yx0IOcuTgiB3tjtlwQnOhERWdwGuOvcEmYRb5sSAr/tN4Jd2HqO
 F/P0y43ZigziLoAsez1ze7RQ+Pqjpl/038amxEHRodsIQ5lHT8b/+aivzvr0FfM=
X-Google-Smtp-Source: AGHT+IFM5iwXPql0T+MY11sil2zITH3vbm8Rxbt1KXtBwyzlem7cU444jxK7LNt0b2gcW97gRbUosw==
X-Received: by 2002:a5d:400a:0:b0:363:107d:8385 with SMTP id
 ffacd0b85a97d-366e94cbca0mr4713479f8f.34.1719301427565; 
 Tue, 25 Jun 2024 00:43:47 -0700 (PDT)
Received: from [192.168.7.95] (679773502.box.freepro.com. [212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367011c4600sm849926f8f.61.2024.06.25.00.43.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 00:43:47 -0700 (PDT)
Message-ID: <3c2b8a90-1d4d-41ac-a15a-0d3b2a7d2a57@linaro.org>
Date: Tue, 25 Jun 2024 09:43:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/14] net-lwip: add wget command
To: Jon Humphreys <jhumphreysti@gmail.com>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Peter Robinson <pbrobinson@gmail.com>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <ba84782cebf8a151ae7bd5d9abc4b313fb4334e8.1718638104.git.jerome.forissier@linaro.org>
 <86frt2vp2k.fsf@udb0321960.dhcp.ti.com>
 <33cdfc51-178a-4c4b-90e2-683dc7f8ac51@linaro.org>
 <867cedvhct.fsf@udb0321960.dhcp.ti.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <867cedvhct.fsf@udb0321960.dhcp.ti.com>
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

On 6/25/24 05:20, Jon Humphreys wrote:
> Jerome Forissier <jerome.forissier@linaro.org> writes:
> 
>> On 6/24/24 08:21, Jon Humphreys wrote:
>>> Jerome Forissier <jerome.forissier@linaro.org> writes:
>>>
>>>> Add support for the wget command with NET_LWIP.
>>>>
>>>> Based on code initially developed by Maxim U.
>>>>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
>>>> Cc: Maxim Uvarov <muvarov@gmail.com>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> ---
>>>>  cmd/Kconfig        |   7 ++
>>>>  cmd/net-lwip.c     |   8 ++
>>>>  include/net-lwip.h |  18 +++
>>>>  net-lwip/Makefile  |   1 +
>>>>  net-lwip/wget.c    | 269 +++++++++++++++++++++++++++++++++++++++++++++
>>>>  5 files changed, 303 insertions(+)
>>>>  create mode 100644 net-lwip/wget.c
>>>>

<snip>

>>>> +/**
>>>> + * wget_validate_uri() - validate the uri for wget
>>>> + *
>>>> + * @uri:	uri string
>>>> + *
>>>> + * This function follows the current U-Boot wget implementation.
>>>> + * scheme: only "http:" is supported
>>>> + * authority:
>>>> + *   - user information: not supported
>>>> + *   - host: supported
>>>> + *   - port: not supported(always use the default port)
>>>> + *
>>>> + * Uri is expected to be correctly percent encoded.
>>>> + * This is the minimum check, control codes(0x1-0x19, 0x7F, except '\0')
>>>> + * and space character(0x20) are not allowed.
>>>> + *
>>>> + * TODO: stricter uri conformance check
>>>> + *
>>>> + * Return:	true on success, false on failure
>>>> + */
>>>> +bool wget_validate_uri(char *uri)
>>>> +{
>>>> +	char c;
>>>> +	bool ret = true;
>>>> +	char *str_copy, *s, *authority;
>>>> +
>>>> +	for (c = 0x1; c < 0x21; c++) {
>>>> +		if (strchr(uri, c)) {
>>>> +			log_err("invalid character is used\n");
>>>> +			return false;
>>>> +		}
>>>> +	}
>>>> +	if (strchr(uri, 0x7f)) {
>>>> +		log_err("invalid character is used\n");
>>>> +		return false;
>>>> +	}
>>>> +
>>>> +	if (strncmp(uri, "http://", 7)) {
>>>> +		log_err("only http:// is supported\n");
>>>> +		return false;
>>>> +	}
>>>> +	str_copy = strdup(uri);
>>>> +	if (!str_copy)
>>>> +		return false;
>>>> +
>>>> +	s = str_copy + strlen("http://");
>>>> +	authority = strsep(&s, "/");
>>>> +	if (!s) {
>>>> +		log_err("invalid uri, no file path\n");
>>>> +		ret = false;
>>>> +		goto out;
>>>> +	}
>>>> +	s = strchr(authority, '@');
>>>> +	if (s) {
>>>> +		log_err("user information is not supported\n");
>>>> +		ret = false;
>>>> +		goto out;
>>>> +	}
>>>> +	s = strchr(authority, ':');
>>>> +	if (s) {
>>>> +		log_err("user defined port is not supported\n");
>>>> +		ret = false;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +out:
>>>> +	free(str_copy);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> -- 
>>>> 2.40.1
>>
>> Hi Jon,
>>
>>> Hi Jerome, I am trying out the lwIP stack on TI boards.
>>>
>>> For wget, I noticed a bug and a user experience improvement. The bug is an
>>> off-by-one array access when parsing the url.
>>
>> Indeed, someone reported this bug to me off-list and it's already fixed in
>> my WIP branch.
>>
>>> The improvement emits a
>>> message if the url isn't an http://, since that is all we are supporting,
>>> and without the message, the wget command silently fails, which is
>>> confusing to the user.
>>
>> I agree.
>>
>>> I will post the 2 patches as a reply to this email. LMK if you want to use
>>> another method to collaborate. I can already see that efi http boot support
>>> will not work. wget_validate_uri() looks to be copied vertabim from the
>>> current implementation, and IMO we should completely remove it.
>>
>> It is indeed copied. It is needed to avoid an unresolved symbol but I
>> understand more work may be needed for EFI HTTP boot support (not tested by
>> me).
>>
>> If you are willing to help with this then you are welcome to post patches as
>> replies and I will integrate them in the series.
>>
>> Thanks,
>> -- 
>> Jerome
> 
> Jerome, here is a patch to allow a port specifier in wget's uri, which lwIP
> supports.
> 
> thanks
> Jon
> 
> Subject: [PATCH] net-lwip: lwIP wget supports user defined port in the uri, so
>  allow it.
> 
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  net-lwip/wget.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/net-lwip/wget.c b/net-lwip/wget.c
> index 6b9c953ef51..d3fdd44a29e 100644
> --- a/net-lwip/wget.c
> +++ b/net-lwip/wget.c
> @@ -257,12 +257,6 @@ bool wget_validate_uri(char *uri)
>  		ret = false;
>  		goto out;
>  	}
> -	s = strchr(authority, ':');
> -	if (s) {
> -		log_err("user defined port is not supported\n");
> -		ret = false;
> -		goto out;
> -	}
>  
>  out:
>  	free(str_copy);

Patch added to v5, thanks!

-- 
Jerome
