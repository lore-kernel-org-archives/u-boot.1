Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F76DECD998
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 19:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F16283C14;
	Thu,  5 Feb 2026 20:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cgzo2ijG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6429483C51; Thu,  5 Feb 2026 20:17:58 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F247983AA4
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 20:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-45f10d7eb81so494889b6e.3
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 11:17:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770319075; cv=none;
 d=google.com; s=arc-20240605;
 b=AekT/h8NCemt5+YSo3u91D3P7DojCdG8v26m/E2Us3oTos7dJxao9nhiFw3z0PINb0
 PbzL2Gl8SML+kWqVCJI6QmDXZv6of2b1WlrkebavJGGm7jeDuQCXYZNpX+yYbtjyB+AI
 yd+SJyPY8tp9b5bVXpIIq3IZr7anm8QEYuX3CB7y+NtI3mkywqYp2T+noNfmZL2Q+aNf
 FkJkLPhcqJC8NqHFaDfcPS+Jgt1SkpdV0FAHnYxRR9s4yaAh36GEoexmoXfaO1fucStD
 d93aDOyel1Q9hDG3IuHkkugWnYVSAydxi2kOZuvaOy96ov5JPVyKe/l2E6Q0EW/pbm+J
 2lXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7wQR8ex8Gla+zDk2xAUVwvrHyt1wa9/CleFZA2throA=;
 fh=ZTbIeCjJAUR8/1e6R81EUauLoog7Fs2wqAaqH0nFwFM=;
 b=dhwOv8H68Myz26L7ovUd7JgkQ0GetPFns3sXl74jYPO7izTE2Xug+ZmnZ4ti7FObaM
 W97L+UxJSBpH9c+yGfQsOW6+oc1kaoeJPnKUQjgcQ42TxNvGc5S6B/t6KoPP0Djc9pnh
 sCuPTNqI+c3QKQJ6XA5mNlxjIbsSLaruyZL6m7R3uuseE2vuhRYG49hwBTh1kYrfnUVe
 gPaOHrkoAqoYbtTfir06GZltsfqs01KdetPufC/HJSigr5YU6oAjBR5dokHBCoVhDefv
 F+eb7EQsDLUHjrauRj0UfQ3Xk3EuUz7Utw8ilWr+vuNvvovFLNT8i6U1B+RW5oTzD+Jf
 ZQiQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770319075; x=1770923875; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wQR8ex8Gla+zDk2xAUVwvrHyt1wa9/CleFZA2throA=;
 b=cgzo2ijG9kqwaVcN5ScxOAedD3HuJAF5J+0N5UfXCYF4z8iwC0+Iqcou/d6bjuW7iq
 FIusbiUWKfYjcdL7qkpbJ0tXYh9zALeJkebcJH5XMl57/aArR1N4V1o+zfk6zCyb2NSd
 bj9IjEr+uEhf1gaecydbPWHMGwI1Gn2uKnrGyA2BITr3i8WBZJmgXa6mZcWwD9xxcN0b
 7lWQH/UN6WfTIFtjUGJy+6SY/EkXkcyCipN7EDHrogHozRX2EQ0JZHA81wiPi0wdBWWZ
 WFHK7ZStMMmP6OFGJDrc6DTZs2I6FVxGAJGJj6L78b0g1QyObHa/CeYbnd2tgRNfz6oS
 pz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770319075; x=1770923875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7wQR8ex8Gla+zDk2xAUVwvrHyt1wa9/CleFZA2throA=;
 b=qyK5mxHEvspdkfffBEPkoBEgDXgvitWByFeHcBnrcTviPImM5tjyMuKOULQJXW/jtF
 pVqF0U9uwY5R7qk1Vdqm+QvlAfN0FeSVWAWXWp/0ljYn8S+ZsJdyrOw0cpzoesWbsLZX
 tKA3AQ14Fna9w/vNATOJZIVsoBhcoqHDZRvHYjI/s4mKNl1XrefKaGc5AkqjPs5tpf05
 Oym/CgLwF5uljOVx0mFUmgw7XMFGmzojbpCMN6uU7ZDNeI/fm1aL8B+pWszQXRsQ5NXu
 WTv9qd3+dRkPrQpzbYP+Db7XZjaa395kLuvQ4sfhl/7eC2lN63KdyyUlXue4nPvnFYvA
 tZhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/tG+jmTCLUViXbcocj8vkCtm4IikySWhOpGvh56EErAQ6RWIAE9hV797MjPU90ASDrT7SZw4=@lists.denx.de
X-Gm-Message-State: AOJu0YxxMEn2mc9tzno/UFfmdu/3aXT3OVXUwdZbkaOWzFd3LRUWQd2S
 R1Jk0Hq53d/uVkRRaVBdDKu2Z2uy8AmnWaE5sujXrcUR1kxigtlj94UjZ5WcSMwZgAxZ+LVyRt0
 WAolHahElNMXf3vRNM2dzfTSM30I2UmHy14pjs8M09g==
