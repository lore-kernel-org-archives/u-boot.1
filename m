Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183DFD2FFFD
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 12:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9996489145;
	Fri, 18 Oct 2024 14:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YHpGxJa6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB97089289; Fri, 18 Oct 2024 09:39:35 +0200 (CEST)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AA8D88E65
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 09:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aibaykaro@gmail.com
Received: by mail-yb1-xb43.google.com with SMTP id
 3f1490d57ef6-e291cbbf05bso1933455276.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 00:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729237172; x=1729841972; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gm264xFIuNPcLNlrCrdS/TbJhZ6SVWv3qL9FJr3euUE=;
 b=YHpGxJa6ZcLPZv0hy61UqjtZIRAbJGZsbr4qy69NDKf8c+8wg2mCIs/LaMc229kK4+
 Y+BoxzUcPvXZZ9u/iQs1VefkSJKx8KNcFT0vRdrfnbO/+tDe9S7mWb2j2wFVEbm6oTLq
 In7Z+iC+oVf0dUJ/+9b+fPhhVsz+4Zhw5OgCMBroLsY2sbPeYum361Cbr3MuWRU5BRc1
 ViopiL9Qkc41DAvthZ/vOqrg5A2UQOhfCVNKhwKsawoOB2u0cd6REuIWF80SBo8B6+h1
 oBXAvsU10XNH5addo4W/qNdXtCBcrDZ47ax2/KeLtAX4K6AHsUpGFbb3f4xcznpSeZYp
 E9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729237172; x=1729841972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gm264xFIuNPcLNlrCrdS/TbJhZ6SVWv3qL9FJr3euUE=;
 b=mlInI+JcKBHoPookDeki+8ug/aVIczJxx02hJC5Yy3Zdwrk4nqDArKeEQ8IIM11UtJ
 zBV65NLzLHlalz5Kw/Mgt4gK4OH/NknF8wG6Z9YmIz5+/HNKhwQiRFRGwV+VIsh6f5/n
 Ffy/jPN77x5F1NmXnYakkGA5VkYI8sO3sUxqmWiC2wzf/wv8n4RRiOdekNI2B/NqydYy
 GI8gYVmHT4/aY1Q2GjLO2L4wLXO99QxsM3S5How6waHRVbaTKqbUkZf5HIc8DFlfhCRQ
 tx5dYMIw3hTIjrSo0ICQqfmP14q55/84MGoGa+53kvTXboza3e8ZhQZlLV3mAvEGFTpF
 mRIw==
X-Gm-Message-State: AOJu0YxbFaNph+vT9RthTRQG/RMwQVY4pmUgp9DBp4oy0I0x9Byrpni+
 KFdzMEmpV8oPuZxcSKB3mg7cfXRNUfgZvAqj4VIVCmXyDQ0PpTTeu/wT60GcUJBVNdT0dfdvwoZ
 ici2tarjPIDq5vb/vaK7JuXlhytt2K+EFEt8=
X-Google-Smtp-Source: AGHT+IEWISaG2kYvUVgeCxLaXMiGNwGG/GGbwC+DvQBJyE3TxsaeiVS2ZAdeT8sOoEgbTE9cMCSJ2WcANZkxQ3m43qU=
X-Received: by 2002:a25:60d4:0:b0:e2b:add4:cd2 with SMTP id
 3f1490d57ef6-e2bb1692a90mr1200122276.46.1729237171891; Fri, 18 Oct 2024
 00:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhyRsAMfYeMKVjGRLHM3DFymHxnxVO0YNM_2G=CYvGmTJoYNw@mail.gmail.com>
 <CAFLszTjnye2UYPxEQhGREuG-x5G3PA9ejAMSJi2SWZK_nz7m4w@mail.gmail.com>
 <CAMhyRsBwo2Km+7TroT9+j5zYsSFhs6O4MfqZJ2JSNE8yhvtquQ@mail.gmail.com>
 <CAMhyRsDi2d6PVvEcter3w4BaMt_58kFo5ZChhoVkYkeMSGoK3g@mail.gmail.com>
 <CAFLszTjBz16y=H+czO53QMB8mL_EOzzZ+vK3QFdS+pRCJ=YdrQ@mail.gmail.com>
In-Reply-To: <CAFLszTjBz16y=H+czO53QMB8mL_EOzzZ+vK3QFdS+pRCJ=YdrQ@mail.gmail.com>
From: Osman <aibaykaro@gmail.com>
Date: Fri, 18 Oct 2024 10:39:21 +0300
Message-ID: <CAMhyRsA4NuUOef9KY0axu_ZSVjE4dPRDa0UeiUM16UwMWU3OgQ@mail.gmail.com>
Subject: Re: ll_entry_count returns 0 even though the linker list has 5 entries
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 18 Oct 2024 14:32:49 +0200
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

Hello Simon,

I am not sure, the problem is with the rodata as the linker list looks fine
and execution finds the start and end of the list correctly. The wrong
thing is the size value it uses located at the rodata. This is the region
in u-boot-spl.lds that links the rodata:

