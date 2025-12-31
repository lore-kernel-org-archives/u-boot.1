Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B54EE57C8
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 01:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F54983FEE;
	Wed, 31 Dec 2025 02:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GxTJq95x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8787483FF5; Wed, 31 Dec 2025 02:48:54 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8FF383F69
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 02:48:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-64b7318f1b0so12385642a12.2
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 17:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767145731; x=1767750531; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H9EQMs4l/Me9Yq8h2b8P8nm0OV3JCAkk+vlaNxM5eSk=;
 b=GxTJq95xDk1UHWY6d6stpcsd8FMukcFN9yAh0+zaJenLERLozTW8F3I+fL5Lx8KoAp
 VfdGRrb8gpxf+Pp24F7iRFMUl85RvFnnkd15vYZDNmuubgfJB6gaOXohM0gbce8z/6DF
 Yb/nrmAXeljHcpPd7D1r8EnLc+1yzQpZ9+ztU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767145731; x=1767750531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H9EQMs4l/Me9Yq8h2b8P8nm0OV3JCAkk+vlaNxM5eSk=;
 b=iaoy8mRuoyjndKmtstot7vzgVYAhoEbYEmHDKOwYZXung5k/HeyZdx4J0/LTz1Tev8
 3Vb05eajvsiJgK3bx70OmBYAWGkPL7Qu8jkMqtG2P9IZN0F0QBguw0hsvVJnk98ttOWR
 NAXvE3SCPbO5e/UOac8UNmfvGjbNbcOC2+3HDRjOD9y65DmZlBumxeDeQX35GoLcU18V
 UIfpptF7hgtpBOPlWUc5MNt6J5MfCu2cFpCvVxtMGsmBDJ2jI3Sxe+iBIEMM1ymA9c4C
 ELwFNylHAuwFiqn2xVAp4MEfEhBrQtG+FeHhZ4L/4jt5EB5BodmeNHbuy/Fy1OlBOHUI
 FGTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwYJJ3PJvYkfcHm0nv2x79IR+vjssf/YACS5A8PnQ65WSzw1Ougsy5ovi/qQ2X0iGHTM3A/qo=@lists.denx.de
X-Gm-Message-State: AOJu0YyqXHiqMPL6NYkUnRfVqeZfs9p6aXwwQFi5p9O/aE198VIt9n6N
 1YTvu2ZgU7LvLN+xCdg9FigB3lmRl3vS4c4X3Xcd/jlzzEx/0eLwgJ7vjgI54Eh2nBMz72JwSDI
 s7EOrEO/5A1x/ZKOmy0YtpotmzA0Mt5VpxNfTzpsA
X-Gm-Gg: AY/fxX64AQIZtlz/WxvFILQQqioEcgDeMoQPwWKwSbbnP+AbAODxmtelQQ+oddyAdEA
 osyBf5LvTA2H6HFCF3/6aNp9G3BuPRKPYey1gu6Q01P9EXK2fRz6OVZMD3M7Lsyz90rWvsvz8rn
 VKZWrJtZ7X013bymfy9A5rql4lfLaUwlV21Cl+/tN7RwI2Nity520yrwWA8E/23GXAb1hJ4cDgG
 JFTivtbAHiHF3WUenq2aPKD2Xl7MSeYYoLTFOisPGwDAT6n+9PgVXsxglpa9n71wDWBhw==
X-Google-Smtp-Source: AGHT+IG+6pOGMUVPJvNYR+YYJ0xUtGj1zOWifZCHoM5sR41SBABSpMBVG/jUffQf0ic35y482afslg/GfLdjhhBH0vQ=
X-Received: by 2002:a17:907:3da8:b0:b76:b76e:112a with SMTP id
 a640c23a62f3a-b8036ece49dmr3574637966b.11.1767145731095; Tue, 30 Dec 2025
 17:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20251228164500.313817-1-t.preissl@proton.me>
 <20251229144813.GP710860@bill-the-cat>
In-Reply-To: <20251229144813.GP710860@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 30 Dec 2025 18:48:38 -0700
X-Gm-Features: AQt7F2q6UX5oANe7R2rJv3C9qa86ljDKROOHd_Q1XYyPQ17EmBkFSPrqyHYx8w4
Message-ID: <CAFLszTjFP4N1v-=Uob+DRpG_Fc3szkt+yziG+cbLQ7nxaM5mvQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] fix integer overflows in filesystem code
To: Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
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

Hi Timo,

On Mon, 29 Dec 2025 at 07:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Dec 28, 2025 at 04:45:08PM +0000, Timo tp Prei=C3=9Fl wrote:
>
> > Timo tp Prei=C3=9Fl (4):
> >
> > This patch series fixes potential integer overflows in U-Boot
> > filesystem code. It includes the following patches:
> >   fs: prevent integer overflow in fs.c do_mv()
> >   fs: zfs: prevent integer overflow in zfs_nvlist_lookup_nvlist()
> >   fs: squashfs: prevent integer overflow in sqfs_concat_tokens()
> >   fs: ext4: preventing integer overflow in ext4fs_get_bgdtable()
> >
> >  fs/ext4/ext4_write.c |  7 ++++++-
> >  fs/fs.c              | 18 ++++++++++++++----
> >  fs/squashfs/sqfs.c   |  9 +++++++--
> >  fs/zfs/zfs.c         |  9 ++++++---
> >  4 files changed, 33 insertions(+), 10 deletions(-)
> >
> > All patches have been tested with:
> > - sandbox_defconfig
>
> First, thank you for looking in to this. Second, please run
> "scripts/checkpatch.pl" against each as there's inconsistent spacing
> used here and that makes review harder (and needs to be fixed before
> applying). Finally, for each commit please elaborate on the problem
> being fixed (for example "if ... is corrupted then ... could
> oveverflow"). Thanks!

In case it helps, there was an earlier series here:

https://patchwork.ozlabs.org/project/uboot/list/?series=3D456262&state=3D*

Regards,
Simon
