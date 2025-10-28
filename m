Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ADFCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 11:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13EC6832AD;
	Tue, 28 Oct 2025 12:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M7wkHvtP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15787836D1; Tue, 28 Oct 2025 12:06:44 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CF6880422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 12:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b6d4e44c54aso1013753166b.2
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 04:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761649601; x=1762254401; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bu8b8EBWy9PGRtTVN9orpdSefi4IGEOp+UIV//BCE3g=;
 b=M7wkHvtPWyiw1rhDeQqGt1swI5q5pHCTerxL1r0Ja6XjaG6Jv8EC0jhWA95ys6kcoS
 xKlxvQ3T0Zkkb5VK+uZtXayFWDp+QpdUWTPbAwBIO0sWLzR42160uZejLs1afs02pSWq
 PE2h9XVMMXHFQlR/+3ZT/YQuii59LKktJD2hU1wo45KbMfERVgkvrMDiRXafEUPdpm0f
 r70EOMggu5RqUXTYcWbxMFrSYbQyxl9kCZ2iMaFvMEuRIaX6QQTFos7EavoRE2DSmARK
 95NikWVh+LeHzRSC0MVk1hKMFWbbDQRquqGctDU3pQOXnX35XDsDBjVoXRn/sQYqqx+m
 OWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761649601; x=1762254401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bu8b8EBWy9PGRtTVN9orpdSefi4IGEOp+UIV//BCE3g=;
 b=RrrXsaYyEnFylK83/WauViThpnusYULgGC1yzKh1i+mcrfIWj4+ffYuAag27vMXy8Q
 +Q7RZpJGhAoFD4U+u4s3MQH7PhGWWdq/7x096r/kBXLE8BFfkfFUXBq0QRldRiNcsFGp
 3f880WXn7raNyYxWYQh2YP1E8taJt35MqEP+GtnqOkLhrC8dVXKl9yP/bXXsKu1oI0pm
 E7AN0tH30hmBSaxwg26/L0IaWsqVBQfm74sDxP7y7hWGCObkj3JRWBKyM67sdlQr27gs
 caiSY6oruYcMWHjsJmTT0wUs3+x7XqpUWxJUJjj1zeu6ROlr8ql//eZVX4O/v4Qd04fW
 lJLg==
X-Gm-Message-State: AOJu0YyrNxdtWo80OsQ1c5AmULL6QrMIOoYfsgsHLTbCciPFkECDrtlk
 a00p1IFBOTOcKZCyOHkI/zKj7DS4EsJ3ex+z+hX+DR4EJa0Av/9EK3x1uBHhOAzQ0yo=
X-Gm-Gg: ASbGncs5GgtDxAyu2jQw4KlHH/SZkWhI3zGxPzfPXaWOrdlgVi8WnIL2jgPP6xFb0ws
 gEydC+H/xlpcE0tRYUOLt8CqnRmr8uybiRZ5GICTi9W/UBJ3rTrHoCHXR/MnZTfog3ShWI9HLeD
 YRH9OVWSle/O/cE5GjC9y0lI3j/S+0em8ZjVg82pA2N+cYeXTLLW5fcbWAnw1ylOhD73dW7D2jV
 02vhVFQqUxbJFFhC5bYarHZocaX525Ri2yAYnL6HI7fzgbBffdTgU7R7fdUu0tKuewGBXxC305e
 +4BJHLAZGNAFHAy/z8b7N9LCCgL8sOVqzJyuO3/RGx+1qaegTbf3q0dBaal0DZMpOC16PGHfhr6
 Enfpll5uO3hXdfkaWOeTjknZ18l9o8fTtVfPid6ixSLYoNHjlqAms8FiCcTDoaqrQbTapKI5GB1
 c6/T6tH7liOjQX1Vj3mz/17WvAkiq2QuvkEnUWs2qEsQ==
X-Google-Smtp-Source: AGHT+IGb+Nl2IqZtsXdhax0GiaBNxpOBk++akdy0Z84ABjLrtF8CyXFfHpK3JVWCoEduQHLQq6TC4w==
X-Received: by 2002:a17:907:9727:b0:b2d:830a:8c09 with SMTP id
 a640c23a62f3a-b6dba5a4780mr310539366b.44.1761649600634; 
 Tue, 28 Oct 2025 04:06:40 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e67b.dip0.t-ipconnect.de. [91.41.230.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85309069sm1039356766b.10.2025.10.28.04.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 04:06:39 -0700 (PDT)
Message-ID: <b3e8efc4-b176-4f05-9769-be7180ea7a7b@linaro.org>
Date: Tue, 28 Oct 2025 12:06:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] binman: fix mkmbn integration and tests
Content-Language: en-US
To: u-boot-qcom@groups.io, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20251023133850.3686431-1-casey.connolly@linaro.org>
 <5e94dba5-b922-4536-aa29-bbdd7aeafb0d@linaro.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <5e94dba5-b922-4536-aa29-bbdd7aeafb0d@linaro.org>
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



