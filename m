Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09042C27C43
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 14:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D91F88700;
	Thu, 30 May 2024 16:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PHAuWNLl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17D9C88705; Thu, 30 May 2024 16:11:30 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5E8A886FD
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 16:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a635a74e031so113582866b.0
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717078287; x=1717683087; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z/suQd3aS+8HlyYRhEFjecabepj4JkSHW35Rx0kaguM=;
 b=PHAuWNLlbYA4fj+E6FF9m4cnDXmNCzemgTuYKcEHWt2T9BWmr2IcYrhapOljuZMAtK
 E3iUi5OsGUJzaX2SoGv8ePo7aL54wLzmktnrV042JUTY7KebFsQkqKC/xA3ni+HCyId1
 oC+qz9X04lSwWHA3JMkul3nwV0JozZPN8WEq17zP0u6xtMZnCyL/AiYBCYDSlIZOyGYA
 3C7PZTMwxTLX6z/OP54KZvK9ciN2sQDhdCJ4TSX6xLlaIDIQT8ZN3zG2NE48k20dbbol
 xsKx894zaVGGh7DQXKpddKhPCLyNj9054fSR5fyBPVR3XffSenlJMRoajGrRpeMP2SFe
 fgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717078287; x=1717683087;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z/suQd3aS+8HlyYRhEFjecabepj4JkSHW35Rx0kaguM=;
 b=s23B4gYxX7fEDRCAWfliWd/OQ+5zYuSrgESIoR9PaZTirMrcC6IS9V7PbNA3grcrHf
 5+FkZ3hcXcquR9rdGjcM8BDP/KyWTj7biQPRICCPOYMI/vtMyTtXykEOkegUw0n+8W0o
 RvQk4Caep1hKBpDKYYC/GmEy3bUOZ2/8lwXenpe/0Besi6M97VQIzhHbxlR4ZeZgEMfV
 lnZcstZytzKlJklTPtkLK5SMQMZOsPAUEtidoiarxueToWEG29B9ofl1z5Uvr89N317U
 3acrm/6MnUrE6T7CyOKachyt1Q9oQ61EAjit6L8LTUfERcY2rrlD0r7s9DKa4Hp8KrI1
 m9tA==
X-Gm-Message-State: AOJu0YxfwhjJgG0FbsZ4h/kPk1vzNzubSNvV6n8G0Ljnjh6z1RXfn53X
 DaAY33A6KGRgtC5db3XrebpKuAhpirm0TgB+PWvNDoTnJ8HI9uadAID03EB84ak=
X-Google-Smtp-Source: AGHT+IHc56S+CVs1MLxZp99Pb9T8wrWysvevyLZLBH/6sPEMLuKbyBcl1yzlS5S0Ut09pApDsXG0Uw==
X-Received: by 2002:a17:906:60d:b0:a63:2698:2163 with SMTP id
 a640c23a62f3a-a65e8d35e25mr271768566b.7.1717078287181; 
 Thu, 30 May 2024 07:11:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:e866:9218:1a26:c042?
 ([2a01:e0a:3cb:7bb0:e866:9218:1a26:c042])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a62baf15294sm608479666b.23.2024.05.30.07.11.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 07:11:26 -0700 (PDT)
Message-ID: <1b104b1a-f6cd-4d16-b1e9-9f87ef483443@linaro.org>
Date: Thu, 30 May 2024 16:11:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] test/py: net: add _lwip variants of dhcp, ping
 and tftpboot tests
To: Maxim Uvarov <muvarov@gmail.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Tom Rini <trini@konsulko.com>,
 Love Kumar <love.kumar@amd.com>, Maxim Uvarov <maxim.uvarov@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <9acc7630e5768ab9af673981a78ffb84b47aa62e.1716566960.git.jerome.forissier@linaro.org>
 <CAJGZr0JN3SLGfjRunLpvstBEfpOr6tHgt4h0K5_1Cayn+5WKOw@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJGZr0JN3SLGfjRunLpvstBEfpOr6tHgt4h0K5_1Cayn+5WKOw@mail.gmail.com>
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



