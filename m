Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C00606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UQlS0/yY;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Te9m1EzZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A91AE81221;
	Wed, 11 Nov 2026 12:52:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k8JW9anQYIbk; Wed, 11 Nov 2026 12:52:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DB84E81206
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794401567;
	b=ZXwQ41TubwmfQ/7zqM59TOVHTS0nL5H2yI7sjqsV3o1Iao3JHH24xO1YW4Ynvxd8wCvh
	 DSFqmtL2Pb+J2PG9+YIaEMYuEHHTa/FhWOyh9zKsXsXkR9L/5yzNrIt8QNZmxpFkGNsac
	 wLtPgTtLoVBlxjiN2Qn+inCFo+mm6LImcQpUMJ20s1BdVIi1hyHSPfu7pNWPN9XjOt1rX
	 ZgZL1AhaLN84/9L6Klz67OgcxFFk5yp3KSHKmSTd5Vvcq8gYZiXdUZk0qyWaSgvcqJy0U
	 Q4y4eiYmgIAE7mNeyBj1s7/O6AeJSAV/iqe04k1iR8weMWqRw8gbmu4n+32rbDDqZDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794401567;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=H76bdwHJcziQMI/cIBv+/vLV5e1GkafrZPaoM30LE20=;
	b=l1NuWGgJ3X4ggRZ9WCrAgL4K4HozgaOw6N5qrsLXs3jHEfyRRbwcLWwjbD44wueTT7sQ
	 x03x/9gtpOLpCTq5d8P55OFJ8adGvFdBZS6au6KjZygFo2JdHieVYNsH/6scCOHaVVxGi
	 tD4IxmWiY7ePreN5ZGOQQtmTlWjvgovYbpuUoH2oi/0yrLNKTr/Jf9WZfWRQtvHUdjT2I
	 a2/VsypzdwOGFQDKS3CH06SvVRsGydBnJ5QtwZTth5sNOA0E2gSQjwp5EoQ/8RS60gOKt
	 C/WydlwPOCU+nOy1AzNojNVZpWzGf8othQugx3NvrEL97MxdpIyeUnpuIa4b/nAGsRg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Te9m1EzZ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794401567;
	bh=H76bdwHJcziQMI/cIBv+/vLV5e1GkafrZPaoM30LE20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UQlS0/yY3WGa1IecLDhRcfR/dYmprmK0jU/mihKbdk4qezkD9wzd+b154P5JhTWMn
	 uiWMLxFgEITAbBTNWRY/q8j3vT8BAtPVB2Iacb7EM02tygqEr9wid8HORryHQunowX
	 K0UAgYnUVKAx8/PiWamCiHF1R4BR4dqcK3AA3N5iGKWZ/inpyy5bvhqrS8Y4Uer1eN
	 7sAizMvFID/ouUmarjBK7ohIgf4vMTTwK7qeU+R0hbsYd2eb3dUiabYcmtXxrOSE9A
	 oz4KImtImTkAiJA4/+nTyjeIBA1lQ7Vul+kdHncc0nxPFVhPeN/+BMCeUGubxXm11G
	 pKFL/kwCcUm7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB84E81206;
	Wed, 11 Nov 2026 12:52:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D0BDC2FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C223281174
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:52:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PdCf0xwHOv_l for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 12:52:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2439381218
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Te9m1EzZ
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2439381218
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:52:43 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4922dbcee23so1810759f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 04:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794401561; x=1795006361;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H76bdwHJcziQMI/cIBv+/vLV5e1GkafrZPaoM30LE20=;
 b=Te9m1EzZqgu1sTj+pavyJ9g9K0UEZLUkbgocD9dDDcS1hLpVh9fCnRLA78eJDK8O/n
 eSHyJvDtlAcWSlePhNleq96h+xMhrnkACdDNqSEKHuOSqHZxzfMiTexT6cBM1WkAnX0a
 z92DSYzJFVAY37vVZH95l1q/8mkqpYCQLyIUqfR3mDdk9/P+cv+0fgULl2iyeO8gyCJc
 q5ECxfkCNyuFblb43yHXA5jIE9jw+WYiz7ey8pzVekmNIsHqY12IB6vIxJWXI6s2GAlN
 QTa5HbQP9M+pX+0h17W7OwHv7zNODX397MLve758zztlO6b+iGq8q0Y+AsaeGqVSGuAO
 4qPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794401561; x=1795006361;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H76bdwHJcziQMI/cIBv+/vLV5e1GkafrZPaoM30LE20=;
 b=dUs73nvE1HFGbrvJ4wE3PpsSkWNORXMNBLcsoqobIF7I2WJz++02TpwfQWk5nToqbn
 2+T6/HxWbG+mxSagk/vnDzCnHvjMoSQDRi7km0gM46r1fkupl4rm6NRM49xoO9J1FY5n
 lRGSZoux4VGpbem5UR4Q7THPtNOYZe6tnrV2nNN04VckVzsSvbbF/dmWbBfiwKRsmFwY
 hAW01vY5BLrfYmy/qYtP2oiM9TaOuM/uGW3KwYNgpYgcj+WFF5BPvG7mGTbqJpL8g6nt
 U9UfncDAhBK1guRZ2m6jLEnSMNcSyklGRsMj+nrW+td4mfymMqLb77SRRkF3o9sExTgb
 ap+w==
