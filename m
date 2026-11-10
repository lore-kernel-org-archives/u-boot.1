Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998B4606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c7/oy6bi;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cpjswIKK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7086440850;
	Tue, 10 Nov 2026 17:31:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2V3qMvlu_kw8; Tue, 10 Nov 2026 17:31:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AE62F4086F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794331915;
	b=kv/C2XEwR0CDjr7xfCc0VgITXdLeUHkOetMC/5hDdLiXTHxkl2wGEBaulgvwbJY9xati
	 +DJGTHPR5pwVGAIzvM/MBXikxKi0v/gahCIs054hUo6voOsxLlA6ZO+BBs994mLoejQsB
	 WqGGsa/DoQSm9vvXtwuth9e3GZaacYcrIgz5klnGuWjMU3wlHpL2rxzxM8gC69dicbmNv
	 sL56vmUdq9QVaeNmAOOdpA2vlu+WY2rnhtcyFORLPnuojpvlCCwFqgwK5olKUn/PajKXu
	 rzO6fhNkeuS98HnC2qo8MBQbRSH8x3kYj8k8ihJTYnn/bEcp8y9LGAUrJ/pVUqTziDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794331915;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pDe6HzROGWpHvUwzKIcWmlEofU/qYty3+/6KEp8r/C0=;
	b=lrUuBUz7tENbzsGOteRzvAVkl4Dyw20sdBFEIUlBpqn/REQ1QfjC6jcStQoBT1I1bNsK
	 nFDUZWY3mg0N+j2/3koRkty3iOqGFBB7XbpKWKkTnYW3E9YrGtw4VqgK+4fMS5kBvVDUj
	 uR0pPjjG4sVsOrajaqy7dXgJd8/78ub7rdE0JgD0AlONcA4C+0Tk0R63WYKvE/lWY1tG0
	 FNyQk788ddVbqUASOhyA+0LOa6aqpMA/rTKASyBkF/ktDkf3g7GAgg1MTtKrzECs/jfvK
	 aM0SIF/VJL6DirgyJxu9irf866Q0+Ux7mvaLncuqGZ156KG1aPiBtoOgfNZGdv77zdw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cpjswIKK;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794331915;
	bh=pDe6HzROGWpHvUwzKIcWmlEofU/qYty3+/6KEp8r/C0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c7/oy6bihT5kjNONfMwlYkjRvDTeAkG13MbzVrP25EJFvfb84xAPapBxzDHiKTZ/3
	 yd1L/eY/7c38TR9UOwAVFFybbBNosIQGt19FtGAmlL3icWvVUggWz071lQD+UVDMyT
	 SerfkBDnsEs7H17G27PaLl4z2ZosK2176jB74eCQxAGXAeWKT+GjGr4yMH6w9ZHlB6
	 5IWi0E8kM/ysRnsJPxm33R6WB/vVhPR4a/C96epIitFRRfaAbOo8FvZoUWvwr4CMz9
	 De+gSTYsmC44IPX8sl2dRsEaHadBX9zZN3eUqGJBetpQ7hWcO28kujY8rGG3NnE1Xs
	 WOtVTurie8KZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE62F4086F;
	Tue, 10 Nov 2026 17:31:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C5AD388
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 17:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7110E4086F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 17:31:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ncqz8yoIDqax for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 17:31:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB64740850
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cpjswIKK
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB64740850
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 17:31:52 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so634104f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794331910; x=1794936710;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pDe6HzROGWpHvUwzKIcWmlEofU/qYty3+/6KEp8r/C0=;
 b=cpjswIKKT/zCBKpdyjOEo5SV/G2mhanof/vqtSVCVm7CTEXanKvb4JhM1Rll8Gy0Lg
 +1th8CrzhkeTTZ2Y9ha0SaegMTrJULcTsvtu4OGGMGvKDROY8RObtk0eVuSS3/FkuFfs
 /jQHOtiZqNh0Y/DMkG0By04m9XGqcYeTdkX2brj0cOLrAb6nZS0yenTw2WfeRXYxDHPx
 c57IYrzZm/sqwXWTk4cu4x3PR1V+mn0CJaxd0b98bXwxNphPEKxvT31LAfxmxIx3H+fr
 hFNev1wU04dFZOeDQ6RXcqJQHbChYAhx2aQu/ZKHQ/HtPOsaAv6D3UQdihL6FCLGa2yp
 1BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794331910; x=1794936710;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pDe6HzROGWpHvUwzKIcWmlEofU/qYty3+/6KEp8r/C0=;
 b=jFaQfhfsqsj5SaMAwyWixMAG2FK1PEMuUeFRVoB2cmKfF9kyeHCD6W0saQu6nnzYDF
 CLj7m3d8BZR6HGw1Odv9JsNHEgLu5gKLm0NO6pI0caPJXegHkBLGSd5pjbXuHqsSahK+
 qVX3FChRNWyRkGV/3/KJsFF8zsJx94Zop01VNZDnT92lwKpeHhLX37bLWpcdfvOYNQsZ
 OV83npzLvLrQOCk/HNQq7Kqv+DrcsDGchLiPmphO4FbZtRH+UgZUJFLb4idd6wmEUuyn
 XEMLNZ3UX09k/e3VBqN21iNAZdxEojsmBxQasLXFGO91qy0+WFfbyYMX6d1Z09HuwQ9u
 PWYw==
