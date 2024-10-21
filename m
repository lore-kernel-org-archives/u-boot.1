Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EDED15D8A
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 13:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60C44885B3;
	Mon, 21 Oct 2024 15:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z9iFO88u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECB3D881C1; Mon, 21 Oct 2024 08:56:55 +0200 (CEST)
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 676A1892D0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 08:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aibaykaro@gmail.com
Received: by mail-yb1-xb44.google.com with SMTP id
 3f1490d57ef6-e0875f1e9edso3662333276.1
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 23:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729493812; x=1730098612; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=thhZq/LAgQ1wZeoS4ANjaBp42Z1Ib08kwu7rYBUdhOY=;
 b=Z9iFO88uwdswoonM4Z+Dz5r0emRKNQPG2fPDxmldQu+qx7eRfljT5I2mE32hxJaclK
 qHtv4qDU9yFBfFv2EWHu5gcQnD+kBQyQDW97TieyF4TvnZgUdSWPdOtXgVBZCLY8TVah
 B7U1KfKeF18x/PNZ5xH3ZPeyoQ+xT2dJoKLhARGtGVqLI9I/m0n+vyTOu6xLFiLSwCkN
 167G/oYgsoJ9RHEzroXDQ4KDUgwP8PK3jSK+IZTQF5qe69W6rBJI0eG3EOxETj2XML7o
 0FC+fQsGggr7Zz4zhYv7T38TFbKorlHgcxDVmT5dfGNj86q/XC3yKuo5CAMnIO6OTRFx
 gWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729493812; x=1730098612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=thhZq/LAgQ1wZeoS4ANjaBp42Z1Ib08kwu7rYBUdhOY=;
 b=oKV7Y6sB3hglzuUwl1twiLQWfrTZGGiwctHOveL8MqyHG2Ewwf/7685k/M6C1S/NZn
 dCj9W0Zx6zTOS1o9QTedTFsPRKPDkYz9xpfoa4rAiLxb5MhuWePJUcuLwj443bWanCAm
 kljjExsX/m6ojp9SqYD588+aMHCk3IJKU9udG1eL5ioMYFHX6rZYyLV+dlVpJrLO01Ko
 ftqfLrQ/vsvNYH05s2JwYWFooCh0DF2khsv3sDPZRD37ezgXTfyYGp0lZUsplyOjftEH
 3wlBK4xENA7lYuwmM9GVFwtT4fOwrReTf/6wJV05AIP5mIzpYHtSvt9fHt5NQJpG+I0O
 QQOA==
X-Gm-Message-State: AOJu0Yx8MT/8R94TPJ/tJ9NKUsNomkhLgQQFJK6V90LEh1w2pn2kmFoI
 JII6eDnH4auadRtLqyPSczH0B7wckT5oQUficqVMkSNIJq7023wG0dZfTRDhJiUEP/PbdnHQ3R5
 QcnMUgGRXPFaTszUaxw2S3rCFzz3xUDg1z40=
X-Google-Smtp-Source: AGHT+IGj+ZSXck97vjGsgcCILXALnuO3MYTfe5fGn5YbuUMxSzmWVXc9yzoEltfumIdu0FhMclcKXlFFeRePdhCOT88=
X-Received: by 2002:a05:6902:1b90:b0:e25:d51a:98ba with SMTP id
 3f1490d57ef6-e2bb11bb07dmr8902430276.7.1729493812087; Sun, 20 Oct 2024
 23:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhyRsAMfYeMKVjGRLHM3DFymHxnxVO0YNM_2G=CYvGmTJoYNw@mail.gmail.com>
 <CAFLszTjnye2UYPxEQhGREuG-x5G3PA9ejAMSJi2SWZK_nz7m4w@mail.gmail.com>
 <CAMhyRsBwo2Km+7TroT9+j5zYsSFhs6O4MfqZJ2JSNE8yhvtquQ@mail.gmail.com>
 <CAMhyRsDi2d6PVvEcter3w4BaMt_58kFo5ZChhoVkYkeMSGoK3g@mail.gmail.com>
 <CAFLszTjBz16y=H+czO53QMB8mL_EOzzZ+vK3QFdS+pRCJ=YdrQ@mail.gmail.com>
 <CAMhyRsA4NuUOef9KY0axu_ZSVjE4dPRDa0UeiUM16UwMWU3OgQ@mail.gmail.com>
 <CAFLszTi+vQ5r4HvqoKkY5RjRwRcB2RZ1-nRO5BXgZCA5ydipNA@mail.gmail.com>
