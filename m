Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC604C4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 23:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E3A48755C;
	Tue,  2 Jan 2024 00:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VygL8hT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBCE687708; Tue,  2 Jan 2024 00:23:53 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D357E871B4
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 00:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 076AF3F5F0; 
 Mon,  1 Jan 2024 23:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704151431;
 bh=h0qyIdCYlbnlIVhWu0z+3xaO753B0eSJlpY6fjecgts=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=VygL8hT+qphZ3j5zKrx9B6AThEc3T0YWz78Q7LBaxRjYf66dZrTb8B8TLwFEFwZA0
 EEb4oPzVvKQuF6ciuXNwilGDC9iIyPK9GRazSyBhAgpJnxDdvAJiQuIIS3jKRwiOQO
 eGQmCfZEzyy5/+7o8ihgHG/vvzaxkDmTUIl26OjGFbErSHAYx+i7+to2mZtGQZk09e
 eVhfGAVAP2UpMBFSlvwy7wok0266o6e9/fxnjkzUNn9oBpAZxZ0bliKmNutB+K2iUj
 v8JL9x6SDWyXhVe+icuCYas9c8p/+928LYps6QS6khnc0+HSUOntqDWmpvd3JJ4Ulh
 rSy6/iMgbjfpQ==
Message-ID: <c2f78de7-9dc7-47f2-a3f7-3ce84917ac99@canonical.com>
Date: Tue, 2 Jan 2024 00:23:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] efi_loader: provide tool to dump SMBIOS table
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20240101185004.268790-1-heinrich.schuchardt@canonical.com>
 <20240101185004.268790-3-heinrich.schuchardt@canonical.com>
 <CAFLszTiH6awH9jt514b0Tod-dB0jigYa3vo2gtTRxZHRk2nNkw@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTiH6awH9jt514b0Tod-dB0jigYa3vo2gtTRxZHRk2nNkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 1/1/24 23:41, Simon Glass wrote:
> Hi Heinrich,
> 
> On Mon, Jan 1, 2024 at 11:50 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> An EFI binary dmidump.efi is provided that can be used to check the SMBIOS
>> table for consistency and to dump it as a file.
>>
>> The tool provides the following commands:
>>
>> check
>>      Check the SMBIOS table for consistency.
>>
>> exit
>>      Leave the tool.
>>
>> help
>>      Show available commands.
>>
>> save
>>      Save the SMBIOS table to a file on the EFI system partition. The file
>>      can be further analyzed with the dmidecode command line tool::
>>
>>          dmidecode --from-dump <filename>
>>
>> Specifying 'nocolor' as load option data suppresses colored output and
>> clearing of the screen.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          fix an incorrect variable usage when checking the result of memcmp
>> ---
>>   lib/efi_loader/Makefile  |   7 +
>>   lib/efi_loader/dmidump.c | 595 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 602 insertions(+)
>>   create mode 100644 lib/efi_loader/dmidump.c
> 
> Does this tool need tests?

Once we have all the SMBIOS stuff in, we could use the tool in a test to 
verify that the SMBIOS tables are correctly installed.

> 
> Can you please split up do_save() a bit and also move the command loop
> into its own function? Otherwise it looks good to me.
> 
>>
>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>> index 24d33d5409..71880d330e 100644
>> --- a/lib/efi_loader/Makefile
>> +++ b/lib/efi_loader/Makefile
>> @@ -16,6 +16,8 @@ CFLAGS_boothart.o := $(CFLAGS_EFI) -Os -ffreestanding
>>   CFLAGS_REMOVE_boothart.o := $(CFLAGS_NON_EFI)
>>   CFLAGS_helloworld.o := $(CFLAGS_EFI) -Os -ffreestanding
>>   CFLAGS_REMOVE_helloworld.o := $(CFLAGS_NON_EFI)
>> +CFLAGS_dmidump.o := $(CFLAGS_EFI) -Os -ffreestanding
>> +CFLAGS_REMOVE_dmidump.o := $(CFLAGS_NON_EFI)
>>   CFLAGS_dtbdump.o := $(CFLAGS_EFI) -Os -ffreestanding
>>   CFLAGS_REMOVE_dtbdump.o := $(CFLAGS_NON_EFI)
>>   CFLAGS_initrddump.o := $(CFLAGS_EFI) -Os -ffreestanding
> 
> Is there a way to have a list of these tools such that the flags stuff
> is done automatically and doesn't need to be repeated each time?

Looking at

scripts/Makefile.lib:102:
_c_flags = $(filter-out $(CFLAGS_REMOVE_$(basetarget).o), $(orig_c_flags))

this is not possible.

> 
>> @@ -31,6 +33,11 @@ always += helloworld.efi
>>   targets += helloworld.o
>>   endif
>>
>> +ifneq ($(CONFIG_GENERATE_SMBIOS_TABLE),)
>> +always += dmidump.efi
>> +targets += dmidump.o
> 
> How about smbios_tool ? I think 'dmi' is a bit of an obfuscation.

We can call it smbiosdump.efi.

Thanks for reviewing.

Best regards

Heinrich

> 
>> +endif
>> +
>>   ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
>>   always += dtbdump.efi
>>   targets += dtbdump.o
> 
> [..]
> 
> Regards,
> SImon

