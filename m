Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43916D6D231
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 19:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A71E1897EC;
	Wed, 27 Nov 2024 20:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="e4GRaBam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9941D89802; Wed, 27 Nov 2024 20:38:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89D6E897DD
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 20:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732736296; x=1733341096; i=xypron.glpk@gmx.de;
 bh=LOUK7Fer35PO6FiI6teS5oKo8lu/pP1+OCIVpPG/OyQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=e4GRaBamQzXpZdsbuSdLLO7+ODix9aSOo7ThI41+qfHRfVP2IrXwDjaC5qjNtFMt
 u06vmZ5sczAhygxtxrxge4o7MYzjywXx7bMsdLFIZCCVLagfMQbrBGVeW4A8ofCHb
 K/aoOFexXvRWE5byntfrEmeRa/KIKm1biU+Po1JaVR4g9NZYbvGPwe+PHOLRHtx/q
 mRMeRQlOIvg+14jZ+Adi3SULfK7fpFWjPW7I+7AE+s9DlRVQuerTHXX5oQEluHDO3
 LHV51uH+nchY+JTskaH58VwF3GsocXKlCU8fEK/+dgz7okeOub6eOy9u2zQLkltCg
 bSkwgNGvnNfNZDTSwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpOd-1tw2D30bSz-00l2hL; Wed, 27
 Nov 2024 20:38:16 +0100
Message-ID: <99be07a6-e4bf-4b3e-a44a-e714014fa029@gmx.de>
Date: Wed, 27 Nov 2024 20:38:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 01/12] sandbox: efi_loader: Correct use of addresses as
 pointers
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20241127172247.1488685-1-trini@konsulko.com>
 <20241127172247.1488685-2-trini@konsulko.com>
 <55538d09-dd9f-424e-9600-a7d94172e216@gmx.de>
Content-Language: en-US
In-Reply-To: <55538d09-dd9f-424e-9600-a7d94172e216@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7bIGdILZFHriQ8bR/1PeVtS3wY2cLS6un9kee47g9nyiLFPCiHw
 5UcF1/cDu0RkCi0lhw5XtOQibiIe43bZVTUdEelofhcgi92W4OQUrJAHktTwwwUVQTLxWXu
 d56XWILGZ4eODU5p4aIDHm+5Mvw9wiE37x9mBhuqxS7U4aLIuP2ZDkEmUzh4Bg8/pBijkNJ
 vJsB9zOYZ4G+qsvVJXFCQ==
