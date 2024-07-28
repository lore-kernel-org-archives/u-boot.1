Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA15C3DA49
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 21:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16CF288266;
	Sun, 28 Jul 2024 23:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="nBEZ9gZg";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="D4/cEAwk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C540788137; Sun, 28 Jul 2024 23:04:47 +0200 (CEST)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 370E2885E7
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 23:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 3dfd61db;
 Sun, 28 Jul 2024 21:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=/A
 bdpMovCNmqdEKlx7KMooR6u2w=; b=nBEZ9gZgHEswN4F3FpyHMGmfm+n5rCHg3/
 QY+kwUfllDDG+fhsnABSdQwxifojFiR4OP02xbPVLbtFwQsbVjKf4EzPXWsDlBMQ
 KkJwEDL0uivJiBj6lcUwJWJ2nRE9kBu5luc9dyk1QDm0cnzqI8GrAqjYr9Lyl8FQ
 wSgNwUWy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 wtHwHkAN3hkjJwr4xgRu6PuhMkrUJ4yVHxVWO5iXv+/ZE8zarcJApmwxpXV6pjdA
 xN/uLKyaDkc9kjPcNxgbeabl4ME1rl+eBiF7FBC/xopzAu/Ad7wbq1t+iRAnJsqV
 6dkPkHgk7eOcGDW1TyB+Bvyqd71efMUSZAyMLaYztZo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1722200553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2JNjdN604BdPGm7wsMAjikETRfKCJ9ExNDBclwtPJY=;
 b=D4/cEAwkKbLIqxZwRv/FpL43FWQUpcETD57+wIqTfF9A10kTDg5EtrbOE6vDO88/ac7K4t
 n0vqh2Dc4RtqXGCDGNhTg3u00UPfMjZvuw0UTILUhAKjXdrC7xFP8jj/tc/P55ExMqpJXQ
 JJjUPhrFktt/vVN0rx7xKPHQJAV87os=
Received: from [192.168.0.2] (host-87-5-224-154.retail.telecomitalia.it
 [87.5.224.154])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 143da946
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sun, 28 Jul 2024 21:02:33 +0000 (UTC)
Message-ID: <5587ef25-7694-4aa9-8a73-98e589b61cae@kernel-space.org>
Date: Sun, 28 Jul 2024 23:03:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: M68K Vectors
To: Peter LaDow <pladow@gmail.com>, Huan Wang <alison.wang@nxp.com>,
 u-boot@lists.denx.de
References: <CAN8Q1EeO0C-LcC1jC=XYZM3RbFbs6sUtjbR===VUe6FYe5Utrw@mail.gmail.com>
 <CAN8Q1Ef=eUs9qfwzhCfHA2YrFFZnKVNQVA=5mQb5Hxqi6hs5cw@mail.gmail.com>
 <CAOMZO5BT2st6FdSx-QzmOee2pqTZ0PE_-Ek6p4KbZ+JJJ=HAvw@mail.gmail.com>
 <CAN8Q1EfPghRrKtgeO_gr_VZ26_dHQUpRkBqbfYshZf0KeGm=oA@mail.gmail.com>
 <CAN8Q1EdCtmCE9HPhhjHakRk77Mw4AQ1-tPLm1SQcS0ELrgy3Lg@mail.gmail.com>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <CAN8Q1EdCtmCE9HPhhjHakRk77Mw4AQ1-tPLm1SQcS0ELrgy3Lg@mail.gmail.com>
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

Hi Peter,

glad to hear you solved.

As a toolchain i use those provided by kernel.org:

/opt/toolchains/m68k/gcc-12.2.0-nolibc/m68k-linux/bin/m68k-linux-

https://cdn.kernel.org/pub/tools/crosstool/

Just out of curiosity, what's the cpu model you used ?


Regards,
Angelo Dureghello


