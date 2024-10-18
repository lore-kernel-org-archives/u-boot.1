Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DE6D30017
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E58A8968D;
	Fri, 18 Oct 2024 16:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lCKMgYvb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10ECA89679; Fri, 18 Oct 2024 16:56:23 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5083891D6
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3e602994635so484889b6e.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263354; x=1729868154; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bL3EDYbrWuFW/WyWE4Pbk0gUIaAl7nESz/ZT4mTIffI=;
 b=lCKMgYvbk21NGNmUyrEBD5d7liZ+6QTdoBXAPGhbGVR6tbluhlzkNyD+5aUtzgrR94
 p2yidPV3jNLlfCp6lZdY/9IcR69JtbwcDQx4NR3jy/XWY7WnA63+Yknc3QoDvlvazWcO
 pjdc0NE2Zlj5fl2Bwx+LamEwERegFMFfg/mWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263354; x=1729868154;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bL3EDYbrWuFW/WyWE4Pbk0gUIaAl7nESz/ZT4mTIffI=;
 b=uWq5MC0k5c6sVuFpzKCASKeuZYeRWtwsaErKSJa1PrOHV4BZ0oHHgJKg/RgMBd4Ky8
 YpgDTakcWhsGqXnD3toD9i2wUUd0BUxO9MnRWgUMCkJ+k14Y34RA9YEclSVJDAC2w4MY
 Rf6G9k/oCxdoCMrXEkVcDju/kqUm8C1BGzENiSsISZDxEJzwwd0JB5jjKcG7v8jo+hP2
 tO2opd7EBNuI6u3xy6lUOrkCS7ef6q56qinJhtlibXRhfQWUjYXckbaskIQxHccancpa
 ZGMVa4W5NYk3r73MFGczDDvF4db1gn62PJkh8sb5idvhyTdTYecgrHwSwy3r10LQR6YZ
 DLNA==
X-Gm-Message-State: AOJu0Ywku4n7QCuWDYtsHoItS0DB+3mQfResA4bCMY+5BVhJoUIbnVHM
 G2YZbUG+F9vCl4pTOdpfpp+gWJhswF/L44n5h6RBese+lWrmiD73S4HQEydhGVxUDv5IneY3TMg
 FfrrSRa0v1zoB9Ydmi5ddhrPGPJwNK3bz1TS4NcDwx0ATbrU=
X-Google-Smtp-Source: AGHT+IGP8+80S9MKwB9bnMtUSOF70Vvnabqvct4bR3RYsD8h/cfdgSeHJoESNFrc7e2gWKOHzq+gUjNNiQP96fx6tlQ=
X-Received: by 2002:a05:6808:15a6:b0:3e0:4558:612f with SMTP id
 5614622812f47-3e602da2a25mr3129782b6e.36.1729263353690; Fri, 18 Oct 2024
 07:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhyRsAMfYeMKVjGRLHM3DFymHxnxVO0YNM_2G=CYvGmTJoYNw@mail.gmail.com>
 <CAFLszTjnye2UYPxEQhGREuG-x5G3PA9ejAMSJi2SWZK_nz7m4w@mail.gmail.com>
 <CAMhyRsBwo2Km+7TroT9+j5zYsSFhs6O4MfqZJ2JSNE8yhvtquQ@mail.gmail.com>
 <CAMhyRsDi2d6PVvEcter3w4BaMt_58kFo5ZChhoVkYkeMSGoK3g@mail.gmail.com>
 <CAFLszTjBz16y=H+czO53QMB8mL_EOzzZ+vK3QFdS+pRCJ=YdrQ@mail.gmail.com>
 <CAMhyRsA4NuUOef9KY0axu_ZSVjE4dPRDa0UeiUM16UwMWU3OgQ@mail.gmail.com>
In-Reply-To: <CAMhyRsA4NuUOef9KY0axu_ZSVjE4dPRDa0UeiUM16UwMWU3OgQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 08:55:43 -0600
Message-ID: <CAFLszTi+vQ5r4HvqoKkY5RjRwRcB2RZ1-nRO5BXgZCA5ydipNA@mail.gmail.com>
Subject: Re: ll_entry_count returns 0 even though the linker list has 5 entries
To: Osman <aibaykaro@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Osman,

On Fri, 18 Oct 2024 at 01:39, Osman <aibaykaro@gmail.com> wrote:
>
> Hello Simon,
>
> I am not sure, the problem is with the rodata as the linker list looks fi=
ne and execution finds the start and end of the list correctly. The wrong t=
hing is the size value it uses located at the rodata. This is the region in=
 u-boot-spl.lds that links the rodata:
>
> . =3D ALIGN(4);
> .rodata : {
> *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
> } > .spl_mem
>
> I am not sure where it looks for the alignment of this value. Normally th=
e field which spl looks in rodata should contain the multiplicative inverse=
 of the size of struct driver and from what i can tell from assembly it is =
shifted as well. Where does the linker look for the alignment of a value li=
ke this?

This is something of a mystery to me as well. I did dig into it quite
a lot at one point and recall some alignment settings on both input
and output sections. But the strange thing about your case is that it
seems that ll_entry_start() and ll_entry_end() are correct but
ll_entry_count() is not. That is the particular situation that I
believe you could debug, to understand what is happening.


>
> Regards,
> Osman
>
> Simon Glass <sjg@chromium.org>, 18 Eki 2024 Cum, 02:18 tarihinde =C5=9Fun=
u yazd=C4=B1:
>>
>> +U-Boot Mailing List
>>
>> On Thu, 17 Oct 2024 at 03:03, Osman <aibaykaro@gmail.com> wrote:
>> >
>> > Hello Simon,
>> >
>> > The problem is solved after enabling SPL_OPENSBI in my case, it would =
have been better if I knew the reason for it but I can't see how the linker=
 list is related to opensbi configuration. Thank you for your time.
