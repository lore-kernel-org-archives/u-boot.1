Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EFEC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 09:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D517288363;
	Thu,  6 Jun 2024 11:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ck2RJ2Z8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28D1E8839C; Thu,  6 Jun 2024 11:18:47 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F0A288103
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 11:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4214f52b810so10315855e9.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 02:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717665524; x=1718270324; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=28N/rDZmlxLnCyUVO+R+2WzwMDKx4sSXqV+1rkRWtMw=;
 b=Ck2RJ2Z8dmDwi5z1piuDkpEFgh0HAbGWbihlZvAgKYHCehKKUQciyvLP4F0KaajjT9
 DVDoUoCHZQr9pGiTF1IaDzgnfoZqTHchPFn1JIkPok4LbTRCMSekxFeUViDQ0nkfxFj/
 Oc5uK6VCptSQIPoW3HvypsGxe/9figP9z1oZsF7Dogw5UEI73YFm9dxuubRCqphqFMMx
 tRec8H7OTlpXot23a3vPgrAJ2p2pa6/j/H0JtOpntB3Rq0sCvlSXgjStNfjzzDawHe1D
 YhVLzuPomS0ZVova5TxaNd7iZNU3i6yzdVnkkXIxT7q5szr8Hg7RXpgOrP1XulwVFMYj
 ieOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717665524; x=1718270324;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=28N/rDZmlxLnCyUVO+R+2WzwMDKx4sSXqV+1rkRWtMw=;
 b=E1jlSiCCtnh+9iAAzbkJ3OEsFTGdBl82g8P+S8xRjRyOT0DtgsUyQ9+Y9cl7HcgIkd
 l5J6CnpSObOZemqtuMQJkVYXo/xnZaIuYKHASb2uArVPCIrPfOq/gazbq7aIuZrH8sn0
 5kncowC6nguWPI2y0koVbkDkI0Utj0/kzmXkaQECOL2R6jkIdBq0KY83rAA/VC3+VfwO
 T0jPi8s38jjsdLyLlQrnypxGjrl7xwNE23golMI17QuTvfehS+CfAApmqAi3s1sMrbzj
 RpjgfgI+LiD7GqhxWeyJnDe8b7HbjZS1Ush6hz34DwHah6/MRDSq535nXI21EhjFVDjn
 6FBQ==
X-Gm-Message-State: AOJu0YzlGqaVdV4QT/ZJmgXX9F74v7mXaeCuUe5rEM3NNAccGmyZLmF5
 f9xKyI31oDdca2vkGkD+72sHo8o8cQFYsfxxoswC+sHuvlqQviQiPqyHGN5FSu8=
X-Google-Smtp-Source: AGHT+IGjZLxH4ZyqgZljLrsPbo23++5jhYt5AAvRGlKHqdS0g7CF72+XTPjIiOMFPVtGZ3S5abmz6A==
X-Received: by 2002:a5d:6d84:0:b0:35d:c1b1:85c with SMTP id
 ffacd0b85a97d-35e8ef07f8fmr5833384f8f.26.1717665524437; 
 Thu, 06 Jun 2024 02:18:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:af73:f6a9:3d55:6f07?
 ([2a01:e0a:3cb:7bb0:af73:f6a9:3d55:6f07])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5e983d8sm1030642f8f.84.2024.06.06.02.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 02:18:44 -0700 (PDT)
Message-ID: <87a47385-771c-4d57-95d6-f0f72c14fa39@linaro.org>
Date: Thu, 6 Jun 2024 11:18:43 +0200
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
 <1b104b1a-f6cd-4d16-b1e9-9f87ef483443@linaro.org>
 <CAJGZr0LmonXv-RDE3tawT49tj8WNHe=fh2zhhg2wfh_6gvx6+Q@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJGZr0LmonXv-RDE3tawT49tj8WNHe=fh2zhhg2wfh_6gvx6+Q@mail.gmail.com>
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