In-Reply-To: <CAFLszTi+vQ5r4HvqoKkY5RjRwRcB2RZ1-nRO5BXgZCA5ydipNA@mail.gmail.com>
From: Osman <aibaykaro@gmail.com>
Date: Mon, 21 Oct 2024 09:56:40 +0300
Message-ID: <CAMhyRsA3CFknDvfW_wb37cFyp9LezAdx+ZNoeVtK8pb7Csx=_A@mail.gmail.com>
Subject: Re: ll_entry_count returns 0 even though the linker list has 5 entries
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 21 Oct 2024 15:02:15 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

I have digged on this a bit while debugging and this is the disassembled
version of the ll_entry_count:

1 auipc   s1,0x4
2 addi    s1,s1,-436
3 sub     s1,s1,s2
4 srai    s1,s1,0x3
5 auipc   a5,0x2
6 ld      a5,-228(a5)
7 mulw    s1,s1,a5

For explanation s2 contains the start of the linker list and the s1
contains the end of it so at line 3 it calculates the end-start as 0x258
which is correct in my case (0x80006620 =E2=88=92 0x800063c8). From there i=
t gets a
bit interesting cause it shifts that value to right by 3 in line 4, from
there it makes a load operation (line 5-6) at 0x80005768 which corresponds
to this location in generated .map file:

.rodata.cst8   0x0000000080005768        0x8 drivers/core/lists.o

Since i know the size of the linker list by looking at the .map file i made
the calculation myself, 0x258 shifted right 3 times becomes 0x4b and to
make the calculation correct size of the struct driver must be shifted as
well which is 0x78>>3 =3D F. Since this is the multiplicative inverse the
final value should be something like 0xeeeeeeeeeeeeeeef but the value in
that section was just 0x0. From there i was a bit clueless to be honest i
am not sure what makes it filled with zeros instead of the actual number, i
made a simple c code to test it out myself but it didn't generate the same
assembly lines. I know that declaring CONFIG_SPL_OPENSBI just adds the
spl_opensbi.c file but I couldn't figure out how it is related to this,
that file doesn't even use linker_lists.h. In the end I left it at that
since there weren't any more clues. By the way, I looked at the .map file
to see what adding opensbi adds to the symbols but those symbols are after
the address in question so I couldn't make much sense of it. So that's it,
thank you for your time and have a nice day.

Best Regards,

Osman


Simon Glass <sjg@chromium.org>, 18 Eki 2024 Cum, 17:55 tarihinde =C5=9Funu =
yazd=C4=B1:

