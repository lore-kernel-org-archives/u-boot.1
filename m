Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B14C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33327884A9;
	Fri, 26 Jul 2024 01:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TbBbP0S3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EB98882E6; Thu, 25 Jul 2024 23:35:35 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEC5D87EEE
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 23:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pladow@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70d28023accso311353b3a.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 14:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721943331; x=1722548131; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OBqUSPJAOGquRHXXm/sHwU2t9FmPvkAApu6/CSJLDOs=;
 b=TbBbP0S30qaWX3ySHW89UNPlBCaWoctJqgsvvmxGKhJ3UinRJpZSUp1sXLkv06sIim
 ERnyYpqTy0fiFgKXmGUtd74IXwOSTzbV9mGVPJfjR6TZKw6laGCu1zGA7JHTVkr1peXM
 N9Np7hYx0CDPeNk1ua4lInRsEGq04TnUWDwqQJgvqo00P2XaJGTix0wM+k8OWf8lI0Ob
 vIHqQj941b0QGJWAZCcAknNoH70mvDmkBHrCJ5kxkoO9o61A819+uxPF/Oeg2e2Y2eIy
 KdMsE5AqOdzUhZR4imYACc24k/S9/wAIz4DxwiGO55a54t075v1ZtldsFM6Mq4XyCLfX
 H3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721943331; x=1722548131;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OBqUSPJAOGquRHXXm/sHwU2t9FmPvkAApu6/CSJLDOs=;
 b=a2Wlfhoc5TROosAYKuslM5QSfmaTLh/hrod9/hS3bhc6hXUBXKRUDY6M6tqfmUDmtH
 Zo0Q9JhQYOxJHna5Xre4aDlADF+yMl2xQJ99giCmX+tEYes6Ra/XshXNW+YjXzPY73zF
 ptZJR9bnVQrsiGWpOSPl3JnHwin9IffaU3I4x0V/pdMvJc1iQgJPm5SshFlIy3quHsZs
 Os33Wrt6NloyrLnQYInpG9zB1Ub+tUgeh48zgl+nK20P028DLBm6VfTlDOyZ6S+jm4Ka
 zqlrWBwpIl9xrMKpzkTScDyWSvAfS+156o68DpsDhfeW9DxAAUecWWkocIVW/UG3m0En
 BFZg==
X-Gm-Message-State: AOJu0Yw/kAyAqyfYmwEA4YYakDGSIdiKT29AIQVZNySOFq538gigwUE0
 PdKFW9Rm3JYse/i7hhQKPGEozbt4/iZp0dU8XvYQpF7JC2/iO+nDTTKeFTTuYeYbSmEXcmm9JVa
 AXjL2DyWHxmCma2b0d5KrjLaw7px1jWao
X-Google-Smtp-Source: AGHT+IHFiWJ3bbLHJF9JUqJWuoZQopaZJ4u90tFhl3ZgCbaA2CFHEMZaa5hNu/87GLDDYY050+YoM2tFFH8yv+Q5k9I=
X-Received: by 2002:a05:6a20:8411:b0:1c2:8cdf:c603 with SMTP id
 adf61e73a8af0-1c47b4e22b9mr4132637637.54.1721943331116; Thu, 25 Jul 2024
 14:35:31 -0700 (PDT)
MIME-Version: 1.0
From: Peter LaDow <pladow@gmail.com>
Date: Thu, 25 Jul 2024 14:35:19 -0700
Message-ID: <CAN8Q1EeO0C-LcC1jC=XYZM3RbFbs6sUtjbR===VUe6FYe5Utrw@mail.gmail.com>
Subject: M68K Vectors
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 26 Jul 2024 01:54:25 +0200
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

I'm trying to add support for a custom Colfire based board.  I have
things building, but the final linked vectors in start.S do not point
to _start.  In start.S I have:

_vectors:
.long   0x00000000              /* Flash offset is 0 until we setup CS0 */
.long   _START

.long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
.long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
.long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT

Dumping the symbols in the final u-boot yields:

$ m68k-linux-gnu-nm -n u-boot
00000000 A __fixup_entries
00000000 A __got2_entries
00000000 t _vectors
00000400 T _start
0000047e T relocate_code
000004ae t fixloop

But then dumping the raw binary:

u-boot:     file format elf32-m68k

Contents of section .text:
00000 00000000 00000000 00000516 00000516  ................
00010 00000516 00000516 00000516 00000516  ................
00020 00000516 00000516 00000516 00000516  ................
00030 00000516 00000516 00000516 00000516  ................

Note at offset 4 it is 0x00000000, not 0x00000400 as I'd expect.

The final linker script has:

OUTPUT_ARCH(m68k)
ENTRY(_start)
SECTIONS
{
.text :
{
 arch/m68k/cpu/mcf548x/start.o (.text*)
 . = DEFINED(env_offset) ? env_offset : .; env/embedded.o(.text*);
 *(.text*)
}


It is difficult to search the archives, and so far I haven't found
anything.  Any help would be appreciated.

-- 
To love for the sake of being loved is human, but to love for the sake
of loving is angelic. -- Alphonse de Lamartine.
