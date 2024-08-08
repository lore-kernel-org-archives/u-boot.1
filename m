Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232ACC52D7B
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EB8A88AE4;
	Thu,  8 Aug 2024 18:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PIYtHmJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AB6F88AE8; Thu,  8 Aug 2024 18:30:46 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04AB0889EF
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f029e9c9cfso18046001fa.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723134643; x=1723739443; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4lY1XYcO3UvNQrf1fPgdN0oDjS7kinjwEWxhcmz78Y4=;
 b=PIYtHmJvlvnVeKQAw2jNuV6m7W8XE+allASLqINWvvbDkBd7OHAY7PgJNko9E/ZgWm
 BjIwK4yXMUa4ZNz4A51c+6pzFFETHd8jWFPwYNLA3DQ4tpNdXKH466CDnN5htqcqux7+
 zm8mbs14d8buoxDCTaWNAHhXn9RuhANe//dGQbwqrlELi+64SXUPCWLf1D24L7IdMgJB
 J7vU0ehnqFUPnBLRnwzvIyuVhfQvqUqOoY8mLsBNdItAkhfDRiz9PubvA6hBvGdM9boY
 Y0yG3FNuFZ8OKRjbITZWH6YEPux9/XZdmwrXR0C2kY2bv/cZ0+Vy1SHQ54xgpiekeAs3
 1UuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134643; x=1723739443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4lY1XYcO3UvNQrf1fPgdN0oDjS7kinjwEWxhcmz78Y4=;
 b=sM/NjCMuH4xI2kHlU4Gr5kDTFd+R04KZpimWQUfqPw7kGAwhxZOAyyKdEF48ta0nx0
 nLkgtltp4CL4JzLmg94PDF3nm80JMEn/4+EkktnsNqvestD2q0qhHNCwYhoTA03z9xcB
 o+spMYNGAHGGOdLZSTpUsiQN5DETSYxvxm6GAgVkROeWbUnLTkNI2UyU2SgBhwB4Hxr9
 EDayPoeCxjMyKC+bKTfBrrb3mSClvjtUg59ieaA826IMmlwPfGdLeILABXYYn6UWPL6F
 9p93I6E1VuigvFzSV6/x/j2GqePX1aJ3FKCM90NEgXmU/uHbFTcEgRUb9FcBRADyWJ16
 R/0A==
X-Gm-Message-State: AOJu0Yw9rmQjZ3c+uvBgjAESZ61kQwhSxUlrXzo4OFWn4JWjTIbFXb+J
 KCx41Obcod3GMN6WtUtxtwU6qAMcBJIVt0S6Cjuhf4G6D5cFzTnA20ELFjHVC7k=
X-Google-Smtp-Source: AGHT+IGePzOytl7Jb/f/IHb80GOmsaUEbzoCv+mlFo3ibBZKSq+Kk1aqLMi0lRT5vM/NnVQmLlhSpg==
X-Received: by 2002:a2e:859:0:b0:2ef:2e98:9718 with SMTP id
 38308e7fff4ca-2f19de2bfa8mr20337861fa.15.1723134642978; 
 Thu, 08 Aug 2024 09:30:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:76c8:eeba:d244:1830?
 ([2a01:e0a:3cb:7bb0:76c8:eeba:d244:1830])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bc3cbesm755504966b.5.2024.08.08.09.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 09:30:42 -0700 (PDT)
Message-ID: <065e1708-99f6-443c-ae0a-6b183737e6f1@linaro.org>
Date: Thu, 8 Aug 2024 18:30:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 22/23] test/py: add HTTP (wget) test for the EFI loader
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <9b055b18f84755d775bf0cf4064e66801608839c.1723050310.git.jerome.forissier@linaro.org>
 <20240807175740.GH1626301@bill-the-cat>
 <fbe3c688-1d3a-4e07-8e20-1cefe1989752@linaro.org>
 <20240808162030.GP1626301@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240808162030.GP1626301@bill-the-cat>
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



