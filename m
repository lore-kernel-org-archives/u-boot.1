Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57551C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 17:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC87E808A2;
	Thu,  6 Mar 2025 18:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G2uKgXEt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F9580E94; Thu,  6 Mar 2025 18:42:35 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F21AD805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 18:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so20915125ad.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 09:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741282951; x=1741887751; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6EVASNhlD4YE9+3ZL+cqVT4P+SdnRckaGe4EC6F//k=;
 b=G2uKgXEtst+/+Gvl+Rb9g71et6guvmgdoAKriYIbGAHFrXAKB7kgwf8faYxroC77pm
 EjkRGNUhdF2P5+krsba+QyjZWyr/bX+wDdYtTKp2zgPcf4zQSPdDCcmqeZsTy0Q8zpY6
 /odGY4UAFeiB2RHGt6zrMlEYmiyovOikeo7Uk9vbeFwwOSIWcq3NjFUd6cGwb5O4p3MC
 yKTwne/zucf0zYjqr+TiMkqTuU54jB8jrWlAAQaWXZ/UxNRb1IbxX6jK5nowrkKsbKGB
 vzawuK4sJfT0SGuM0YUbbyOE9868ag5NhBLNOKJgxUdWIzlnkjpnhYHx/ixQqLogyM/u
 v6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741282951; x=1741887751;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6EVASNhlD4YE9+3ZL+cqVT4P+SdnRckaGe4EC6F//k=;
 b=lYil+QChfNvCxV7fqP9dFP6ug7/zdVP4aun5n3W7OGiyb62iKJ2htjLGCjHQ/hywbL
 LdirVdnb31+V7CjyQzioDe+A9re0qWdC7D34oZ0HMqJYA8yzRtdp62qfKo04OOyHUcmq
 0L89L7Gmz+31KMO7twsWGRyztqiqJLk2NggcwYTkWhv3zzI8XEoqgmwCFesFW195jIz0
 h7qRQ1MClXou89V/VmnyH2bwbTaHqoNXiU1451r/srO9RjUqxg80Dvu62ix7pvJ1w9jb
 DSwSVp5Z5XJYnoTua/f7GfSw2i5k9DBCfeWDbYOJ92VZ2NnWKJJesAQAcocmvlbZg48R
 u+lg==
X-Gm-Message-State: AOJu0YypPT2kv/kKZ9d7NAP28MyUjM1x97AehYfuxvaok6UbXaKW8QJA
 B78MlSZAO6V6HGpysuhb7ltX8+kcdOcyo+Ig9uV+aQYRObQV1BMZQRgkGiXCnIbPdSJAYfE9W1P
 /web81ZsGUhuKR21njOclrm0/hZg=
X-Gm-Gg: ASbGncs9MJ+xjslW1aYpChO/CJw6GEcENTeLfeXDFCQgW5OHm1Ruq98Kj9G/oz2qXeB
 EdFjOIMu1dpzEuPxI1JP3pftEeg2Ofp8z7JfhN/KC5OwkWqpf2alJ/r8sZR0gQ5VtChpaIdAVmc
 5V2jHam5lfJaA82dJjqHjRLkW5+Q==
X-Google-Smtp-Source: AGHT+IGQYWShJw6chsmFC2GkbW7RMSv7WrNtpQu34zHmq7DsRArzBn5VFdGKmXLm0f4muuAmOJ36CthaMuojLExEC+w=
X-Received: by 2002:a05:6a00:987:b0:730:99cb:7c32 with SMTP id
 d2e1a72fcca58-736aa9ddd9bmr330693b3a.7.1741282951253; Thu, 06 Mar 2025
 09:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20250302165249.267992-1-aford173@gmail.com>
 <20250302165249.267992-6-aford173@gmail.com>
 <CAOMZO5CWobDv_wqmjJxzo1Ekb-UbtGfxoLtHo7ZKmjPSuHy+1w@mail.gmail.com>
In-Reply-To: <CAOMZO5CWobDv_wqmjJxzo1Ekb-UbtGfxoLtHo7ZKmjPSuHy+1w@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 6 Mar 2025 11:42:19 -0600
X-Gm-Features: AQ5f1Jq8OVfmNKoU1WBN-tzD87dJgkju_tVjQ0niMDhgNWI0ALatUk8lO4ZbTVM
Message-ID: <CAHCN7xJ9euY_DdaWmSsDJDJew1tUEOKvVrPKc1-DX0LSGjRjMA@mail.gmail.com>
Subject: Re: [PATCH 05/10] serial: mxc: Support bulk enabling clocks
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Tim Harvey <tharvey@gateworks.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Peter Robinson <pbrobinson@gmail.com>
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

On Thu, Mar 6, 2025 at 9:55=E2=80=AFAM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> On Sun, Mar 2, 2025 at 1:53=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
>
> > @@ -312,7 +313,17 @@ int mxc_serial_setbrg(struct udevice *dev, int bau=
drate)
> >  static int mxc_serial_probe(struct udevice *dev)
> >  {
> >         struct mxc_serial_plat *plat =3D dev_get_plat(dev);
> > +       int ret;
> >
> > +#if CONFIG_IS_ENABLED(CLK_CCF)
> > +       ret =3D clk_get_bulk(dev, &plat->clks);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D clk_enable_bulk(&plat->clks);
> > +       if (ret)
> > +               return ret;
> > +#endif
>
> CI fails when building a target with CLK_CCF disabled:

OK.  Thanks for catching that.  I'll move 'int ret' under the #if
statement to fix it in V2.

>
>    aarch64:  +   imx8mp_evk
> +drivers/serial/serial_mxc.c: In function 'mxc_serial_probe':
> +drivers/serial/serial_mxc.c:316:13: error: unused variable 'ret'
> [-Werror=3Dunused-variable]
> +  316 |         int ret;
> +      |             ^~~
> +cc1: all warnings being treated as errors
> +make[4]: *** [scripts/Makefile.build:257:
> spl/drivers/serial/serial_mxc.o] Error 1
> +make[3]: *** [scripts/Makefile.build:398: spl/drivers/serial] Error 2
> +make[2]: *** [scripts/Makefile.xpl:550: spl/drivers] Error 2
> +make[1]: *** [Makefile:2117: spl/u-boot-spl] Error 2
> +make: *** [Makefile:177: sub-make] Error 2
>
> Please fix and resend.
