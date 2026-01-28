Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467B2D3F083
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 15:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F07383FFF;
	Wed, 28 Jan 2026 16:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TEwQ2Dh4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F244684013; Wed, 28 Jan 2026 16:58:21 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AAA483FFE
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 16:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f1Rkw0Rgqz9tj3;
 Wed, 28 Jan 2026 16:58:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769615896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=poqjfirjQiUIwbCVfSZT5Fl9bFEov1PfH2+6PaHrSyQ=;
 b=TEwQ2Dh4JURVCW+k5A9YHEwV2ukmHKTKXF48plH0SIZElz0mxK/H/0JsZPK6QjyLb5nBS5
 WkHCKbWb/f9JFAb/CCGjGEX0X1v7h37lfIv3TJS3vTUwGt9gWijzVItM+F+bjmOM021orP
 NbM6JoOF+2HRWN1cNWi6mtZ1jzS6cHzo0V0RD5Ldu9NE0lO6A9v0Z2qfjv958FevtX6XP+
 fO9W0OJGf/4oaxODoPDx8TDutk8h+vmpZK9S3tjW87s4y1nGVDD+jviQQkeEkFF4uZZtjP
 m7goaqh3lLyYMOvTxPAgWfYqBZXQeYN7jf1rnrcHzBLOnhfv9xSIc8M8n0dZUA==
Message-ID: <3dae966e-d866-4cd9-b136-c62794dfe137@mailbox.org>
Date: Wed, 28 Jan 2026 16:58:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: xypron.glpk@gmx.de, u-boot@lists.denx.de, yuya.hamamachi.sx@renesas.com,
 andrew.goodbody@linaro.org, casey.connolly@linaro.org,
 holger.brunck@hitachienergy.com, ilias.apalodimas@linaro.org,
 jonas@kwiboo.se, kettenis@openbsd.org, semen.protsenko@linaro.org,
 sughosh.ganu@linaro.org, trini@konsulko.com
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <A2BF7446-8270-486A-9239-8CBB2C52AC17@gmx.de>
 <462cf22d-10d4-4c59-9690-29d9584e7efb@mailbox.org>
 <875x8l69l3.fsf@bloch.sibelius.xs4all.nl>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <875x8l69l3.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: fdf2f4aef0549c90917
X-MBO-RS-META: kubotkgn3ybroksdshmh3x8844w5ay7k
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

On 1/28/26 4:27 PM, Mark Kettenis wrote:

Hello Mark,

>> On 1/28/26 5:41 AM, Heinrich Schuchardt wrote:
>>> Am 28. Januar 2026 00:48:40 MEZ schrieb Marek Vasut <marek.vasut+renesas@mailbox.org>:
>>>> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
>>>> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from
>>>> same bank"). These are based on incorrect premise of the first commit, that
>>>> "U-Boot does not use memory above ram_top". While U-Boot itself indeed does
>>>> not and should not use memory above ram_top, user can perfectly well use
>>>> that memory from the U-Boot shell, for example to load content in there.
>>>>
>>>> Currently, attempt to use that memory to load large image using TFTP ends
>>>> with "TFTP error: trying to overwrite reserved memory...". With this change
>>>> in place, the memory can be used again.
>>>
>>> IIRC there are drivers that have issues with memory above 4 GiB and boards that artificially set ram_top to 4 GiB to work around these issues.
>>
>> I thought I had all of those solved, but apparently not, please read on.
>>
>>> We need to carefully consider why the reverted patch was introduced.
>>
>> I didn't find much on either commit. I believe the premise on which the
>> original patch was introduced is wrong, cf this commit message. We
>> should allow U-Boot to access the memory above ram_top, we should not
>> allow U-Boot to use it for its data structures because of the possible
>> 32bit DMA limitations.
> 
> What do you want to do with that memory in U-Boot?  You can't really
> use it to load a kernel into if there is a 32-bit DMA limitations in,
> for example, your MMC controller...

