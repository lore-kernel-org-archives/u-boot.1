Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B1BC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 19:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85012878ED;
	Fri, 26 Jul 2024 21:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fhvhcWsm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B8E880DE; Fri, 26 Jul 2024 21:46:17 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 345578780E
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 21:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pladow@gmail.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-260f863109cso989399fac.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722023173; x=1722627973; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vEMQNAhhTyj+ubLIQhCVsznsVBcK4sOvSj4Wqcfc8vA=;
 b=fhvhcWsmnTfRxySxHoI9vRd7vnuXCGLzbesMb0E94c468xew7qqAA0bZiKsqqJKPUy
 G46CSgRuCsEMMgyv+IXfD43k6SFDtOMCe0HaR6eNUtt0KLVqjQ4XhKp835yQoHzXn0Q0
 OzrLt6LHzRXzoKsNKBVPpsg/2pCuKL6F8l268YrOVZ3t9n9ZAUVDPapzoH6IxtauVvRT
 4nRBvkfYQzaP2XTLBr7DfOvKUOJ3OIKoG52CAfetd7QL5R4KJQ8w0i5bQhdaaSFpoq45
 rSIgEtGBUlJ8/HtnEzvOZIn5RlDQc3TT/8Xy1jXy6QIS+PJCz51bPXgx61jWWbm+s7I7
 jwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722023173; x=1722627973;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vEMQNAhhTyj+ubLIQhCVsznsVBcK4sOvSj4Wqcfc8vA=;
 b=YcE66RZJA97WPt+g5ggm2Qv9Na2qzzvzocEcDazvDYOhN/TzdLNOUOSsT7isFiuydB
 l1TlVgv0e0bTfspg+nY+oXzWRsqOoLLHdubUa2EW8eUD59BPMijT9R2DHtWl1f5YhJSW
 pj83rJMctQb7iAm1U/jxOwD76Btnfq92vq7hI9NtPvUH4hnrImNNeM5oAAC//i+axo8C
 d/1oJAny88VOYEY6KvX8SCx+v1wJpwbQz0cpFRIozM3/crAMV2XM5XWv4fA3SRq4K6Ok
 /mz5SJjjukdVKUOTcGZqjcO72hmx6ECMW8AKsWO2MAmYA/0oFyyZ++jHZVmHdXxTYDUx
 Epxg==
X-Gm-Message-State: AOJu0YyY2TzFWuOzMk7V+RaIS+BIwKljpPmB0eT86AAFCsAqcRiLgNJW
 FzNJw2xGGm1zlvlPL4vJNImz4WRThrKYZrhTIVbYyfg9kOt0+zgemc4QiRiNzlrxPiRQDLkx1hz
 msWkiaePuzdh2QxUO12EHsNxbZNjnHF17
X-Google-Smtp-Source: AGHT+IH2hNqoqS4Dbn/hLLFlTBVFJYc/2TghaTMUCF4lo72EuXKDE2SnSNHQt+FbnWVrNdqyB5bEZ+iyCQfgNPxt4Zk=
X-Received: by 2002:a05:6870:330e:b0:25e:1edb:5bcf with SMTP id
 586e51a60fabf-267d4cfdfd2mr929457fac.6.1722023173543; Fri, 26 Jul 2024
 12:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAN8Q1EeO0C-LcC1jC=XYZM3RbFbs6sUtjbR===VUe6FYe5Utrw@mail.gmail.com>
In-Reply-To: <CAN8Q1EeO0C-LcC1jC=XYZM3RbFbs6sUtjbR===VUe6FYe5Utrw@mail.gmail.com>
From: Peter LaDow <pladow@gmail.com>
Date: Fri, 26 Jul 2024 12:46:02 -0700
Message-ID: <CAN8Q1Ef=eUs9qfwzhCfHA2YrFFZnKVNQVA=5mQb5Hxqi6hs5cw@mail.gmail.com>
Subject: Re: M68K Vectors
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

After some digging it appears that this is a toolchain issue.  It seems the
linker fixups are sometimes not computed correctly.  For example, in
board_init_f_init_reserve, the object file disassembled has:

