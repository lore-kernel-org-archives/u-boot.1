Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A875E6C5F3
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 03:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8C6B895EC;
	Tue,  3 Dec 2024 04:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF022895F3; Tue,  3 Dec 2024 04:05:35 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 200A188E32
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 04:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip3t1733195097t5xn32s
X-QQ-Originating-IP: KC7oSmas/IwyJJ8VNyplJFuMYKl1oh6GoFh/81HJ0Ig=
Received: from [IPV6:240f:10b:7440:1:f61a:d8:e ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 03 Dec 2024 11:04:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8493613330952957343
Message-ID: <0327B36119FCCCA7+a2c1093d-12e9-45a6-93bc-7ebc08ba6a77@radxa.com>
Date: Tue, 3 Dec 2024 12:04:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3399: expand space for decompressed kernel
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, chris.obbard@collabora.com,
 pbrobinson@gmail.com, jonas@kwiboo.se, sjg@chromium.org
References: <20241202234018.92120-1-naoki@radxa.com>
 <8330654E611213C4+6a97c5b4-7b20-4467-a627-4f16a9899ad4@radxa.com>
Content-Language: en-US
In-Reply-To: <8330654E611213C4+6a97c5b4-7b20-4467-a627-4f16a9899ad4@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NFNrK8KlcSCRKoy72dZ7IgqkD+PIhlqdbhqtoKRllaFVG5HHk8CSiANw
 wLdMGmNGs1Zd3ki1rNoi2xQTdk67k0PQYQUnEBh3a1mtyaU2dP/+ZRswbV7J6X5wBYQS6t2
 /4Kn5ywHbf6Hrdz09B2ASRE5sJZjzAj3xOrJpo9sutkitk0sZvdGnsywK002tieTlDWKQ7R
 uXdf1Z7y01bBG88RINVGJEsc65bitDvuFfhk761U7+mjed0i5vG98n1C9iTFVIeNCYSLaHj
 WsFiXM+136hGU6peTM7O7kdSVJEJCTFMlsUvkIKHmOxzRtq5QCvHRiomQLwIYbcnLP0FTNa
 YINVGJRKdyW8yfMii2QOuKt0SPnk7FYclw3mg/Cy1gKBNyODEryUCfnoZhWtR3v4t9cE4ub
 GZji9/U1b3QpsSFi8sO8LvD9fGWFtf0DQ+IfFH/7sbar9AkyNCtDAj2fQhJo/XlHe/nq0cR
 r73RkdVm/jb/X91JBFgKq8qCDa1z/to37Bp4RniEtbM/R8zEoEZQfROGwFX32271jkZcTh+
 mMA1HYkgXEPF7hJ2gLemt9DPgWmjD4XBYar7P0MTKX/ZNxD8A3xCf1ZgREijqAN2Z8q6Wxz
 K6nFdPOgu6Ho6u/QfB5AojrUp72qQC47+RIwEIiPrD5Ff78AvLJfbzD0zfj0EqgnP+a5fCU
 VHcrLj/hxv/Ck9SjpwbZ9JQxrD6KHvV3RBYf9bizHsaxAXNYUsrXrtgRY6UidBZAam884fX
 lgKPqHkCYKAuPPQiZBy1Hs0OWEVCqD+UN2wxRjDTst4iPgX0MZojxriYhUZYIMyfxzR18Kq
 /wKLUQHLG1pgW+eumlV1GKGKUj5ATAuvJ+5BD8FHq5pgRpfzztWmgyZED221KpoesLe276q
 ywQv7v1qtOwSGlOjCIW8N9RSZQHqOLZhiUJXzQAmS4VIO6jXvmdYQw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
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


On 12/3/24 11:39, FUKAUMI Naoki wrote:
> Hi,
> 
> I'm thinking to do same (or similar) fix for RK3328 too.
> 
> that configuration should work with 512MB RAM device, right?

I noticed there is 256MB RK3328 device. I need to think about it.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Best regards,
> 
> -- 
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
> 
> On 12/3/24 08:40, FUKAUMI Naoki wrote:
>> fix following error by using same ENV_MEM_LAYOUT_SETTINGS with rk35xx:
>>
>> U-Boot 2025.01-rc3-00001-g1527c7dcdb01 (Dec 02 2024 - 22:57:18 +0000)
>>    :
>> Retrieving file: /boot/extlinux/../nixos/ 
>> dhqjsnprmzjxncil3m0g9l09a479crn3-linux-6.12.1-Image
>> Retrieving file: /boot/extlinux/../ 
>> nixos/6fq8fmmab31yxdwcs7zw44p78fq9fy1s-initrd-linux-6.12.1-initrd
>> append: init=/nix/store/yjbxgzf1vkwbw6ab738bf4kxazhyypa1-nixos-system- 
>> rock-5b-25.05.20241201.ac35b10/init console=ttyS2,1500000n8 
>> console=ttyAMA0,115200n8 console=tty0 loglevel=7
>> Retrieving file: /boot/extlinux/../nixos/ 
>> dhqjsnprmzjxncil3m0g9l09a479crn3-linux-6.12.1-dtbs/rockchip/rk3399- 
>> rock-4se.dtb
>> Moving Image from 0x2080000 to 0x2200000, end=0x60d0000
>> ERROR: RD image overlaps OS image (OS=2200000..60d0000)
>> Boot failed (err=-14)
>>
>> $ ls -lh boot/nixos/
>> total 84M
>> -r--r--r--  1 root root  24M Jan  1  1970 
>> 6fq8fmmab31yxdwcs7zw44p78fq9fy1s-initrd-linux-6.12.1-initrd
>> -r--r--r--  1 root root  62M Jan  1  1970 
>> dhqjsnprmzjxncil3m0g9l09a479crn3-linux-6.12.1-Image
>> dr-xr-xr-x 36 root root 4.0K Jan  1  1970 
>> dhqjsnprmzjxncil3m0g9l09a479crn3-linux-6.12.1-dtbs
>>
>> similar problem was fixed for rk35xx by:
>>
>> commit 69b73877f02c ("rockchip: rk35xx: expand space for decompressed 
>> kernel")
>>
>> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>> ---
>>   include/configs/rk3399_common.h | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/configs/rk3399_common.h b/include/configs/ 
>> rk3399_common.h
>> index c5bcd7dc5e8a..76f40e7cd5f8 100644
>> --- a/include/configs/rk3399_common.h
>> +++ b/include/configs/rk3399_common.h
>> @@ -20,16 +20,16 @@
>>   #endif
>>   #define ENV_MEM_LAYOUT_SETTINGS        \
>> -    "scriptaddr=0x00500000\0"    \
>> +    "scriptaddr=0x00c00000\0"    \
>>       "script_offset_f=0xffe000\0"    \
>>       "script_size_f=0x2000\0"    \
>> -    "pxefile_addr_r=0x00600000\0"    \
>> -    "fdt_addr_r=0x01e00000\0"    \
>> -    "fdtoverlay_addr_r=0x01f00000\0"    \
>> -    "kernel_addr_r=0x02080000\0"    \
>> -    "ramdisk_addr_r=0x06000000\0"    \
>> -    "kernel_comp_addr_r=0x08000000\0"    \
>> -    "kernel_comp_size=0x2000000\0"
>> +    "pxefile_addr_r=0x00e00000\0"    \
>> +    "kernel_addr_r=0x02000000\0"    \
>> +    "kernel_comp_addr_r=0x0a000000\0"    \
>> +    "fdt_addr_r=0x12000000\0"    \
>> +    "fdtoverlay_addr_r=0x12100000\0"    \
>> +    "ramdisk_addr_r=0x12180000\0"    \
>> +    "kernel_comp_size=0x8000000\0"
>>   #define CFG_EXTRA_ENV_SETTINGS        \
>>       "fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"    \
> 
> 