On 8/8/24 18:20, Tom Rini wrote:
> On Thu, Aug 08, 2024 at 03:06:05PM +0200, Jerome Forissier wrote:
>>
>>
>> On 8/7/24 19:57, Tom Rini wrote:
>>> On Wed, Aug 07, 2024 at 07:12:06PM +0200, Jerome Forissier wrote:
>>>> Add a test to test_efi_loader.py similar to the TFTP test but for HTTP
>>>> with the wget command.
>>>>
>>>> Suggested-by: Tom Rini <trini@konsulko.com>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> ---
>>>>  test/py/tests/test_efi_loader.py | 52 +++++++++++++++++++++++---------
>>>>  1 file changed, 37 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
>>>> index 85473a9049b..64c994fdf95 100644
>>>> --- a/test/py/tests/test_efi_loader.py
>>>> +++ b/test/py/tests/test_efi_loader.py
>>>> @@ -50,6 +50,8 @@ env__efi_loader_helloworld_file = {
>>>>  import pytest
>>>>  import u_boot_utils
>>>>  
>>>> +PROTO_TFTP, PROTO_HTTP = range(0, 2)
>>>> +
>>>>  net_set_up = False
>>>>  
>>>>  def test_efi_pre_commands(u_boot_console):
>>>> @@ -110,10 +112,10 @@ def test_efi_setup_static(u_boot_console):
>>>>      global net_set_up
>>>>      net_set_up = True
>>>>  
>>>> -def fetch_tftp_file(u_boot_console, env_conf):
>>>> -    """Grab an env described file via TFTP and return its address
>>>> +def fetch_file(u_boot_console, env_conf, proto):
>>>> +    """Grab an env described file via TFTP or HTTP and return its address
>>>>  
>>>> -    A file as described by an env config <env_conf> is downloaded from the TFTP
>>>> +    A file as described by an env config <env_conf> is downloaded from the
>>>>      server. The address to that file is returned.
>>>>      """
>>>>      if not net_set_up:
>>>> @@ -128,7 +130,13 @@ def fetch_tftp_file(u_boot_console, env_conf):
>>>>          addr = u_boot_utils.find_ram_base(u_boot_console)
>>>>  
>>>>      fn = f['fn']
>>>> -    output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
>>>> +    if proto == PROTO_TFTP:
>>>> +        cmd = 'tftpboot'
>>>> +    elif proto == PROTO_HTTP:
>>>> +        cmd = 'wget'
>>>> +    else:
>>>> +        assert False
>>>> +    output = u_boot_console.run_command('%s %x %s' % (cmd, addr, fn))
>>>>      expected_text = 'Bytes transferred = '
>>>>      sz = f.get('size', None)
>>>>      if sz:
>>>> @@ -147,16 +155,8 @@ def fetch_tftp_file(u_boot_console, env_conf):
>>>>  
>>>>      return addr
>>>>  
>>>> -@pytest.mark.buildconfigspec('of_control')
>>>> -@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
>>>> -def test_efi_helloworld_net(u_boot_console):
>>>> -    """Run the helloworld.efi binary via TFTP.
>>>> -
>>>> -    The helloworld.efi file is downloaded from the TFTP server and is executed
>>>> -    using the fallback device tree at $fdtcontroladdr.
>>>> -    """
>>>> -
>>>> -    addr = fetch_tftp_file(u_boot_console, 'env__efi_loader_helloworld_file')
>>>> +def do_test_efi_helloworld_net(u_boot_console, proto):
>>>> +    addr = fetch_file(u_boot_console, 'env__efi_loader_helloworld_file', proto)
>>>>  
>>>>      output = u_boot_console.run_command('bootefi %x' % addr)
>>>>      expected_text = 'Hello, world'
>>>> @@ -164,6 +164,28 @@ def test_efi_helloworld_net(u_boot_console):
>>>>      expected_text = '## Application failed'
>>>>      assert expected_text not in output
>>>>  
>>>> +@pytest.mark.buildconfigspec('of_control')
>>>> +@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
>>>> +def test_efi_helloworld_net_tftp(u_boot_console):
>>>> +    """Run the helloworld.efi binary via TFTP.
>>>> +
>>>> +    The helloworld.efi file is downloaded from the TFTP server and is executed
>>>> +    using the fallback device tree at $fdtcontroladdr.
>>>> +    """
>>>> +
>>>> +    do_test_efi_helloworld_net(u_boot_console, PROTO_TFTP);
>>>> +
>>>> +@pytest.mark.buildconfigspec('of_control')
>>>> +@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
>>>> +def test_efi_helloworld_net_http(u_boot_console):
>>>> +    """Run the helloworld.efi binary via HTTP.
>>>> +
>>>> +    The helloworld.efi file is downloaded from the HTTP server and is executed
>>>> +    using the fallback device tree at $fdtcontroladdr.
>>>> +    """
>>>> +
>>>> +    do_test_efi_helloworld_net(u_boot_console, PROTO_HTTP);
>>>> +
>>>>  @pytest.mark.buildconfigspec('cmd_bootefi_hello')
>>>>  def test_efi_helloworld_builtin(u_boot_console):
>>>>      """Run the builtin helloworld.efi binary.
>>>> @@ -185,7 +207,7 @@ def test_efi_grub_net(u_boot_console):
>>>>      executed.
>>>>      """
>>>>  
>>>> -    addr = fetch_tftp_file(u_boot_console, 'env__efi_loader_grub_file')
>>>> +    addr = fetch_file(u_boot_console, 'env__efi_loader_grub_file', PROTO_TFTP)
>>>>  
>>>>      u_boot_console.run_command('bootefi %x' % addr, wait_for_prompt=False)
>>>
>>> Looking at this now that I've added wget to my Pi builds, erm:
>>> U-Boot> wget 200000 EFI/arm64/helloworld.efi
>>>
>>> That's not going to work. That's what works fine for a tftp server. I
>>> think the test is going to need to require some http specific
>>> configuration added (and I'll locally start firing off the python
>>> trivial http server or something, for tests).
>>
>> It should work because 'wget <addr> <file>' is a valid syntax for the legacy
>> wget as well as for the new one, now that I have added support for it. It
>> takes the address of the http server from ${serverip}. Of course you need a
>> http server listening on the same host as the tfp server, yes.
>> I have tested this on the RPi3.
> 
> OK, so problem. This is intermittent (first I saw it on rpi_3_32b built with
> clang (LLVM-17) and lwIP and the second was rpi_3_32b with gcc and lwIP):
> ========================================== FAILURES ===========================================
> ________________________________ test_efi_helloworld_net_http _________________________________
> test/py/tests/test_efi_loader.py:187: in test_efi_helloworld_net_http
>     do_test_efi_helloworld_net(u_boot_console, PROTO_HTTP);
> test/py/tests/test_efi_loader.py:159: in do_test_efi_helloworld_net
>     addr = fetch_file(u_boot_console, 'env__efi_loader_helloworld_file', proto)
> test/py/tests/test_efi_loader.py:139: in fetch_file
>     output = u_boot_console.run_command('%s %x %s' % (cmd, addr, fn))
> test/py/u_boot_console_base.py:288: in run_command
>     raise Exception('Bad pattern found on console: ' +
> E   Exception: Bad pattern found on console: error_please_reset
> ------------------------------------ Captured stdout call -------------------------------------
> U-Boot> wget 200000 EFI/arm/helloworld.efi
> 2320 bytes transferred in 0 ms (### ERROR ### Please RESET the board ###
> =================================== short test summary info ===================================
> 
> My first guess is the "in 0 ms" leads to a divide by zero later on?

Oops! Yes, that is clearly the reason. Fixed in v9.

Thanks,
-- 
Jerome
