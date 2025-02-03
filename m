Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3786EC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 14:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62E9A80079;
	Mon,  3 Feb 2025 15:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="0uwtrT4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E40980087; Mon,  3 Feb 2025 15:45:44 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4BC580077
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 15:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aafc9d75f8bso899237766b.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 06:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1738593941; x=1739198741;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jzjKmaSZD003iLOX56rBf+sGbNpeHMrLBL8YkdsE+qE=;
 b=0uwtrT4EK7kSXefFcz/CL0VYrCQMmYIvaLjybc92sSkEET5KRWuH7hSNudO8ATP1Bp
 sGGeWr5KXdFO0/IfD0LHMD5KCgCrWuU/KHcA44sbA1/ulvEHV2puOU5Wu5LzYCK8/WSf
 69rid2Bx5WLaexfvgdjQ9/zPBIbWDQIWc/ll8y8a1OtsKY5FwaW2Bb+ITLOU7DmlEQEt
 qXpIcz2WbZqaCwStEz7jr6YDSbhDq3Wh8/Lt8vToXA+3zng1Av/0yI8cRSTtmOqDiIfq
 ZkKAtVVuOOtoIh7UJRg3oiPf2A59Ak3lfmAbU+Bz3WFN8gETnZTLu4aos/Qeg3HytvRy
 zpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738593941; x=1739198741;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jzjKmaSZD003iLOX56rBf+sGbNpeHMrLBL8YkdsE+qE=;
 b=W+yELyKG1UbkCb5+M24MbaCgBY/lbIrFjrX5h4uVDjpmu1heADwA15VLWyNxHP/YAj
 hB3/cxBoGPmMNdp75GMATlNfpIjbzHgRXVUd9XcDWId9mMVbV3WuC47J7s5S3sk/cUS8
 OpFH4CLcWkuE/Ky3dbuK9JGNoF/RUEHWL/DBcuML/bpJ3lheO9W/4sWnFaXN9zWHn5TU
 LESDdaV2+TYkHRDU8QytQ3R3g1PT1CiEvkXb6GjSDWkkzyv6E8z3amY7Xeb//fKFB85A
 GoXmamzHpsVqWUlWTi4UvUWp6RYc5YfwCKlUuWRXjHDfiAWQokvR5jK0VQj3UppIln2X
 0lbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWceDE2wzcv2SiGoolMtw+U1Bxqef7jXdzeWOIYURhL2JzGbBePLJZmb0bE6P5ERJRKEmTWYQw=@lists.denx.de
X-Gm-Message-State: AOJu0YzrPofc2rzjX0vWAVjkX+rcJw5QhLbP5gEKLKgEau2HA/A+lF5L
 7dmig+w/RkjzOdiJGY7Grn6y2iIZyZVxm8IC8dYBFP9/R3vzw4HZF2qAgZ3Yug==
X-Gm-Gg: ASbGncuIYumjT+IeFpanbXtUPD2AigFhO5cxVGtkzH0NOh1gpHsROzkYhlhzfDYIsWu
 Xz96VC0esrLZoZKMbRDQ0XQgdlXWZ/Y8pgCAFPgxwEg+/Z+fGTENLokU2zMlhVwr5uiXPcKeAsa
 pb4gjqjhtl7HugvOrhUiPgyMItrRT2BE6P9hFM2vUS8lJC9EM4QQvhdUJhYR9rweLYNBufDpB2P
 fl77NNLBO7qMTaavsjMxe0++V2JONgUuTPMxnC3jn+bSX60Wi3nKQ53nMu0V0S082GGL4BTwG5l
 S9qt42kOLmsJpUeQTU5S6lAITs7MF4g=
X-Google-Smtp-Source: AGHT+IFMV2kgwZxwPRyJqTXXi+BxQ7P+97OQ4lJGsXWvEh0hihbdRnDM5OItdaFVGsSFZ82IKfa88A==
X-Received: by 2002:a17:907:6ea1:b0:aac:29a:2817 with SMTP id
 a640c23a62f3a-ab6cfcea4a4mr2067052466b.26.1738593941125; 
 Mon, 03 Feb 2025 06:45:41 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47a8268sm766623866b.28.2025.02.03.06.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 06:45:40 -0800 (PST)