X-Gm-Gg: AZuq6aKLyBSF6bk6GDTW315wA7WkUu+KllC/F6UsCd3iWkjcHZSmIWwxttATP4XUUAI
 m88MPqKM95aXLcEVZuw18mTJRvnyt3PD3C3gapcTO0K+ZFU2hjKZNPZnZGz4/qOoQquB0nv3P0r
 XHxs3yLePGliKyWMY2FDS8BxY1Rszl3CL7jn5ylG3vHMhy0Yl4EGwQpLDd+1VghqWP+mWGd0M/Z
 YJW2tVJRv169cf+XUPhb26GGtvq6ttWl+p1Q5JUgtkBgIjU7seps2O/sCQCF78QDyWg+g8a
X-Received: by 2002:a05:6808:22a8:b0:45a:5584:9bf6 with SMTP id
 5614622812f47-462fcb45c7amr166897b6e.39.1770319074712; Thu, 05 Feb 2026
 11:17:54 -0800 (PST)
MIME-Version: 1.0
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
 <20251216084623.19589-4-alif.zakuan.yuslaimi@altera.com>
 <fb37af46-c84c-4438-a7a9-c9476f2511f8@altera.com>
In-Reply-To: <fb37af46-c84c-4438-a7a9-c9476f2511f8@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 6 Feb 2026 03:17:43 +0800
X-Gm-Features: AZwV_QjNxLjCzbNGY4EzHmVf2By05jgnlRz01di91olqtFP5JnnSDaW1o8EYIhE
Message-ID: <CAN7C2SBDat32aNjROeet5BwZTpJxN-8DOKx4gU12QY_ibbDLtg@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] ddr: altera: gen5: Add DRAM size checking
To: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de, 
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Boon Khai Ng <boon.khai.ng@altera.com>
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

On Tue, Jan 27, 2026 at 4:03=E2=80=AFPM Chee, Tien Fong
<tienfong.chee@altera.com> wrote:
>
>
> On 16/12/2025 4:46 pm, alif.zakuan.yuslaimi@altera.com wrote:
> > From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> >
> > Add DRAM size checking compare between size from device tree and actual
> > hardware.
> >
> > Trigger hang if DRAM size from device tree is greater than actual hardw=
are.
> > Display warning message if DRAM size mismatch between device tree and
> > actual hardware.
> >
> > get_ram_size() uses size from device tree. So, it has consistency with
> > other device families.
> >
> > Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> > ---
> >   drivers/ddr/altera/sdram_gen5.c | 20 +++++++++++++++++++-
> >   1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram=
_gen5.c
> > index 7a0a043557b..d5892850da7 100644
> > --- a/drivers/ddr/altera/sdram_gen5.c
> > +++ b/drivers/ddr/altera/sdram_gen5.c
> > @@ -6,6 +6,7 @@
> >   #include <dm.h>
> >   #include <errno.h>
> >   #include <div64.h>
> > +#include <hang.h>
> >   #include <init.h>
> >   #include <log.h>
> >   #include <ram.h>
> > @@ -615,6 +616,22 @@ static int altera_gen5_sdram_probe(struct udevice =
*dev)
> >       sdram_size =3D sdram_calculate_size(sdr_ctrl);
> >       debug("SDRAM: %ld MiB\n", sdram_size >> 20);
> >
> > +     /* setup the dram info within bd */
> > +     dram_init_banksize();
> > +
> > +     if (sdram_size !=3D gd->bd->bi_dram[0].size) {
> > +             printf("DDR: Warning: DRAM size from device tree (%d MiB)=
\n",
> > +                    (u32)(gd->bd->bi_dram[0].size >> 20));
> > +             printf(" mismatch with hardware (%d MiB).\n",
> > +                    (u32)(sdram_size >> 20));
> > +     }
> > +
> > +     if (gd->bd->bi_dram[0].size > sdram_size) {
> > +             printf("DDR: Error: DRAM size from device tree is greater=
\n");
> > +             printf(" than hardware size.\n");
> > +             hang();
> > +     }
> > +
> >       if (sdram_is_ecc_enabled(sdr_ctrl)) {
> >               /* Must set USEECCASDATA to 0 if ECC is enabled */
> >               clrbits_le32(&sdr_ctrl->static_cfg,
> > @@ -623,7 +640,8 @@ static int altera_gen5_sdram_probe(struct udevice *=
dev)
> >       }
> >
> >       /* Sanity check ensure correct SDRAM size specified */
> > -     if (get_ram_size(0, sdram_size) !=3D sdram_size) {
> > +     if (get_ram_size(0, gd->bd->bi_dram[0].size) !=3D
> > +                      gd->bd->bi_dram[0].size) {
> >               puts("SDRAM size check failed!\n");
> >               goto failed;
> >       }
>
>
> Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Hi T.F. and Alif,

I know you reviewed the code.
But I am not sure on 2GB w/o ECC run it will pass SPL stage.
However when applied to the patch 2GB w/ ECC it does not pass SPL.
I would like to confirm that ARM GDB cannot be used to test ECC or not?
As I do see it involved D-Cache on

"drivers/ddr/altera/sdram_soc32.c"

Thanks,
Brian

>
> Best regards,
> Tien Fong
>
