Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF76D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:20:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21FFA891D2;
	Fri, 18 Oct 2024 01:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n6NHih3n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE228891E3; Fri, 18 Oct 2024 01:18:40 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FE52890F3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbf347dc66so8167116d6.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207117; x=1729811917; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eudIa2BrVv1RTmDISSqPW6O9+T780Ko+3xdLnBGjJI0=;
 b=n6NHih3nphOaZ0kmJpQmTcxOg9UybKM4FhstNnd5svlQ/droB9h9uSw0aqdD+3E4zR
 ZG5biOeNDgF49Ng6LtLYaV7bKZob8Or+lGtwQY3/xnuUbM/tfemVgG3iyNKU5UYcOB+B
 a5Iy6p1YNWLCGe2fmo2/XH8wcwTdFKWmILEE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207117; x=1729811917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eudIa2BrVv1RTmDISSqPW6O9+T780Ko+3xdLnBGjJI0=;
 b=TFepeuZoKcDgwPMRrwZuTF3PRAo4Su0A46So3SKoyoWTDO9CXL/vL8V8U3khsUAscY
 /lLdDJ3/B+IjquKjjj8t7CJ2xrn+98gIFi76qw66ZmG8O9GtLIyfHyP8WInYf3CjsyBE
 WoWueyuZWcVKvGPLzuczCit1rdPTdu+gfnuggbcbb/S3MvRnos/uZIDG+kNLiBewicM/
 nIitsMndJQMWX6Lp61CYTRBN2uJoOlC0df7GPSpwz6doYhDcz5oQs02vSrpI1MvnzLeA
 M6MOuaJozr2VCMeCK2Ru6ZqGzdgBfwCiSslYMX6flYwvWQGBDTb+0Oy7+IrgC/PvCpNq
 +kzg==
X-Gm-Message-State: AOJu0YxQ4+PKa65opDe5r8hwaOK2gWIE6RujX7oKYtCCUHsEQZ6CUAXA
 LisJM/5QmIPFdCswcxHMuBlEkpgbq3EWpztlmSEMMWadf9NzwKZAlc0QblydEG1fPla+Q+Ez8RW
 yO6kopIC6SrrQfxYZyJc+gUHFT4A1vZeN1xyB4virk37Vv3g=
X-Google-Smtp-Source: AGHT+IFD8vF4jb6XX2dsJzC0PBBmgvLb2nsBMs0RV3VHxk+fio6t7IiVzl6a5wjv0QVbaj7mkI+pBxVfJz6LGr2okjA=
X-Received: by 2002:a05:6214:5b08:b0:6cb:e603:1c3a with SMTP id
 6a1803df08f44-6cde155e574mr6602366d6.25.1729207117524; Thu, 17 Oct 2024
 16:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhyRsAMfYeMKVjGRLHM3DFymHxnxVO0YNM_2G=CYvGmTJoYNw@mail.gmail.com>
 <CAFLszTjnye2UYPxEQhGREuG-x5G3PA9ejAMSJi2SWZK_nz7m4w@mail.gmail.com>
 <CAMhyRsBwo2Km+7TroT9+j5zYsSFhs6O4MfqZJ2JSNE8yhvtquQ@mail.gmail.com>
 <CAMhyRsDi2d6PVvEcter3w4BaMt_58kFo5ZChhoVkYkeMSGoK3g@mail.gmail.com>
In-Reply-To: <CAMhyRsDi2d6PVvEcter3w4BaMt_58kFo5ZChhoVkYkeMSGoK3g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Oct 2024 17:18:27 -0600
Message-ID: <CAFLszTjBz16y=H+czO53QMB8mL_EOzzZ+vK3QFdS+pRCJ=YdrQ@mail.gmail.com>
Subject: Re: ll_entry_count returns 0 even though the linker list has 5 entries
To: Osman <aibaykaro@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

+U-Boot Mailing List

On Thu, 17 Oct 2024 at 03:03, Osman <aibaykaro@gmail.com> wrote:
>
> Hello Simon,
>
> The problem is solved after enabling SPL_OPENSBI in my case, it would hav=
e been better if I knew the reason for it but I can't see how the linker li=
st is related to opensbi configuration. Thank you for your time.
>
> By the way I made sure to try the spl by only disabling spl_opensbi confi=
guration to make sure other changes are not affecting it but disabling real=
ly causes it to fail again.

I wonder if this has something to do with alignment?

Regards,
Simon