X-Forwarded-Encrypted: i=1;
 AL+hErEDywgLevvs/cZ9ilvhJAhKT4ZYEYsVTM7deAglGsQpsVFfDwAWCaTzmL8e3td1NLlHacs1pK4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/F03nWwJGw/97rbzpPS1Iy6H3BBtj+iaLX4MA6euE5tpD5P0OF
 lXPJ8oH7lb9dHslKm8weBRxjjPlCL2/gD5C5aYvYZdDObajj7P6y1V+yT4V9jMuptc4=
X-Gm-Gg: AYBFou0rZ//Z+kmfn9skuJzhPUCCQLS9SKcRCe+0HWO1aIxDXGbt2/tfqx+Yr7GMISO
 9201mjybGAVYGJJ+WlDO6Pj0MFQdcVSfBm8u2zzaHn3jvBHFV0VMq7e6kmnx/80+cosA3im478E
 k6WjoDomzImhRr0Z/0/Qx+8bUnjm6pyb0a8Mb1E6qUT+kZmSamFL9s62U0WA0jJD4Hmsi6uXPxy
 lDK8MUmYUoQXLzOWTHNCSEsGPKwX7lcdvG1M97VxFiFni6ApI9bFQ8KE8ShrzXJFFffMb/1KSTg
 A66U62V5ab0y0bzxKzq0ZLpOyedr47plk4Z1yPYh1MFmIkK1PfaSrOsbGqs76Ok8qz9YZMUlTxy
 SO7xGZAvktWo7dAFz5tQGR7958V0gqfyh9uE7W2GY0QxC7QUghGw3tHkr+PNcY11rMSsMlLc8W2
 mss6Y1IUe0KP8+CdsVnydF5pgJYim3llqdgmjnsw595a+gzZt3N4gSJUmB9SAc8psTVUQ1xstli
 D38cMSzWlkYhV2wV1p9JXZ8909tuhZeEzY0pcshlq8TfE41SkUG4oIQYrBB07m0YykdsHVCmgIS
 mu5uoOnJwB9ANR/el//ekpEOI30Jc2ZsbzU4cQomJ6XiEIOhUx3jQRQXG6FH9xQfLDPiNGYTrYQ
 IcDyHeDX045+IT+NeiTCOnB40kw==