UI-OutboundReport: notjunk:1;M01:P0:aaZsDV7qKGY=;j7Os6ajkCmA/5dD4pOTKmH3dt8y
 eIQxagwG3ylv5jkvkvcwZr6IA3sMb+noEw7Y+nIlCLkORa0GKCw25BcEpmAIU7PQ5h2R9sDMb
 HVhpyb0zV3NNkQyj9gEA2SqUPo8jh+BAqFkjx0CVXVN/VWgA9XUI+Tz9bClbjfe6yCR+LbGX4
 cEGZWqaNbBppkIV5PTXXJkBdpMGScYv30aEBm2J/9Uqdm2PKANwsfoWBdGHHyXEgY/z/b2Lx+
 NeSj57uC90o3HeZuuOgB/3UJPUorOtiWWrBG2SDELOql6Bc6PfBBTEokHhJbSE6lr7kCeTZo9
 HyPFs8l4s1wMEr+XkMTXvf51/BW3PSuRsQwF1kPSCrgXOUuyotFHS04h0NVs/QEt4kR8BnxpD
 tK/6G+Bc5sB9Ofn6Yr51h/hwNkirUaWO5aX2OW7MrwpjaRco2TumLObV59CfsmUMvHkFiCRmY
 K+vrn/o3csNUbxZxGQgL7kTGwQv6Gzf8b+HEdVq9BQcn5xkRLGqQWB7yYr+ZUttr40JD3mDPX
 JfGmoDcbu9gpQ2pFFeuWjM5NGTMMeIMVyuJd3H2WRplNR1VtIbn/8bj2FNQWUUKHQkGdxoM3S
 MSD6CMw9nW7kZJ903VjzBmyDr4zI7JIn3KTj5PcHjwupBUlYcAUv2ipM9923IwTEsogWoxU2k
 oLTz7NYqXDr4ou2evNv/ncxQuo9Pz+6bfMhAC0b3YweRDrTYpjfY6VvfA5m1HD0+FG8oXF3Xv
 rUdGkXSWdNPbuMPKzD1mcA6k9rHDuM5uFrc5yvTEOBmlGQzFTrKDrVG+HKL/+xKwbHV6P6vSI
 QLtM034vq1nMn5OI5PHgHd4nHKGYSZkYzoGmAdp0HHbjFYSGU3GH4+ZNVSdCaKxsohZjSjzk0
 fZXCF+lpkoJ6bwt5TPARnt2iaDB9qEDwxhef4XxTms90Vktc/OuOqf6LJpUgm/0Z/zZ1MjnVD
 ak3ptxp7ZZ9rygTXSrCCpkYhGS9m5YIxE9cQrm1lUa5fOvbtqlhqyFHwr+D1j98As4Fy6FNmL
 mF4yO+dVeRdjruc9ieIs7hijljk5/Cjk0WEK0AtEe/eBQFxFT7+WYOHIERgcEE6bnfTteL6es
 AT27MiCcttTsoE9tTSYKABGWMc9DQE
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

On 27.11.24 19:40, Heinrich Schuchardt wrote:
> On 27.11.24 18:17, Tom Rini wrote:
>> From: Simon Glass <sjg@chromium.org>
>>
>> The cache-flush function is incorrect which causes a crash in the
>> remoteproc tests with arm64.
>>
>> Fix both problems by using map_sysmem() to convert an address to a
>> pointer and map_to_sysmem() to convert a pointer to an address.
>>
>> Also update the image-loader's cache-flushing logic.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> Fixes: 3286d223fd7 ("sandbox: implement invalidate_icache_all()")
>> Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>
>> Changes in v6:
>> - Re-introduce
>>
>> Changes in v2:
>> - Drop message about EFI_LOADER
>>
>> =C2=A0 arch/sandbox/cpu/cache.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++++++-
>> =C2=A0 drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
>> =C2=A0 lib/efi_loader/efi_image_loader.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 ++-
>> =C2=A0 3 files changed, 20 insertions(+), 9 deletions(-)
>> ---
>> =C2=A0 arch/sandbox/cpu/cache.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++++++-
>> =C2=A0 drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
>> =C2=A0 lib/efi_loader/efi_image_loader.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 ++-
>> =C2=A0 3 files changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/sandbox/cpu/cache.c b/arch/sandbox/cpu/cache.c
>> index c8a5e64214b6..96b3da47e8ed 100644
>> --- a/arch/sandbox/cpu/cache.c
>> +++ b/arch/sandbox/cpu/cache.c
>> @@ -4,12 +4,18 @@
>> =C2=A0=C2=A0 */
>>
>> =C2=A0 #include <cpu_func.h>
>> +#include <mapmem.h>
>> =C2=A0 #include <asm/state.h>
>>
>> =C2=A0 void flush_cache(unsigned long addr, unsigned long size)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 void *ptr;
>> +
>> +=C2=A0=C2=A0=C2=A0 ptr =3D map_sysmem(addr, size);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Clang uses (char *) parameters, GCC (=
void *) */
>> -=C2=A0=C2=A0=C2=A0 __builtin___clear_cache((void *)addr, (void *)(addr=
 + size));
>> +=C2=A0=C2=A0=C2=A0 __builtin___clear_cache(map_sysmem(addr, size), ptr=
 + size);
>> +=C2=A0=C2=A0=C2=A0 unmap_sysmem(ptr);
>> =C2=A0 }

I missed this part when looking at the EFI change.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

