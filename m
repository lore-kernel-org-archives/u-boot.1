Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA70C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E418888B8E;
	Thu,  8 Aug 2024 18:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qk6CDtl4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A167A88B6B; Thu,  8 Aug 2024 18:10:14 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DF1C88AE1
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-530ae4ef29dso1987470e87.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723133412; x=1723738212; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yzr4gDbJs2IOAFVr6hYCIQeykMuivn9cgtF4a2G0Q+o=;
 b=Qk6CDtl4Tt0os905zAcJnG5zJ4pTqMRGC2wHeEqxLjisgL5GIuYAGe6/etKKnh5JlS
 OrOxGbTpE5YZCHUaqy/FpjyEjqCVC/XjIEwUaMB1K+xHFEf/smCoF0f/wyLP0duy23nI
 uKz98I+ben6OBo4rfFJ/FpLpu8YZ9eUThdkjs4wfcr2zuPBgeL8I3VUfm+VHToV4WGyg
 UaaptIjAyFXqWp/2jSKC+XYq/ROvQ5oOb113K6PH80e9xi5DZj+Q++eptzVlcTZxDnbI
 ZTadGIQ5tTiu6iIIj6CdFt4HD4K+pPwKT86Cnaf+4KI5YQTMYjg3bj0Uew126W0oL2ho
 xSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723133412; x=1723738212;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yzr4gDbJs2IOAFVr6hYCIQeykMuivn9cgtF4a2G0Q+o=;
 b=NgRQZkVs6ABO0D25K+ilHv0LVKSzBtboTdGN0hFQo68LU/zgAs58CCRhC9684t6mZ2
 c6c16VmKQiIaLsYd/7H/z/wpH6B3RL5v+VR+yMUXbwrQEAuDwxhKvvst3/sZsXw3oHvX
 KcNCrpFUK9s6KncOC1261CxTavUZ5j0ATjOmTuAfO5jbnjTlWRDskgxCLhvzrtClZfiq
 WOA+IrTQsec7QYv/8HFEJOBug0TbUOXPOlK9zn2QH3+l+S5eTOefrvhtutsCtm66ST/x
 6YQUCSivSzeIqrpHpC6dvMx5UuULYeje0jB1qMDqa4DP/bCT3tPTLOtFL8DTMWjdkA4R
 tlDA==
X-Gm-Message-State: AOJu0YyxlS+6u6+jl/xSbum/3ZehvGvjBr3tMdcGA2nZ6R1iufDj0sf1
 CHnljcPGvGXLSThv5k/99GwvryZYIGewOHWKTLzpqkaUXGIh0ad1172uiAEvRLA=
X-Google-Smtp-Source: AGHT+IEfnncGcI6+olnAnm5w2ze98i7S+YeT53AtJmKC1iS44/jGkQPz+8FtIRjRoldeakGBBNltjQ==
X-Received: by 2002:a05:6512:e98:b0:529:b718:8d00 with SMTP id
 2adb3069b0e04-530e58124bbmr2195517e87.8.1723133411422; 
 Thu, 08 Aug 2024 09:10:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:76c8:eeba:d244:1830?
 ([2a01:e0a:3cb:7bb0:76c8:eeba:d244:1830])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e83eccsm753090366b.184.2024.08.08.09.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 09:10:10 -0700 (PDT)
Message-ID: <4b8a2ebc-4551-4ec5-9b0f-d4b85e10b350@linaro.org>
Date: Thu, 8 Aug 2024 18:10:09 +0200
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
 <20240808155217.GO1626301@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240808155217.GO1626301@bill-the-cat>
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



On 8/8/24 17:52, Tom Rini wrote:
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
> Oh, neat, OK, thanks. The lack of error message was confusing, does lwIP
> wget say something when it fails to fetch? 

Yes, it will print: "HTTP (client|server) error xxx". Typically:

"HTTP client error 4" -> TCP connection refused
"HTTP client error 5" -> TCP connection timeout
"HTTP server error 404" -> file not found

> Throwing the trivial http
> server up lets me pass the test.
> Tested-by: Tom Rini <trini@konsulko.com>


Nice! T-b added. Thanks.

-- 
Jerome