. =3D ALIGN(4);
.rodata : {
*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
} > .spl_mem

I am not sure where it looks for the alignment of this value. Normally the
field which spl looks in rodata should contain the multiplicative inverse
of the size of struct driver and from what i can tell from assembly it is
shifted as well. Where does the linker look for the alignment of a value
like this?

Regards,
Osman

Simon Glass <sjg@chromium.org>, 18 Eki 2024 Cum, 02:18 tarihinde =C5=9Funu =
yazd=C4=B1:

> +U-Boot Mailing List
>
> On Thu, 17 Oct 2024 at 03:03, Osman <aibaykaro@gmail.com> wrote:
> >
> > Hello Simon,
> >
> > The problem is solved after enabling SPL_OPENSBI in my case, it would
> have been better if I knew the reason for it but I can't see how the link=
er
> list is related to opensbi configuration. Thank you for your time.
> >
> > By the way I made sure to try the spl by only disabling spl_opensbi
> configuration to make sure other changes are not affecting it but disabli=
ng
> really causes it to fail again.
>
> I wonder if this has something to do with alignment?
>
> Regards,
> Simon
>
>
> >
> > Regards,
> >
> > Osman
> >
> > Osman <aibaykaro@gmail.com>, 15 Eki 2024 Sal, 14:17 tarihinde =C5=9Funu
> yazd=C4=B1:
> >>
> >> Hi Simon,
> >>
> >> This is a 64 bit RISC-V platform, i don't have LINKER_LIST_ALIGN in my
> defconfig so it should be 4 by default however it's not a problem with
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
> >>
> >> u-boot-spl.map:
> >>  .rodata.cst8   0x0000000080007eb0        0x8 drivers/core/lists.o
> >>
> >>  and this is what i see while debugging:
> >>
> >>  (gdb) x /x 0x0000000080007eb0
> >> 0x80007eb0:     0x00000000
> >>
> >> it should be something like 0xEEEEEEEF for it to work correctly.
> >> Actually there are a lot of spaces that are filled with zeros is this
> normal?:
> >>
> >> (gdb) x /64w 0x0000000080007e60
> >> 0x80007e60:     0x69797254      0x7420676e      0x6f62206f
> 0x6620746f
> >> 0x80007e70:     0x206d6f72      0x000a7325      0x3a4c5053
> 0x736e5520
> >> 0x80007e80:     0x6f707075      0x64657472      0x6f6f4220
> 0x65442074
> >> 0x80007e90:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> 0x80007ea0:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> 0x80007eb0:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> 0x80007ec0:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> 0x80007ed0:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> 0x80007ee0:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> 0x80007ef0:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> 0x80007f00:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> 0x80007f10:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> 0x80007f20:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> 0x80007f30:     0x00000000      0x00000000      0x00000000
> 0x00000000
> >> 0x80007f40:     0x00000000      0x00000000      0x80007f48
> 0x00000000
> >> 0x80007f50:     0x80007f48      0x00000000      0x80007f48
> 0x00000000
> >>
> >> u-boot-spl.map:
> >>  .rodata.boot_from_devices.str1.8
> >>                 0x0000000080007e60       0x39 common/spl/spl.o
> >>  *fill*         0x0000000080007e99        0x7
> >>  .rodata.cst8   0x0000000080007ea0        0x8 common/spl/spl.o
> >>  .rodata.cst8   0x0000000080007ea8        0x8 lib/tiny-printf.o
> >>  .rodata.cst8   0x0000000080007eb0        0x8 drivers/core/lists.o
> >>  .rodata.devfdt_get_addr_index.str1.8
> >>                 0x0000000080007eb8        0x4 drivers/core/fdtaddr.o
> >>  .rodata.dm_extended_scan.str1.8
> >>                 0x0000000080007eb8       0x12 drivers/core/root.o
> >>                                          0x1a (size before relaxing)
> >>  *fill*         0x0000000080007eca        0x6
> >>  .rodata.do_reset.str1.8
> >>                 0x0000000080007ed0       0x29 arch/riscv/lib/reset.o
> >>  *fill*         0x0000000080007ef9        0x7
> >>  .rodata.fdt_address_cells.str1.8
> >>                 0x0000000080007f00        0xf lib/libfdt/fdt_addresses=
.o
> >>  *fill*         0x0000000080007f0f        0x1
> >>  .rodata.fdt_find_or_add_subnode.str1.8
> >>                 0x0000000080007f10        0xc common/fdt_support.o
> >>  *fill*         0x0000000080007f1c        0x4
> >>  .rodata.fdt_fixup_memory_banks.str1.8
> >>                 0x0000000080007f20       0x9c common/fdt_support.o
> >>  *fill*         0x0000000080007fbc        0x4
> >>  .rodata.fdt_get_alias_namelen.str1.8
> >>                 0x0000000080007fc0        0x9 lib/libfdt/fdt_ro.o
> >>
> >>  I am not sure what is happening here, is there a way to check how a
> specific rodata region is filled?
> >>
> >>  Regards,
> >>
> >>  Osman
>
