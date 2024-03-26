Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A547CD11DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 22:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5211B87D09;
	Tue, 26 Mar 2024 23:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TGhhrueE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 704B680EED; Tue, 26 Mar 2024 23:10:40 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A05C8801E
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 23:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6ea7eff5f3cso555532b3a.0
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 15:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711491036; x=1712095836; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNFtw4+lsjUn+uGerRgUjRvKFck0MGwllzb7pkQryqo=;
 b=TGhhrueEDuOfWVi+NqCYL/UO7fyFbfW93TnEzqIQjpT/HmxV7jd9m9hIy3KC5G8Ena
 aWQaexwLBaL8vMKMVgqnWzXl6mRrrlnhB17gDDmgx0QrpCLQI8PzZ1ovJGhw8DcfN+ud
 t/fAVUHVX/y9jeVBr91PVWDe/S6SOOe5eeJ2q6/Q3gtdfx9n0vE5Pfxr/i942x2MDVDe
 titFE2C/C0zZ8E0/Q4Xf5YwBI4+9NLxVLKWS2n7a3IlBnLJWg/8JZMI430WFrvek+CyU
 wVzF5mzeifu2ZPz+3OYMpXrzxzYRkVFjDX6DnqK3K+npPHVHmtbsyFSsm6fW8Qd34PTh
 7Djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711491036; x=1712095836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QNFtw4+lsjUn+uGerRgUjRvKFck0MGwllzb7pkQryqo=;
 b=Rp8K4I9QI2y897lFddGluljm6hlI0rT9bPlIqRr0Ajfsy9oB1GhmhCzqnHZY0PA9Ok
 RSkRgFA5mIf6Oh/y4hRK11Jg1nsMYlXZWmRBZo7wdakWZxYxB0LC4f2brOFZZpDZMO6q
 p++1OuGM/1iCWP0R9goMXMzMZiJhJYzkSwDSXLpI9aO2+s1NEZ8OeyUJmH4WWDmay3e1
 //9uswrYmfOuQtw2/BMUSnTo6Aq2z4w8UxAKWUemflWvn/39VqeGG36K5aaAuyzyPZIH
 4+kuTOvJoiHyK7f5fjMHzNsE1vDD5cQQWmhFbX6ZX4NxjM2bx1ih9d2Oee5501C3KEGO
 UeKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJh95DkDkTHdkgp5H21isxMzq1rXNnB7G0ojoEHyJveqpBAX6Z66TmIWyaTB6RkHf6cXQbYptFQmp15ahtF3A+qCFdtA==
X-Gm-Message-State: AOJu0YzpXKCAc5CvnvTo4p8PyhKQi0+ncpvuOamOqRwa7mwozm1gYHwN
 6/7sgVLfcTSbgdXAYZPS70ksnE0ARL6vDLVvXNsYU+bvMxor/BbUEzSIt2PDtGamUjjWYwOHG73
 Rb699UTlRmaQe0hfGen7LOyN5f1g=
X-Google-Smtp-Source: AGHT+IGTJMKf9+nyv3Gschd0a21oFMRxSvxqo4g0tE6cjmd5GnuuYADmN/eJVrEG0SAIrhM9cyr6SA3+kfVcQ+p1yN4=
X-Received: by 2002:a17:90a:b016:b0:2a0:2605:688f with SMTP id
 x22-20020a17090ab01600b002a02605688fmr10104081pjq.2.1711491036396; Tue, 26
 Mar 2024 15:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240326033801.228419-1-joy.zou@nxp.com>
 <20240326033801.228419-2-joy.zou@nxp.com>
In-Reply-To: <20240326033801.228419-2-joy.zou@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Mar 2024 19:10:25 -0300
Message-ID: <CAOMZO5DnR_AoZJsnx8FD-y5j5UzgiPSHsPRRQkLKwYFwhCVWQA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drivers: rtc: add pcf2131 rtc driver
To: Joy Zou <joy.zou@nxp.com>
Cc: peng.fan@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, sbabic@denx.de, 
 sjg@chromium.org, saproj@gmail.com, judge.packham@gmail.com, 
 uboot-imx@nxp.com, u-boot@lists.denx.de
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

On Tue, Mar 26, 2024 at 12:30=E2=80=AFAM Joy Zou <joy.zou@nxp.com> wrote:

> +bool is_pcf2131_type(struct udevice *dev)

static bool

>  static int pcf2127_rtc_read(struct udevice *dev, uint offset, u8 *buffer=
, uint len)
>  {
>         struct dm_i2c_chip *chip =3D dev_get_parent_plat(dev);
> @@ -43,10 +75,64 @@ static int pcf2127_rtc_read(struct udevice *dev, uint=
 offset, u8 *buffer, uint l
>         return dm_i2c_xfer(dev, &msg, 1);
>  }
>
> +static int pcf2131_rtc_lock(struct udevice *dev)
> +{
> +       int ret =3D 0;

No need to initialize ret with 0.

> +static int pcf2131_rtc_unlock(struct udevice *dev)
> +{
> +       int ret =3D 0;

Ditto.

>  static int pcf2127_rtc_write(struct udevice *dev, uint offset,
>                              const u8 *buffer, uint len)
>  {
> -       return dm_i2c_write(dev, offset, buffer, len);
> +       int ret =3D 0;

Ditto.
