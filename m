Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B826C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 10:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23E328870B;
	Wed, 31 Jul 2024 12:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="tma9KDDv";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="Kore78Sd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 036BF8870B; Wed, 31 Jul 2024 12:11:29 +0200 (CEST)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 612ED87702
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 4686710f;
 Wed, 31 Jul 2024 10:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=2b
 2fRKlYkTRPL40g9VV6fnKe818=; b=tma9KDDvNl7E6S47LzRUlKsdKoaB8DaBLB
 I9b+5Hhuu6Fo1RiclRD/EjRQcAjSdRnFNmCaS6obqcnO6bW/9cq+3MaWhYbfoS1x
 qdNEWRo0+fKfizsLo7CUcy2DPgFTBCZPzbTtF6SKUFS/xIeNdroZysbBpQFRKGzb
 JKfMa48yo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 TY9Qdw/kBXhtznMrGdWj2iemCgkHonxH4P8p2Mxe+Oegl28TInupfYU7ysBbfAuN
 pWIXLuA4DtoGZ6u0vfEWv1tQ9GzT2nHdAXV9OM5YOYDN3O8ON+5SE9591DCpkQ7V
 149HRQx2e8pdcAidRT7Vg1QH/BE63IjKGIJqMlbEoOI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1722420540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uDTyY9hOEluFBUOYQrxVSyr8OTqH+M6SXqRinA4Aikk=;
 b=Kore78Sd2u3e9SOlm0QCAurTJk1TqO02pqgTpUPxp4F7/aB7YT/KWdkZaDSc9fkyjbCX4x
 quH+Zy9KXO3gVK3XtF1mr5SNSy30ePScpAAMlVS0viyNCl4txBXYY3mRmj+Yjv4KgY5g1R
 qWs2s59tWh58mINrs/rBnWH+ZsiwlEU=
Received: from [192.168.0.2] (host-87-5-224-154.retail.telecomitalia.it
 [87.5.224.154])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 09d89f74
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 31 Jul 2024 10:09:00 +0000 (UTC)
Message-ID: <6e3ddc2a-3c7b-4e45-a4a3-99bba6a792fb@kernel-space.org>
Date: Wed, 31 Jul 2024 12:10:29 +0200
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
 <0ca9ef05-1de8-4c30-b1e7-084a57c97828@kernel-space.org>
 <CAN8Q1EdrY9KfGG=RFGshEZGXhw1JNT6C_X6zs2kW8ecw3yut6w@mail.gmail.com>
 <CAN8Q1Ed-dxKMLF3enY-zCE57YoQ9yisfyTULWos4JSMA+8qbfQ@mail.gmail.com>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <CAN8Q1Ed-dxKMLF3enY-zCE57YoQ9yisfyTULWos4JSMA+8qbfQ@mail.gmail.com>
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

Hi Pete,

ok, so if you are running from flash, amcore is
also running from parallel nor flash, but is no-mmu mcf5397,
jfyi.

Regards,
angelo


