Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2D9C52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 16:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E637188842;
	Tue, 13 Aug 2024 18:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J0NSmZao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 461BF8895B; Tue, 13 Aug 2024 18:02:23 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AE748800C
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 18:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pladow@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70d2b921cd1so5244922b3a.1
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723564939; x=1724169739; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=inOEOCnr7bXoX7dNttJtD1C+6O8yagYccv6pBIcCiwU=;
 b=J0NSmZaof5DYtEs4hnlPVUrmy6Z5lLvkgEK9LBD6hm+zdglSOtASpqPkDBIfq6v8Ph
 ciM+xSAFedxQEwQmIHp85KtkvYCU3p8atXKU9rWD91xwibRO52UYldOg0xCbibloKjdy
 Am7ZPGvbyybs5/XmZjmiBPRWHEryekDc2UwZcaM7dSDxFUhvTYxR4XVDeDA/68lLolvq
 u0F9X+c7/bZ9PIhwhIqLN4lScZuw/oJdnYh3tuQFwPrQjRxpUJNO1pbSkAK+aO5jdsng
 lmaSwbgyjCsEjd1Voj0odEAUuby4YW64uR9A69v3fsEnkRqdM2nLVI7jSQUrOTm8wzQX
 Rhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723564939; x=1724169739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=inOEOCnr7bXoX7dNttJtD1C+6O8yagYccv6pBIcCiwU=;
 b=R6kAp0MT+y1yAoBWPMkCwzZ2ucgvWg/GaSYjlWovtum36yALtmatLbYJj4jNAS4Xsn
 olhoDbcK7MIZYUXumfoIUulHfbFPbExrWMzfjWUuqvuT2TJVqP1bL7YdddFnq+7D8ZyQ
 ddxiNSt8O6Yi4LMY5m6JKQFVUdvvO3XF5wMBVD8Qy5j0/uuHzpF3SCc0LMhXtcBHkVyg
 11ckRF8zW2kj1qyWYJtGRm9brn1SCav98Edjyj1DR/i/AK4wGEcCpECYYvIqi136DHGL
 L7wpe1h7aoX9lAf59Y3j3YxY33zUbd09enDW94dpEQIZMep5qIdOYgNHGDvuCoUI0ryg
 G+aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIlWayJzTUbtKMz2emI+te3WaDKZUvGdrb6vjCJhmlR87kme43f2AcmtcFRp3oq4ACvGqA/DubMTGOz7Z77bAw/I6ohA==
X-Gm-Message-State: AOJu0YynASbkZyAa/PxbfoSigI0T8E2MJZ8CAz5LNVzH7iqthlCdHiBG
 PLBArdfYjV2AdKTpZYRl5n3u3h8qV0v+qTpOJKEc2gNjJzxXPM55ucYvZIowJEINwWwj97b53xf
 UcuuYM120RFnwqlGlRCjXKbZCf8+E+a6v
X-Google-Smtp-Source: AGHT+IEyablc/YRY//Yl//Djvfsbpa/b8F2PNNwdidhEoMF+fcmCRG9AqFkp1ULaswcV8anYHGnqHQtV2OveBDi+Yok=
X-Received: by 2002:a17:902:db0e:b0:1fd:9fd8:1b2f with SMTP id
 d9443c01a7336-201ca185a29mr47377275ad.8.1723564939263; Tue, 13 Aug 2024
 09:02:19 -0700 (PDT)
MIME-Version: 1.0
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
 <6e3ddc2a-3c7b-4e45-a4a3-99bba6a792fb@kernel-space.org>
 <CAN8Q1EfugCvbfcNTCAJgOX65UCY=oJpTTuFLuB=nVYowmjioTA@mail.gmail.com>
In-Reply-To: <CAN8Q1EfugCvbfcNTCAJgOX65UCY=oJpTTuFLuB=nVYowmjioTA@mail.gmail.com>
From: Peter LaDow <pladow@gmail.com>
Date: Tue, 13 Aug 2024 09:02:07 -0700
Message-ID: <CAN8Q1EfivAmTt4WHN23sgOFT+LF8dWrX_91zQjMRp3hRN+CARg@mail.gmail.com>
Subject: Re: M68K Vectors
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: Huan Wang <alison.wang@nxp.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Ok, I worked through the binutils team and identified a few changes to
get things to link correctly.

