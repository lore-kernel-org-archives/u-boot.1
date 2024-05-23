Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA65C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 06:56:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D504D884CA;
	Thu, 23 May 2024 08:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mH34PzH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C97884CA; Thu, 23 May 2024 08:56:27 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 411778850B
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 08:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r.stratiienko@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2e45c0a8360so63852021fa.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 23:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716447384; x=1717052184; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3RcoLdODu7GTYq9KFOx0PlOhPie+dH4XuBAKiv3XTc=;
 b=mH34PzH0MW0I1/P+el492NMlUslOqcbx7jDn8Uvdpe208Ko05pGYRDjlZnyPUzuhpI
 8a3GAIxovvVZ4uA+LU+tTxGLQyBnLubKkRo/BDQ57mzubeXtSeGjLJOpfGLB9SLSjxuj
 QQqjRdVsAo+xop7SjSWVgkhLQMtxDo84vhAKzTWsKhcOC6yKO8tuaAEXdruhnRt6Fz7P
 XlVZyXuld12B61bulhPcyd4QfW1CgEVFldTxLsBkmHEufL669o9WfOEjscXIArrO3z/g
 WKx9Lc9NcjHhtP3VuNuLMlKHxpp7F6/XA7Et/stDDdkRmcPbcw1P8R9AvQE2hdsQkhc1
 Eo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716447384; x=1717052184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3RcoLdODu7GTYq9KFOx0PlOhPie+dH4XuBAKiv3XTc=;
 b=jCeWICGsC2jdx7rEMh2klWSm/w5QceLe11AOkDNUa8c7FI2KO4/Up4mFyg4QRtEOod
 3lAoxz0UbqbxKBI93yfWIsGpbIPXumGGCgIeBAMro1XPcbn3YD8XVS0V1SL8vKd1NxyW
 bIYuRWSkUXAGC9yJDbrw8H0i5EqDfVFOQqS0sYU7jhBhpfQO/woEnzQh+fcvf3Ai8lva
 aarq3EhLX5PgofRPAvzwHVBwcv22pdxmn47458wYAbGi0x5bEUwhttmmOAIq86VwZDyW
 Mx54YQLWOrGtQZgHLjf3hczG4x4CX68S/xPeoQChmKcKyeYVqtWUAtqrAb8n5GDoxDbU
 aLxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtCdzQ5QA0HOx+8rGiPM1DgS4ysNo+uBK+hvvdGfgUoj1i4YfDCcgSf3yRHe8eESnRiHAzWgHjdfQ76sBe//ITudMRLA==
X-Gm-Message-State: AOJu0YyCdRy/bO/9IzZHvK6nRmAzeRHdNIVLQQyyd6imnBZFovk+5dEM
 rUeKlKBxcOxoctjS7z6CHVmrbQ5ivRheVfCgE7MzJPVSpXZRTpEOe+O9+oExlJ8J5BT44dGcVYm
 QPzgq+EpqZxjd5KYQ+9z6SG44ydU=
X-Google-Smtp-Source: AGHT+IE93z5S8EfOJQzybsIAiYZwlYd2oF9auzfxsrAIdik/Q0bI2zhh6ECDA6KXcos/XVPTF/zH88zOKxNTrMhVLbM=
X-Received: by 2002:a2e:9088:0:b0:2e1:adc4:47f6 with SMTP id
 38308e7fff4ca-2e94944138fmr23679781fa.6.1716447384313; Wed, 22 May 2024
 23:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240522212645.87250-1-r.stratiienko@gmail.com>
 <87y181xc6c.fsf@baylibre.com>
In-Reply-To: <87y181xc6c.fsf@baylibre.com>
From: Roman Stratiienko <r.stratiienko@gmail.com>
Date: Thu, 23 May 2024 09:56:13 +0300
Message-ID: <CAGphcdn99CyoHvphk2VAzGLp4qmws5kN2KN5sKCoUZenZ+idwQ@mail.gmail.com>
Subject: Re: [PATCH v2] abootimg: Add init_boot image support
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: sjg@chromium.org, marek.vasut+renesas@mailbox.org, 
 laurent.pinchart@ideasonboard.com, eajames@linux.ibm.com, 
 paulerwan.rio@gmail.com, xypron.glpk@gmx.de, u-boot@lists.denx.de, 
 igor.opaniuk@gmail.com
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