On 26/07/24 10:22 PM, Peter LaDow wrote:
> Scratch that.  I forgot I hard coded the vector table with 0x400 to
> test things.  Restoring _start still results in 0x00000000 for the
> reset vector.
>
> On Fri, Jul 26, 2024 at 1:16 PM Peter LaDow <pladow@gmail.com> wrote:
>> I should mention I was using the gcc-m68k-linux-gnu package on Ubuntu
>> 22.04.4, which pulled in gcc-11-m68k-linux-gnu.
>>
>> I just downloaded the bootlin m68k-coldfire--uclibc--stable-2024.02-1,
>> and tried that.  It generates the proper value in the vector table
>> (0x400 for _start).  But the call to memset is still bad:
>>
>> 0000f5da <board_init_f_init_reserve>:
>>     f5da:       2f02            movel %d2,%sp@-
>>     f5dc:       242f 0008       movel %sp@(8),%d2
>>     f5e0:       4878 00c0       pea c0 <_vectors+0xc0>
>>     f5e4:       42a7            clrl %sp@-
>>     f5e6:       2f02            movel %d2,%sp@-
>>     f5e8:       61ff 0001 4622  bsrl 23c0c <_etext+0x138>
>>     f5ee:       2f02            movel %d2,%sp@-
>>     f5f0:       61ff ffff ffd2  bsrl f5c4 <arch_setup_gd>
>>     f5f6:       0682 0000 00c0  addil #192,%d2
>>     f5fc:       4fef 0010       lea %sp@(16),%sp
>>     f600:       2047            moveal %d7,%a0
>>     f602:       2142 00a0       movel %d2,%a0@(160)
>>     f606:       241f            movel %sp@+,%d2
>>     f608:       4e75            rts
>>
>> Note "bsrl 23c0c" which points beyond _etext.
>>
>> On Fri, Jul 26, 2024 at 12:59 PM Fabio Estevam <festevam@gmail.com> wrote:
>>> Adding the Coldfire maintainers on Cc.
>>>
>>> On Fri, Jul 26, 2024 at 4:46 PM Peter LaDow <pladow@gmail.com> wrote:
>>>> After some digging it appears that this is a toolchain issue.  It seems the
>>>> linker fixups are sometimes not computed correctly.  For example, in
>>>> board_init_f_init_reserve, the object file disassembled has:
>>>>
>>>> 00000000 <board_init_f_init_reserve>:
>>>>    0:   2f02            movel %d2,%sp@-
>>>>    2:   242f 0008       movel %sp@(8),%d2
>>>>    6:   4878 00c0       pea c0 <board_init_f_init_reserve+0xc0>
>>>>    a:   42a7            clrl %sp@-
>>>>    c:   2f02            movel %d2,%sp@-
>>>>    e:   61ff 0000 0000  bsrl 10 <board_init_f_init_reserve+0x10>
>>>>   14:   2f02            movel %d2,%sp@-
>>>>   16:   61ff 0000 0000  bsrl 18 <board_init_f_init_reserve+0x18>
>>>>   1c:   0682 0000 00c0  addil #192,%d2
>>>>   22:   4fef 0010       lea %sp@(16),%sp
>>>>   26:   2047            moveal %d7,%a0
>>>>   28:   2142 00a0       movel %d2,%a0@(160)
>>>>   2c:   241f            movel %sp@+,%d2
>>>>   2e:   4e75            rts
>>>>
>>>> But when I disassemble the final linked u-boot output:
>>>>
>>>> 0000f646 <board_init_f_init_reserve>:
>>>>     f646:       2f02            movel %d2,%sp@-
>>>>     f648:       242f 0008       movel %sp@(8),%d2
>>>>     f64c:       4878 00c0       pea c0 <_vectors+0xc0>
>>>>     f650:       42a7            clrl %sp@-
>>>>     f652:       2f02            movel %d2,%sp@-
>>>>     f654:       61ff 0001 44da  bsrl 23b30 <_etext+0x138>
>>>>     f65a:       2f02            movel %d2,%sp@-
>>>>     f65c:       61ff ffff ffd2  bsrl f630 <arch_setup_gd>
>>>>     f662:       0682 0000 00c0  addil #192,%d2
>>>>     f668:       4fef 0010       lea %sp@(16),%sp
>>>>     f66c:       2047            moveal %d7,%a0
>>>>     f66e:       2142 00a0       movel %d2,%a0@(160)
>>>>     f672:       241f            movel %sp@+,%d2
>>>>     f674:       4e75            rts
>>>>
>>>> Note the pea c0 instruction.  The object file has
>>>> board_init_f_init_reserve+0xc0 as the argument, but the final linker has
>>>> 0xc0, meaning board_init_f_init_reserve is being set to 0 after linking.
>>>>
>>>> Also, note the first bsrl instruction, which is not setup correctly
>>>> either.  This is a call to memset.  This points to _etext+0x138, which is
>>>> not a code region Note that 0x239f8 + 0x138 = 0x23b30.  But in the final
>>>> uboot, memset is at 0x1f030.
>>>>
>>>> In the call to memset(),  objdump shows the relocation:
>>>>
>>>> RELOCATION RECORDS FOR [.text.board_init_f_init_reserve]:
>>>> OFFSET   TYPE              VALUE
>>>> 00000010 R_68K_PLT32       memset
>>>> 00000018 R_68K_PLT32       arch_setup_gd
>>>>
>>>> So it seems only when linking outside the same compilation unit that the
>>>> relocations aren't set correctly.
>>>>
>>>> I'm not sure where to look for a solution.  Or how to search for an
>>>> answer.  I've done some digging on Google, but nothing points to a clear
>>>> answer.  Anyone seen something similar?
>>>>
>>>> To love for the sake of being loved is human, but to love for the sake of
>>>> loving is angelic. -- Alphonse de Lamartine.
>>>>
>>>>
>>>> On Thu, Jul 25, 2024 at 14:35 Peter LaDow <pladow@gmail.com> wrote:
>>>>> I'm trying to add support for a custom Colfire based board.  I have
>>>>> things building, but the final linked vectors in start.S do not point
>>>>> to _start.  In start.S I have:
>>>>>
>>>>> _vectors:
>>>>> .long   0x00000000              /* Flash offset is 0 until we setup CS0 */
>>>>> .long   _START
>>>>>
>>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
>>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
>>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
>>>>>
>>>>> Dumping the symbols in the final u-boot yields:
>>>>>
>>>>> $ m68k-linux-gnu-nm -n u-boot
>>>>> 00000000 A __fixup_entries
>>>>> 00000000 A __got2_entries
>>>>> 00000000 t _vectors
>>>>> 00000400 T _start
>>>>> 0000047e T relocate_code
>>>>> 000004ae t fixloop
>>>>>
>>>>> But then dumping the raw binary:
>>>>>
>>>>> u-boot:     file format elf32-m68k
>>>>>
>>>>> Contents of section .text:
>>>>> 00000 00000000 00000000 00000516 00000516  ................
>>>>> 00010 00000516 00000516 00000516 00000516  ................
>>>>> 00020 00000516 00000516 00000516 00000516  ................
>>>>> 00030 00000516 00000516 00000516 00000516  ................
>>>>>
>>>>> Note at offset 4 it is 0x00000000, not 0x00000400 as I'd expect.
>>>>>
>>>>> The final linker script has:
>>>>>
>>>>> OUTPUT_ARCH(m68k)
>>>>> ENTRY(_start)
>>>>> SECTIONS
>>>>> {
>>>>> .text :
>>>>> {
>>>>>   arch/m68k/cpu/mcf548x/start.o (.text*)
>>>>>   . = DEFINED(env_offset) ? env_offset : .; env/embedded.o(.text*);
>>>>>   *(.text*)
>>>>> }
>>>>>
>>>>>
>>>>> It is difficult to search the archives, and so far I haven't found
>>>>> anything.  Any help would be appreciated.
>>>>>
>>>>> --
>>>>> To love for the sake of being loved is human, but to love for the sake
>>>>> of loving is angelic. -- Alphonse de Lamartine.
>>
>>
>> --
>> To love for the sake of being loved is human, but to love for the sake
>> of loving is angelic. -- Alphonse de Lamartine.
>
>
