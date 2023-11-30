Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9FFC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 00:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62D8887073;
	Thu, 30 Nov 2023 01:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAFE387073; Thu, 30 Nov 2023 01:11:00 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 84B6B86940
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 01:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9215F1042;
 Wed, 29 Nov 2023 16:11:43 -0800 (PST)
Received: from [192.168.1.247] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5F8D3F73F;
 Wed, 29 Nov 2023 16:10:54 -0800 (PST)
Message-ID: <3c5b7d67-f8e5-41a3-a34b-8f59f9adb117@arm.com>
Date: Thu, 30 Nov 2023 00:10:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: OrangePI Zero3 memory timing testing
Content-Language: en-US
To: Stephen Graf <stephen.graf@gmail.com>
Cc: Mikhail Kalashnikov <iuncuim@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
References: <20231114013106.31336-1-andre.przywara@arm.com>
 <20231114013106.31336-4-andre.przywara@arm.com>
 <0eab5c21-4fdc-478e-9071-f43c12e01fb3@gmail.com>
 <20231126002349.55404e43@slackpad.lan>
 <465a5608-89f7-4691-a2e0-ebec9b85d994@gmail.com>
 <20231126122342.3944cad5@slackpad.lan>
 <d8862c87-072d-4f74-bb37-08f34c610cc8@gmail.com>
 <dae3bee5-e1c7-4154-959c-e41dabb5d844@gmail.com>
 <20231128013746.23648d39@slackpad.lan>
 <0560924e-119b-4122-ad5b-bd563554eb10@gmail.com>
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <0560924e-119b-4122-ad5b-bd563554eb10@gmail.com>
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

Hi Stephen,

On 29/11/2023 18:45, Stephen Graf wrote:
> Some testing results:
> 
> With the default DRAM timing of 30x24=720, most often when my system 
> boots it comes up with DRAM 2G, but I have a 1G system. Once in a while 
> the boot shows 1G.  When it shows 2G the linux OS also shows 2G and 
> continuing does not make much sense.
> 
> On one boot where u-boot reported 1G the OS agreed and I ran memtester 
> successfully.
> 
> If I build u-boot with CONFIG_DRAM_CLK=792 (33*24=792) I have never seen 
> my system boot with anything other than DRAM 1G showing in u-boot. I ran 

Interesting, many thanks for the elaborate experiments!
To be fair, the timing parameters were from Xunlong's setup, so with 792 
MHz, but I remember that in my early testing this failed more often than 
not, so I reverted back to 720MHz. But I had different parameters back 
then, I believe. I will try to arrange some boot loop, to see how it 
fares with the 792 MHz, though I believe you that it's more stable.
If that works, I will send a v2 with the USB and the DRAM clock fixed.

Thanks again for testing and the report!

Cheers,
Andre

