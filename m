Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73562606A331
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sAtCFhz8;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VAO/5R73
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C660811C1;
	Wed, 11 Nov 2026 16:58:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PHNSlgYVOgjm; Wed, 11 Nov 2026 16:58:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 89E60810A0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794416325;
	b=ExnpSqEcA26KLmndib09tjFXB3uzZ+5CrptX2JTWuYnkZVzteUdaBWI7QgDC+FYiS1rZ
	 9NttSILR/O3DhjroF4eXB4mxPW0MrelkHwRmH/j8IdgrQ7O4sgvPQX9qURf5hZhNo7xwj
	 W+Fjyx1NyFkiIOM6rUg6LSp25B4IMZK+RrCZJnGn4DHHWvJrJ5h5dOxn69qglwC1Zy2pT
	 9vfYV4NiISLg3ev8pZEH99YUf7VLyWqBP9ImoN3nfz/nJmSLz7SjJvhMzU5voF8qu/uGF
	 rVQbejWDyvt0P5s1+svXPE4GZcc+4KtM4huLWoF9ojK4ztI9JDAG5x0Lrrg1/BXtSoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794416325;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4FglzwMAy3PKLvRGGDibKV/K+L3Vi6Vgy4fQ+6PUnPo=;
	b=MnUmEYlhjMdZJ6vLr2K5yW5viksWja3RFxL8Km6kuJ06iWrfAAPe1ldU3MKN+lroOuTu
	 0D10RM5BQohxKtKSGbfIFADw9qdTAF/NeBAel8jn5IWzwTE4nB3pViDWmGIDCr4Xwdhq/
	 6nhADlL4uLOy+UybVoj40BhceDlV5YsisPgoBPKpwXs7UP+V6EU6l10rLyj5KkBtro3Xm
	 P6DJQ77MfcOnJQcGWd49AKqrussi66Ix45HullY8vqzkRK2gE6jierqp3362Qx44p60q2
	 bQFd0E+C1Ism4jeMw41hzSs6KyZw3u2eEYEsRIkFFOunwdR2TxjKF/SdKTFNOMrsaug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="VAO/5R73";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794416325;
	bh=4FglzwMAy3PKLvRGGDibKV/K+L3Vi6Vgy4fQ+6PUnPo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sAtCFhz8Hd4Qs9cWkS0yQyWcVn/cLWXFweYuRn/XkizvTQ+sdfAP45fX2jLOzTSaY
	 13rA9oBNU5kin7D1w78ggd11phfqrWlWcy7kHz/JZf/D078+Y26gus5gCRnajfkx1J
	 mEr29uwvFxd5ZRYg0i6hHzjHdpQpY/aGrEECw9ZJvx156I7TUraRE/pQeIlghqLTW/
	 19u2HfCEclaru6t/cgswTnftkaTcf698usekq7iB0ByTNtmw3+txGqy5DCMsW3dkGq
	 d7Vxx53wDTYQ+/bYv6xMeipB6vT6gQfgPUjHrNHn4N5gpWyjEUYXhnBnEJU6BX3Kmx
	 Xc6ZNoAFTBiLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89E60810A0;
	Wed, 11 Nov 2026 16:58:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F11DA31F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E29688109C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jJ4O90Psn9vV for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 16:58:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CBCFF810A0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=VAO/5R73
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CBCFF810A0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:58:42 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so36444345e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794416320; x=1795021120;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4FglzwMAy3PKLvRGGDibKV/K+L3Vi6Vgy4fQ+6PUnPo=;
 b=VAO/5R73SWKAF0HEP2GAUKuakAkbl7L7K1MAFHzxOnUiq+ZjzGVdRUXOQo6EOQcwvx
 Mze35vDw3V8EIWvpUZE+ECLa6ATMGYsONPWeeOJTQZ6UWghX7+NDk3qekdSz7A11gZkF
 OkGW7C0LRsi1G7UEeZBycXq6zo7bEK9BL+XrSl3f+iD2idv+8J5y8ojNj6E1Xh668Vm4
 1NTjHxon0im33oIxqy/b+4KOgUQi+VHFckGstaSSu9wxQKH6R9qfQk4uCcEYXa7zQC9n
 7GtAR0sYnNwYlUcS0rdpLzUaPSzulknArTdqlfDWFoJy7p93IbmSn6MmZQ6/SzEibKAG
 lwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794416320; x=1795021120;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4FglzwMAy3PKLvRGGDibKV/K+L3Vi6Vgy4fQ+6PUnPo=;
 b=rfmgmD+4dvRbcRs20oP8odtxIHYm+R6b7KW7SGaKPDbx+5seRN/VnIVQzgd11FnqfS
 dJE/lqfmEbodUsrFnqlBly/zjrAXuNTFZovHTrXIIZVwu/mBVmQxN/pP4OBFPfMXvdpF
 NQqHqrmzxaBx5NnMHzpBuw11KVidHEvryAETSprJWVTXhKT6aU4A08wsDcsvInFTHn1p
 l5UOCPmi8AAfkTRGjf6EmpmXvSTrs62dyjxwq1z+bGZ5pFzc0QjDNQeuUhmJH/YmQCy1
 V3cEDXtG2/WOZ7hv7iOwLDQKCXTqIAzbdfEsINqX+u5eV7njh4jHbkMcBZYIIKgNWrgj
 QTbg==
