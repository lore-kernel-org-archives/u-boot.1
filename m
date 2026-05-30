Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A81CD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 13:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 174FF847C6;
	Sat, 30 May 2026 15:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fPNpyOy7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WMz37J3c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 874FC846FA; Sat, 30 May 2026 15:28:04 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3713847C6;
 Sat, 30 May 2026 15:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gSLdF2J1Dz9t4k;
 Sat, 30 May 2026 15:28:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780147681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvMCM9PklRE8ViY+/UkOJY/0PiHG6algNdfnIl7hJ88=;
 b=fPNpyOy7swCoK8EWJO/M+w5bTo89OVR5GBAjn2QU5S8fwv6wE8u2lO0Kba2AyGnnbr9XGP
 3Ag0c6LZHuR2f6PCOCX9PC+8QW4CtZJs7nCoHWQpuvSTFXnTZe71B0ksJHwRCjWi80fQ+u
 2pGtDBfiTqH/94yoXoJOeOLKsQ9SUw3t53cbAVPZr3JrY66KqcX5f7fR0b5Frjsgth7+lH
 FqdmQRk0vVUvJIlJzndHT3TWr60Cq2TfkScX+crlgyVzwyr4QhnKlL7Fx8/O7c9WX56TKM
 5J5B0xlniRNlytI3ZOP6+jPaYy+Zrz5mr7PrOMn2OJCF8t88bGd/PBuPH8DhzQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=WMz37J3c;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <c9e810ac-6c0e-4a66-bbae-d6557a26197b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780147679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvMCM9PklRE8ViY+/UkOJY/0PiHG6algNdfnIl7hJ88=;
 b=WMz37J3cNLSTeSwpOR3mGyGqNdl3J28BxeeJkZAHZ26GNuhYakAr2Vog+LpJPts4KdMrkX
 iATM930CUM9kcgubI7LA8us2lvkry5i7aFkRocXEgCmBIRo/tmeZvR1/6zN66aPXZefSyP
 DByrXwP4b/NBM/dtRSI58Z9zeBNWRm5qgSIf8bXDww/bcwcLS86MCb/XNABIsEV+Z5kqNU
 l0l8SLRg2DKAF9ZLkH6FqIgah+KtdxrXnTH7bF8STLHH5YHlxxvPhA4Ieqv6UYsecQ0cNv
 tcd6Zzl03ADS/6jHBJcEnaARxwvpnDprJs2DiFQLsUHGPIJcvwGeiOTwjnmEwQ==
Date: Sat, 30 May 2026 15:24:43 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Gary Guo <gary@garyguo.net>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, U-Boot <u-boot-bounces@lists.denx.de>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <CALeDE9PARyt0iUvnfbSfz=rSA2RkQ1AcoaJpU=8RgnYivaPNEA@mail.gmail.com>
 <20260529154446.GC627328@bill-the-cat>
 <CALeDE9MAE6r3pFzNRDbwAXkkkWrZo_0gXEMTavmpnGjQBoxrVQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CALeDE9MAE6r3pFzNRDbwAXkkkWrZo_0gXEMTavmpnGjQBoxrVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5409f3f19624e48f81a
X-MBO-RS-META: hr8rsnrgk9j78usi7bp5t7keqos1csn3
X-Rspamd-Queue-Id: 4gSLdF2J1Dz9t4k
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