On 28/10/2025 09:19, Neil Armstrong via groups.io wrote:
> Hi,
> 
> On 10/23/25 15:38, Casey Connolly wrote:
>> Add the missing cryptography requirement to binman so that mkmbn
>> will work correctly, fix a pylint error, and adjust mkmbn to properly
>> integrate into binman rather than writing the output file directly.
>>
>> For now skip testing u_boot_mbn since it has some weird requirements due
>> to how mkmbn works and can't be easily integrated into binman.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>> Resent to fix my name
>> ---
>>   tools/binman/btool/mkmbn.py      | 9 ++-------
>>   tools/binman/etype/u_boot_mbn.py | 5 +++--
>>   tools/binman/main.py             | 4 +++-
>>   tools/binman/requirements.txt    | 1 +
>>   tools/qcom/mkmbn/elf.py          | 6 +++---
>>   5 files changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/tools/binman/btool/mkmbn.py b/tools/binman/btool/mkmbn.py
>> index 232e2b442a16..c1439977833e 100644
>> --- a/tools/binman/btool/mkmbn.py
>> +++ b/tools/binman/btool/mkmbn.py
>> @@ -12,18 +12,13 @@ class Bintoolmkmbn(bintool.Bintool):
>>       def __init__(self, name):
>>           super().__init__(name, 'Generate MBN (signed ELF) image for
>> U-Boot')
>>         # pylint: disable=R0913
>> -    def run(self, infile: str) -> CommandResult:
>> +    def run(self, infile: str, outfile:  str) -> CommandResult:
>>           """Run mkmbn.py
>>           """
>> -        args = [infile]
>> +        args = ['-o', outfile, infile]
>>           return self.run_cmd_result(*args, raise_on_error=False)
>>     -    def get_path(self):
>> -        path = super().get_path()
>> -        return path
>> -
>> -
>>       def fetch(self, _method):
>>           return True
>> diff --git a/tools/binman/etype/u_boot_mbn.py b/tools/binman/etype/
>> u_boot_mbn.py
>> index e470b31fa318..6268397fd122 100644
>> --- a/tools/binman/etype/u_boot_mbn.py
>> +++ b/tools/binman/etype/u_boot_mbn.py
>> @@ -31,10 +31,11 @@ class Entry_u_boot_mbn(Entry_blob):
>>       def __init__(self, section, etype, node):
>>           super().__init__(section, etype, node)
>>         def ObtainContents(self):
>> -        self._pathname = tools.get_input_filename('u-boot.bin')
>> -        res = self.mkmbn.run(self._pathname)
>> +        pathname = tools.get_input_filename('u-boot.bin')
>> +        self._pathname = tools.get_output_filename('u-boot.mbn')
>> +        res = self.mkmbn.run(pathname, self._pathname)
>>           if res is None:
>>               self.Raise('mkmbn not found or failed!')
>>           # Exit code 61 (ENODATA) indicates that an MBN file can't be
>> built
>>           # for this board. This is non-fatal since it may not be
>> required.
>> diff --git a/tools/binman/main.py b/tools/binman/main.py
>> index fa5ad79ca0e8..bfd6e990d2e4 100755
>> --- a/tools/binman/main.py
>> +++ b/tools/binman/main.py
>> @@ -102,9 +102,11 @@ def RunTestCoverage(toolpath, build_dir, args):
>>                'tools/u_boot_pylib/*'],
>>               build_dir, all_set, extra_args or None, args=args,
>>               allow_failures=['tools/binman/btool/cst.py',
>>                               'tools/binman/etype/nxp_imx8mcst.py',
>> -                            'tools/binman/etype/nxp_imx8mimage.py'])
>> +                            'tools/binman/etype/nxp_imx8mimage.py',
>> +                            'tools/binman/etype/u_boot_mbn.py',
>> +                            'tools/binman/btool/mkmbn.py'])
>>     def RunBinman(args):
>>       """Main entry point to binman once arguments are parsed
>>   diff --git a/tools/binman/requirements.txt b/tools/binman/
>> requirements.txt
>> index 7db72e888e3e..51b8ecd73478 100644
>> --- a/tools/binman/requirements.txt
>> +++ b/tools/binman/requirements.txt
>> @@ -3,4 +3,5 @@ importlib_resources==6.5.2
>>   jsonschema==4.23.0
>>   pycryptodomex==3.21.0
>>   pyelftools==0.31
>>   yamllint==1.35.1
>> +cryptography==46.0.3 # for mkmbn
>> diff --git a/tools/qcom/mkmbn/elf.py b/tools/qcom/mkmbn/elf.py
>> index 86f12d1f4e5d..7737adc6a4e2 100644
>> --- a/tools/qcom/mkmbn/elf.py
>> +++ b/tools/qcom/mkmbn/elf.py
>> @@ -171,11 +171,11 @@ def _align(i: int, alignment: int) -> int:
>>   class Elf:
>>       ehdr: Ehdr
>>       phdrs: List[Phdr]
>>   -    def __init__(self):
>> -        self.ehdr = Ehdr()
>> -        self.phdrs: List[Phdr] = []
>> +    def __init__(self, ehdr: Ehdr | None = None, phdrs: List[Phdr] |
>> None = None):
>> +        self.ehdr = ehdr or Ehdr()
>> +        self.phdrs: List[Phdr] = phdrs or []
>>         def total_header_size(self):
>>           return self.ehdr.e_phoff + len(self.phdrs) *
>> self.ehdr.e_phentsize
>>   
> 
> I understand all the changes.. except this last one.
> 
> Could you elaborate ?

Ah yeah i missed that in the commit message. In ("tools: qcom: add
mkmbn.py") we add the missing constructor for the Elf class but I forgot
to add the parameters which are passed in when constructed with the
parse() staticmethod, this fixes that. It should probably be a separate
commit, I'll split it out.

Kind regards,
> 
> Thanks,
> Neil
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#2386): https://groups.io/g/u-boot-qcom/message/2386
> Mute This Topic: https://groups.io/mt/115910537/8413174
> Group Owner: u-boot-qcom+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-qcom/
> leave/13197796/8413174/1557304080/xyzzy [casey.connolly@linaro.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

-- 
// Casey (she/her)

