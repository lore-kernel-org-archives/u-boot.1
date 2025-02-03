Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317F9C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 12:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41E8C80079;
	Mon,  3 Feb 2025 13:20:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="gV/Z3tSS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91BDA80087; Mon,  3 Feb 2025 13:20:33 +0100 (CET)
Received: from smtp-out.freemail.hu (fmfe19.freemail.hu [46.107.16.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A1608004F
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 13:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from [192.168.0.16] (catv-178-48-208-49.catv.fixed.one.hu
 [178.48.208.49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4YmlvG18TYz1fP;
 Mon, 03 Feb 2025 13:20:26 +0100 (CET)
Message-ID: <b553b19e-4fd7-4a8d-8b81-ccc241a56d04@freemail.hu>
Date: Mon, 3 Feb 2025 13:19:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] zynqmp: Dynamic setting mmcdev and mmcroot
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: love.kumar@amd.com
References: <20250201140611.1798-1-egyszeregy@freemail.hu>
 <118d7b2a-2550-4795-8b93-50c92f5fb8cc@amd.com>
Content-Language: hu
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <118d7b2a-2550-4795-8b93-50c92f5fb8cc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1738585230; 
 s=20181004; d=freemail.hu;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 l=2007; bh=bI5Uuohx2nvddwrrcTIgHsUFv12Yfr3oRWPzxxs3q+0=;
 b=gV/Z3tSSW32ukBWweicdggo9Fdw2KaQJTcBeDJwyUpRAVR9Ie+7f3qu2XiKo+IE6
 8ayoOW33i3wybCzomYcTFo9fY5AHG1ZOjqYDEedpwj/NDVX/yMbFYG22GvzTF4KjnF2
 pFvR/+6DoSERe6lPgIk9PfWMb/d/F4qi+S6nluO3d0H2UYVbAoVirTOf/F5MchLQ/ye
 r20rDcZPQryLLuAbT4hqTc/UB7ejMRJm3+XCsxrjRM77YAUFnnuYCtL+mduLryBDgWu
 uNszU7IW1Yt3vPf0IYDclhWpDOCMwXR3au/gr99LeFQrW4+3gS766AvX4if6axX12mS
 ckEhkHIMVQ==
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

2025. 02. 03. 9:01 keltezéssel, Michal Simek írta:
> Hi,
> 
> On 2/1/25 15:06, egyszeregy@freemail.hu wrote:
>> From: Benjamin Szőke <egyszeregy@freemail.hu>
>>
>> Dynamic setting mmcdev and mmcroot.
>> Then when boot linux, we can have correct "root=/dev/mmcblk[x]p2"
> 
> This is source of the problem. That root partition is second is only your choice 
> and doesn't need to be choice for others.
> 
> There is no reason to write this logic to C code.
> 
> We are exporting variable bootseq which you can use to determine which 
> controller was used by boot device and can be used for rootfs.
> 
> Here is how you can compose your bootargs.
> 
> ZynqMP> setenv bootseq 50
> ZynqMP> setenv bootargs root=/dev/mmcblk${bootseq}p2
> ZynqMP> pri bootargs
> bootargs=root=/dev/mmcblk50p2
> 
> Or you should look at devnum which is setup when mmc boot is called.
> 
> bootcmd_mmc0=devnum=0; run mmc_boot
> bootcmd_mmc1=devnum=1; run mmc_boot
> 
> Thanks,
> Michal

Thanks the details. Usually i use extlinux.conf to provide kernel arguments for 
root mounting.

Does it mean "bootseq" contains the real mmc blk index number what is really 
need in this situation when we like to get it work dynamically?

As i understand, in extlinux.conf, there are two possbile easy solution which 
will provide the same what i thought.

     "APPEND root=/dev/mmcblk${bootseq}p2 rw rootwait"

or

     "APPEND root=/dev/mmcblk${devnum}p2 rw rootwait"


But i have a little confusion about "bootseq" env variable. Why is it good to 
save it as a hex env variable?
https://elixir.bootlin.com/u-boot/v2025.01/source/board/xilinx/zynqmp/zynqmp.c#L491

To use it as a varibale for mmc blk it would be more safe/fit to save it in a 
normal decimal number.

Wont be it better to save it also as a more verbosable name ("mmcblk") in a 
ulong decimal format? It would be more clear for all people that it is usable to 
use for mmc blk number also.

     env_set_ulong("mmcblk", (unsigned long)bootseq);
