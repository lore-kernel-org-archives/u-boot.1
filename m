Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308B1C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 17:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F7748832D;
	Fri, 26 Apr 2024 19:36:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="dLWD2Gvz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F8F5884F3; Fri, 26 Apr 2024 19:36:57 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 170CD88324
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 19:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a5883518135so281020966b.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1714153014; x=1714757814; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0hL5bd2bN8P+WIbT4xDgi/aW6ocnRgKtCc0bgSxC1jk=;
 b=dLWD2GvzrCFW3dIUGNMsTvV769WrOlqGbTRlDipj1OS7gUG+oYpxmVsVyfa95oAEkV
 +DPx5j11mGxuL8+YdvpRY9K1tp+RXDiIQkkxzkDBOCNx40YbYTix4AQIkHM+/bdkK0i4
 +Z5fN6YoQXFQwA3/PUr7rstcY5C47im0BG0nJPOwGJ2Z7kER/2TV7jPTP/wlqQgfUL56
 7SYPOC6gySYFBc7FnfOkgCiZPvbrVAl7/6r46blE80QnnrlUwDzgjn5lFDDZD7NHRwvI
 yXfXgQwpD3mw2l263JPZrUARQTAtKnh8QCG/Aw+9oqdPfRDK1oXAVsrE32JWeJ9Lksda
 Ulkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714153014; x=1714757814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0hL5bd2bN8P+WIbT4xDgi/aW6ocnRgKtCc0bgSxC1jk=;
 b=ghu2rH8/hVJ+8tTSrTgVsNnuaLrclPfv4jEwgzuhNZ9jH8OTcqSyHtMwwGU9WYBfOe
 dcZfohkf8JIuHJCt9eIEqmNsk+hvpEX1wDi6Kv8Afx3ZVMbdnwI207n+v9TAnVBAtJaB
 BLRErOUnxiWfs4veaUtksUCTWRPsLVW96I3GZXyB5tAcu2uVgBQileeqIc8TgsuiTKoM
 X1p2OGLnEUtfemsJmjRiSB/J0FcyKQijaLAHzW3AubQfquTKhrwGlwh7ctnRZ3X2eeKj
 Qa4Tfsrbrf0MruXI53yfFmtfo+NtTfYMNJ1WPqeT0pwEG3uPHKoatX5NVbi+3xDh8jaU
 fiHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7r0H/KnZ6yZF2mBnyqQB4eNlLTuGitvuh98pgSNcoC18dyES2EOlIXSD+vQpQFf2lOXIHOJc38bG830CV1diZ+43/lQ==
X-Gm-Message-State: AOJu0YxOa6YUowIbn5pKeVtPkOEpVKxoaDL5eHGskc4zW2rh/+C0FyJV
 MP87hmbx5snsi5kDqrPd2+dTjmHvyJtQgI/2H1KPoiaek1kvZvmGdRKJBVsBeyQ723qyVsN7lyl
 eGbZXz12/PIyD4oFFQ+Zi5NymckCnr6Gje46VrdtPL7MS+uC0e55eeQ==
X-Google-Smtp-Source: AGHT+IGSV6D56xI+xrw8kxWM7aKvOjauh5DR+XeGihU6759Ao8I3qxisyZPbIaRjA4oyubOnHrcTUw8dxj9jL7AP5TI=
X-Received: by 2002:a17:907:1008:b0:a52:3583:b9d0 with SMTP id
 ox8-20020a170907100800b00a523583b9d0mr160565ejb.3.1714153014467; Fri, 26 Apr
 2024 10:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240426171205.1382212-1-tharvey@gateworks.com>
 <9f5dc653-8252-4da7-81bc-a76280cf4c68@denx.de>
In-Reply-To: <9f5dc653-8252-4da7-81bc-a76280cf4c68@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 26 Apr 2024 10:36:43 -0700
Message-ID: <CAJ+vNU3U4P0wLcJ=_Bev++bsRF+=2inGEcs3pMuRb4f7ObSjBQ@mail.gmail.com>
Subject: Re: [PATCH v2] cmd: mmc: allow use of hardware partition names for
 mmc partconf
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
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

On Fri, Apr 26, 2024 at 10:25=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 4/26/24 7:12 PM, Tim Harvey wrote:
> > eMMC devices have hardware partitions such as user, boot0, and boot1.
> > Allow these names to be displayed when reading the mmc PARTITION_CONFIG
> > field via 'mmc partconf'. Additionally allow a name to be specified whe=
n
> > setting the PARTITION_CONFIG.
> >
> > Before:
> > u-boot=3D> mmc partconf 2 1 1 0 && mmc partconf 2
> > EXT_CSD[179], PARTITION_CONFIG:
> > BOOT_ACK: 0x1
> > BOOT_PARTITION_ENABLE: 0x2
> > PARTITION_ACCESS: 0x0
> >
> > After:
> > u-boot=3D> mmc partconf 2 1 1 0 && mmc partconf 2
> > EXT_CSD[179], PARTITION_CONFIG:
> > BOOT_ACK: 0x1
> > BOOT_PARTITION_ENABLE: 0x1 (boot0)
> > PARTITION_ACCESS: 0x0
> > u-boot=3D> mmc partconf 2 1 boot1 0 && mmc partconf 2
> > EXT_CSD[179], PARTITION_CONFIG:
> > BOOT_ACK: 0x1
> > BOOT_PARTITION_ENABLE: 0x2 (boot1)
> > PARTITION_ACCESS: 0x0
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> > v2:
> >   - fix typo in subject
> >   - add names for gp1..gp4
> > ---
> >   cmd/mmc.c | 25 ++++++++++++++++++++++---
> >   1 file changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/cmd/mmc.c b/cmd/mmc.c
> > index 2d5430a53079..af9a66cc6df4 100644
> > --- a/cmd/mmc.c
> > +++ b/cmd/mmc.c
> > @@ -14,6 +14,18 @@
> >   #include <part.h>
> >   #include <sparse_format.h>
> >   #include <image-sparse.h>
> > +#include <linux/ctype.h>
> > +
> > +static const char *mmc_partnames[] =3D {
> > +     "user",
> > +     "boot0",
> > +     "boot1",
> > +     "gp1",
> > +     "gp2",
> > +     "gp3",
> > +     "gp4",
>
> Uh, maybe gp%d are indexed from zero too ?
>
> (sorry for the confusion)

but 'mmc hwpartition' does not list them 0 based:
u-boot=3D> mmc hwpartition
switch to partitions #0, OK
mmc2(part 0) is current device
Partition configuration:
        No enhanced user data area
        No GP1 partition
        No GP2 partition
        No GP3 partition
        No GP4 partition

I'm ok with either, I'm just not sure what is more understandable and stand=
ard.

Tim