>
> Regards,
>
> Osman
>
> Osman <aibaykaro@gmail.com>, 15 Eki 2024 Sal, 14:17 tarihinde =C5=9Funu y=
azd=C4=B1:
>>
>> Hi Simon,
>>
>> This is a 64 bit RISC-V platform, i don't have LINKER_LIST_ALIGN in my d=
efconfig so it should be 4 by default however it's not a problem with linke=
r list alignment i suppose. After debugging it in assembly I found out that=
 it successfully calculates the length between the start and end of the lin=
ker list, it just divides incorrectly because the inverse value of the size=
 of struct driver is wrong. The rodata section which contains that size val=
ue is filled with zeros. For reference this is the location it looks for th=
e size value:
>>
>> u-boot-spl.map:
>>  .rodata.cst8   0x0000000080007eb0        0x8 drivers/core/lists.o
>>
>>  and this is what i see while debugging:
>>
>>  (gdb) x /x 0x0000000080007eb0
>> 0x80007eb0:     0x00000000
>>
>> it should be something like 0xEEEEEEEF for it to work correctly.
>> Actually there are a lot of spaces that are filled with zeros is this no=
rmal?:
>>
>> (gdb) x /64w 0x0000000080007e60
>> 0x80007e60:     0x69797254      0x7420676e      0x6f62206f      0x662074=
6f
>> 0x80007e70:     0x206d6f72      0x000a7325      0x3a4c5053      0x736e55=
20
>> 0x80007e80:     0x6f707075      0x64657472      0x6f6f4220      0x654420=
74
>> 0x80007e90:     0x00000000      0x00000000      0x00000000      0x000000=
00
>> 0x80007ea0:     0x00000000      0x00000000      0x00000000      0x000000=
00
>> 0x80007eb0:     0x00000000      0x00000000      0x00000000      0x000000=
00
>> 0x80007ec0:     0x00000000      0x00000000      0x00000000      0x000000=
00
>> 0x80007ed0:     0x00000000      0x00000000      0x00000000      0x000000=
00
>> 0x80007ee0:     0x00000000      0x00000000      0x00000000      0x000000=
00
>> 0x80007ef0:     0x00000000      0x00000000      0x00000000      0x000000=
00
>> 0x80007f00:     0x00000000      0x00000000      0x00000000      0x000000=
00
>> 0x80007f10:     0x00000000      0x00000000      0x00000000      0x000000=
00
>> 0x80007f20:     0x00000000      0x00000000      0x00000000      0x000000=
00
>> 0x80007f30:     0x00000000      0x00000000      0x00000000      0x000000=
00
>> 0x80007f40:     0x00000000      0x00000000      0x80007f48      0x000000=
00
>> 0x80007f50:     0x80007f48      0x00000000      0x80007f48      0x000000=
00
>>
>> u-boot-spl.map:
>>  .rodata.boot_from_devices.str1.8
>>                 0x0000000080007e60       0x39 common/spl/spl.o
>>  *fill*         0x0000000080007e99        0x7
>>  .rodata.cst8   0x0000000080007ea0        0x8 common/spl/spl.o
>>  .rodata.cst8   0x0000000080007ea8        0x8 lib/tiny-printf.o
>>  .rodata.cst8   0x0000000080007eb0        0x8 drivers/core/lists.o
>>  .rodata.devfdt_get_addr_index.str1.8
>>                 0x0000000080007eb8        0x4 drivers/core/fdtaddr.o
>>  .rodata.dm_extended_scan.str1.8
>>                 0x0000000080007eb8       0x12 drivers/core/root.o
>>                                          0x1a (size before relaxing)
>>  *fill*         0x0000000080007eca        0x6
>>  .rodata.do_reset.str1.8
>>                 0x0000000080007ed0       0x29 arch/riscv/lib/reset.o
>>  *fill*         0x0000000080007ef9        0x7
>>  .rodata.fdt_address_cells.str1.8
>>                 0x0000000080007f00        0xf lib/libfdt/fdt_addresses.o
>>  *fill*         0x0000000080007f0f        0x1
>>  .rodata.fdt_find_or_add_subnode.str1.8
>>                 0x0000000080007f10        0xc common/fdt_support.o
>>  *fill*         0x0000000080007f1c        0x4
>>  .rodata.fdt_fixup_memory_banks.str1.8
>>                 0x0000000080007f20       0x9c common/fdt_support.o
>>  *fill*         0x0000000080007fbc        0x4
>>  .rodata.fdt_get_alias_namelen.str1.8
>>                 0x0000000080007fc0        0x9 lib/libfdt/fdt_ro.o
>>
>>  I am not sure what is happening here, is there a way to check how a spe=
cific rodata region is filled?
>>
>>  Regards,
>>
>>  Osman