I want to load system image into it, via ethernet. The network stack 
does have built-in packet buffer which is part of the U-Boot binary in 
.data section, which is below ram_top . The malloc area is also below 
ram_top, so any private data which hold DMA descriptors are also below 
ram_top . When a TFTP transfer runs, the data are all exchanged within 
the 32bit memory range and reachable by the network hardware, the packet 
data are copied between the packet buffer in U-Boot .data section and 
the real source/destination address which may be above the 32bit boundary.

This copying is what the network stack does today, so optimizing that is 
out of scope of this discussion (although it is on my radar).

As for the SD card controllers with 32bit limitations, I think we need 
bounce buffer with the ability to bounce into area that is forced below 
32bit boundary. I think we are missing that.

> Are there boards that don't have enough memory below the 4GB address
> boundary?

Yes, there are system images which are larger than 2 GiB when gzip 
compressed. They are being written into NVMe storage during board 
installation, without booting the OS.

>>> Why does your board use a 4GiB ram_top and not place ram_top at the physical top?
>> Originally, I thought it was only a remnant from the past which kept
>> U-Boot and all its data structures, stack, heap in the first DRAM bank
>> in 32bit space, so I tried to remove that. It turns out there are still
>> a couple of problems that have to be solved to make it possible to
>> relocate U-Boot fully into the 64bit space.
>>
>> The first one is the standard parsing of DRAM size / ram_top / DRAM
>> banks order in common/board_f.c , which probably hides a lot of issues
>> on various boards, pretty much what you wrote above. In short,
>> dram_init() only sets up gd->ram_base and gd->ram_size , which is often
>> the first continuous DRAM bank which is in 32bit space. The follow up
>> setup_dest_addr() uses that information to set up U-Boot relocation
>> address at the end of that first continuous bank. And then
>> dram_init_banksize() parses the rest of the DRAM banks into gd->bd
>> (gd->bd is set up after setup_dest_addr() is called, in reserve_board()).
>>
>> This above is fixable and I already have some clean up patches for that,
>> which I implemented while writing this email.
>>
>> But then I found out, that the ravb ethernet driver also has 32bit
>> limited DMA, which breaks if I relocate U-Boot to the 64bit range. It
>> worked thus far, because U-Boot was in 32bit space, so were mallocated
>> DMA descriptors, so was the net_pkt_buf[] array (which is in .data
>> section). I didn't find any other breakage thus far.
> 
> Unfortunately hardware with 32-bit DMA constraints is very common.
> There are device trees with dma-ranges properties that imply DMA
> constraints.  That is mostly about restrictions of busses that have a
> limited number of address lines so it certainly doesn't cover
> everything.  My list of additonal SoCs with restrictions in OpenBSD has
> the Raspberry Pi 4 and Rockchip RK356x and RK3588 on it.

I know. The ram_top is used to keep U-Boot below the 4 GiB boundary, 
including its structures, so this limited hardware can surely work, 
until there is a better fix.

>> Which means, before we can really start switching boards to relocate to
>> 64bit space, we need to find all these remaining 32bit limitation sites
>> and fix them first. And to do that, we would need some way to force
>> allocation from 32bit space for drivers which need that ... do we
>> already have such a thing ? I couldn't find anything.
> 
> We have bounce buffers in the EFI loader.  There is a more genric
> bounce buffer implementation in U-Boot as well, but that is only used
> to solve DMA cache coherency issues.

That is my doing, but indeed, it does solve coherency problems, not 
placement problems.

> But this suggests that solving
> things in generic code instead of drivers might be feasable (at the
> price of extra memery copying).

Yes, correct. I am thinking of some DMA32 DM flag, which would indicate 
the hardware has such limitation and its data buffers should be bounced 
in common code.

> That said, is there really a benefit in giving U-Boot more memory on
> systems that typically have 2GB or more below the 4GB address
> boundary?

Yes there is, there are systems with a lot of DRAM, 8 GiB, 16 GiB, or 
even more. And yes, there is a use case for loading very large data into 
that DRAM. That is what spawned this change.

Do you think this change is acceptable until we have some 32bit DMA 
allocator ? Can you please test it on RK3588 and see if it causes any 
breakage for you ?

Thank you for your help !