> memtester successfully and this system has been stable running linux 6.6.2.
> 
> Andre, if you can put together a few patches I can test them to see 
> which works.
> 
> If anyone else with different variations of the Zero3 would test with 
> the two DRAM timings and report results.
> 
> I also use the Zunlong image on occasion and it consistently shows 1G 
> and from my poking around I think it runs at a 792 clk.
> 
> 
> Console output with DRAM default:
> 
> U-Boot 2024.01-rc3-00028-g43f2873fa9-dirty (Nov 28 2023 - 22:46:39 
> -0800) Allwinner Technology
> 
> CPU:   Allwinner H616 (SUN50I)
> Model: OrangePi Zero3
> DRAM:  2 GiB
> 
> Last login: Wed Nov 29 09:35:15 PST 2023 on ttyS0
> root@orangepizero3:~# free -h
>                 total        used        free      shared  buff/cache 
> available
> Mem:           1.9Gi       139Mi       1.7Gi       360Ki        82Mi   
> 1.7Gi
> Swap:             0B          0B          0B
> 
> 
> U-Boot 2024.01-rc3-00028-g43f2873fa9-dirty (Nov 28 2023 - 22:46:39 
> -0800) Allwinner Technology
> 
> CPU:   Allwinner H616 (SUN50I)
> Model: OrangePi Zero3
> DRAM:  1 GiB
> 
> root@orangepizero3:~# free -h
>                 total        used        free      shared  buff/cache 
> available
> Mem:           917Mi       137Mi       766Mi       360Ki        79Mi   
> 780Mi
> Swap:             0B          0B          0B
> 
> 
> root@orangepizero3:~# memtester 700M 1
> memtester version 4.6.0 (64-bit)
> Copyright (C) 2001-2020 Charles Cazabon.
> Licensed under the GNU General Public License version 2 (only).
> 
> pagesize is 4096
> pagesizemask is 0xfffffffffffff000
> want 700MB (734003200 bytes)
> got  700MB (734003200 bytes), trying mlock ...locked.
> Loop 1/1:
>    Stuck Address       : ok
>    Random Value        : ok
>    Compare XOR         : ok
>    Compare SUB         : ok
>    Compare MUL         : ok
>    Compare DIV         : ok
>    Compare OR          : ok
>    Compare AND         : ok
>    Sequential Increment: ok
>    Solid Bits          : ok
>    Block Sequential    : ok
>    Checkerboard        : ok
>    Bit Spread          : ok
>    Bit Flip            : ok
>    Walking Ones        : ok
>    Walking Zeroes      : ok
>    8-bit Writes        : ok
>    16-bit Writes       : ok
> 
> Done.
> 
> Console output with DRAM clk 792:
> 
> 
> U-Boot 2024.01-rc3-00028-g43f2873fa9-dirty (Nov 28 2023 - 21:34:46 
> -0800) Allwinner Technology
> 
> CPU:   Allwinner H616 (SUN50I)
> Model: OrangePi Zero3
> DRAM:  1 GiB
> 
> root@orangepizero3:~# free -h
>                 total        used        free      shared  buff/cache 
> available
> Mem:           917Mi       134Mi       768Mi       360Ki        79Mi   
> 782Mi
> Swap:             0B          0B          0B
> 
> 
> root@orangepizero3:~# memtester 700M 1
> memtester version 4.6.0 (64-bit)
> Copyright (C) 2001-2020 Charles Cazabon.
> Licensed under the GNU General Public License version 2 (only).
> 
> pagesize is 4096
> pagesizemask is 0xfffffffffffff000
> want 700MB (734003200 bytes)
> got  700MB (734003200 bytes), trying mlock ...locked.
> Loop 1/1:
>    Stuck Address       : ok
>    Random Value        : ok
>    Compare XOR         : ok
>    Compare SUB         : ok
>    Compare MUL         : ok
>    Compare DIV         : ok
>    Compare OR          : ok
>    Compare AND         : ok
>    Sequential Increment: ok
>    Solid Bits          : ok
>    Block Sequential    : ok
>    Checkerboard        : ok
>    Bit Spread          : ok
>    Bit Flip            : ok
>    Walking Ones        : ok
>    Walking Zeroes      : ok
>    8-bit Writes        : ok
>    16-bit Writes       : ok
> 
> Done.
> 
> 
> On 2023-11-27 5:37 p.m., Andre Przywara wrote:
> 
>>
>> This symptom is pretty surely not directly related to the DRAM
>> frequency, it's caused by a missing barrier or delay *somewhere*.
>> People report that this is fixed by adding another "dsb();" at the
>> beginning of the mctl_mem_matches() function, but I don't have a good
>> explanation why exactly there, and would like to avoid submitting
>> patches that "just seem to work (TM)".
>>
>> If I find some time, I will try to setup some automated environment
>> where I can run some experiments with different barrier locations.
>> I can offer some rationale for putting it at the end of the function(s)
>> that call mctl_mem_matches(), so hope that this fixes it.
>>
>> Cheers,
>> Andre
>>