X-Forwarded-Encrypted: i=1;
 AL+hErEaeE0U0V4sDp3vjevTl+/rQh061TKcev8AVANDs4wR5c9MX2hJyOmi8DMMmzyoPkr1Hv3Wrcc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/59IyK0WmE39R2OnSvdoA0gyc8oiH3MzJe5vuOBtYNYqsHc+wT
 oLzZOxTdp99Aiv0IQHYIsqWsxxttp3Rkb/QUtjhjdZMJGaZuetTWC6oojbBO58OM5tI=
X-Gm-Gg: AYBFou36v3rTDo6Lvrw9SLYF4nGzFektrORn7M9GXS4QCxBGNyc6wDcqfaSmPwdrLz7
 8ylgb2ONF8ShMGTowS2lRyT7CutAKpSzTdhgu9rFTMT3m8/NtFyG1sOwLWLgwgOYf/pxaE7mkWH
 Kt8AiqW8JD4jlvM8zAWElBboDU5HqQi4lKU2auwfxGRlkZs8q8uTyAmwqwGh+HYvs6SY4AH8B10
 xXG8BI8TG5TKZefHJscCbzWisdscKqYs62/x+OgAyp92QgSGyTBBWzj6F6Ax5YXE+j4BEB2qiCq
 Vm8vjUWCoyzm583qVPvMkRPh86DuwC6sHGFcmDNwNSQ1BKS6Po5+rtpSeiUUb3S4vNKNBeTb7on
 wSS42tWhP6YijjfxjCS3VZFIESmFtlmahjaFtpAWZK3hF2c9FFVruhDpRpPqceK2jQDOb9rvZDU
 +RoYGFz0dMcsfc37QwY4Y8JlC+MKhpMc4PefO7x6Fvff46veD6pJ9fhUjAYusn3NKhxh8JGhubl
 oZkh+yst2U3KID/QnUCHYFm+9GWdhq/WKhE/sYSf1kqJ8XAR8REc3AaR4T5jDkfdIj/ucipJ/py
 sbwOshWOUAv6IaWZW+E3HGVdA1NOiq1Z0m8dlTV+R2jvWL8diLluxfYBX2/cbtOjcBNn70xrxn6
 teA3t
X-Received: by 2002:a05:600c:1989:b0:4a1:fe55:88ef with SMTP id
 5b1f17b1804b1-4ba0937df21mr49965695e9.20.1794416320243; 
 Wed, 11 Nov 2026 08:58:40 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:e16:1f01:f60:9877:8ffd:39bb?
 ([2a0a:ef40:e16:1f01:f60:9877:8ffd:39bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e28c882sm1303885e9.6.2026.11.11.08.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 08:58:39 -0800 (PST)
Message-ID: <12f5fb64-993b-4062-8890-daad7aaf60b8@linaro.org>
Date: Wed, 11 Nov 2026 16:58:38 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] test: Do not set DTC environment variable
To: Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini
 <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>, Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110-qcheck_fix-v2-3-1c76e0b68f29@linaro.org>
 <a714c089-680c-4698-bc8b-4cc0366f68ef@cherry.de>
 <906a1084-fa5d-43ea-b0f0-6a3edbd60cc1@linaro.org>
 <b6246d02-b4eb-44ca-ac8a-e4772860533d@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <b6246d02-b4eb-44ca-ac8a-e4772860533d@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/11/2026 14:43, Quentin Schulz wrote:
> 
> 
> On 11/10/26 3:30 PM, Andrew Goodbody wrote:
>> On 10/11/2026 13:30, Quentin Schulz wrote:
>>> Hi Andrew,
>>>
>>> On 11/10/26 1:24 PM, Andrew Goodbody wrote:
>>>> The presence of the DTC environment variable breaks a binman test that
>>>> attempts to execute dtc from a temporary directory using the value of
>>>> DTC but that is a relative directory path based on the source tree not
>>>> this temporary directory and so it fails.
>>>> It also breaks a buildman test that checks the environment and asserts
>>>> that DTC is not present.
>>>> Remove the setting of DTC as it is not needed.
>>>>
>>>
>>> What happens if you have DTC exported in your current environment 
>>> before the tests are run? It'd be nice to mention which tests exactly 
>>> fail for future reference.
>>
>> It will fail if DTC is already set in the environment. I will add the 
>> failing test names to the commit message.
>>
>>> I'm thinking this is not enough and we should also fix the binman and 
>>> buildman tests to run with an environment where the DTC variable is 
>>> removed/absent/set to the correct path so we don't depend on a 
>>> "correct" external environment.

OK and will split into 3 commits.

>> I was hoping that assuming a 'clean' environment would be acceptable 
>> but I can look at what needs to be done to make the test work no 
>> matter what the DTC variable is set to on entry.
>>
> 
> Mock the environment with with unittest.mock.patch.dict('os.environ', 
> environ) for example, see tools/binman/ftest.py for examples. If you 
> want to only remove some variables, you can duplicate the environment, 
> delete the key from the dict and use that as mock value.

Thanks. Will do.

Andrew

> Cheers,
> Quentin