00000000 <board_init_f_init_reserve>:
  0:   2f02            movel %d2,%sp@-
  2:   242f 0008       movel %sp@(8),%d2
  6:   4878 00c0       pea c0 <board_init_f_init_reserve+0xc0>
  a:   42a7            clrl %sp@-
  c:   2f02            movel %d2,%sp@-
  e:   61ff 0000 0000  bsrl 10 <board_init_f_init_reserve+0x10>
 14:   2f02            movel %d2,%sp@-
 16:   61ff 0000 0000  bsrl 18 <board_init_f_init_reserve+0x18>
 1c:   0682 0000 00c0  addil #192,%d2
 22:   4fef 0010       lea %sp@(16),%sp
 26:   2047            moveal %d7,%a0
 28:   2142 00a0       movel %d2,%a0@(160)
 2c:   241f            movel %sp@+,%d2
 2e:   4e75            rts

But when I disassemble the final linked u-boot output:

0000f646 <board_init_f_init_reserve>:
   f646:       2f02            movel %d2,%sp@-
   f648:       242f 0008       movel %sp@(8),%d2
   f64c:       4878 00c0       pea c0 <_vectors+0xc0>
   f650:       42a7            clrl %sp@-
   f652:       2f02            movel %d2,%sp@-
   f654:       61ff 0001 44da  bsrl 23b30 <_etext+0x138>
   f65a:       2f02            movel %d2,%sp@-
   f65c:       61ff ffff ffd2  bsrl f630 <arch_setup_gd>
   f662:       0682 0000 00c0  addil #192,%d2
   f668:       4fef 0010       lea %sp@(16),%sp
   f66c:       2047            moveal %d7,%a0
   f66e:       2142 00a0       movel %d2,%a0@(160)
   f672:       241f            movel %sp@+,%d2
   f674:       4e75            rts

Note the pea c0 instruction.  The object file has
board_init_f_init_reserve+0xc0 as the argument, but the final linker has
0xc0, meaning board_init_f_init_reserve is being set to 0 after linking.

Also, note the first bsrl instruction, which is not setup correctly
either.  This is a call to memset.  This points to _etext+0x138, which is
not a code region Note that 0x239f8 + 0x138 = 0x23b30.  But in the final
uboot, memset is at 0x1f030.

In the call to memset(),  objdump shows the relocation:

RELOCATION RECORDS FOR [.text.board_init_f_init_reserve]:
OFFSET   TYPE              VALUE
00000010 R_68K_PLT32       memset
00000018 R_68K_PLT32       arch_setup_gd

So it seems only when linking outside the same compilation unit that the
relocations aren't set correctly.

I'm not sure where to look for a solution.  Or how to search for an
answer.  I've done some digging on Google, but nothing points to a clear
answer.  Anyone seen something similar?

To love for the sake of being loved is human, but to love for the sake of
loving is angelic. -- Alphonse de Lamartine.


On Thu, Jul 25, 2024 at 14:35 Peter LaDow <pladow@gmail.com> wrote:
>
> I'm trying to add support for a custom Colfire based board.  I have
> things building, but the final linked vectors in start.S do not point
> to _start.  In start.S I have:
>
> _vectors:
> .long   0x00000000              /* Flash offset is 0 until we setup CS0 */
> .long   _START
>
> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
>
> Dumping the symbols in the final u-boot yields:
>
> $ m68k-linux-gnu-nm -n u-boot
> 00000000 A __fixup_entries
> 00000000 A __got2_entries
> 00000000 t _vectors
> 00000400 T _start
> 0000047e T relocate_code
> 000004ae t fixloop
>
> But then dumping the raw binary:
>
> u-boot:     file format elf32-m68k
>
> Contents of section .text:
> 00000 00000000 00000000 00000516 00000516  ................
> 00010 00000516 00000516 00000516 00000516  ................
> 00020 00000516 00000516 00000516 00000516  ................
> 00030 00000516 00000516 00000516 00000516  ................
>
> Note at offset 4 it is 0x00000000, not 0x00000400 as I'd expect.
>
> The final linker script has:
>
> OUTPUT_ARCH(m68k)
> ENTRY(_start)
> SECTIONS
> {
> .text :
> {
>  arch/m68k/cpu/mcf548x/start.o (.text*)
>  . = DEFINED(env_offset) ? env_offset : .; env/embedded.o(.text*);
>  *(.text*)
> }
>
>
> It is difficult to search the archives, and so far I haven't found
> anything.  Any help would be appreciated.
>
> --
> To love for the sake of being loved is human, but to love for the sake
> of loving is angelic. -- Alphonse de Lamartine.