On 5/29/26 6:30 PM, Peter Robinson wrote:
> On Fri, 29 May 2026 at 16:44, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Fri, May 29, 2026 at 01:10:14PM +0100, Peter Robinson wrote:
>>> Hi Tom, Marek et el,
>>>
>>> This is still broken on Raspberry Pis, at least RPi4/RPi5 against RC3.
>>>
>>>> On Fri Mar 13, 2026 at 8:54 PM GMT, Tom Rini wrote:
>>>>> On Wed, 28 Jan 2026 00:48:40 +0100, Marek Vasut wrote:
>>>>>
>>>>>> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
>>>>>> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from
>>>>>> same bank"). These are based on incorrect premise of the first commit, that
>>>>>> "U-Boot does not use memory above ram_top". While U-Boot itself indeed does
>>>>>> not and should not use memory above ram_top, user can perfectly well use
>>>>>> that memory from the U-Boot shell, for example to load content in there.
>>>>>>
>>>>>> [...]
>>>>>
>>>>> Applied to u-boot/next, thanks!
>>>>>
>>>>> [1/1] lmb: Reinstate access to memory above ram_top
>>>>>        commit: a3075db94d49f415658bf7e961e1eae90d9abc33
>>>>
>>>> (Cc RPI maintainers)
>>>>
>>>> Hi Tom,
>>>>
>>>> I'm testing out latest u-boot/next on my Raspberry Pi 5 8GB, and I am running
>>>> into issues caused by this patch.
>>>>
>>>> I have EFI enabled, and efi_allocate_pages will call into lmb to allocate pages
>>>> and start accessing them. However on RPI5, only 1G is mapped, so I got hit with
>>>> an "Synchronous Abort" triggered at address 0x1_ffff_f000.
>>>
>>> I was seeing a "Synchronous Abort" triggered, but now now I am seeing:
>>>
>>> Hit any key to stop autoboot: 0
>>> Cannot persist EFI variables without system partition
>>> ** Booting bootflow '<NULL>' with efi_mgr
>>> Not a PE-COFF file
>>> Loading Boot0000 'mmc 0' failed
>>> EFI boot manager: Cannot load any image
>>> Boot failed (err=-14)
>>> ** Booting bootflow 'mmc@7e340000.bootdev.part_1' with efi
>>> Booting /\EFI\BOOT\BOOTAA64.EFI
>>> Platform does not support this image
>>> Failed to read header: Unsupported
>>> Failed to load image: Unsupported
>>> start_image() returned Unsupported
>>> ## Application failed, r = 3
>>> Boot failed (err=-22)
>>>
>>>> Now, that is easy to fix with the following diff:
>>>
>>> Simon sent something similar [1] but it didn't fix the problem, nor
>>> address the RPi4.
>>>
>>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20260508233254.2022495-1-sjg@chromium.org/
>>>
>>>> diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
>>>> index 7a1de22e0aef..1db2e37c44f4 100644
>>>> --- a/arch/arm/mach-bcm283x/init.c
>>>> +++ b/arch/arm/mach-bcm283x/init.c
>>>> @@ -69,10 +69,10 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] = {
>>>>
>>>>   static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] = {
>>>>          {
>>>> -               /* First 1GB of DRAM */
>>>> -               .virt = 0x00000000UL,
>>>> -               .phys = 0x00000000UL,
>>>> -               .size = 0x40000000UL,
>>>> +               /* 16GB of DRAM max */
>>>> +               .virt = 0x000000000UL,
>>>> +               .phys = 0x000000000UL,
>>>> +               .size = 0x400000000UL,
>>>>                  .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>>>                           PTE_BLOCK_INNER_SHARE
>>>>          }, {
>>>>
>>>> and that indeed makes my system go past the init. However, I found that while it
>>>> is fine to boot into systemd-boot, systemd-boot cannot boot into kernel. After
>>>> some investigation, it turns out that efi_load_image_from_file uses
>>>> efi_allocate_pages to allocate pages, and then feed this to f->read. This all
>>>> eventually trickles down to the MMC driver, and MMC is doing a 32-bit DMA and it
>>>> fails to write to the buffer allocated (which is above 4G).
>>>
>>> The Raspberry Pi has a number of devices which are only accessible at
>>> lower memory access, the mailbox is only accessible < 1Gb too.
>>>
>>>> This could be all fixed by having dma_map_single use a bounce buffer and copy
>>>> back the contents on unmap similar to kernel's swiotlb, but that's going to be
>>>> some major work.
>>>>
>>>> In the mean time, I think this patch should be reverted. I can confirm that my
>>>> system boots fine with this reverted.
>>>
>>> Yes, I agree here.
>>
>> Can you please post the revert Peter? Thanks.
> 
> Sent.

The revert is wrong as that breaks other things , like use of DRAM above 
4 GiB boundary, which is exactly why this change was implemented. If RPi 
has limitations, then those limitations should be imposed on RPi, not 
globally, so add the LMB reservations on RPi.