Message-ID: <3455d7f9-0bdb-4f85-a0d6-7cbe236bf3cb@monstr.eu>
Date: Mon, 3 Feb 2025 15:45:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] zynqmp: Dynamic setting mmcdev and mmcroot
To: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: love.kumar@amd.com
References: <20250201140611.1798-1-egyszeregy@freemail.hu>
 <118d7b2a-2550-4795-8b93-50c92f5fb8cc@amd.com>
 <b553b19e-4fd7-4a8d-8b81-ccc241a56d04@freemail.hu>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <b553b19e-4fd7-4a8d-8b81-ccc241a56d04@freemail.hu>
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



On 2/3/25 13:19, Szőke Benjamin wrote:
> 2025. 02. 03. 9:01 keltezéssel, Michal Simek írta:
>> Hi,
>>
>> On 2/1/25 15:06, egyszeregy@freemail.hu wrote:
>>> From: Benjamin Szőke <egyszeregy@freemail.hu>
>>>
>>> Dynamic setting mmcdev and mmcroot.
>>> Then when boot linux, we can have correct "root=/dev/mmcblk[x]p2"
>>
>> This is source of the problem. That root partition is second is only your 
>> choice and doesn't need to be choice for others.
>>
>> There is no reason to write this logic to C code.
>>
>> We are exporting variable bootseq which you can use to determine which 
>> controller was used by boot device and can be used for rootfs.
>>
>> Here is how you can compose your bootargs.
>>
>> ZynqMP> setenv bootseq 50
>> ZynqMP> setenv bootargs root=/dev/mmcblk${bootseq}p2
>> ZynqMP> pri bootargs
>> bootargs=root=/dev/mmcblk50p2
>>
>> Or you should look at devnum which is setup when mmc boot is called.
>>
>> bootcmd_mmc0=devnum=0; run mmc_boot
>> bootcmd_mmc1=devnum=1; run mmc_boot
>>
>> Thanks,
>> Michal
> 
> Thanks the details. Usually i use extlinux.conf to provide kernel arguments for 
> root mounting.
> 
> Does it mean "bootseq" contains the real mmc blk index number what is really 
> need in this situation when we like to get it work dynamically?

I do normally using aliases for sdhci that's why number is read from aliases 
node and it's position. U-Boot is also using this number and bootseq is aligned 
with it.
You can test it.
Setup
aliases {
	mmc9 = &sdhci1;
};

And if this is your boot device you should get bootseq as 9.



> 
> As i understand, in extlinux.conf, there are two possbile easy solution which 
> will provide the same what i thought.
> 
>      "APPEND root=/dev/mmcblk${bootseq}p2 rw rootwait"
> 
> or
> 
>      "APPEND root=/dev/mmcblk${devnum}p2 rw rootwait"
> 

yes. It depends what you want to do. In our systems we have only 2 sdhci 
controllers that's why only boot from mmc0 or mmc1 is created. And that's likely 
distro boot limitation. With stdboot I think it shouldn't really matter.

And this code is prioritizing boot device by changing boot_targets variable.
It means bootseq/bootnum should be the same but doesn't need to be based on 
above test.

> 
> But i have a little confusion about "bootseq" env variable. Why is it good to 
> save it as a hex env variable?
> https://elixir.bootlin.com/u-boot/v2025.01/source/board/xilinx/zynqmp/zynqmp.c#L491
> 
> To use it as a varibale for mmc blk it would be more safe/fit to save it in a 
> normal decimal number.
> 
> Wont be it better to save it also as a more verbosable name ("mmcblk") in a 
> ulong decimal format? It would be more clear for all people that it is usable to 
> use for mmc blk number also.
> 
>      env_set_ulong("mmcblk", (unsigned long)bootseq);

As above these values are pretty much 0 or 1 all the time. And value above 9 was 
never tested. I think there is a small mess in U-Boot in general if value should 
be dec or hex and it is command dependent.
In this particular case likely switching it from hex to dec make sense because 
mmc dev command also treat that value as dec.
And dt specification is not talking if it is hex or dec but likely it is dec.

Thanks,
Michal




-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

