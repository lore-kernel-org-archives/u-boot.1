Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE89606A320
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vUFlL73n;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=R9yf8iYL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1A4F40968;
	Tue, 10 Nov 2026 16:09:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ziwTRJRNLwfd; Tue, 10 Nov 2026 16:09:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 33BC3408D1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794326960;
	b=MVQWilQz2vyqccd869Zfecl2KtWjK9Oj6o+kIbG0Z6tDOaC/A7qMetCkjQiGpXgyfWuK
	 iurYnFtZpxdqNibk76Wn0TMdudY6QEH/hGLrW30d7dl11xxJPGTL4vBvAKJUHh6Z/D+/I
	 Wocm/kCzOqvvibQ56e35nyP2Syj//y5s/LXDfs783J66oi0zKa9u1vrXS2BIJorX3n0y3
	 JNaXIGsebH7lGUb0nahOBIGXoMIuk8u7jwbSxYmjBgeFQZgXdhlamiTxvBHf9OZClVK0g
	 CXaG0l4GBBL0e6uocoLbYOsDFbFL55Zgmw4vI9np3fCsopLwjJPId4p/D4z4tiviqBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794326960;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/QE0Ar3FkG96bmq5VM/Y3n4ezrxjggYooSCloRaRJgI=;
	b=NgP1dc0q1vJ93KumXiiAJpHB6O/x044NM8wFtaOKUr5tLgUj6UboGmjN3VgevNsEyU7v
	 AibKsScDAPGOkeX+Kc7zW6CxzH1Q3DLi3ULmGjOBdDE2ckKqws+FPQU2CnZWsc3NX10tW
	 nUGauhyp51Sv2j0Gb4mJloceUjnu7W7TlOgPvkRrSE1PWkli4DBZqMIdnB3v0Uz7yONPl
	 VV03+UXxAzXMY2fAWDIwtWgqZFDUQYT/0689YPxgRgrca7NkeKX1z2cM6J5gZ4gTYjscM
	 a5J2ZFjhj6OIBkt3/DUMGhm5RQ5N+r4bJJTvVa+qZ67JjlJn2W9gM1aDHhCGltndhcQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794326960;
	bh=/QE0Ar3FkG96bmq5VM/Y3n4ezrxjggYooSCloRaRJgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vUFlL73nejZdbt/AMVjBmmQfgWsMPTILF6lrntFaMrh9ozKKL8+vK/EbTn/ATGr0s
	 5jsVUuWIRfppNIq7QvRjHin+F5Ee1MtOJ3nF0uf2d3pupK0yH0l0R/gHMF/nRe+G/v
	 8IjAABfahkGAMpj92FccXCoHctGDKrFCxno/rap3DEr8j2hlsfflTuurJVmEgETuJ7
	 6afA8ayu3MeTdzFzPICYcfXfDHUap0Nia4q21i+ZUQn/pQ+uCA+zkFLScs+OZ53Se8
	 1KSbFsrrcExobHjtT9LbXxOJi576E+M7uwZC0sNC0c7jmoqlBc+ibYAluSZd38kz9F
	 HkI1fzMa5sJhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33BC3408D1;
	Tue, 10 Nov 2026 16:09:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CDF33731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 16:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF2AA60847
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 16:09:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WVm3eEgjxD_h for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 16:09:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 92C836080C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=R9yf8iYL
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92C836080C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 16:09:17 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b58cb69927so3489068a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794326955; x=1794931755;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/QE0Ar3FkG96bmq5VM/Y3n4ezrxjggYooSCloRaRJgI=;
 b=R9yf8iYL/MRAz3kkIGA+RyFylVVrqp0l6kxkPWq0iiKf/9rLilplXAOeXJfydWzhok
 WV2sPDtZI4VxiPEylF9EWaD+SDcGqGSvp4vwWZTVQVzlKIZHG2mo3MaOCvlvWUjiEr+K
 VeZTC4xIGxaMHuuReiQ9shqluK1B2GCtNaXWff7pHLwRANLYecNtmLWrvsChDckWmKVj
 8I1e/01fb9ZetbqpG/ThxZ8F1VBAsjSjjdQLnWHG6Ulg6yEDoBOgLYMGGzdUgt57ouuy
 XzJq7sd0BkJyMpwS2yZX4SwY5MyrvTLWeg3nQKYAMjxdNHd2E+IjSL7d/BoSgG33L6vL
 rw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794326955; x=1794931755;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/QE0Ar3FkG96bmq5VM/Y3n4ezrxjggYooSCloRaRJgI=;
 b=RA3JUNB/k5bSBchnlXLqys4C0pQa460rGUTDPAFKmMRjczgjtTIyAsseXMtCpxOn/S
 5WwqGrKR1WIKV0adTD0ruEgoSfZn2+/H18WGT4Kco3tULrztAbexbRXM7NOlyWqjc+hr
 ToNi9VyF/AC+U/QTuvb47v9WDOue/Fi7sMCVa9XkSsVmyDZBBQlQW5KMS/4Gksrwwt+g
 GSBD3BL/n7DevkKhY8fQdY7XMWYAuQi6G4uWpo/2p5s/o1PSCeTinwnOmBrJ3p5d3GQr
 SafYXQFS2dVi9L5PElZ+3zXhIgOmPZKlp2b/B0aktDATmdKmU4fDQPL1pdk7vYp5Emhu
 Mt5w==
