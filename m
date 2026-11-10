Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43892606A32E
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vcpAKRus;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Dg7upsCJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AE65608DB;
	Tue, 10 Nov 2026 14:30:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w-X624Paieii; Tue, 10 Nov 2026 14:30:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6B69B60858
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794321038;
	b=Q4NCnvFkc1NfjC2pEFxIhtND1X2J8CDzo8JOJ4x4W1rKCdNnsx4FLG9yjPVTmsXRQSIR
	 IOzQ1/zoJE3RtyrTdIWYWvju+F4IGa0yQiMqTv8Ov12C1/JoC29ENaRlUKdqYA1QHg3Zo
	 uxLCT0V13sOiQBZdrEe++cJqCmEEgVBR/hPj1lQ7JjIaxxayjEm1pxZUGvjoobD9J83mc
	 sGj9pN0atu1+E/3qliEjuNuUJeT5cHETtyaNbEI/Y9ugnm7lIO8mnVDA9bY3k8OfQvnkd
	 cCUKScNW99muyTbi5giRpClKAzFTvf3P62HuWfEs4jo/UwMp5Wnud4MISdRqbnOr65g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794321038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=76Qi0z8aXMi3kYv3WTNVnfBFiEg10KrRBhsCktFCcaw=;
	b=FfF/QowZ8Vmsi3Bh/JQXrYaYFXv6uAmcFT7bx1QhRTBdrdQzx0BlzKnYthrKspktH4XN
	 ST5GNvlgVDtf+uLuOdngE3th40ca0IcDKz71FwwyIZICOgblHy2iAZmMaLbrWpzMX+96d
	 XfnB5V8TywNcf+O3HL8LJUhU+R820mi7zBXRtQYXUBaA7OpXhMv9fl6TRZy6SKjOiIv30
	 FIHsRUo9wusQtwZUCUirc+GD3YE0O3dLvaWBni771CYrNyWz8JBtOan3CDjny7JbYd+Nd
	 Cl8/2tjra1EVLTK/hbnCeZrG/yeXxEv20hHR3Huk0PUOqGGTP9h9PefVCIP8eGRlkvQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794321038;
	bh=76Qi0z8aXMi3kYv3WTNVnfBFiEg10KrRBhsCktFCcaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vcpAKRusdyYf9/xLaG1V2jE2y4qjHE+4z9hkSMSpsKt8Wb2iFyuPHYrhmsn5JEMgh
	 IIEXBcWisA341SHn0spVFiw4hJu4VEH1NVnsvDfI8Oy3CFnZx7l9zl6pfUN4mvvPYD
	 UYHks5EXzeWQmt8CCbNSBpEO0A1Yl63Q7km0yPkd8zPA9LHZiUvxhANo3bY0mGizqN
	 /ktNX0J3yyyTa/lcj74apSCRb72Djrv7KVqjafqQcUD2fmC2eUcsuUaAsuSsZpenf4
	 VroeZsJzEn0XqkRF9kj75Hr0J+nyfMS4e/WsSe7NhREyUtdZEnphNWwogNNj7KI4sW
	 sozBd98+QWO8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B69B60858;
	Tue, 10 Nov 2026 14:30:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D43F0D7
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C570E40822
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:30:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jRtTrcDWYCTt for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 14:30:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 679CD40812
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Dg7upsCJ
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 679CD40812
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:30:35 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6afbc363efeso3086678a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794321034; x=1794925834;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=76Qi0z8aXMi3kYv3WTNVnfBFiEg10KrRBhsCktFCcaw=;
 b=Dg7upsCJJVRzAsguZeHufGKXNGYWeBswg5fU8qp3/XDh87G+gjsPsXPjhRDBMF/sAp
 lfVXcCR6tX2V13PnBLXvCdiXgDP7O5B9j2+LwzQJzUPK55fCZh4x9U9LMzf0Mrh42cDA
 Hmfy1+jOyCpZAlWWjzI2asWq7CNOSe5lzzY5C6EWaeN2SzaH3xn7vDO2R9NOxxuXDxpU
 eS0quz9N0YfMnxxdywXnq6lX5sghz5IlFqyOkBZUSNPDrymfu5DjCeeRBy/5dO1Sv55v
 EU/jxbQIMwErUygjqLr1p5vDOUH+CDVTovPJPEDagtlALfE0CIAjeszv3zMUSoXM5Ezc
 f7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794321034; x=1794925834;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=76Qi0z8aXMi3kYv3WTNVnfBFiEg10KrRBhsCktFCcaw=;
 b=J+YWp1Quuh6kCFvhHbFkXjy/QbOsLQBP9OWZu+Q/kFghKaNV6h7btDbV2Xv5eSzqpE
 NfzsUmJkEkXhDE9asSioFK5ak//sxuJ2Z4qDWFnWv+jz4e5G647LNDW1E89rdd5Nz84s
 bl6o/3l0sHC+mE17Rfrht+Qge2jX07VQwpU74E5gPwYnRQ4fD8Um8B5cx3v6i2mzJCZc
 xGz0/pv8NsWMj0rS4VvmDWML+U8XQU5iWPzkPOAXVJzB7r8qMjW1S69GJaWUbFk+fZeR
 vtDQoeHwuqLYs70fMN4QM0IjyOQ9Mta43meZYQs86oNIugY4x8RiX2oOuMT+usuDNRwI
 1TVg==