X-Forwarded-Encrypted: i=1;
 AL+hErE0isrUDrEy6JpQuBZS7vBaowHi1jGq5d+Ox/L5xp4Q9017AygJrL1QAiWbg4tpdnj1qNMXp+E=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+NfZYhTgHvU5m2tHXjoy0OjeT+zGbd3MtRpgoiqFNuHhA1oyA5
 UgoR+VUpu32aomE3ditJo9BMMpkWjTVri5USvlrFjdtkXmqrFT9Yp+LqgNJe9tT/RKw=
X-Gm-Gg: AYBFou0rqjcKCwdmJApuf0djfPtUYE2wGOJRSFv1AWiRbKChXVK6s1A7Eagw38Pm1K8
 rPgilkLvk01xzNp+8euV61LSov5XWDaJXWDuUfFYaoY89wUzg1jxGcpF+lb2aaCk3ES15y7+5Hh
 ASuI/ih9zfLQV0/VmWvROUVCDAhZaZ2BV73lRSWv3JLYKLPBzbBwDZDYKr2rgSABPkmaGCoUVEw
 6hWoAJeH0YgoDoEjbY+41sBxV9DygVXVsujgSzDNh8Ue6pGdXsYBh49e0c8QBOQqrkppnRJvQGz
 FwO37CmOLafJL7kww5aQNF7pK+CBabgNF6HyskmnCBgCAxM2d1NZ5YB6w8c8xdgsytg6NSEm4ip
 oyiR5KBYDOtRommsGI8dm3NsvxHEvEjzTzYA0s8qwE1UUn3tSKVQK9MbAq9Ya8bAx+FmL4DKilS
 C4JSMwp4vVR8lagRh59VlJTT93avH8Dyq9h1JXxqoRda7tjOOZTw4bPzljCzLMWkm+5MGiFpORy
 owpGTjJJ6kkBCX+ymbscmvD9iqiurwNwtfglDVGEtn7TisILLXCZfh9OOMQh7DV3VZGvy6UKUK5
 0hCuf+hr2i1seNgKjlr3kL3G1/SH0GZrOD0l2ZHcV4DP8sW5r2TlurcnxhuBFTgWKAJ54oFExx5
 ELUdLBw==
