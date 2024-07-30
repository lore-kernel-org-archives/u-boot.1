Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA20CC3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 13:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0378D88820;
	Tue, 30 Jul 2024 15:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="ny1+n9RP";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="pX5kjZLl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1B218881F; Tue, 30 Jul 2024 15:50:48 +0200 (CEST)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 698EE87BF4
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 15:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id e932eb22;
 Tue, 30 Jul 2024 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=Uz
 0m6N0SCV2MmMGBEIiSIj1n9kc=; b=ny1+n9RPQkrqvhmd0FTcOm+QSicwfr9To9
 DcltD4eIItMcM6WzVGMII3Z11SR2eq3BdCaxCG/Cn7jjqtvgMZrTq19kZm9OJ2Ov
 oZzcdDVBNboim99V13C/CwOuXcKfVEuQUGVfNLTa6SKla8jhX0tMrXVXr880qj64
 jUuzBhk5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 FTiO+K3DhR1TuryeUHTsGxNBbAfPz/e6yIGRLK5IKi6TZEt+qvJ89yar7EcWNjcV
 bjbsXldv2BrzbcaeBuz9rdKKGAaFHk2dRXad5/jQb13L/fWBjF0ub1njw8vPPUoh
 4gj9OC7r+ExszRp80Ut98baTVeB+K0lIXNOat3xmToE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1722347305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3t94pfAbsl/ccU0IU3qrYszK/m1yNfpSb7iglABD3E=;
 b=pX5kjZLlUal2V5UgWRCeqlKH3Mbyd595jQyMlTbjkLDoziQLSpEIpNOLyFSTVHBGNrm0dK
 HgqO24nhNfUnee8o+ldjNt7thPaWPKw+XZucZVTU9jA9nyYY2315tC+smMdwp8ceDCFgDd
 4sa64MQJvxUAGiAbeTnZb/o/br4R2j0=
Received: from [192.168.0.2] (host-87-5-224-154.retail.telecomitalia.it
 [87.5.224.154])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 9eed59f6
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Tue, 30 Jul 2024 13:48:25 +0000 (UTC)
Message-ID: <0ca9ef05-1de8-4c30-b1e7-084a57c97828@kernel-space.org>
Date: Tue, 30 Jul 2024 15:49:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: M68K Vectors
To: Peter LaDow <pladow@gmail.com>
Cc: Huan Wang <alison.wang@nxp.com>, u-boot@lists.denx.de
References: <CAN8Q1EeO0C-LcC1jC=XYZM3RbFbs6sUtjbR===VUe6FYe5Utrw@mail.gmail.com>
 <CAN8Q1Ef=eUs9qfwzhCfHA2YrFFZnKVNQVA=5mQb5Hxqi6hs5cw@mail.gmail.com>
 <CAOMZO5BT2st6FdSx-QzmOee2pqTZ0PE_-Ek6p4KbZ+JJJ=HAvw@mail.gmail.com>
 <CAN8Q1EfPghRrKtgeO_gr_VZ26_dHQUpRkBqbfYshZf0KeGm=oA@mail.gmail.com>
 <CAN8Q1EdCtmCE9HPhhjHakRk77Mw4AQ1-tPLm1SQcS0ELrgy3Lg@mail.gmail.com>
 <5587ef25-7694-4aa9-8a73-98e589b61cae@kernel-space.org>
 <CAN8Q1Ee6LhiLadKDjFzBghzENEDaWjLL9OBDiOpK_LnfN=DTdg@mail.gmail.com>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <CAN8Q1Ee6LhiLadKDjFzBghzENEDaWjLL9OBDiOpK_LnfN=DTdg@mail.gmail.com>
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

unfortunately i don't have any of such 548x boards, so cannot
help that much, but if you can manage to have it working, it will
be great.

Considering 548x is with mmu, mcf5441x startup code may be helpful,
even if it's isa_C (your is isa_B).

mcf5441x is tested here, and it is actually doing an elf32 relocation,
as you can see in start.S "fixloop". It is done after the "copy to ram".

I would proceed with small steps, setting some debug output (or gpio output)
to see where the startup code fails.

Check also the makefile options in arch/m68k/cpu/Makefile, see the -fPIC.

I follow the thread.

Thanks,
regards,
angelo