X-Forwarded-Encrypted: i=1;
 AL+hErGYj2yk2sApp/+TeaXYKAbrhE83+T1ecZFbIsQHrV++Xl1d0+Q7sngceTaibkxcc6n0iIsg9cI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9qYy6jySVvxUNeVednjvBsBMftHl2RyymDgXYRejQE8R6SLKV1
 DWuFEDfCVU8ati9xsI4B01ujYVtP0UKbnzu47uvpZgkAQ9uOL6Ai3wtXmE+YvHBmH+w=
X-Gm-Gg: AYBFou3hJcqhpa3uvj8/7fTNaC5QfHA7Ch2UHWlaHPO4eCm5sNgY6PWe7/OyZRn+hXH
 +koEEFEa9LB9l5TPGsPMry36DDp1dm5OUN28gXNQE7Zj0GrmVCKc1mKB7zKOiamnCJBtuhe5zNg
 8yh1rkVvI+mnZmprwVNk+I1R60DCWwmIEcBpxGiinSlVwSSWdaVWEKHR2TZsHg6SgWLPA/wCdZf
 Ar4t3Qek+aGzM62mZuBpQ9F6wUmAd9+659C8Chr3wVvybTRrp3Q/1aiDJJLJCcgdl21d5dHxWu2
 UzgUmUauqfJnKe+FS2bfCzhvpFeM2UOvKPm3UvznYWqL8YK5LnG6rpbITR2grSAYiiA7engyUPZ
 kDfjHzPc4KewWcL9djLjEK3TvG4d2DTqUUKPNkfs2Hj2rc/p7v1JbzZTBHAYkRWxZ+R2VBrIc32
 0VVa+Vv89JSQ8Vnu3bvkUNHeI8d4++MO72H2iL3n+Mcbv6mViJFcdryRKQjiVQ7CaXhixhHozxf
 3wfmoRjm3oSSSnDtlZDtkCvLl3c7c7+fOrwh3dz6kewRZeLehj/qIgw+awaZ3GScfgWSJnJ7M1q
 zi+nosNFJ4a8BxIbK3nDQFtgQ+fj0lFPx1yKh/uReF9uP3Nb3HKPtxOvB3jVfpk0m9z2nTvyP2d
 Y/MJb
X-Received: by 2002:a17:907:8691:b0:c50:53cb:69fe with SMTP id
 a640c23a62f3a-c5053cb6ba4mr178438266b.23.1794321033765; 
 Tue, 10 Nov 2026 06:30:33 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:e16:1f01:e384:fd63:c1b:f384?
 ([2a0a:ef40:e16:1f01:e384:fd63:c1b:f384])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c504a56ffc7sm112759466b.17.2026.11.10.06.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 06:30:32 -0800 (PST)
Message-ID: <906a1084-fa5d-43ea-b0f0-6a3edbd60cc1@linaro.org>
Date: Tue, 10 Nov 2026 14:30:31 +0000
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
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <a714c089-680c-4698-bc8b-4cc0366f68ef@cherry.de>
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

On 10/11/2026 13:30, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 11/10/26 1:24 PM, Andrew Goodbody wrote:
>> The presence of the DTC environment variable breaks a binman test that
>> attempts to execute dtc from a temporary directory using the value of
>> DTC but that is a relative directory path based on the source tree not
>> this temporary directory and so it fails.
>> It also breaks a buildman test that checks the environment and asserts
>> that DTC is not present.
>> Remove the setting of DTC as it is not needed.
>>
> 
> What happens if you have DTC exported in your current environment before 
> the tests are run? It'd be nice to mention which tests exactly fail for 
> future reference.

It will fail if DTC is already set in the environment. I will add the 
failing test names to the commit message.

> I'm thinking this is not enough and we should also fix the binman and 
> buildman tests to run with an environment where the DTC variable is 
> removed/absent/set to the correct path so we don't depend on a "correct" 
> external environment.

I was hoping that assuming a 'clean' environment would be acceptable but 
I can look at what needs to be done to make the test work no matter what 
the DTC variable is set to on entry.

Andrew

> Cheers,
> Quentin