X-Received: by 2002:a05:6000:1a86:b0:488:57ad:d5c8 with SMTP id
 ffacd0b85a97d-4982ba3297amr6405894f8f.3.1794331909987; 
 Tue, 10 Nov 2026 09:31:49 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:e16:1f01:e384:fd63:c1b:f384?
 ([2a0a:ef40:e16:1f01:e384:fd63:c1b:f384])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-499823761f5sm710123f8f.2.2026.11.10.09.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 09:31:49 -0800 (PST)
Message-ID: <6485ce1d-2b5b-4800-9782-0a6276209fcc@linaro.org>
Date: Tue, 10 Nov 2026 17:31:48 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] test: Fix test_basic file system tests
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
 <20261110-qcheck_fix-v2-12-1c76e0b68f29@linaro.org>
 <4c272bb8-5ac8-42e9-9338-fc9e13cfeca4@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <4c272bb8-5ac8-42e9-9338-fc9e13cfeca4@cherry.de>
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

On 10/11/2026 15:39, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 11/10/26 1:24 PM, Andrew Goodbody wrote:
>> Ensure that /sbin is on the path so that distributions that do not have
>> it will still be able to successfully run these tests that need fsck.
>> Add a forced clean of the newly created file system to cope with the
>> fact that there is an orphaned file on ext4 that will cause the
>> integrity test to fail later on if not removed now.
>>
> 
> question: are those really related?
> 
> It feels to me that those should be fixed in separate commits?

OK.

>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   test/py/tests/fs_helper.py              | 4 ++++
>>   test/py/tests/test_fs/fstest_helpers.py | 5 +++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
>> index e3824b2c1fd..48b047aeefd 100644
>> --- a/test/py/tests/fs_helper.py
>> +++ b/test/py/tests/fs_helper.py
>> @@ -250,6 +250,10 @@ def mk_fs(config, fs_type, size, prefix, 
>> src_dir=None, fs_img=None, quiet=False)
>>                                         shell=True).decode()
>>               if 'metadata_csum' in sb_content:
>>                   check_call(f'tune2fs -O ^metadata_csum {fs_img}', 
>> shell=True)
>> +            # Cannot use check_call here as it will return an exit 
>> code of 1
>> +            # as it modifies the file system. The -f is needed as 
>> although the
>> +            # fs is marked clean, it is not really.
>> +            call(f'fsck.ext4 -f -y {fs_img}', shell=True)
> 
> nitpick: just use an array to avoid shell=True
> 
> Considering the rest of the file still uses shell=True with a single 
> string, I guess it's fine for now but we should really think about 
> getting rid of those.
> 
>>           elif fs_lnxtype == 'vfat' and src_dir:
>>               flags = f"-smpQ{'' if quiet else 'v'}"
>>               check_call(f'mcopy -i {fs_img} {flags} {src_dir}/* ::/',
>> diff --git a/test/py/tests/test_fs/fstest_helpers.py b/test/py/tests/ 
>> test_fs/fstest_helpers.py
>> index d25326ee993..6164eca476a 100644
>> --- a/test/py/tests/test_fs/fstest_helpers.py
>> +++ b/test/py/tests/test_fs/fstest_helpers.py
>> @@ -3,9 +3,14 @@
>>   # Author: JJ Hiblot <jjhiblot@ti.com>
>>   #
>> +import os
>>   from subprocess import check_call, CalledProcessError
>>   def assert_fs_integrity(fs_type, fs_img):
>> +    # Some distributions do not add /sbin to the default PATH, where 
>> fsck lives
>> +    if '/sbin' not in os.environ["PATH"].split(os.pathsep):
>> +        os.environ["PATH"] += os.pathsep + '/sbin'
>> +
> 
> issue: modifying the environment like this is a big no-no.

I copied the code from fs_helper.py but OK.

> Modifying the environment like this should really be last resort as it 
> breaks things in various sneaky and random ways.
> 
> check_call() takes an env parameter, so copy os.environ and edit the 
> PATH key, then pass this copy as env parameter to all check_call calls 
> in this function.

Ack.

Thanks,
Andrew

> Cheers,
> Quentin