X-Forwarded-Encrypted: i=1;
 AL+hErGmI/uVNvNw/NO1m1nVByhV9MP0vLQWIgof1uvuNGEOJBgBmj4+/b+Bh/GQ2PgzIRpGB/rSpJM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z94oXGDoAm8AJpSwEgSi9Im8ygdTQGzIERSSC05iaUaoaoHVMGF
 ClxnGlxNXT7okfvE0Wya97t/k7O/y2rxt6VOvNtpSgh7nKPcRa8DT60IEJnweYZsNws=
X-Gm-Gg: AYBFou3UzXAAjj0qzsaNNEAZ7AGW9mysJT1n2wvdaKXoZkUALRICTIqKzPxyjsNlRT+
 GZFbOqjCPG7KHmgxnwvIkEqrxpAzs4mAHO5e+rJjtVC2LayKIp5NEW6VYd6trrPzapSbu8yr2Yd
 utACZDrAa4eOuLbufvdXipZXnjBppbENXYJmsqc25jVPqeeMAbaNLEfNYMDF2alwdbBK7dVb+rq
 mRv7bSBiLgQ6oj6GSoiuZZ74q8ENVdq78mJ4dsa3PLF1JLIfy7Vt2Tvpe+oXU7riQA5iU/Z2KD2
 BLvJJF0OSeC7GDTT8Jmvr0FtXxN5Ws/TE8P58tdNt71jgtio3JbNRdL42Zb4XxEDYDlxAwMXZeh
 ikrytKIjJCaNomSynDljcXuLuZs3LPXtouX405RENTHfBx+ENaByTvKP3q2hZb364o9nDeWZrUL
 BkvNrwh1ec0sjgT0nOWBoM0msFS/b1+lLePVAk0TsC1s77tqkuW1LtL9CG2srrpLVAWO9ifHU8H
 tvWSkqcjZ7DXp5DPWc9Vc826oi/h5fMztAJUORp9ywSJsd5bWB7XqdF4upeAZKPAn2vzQXJ4bnV
 okIM3ktPlH3fVMz7qU25bY9o52LciCX+5Ci1gSpQHfXhwrCZP3/wv5uUOdKIeaoldMkLE3ItRBM
 GGQn3
X-Received: by 2002:a17:907:d40f:b0:c4d:31ca:e316 with SMTP id
 a640c23a62f3a-c5063441407mr1004466b.20.1794326954828; 
 Tue, 10 Nov 2026 08:09:14 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:e16:1f01:e384:fd63:c1b:f384?
 ([2a0a:ef40:e16:1f01:e384:fd63:c1b:f384])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c504a56f377sm127214066b.18.2026.11.10.08.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 08:09:14 -0800 (PST)
