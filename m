Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9B0CF34C4
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 15:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9968A88A24;
	Sat,  5 Oct 2024 17:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l3DSGWdw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A082188835; Sat,  5 Oct 2024 17:23:03 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B64F688A24
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 17:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c89bdb9019so3630188a12.0
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1728141780; x=1728746580;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDlZBjXmbCSe66kUHKn9bqR4tF4jVKVaj5oHwLG5wxs=;
 b=l3DSGWdwEmoOiru3kZQLlqMBvtCSYL1FQqxzwPjEFkyZJOerAqKqpvfMl+Qs7qO8CT
 QLl5nEwDZdLxheQJ23YoD6Sv3hzJr+E8qVbTpm39QXO/t+fO14/BLYMgQH7VqHsl54xI
 m5acl4xFQkqBZJ1E1JvumH+T4ncwT585w/aYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141780; x=1728746580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDlZBjXmbCSe66kUHKn9bqR4tF4jVKVaj5oHwLG5wxs=;
 b=j0lyu7JNHu7Y4PCquMcYWRtGoKb7zdUiQvqKcXTKLy6iaXBkObstK0TIawazkI5KZs
 Vf9nDQrRsC7zlVo25e7eg4j8cOsFEiqL7HydMZraA7QzhQCxKRwhUPY8JjV2NLXkLw/S
 tPOj4/OsLHnX4SKS5+sC+cf62KkLdMfrKmYcIGt2yD95sbgBsebTePTNKbCgmol5HGs3
 JtKLzNiRpYyzjaO2wyCxDB9BVeohm4iS5AwbcTFJB6DdAmN9rC7cUvXDr61pBEdxh4Ot
 iT0Qgv0B8zTpxEWJcT1aNtLkMZgGREd0mb3yCSrI/hGt5phwtJssEjbMRT08YcSjyDdh
 fgBA==
X-Gm-Message-State: AOJu0YyMUdDa7GZ2Q1nvrUkSXRINgYnyH8cgzh5dCwexQMQSUpx9PFQ5
 HIJk23yNbk/CGf68F0zi/zaBJ2THtDVJmtdtWg3jKzpf9wNG/Z5YGP3qbv1NSyqNhpP9GOx4m39
 xRRq1OnqB0VpbxVPE771jmiDF2l6RTkgTsWZ+hw==
X-Google-Smtp-Source: AGHT+IESv2aGTQOkWySz2fOjk/w29tO8ijHQ7iTCc8O1SRq3ODYyQqMoXN1wd3EU8/vBROzSC9tBNo8BxbgNfa4lYd4=
X-Received: by 2002:a05:6402:34d0:b0:5c5:cf0b:b515 with SMTP id
 4fb4d7f45d1cf-5c8d2dfbf13mr5052927a12.1.1728141780128; Sat, 05 Oct 2024
 08:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240919035512.13854-1-dinesh.maniyam@intel.com>
 <20240919035512.13854-17-dinesh.maniyam@intel.com>
In-Reply-To: <20240919035512.13854-17-dinesh.maniyam@intel.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 5 Oct 2024 17:22:48 +0200
Message-ID: <CAOf5uwk+CHPbGvLH=pjqbh1qiKg-xXMXFCP7iS9hXcHf9xDFmQ@mail.gmail.com>
Subject: Re: [PATCH 16/19] drivers: mtd: nand: spl: Add support for nand SPL
 load image
To: dinesh.maniyam@intel.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>, 
 Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Alexander Dahl <ada@thorsis.com>, William Zhang <william.zhang@broadcom.com>, 
 Igor Prusov <ivprusov@salutedevices.com>, Tien Fong <tien.fong.chee@intel.com>,
 Kok Kiang <kok.kiang.hea@intel.com>, Boon Khai <boon.khai.ng@intel.com>, 
 Alif <alif.zakuan.yuslaimi@intel.com>, Teik Heng <teik.heng.chong@intel.com>, 
 Hazim <muhammad.hazim.izzat.zamri@intel.com>, 
 Tingting Meng <tingting.meng@intel.com>, Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
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