> Hi Osman,
>
> On Fri, 18 Oct 2024 at 01:39, Osman <aibaykaro@gmail.com> wrote:
> >
> > Hello Simon,
> >
> > I am not sure, the problem is with the rodata as the linker list looks
> fine and execution finds the start and end of the list correctly. The wro=
ng
> thing is the size value it uses located at the rodata. This is the region
> in u-boot-spl.lds that links the rodata:
> >
> > . =3D ALIGN(4);
> > .rodata : {
> > *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
> > } > .spl_mem
> >
> > I am not sure where it looks for the alignment of this value. Normally
> the field which spl looks in rodata should contain the multiplicative
> inverse of the size of struct driver and from what i can tell from assemb=
ly
> it is shifted as well. Where does the linker look for the alignment of a
> value like this?
>
> This is something of a mystery to me as well. I did dig into it quite
> a lot at one point and recall some alignment settings on both input
> and output sections. But the strange thing about your case is that it
> seems that ll_entry_start() and ll_entry_end() are correct but
> ll_entry_count() is not. That is the particular situation that I
> believe you could debug, to understand what is happening.
>
>
> >
> > Regards,
> > Osman
> >
> > Simon Glass <sjg@chromium.org>, 18 Eki 2024 Cum, 02:18 tarihinde =C5=9F=
unu
> yazd=C4=B1:
> >>
> >> +U-Boot Mailing List
> >>
> >> On Thu, 17 Oct 2024 at 03:03, Osman <aibaykaro@gmail.com> wrote:
> >> >
> >> > Hello Simon,
> >> >
> >> > The problem is solved after enabling SPL_OPENSBI in my case, it woul=
d
> have been better if I knew the reason for it but I can't see how the link=
er
> list is related to opensbi configuration. Thank you for your time.
> >> >
> >> > By the way I made sure to try the spl by only disabling spl_opensbi
> configuration to make sure other changes are not affecting it but disabli=
ng
> really causes it to fail again.
> >>
> >> I wonder if this has something to do with alignment?
> >>
> >> Regards,
> >> Simon
> >>
> >>
> >> >
> >> > Regards,
> >> >
> >> > Osman
> >> >
> >> > Osman <aibaykaro@gmail.com>, 15 Eki 2024 Sal, 14:17 tarihinde =C5=9F=
unu
> yazd=C4=B1:
> >> >>
> >> >> Hi Simon,
> >> >>
> >> >> This is a 64 bit RISC-V platform, i don't have LINKER_LIST_ALIGN in
> my defconfig so it should be 4 by default however it's not a problem with
> linker list alignment i suppose. After debugging it in assembly I found o=
ut
> that it successfully calculates the length between the start and end of t=
he
> linker list, it just divides incorrectly because the inverse value of the
> size of struct driver is wrong. The rodata section which contains that si=
ze
> value is filled with zeros. For reference this is the location it looks f=
or
> the size value:
> >> >>
> >> >> u-boot-spl.map:
> >> >>  .rodata.cst8   0x0000000080007eb0        0x8 drivers/core/lists.o
> >> >>
> >> >>  and this is what i see while debugging:
> >> >>
> >> >>  (gdb) x /x 0x0000000080007eb0
> >> >> 0x80007eb0:     0x00000000
> >> >>
> >> >> it should be something like 0xEEEEEEEF for it to work correctly.
> >> >> Actually there are a lot of spaces that are filled with zeros is
> this normal?:
> >> >>
> >> >> (gdb) x /64w 0x0000000080007e60
> >> >> 0x80007e60:     0x69797254      0x7420676e      0x6f62206f
> 0x6620746f
> >> >> 0x80007e70:     0x206d6f72      0x000a7325      0x3a4c5053
> 0x736e5520
> >> >> 0x80007e80:     0x6f707075      0x64657472      0x6f6f4220
> 0x65442074
> >> >> 0x80007e90:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> >> 0x80007ea0:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> >> 0x80007eb0:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> >> 0x80007ec0:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> >> 0x80007ed0:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> >> 0x80007ee0:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> >> 0x80007ef0:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> >> 0x80007f00:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> >> 0x80007f10:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> >> 0x80007f20:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> >> 0x80007f30:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> >> 0x80007f40:     0x00000000      0x00000000      0x80007f48
> 0x00000000
> >> >> 0x80007f50:     0x80007f48      0x00000000      0x80007f48
> 0x00000000
> >> >>
> >> >> u-boot-spl.map:
> >> >>  .rodata.boot_from_devices.str1.8
> >> >>                 0x0000000080007e60       0x39 common/spl/spl.o
> >> >>  *fill*         0x0000000080007e99        0x7
> >> >>  .rodata.cst8   0x0000000080007ea0        0x8 common/spl/spl.o
> >> >>  .rodata.cst8   0x0000000080007ea8        0x8 lib/tiny-printf.o
> >> >>  .rodata.cst8   0x0000000080007eb0        0x8 drivers/core/lists.o
> >> >>  .rodata.devfdt_get_addr_index.str1.8
> >> >>                 0x0000000080007eb8        0x4 drivers/core/fdtaddr.=
o
> >> >>  .rodata.dm_extended_scan.str1.8
> >> >>                 0x0000000080007eb8       0x12 drivers/core/root.o
> >> >>                                          0x1a (size before relaxing=
)
> >> >>  *fill*         0x0000000080007eca        0x6
> >> >>  .rodata.do_reset.str1.8
> >> >>                 0x0000000080007ed0       0x29 arch/riscv/lib/reset.=
o
> >> >>  *fill*         0x0000000080007ef9        0x7
> >> >>  .rodata.fdt_address_cells.str1.8
> >> >>                 0x0000000080007f00        0xf
> lib/libfdt/fdt_addresses.o
> >> >>  *fill*         0x0000000080007f0f        0x1
> >> >>  .rodata.fdt_find_or_add_subnode.str1.8
> >> >>                 0x0000000080007f10        0xc common/fdt_support.o
> >> >>  *fill*         0x0000000080007f1c        0x4
> >> >>  .rodata.fdt_fixup_memory_banks.str1.8
> >> >>                 0x0000000080007f20       0x9c common/fdt_support.o
> >> >>  *fill*         0x0000000080007fbc        0x4
> >> >>  .rodata.fdt_get_alias_namelen.str1.8
> >> >>                 0x0000000080007fc0        0x9 lib/libfdt/fdt_ro.o
> >> >>
> >> >>  I am not sure what is happening here, is there a way to check how =
a
> specific rodata region is filled?
> >> >>
> >> >>  Regards,
> >> >>
> >> >>  Osman
>