On 30/07/24 9:09 PM, Peter LaDow wrote:
> A bit more digging.
>
> When I follow the chain through the PLT call to memset, it does some
> lookups in the .got.plt section.  And even on the MCF5445x, it seems
> to ultimately result in a lookup of 0x00000000.
>
> Here's the chain for the MCF5445x.  I did the manually using
> objdump/nm, but I think the math works out (I did a similar thing for
> my board).
>
> Here's the call in board_init_f_init_reserve:
>
>    47e0ad62:       61ff 0001 4ae0  bsrl 47e1f844 <_etext+0x2d0>
>
> Now, 0x47e1f844 is in .plt.  The code here:
>
>    47e1f844:       203c 0000 c046  movel #49222,%d0
>    47e1f84a:       207b 08fa       moveal %pc@(47e1f846 <.plt+0x2d2>,%d0:l),%a0
>    47e1f84e:       4ed0            jmp %a0@
>
> So, this does a lookup relative to PC:  0x47e1f84a + 2 (CF adds to for
> PC relative) - 6 (0xfa in the extension word) + 49222*1 (D0 register,
> scale of 1).  This PC relative lookup resolves to 0x47e2b88c, so it
> reads from this address, loads into A0, and jumps to that address.
> This address is in .got.plt:
>
>    Contents of section .got.plt:
>     ...
>     47e2b88c 47e1f850 47e1f868 47e1f880 47e1f898  G..PG..hG...G...
>
> So, the code jumps to 0x47e1f850.  The disassembly at 0x47e1f850:
>
>    47e1f850:       2f3c 0000 015c  movel #348,%sp@-
>    47e1f856:       61ff ffff fd1c  bsrl 47e1f574 <.plt>
>
> Which jumps to 0x47e1f574:
>
>    47e1f574 <.plt>:
>    47e1f574:       203c 0000 c29a  movel #49818,%d0
>    47e1f57a:       2ebb 08fa       movel %pc@(47e1f576 <.plt+0x2>,%d0:l),%sp@
>    47e1f57e:       203c 0000 c294  movel #49812,%d0
>    47e1f584:       207b 08fa       moveal %pc@(47e1f580 <.plt+0xc>,%d0:l),%a0
>    47e1f588:       4ed0            jmp %a0@
>
> Ultimately here we see it load more data from .got.plt (at
> 0x47e1f584):  PC relative = 0x47e1f584 + 2 - 6 + 49812 =  0x47e2b814.
> This resolves to 0x47e2b814, which again is in .got.plt:
>
>    Contents of section .got.plt:
>     47e2b80c 47e2b75c 00000000 00000000 47e1f598  G..\........G...
>
> And we see at 0x47e2b814 a value of 0x00000000.  Meaning the code
> jumps to address 0.  Which cannot be correct.
>
> And this is exactly the behavior I'm seeing with my build.  My build
> gets lost on the call to memset(), because the PLT code ultimately
> resolves to call address 0x00000000.
>
> So, the question is how could this fixup be done?  Now, I do see code
> in start.S that does fixups.  But this references the .rela.dyn
> section, neither .plt nor .got.plt.  And I see no other code that does
> any fixup of .got or .got.plt.  And further, .got.plt is largely
> populated with values other than 0.  There's just these two entries.
>
> I think I'm going to reach out on the binutils list to try and get
> some insight into what is occurring here.
>
> Thanks,
> Pete
>
>
> On Tue, Jul 30, 2024 at 8:43 AM Peter LaDow <pladow@gmail.com> wrote:
>> Thank you for the feedback.
>>
>> It looks like the mcf5441x executes from RAM.  At least looking at the
>> configuration for the stmark2, which defines CONFIG_SERIAL_BOOT and
>> CONFIG_SF_SBF.  This appears to copy from an external device using the
>> DSPI into RAM.  After loaded, _start finally executes.  Interestingly,
>> the offset to _start appears to be hard-coded.
>>
>> First, it forces _start to offset 0x400:
>>
>> .text
>> . = 0x400
>> .globl _start
>> _start:
>>
>> Then the call to start is by a fixed offset:
>>
>> /* jump to memory and execute */
>> move.l #(CONFIG_TEXT_BASE + 0x400), %a0
>> jmp (%a0)
>>
>> Where CONFIG_TEXT_BASE is set to 0x47e00000.  The code is odd in this
>> case as it appears to use the vector table for the DSPI boot,
>> squeezing all that functionality into less than 1kbyte of memory.
>>
>> However, once _start runs, the code is pretty much the same as the
>> other Coldfire variants.  It calls board_init_f_init_reserve, which
>> calls memset through the same PLT mechanism.  What isn't clear to me
>> (yet) is why that PLT mechanism works for you, but not for me.  But I
>> suspect it is because I'm trying to execute directly from flash.
>>
>> Thanks,
>> Pete
>>
>> On Tue, Jul 30, 2024 at 6:50 AM Angelo Dureghello
>> <angelo@kernel-space.org> wrote:
>>> Hi Peter,
>>>
>>> unfortunately i don't have any of such 548x boards, so cannot
>>> help that much, but if you can manage to have it working, it will
>>> be great.
>>>
>>> Considering 548x is with mmu, mcf5441x startup code may be helpful,
>>> even if it's isa_C (your is isa_B).
>>>
>>> mcf5441x is tested here, and it is actually doing an elf32 relocation,
>>> as you can see in start.S "fixloop". It is done after the "copy to ram".
>>>
>>> I would proceed with small steps, setting some debug output (or gpio output)
>>> to see where the startup code fails.
>>>
>>> Check also the makefile options in arch/m68k/cpu/Makefile, see the -fPIC.
>>>
>>> I follow the thread.
>>>
>>> Thanks,
>>> regards,
>>> angelo
>>>
>>>
>>> On 29/07/24 4:27 PM, Peter LaDow wrote:
>>>> It's not solved yet.  I forgot I had hard coded some items.
>>>>
>>>> I will give the flavors you suggest a try.
>>>>
>>>> I'm trying to add the MCF548x for a legacy board we have.  It's near
>>>> EOL, but we want to leverage uBoot from some in house work.
>>>>
>>>> Thanks,
>>>> Pete
>>>>
>>>> On Sun, Jul 28, 2024 at 2:04 PM Angelo Dureghello
>>>> <angelo@kernel-space.org> wrote:
>>>>> Hi Peter,
>>>>>
>>>>> glad to hear you solved.
>>>>>
>>>>> As a toolchain i use those provided by kernel.org:
>>>>>
>>>>> /opt/toolchains/m68k/gcc-12.2.0-nolibc/m68k-linux/bin/m68k-linux-
>>>>>
>>>>> https://cdn.kernel.org/pub/tools/crosstool/
>>>>>
>>>>> Just out of curiosity, what's the cpu model you used ?
>>>>>
>>>>>
>>>>> Regards,
>>>>> Angelo Dureghello
>>>>>
>>>>>
>>>>> On 26/07/24 10:22 PM, Peter LaDow wrote:
>>>>>> Scratch that.  I forgot I hard coded the vector table with 0x400 to
>>>>>> test things.  Restoring _start still results in 0x00000000 for the
>>>>>> reset vector.
>>>>>>
>>>>>> On Fri, Jul 26, 2024 at 1:16 PM Peter LaDow <pladow@gmail.com> wrote:
>>>>>>> I should mention I was using the gcc-m68k-linux-gnu package on Ubuntu
>>>>>>> 22.04.4, which pulled in gcc-11-m68k-linux-gnu.
>>>>>>>
>>>>>>> I just downloaded the bootlin m68k-coldfire--uclibc--stable-2024.02-1,
>>>>>>> and tried that.  It generates the proper value in the vector table
>>>>>>> (0x400 for _start).  But the call to memset is still bad:
>>>>>>>
>>>>>>> 0000f5da <board_init_f_init_reserve>:
>>>>>>>       f5da:       2f02            movel %d2,%sp@-
>>>>>>>       f5dc:       242f 0008       movel %sp@(8),%d2
>>>>>>>       f5e0:       4878 00c0       pea c0 <_vectors+0xc0>
>>>>>>>       f5e4:       42a7            clrl %sp@-
>>>>>>>       f5e6:       2f02            movel %d2,%sp@-
>>>>>>>       f5e8:       61ff 0001 4622  bsrl 23c0c <_etext+0x138>
>>>>>>>       f5ee:       2f02            movel %d2,%sp@-
>>>>>>>       f5f0:       61ff ffff ffd2  bsrl f5c4 <arch_setup_gd>
>>>>>>>       f5f6:       0682 0000 00c0  addil #192,%d2
>>>>>>>       f5fc:       4fef 0010       lea %sp@(16),%sp
>>>>>>>       f600:       2047            moveal %d7,%a0
>>>>>>>       f602:       2142 00a0       movel %d2,%a0@(160)
>>>>>>>       f606:       241f            movel %sp@+,%d2
>>>>>>>       f608:       4e75            rts
>>>>>>>
>>>>>>> Note "bsrl 23c0c" which points beyond _etext.
>>>>>>>
>>>>>>> On Fri, Jul 26, 2024 at 12:59 PM Fabio Estevam <festevam@gmail.com> wrote:
>>>>>>>> Adding the Coldfire maintainers on Cc.
>>>>>>>>
>>>>>>>> On Fri, Jul 26, 2024 at 4:46 PM Peter LaDow <pladow@gmail.com> wrote:
>>>>>>>>> After some digging it appears that this is a toolchain issue.  It seems the
>>>>>>>>> linker fixups are sometimes not computed correctly.  For example, in
>>>>>>>>> board_init_f_init_reserve, the object file disassembled has:
>>>>>>>>>
>>>>>>>>> 00000000 <board_init_f_init_reserve>:
>>>>>>>>>      0:   2f02            movel %d2,%sp@-
>>>>>>>>>      2:   242f 0008       movel %sp@(8),%d2
>>>>>>>>>      6:   4878 00c0       pea c0 <board_init_f_init_reserve+0xc0>
>>>>>>>>>      a:   42a7            clrl %sp@-
>>>>>>>>>      c:   2f02            movel %d2,%sp@-
>>>>>>>>>      e:   61ff 0000 0000  bsrl 10 <board_init_f_init_reserve+0x10>
>>>>>>>>>     14:   2f02            movel %d2,%sp@-
>>>>>>>>>     16:   61ff 0000 0000  bsrl 18 <board_init_f_init_reserve+0x18>
>>>>>>>>>     1c:   0682 0000 00c0  addil #192,%d2
>>>>>>>>>     22:   4fef 0010       lea %sp@(16),%sp
>>>>>>>>>     26:   2047            moveal %d7,%a0
>>>>>>>>>     28:   2142 00a0       movel %d2,%a0@(160)
>>>>>>>>>     2c:   241f            movel %sp@+,%d2
>>>>>>>>>     2e:   4e75            rts
>>>>>>>>>
>>>>>>>>> But when I disassemble the final linked u-boot output:
>>>>>>>>>
>>>>>>>>> 0000f646 <board_init_f_init_reserve>:
>>>>>>>>>       f646:       2f02            movel %d2,%sp@-
>>>>>>>>>       f648:       242f 0008       movel %sp@(8),%d2
>>>>>>>>>       f64c:       4878 00c0       pea c0 <_vectors+0xc0>
>>>>>>>>>       f650:       42a7            clrl %sp@-
>>>>>>>>>       f652:       2f02            movel %d2,%sp@-
>>>>>>>>>       f654:       61ff 0001 44da  bsrl 23b30 <_etext+0x138>
>>>>>>>>>       f65a:       2f02            movel %d2,%sp@-
>>>>>>>>>       f65c:       61ff ffff ffd2  bsrl f630 <arch_setup_gd>
>>>>>>>>>       f662:       0682 0000 00c0  addil #192,%d2
>>>>>>>>>       f668:       4fef 0010       lea %sp@(16),%sp
>>>>>>>>>       f66c:       2047            moveal %d7,%a0
>>>>>>>>>       f66e:       2142 00a0       movel %d2,%a0@(160)
>>>>>>>>>       f672:       241f            movel %sp@+,%d2
>>>>>>>>>       f674:       4e75            rts
>>>>>>>>>
>>>>>>>>> Note the pea c0 instruction.  The object file has
>>>>>>>>> board_init_f_init_reserve+0xc0 as the argument, but the final linker has
>>>>>>>>> 0xc0, meaning board_init_f_init_reserve is being set to 0 after linking.
>>>>>>>>>
>>>>>>>>> Also, note the first bsrl instruction, which is not setup correctly
>>>>>>>>> either.  This is a call to memset.  This points to _etext+0x138, which is
>>>>>>>>> not a code region Note that 0x239f8 + 0x138 = 0x23b30.  But in the final
>>>>>>>>> uboot, memset is at 0x1f030.
>>>>>>>>>
>>>>>>>>> In the call to memset(),  objdump shows the relocation:
>>>>>>>>>
>>>>>>>>> RELOCATION RECORDS FOR [.text.board_init_f_init_reserve]:
>>>>>>>>> OFFSET   TYPE              VALUE
>>>>>>>>> 00000010 R_68K_PLT32       memset
>>>>>>>>> 00000018 R_68K_PLT32       arch_setup_gd
>>>>>>>>>
>>>>>>>>> So it seems only when linking outside the same compilation unit that the
>>>>>>>>> relocations aren't set correctly.
>>>>>>>>>
>>>>>>>>> I'm not sure where to look for a solution.  Or how to search for an
>>>>>>>>> answer.  I've done some digging on Google, but nothing points to a clear
>>>>>>>>> answer.  Anyone seen something similar?
>>>>>>>>>
>>>>>>>>> To love for the sake of being loved is human, but to love for the sake of
>>>>>>>>> loving is angelic. -- Alphonse de Lamartine.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Thu, Jul 25, 2024 at 14:35 Peter LaDow <pladow@gmail.com> wrote:
>>>>>>>>>> I'm trying to add support for a custom Colfire based board.  I have
>>>>>>>>>> things building, but the final linked vectors in start.S do not point
>>>>>>>>>> to _start.  In start.S I have:
>>>>>>>>>>
>>>>>>>>>> _vectors:
>>>>>>>>>> .long   0x00000000              /* Flash offset is 0 until we setup CS0 */
>>>>>>>>>> .long   _START
>>>>>>>>>>
>>>>>>>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
>>>>>>>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
>>>>>>>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
>>>>>>>>>>
>>>>>>>>>> Dumping the symbols in the final u-boot yields:
>>>>>>>>>>
>>>>>>>>>> $ m68k-linux-gnu-nm -n u-boot
>>>>>>>>>> 00000000 A __fixup_entries
>>>>>>>>>> 00000000 A __got2_entries
>>>>>>>>>> 00000000 t _vectors
>>>>>>>>>> 00000400 T _start
>>>>>>>>>> 0000047e T relocate_code
>>>>>>>>>> 000004ae t fixloop
>>>>>>>>>>
>>>>>>>>>> But then dumping the raw binary:
>>>>>>>>>>
>>>>>>>>>> u-boot:     file format elf32-m68k
>>>>>>>>>>
>>>>>>>>>> Contents of section .text:
>>>>>>>>>> 00000 00000000 00000000 00000516 00000516  ................
>>>>>>>>>> 00010 00000516 00000516 00000516 00000516  ................
>>>>>>>>>> 00020 00000516 00000516 00000516 00000516  ................
>>>>>>>>>> 00030 00000516 00000516 00000516 00000516  ................
>>>>>>>>>>
>>>>>>>>>> Note at offset 4 it is 0x00000000, not 0x00000400 as I'd expect.
>>>>>>>>>>
>>>>>>>>>> The final linker script has:
>>>>>>>>>>
>>>>>>>>>> OUTPUT_ARCH(m68k)
>>>>>>>>>> ENTRY(_start)
>>>>>>>>>> SECTIONS
>>>>>>>>>> {
>>>>>>>>>> .text :
>>>>>>>>>> {
>>>>>>>>>>     arch/m68k/cpu/mcf548x/start.o (.text*)
>>>>>>>>>>     . = DEFINED(env_offset) ? env_offset : .; env/embedded.o(.text*);
>>>>>>>>>>     *(.text*)
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> It is difficult to search the archives, and so far I haven't found
>>>>>>>>>> anything.  Any help would be appreciated.
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> To love for the sake of being loved is human, but to love for the sake
>>>>>>>>>> of loving is angelic. -- Alphonse de Lamartine.
>>>>>>> --
>>>>>>> To love for the sake of being loved is human, but to love for the sake
>>>>>>> of loving is angelic. -- Alphonse de Lamartine.
>>>>
>>
>>
>> --
>> To love for the sake of being loved is human, but to love for the sake
>> of loving is angelic. -- Alphonse de Lamartine.
>
>
> --
> To love for the sake of being loved is human, but to love for the sake
> of loving is angelic. -- Alphonse de Lamartine.