On 5/28/24 11:53, Maxim Uvarov wrote:
> пт, 24 мая 2024 г. в 19:22, Jerome Forissier <jerome.forissier@linaro.org>:
>>
>> WHen NET_LWIP is enabled, the dhcp/ping/tftpboot commands are enabled
>> via CMD_DHCP_LWIP, CMD_PING_LWIP and CMD_TFTPBOOT_LWIP, respectively;
>> therefore the config annotations in the Python test scripts need to be
>> cmd_dhcp_lwip, cmd_ping_lwip and cmd_tftpboot_lwip.
>>
>> The console output of the tftpboot command with lwIP is slightly
>> different from the non-lwIP implementation. This is taken care of in
>> test_net_tftpboot().
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  test/py/tests/test_net.py | 21 +++++++++++++++++----
>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
>> index 038a473b239..ba30780903f 100644
>> --- a/test/py/tests/test_net.py
>> +++ b/test/py/tests/test_net.py
>> @@ -127,6 +127,10 @@ def test_net_dhcp(u_boot_console):
>>      global net_set_up
>>      net_set_up = True
>>
>> +@pytest.mark.buildconfigspec('cmd_dhcp_lwip')
>> +def test_net_dhcp_lwip(u_boot_console):
>> +    test_net_dhcp(u_boot_console)
>> +
>>  @pytest.mark.buildconfigspec('cmd_dhcp')
>>  @pytest.mark.buildconfigspec('cmd_mii')
>>  def test_net_dhcp_abort(u_boot_console):
>> @@ -230,6 +234,10 @@ def test_net_ping(u_boot_console):
>>      output = u_boot_console.run_command('ping $serverip')
>>      assert 'is alive' in output
>>
>> +@pytest.mark.buildconfigspec('cmd_ping_lwip')
>> +def test_net_ping_lwip(u_boot_console):
>> +    test_net_ping(u_boot_console)
>> +
>>  @pytest.mark.buildconfigspec('IPV6_ROUTER_DISCOVERY')
>>  def test_net_network_discovery(u_boot_console):
>>      """Test the network discovery feature of IPv6.
>> @@ -255,7 +263,7 @@ def test_net_network_discovery(u_boot_console):
>>      assert '0000:0000:0000:0000:0000:0000:0000:0000' not in output
>>
>>  @pytest.mark.buildconfigspec('cmd_net')
>> -def test_net_tftpboot(u_boot_console):
>> +def test_net_tftpboot(u_boot_console, lwip = False):
>>      """Test the tftpboot command.
>>
>>      A file is downloaded from the TFTP server, its size and optionally its
>> @@ -279,10 +287,11 @@ def test_net_tftpboot(u_boot_console):
>>          output = u_boot_console.run_command('tftpboot %s' % (fn))
>>      else:
>>          output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
>> -    expected_text = 'Bytes transferred = '
>>      sz = f.get('size', None)
>> -    if sz:
>> -        expected_text += '%d' % sz
>> +    if lwip:
>> +        expected_text = f'{sz} bytes transferred'
> 
> Why not change patch 5 to print with capital character to match this pattern?

I thought unifying the messages of wget and tftp would be a good idea. With
this series, both commands print hash signs followed by:
"xxx bytes transferred (yy MB/s)".

Would a patch updating the tftp message when the legacy stack is used be
acceptable?

-- 
Jerome

> BR,
> Maxim.
> 
>> +    else:
>> +        expected_text = f'Bytes transferred = {sz}'
>>      assert expected_text in output
>>
>>      expected_crc = f.get('crc32', None)
>> @@ -295,6 +304,10 @@ def test_net_tftpboot(u_boot_console):
>>      output = u_boot_console.run_command('crc32 $fileaddr $filesize')
>>      assert expected_crc in output
>>
>> +@pytest.mark.buildconfigspec("cmd_net_lwip")
>> +def test_net_tftpboot_lwip(u_boot_console):
>> +    test_net_tftpboot(u_boot_console, True)
>> +
>>  @pytest.mark.buildconfigspec('cmd_nfs')
>>  def test_net_nfs(u_boot_console):
>>      """Test the nfs command.
>> --
>> 2.40.1
>>
> 
> 
