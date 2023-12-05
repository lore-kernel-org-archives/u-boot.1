Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A351AC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 20:00:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9B0C870B5;
	Tue,  5 Dec 2023 21:00:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DLO5sKsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3F15870F2; Tue,  5 Dec 2023 21:00:34 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9366187015
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 21:00:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a1a496a73ceso4705866b.2
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 12:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701806431; x=1702411231; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ma6JrezXsG6NNcFKpzEQDLb5x+aqXRaCHVl0X5lfmwo=;
 b=DLO5sKsGw9serBGDZWO3AhJ/maGt5koV2ZffrqlEZa4oD6fj/Xt4BQV8J3lSBvVQeK
 1LN18YQguy3WeX+djJaMKbwEgMxz5D8gMX+zCstUL59pkB5V25xdI+GBmi8GSe+Umgz4
 LGecUzG+tL37458oH15UJzv2wrXAy7zTzHHYHHLzez/9KSu4jfPCPzKAGFhz46Vikwmn
 Mz1pVanc6MuBcR5yhCRFUTsxEdYH27SmV9rXwcDCXDbBUqMNHv5CI4zKweXIbUhQFv/O
 cx6dwelgWHDnX1btEL88pdfClR8/hC8GXw1g6qbexh3atLq7VP8aTar8Fu/D/DRR/CaX
 zNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701806431; x=1702411231;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ma6JrezXsG6NNcFKpzEQDLb5x+aqXRaCHVl0X5lfmwo=;
 b=ZYOo50cg3TyCsJyLQYaRh0uNrclgrBsv7j09Tm2f6dQxuDVcYZmjo8koQ4Mw0WhUUW
 rHNsHt0dFzLiwXqvajToD3SHxfBLTR+zqBTylB9sbOfLPkZLmqxUFhdCyinn0AoMha3O
 IUO/jHyAwkb6xQbNA00j+yvk4GGyTOlOnLUb1oB1yAMx+PKWcwmXj2CChU9exSovLxxP
 WtMgcZE1beJ5yFSN40I8JUzWuaQ87thVIp+vN4MiNFKbCmFGoBly3n1Crkua1FPOpRqp
 gnemJjGKBTalqirEnwI3PpdHkUsHUNdCvkB978P5FMxFune25bURN4Oc5RC4ReJdezd8
 pOnw==
X-Gm-Message-State: AOJu0YwXRh66k1+ZTYQNoYF0wM1ORIOhn8/pN0ZsGiXhc9HGq81ROurp
 nuN4KQpST0Eabdr7pbZOl8Mktj4hoSxLjwGoUwznuQ==
X-Google-Smtp-Source: AGHT+IHgvbwVSHwk6J8WDwqbfXwctoBNwze0JVzg3t7WHvszV6EsWQOiVCe7r947qYiHH2mla64R5zoU3u0iBMfqiVE=
X-Received: by 2002:a17:907:1582:b0:a19:a19b:789f with SMTP id
 cf2-20020a170907158200b00a19a19b789fmr927710ejc.98.1701806430870; Tue, 05 Dec
 2023 12:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-27-maxim.uvarov@linaro.org>
 <20231127131129.GD2513409@bill-the-cat>
 <c7022ef3-ad0c-4f89-ad47-a0f7df2a24c6@web.de>
 <CAD8XO3aVLzpqV=MDVO2mJBP=sLzSieXhrV8GUPYPpu76mRKjeQ@mail.gmail.com>
 <CAD8XO3Y4_=8wDQcFNJW1MT1yiyDmbQxP3UCRWWWPZzuJkZp88g@mail.gmail.com>
 <1402b942-9ce9-4bc3-9fac-0eb438b23e77@web.de>
 <CAD8XO3bYyfDVnVQdcqDji39Y=i1Q2jdG-SQ6KUWsBPo0umoZnQ@mail.gmail.com>
 <b47859ca-36d3-4eee-88fb-f7859e69ff2d@web.de>
In-Reply-To: <b47859ca-36d3-4eee-88fb-f7859e69ff2d@web.de>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Wed, 6 Dec 2023 02:00:18 +0600
Message-ID: <CAD8XO3Zqt1SN6t4MWXozJ4R-FjQ1324Vn5=h6xCe13gwxb9qSA@mail.gmail.com>
Subject: Re: [PATHv11 26/43] configs/tbs2910_defconfig inc limit
To: Soeren Moch <smoch@web.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, 6 Dec 2023 at 00:25, Soeren Moch <smoch@web.de> wrote:

>
>
> On 05.12.23 17:25, Maxim Uvarov wrote:
>
>
>
> On Tue, 5 Dec 2023 at 21:49, Soeren Moch <smoch@web.de> wrote:
>
>> On 05.12.23 14:15, Maxim Uvarov wrote:
>>
>> I think I solved the size issue on all the boards.
>>
>> Key changes:
>> 1. remove compilation of original ping.c and tftp.c (tftp had also server
>> code, so I will partially bring it back.)
>>
>> Interesting.
>> @Tom: Is there other server code in u-boot, that is enabled by default
>> (and can be used to reclaim code space)?
>> Fur sure I do not need u-boot to act as server for tftp (maye nfs,
>> others).
>>
>
> Maybe I need to be more clear about this. reference to code from tftp.c
> and ping.c exist in net.c, test/image/spl_load_net.c, test.dm/dsa.c,
> test/dm/eth.c.
> And even if that code is not used (replaced with lwip calls to the same
> commands in my case) it adds additional size. Even enabled LTO does not see
> direct difference.
>
> So 'server code' does not mean u-boot acting as network server, you mean
> this code is referenced by something else? And things in test do increase
> image size?
>
>
>
>
>> 2. LTO=y
>> 3. CONFIG_LOGLEVEL=3 instead of 4.
>> 4. CONFIG_CMD_DATE is not set
>> 5. CONFIG_CMD_LICENSE is not set
>> 6. CONFIG_CMD_PING (if 1-6 did not help).
>>
>> And these changes were enough for CI tagrets to build.
>> I also tested that Raspberry PI 4B works fine (dhcp, ping). Looking for
>> other boards to test.
>>
>> For example for this tbs2910 board changes are:
>>
>> Disabling CMD_DATE is unfortunate. This can help to debug RTC problems
>> (already used it for this purpose).
>> And, if we are that close to the size limit, than maybe we can get away
>> for this series, but for sure will run into trouble for every other small
>> change to u-boot core/driver code.
>>
>> Regards,
>> Soeren
>>
>
> The problem is that for many targets the limit is 1MB.
>
> For tbs2910 it is 383kBytes. And there was plenty of free space when I
> introduced mainline u-boot support. But yes, space got tighter over time.
>

Hm,
orig:
-rw-r--r-- 1 uboot uboot 371K Dec  5 19:54 u-boot.bin
lwip:
-rw-r--r-- 1 uboot uboot 380K Dec  5 19:55 u-boot.bin

Then if I just enable CMD_DATE:
u-boot.imx exceeds file size limit:
  limit:  0x5fc00 bytes
  actual: 0x60c00 bytes
  excess: 0x1000 bytes
make: *** [Makefile:1240: u-boot.imx] Error 1
make: *** Deleting file 'u-boot.imx'
uboot@3eebd85985c8:~/uboot-size$ ls -lh u-boot.bin
-rw-r--r-- 1 uboot uboot 382K Dec  5 19:58 u-boot.bin

So limit for your board is:
(gdb) p 0x5fc00/1024
$1 = 383

383k. Where do you see the space?

BR,
Maxim.