>> >
>> > By the way I made sure to try the spl by only disabling spl_opensbi co=
nfiguration to make sure other changes are not affecting it but disabling r=
eally causes it to fail again.
>>
>> I wonder if this has something to do with alignment?
>>
>> Regards,
>> Simon
>>
>>
>> >
>> > Regards,
>> >
>> > Osman
>> >
>> > Osman <aibaykaro@gmail.com>, 15 Eki 2024 Sal, 14:17 tarihinde =C5=9Fun=
u yazd=C4=B1:
>> >>
>> >> Hi Simon,
>> >>
>> >> This is a 64 bit RISC-V platform, i don't have LINKER_LIST_ALIGN in m=
y defconfig so it should be 4 by default however it's not a problem with li=
nker list alignment i suppose. After debugging it in assembly I found out t=
hat it successfully calculates the length between the start and end of the =
linker list, it just divides incorrectly because the inverse value of the s=
ize of struct driver is wrong. The rodata section which contains that size =
value is filled with zeros. For reference this is the location it looks for=
 the size value:
>> >>
>> >> u-boot-spl.map:
>> >>  .rodata.cst8   0x0000000080007eb0        0x8 drivers/core/lists.o
>> >>
>> >>  and this is what i see while debugging:
>> >>
>> >>  (gdb) x /x 0x0000000080007eb0
>> >> 0x80007eb0:     0x00000000
>> >>
>> >> it should be something like 0xEEEEEEEF for it to work correctly.
>> >> Actually there are a lot of spaces that are filled with zeros is this=
 normal?:
>> >>
>> >> (gdb) x /64w 0x0000000080007e60
>> >> 0x80007e60:     0x69797254      0x7420676e      0x6f62206f      0x662=
0746f
>> >> 0x80007e70:     0x206d6f72      0x000a7325      0x3a4c5053      0x736=
e5520
>> >> 0x80007e80:     0x6f707075      0x64657472      0x6f6f4220      0x654=
42074
>> >> 0x80007e90:     0x00000000      0x00000000      0x00000000      0x000=
00000
>> >> 0x80007ea0:     0x00000000      0x00000000      0x00000000      0x000=
00000
>> >> 0x80007eb0:     0x00000000      0x00000000      0x00000000      0x000=
00000
>> >> 0x80007ec0:     0x00000000      0x00000000      0x00000000      0x000=
00000
>> >> 0x80007ed0:     0x00000000      0x00000000      0x00000000      0x000=
00000
>> >> 0x80007ee0:     0x00000000      0x00000000      0x00000000      0x000=
00000
>> >> 0x80007ef0:     0x00000000      0x00000000      0x00000000      0x000=
00000
>> >> 0x80007f00:     0x00000000      0x00000000      0x00000000      0x000=
00000
>> >> 0x80007f10:     0x00000000      0x00000000      0x00000000      0x000=
00000
>> >> 0x80007f20:     0x00000000      0x00000000      0x00000000      0x000=
00000
>> >> 0x80007f30:     0x00000000      0x00000000      0x00000000      0x000=
00000
>> >> 0x80007f40:     0x00000000      0x00000000      0x80007f48      0x000=
00000
>> >> 0x80007f50:     0x80007f48      0x00000000      0x80007f48      0x000=
00000
>> >>
>> >> u-boot-spl.map:
>> >>  .rodata.boot_from_devices.str1.8
>> >>                 0x0000000080007e60       0x39 common/spl/spl.o
>> >>  *fill*         0x0000000080007e99        0x7
>> >>  .rodata.cst8   0x0000000080007ea0        0x8 common/spl/spl.o
>> >>  .rodata.cst8   0x0000000080007ea8        0x8 lib/tiny-printf.o
>> >>  .rodata.cst8   0x0000000080007eb0        0x8 drivers/core/lists.o
>> >>  .rodata.devfdt_get_addr_index.str1.8
>> >>                 0x0000000080007eb8        0x4 drivers/core/fdtaddr.o
>> >>  .rodata.dm_extended_scan.str1.8
>> >>                 0x0000000080007eb8       0x12 drivers/core/root.o
>> >>                                          0x1a (size before relaxing)
>> >>  *fill*         0x0000000080007eca        0x6
>> >>  .rodata.do_reset.str1.8
>> >>                 0x0000000080007ed0       0x29 arch/riscv/lib/reset.o
>> >>  *fill*         0x0000000080007ef9        0x7
>> >>  .rodata.fdt_address_cells.str1.8
>> >>                 0x0000000080007f00        0xf lib/libfdt/fdt_addresse=
s.o
>> >>  *fill*         0x0000000080007f0f        0x1
>> >>  .rodata.fdt_find_or_add_subnode.str1.8
>> >>                 0x0000000080007f10        0xc common/fdt_support.o
>> >>  *fill*         0x0000000080007f1c        0x4
>> >>  .rodata.fdt_fixup_memory_banks.str1.8
>> >>                 0x0000000080007f20       0x9c common/fdt_support.o
>> >>  *fill*         0x0000000080007fbc        0x4
>> >>  .rodata.fdt_get_alias_namelen.str1.8
>> >>                 0x0000000080007fc0        0x9 lib/libfdt/fdt_ro.o
>> >>
>> >>  I am not sure what is happening here, is there a way to check how a =
specific rodata region is filled?
>> >>
>> >>  Regards,
>> >>
>> >>  Osman
