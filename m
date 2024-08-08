Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7CDC52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 13:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C243D88A6B;
	Thu,  8 Aug 2024 15:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r+251r1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2975888A74; Thu,  8 Aug 2024 15:06:09 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0773188440
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 15:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5bba25c1e15so1099880a12.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 06:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723122366; x=1723727166; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xHQSq6NR1TlCEgOxbyvXNt/getGQql5EVnZYaZSApNE=;
 b=r+251r1xHyrTsqqUr/FsEUiSvf0QNxAPdrIRmLOK6c1uJ+XnQN+tCAkCG8G3QYLQQo
 gJ/qTfxHvFmflvUSsuuE4xgIpZFffSqlHvWYlzOcR8Gsr0Lr1NxWVtTEKkw278/zs/CZ
 bjMsvvNq52oMqHpURFQERO3v4oC/+iQZr/hsEtw+MEfoPJITvJpKKK02ideT13n7dVXJ
 5kfArqIr3wD7clmy9E4cDdpCA4tPs3IaOLWPgGUwTNBh7LoO09uunnEIErfaGcFG0Nhv
 248TNLCdQACt8N0VOHVl80gaPC1MAneXZhMzFGyn7Hkv+YtHHGkdwmcKQWXZX/69H9pt
 pYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723122366; x=1723727166;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xHQSq6NR1TlCEgOxbyvXNt/getGQql5EVnZYaZSApNE=;
 b=DW4bq/7A7O2yhxwq9+t35TswdWtqdVgXCov5GhLN7ceLD3xPj8XIUYTMKTvRjjqEp8
 tl55lfvxfr+bn6rwr9uOihCEvx7YuSKUbJOqns1uTi0Quhu/TzFMD8eXSXSuUkYzpRDz
 /i3OyjpsFYsis71CKHr7sIG7gI9LRwIZPrsd4AKt0nEuE6fX0JFSt79IsrdjsdQnQFor
 BcPSHdOL2CNaQQZlzmCSIaBW4qFMHH+wIYmyhS6D65D71OeQjGZlvzKOyU7JhReqV/Zr
 BPjXuAr/+Axh3jU7cDD7FCjOirmd6bm43pVm7PVs09OFHbmCuXdiSlGMUh6A/e3ev9+6
 9EXw==
X-Gm-Message-State: AOJu0YwU7zERLeT4uLIQVVqAKnClztAglDTZsUN1FVFo2TI9LQX987UP
 jGSgZYg9zOQqCr8qYy1Cq+/TKZinZYrecNbivCNckLZ57/Qg7VysahRaMIzqpxI4k7r3UuQ/Lyu
 J9It8xnZu
X-Google-Smtp-Source: AGHT+IF30TBDMaHgWoytFINLp1wIR8ItkSw7ECJqs6NRDkoqRV//fGiLIgqilqjAC/mZiVLGFOLElA==
X-Received: by 2002:a17:907:d2e8:b0:a7a:9a78:4b4f with SMTP id
 a640c23a62f3a-a8090e8aa5dmr128478866b.46.1723122366217; 
 Thu, 08 Aug 2024 06:06:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:76c8:eeba:d244:1830?
 ([2a01:e0a:3cb:7bb0:76c8:eeba:d244:1830])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0cc4fsm745384666b.77.2024.08.08.06.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 06:06:05 -0700 (PDT)
Message-ID: <fbe3c688-1d3a-4e07-8e20-1cefe1989752@linaro.org>
Date: Thu, 8 Aug 2024 15:06:05 +0200
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
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240807175740.GH1626301@bill-the-cat>
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