> U-Boot in some minimal configuration is about 500kb. But U-boot with EFI,
> USB, Eth drivers,  MMC, RTC, and all the commands is 900+ kb and very close
> to 1MB. Most of the new features are enabled by default.
>
> No. Tom does a very good job to ensure that there is no (not much)
> additional space required for unrelated boards that do not need new
> features.
>
> I.e. they do not exist in _defconfig and appear in the resulting .config
> automatically.  I would say that for some small targets things like EFI,
> Secure boot, TPM, Updates and many others are not needed. But if new
> features will appear by default very soon we will see limits.
>
> New features will not be enabled for old space constrained boards. In your
> series you did not offer to keep the old implementation instead, this is
> different and the reason why we discuss image size constraints.
>
> Regards,
> Soeren
>
>
> BR,
> Maxim.
>
>>
>> --- a/configs/tbs2910_defconfig
>> +++ b/configs/tbs2910_defconfig
>> @@ -18,6 +18,7 @@ CONFIG_SYS_MEMTEST_END=0x2f400000
>>  CONFIG_LTO=y
>>  CONFIG_HAS_BOARD_SIZE_LIMIT=y
>>  CONFIG_BOARD_SIZE_LIMIT=392192
>> +CONFIG_TIMESTAMP=y (this was added by savedefconfig)
>>  # CONFIG_BOOTSTD is not set
>>  CONFIG_SUPPORT_RAW_INITRD=y
>>  CONFIG_BOOTDELAY=3
>> @@ -26,6 +27,7 @@ CONFIG_BOOTCOMMAND="mmc rescan; if run bootcmd_up1;
>> then run bootcmd_up2; else r
>>  CONFIG_USE_PREBOOT=y
>>  CONFIG_PREBOOT="echo PCI:; pci enum; pci 1; usb start"
>>  CONFIG_DEFAULT_FDT_FILE="imx6q-tbs2910.dtb"
>> +CONFIG_LOGLEVEL=3
>>  CONFIG_PRE_CONSOLE_BUFFER=y
>>  CONFIG_HUSH_PARSER=y
>>  CONFIG_SYS_PROMPT="Matrix U-Boot> "
>> @@ -52,7 +54,7 @@ CONFIG_CMD_DHCP=y
>>  CONFIG_CMD_MII=y
>>  CONFIG_CMD_PING=y
>>  CONFIG_CMD_CACHE=y
>> -CONFIG_CMD_TIME=y
>> +# CONFIG_CMD_DATE is not set
>>  CONFIG_CMD_SYSBOOT=y
>>  # CONFIG_CMD_VIDCONSOLE is not set
>>  CONFIG_CMD_EXT2=y
>>
>> BR,
>> Maxim.
>>
>>
>> On Tue, 28 Nov 2023 at 13:09, Maxim Uvarov <maxim.uvarov@linaro.org>
>> wrote:
>>
>>>
>>>
>>> On Tue, 28 Nov 2023 at 03:20, Soeren Moch <smoch@web.de> wrote:
>>>
>>>> On 27.11.23 14:11, Tom Rini wrote:
>>>> > On Mon, Nov 27, 2023 at 06:57:09PM +0600, Maxim Uvarov wrote:
>>>> >
>>>> >> Increase allowed binary size to fit lwip code.
>>>> >>
>>>> >> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>>>> >> ---
>>>> >>   configs/tbs2910_defconfig | 2 +-
>>>> >>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>> >>
>>>> >> diff --git a/configs/tbs2910_defconfig b/configs/tbs2910_defconfig
>>>> >> index 8fbe84f1d2..ce40efa9ab 100644
>>>> >> --- a/configs/tbs2910_defconfig
>>>> >> +++ b/configs/tbs2910_defconfig
>>>> >> @@ -17,7 +17,7 @@ CONFIG_SYS_MEMTEST_START=0x10000000
>>>> >>   CONFIG_SYS_MEMTEST_END=0x2f400000
>>>> >>   CONFIG_LTO=y
>>>> >>   CONFIG_HAS_BOARD_SIZE_LIMIT=y
>>>> >> -CONFIG_BOARD_SIZE_LIMIT=392192
>>>> >> +CONFIG_BOARD_SIZE_LIMIT=417792
>>>> >>   # CONFIG_BOOTSTD is not set
>>>> >>   CONFIG_SUPPORT_RAW_INITRD=y
>>>> >>   CONFIG_BOOTDELAY=3
>>>> > This is another case where the binary size is a fairly hard limit. You
>>>> > forgot to cc the board maintainer here (and I assume the rest of the
>>>> > series too) for these config changes.
>>>> ThanksTom for sending a notification to me.
>>>>
>>>> Yes, the CONFIG_BOARD_SIZE_LIMIT is a hard limit and this patch in its
>>>> current form will break tbs2910 support and even brick the board for
>>>> some configurations. So NAK for this patch.
>>>> > I think on this platform it's not
>>>> > impossible (like it is on am335x where I just replied) but really
>>>> > difficult. I'll let Soeren comment on if switching the network stack
>>>> to
>>>> > lwip is the kind of feature enhancement that warrants the pain of
>>>> > dealing with the size change here or not.
>>>> Network boot is no important feature for this board and not used in
>>>> the default boot configuration. But network support always was part
>>>> of the config, may be used by some users, and is at least required
>>>> to communicate the ethernet address to linux.
>>>>
>>>> So I'm not interested in a new network stack for this board, but
>>>> also cannot disable network support completely. This seems to be a
>>>> problem for this patch series, since networking support implies LWIP
>>>> now.
>>>>
>>>>
>>> Thanks Soeren for the explanation. Then yes, something more advanced is
>>> needed
>>> to be done here.
>>>
>>>
>>>
>>>> The question for me is, why is the new network stack consuming so
>>>> much space, with only a few enabled commands? Is the whole library
>>>> linked in with some unused features (the cover letter mentions much
>>>> more than what seems to be used in the converted commands). Or is
>>>> the old network stack linked in in parallel to the new one? Can
>>>> we save space here?
>>>>
>>>
>>> Yes, the old code is still there. I decided to not touch it for the
>>> first integration (arp.o, bootp.o, ping.o and
>>> mostly all from net/Makefile).  Those files also have reference code in
>>> net/net.c. Not compiling
>>> and not linking this code will save some space, but It's larger than the
>>> current version.
>>> Like for EVM SPL code with usb+net+ext4 and etc have very minimal space
>>> for network stack.
>>> I will take a look at this more closely...
>>>
>>>
>>>>
>>>> NFS support in the old networking code is quite big, enabled by default,
>>>> and probably still there in parallel to this new lwip library. If there
>>>> is really no other option to save space, and lwip in general is agreed
>>>> to be the way forward for U-Boot, and only tbs2910 is blocking that,
>>>> then from my point of view disabling NFS for tbs2910 could be a way
>>>> to stay within the size limit.
>>>>
>>>> ok. I think that by default we need something very minimal (dhcp,
>>> tftp),  probably ping is even not needed.
>>>
>>>
>>>
>>>> Regards,
>>>> Soeren
>>>>
>>>>
>>
>