On 29/07/24 4:27 PM, Peter LaDow wrote:
> It's not solved yet.  I forgot I had hard coded some items.
>
> I will give the flavors you suggest a try.
>
> I'm trying to add the MCF548x for a legacy board we have.  It's near
> EOL, but we want to leverage uBoot from some in house work.
>
> Thanks,
> Pete
>
> On Sun, Jul 28, 2024 at 2:04 PM Angelo Dureghello
> <angelo@kernel-space.org> wrote:
>> Hi Peter,
>>
>> glad to hear you solved.
>>
>> As a toolchain i use those provided by kernel.org:
>>
>> /opt/toolchains/m68k/gcc-12.2.0-nolibc/m68k-linux/bin/m68k-linux-
>>
>> https://cdn.kernel.org/pub/tools/crosstool/
>>
>> Just out of curiosity, what's the cpu model you used ?
>>
>>
>> Regards,
>> Angelo Dureghello
>>
>>
>> On 26/07/24 10:22 PM, Peter LaDow wrote:
>>> Scratch that.  I forgot I hard coded the vector table with 0x400 to
>>> test things.  Restoring _start still results in 0x00000000 for the
>>> reset vector.
>>>
>>> On Fri, Jul 26, 2024 at 1:16 PM Peter LaDow <pladow@gmail.com> wrote:
>>>> I should mention I was using the gcc-m68k-linux-gnu package on Ubuntu
>>>> 22.04.4, which pulled in gcc-11-m68k-linux-gnu.
>>>>
>>>> I just downloaded the bootlin m68k-coldfire--uclibc--stable-2024.02-1,
>>>> and tried that.  It generates the proper value in the vector table
>>>> (0x400 for _start).  But the call to memset is still bad:
>>>>
>>>> 0000f5da <board_init_f_init_reserve>:
>>>>      f5da:       2f02            movel %d2,%sp@-
>>>>      f5dc:       242f 0008       movel %sp@(8),%d2
>>>>      f5e0:       4878 00c0       pea c0 <_vectors+0xc0>
>>>>      f5e4:       42a7            clrl %sp@-
>>>>      f5e6:       2f02            movel %d2,%sp@-
>>>>      f5e8:       61ff 0001 4622  bsrl 23c0c <_etext+0x138>
>>>>      f5ee:       2f02            movel %d2,%sp@-
>>>>      f5f0:       61ff ffff ffd2  bsrl f5c4 <arch_setup_gd>
>>>>      f5f6:       0682 0000 00c0  addil #192,%d2
>>>>      f5fc:       4fef 0010       lea %sp@(16),%sp
>>>>      f600:       2047            moveal %d7,%a0
>>>>      f602:       2142 00a0       movel %d2,%a0@(160)
>>>>      f606:       241f            movel %sp@+,%d2
>>>>      f608:       4e75            rts
>>>>
>>>> Note "bsrl 23c0c" which points beyond _etext.
>>>>
>>>> On Fri, Jul 26, 2024 at 12:59 PM Fabio Estevam <festevam@gmail.com> wrote:
>>>>> Adding the Coldfire maintainers on Cc.
>>>>>
>>>>> On Fri, Jul 26, 2024 at 4:46 PM Peter LaDow <pladow@gmail.com> wrote:
>>>>>> After some digging it appears that this is a toolchain issue.  It seems the
>>>>>> linker fixups are sometimes not computed correctly.  For example, in
>>>>>> board_init_f_init_reserve, the object file disassembled has:
>>>>>>
>>>>>> 00000000 <board_init_f_init_reserve>:
>>>>>>     0:   2f02            movel %d2,%sp@-
>>>>>>     2:   242f 0008       movel %sp@(8),%d2
>>>>>>     6:   4878 00c0       pea c0 <board_init_f_init_reserve+0xc0>
>>>>>>     a:   42a7            clrl %sp@-
>>>>>>     c:   2f02            movel %d2,%sp@-
>>>>>>     e:   61ff 0000 0000  bsrl 10 <board_init_f_init_reserve+0x10>
>>>>>>    14:   2f02            movel %d2,%sp@-
>>>>>>    16:   61ff 0000 0000  bsrl 18 <board_init_f_init_reserve+0x18>
>>>>>>    1c:   0682 0000 00c0  addil #192,%d2
>>>>>>    22:   4fef 0010       lea %sp@(16),%sp
>>>>>>    26:   2047            moveal %d7,%a0
>>>>>>    28:   2142 00a0       movel %d2,%a0@(160)
>>>>>>    2c:   241f            movel %sp@+,%d2
>>>>>>    2e:   4e75            rts
>>>>>>
>>>>>> But when I disassemble the final linked u-boot output:
>>>>>>
>>>>>> 0000f646 <board_init_f_init_reserve>:
>>>>>>      f646:       2f02            movel %d2,%sp@-
>>>>>>      f648:       242f 0008       movel %sp@(8),%d2
>>>>>>      f64c:       4878 00c0       pea c0 <_vectors+0xc0>
>>>>>>      f650:       42a7            clrl %sp@-
>>>>>>      f652:       2f02            movel %d2,%sp@-
>>>>>>      f654:       61ff 0001 44da  bsrl 23b30 <_etext+0x138>
>>>>>>      f65a:       2f02            movel %d2,%sp@-
>>>>>>      f65c:       61ff ffff ffd2  bsrl f630 <arch_setup_gd>
>>>>>>      f662:       0682 0000 00c0  addil #192,%d2
>>>>>>      f668:       4fef 0010       lea %sp@(16),%sp
>>>>>>      f66c:       2047            moveal %d7,%a0
>>>>>>      f66e:       2142 00a0       movel %d2,%a0@(160)
>>>>>>      f672:       241f            movel %sp@+,%d2
>>>>>>      f674:       4e75            rts
>>>>>>
>>>>>> Note the pea c0 instruction.  The object file has
>>>>>> board_init_f_init_reserve+0xc0 as the argument, but the final linker has
>>>>>> 0xc0, meaning board_init_f_init_reserve is being set to 0 after linking.
>>>>>>
>>>>>> Also, note the first bsrl instruction, which is not setup correctly
>>>>>> either.  This is a call to memset.  This points to _etext+0x138, which is
>>>>>> not a code region Note that 0x239f8 + 0x138 = 0x23b30.  But in the final
>>>>>> uboot, memset is at 0x1f030.
>>>>>>
>>>>>> In the call to memset(),  objdump shows the relocation:
>>>>>>
>>>>>> RELOCATION RECORDS FOR [.text.board_init_f_init_reserve]:
>>>>>> OFFSET   TYPE              VALUE
>>>>>> 00000010 R_68K_PLT32       memset
>>>>>> 00000018 R_68K_PLT32       arch_setup_gd
>>>>>>
>>>>>> So it seems only when linking outside the same compilation unit that the
>>>>>> relocations aren't set correctly.
>>>>>>
>>>>>> I'm not sure where to look for a solution.  Or how to search for an
>>>>>> answer.  I've done some digging on Google, but nothing points to a clear
>>>>>> answer.  Anyone seen something similar?
>>>>>>
>>>>>> To love for the sake of being loved is human, but to love for the sake of
>>>>>> loving is angelic. -- Alphonse de Lamartine.
>>>>>>
>>>>>>
>>>>>> On Thu, Jul 25, 2024 at 14:35 Peter LaDow <pladow@gmail.com> wrote:
>>>>>>> I'm trying to add support for a custom Colfire based board.  I have
>>>>>>> things building, but the final linked vectors in start.S do not point
>>>>>>> to _start.  In start.S I have:
>>>>>>>
>>>>>>> _vectors:
>>>>>>> .long   0x00000000              /* Flash offset is 0 until we setup CS0 */
>>>>>>> .long   _START
>>>>>>>
>>>>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
>>>>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
>>>>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
>>>>>>>
>>>>>>> Dumping the symbols in the final u-boot yields:
>>>>>>>
>>>>>>> $ m68k-linux-gnu-nm -n u-boot
>>>>>>> 00000000 A __fixup_entries
>>>>>>> 00000000 A __got2_entries
>>>>>>> 00000000 t _vectors
>>>>>>> 00000400 T _start
>>>>>>> 0000047e T relocate_code
>>>>>>> 000004ae t fixloop
>>>>>>>
>>>>>>> But then dumping the raw binary:
>>>>>>>
>>>>>>> u-boot:     file format elf32-m68k
>>>>>>>
>>>>>>> Contents of section .text:
>>>>>>> 00000 00000000 00000000 00000516 00000516  ................
>>>>>>> 00010 00000516 00000516 00000516 00000516  ................
>>>>>>> 00020 00000516 00000516 00000516 00000516  ................
>>>>>>> 00030 00000516 00000516 00000516 00000516  ................
>>>>>>>
>>>>>>> Note at offset 4 it is 0x00000000, not 0x00000400 as I'd expect.
>>>>>>>
>>>>>>> The final linker script has:
>>>>>>>
>>>>>>> OUTPUT_ARCH(m68k)
>>>>>>> ENTRY(_start)
>>>>>>> SECTIONS
>>>>>>> {
>>>>>>> .text :
>>>>>>> {
>>>>>>>    arch/m68k/cpu/mcf548x/start.o (.text*)
>>>>>>>    . = DEFINED(env_offset) ? env_offset : .; env/embedded.o(.text*);
>>>>>>>    *(.text*)
>>>>>>> }
>>>>>>>
>>>>>>>
>>>>>>> It is difficult to search the archives, and so far I haven't found
>>>>>>> anything.  Any help would be appreciated.
>>>>>>>
>>>>>>> --
>>>>>>> To love for the sake of being loved is human, but to love for the sake
>>>>>>> of loving is angelic. -- Alphonse de Lamartine.
>>>>
>>>> --
>>>> To love for the sake of being loved is human, but to love for the sake
>>>> of loving is angelic. -- Alphonse de Lamartine.
>>>
>
>