=D1=87=D1=82, 23 =D0=BC=D0=B0=D1=8F 2024=E2=80=AF=D0=B3. =D0=B2 09:41, Matt=
ijs Korpershoek <mkorpershoek@baylibre.com>:
>
> Hi Roman,
>
> Thank you for the patch.
>
> On mer., mai 22, 2024 at 21:26, Roman Stratiienko <r.stratiienko@gmail.co=
m> wrote:
>
> > Quote from [1]:
> >
> > "For devices launching with Android 13, the generic ramdisk is removed
> > from the boot image and placed in a separate init_boot image.
> > This change leaves the boot image with only the GKI kernel."
> >
> > While at it, update wrong error handling message when vendor_boot
> > cannot be loaded.
> >
> > [1]: https://source.android.com/docs/core/architecture/partitions/gener=
ic-boot
> > Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> Note: this patch still does not apply on master nor next:
>
> $ ~/work/upstream/u-boot/ git show --pretty=3D'%h ("%s")' HEAD --no-patch
> a7f0154c4128 ("Prepare v2024.07-rc3")
>
> $ ~/work/upstream/u-boot/ b4 shazam -s -l 20240522212645.87250-1-r.strati=
ienko@gmail.com
>
> [...]
>
> Total patches: 1
> ---
> Applying: abootimg: Add init_boot image support
> Patch failed at 0001 abootimg: Add init_boot image support
> error: sha1 information is lacking or useless (cmd/abootimg.c).
> error: could not build fake ancestor
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abo=
rt".
> hint: Disable this message with "git config advice.mergeConflict false"
>
> - master: a7f0154c4128 ("Prepare v2024.07-rc3")
> - next: 377e91c162ab ("Merge patch series "Clean-up patch set for MbedTLS=
 integration"")
>
> Looking further down below, we can see that this patch has the "abootimg
> load" command, which is introduced in these series:
> https://lore.kernel.org/r/20240519191856.2582174-1-r.stratiienko@gmail.co=
m
>
> Please consider rebasing on either master or next before sending.

Ahh. I see. Sorry for the inconvenience. I will rebase and send v3.

>
>
> > ---
> >  boot/image-board.c | 13 ++++++++++---
> >  cmd/abootimg.c     | 26 +++++++++++++++++++++-----
> >  include/image.h    |  7 +++++++
> >  3 files changed, 38 insertions(+), 8 deletions(-)
>
> [...]
>
> >
> >
> >  static struct cmd_tbl cmd_abootimg_sub[] =3D {
> > -     U_BOOT_CMD_MKENT(addr, 3, 1, do_abootimg_addr, "", ""),
> > +     U_BOOT_CMD_MKENT(addr, 4, 1, do_abootimg_addr, "", ""),
> >       U_BOOT_CMD_MKENT(dump, 2, 1, do_abootimg_dump, "", ""),
> >       U_BOOT_CMD_MKENT(get, 5, 1, do_abootimg_get, "", ""),
> >       U_BOOT_CMD_MKENT(load, 5, 1, do_abootimg_load, "", ""),
> > @@ -376,7 +392,7 @@ static int do_abootimg(struct cmd_tbl *cmdtp, int f=
lag, int argc,
> >  U_BOOT_CMD(
> >       abootimg, CONFIG_SYS_MAXARGS, 0, do_abootimg,
> >       "manipulate Android Boot Image",
> > -     "addr <boot_img_addr> [<vendor_boot_img_addr>]>\n"
> > +     "addr <boot_img_addr> [<vendor_boot_img_addr> [<init_boot_img_add=
r>]]\n"
> >       "    - set the address in RAM where boot image is located\n"
> >       "      ($loadaddr is used by default)\n"
> >       "abootimg dump dtb\n"
>
> [...]
