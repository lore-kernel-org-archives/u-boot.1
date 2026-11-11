Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1188C606A331
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XutTRaGn;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ls6PhpuA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBAC3811D0;
	Wed, 11 Nov 2026 14:34:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k3RHFcMmDlIw; Wed, 11 Nov 2026 14:34:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B4A3811F8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794407684;
	b=cHHaEsxFLvh7vEIfxtQwhHWvDzjj8iK8w6zFHQK770Ofb174EJq3TLndXdStXjloPO+m
	 xmOxIGgJdbi2dOMXkTkWLpX0rGn5MC/Vy6OQW13uYRZw9r489IkMwmweYiofpxYH1nDf4
	 4URgsi7KJvOfH9Fw/BTNT/D6Nk6zjI7Nv8h0PgndWF7V1mhtLesCbvdvm1T8KGap+lLwT
	 iR+RoAfIK2UZwQRZaNFIq5BNveR+B2L0F0eI9CjDxHuVqCWnUulx2ZnNTLWnQO1R5cRs2
	 pAnB9XCCA/hDJFuPihNz/FJwEN+0m/uvnzULPrfb43QkxvacwD4eRrvTb7Vf/vjvxsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794407684;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Jklw1LQd5nINqUT18r9BzaeuN9zwEhzi/R8G3mdGfI4=;
	b=O3WMdODDqk1CCXlZd/kTwoG9k8drKPZzTDuZwqJfoDREilCxb++o3zubTH1q9naYZ0xw
	 wD8O86eZr5UDfRODiOk+OHit01NFoVvLAa8M3NibNUt42t7BpGU4eNmwV3taIwIwbEuGl
	 OREMFsL/K0SlBEG4hAwkCj4yAuA81hM5FW+rWmA37+HFM1wxZzZ+/BoCiKtIG2llUQ5c6
	 V7xXKYe7YkmFLSZrA4Zpag8ujEzNlzhokSkOuYKEwRivUJWsNhCXp0vRM42N5vSKWrMoj
	 gqMmI40neTEiqs/y2tp6F4HUXDWCa49JXtNXIG6tfqODlLwdNttTkfGoZLY1WQW2nVg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ls6PhpuA;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794407684;
	bh=Jklw1LQd5nINqUT18r9BzaeuN9zwEhzi/R8G3mdGfI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XutTRaGnWRufOyUUVyKFfFzO/ZdVF22xzOI5uJu7CvRGfcFUpuWht8Hhb6+l/Uxc3
	 WitqqGD0eaeubWCNgtnS947LmZx9Uxco1YCMNWEYM6vz2RsUZoHNVkf3axjeco5wzo
	 97f3raOD3Q0yYvtBrof5ltGiJJpj6ci/XscWWEhIR0KCOt+HhHwl4h+B1j7ZUm3Wp/
	 hJkT+VvW3fSiOGDtdBKgoYDHJmBExSNH+kryaFhvHGxzCHkA4CnEVFHoqh4omE3/VV
	 bg6Eo1QV7vXICvsAAWznysw7jmsR+pNn5K9MBEqhxHDfxlx84RgF8R0i/edt5UDZuD
	 H4VDeg8dUyqIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B4A3811F8;
	Wed, 11 Nov 2026 14:34:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E113B17CB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE414811F8
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:34:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sJ7X6jzPfQcl for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:34:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AA871811D0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ls6PhpuA
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA871811D0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:34:40 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so36441655e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 06:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794407679; x=1795012479;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Jklw1LQd5nINqUT18r9BzaeuN9zwEhzi/R8G3mdGfI4=;
 b=ls6PhpuA3K391A+isvbcR9B+9hTuNK0kpGn6p5QgB4JlTAU1q3F0FKONiBSHARAuov
 is5CiZC0320lr9kJKm16vFekI4Njgyqp07w9OobuoSpld053+7XOthYVWYioiKQPkjwV
 24az6rjCvrKe1yWWmahfIORpPtdDsxme0vdyvXSkpqZJjO36USPFUInfx14RVVJLrVle
 /lw6DeqBbuAxpJnMeJZfcuI359rfLb2DjUTvK7gd+4zZubt6rbige+vVgwWzVnMU732/
 czPWmMD7wQMIrOz7R/GUT/ThZUV0/9X90/or7Zk7wp90t+FqfpOFtvXjUJ/JhCf+ot+q
 xqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794407679; x=1795012479;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jklw1LQd5nINqUT18r9BzaeuN9zwEhzi/R8G3mdGfI4=;
 b=ayfqgRg/uXf7o7Xa9b8xGqKY7bQvfw6iN6uROYWXMKIRtTly5rC0iT2SSV/hIPxldX
 wUDCWFsdOQjM9hWDAt56baL9BKxMKumjB17mUdYbHrtpafDRXpBiKEJM4Ai/k4TzJ8Ul
 OAomvEdxwkzzvzyaY/CMHRtSJcKWnrK/otDqyi7cQZWm0HwX3T3uVuLVIR6aKgiPuyKP
 7ka9h8RELibQeO3fRIZd7vtdukhnXuk1AvQLPwgPQb6Cs8ijxXR1pR37cQRnVsbyrfP0
 WRDilmxpfSG2eYz6rYVhfGd77qZK/ZQhdWHrFYVcRUyqboySK4T1buvpBbGmVIePmFS8
 IfLg==