On 8/7/24 19:57, Tom Rini wrote:
> On Wed, Aug 07, 2024 at 07:12:06PM +0200, Jerome Forissier wrote:
>> Add a test to test_efi_loader.py similar to the TFTP test but for HTTP
>> with the wget command.
>>
>> Suggested-by: Tom Rini <trini@konsulko.com>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  test/py/tests/test_efi_loader.py | 52 +++++++++++++++++++++++---------
>>  1 file changed, 37 insertions(+), 15 deletions(-)
>>
>> diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
>> index 85473a9049b..64c994fdf95 100644
>> --- a/test/py/tests/test_efi_loader.py
>> +++ b/test/py/tests/test_efi_loader.py
>> @@ -50,6 +50,8 @@ env__efi_loader_helloworld_file = {
>>  import pytest
>>  import u_boot_utils
>>  
>> +PROTO_TFTP, PROTO_HTTP = range(0, 2)
>> +
>>  net_set_up = False
>>  
>>  def test_efi_pre_commands(u_boot_console):
>> @@ -110,10 +112,10 @@ def test_efi_setup_static(u_boot_console):
>>      global net_set_up
>>      net_set_up = True
>>  
>> -def fetch_tftp_file(u_boot_console, env_conf):
>> -    """Grab an env described file via TFTP and return its address
>> +def fetch_file(u_boot_console, env_conf, proto):
>> +    """Grab an env described file via TFTP or HTTP and return its address
>>  
>> -    A file as described by an env config <env_conf> is downloaded from the TFTP
>> +    A file as described by an env config <env_conf> is downloaded from the
>>      server. The address to that file is returned.
>>      """
>>      if not net_set_up:
>> @@ -128,7 +130,13 @@ def fetch_tftp_file(u_boot_console, env_conf):
>>          addr = u_boot_utils.find_ram_base(u_boot_console)
>>  
>>      fn = f['fn']
>> -    output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
>> +    if proto == PROTO_TFTP:
>> +        cmd = 'tftpboot'
>> +    elif proto == PROTO_HTTP:
>> +        cmd = 'wget'
>> +    else:
>> +        assert False
>> +    output = u_boot_console.run_command('%s %x %s' % (cmd, addr, fn))
>>      expected_text = 'Bytes transferred = '
>>      sz = f.get('size', None)
>>      if sz:
>> @@ -147,16 +155,8 @@ def fetch_tftp_file(u_boot_console, env_conf):
>>  
>>      return addr
>>  
>> -@pytest.mark.buildconfigspec('of_control')
>> -@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
>> -def test_efi_helloworld_net(u_boot_console):
>> -    """Run the helloworld.efi binary via TFTP.
>> -
>> -    The helloworld.efi file is downloaded from the TFTP server and is executed
>> -    using the fallback device tree at $fdtcontroladdr.
>> -    """
>> -
>> -    addr = fetch_tftp_file(u_boot_console, 'env__efi_loader_helloworld_file')
>> +def do_test_efi_helloworld_net(u_boot_console, proto):
>> +    addr = fetch_file(u_boot_console, 'env__efi_loader_helloworld_file', proto)
>>  
>>      output = u_boot_console.run_command('bootefi %x' % addr)
>>      expected_text = 'Hello, world'
>> @@ -164,6 +164,28 @@ def test_efi_helloworld_net(u_boot_console):
>>      expected_text = '## Application failed'
>>      assert expected_text not in output
>>  
>> +@pytest.mark.buildconfigspec('of_control')
>> +@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
>> +def test_efi_helloworld_net_tftp(u_boot_console):
>> +    """Run the helloworld.efi binary via TFTP.
>> +
>> +    The helloworld.efi file is downloaded from the TFTP server and is executed
>> +    using the fallback device tree at $fdtcontroladdr.
>> +    """
>> +
>> +    do_test_efi_helloworld_net(u_boot_console, PROTO_TFTP);
>> +
>> +@pytest.mark.buildconfigspec('of_control')
>> +@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
>> +def test_efi_helloworld_net_http(u_boot_console):
>> +    """Run the helloworld.efi binary via HTTP.
>> +
>> +    The helloworld.efi file is downloaded from the HTTP server and is executed
>> +    using the fallback device tree at $fdtcontroladdr.
>> +    """
>> +
>> +    do_test_efi_helloworld_net(u_boot_console, PROTO_HTTP);
>> +
>>  @pytest.mark.buildconfigspec('cmd_bootefi_hello')
>>  def test_efi_helloworld_builtin(u_boot_console):
>>      """Run the builtin helloworld.efi binary.
>> @@ -185,7 +207,7 @@ def test_efi_grub_net(u_boot_console):
>>      executed.
>>      """
>>  
>> -    addr = fetch_tftp_file(u_boot_console, 'env__efi_loader_grub_file')
>> +    addr = fetch_file(u_boot_console, 'env__efi_loader_grub_file', PROTO_TFTP)
>>  
>>      u_boot_console.run_command('bootefi %x' % addr, wait_for_prompt=False)
> 
> Looking at this now that I've added wget to my Pi builds, erm:
> U-Boot> wget 200000 EFI/arm64/helloworld.efi
> 
> That's not going to work. That's what works fine for a tftp server. I
> think the test is going to need to require some http specific
> configuration added (and I'll locally start firing off the python
> trivial http server or something, for tests).

It should work because 'wget <addr> <file>' is a valid syntax for the legacy
wget as well as for the new one, now that I have added support for it. It
takes the address of the http server from ${serverip}. Of course you need a
http server listening on the same host as the tfp server, yes.
I have tested this on the RPi3.

-- 
Jerome
