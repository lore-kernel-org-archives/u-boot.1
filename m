Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6894CC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 09:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDCC9836C8;
	Thu, 24 Jul 2025 11:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jfB3tdMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8656783754; Thu, 24 Jul 2025 11:13:35 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8572D836B8
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-adfb562266cso117943866b.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 02:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753348413; x=1753953213; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RF90NVck/T+Uxcxv98P+fvi+Xeo6e7iaNqtElS8vMuU=;
 b=jfB3tdMC1+uXi9yHqWtbLbISpLoT74unmCJRc1JPuyDalmA0PIuDJ3/ogYRXqoQU6x
 JLEvF9kQzEzMMj5AYrGlPGNlj1mfcF/k+cmyENv2jPwbtj1S8BVa4KnYOoOEUUWMJmQE
 fi+42j4So5oUt8UZhE2simcqMb6QVrwjTXRVB0HjH7j2jGCAR3h23YKOlMtzkmtByyyA
 w4eG0286LRhbq0gtbyfdFt00+3er8K9H+9Ew++1+Bp5Ku5xM1FRvPA4+twCJ1ak4wIKW
 1PdQj/DAQucz0aB/eydsk20HWYJvw+JCX7bT21/YMBCUR6YiKtGpLsny3+6G+ZFWREhC
 Ug7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753348413; x=1753953213;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RF90NVck/T+Uxcxv98P+fvi+Xeo6e7iaNqtElS8vMuU=;
 b=dGvLmHoYZfTd4SQ1GjfjMyBmB5XTqCAI45VoCZj7VmucUjYOZ97KPQSAFUHIFpIgHD
 oR02CCKl1Swbuhw0115mW6XDL4HYu+3BYrdNqEOgseVqDOzMrm4Xy8CyohgOhCLnz0vn
 aMa+4sZknKoNVTrs6FHZaZ2ojtAA6Hw80DZ0CEZoD5+35bdvZprckZDNafXHW78JdVsd
 evLyZPyQY7w0sHzR0+qDm4Qb60a3v/huAeevlh4ZRMYdbljCgCbcuMGRtssDGrMQCwbu
 PHj3GKu9oygVn43IWnggt1y5kI7pq74PFs4OFZhUGunKFo135Sltw1Z5CfB8lE5gfys+
 vTjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi96cCBeUHVDRYhJnV0UDbEAJApWkImD1KOA1B7Lr7aF4xZq8gKfZcKUCTpfRPdu8wfjy+Pt0=@lists.denx.de
X-Gm-Message-State: AOJu0YyBbOj0bzedlOUtlRSWRxbWv6oyP+WFubgjz+QLA8g1jOVBpUn4
 SKKek3WZMbxAeLVx4x2SvzylV8P64W+pXayx7qsXOF1e58oWMOWuiVnNaqOwfCW+Z9Q=
X-Gm-Gg: ASbGncuvwlUUo90xiH0PcRPZcVkODBteRfCSRZZBj/2VTGOc+KyOb0mPfLSrolybfPb
 mIxbl9unU2J5EQpYDoKO57djgNkEPQniSVl6HOxAv8yZrsCP63EKEsxiHgcxcMKH6X7mdPj+YSh
 ICAf3RnTs2fslaiXqThlJKtqEB67Vd9j2zRuTAolJz0fS5fNukC0IZPTbkVO6Xz8m6dXPIRiaFv
 9mQHGTpwUQSv+uYCm6QUMORwIDJPXTATuLn2hZsfVAITwg1/8nJP0BAXGLhKmQn/gxGizzUWGOP
 DyIC79inrK/8NnV+xnMyaVBNmkuSTmAixiRvS3ObbNJYL91d7Y7h4Ogjac2r4z9hF1xvPsMhAAf
 UDmLz95SfAezt1dP0EN4hYMs1wNFgYvxcdOHV2BPGaZkmeWy/0UrsFMM/D0YacGyis+VhewVJrS
 Vwiw==
X-Google-Smtp-Source: AGHT+IE4YZB7ZfeLCMOzIci9xcsAn4I9gPhYJ74ULL8NAWXkXNmF+QOO07V9VHSBdautoT6tkw/N1A==
X-Received: by 2002:a17:907:6092:b0:ae6:add5:ac8a with SMTP id
 a640c23a62f3a-af2f63c0141mr579949166b.11.1753348407413; 
 Thu, 24 Jul 2025 02:13:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:494d:b001:252e:8716?
 ([2a01:e0a:3cb:7bb0:494d:b001:252e:8716])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47c49604esm83509266b.23.2025.07.24.02.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 02:13:27 -0700 (PDT)
Message-ID: <04df571d-8d07-4c87-9554-47ebb07c7774@linaro.org>
Date: Thu, 24 Jul 2025 11:13:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] binman: bintool: run 'apt-get update -y' on first
 invocation of apt_install()
To: Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot mailing list <u-boot@lists.denx.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Leonard Anderweit <l.anderweit@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250724090247.59221-1-jerome.forissier@linaro.org>
 <20250724090247.59221-3-jerome.forissier@linaro.org>
 <662486e1-7300-41b9-bd8a-8618552331e5@cherry.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <662486e1-7300-41b9-bd8a-8618552331e5@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 7/24/25 11:06, Quentin Schulz wrote:
> Hi Jerome,
> 
> On 7/24/25 11:02 AM, Jerome Forissier wrote:
>> 'apt-get update -y' may be required to make sure that the list of
>> packages is up-to-date and that the subsequent 'apt-get install'
>> operations can find the requested packages.
>>
>> Fixes the following CI error:
>>
>>   Fetch: zstd
>>   - trying method: binary download
>>   - sudo apt-get install -y zstd
>>   Exception: Error 100 running 'sudo apt-get install -y zstd': E: Unable to locate package zstd
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>
>> Changes in v2:
>> - Use apt-get instead of apt
>>
>>   tools/binman/bintool.py | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
>> index f46bb52a7b3..141cc66657c 100644
>> --- a/tools/binman/bintool.py
>> +++ b/tools/binman/bintool.py
>> @@ -55,6 +55,9 @@ class Bintool:
>>       # must be called before this class is used.
>>       tooldir = ''
>>   +    # Flag to run 'apt update' once on first use of apt_install()
>> +    apt_updated = False
>> +
>>       def __init__(self, name, desc, version_regex=None, version_args='-V'):
>>           self.name = name
>>           self.desc = desc
>> @@ -421,6 +424,11 @@ class Bintool:
>>           Returns:
>>               True, assuming it completes without error
>>           """
>> +        if not cls.apt_updated:
>> +            args = ['sudo', 'apt', 'update', '-y']
> 
> I think you forgot to do git add (or git commit --amend) before sending the v2 :)

Oh! Yes. I'm sorry :-/

Cheers,
-- 
Jerome