X-Received: by 2002:a5d:6f08:0:b0:498:7be6:8d69 with SMTP id
 ffacd0b85a97d-499c3aaa3a9mr3583958f8f.6.1794401561477; 
 Wed, 11 Nov 2026 04:52:41 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:e16:1f01:f60:9877:8ffd:39bb?
 ([2a0a:ef40:e16:1f01:f60:9877:8ffd:39bb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498365cbeedsm10821608f8f.43.2026.11.11.04.52.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 04:52:40 -0800 (PST)
Message-ID: <e63e9891-465f-43d8-b32a-0b0bc2a57ed7@linaro.org>
Date: Wed, 11 Nov 2026 12:52:40 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] buildman: Cope with CPP="gcc -E"
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
 <20261110-qcheck_fix-v2-11-1c76e0b68f29@linaro.org>
 <93a130bc-3c19-4ab6-8826-cf8bf76e4fba@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <93a130bc-3c19-4ab6-8826-cf8bf76e4fba@cherry.de>
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



On 10/11/2026 15:29, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 11/10/26 1:24 PM, Andrew Goodbody wrote:
>> Allow the use of "gcc -E" as an alternative to "cpp" when set in the
>> environment as the value of CPP. Accept it as a valid command for
>> running the preprocessor and adjust the test to not depend on a fixed
>> number of arguments. Also split it into parts for constructing the
>> command list so that the validation for running a command does not fail
>> when it tries to find an executable named "gcc -E".
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   tools/buildman/boards.py    | 3 +--
>>   tools/buildman/func_test.py | 5 +++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/buildman/boards.py b/tools/buildman/boards.py
>> index 5d5d3a3822b..111789f1bd4 100644
>> --- a/tools/buildman/boards.py
>> +++ b/tools/buildman/boards.py
>> @@ -244,8 +244,7 @@ class KconfigScanner:
>>           temp = None
>>           if b'#include' in tools.read_file(defconfig):
>> -            cmd = [
>> -                os.getenv('CPP', 'cpp'),
>> +            cmd = os.getenv('CPP', 'cpp').split() + [
> 
> issue: str.split() is not safe for shell commands.
> 
> I think the proper way is to run shlex.split() on it instead of a simple 
> str.split()

OK.

>>                   '-nostdinc', '-P',
>>                   '-I', self._srctree,
>>                   '-undef',
>> diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
>> index fce615ba8b8..eb13589ba17 100644
>> --- a/tools/buildman/func_test.py
>> +++ b/tools/buildman/func_test.py
>> @@ -378,7 +378,7 @@ class TestFunctional(unittest.TestCase):
>>       def _HandleCommandCpp(self, args):
>>           # args ['-nostdinc', '-P', '-I', '/tmp/tmp7f17xk_o/src', '- 
>> undef',
>>           # '-x', 'assembler-with-cpp', fname]
>> -        fname = args[7]
>> +        fname = args[-1]
> 
> todo: add a comment with the new possible list of arguments
> 
> This should explain why we are using -1 instead of an offset from the 
> beginning.

OK.

>>           buf = io.StringIO()
>>           for line in tools.read_file(fname, False).splitlines():
>>               if line.startswith('#include'):
>> @@ -424,7 +424,8 @@ class TestFunctional(unittest.TestCase):
>>               return self._HandleCommandObjcopy(args)
>>           elif cmd.endswith( 'size'):
>>               return self._HandleCommandSize(args)
>> -        elif cmd.endswith( 'cpp'):
>> +        elif cmd.endswith('cpp') \
>> +                or (cmd.endswith('gcc') and pipe_list[0][1] == '-E'):
> 
> question: can't -E be anywhere in the list?
> Should we use "'-E' in pipe_list[0]" instead maybe?
> 
> question: what about "gcc --preprocess"?
> 
> This is the long-format version of -E according to gcc(1) manpage.
> 
> question: what if we want to use clang instead?
> 
> It seems like clang also supports -E/--preprocess.

OK. Updated to allow gcc or clang and -E or --preprocess anywhere in the 
args list.

Andrew

> Cheers,
> Quentin

