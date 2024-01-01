Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BC5C4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 23:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF58487718;
	Tue,  2 Jan 2024 00:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kq0rQ9+Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D87487792; Tue,  2 Jan 2024 00:05:37 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 359F18770A
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 00:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 59E7E3F25A; 
 Mon,  1 Jan 2024 23:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704150333;
 bh=JMic69KADo3QksTQ2FBXFKq0LKEOBAsOHdWl345sRNg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=kq0rQ9+YZ3LEc+y/C1l2G1tOOAz0lbsJyi838LAcjUFdflTVoGRkabyC+LcrUAJD7
 FSPtS0GEmcXKD5I13Thu/eZLaJqqHw7dBW77ahw+lELDRjM4KeA4FLYmy1O674v7hA
 VRZ953x75ytNRkNV8Bwbm/HocAyxVsSdUfkzSTI4cT+TuGVhIJIbL5IDqStaBOyo1Y
 q1YqwzVg22OlyiV/Rx2kHIv9OyYin2mBkKmAuNrQ27W6q3Jf/I/wdyNX/2kiKzJPjx
 rfBJPhfxVeAvKj0kLQtE9LZKAtjhNmAcrnhNAXSl4NkmQcMnldW+Jy3iEAckQiN8OY
 tbk98wrznRhIA==
Message-ID: <8911ae73-e707-4bd0-8e99-9f859cad99d1@canonical.com>
Date: Tue, 2 Jan 2024 00:05:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86: all firmware tables must be paragraph aligned
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20240101115250.78735-1-heinrich.schuchardt@canonical.com>
 <CAFLszTicbA6i9ix2ereRnQtRy5UR=B0rVSUdznqQHPkBCThi=Q@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTicbA6i9ix2ereRnQtRy5UR=B0rVSUdznqQHPkBCThi=Q@mail.gmail.com>
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
> On Mon, Jan 1, 2024 at 4:52 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On qemu-x86_64_defconfig the following was observed:
>>
>>      => efidebug tables
>>      00000000000f0074  eb9d2d31-2d88-11d3-9a16-0090273fc14d  SMBIOS table
>>
>> The SMBIOS configuration table does not point to a paragraph aligned
>> address. The reason is that in write_tables() rom_addr is not aligned and
>> copied to gd->arch.smbios_start.
>>
>> The Simple Firmware Interface requires that the SFI table is paragraph
>> aligned but our code does not guarantee this.
>>
>> As all tables written in write_tables() must be paragraph aligned, we
> 
> paragraph-aligned
> 
> But was is a paragraph? Is that an x86 term?

The term paragraph is used by the SMBIOS spec.

The reason why non-UEFI x86 requires low addresses (< 1MiB) for tables 
is that booting starts in real-mode.

Any memory address evenly divisible by 16 is called a paragraph 
boundary. [1]

[1] Memory Paragraphs in Real Mode
     http://www.c-jump.com/CIS77/ASM/Memory/M77_0080_paragraphs.htm

A segment begins on a paragraph boundary, which is an address divisible 
by decimal 16 or hex 10. [2]

[2] Programming with 8086 microprocessor
     https://www.uobabylon.edu.iq/eprints/publication_1_2613_35.pdf

Best regards

Heinrich

> 
>> should implement the address rounding in write_tables() and not in table
>> specific routines like copy_pirq_routing_table().
>>
>> Add paragraph alignment in write_tables().
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   arch/x86/lib/tables.c | 2 ++
>>   1 file changed, 2 insertions(+)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> 
>>
>> diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
>> index 5b5070f7ca..89d4d30a6a 100644
>> --- a/arch/x86/lib/tables.c
>> +++ b/arch/x86/lib/tables.c
>> @@ -97,6 +97,8 @@ int write_tables(void)
>>                  int size = table->size ? : CONFIG_ROM_TABLE_SIZE;
>>                  u32 rom_table_end;
>>
>> +               rom_addr = ALIGN(rom_addr, 16);
>> +
>>                  if (!strcmp("smbios", table->name))
>>                          gd->arch.smbios_start = rom_addr;
>>
>> --
>> 2.43.0
>>