Message-ID: <db7f8508-22c5-46d8-aa33-13bb0356b9d7@linaro.org>
Date: Tue, 10 Nov 2026 16:09:13 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] dtoc: test: Fix coverage by adding test
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
 <20261110-qcheck_fix-v2-5-1c76e0b68f29@linaro.org>
 <8b5a84d7-47ad-4c3b-90e7-74399d9d258c@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <8b5a84d7-47ad-4c3b-90e7-74399d9d258c@cherry.de>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/11/2026 14:25, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 11/10/26 1:24 PM, Andrew Goodbody wrote:
>> Use of 'indir' in EnsureCompiled() was not being tested and resulted in
>> less than 100% code coverage. Add a test and supporting files that
>> depends on the use of 'indir' by placing an included file in a new
>> directory. The dts file will fail to compile if the new directory is not
>> added to the search path with the use of 'indir'.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   tools/dtoc/test/dtoc_test_include.dts                  | 13 ++++++++ 
>> +++++
>>   tools/dtoc/test/newinclude/dtoc_test_include_file.dtsi |  7 +++++++
>>   tools/dtoc/test_fdt.py                                 |  7 +++++++
>>   3 files changed, 27 insertions(+)
>>
>> diff --git a/tools/dtoc/test/dtoc_test_include.dts b/tools/dtoc/test/ 
>> dtoc_test_include.dts
>> new file mode 100644
>> index 00000000000..b5ef647c1b6
>> --- /dev/null
>> +++ b/tools/dtoc/test/dtoc_test_include.dts
>> @@ -0,0 +1,13 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Test device tree file for dtoc
>> + *
>> + * Copyright 2017 Google, Inc
>> + */
>> +
>> +/dts-v1/;
>> +
>> +/ {
>> +};
>> +
>> +#include "dtoc_test_include_file.dtsi"
> 
> suggestion: move this line close to /dts-v1/

Ack.

> I was about to dig deep into fdt_util.EnsureCompiled() to see what kind 
> of magic it does to automatically include a file because I had 
> completely missed this line. In DTS, we usually have the #include follow 
> the /dts-v1/; line, can you please move this up so it more closely matches?
> 
>> diff --git a/tools/dtoc/test/newinclude/dtoc_test_include_file.dtsi b/ 
>> tools/dtoc/test/newinclude/dtoc_test_include_file.dtsi
>> new file mode 100644
>> index 00000000000..f975005d023
>> --- /dev/null
>> +++ b/tools/dtoc/test/newinclude/dtoc_test_include_file.dtsi
>> @@ -0,0 +1,7 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/ {
>> +    new_node {
>> +        intval = <2>;
>> +    };
>> +};
>> diff --git a/tools/dtoc/test_fdt.py b/tools/dtoc/test_fdt.py
>> index 66d346b1272..a63c860eae1 100755
>> --- a/tools/dtoc/test_fdt.py
>> +++ b/tools/dtoc/test_fdt.py
>> @@ -1105,6 +1105,13 @@ class TestFdtUtil(unittest.TestCase):
>>           finally:
>>               tools.outdir = old_outdir
>> +    def test_ensure_compiled_indir(self):
>> +        """Test providing directory as indir"""
>> +        indir = os.path.dirname(find_dtb_file('dtoc_test_include.dts'))
>> +        indir = os.path.join(indir, 'newinclude')
>> +        dtb = 
>> fdt_util.EnsureCompiled(find_dtb_file('dtoc_test_include.dts'), 
>> indir=[indir])
>> +        self.assertEqual(dtb, fdt_util.EnsureCompiled(dtb))
>> +
> 
> question: do we want to check the content of the DTB?

Answer: No.

> Checking for the node that comes from the included file, to make sure 
> the included directive actually works? At the same time, that would 
> essentially mean checking cc+dtc works as expected, so maybe checking 
> too much in the wrong place?

This is about checking the use of 'indir' in EnsureCompiled. It is not 
about checking the functioning of cc+dtc. If it compiles without 
complaint then that is good enough.

> Looks ok to me:

Thanks,
Andrew

> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

