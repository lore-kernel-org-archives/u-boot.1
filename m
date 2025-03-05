Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACC8C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 08:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD307807B1;
	Wed,  5 Mar 2025 09:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XrOHVSO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BEB48083E; Wed,  5 Mar 2025 09:20:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DE64800C1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 09:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741162849; x=1741767649; i=xypron.glpk@gmx.de;
 bh=NoofrI2zE/yPo5zYZsQudSRo0ydvXJjKVVAxNy14a7U=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XrOHVSO5VHxtOe/dnLdrAyYMm1CzJCYV2FFj7ZtJTf/088eV2dkThOUhE/zBiiud
 v6ktG9k7Gqwmgr/HgdtQrkb67Ui1L2BcxW4g6+9v7S4IKqQOMzcH6NTQzOUNL8ofy
 dy0lDBP87kmK8YKx9CLysK5XmAcfXTbZF2Znk0DOq33rotVGywvbytoynxDeCFYji
 /QpjmPWzn7E7CM5mjE7WMQMkwpkkI6lay9u2fq1qu95SstsiIcJINvpu+jJ9Ci63n
 PPN5psbHXxg+K5coKRBt0G0KjVZlu9ixmQy6HQ27TWqkC9nDrN5CaHJtOLKN6itTu
 E9dKSnf5HeKRM5l7og==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3mz-1tff5e1h3D-00N0Tk; Wed, 05
 Mar 2025 09:20:49 +0100
Message-ID: <09712f67-51aa-4db5-bb7b-e1305c08d5f1@gmx.de>
Date: Wed, 5 Mar 2025 09:20:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: boottime->efi_allocate_pages() returning EFI_NOT_FOUND
To: Ben Schneider <ben@bens.haus>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <CdUirikQxEto6yzkO-G-y6mmWa-ek5NZPN9K7EYvyeUAmnxuge6UmHxfp0tb580qFmfHacX5aWFLqrXjXAFs87nP14AZ72vkClzp3U3WBw4=@bens.haus>
 <CADg8p971xqUzCHhV_yZDXbn8OMn_V2DfHoVschZOTfx1dFvV1A@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CADg8p971xqUzCHhV_yZDXbn8OMn_V2DfHoVschZOTfx1dFvV1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nv9RiVicBv1Selc/rFapGTz57JGQLj04UsAYSCXn2pkU5E1oiVX
 +X6kcLgfVj0eQ6AwuDrLQLc6Iv9IvUQsQzobIqhwpjKTvPOUyPt/krHJ8InFKjE4G/KVZrY
 l7yv6OfGAkUrMD/ji5ox6xtITjW0EpKD7iUho10kDVQVvhlh1kczLEdSj3ougi1upriOXwl
 7HqRkKyGjvcs2ftq3zWrg==