X-Forwarded-Encrypted: i=1;
 AL+hErEpceez8+vDdSPGzCvDMrryEfSQ1E8XFkSZgHQkNpKobd8uh3JWwFMsS/LIJx2nkvDj7dG3JwU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9XZOfAf4WngAQADvZF66/aygbl7YawRgipaz4UpMurP7ipVjpU
 FDqXw8oY5hHE3pnxazi4tpsewry4U07rLhJR9UV4a2iwYaxkRgZsB+TXQWvvDtDGY7I=
X-Gm-Gg: AYBFou27BkU+DPAcgSflAOUSRBt/LnMeLcPTRGylclI4F2Neq5ohf28TGzujaRJdFgS
 qFrcLhCQwusCBenkfv/i5ziDY/WQymGfgNcXTJIDYnYzUJ4raudt1kcfBxRJE4vNIqu+nDe7hR7
 r885FeNoNied/KtlF69Fo32fDXxpFSRv3OMOESoeuZ+eQfYE6SlYzANtkVavX8SbLc0VUpcjFHB
 /doHU8SwhbxfQNuF0FJf+7k4P7sf8yXL0V1jWZ7Rzb39Phdi+TmCnIgPDw9saY5X7LYZMJzvyPq
 +GLS8x/vP7NkcCZ/t6fORYcRE1ruewJAYVSpDAJYDB4oFkSPWAlrddq52Bcc2D1fiK0Da78o/X/
 ZCacfPAQXBD5/sk4/fNTOmzzxoN0Waa0EkvPEGwvLnns/5SvfJzO2JkAQuckttn59fZ0QX6GYXa
 yDm68KJnAUfuG5+TEEqqfToFlwaIIpLfXpOs22QFaTy5bRBHUuTA3pgXZhlqrZ6NXQqJQSOEeh9
 DmSnhb7MeqKtJ5slZk3lMAQhPWhktVrP00E1adE5cB48Vn/bUHAkGrSRs0uzmldNJ3ONcggyw4d
 oqx27n1/11re5BU7NRVdLJYxW81bgeEwfbsGTbXz4+W+TKvBQcaYLTDlmPkuUjFmHCExjjTmpAF
 cLkEp
X-Received: by 2002:a05:600c:64c6:b0:4a1:e69d:90e8 with SMTP id
 5b1f17b1804b1-4ba0937fedcmr48673125e9.22.1794407678906; 
 Wed, 11 Nov 2026 06:34:38 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:e16:1f01:f60:9877:8ffd:39bb?
 ([2a0a:ef40:e16:1f01:f60:9877:8ffd:39bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08e354b0sm50553685e9.1.2026.11.11.06.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 06:34:37 -0800 (PST)
Message-ID: <0fd9744f-e119-4ea5-9026-f86673ffd0d5@linaro.org>
Date: Wed, 11 Nov 2026 14:34:36 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] test: Pass location of built tools to binman
 code coverage test
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
 <20261110-qcheck_fix-v2-9-1c76e0b68f29@linaro.org>
 <4d2d71bf-0c53-45b0-bf75-60473d6274be@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <4d2d71bf-0c53-45b0-bf75-60473d6274be@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/11/2026 15:06, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 11/10/26 1:24 PM, Andrew Goodbody wrote:
>> When running binman for code coverage tests and invoked by 'make tcheck'
>> some tests can fail if they use system installed versions of tools
>> instead of ones built from the tree under test. Ensure that only built
>> versions of tools are used by passing the location of these tools to the
>> binman test being run.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   test/run | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/test/run b/test/run
>> index d1654dffb5f..0857fc14c9d 100755
>> --- a/test/run
>> +++ b/test/run
>> @@ -93,7 +93,7 @@ run_test "dtoc" ./tools/dtoc/dtoc -t
>>   # Code-coverage tests cannot run in parallel, so skip them in that case
>>   if [ -z "${para}" ]; then
>>       export PATH=$PATH:${TOOLS_DIR}
>> -    run_test "binman code coverage" ./tools/binman/binman test -T
>> +    run_test "binman code coverage" ./tools/binman/binman --toolpath 
>> ${TOOLS_DIR} test -T
> 
> question: Quickly reading the code, I'm not sure this "ensure"s that 
> only built versions of tools are used? binman's code is very convoluted 
> so it's not easy to figure out what --toolpath actually does without 
> digging deep into it. But if you say so, then fine with me.

I can reword the commit message along the lines of "Use the toolpath 
option to point at the locally built tools so that these built versions 
are chosen before system ones.

> question: Don't we want to (also?) start PATH with TOOLS_DIR instead of 
> end with it?

That is actually an alternative fix. I chose to add the toolpath option 
to make it match the invocation of binman a few lines above. With that I 
can drop the change to PATH and make it all a bit more consistent. There 
seems no need for both the change to PATH and the use of toolpath.

Andrew

> Cheers,
> Quentin