Hi Dinesh

On Thu, Sep 19, 2024 at 5:56=E2=80=AFAM <dinesh.maniyam@intel.com> wrote:
>
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>
> This patch is add support for spl nand to load binary image from NAND
> to RAM.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> ---
>  drivers/mtd/nand/raw/cadence_spl.c | 96 ++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 drivers/mtd/nand/raw/cadence_spl.c
>
> diff --git a/drivers/mtd/nand/raw/cadence_spl.c b/drivers/mtd/nand/raw/ca=
dence_spl.c
> new file mode 100644
> index 0000000000..841801420d
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/cadence_spl.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier:     GPL-2.0
> +/*
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + */
> +
> +#include <cadence-nand.h>
> +#include <dm.h>
> +#include <hang.h>
> +#include <malloc.h>
> +#include <memalign.h>
> +#include <nand.h>
> +#include <linux/bitfield.h>
> +
> +int nand_spl_load_image(u32 offset, u32 len, void *dst)
> +{
> +       size_t count =3D len, actual =3D 0, page_align_overhead =3D 0;
> +       u32 page_align_offset =3D 0;
> +       u8 *page_buffer;
> +       int err =3D 0;
> +       struct mtd_info *mtd;
> +
> +       if (!len || !dst)
> +               return -EINVAL;
> +
> +       mtd =3D get_nand_dev_by_index(nand_curr_device);
> +       if (!mtd)
> +               hang();
> +
> +       if ((offset & (mtd->writesize - 1)) !=3D 0) {
> +               page_buffer =3D malloc_cache_aligned(mtd->writesize);
> +               if (!page_buffer) {
> +                       debug("Error: allocating buffer\n");
> +                       return -ENOMEM;
> +               }
> +
> +               page_align_overhead =3D offset % mtd->writesize;
> +               page_align_offset =3D (offset / mtd->writesize) * mtd->wr=
itesize;
> +               count =3D mtd->writesize;
> +
> +               err =3D nand_read_skip_bad(mtd, page_align_offset, &count=
,
> +                                        &actual, mtd->size, page_buffer)=
;
> +
> +               if (err) {
> +                       free(page_buffer);
> +                       return err;
> +               }
> +
> +               count -=3D page_align_overhead;
> +               count =3D min((size_t)len, count);
> +               memcpy(dst, page_buffer + page_align_overhead, count);
> +               free(page_buffer);
> +
> +               len -=3D count;
> +               if (!len)
> +                       return err;
> +
> +               offset +=3D count;
> +               dst +=3D count;
> +               count =3D len;
> +       }
> +
> +       return nand_read_skip_bad(mtd, offset, &count, &actual, mtd->size=
, dst);
> +}
> +

We should rethink that way we have nand_spl_load_image and create a way
to unify more SoC

> +/*
> + * The offset at which the image to be loaded from NAND is located is
> + * retrieved from the itb header. The presence of bad blocks in the area
> + * of the NAND where the itb image is located could invalidate the offse=
t
> + * which must therefore be adjusted taking into account the state of the
> + * sectors concerned
> + */
> +u32 nand_spl_adjust_offset(u32 sector, u32 offs)
> +{
> +       u32 sector_align_offset, sector_align_end_offset;
> +       struct mtd_info *mtd;
> +
> +       mtd =3D get_nand_dev_by_index(nand_curr_device);
> +       if (!mtd)
> +               hang();
> +
> +       sector_align_offset =3D sector & (~(mtd->erasesize - 1));
> +
> +       sector_align_end_offset =3D (sector + offs) & (~(mtd->erasesize -=
 1));
> +
> +       while (sector_align_offset <=3D sector_align_end_offset) {
> +               if (nand_block_isbad(mtd, sector_align_offset)) {
> +                       offs +=3D mtd->erasesize;
> +                       sector_align_end_offset +=3D mtd->erasesize;
> +               }
> +               sector_align_offset +=3D mtd->erasesize;
> +       }
> +
> +       return offs;
> +}
> +

Here the same

Michael
> +void nand_deselect(void) {}
> --
> 2.26.2
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