UI-OutboundReport: notjunk:1;M01:P0:0Sigv/iD2O8=;8IuBRX1WL8mT33snWjkQiqT5szz
 Nx+RtpiddlHwJKdNDsmyiV4j95zKLEqOKcPtAW1W5CQkaY760/hD8aB8SQCyBHfL/tYSa5Yxg
 ccJL6aL0hAOd9SBQhklKPPPg5WcP5GEufIvl4zcRCIYCTrAVGwf1jH4TKJ0rjwn24Hof4OXU3
 qofhwMIhzgf5rFlCksHjRxPDZCY2Q3YTlSokQhiJxo8AvmSRwV2mBiGD3fiEI8rr+91cpa1Kr
 psUXqDhz+Q3YRkFEaV+9KglGgXJH23b09Ft/TfldjjLkv/HFV0IHk8Bc0SmY6OOb6ysuQrBzp
 ugrIwNecLZLScJzKO2jGE14sCcIVngD1EIqEHlwetCmUQ3oeXLggvAiTZU8PiYU6cwBWuDNd2
 HbfaqANcoM6ot47sbIfBGkhEBOciH42/qDHBQwf/s2P58eOAhXL66DAw2U7APMylzq8o8JmSt
 myRMcBiRQM5ePRFLwjR7cNwVFy1iVt2ixKoK5g+2B6xW+PhjqMJymcSeIAMxocoJJ1Ag/UuNH
 OCcYgpi+7DSTK9usMoxusW7ncr3a9YFyh6CW9ifamKWhmLDQr2JJ6yzkTX4bLHnRStFEv2+6z
 5c4lDrczlChTJnHqChm7yr53sdF0nDT7S38mcy0pj4gliYwgcbtbSdk0MpXdNwLp5V80FaI5I
 oKm5SAzykibgnPq6dvbV+cZ4DFfweDl4iLWlbMdONLSdPNR1q0woJ2spBHHY7W4YIvismIKfp
 quNr/joP63a9JGODhlJZWwBCDS/Ne5U8Lc2dqM/Jw1i6gwOpLY90Tejex+Lt7NuM7E16qYdVQ
 ZqGV0wUOvz7EPyKPD/38+IFMQ6TxPNC1L0v9WE61ZmYHb31KifgEBqTVMiyWwds+UhjwSc4WE
 +87Xz4Sok3E8/cwArayyHm/MVuUyCmDYhC1gbGBI0SQ7xeY8ABSu2QZgrVljro0iXObfPkQmj
 Ig++MMxlBfyLPRTTvaZZgQQ3nhBoLsdpF5QOt+pm1+TYivU29bEUSqvfX+I8O0ZgSJhT9wWKe
 RpZzgpbNdiY5op8Cfsv7It1pz5YBLeS2OYCFyEaFnq0QUjUoBxChNAoC4BKM2HztW7MMppHjW
 ZXiB5gDEv4ZTpOAf6pTld8sp8va4/3ZKKTNknFCp0CCLaFxnFimNwnITgDGTFf/FHkvc4v1yF
 iYFxphL0Znd8YMv3hKMZY6hJA2UM1OlncUxA/vrI4HkKfcRnAFvlfgFZ/R4CmMp5/HR4Hytqa
 upYvQj51xHVmoj41hx6MqOp5kUXjH3nRSRovOCO4brpG5uXFtKnn2HPpvzVfpCP1xxPTXFcAl
 ZMmIcnDPnzZdJm8ZlfVbhdpisViZi4znIGfnnP1uoZbShHd07gUVpjzkEJak+Sdh0LGLyOt6u
 2J1olQqxnsly0Pbza7O1770+RxQr/wkF2AxlKFxjpe5B4G2+NgK1XWwWKS
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

On 3/5/25 09:13, Sughosh Ganu wrote:
> On Tue, 4 Mar 2025 at 23:34, Ben Schneider <ben@bens.haus> wrote:
>>
>> Hi, I'm trying to boot a compressed (via zboot) Linux kernel image
>> for aarch64 and running into an error I didn't expect.
>>
>> To decompress itself, the kernel will run efi_zboot_entry() (found
>> in drivers/firmware/efi/libstub/zboot.c) which wants additional
>> memory so it asks for it via a call to the UEFI AllocatePages()
>> service.
>>
>> U-Boot receives that request and runs efi_allocate_pages() (found
>> in lib/efi_loader/efi_memory.c). In its call, Linux is setting
>> type =3D EFI_ALLOCATE_ADDRESS, and memory_type =3D EFI_LOADER_CODE.
>>
>> Based on some testing, it seems that the call to lmb_alloc_addr()
>> is not returning an address so efi_allocate_pages() returns
>> along this path:
>>
>> addr =3D map_to_sysmem((void *)(uintptr_t)*memory);
>> addr =3D (u64)lmb_alloc_addr(addr, len, flags);
>> if (!addr)
>>          return EFI_NOT_FOUND;
>>
>
> Can you check what is the address being asked for in the
> lmb_alloc_addr() function. Then you can check through the bdinfo
> command if that address is already reserved, or not added to the
> memory map.

If you add printf() statements here, maybe also add a call to
lmb_dump_all_force() which will dump the LMB memory regions (like the
bdinfo command would).

Best regards

Heinrich

>
> -sughosh
>
>> It's not clear to me why I'm getting this error. I am using U-Boot
>> 2025.04-rc3 configured with mvebu_espressobin_ultra-
>> 8f3720_defconfig. I use Standard Boot (bootflow scan -b) to find
>> and load a systemd-boot EFI application which then tries to boot
>> the compressed Linux kernel. I am encountering this issue on a
>> real device with 1GB of memory. I would appreciate any guidance.
>>
>> Thank you!
>>
>> Ben

