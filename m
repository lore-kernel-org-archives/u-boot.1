Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B70C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 12:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 480CB8798D;
	Thu, 18 Jan 2024 13:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="WpdqOtFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EA3787B4C; Thu, 18 Jan 2024 13:33:19 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FC4D83CF3
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 13:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [192.168.123.161] (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8EE773F2D5; 
 Thu, 18 Jan 2024 12:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705581193;
 bh=9li1KF0dTBruONl88j/WhrvnB8O5DQySrkf07ZCSIio=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=WpdqOtFePEkUoFNQiLeHxBQR07Qs6Axp3VQJeBxn440D/bghjX8cdLivY4M/5Wwvn
 E2LdJ3xb5J7A/XGUSxe/sYTaDisWPAtUJbHKzLminIdWz91hc2HoCffpJVMfI3SQk4
 9ckM5bT3ot0tZ+MNwo5hA5Df5Ko/4wpY/chnP6Vp1dG+Ca61PcE9eBVvQ4+omElkx2
 XUQUzn55wWxFGA9zyprXIBfKOrAfRyHq32HUA7uMvD+Kz2zB8E5kljRM/1B5vKzYAO
 426KD50cGh8tWtJ+nwgezj2NPBXaP0shfdxatUuYpxVqD3nTfozM8WUEUA4W0lFb/v
 Vo8925VWFrlpQ==
Message-ID: <d58a1c24-9af3-4a49-b4bd-afafc0c684f2@canonical.com>
Date: Thu, 18 Jan 2024 13:33:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] test: unit test for smbios command
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
 <20240117153347.85074-4-heinrich.schuchardt@canonical.com>
 <CAC_iWjJv9Ff-sTq63b2L8vrarcpedNsDFg3iokwAgpzFAbZuHw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjJv9Ff-sTq63b2L8vrarcpedNsDFg3iokwAgpzFAbZuHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 1/18/24 12:51, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> On Wed, 17 Jan 2024 at 17:34, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Provide a unit test for the smbios command.
>>
>> Provide different test functions for QEMU, sandbox, and other systems.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          for generic boards we only can assume that a type 127 table exists
>>          email address updated
>> ---
>>   test/py/tests/test_smbios.py | 41 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>   create mode 100644 test/py/tests/test_smbios.py
>>
>> diff --git a/test/py/tests/test_smbios.py b/test/py/tests/test_smbios.py
>> new file mode 100644
>> index 00000000000..82b0b689830
>> --- /dev/null
>> +++ b/test/py/tests/test_smbios.py
>> @@ -0,0 +1,41 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +"""Test smbios command"""
>> +
>> +import pytest
>> +
>> +@pytest.mark.buildconfigspec('cmd_smbios')
>> +@pytest.mark.notbuildconfigspec('qfw_smbios')
>> +@pytest.mark.notbuildconfigspec('sandbox')
>> +def test_cmd_smbios(u_boot_console):
>> +    """Run the smbios command"""
>> +    output = u_boot_console.run_command('smbios')
>> +    assert 'DMI type 127,' in output
>> +
>> +@pytest.mark.buildconfigspec('cmd_smbios')
>> +@pytest.mark.buildconfigspec('qfw_smbios')
>> +@pytest.mark.notbuildconfigspec('sandbox')
>> +# TODO:
>> +# QEMU v8.2.0 lacks SMBIOS support for RISC-V
>> +# Once support is available in our Docker image we can remove the constraint.
>> +@pytest.mark.notbuildconfigspec('riscv')
>> +def test_cmd_smbios_qemu(u_boot_console):
>> +    """Run the smbios command on QEMU"""
>> +    output = u_boot_console.run_command('smbios')
>> +    assert 'DMI type 1,' in output
>> +    assert 'Manufacturer: QEMU' in output
>> +    assert 'DMI type 127,' in output
> 
> Is there an easy way to run this test with and without the SMBIOS
> tables provided by QEMU? We could test the u-boot generated ones that
> way

We already test the sandbox without QFW. I would not want to duplicated 
QEMU defconfigs.

Best regards

Heinrich

> 
> Thanks
> /Ilias
>> +
>> +@pytest.mark.buildconfigspec('cmd_smbios')
>> +@pytest.mark.buildconfigspec('sandbox')
>> +def test_cmd_smbios_sandbox(u_boot_console):
>> +    """Run the smbios command on the sandbox"""
>> +    output = u_boot_console.run_command('smbios')
>> +    assert 'DMI type 0,' in output
>> +    assert 'String 1: U-Boot' in output
>> +    assert 'DMI type 1,' in output
>> +    assert 'Manufacturer: sandbox' in output
>> +    assert 'DMI type 2,' in output
>> +    assert 'DMI type 3,' in output
>> +    assert 'DMI type 4,' in output
>> +    assert 'DMI type 127,' in output
>> --
>> 2.43.0
>>