The 548x cpu target creates PLT relocations (so does the 53015 target,
as used on the stmark2 and amcore configs).  Apparently, these rely
upon the loader to resolve the entries in the PLT table.  Other
targets (such as 5272) do not use PLT.  This is unclear to me, but
sounds like it is GCC related.

So, they suggested the following changes.  They work and I get proper
linking (sort of, see below).  There are two changes:

arch/m68k/Makefile:
-cpuflags-$(CONFIG_MCF5441x)    := -mcpu=54418 -fPIC
+cpuflags-$(CONFIG_MCF5441x)    := -mcpu=54418 -fPIE -fvisibility=hidden

include/asm-generic/sections.h:
-extern void _start(void);
+extern void _start(void) __attribute__((visibility("hidden")));

This works well for my setup with my board booting via the FlexBus
with Flash mapped at address 0x0.  I get the vectors properly mapped
and the calls to functions correctly linked (not through the PLT).

For the stmark2 and amcore, I don't think things are quite right;
either with or without the above tweaks.

The builds for amcore, this uses the 5307 target.  This creates GOT160
relocations, which work.It sets up A5 and uses GOT160 relocations.
However, the _start vector is incorrect.  The build on master for
amcore produces:

u-boot:     file format elf32-m68k

Contents of section .text:
ffc00000 00000000 00000000 ffc0051a ffc0051a  ................

Note that at 0xfc000004, the reset vector, points to 0x00000000.  That
can't be right.  But if I put the hidden visibility attribute on
_start in sections.h, I get:

u-boot:     file format elf32-m68k

Contents of section .text:
ffc00000 00000000 ffc00400 ffc0051a ffc0051a  ................
ffc00010 ffc0051a ffc0051a ffc0051a ffc0051a  ................

Which looks correct; _start is indeed at 0xfc000400:

$ /opt/toolchains/m68k/gcc-14.1.0-nolibc/m68k-linux/bin/m68k-linux-nm -n u
-boot
...
ffc00400 t _start

This solution works for all Coldfire platforms.

But the 548x has the other issue of the PLT table.   But the stmark2
is closer to the 548x in this regard.  If I compile the stmark2 from
master, and look at board_init_f_init_reserve:

47e0acbc <board_init_f_init_reserve>:
47e0acbc:       2f02            movel %d2,%sp@-
47e0acbe:       242f 0008       movel %sp@(8),%d2
47e0acc2:       4878 00d0       pea d0 <__fixup_entries+0xd0>
47e0acc6:       42a7            clrl %sp@-
47e0acc8:       2f02            movel %d2,%sp@-
47e0acca:       61ff 0001 4e4c  bsrl 47e1fb18 <.plt+0x2d0>

Note the branch to .plt + 0x2d0.  This is the PLT table.  But the PLT
table hasn't been fixed up, nor does it contain a call to the loader.
This can't work without the PLT table fixed up.

But if I turn on -fvisibility=hidden:

47e0ac1a <board_init_f_init_reserve>:
47e0ac1a:       2f02            movel %d2,%sp@-
47e0ac1c:       242f 0008       movel %sp@(8),%d2
47e0ac20:       4878 00d0       pea d0 <__fixup_entries+0xd0>
47e0ac24:       42a7            clrl %sp@-
47e0ac26:       2f02            movel %d2,%sp@-
47e0ac28:       61ff 0001 29f6  bsrl 47e1d620 <memset>

Note here the call is directly to memset:

$ /opt/toolchains/m68k/gcc-14.1.0-nolibc/m68k-linux/bin/m68k-linux-nm -n u
-boot
47e1d620 t memset

So, while I'm happy to contribute support for the 548x, I'm not sure
how to reconcile this with the other Coldfire boards.

I can't find the vendor for STMark2 or AMCore.  I'd like to look at
their documentation.  I don't know how these boot or how these
generated binaries could work.

Thanks,
Pete

--
To love for the sake of being loved is human, but to love for the sake
of loving is angelic. -- Alphonse de Lamartine.