On 5/30/24 16:22, Maxim Uvarov wrote:
> чт, 30 мая 2024 г. в 17:11, Jerome Forissier <jerome.forissier@linaro.org>:
>>
>>
>>
>> On 5/28/24 11:53, Maxim Uvarov wrote:
>>> пт, 24 мая 2024 г. в 19:22, Jerome Forissier <jerome.forissier@linaro.org>:
>>>>
>>>> WHen NET_LWIP is enabled, the dhcp/ping/tftpboot commands are enabled
>>>> via CMD_DHCP_LWIP, CMD_PING_LWIP and CMD_TFTPBOOT_LWIP, respectively;
>>>> therefore the config annotations in the Python test scripts need to be
>>>> cmd_dhcp_lwip, cmd_ping_lwip and cmd_tftpboot_lwip.
>>>>
>>>> The console output of the tftpboot command with lwIP is slightly
>>>> different from the non-lwIP implementation. This is taken care of in
>>>> test_net_tftpboot().
>>>>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> ---
>>>>  test/py/tests/test_net.py | 21 +++++++++++++++++----
>>>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
>>>> index 038a473b239..ba30780903f 100644
>>>> --- a/test/py/tests/test_net.py
>>>> +++ b/test/py/tests/test_net.py
>>>> @@ -127,6 +127,10 @@ def test_net_dhcp(u_boot_console):
>>>>      global net_set_up
>>>>      net_set_up = True
>>>>
>>>> +@pytest.mark.buildconfigspec('cmd_dhcp_lwip')
>>>> +def test_net_dhcp_lwip(u_boot_console):
>>>> +    test_net_dhcp(u_boot_console)
>>>> +
>>>>  @pytest.mark.buildconfigspec('cmd_dhcp')
>>>>  @pytest.mark.buildconfigspec('cmd_mii')
>>>>  def test_net_dhcp_abort(u_boot_console):
>>>> @@ -230,6 +234,10 @@ def test_net_ping(u_boot_console):
>>>>      output = u_boot_console.run_command('ping $serverip')
>>>>      assert 'is alive' in output
>>>>
>>>> +@pytest.mark.buildconfigspec('cmd_ping_lwip')
>>>> +def test_net_ping_lwip(u_boot_console):
>>>> +    test_net_ping(u_boot_console)
>>>> +
>>>>  @pytest.mark.buildconfigspec('IPV6_ROUTER_DISCOVERY')
>>>>  def test_net_network_discovery(u_boot_console):
>>>>      """Test the network discovery feature of IPv6.
>>>> @@ -255,7 +263,7 @@ def test_net_network_discovery(u_boot_console):
>>>>      assert '0000:0000:0000:0000:0000:0000:0000:0000' not in output
>>>>
>>>>  @pytest.mark.buildconfigspec('cmd_net')
>>>> -def test_net_tftpboot(u_boot_console):
>>>> +def test_net_tftpboot(u_boot_console, lwip = False):
>>>>      """Test the tftpboot command.
>>>>
>>>>      A file is downloaded from the TFTP server, its size and optionally its
>>>> @@ -279,10 +287,11 @@ def test_net_tftpboot(u_boot_console):
>>>>          output = u_boot_console.run_command('tftpboot %s' % (fn))
>>>>      else:
>>>>          output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
>>>> -    expected_text = 'Bytes transferred = '
>>>>      sz = f.get('size', None)
>>>> -    if sz:
>>>> -        expected_text += '%d' % sz
>>>> +    if lwip:
>>>> +        expected_text = f'{sz} bytes transferred'
>>>
>>> Why not change patch 5 to print with capital character to match this pattern?
>>
>> I thought unifying the messages of wget and tftp would be a good idea. With
>> this series, both commands print hash signs followed by:
>> "xxx bytes transferred (yy MB/s)".
>>
>> Would a patch updating the tftp message when the legacy stack is used be
>> acceptable?
>>
>> --
>> Jerome
>>
> 
> I think yes.

I changed my mind. As I replied to Tom, I will stick with the older message
format for now.

Thanks,
-- 
Jerome
