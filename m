Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B843D5D69F
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 01:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BA0888DB2;
	Fri,  8 Nov 2024 02:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DaasyEk7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38FC788DB2; Fri,  8 Nov 2024 02:27:54 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F185488C66
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 02:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5cf04f75e1aso1659979a12.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 17:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731029271; x=1731634071; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1yklLnsMDyQoY7GP9CWPr1Sj+pYF/NXCOnqtIDPED5g=;
 b=DaasyEk7OliFXyr9Rym/HochY+czuHTsqnvFKAaEDVQik3DsIZ5tXPgJomFeD8FhXD
 ADSTVsea8BaPCu2sgM3FYGLG3u/LoRQCLX6DN2tVW714Ll9oHbqiSODzaJAsPZ9ZD8db
 9l9EOxbLzPhFjJM0q4XTf3GZ/woo0uQp/KUTPGoCWPIFd2e9EixE9Dg7yQ9Dh4OO+Dyz
 +C5bp55RV3K2tKKLo70WOGh5LDQR+D5MIt2bC9mWFjKy9FRF6VLbwC79ZvxpI5xcVNKj
 OSw4oYp/LtcbRaaXCgzuoQzDmB3mBk3JMgkjKCSyiCcl+UY7w4Ay/DCQTPsv2mwcEROQ
 UDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731029271; x=1731634071;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1yklLnsMDyQoY7GP9CWPr1Sj+pYF/NXCOnqtIDPED5g=;
 b=D2OPQCA5RSpeRUWdpmb2u1N63DJlvm8vchUWNxAL7RxEfa8X2gL4p7IBerWxN2yJ5A
 YkgDQGAg0+iJn60ZDFDe43W3ydNMp+l4/0eeSmYqTlDwKpLJ4IVi/8kT2gwpwwt8RHuR
 h3Sw/P3RlhR8L/TjhXpcexNZqtuNCrke8kRchgNIHe8RTm5wMRaWCLzhAXcJF9JX/hEh
 HBHxzKmX5kDLi8vVZhmzj3gTQ+ZSVgDmUBkVBPEn4Kidw/GS/vsrzY2qdLSaDTj6f+yR
 bYh5ZDM4Rdm8eLSQw1ew8FyUfMFbasuoflFTd+PI2eehYygac9eVHHUUXkH2qO9zWl1j
 o3sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd/rcbOtHoxbuvvrUmAhP+m5X7+aTjPDTY01Cfb/ZEhk400fIo+LeKlirc947YSEKsm1YgNVU=@lists.denx.de
X-Gm-Message-State: AOJu0YzJpbsXPZGqIMani54WIP+o7ipmXTprxdmQUgyl+4lppyo2VE1r
 Irpy8j9zDbpLWcxNIYls6s8Ps2F1ypIizMV6b1ppRMsb7Ww3Mi+y6wg0jerEPM02MlbVqUtm+1/
 m/5b0Wch+I9OjicjiRzLohO/QY3I=
X-Google-Smtp-Source: AGHT+IEbN0YQiV9nmtpz3GFKz/JZIXaKtJoWHtS0CCslWkGBPUABpa3oJ/N1/Ofn92Lop7cIdGSPHGtLZpq7/Km5Ba8=
X-Received: by 2002:a05:6402:42d1:b0:5c7:2122:6ad with SMTP id
 4fb4d7f45d1cf-5cf0a31baadmr577463a12.14.1731029271237; Thu, 07 Nov 2024
 17:27:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730988601.git.namcao@linutronix.de>
In-Reply-To: <cover.1730988601.git.namcao@linutronix.de>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 7 Nov 2024 17:27:37 -0800
Message-ID: <CAJaLiFyMuREzRs3f3-kzwaHpBK6NWh9BvadSWDYxrdqBG7SwvQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix boot failure due to misaligned DMA buffer
To: Nam Cao <namcao@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Ion Agorria <ion@agorria.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Sean Anderson <seanga2@gmail.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Javier Fernandez Pastrana <javier.pastrana@linutronix.de>, u-boot@lists.denx.de
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

Hi Nam,


On Thu, Nov 7, 2024 at 1:53=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrote=
:
>
> Hi,
>
> We observed the following sporadic boot failure while booting from MMC
> device:
>
> =3D> boot
> CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
> CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
> CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
> CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
> ** Booting bootflow 'mmc@2194000.bootdev.part_1' with extlinux
> Ignoring unknown command: =EF=BF=BDD=EF=BF=BD=EF=BF=BD=EF=BF=BDD=EF=BF=BD=
=EF=BF=BD
> Boot failed (err=3D-14)
>
> The reason is because while allocating buffer to read a file from MMC,
> alignment of 1 byte is used. Thus, the buffer doesn't work for performing
> DMA, and garbage data is read.
>
> While looking at this issue, I also noticed that if no alignment specifie=
d
> (align=3D0) then fs_read_alloc() is documented to use the default. But th=
e
> default is no alignment. Therefore, other users of fs_read_alloc() which
> specify align=3D0 may be broken as well.
>
> The first patch changes extlinux_read_bootflow() to use proper buffer
> alignment for DMA.
>
> The second patch changes the default alignment of fs_read_alloc() to be
> DMA-suitable, to fix other potential bugs.
>
> Nam Cao (2):
>   boot: extlinux: Fix unaligned buffer for reading data from file system
>   fs: Use ARCH_DMA_MINALIGN as default alignment for fs_read_alloc()
>
>  boot/bootmeth_extlinux.c | 3 ++-
>  fs/fs.c                  | 4 ++++
>  include/fs.h             | 2 +-
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> --
> 2.39.5
>

FYI, this "CACHE: Misaligned operation" problem was also fixed in
bootstd script method by this previous patch:
https://lists.denx.de/pipermail/u-boot/2023-September/530927.html

For the series.
Reviewed-by: Tony Dinh <mibodhi@gmail.com>

All the best,
Tony
