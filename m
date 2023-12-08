Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C4CC4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 13:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ECF08752B;
	Fri,  8 Dec 2023 14:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="CQk2dOQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1681A87536; Fri,  8 Dec 2023 14:59:41 +0100 (CET)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 997D0874B9
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 14:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4b2ca5d5e05so390464e0c.1
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 05:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1702043977; x=1702648777;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dz2aPTSS0GDS12ewep5eZRIyE04bQehBvd0B8RkN1ck=;
 b=CQk2dOQ2cSp+OH/tlPEW9JiN1XGz7DzocB2Bz24cJkXClC1QILNItr/N0pajbIGF4N
 3/QZZwww3Lan2xK10+qODJy2EvIRWreGMbypoiH/T6mBzmsHqRJaD9sstUb+AHAYrYmN
 MXm1u1xRLzJJMFAfQqWYlPoGBX300QT/rxogH99IoTwRrf1ARrN/V7k0ohOHPmQCkHJt
 E75NGc9kUmJX3ItBq128hxQZhXlw8cUAHwq0l3/wrXFrNyspllrrc0weazNyRolaxF9y
 5U5GDzVCUh2RKxZeXO5mZjQC2gQOlpoOBHPLRKmN9+EYJ3Cx4ZlIOxXhTcQTo04c921n
 LQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702043977; x=1702648777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dz2aPTSS0GDS12ewep5eZRIyE04bQehBvd0B8RkN1ck=;
 b=VlDB52mm63AqQeeX3PiWEjcqQVM5OW+7fa7c0gsDgLuqNfPvQQSa0tdt4UZod/QxsR
 vfuH9nKwRZSQpL+giNLwC8p9DmcNfSw0CrUyzv344K0LryjEcohJF8Ql24TxgcfPyGwb
 Ppotj7jUlH1uCc6twTYceENCdgE+o9wXvKvkZDQQt0rfAnSBmEMDBd3gaYx7heqXvlmk
 zLnWs0D5vA+9h/9dKhNDq07/7suq42ENbeZ9z/ZoPIPZhhkpFukX0P2G0WooCamR3aMi
 XWCKSQDPtCzz/IXG8tOrHTrxmcqqQWSEDpyorUqnzrVDYo7OPdPq7VIWH4BNP6X1oiIU
 49Aw==
X-Gm-Message-State: AOJu0YwfuBl27ERrYf3tDGp1aDNTQ9F/9zkH6Vm+j/0tk37EgBQItz/O
 xUdhyoCt+qi1La6IX/flSvYCRicO1nKdcCCKi9Be5w==
X-Google-Smtp-Source: AGHT+IGL7n0LQaA8rU8z4zS4ds9RhZwdc48BjVhl9lsiFZ0sevBaFWry1wSozalG5SE5AODBHOmTX0QWcSYRwUSwu6E=
X-Received: by 2002:a1f:7387:0:b0:4af:fd28:975 with SMTP id
 o129-20020a1f7387000000b004affd280975mr112002vkc.5.1702043977286; Fri, 08 Dec
 2023 05:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20231119172310.1307942-1-i@shantur.com>
 <CAMty3ZDK3jcscgNfMZj4SySK6Kd9L1ZJ6nwaM3eJU_VTBA7yvw@mail.gmail.com>
 <CABEcMwXQaxfW9T9-Grpdf8jjjLn=4c=oV-e3cxgwd9wgerG5Sw@mail.gmail.com>
 <CALeDE9NgZ_zRGgxo2kBaKYAKF-8tKmt-Eoddxf=8U2Q=T29Yjg@mail.gmail.com>
In-Reply-To: <CALeDE9NgZ_zRGgxo2kBaKYAKF-8tKmt-Eoddxf=8U2Q=T29Yjg@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Fri, 8 Dec 2023 13:59:26 +0000
Message-ID: <CABEcMwUDnAQG3h-jrPEim2u_19UMtqhjcG5cSiE-QpjawHACCQ@mail.gmail.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
To: Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
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

Hi Peter,

On Fri, Dec 8, 2023 at 12:59=E2=80=AFPM Peter Robinson <pbrobinson@gmail.co=
m> wrote:
>
> On Fri, Dec 8, 2023 at 12:52=E2=80=AFPM Shantur Rathore <i@shantur.com> w=
rote:
> >
> > Hi Jagan,
> >
> > On Fri, Dec 8, 2023 at 11:13=E2=80=AFAM Jagan Teki <jagan@amarulasoluti=
ons.com> wrote:
> > >
> > > On Sun, Nov 19, 2023 at 10:54=E2=80=AFPM Shantur Rathore <i@shantur.c=
om> wrote:
> > > >
> > > > Rockchip SoCs can support wide range of bootflows.
> > > > Without full bootflow commands, it can be difficult to
> > > > figure out issues if any, hence enable by default.
> > > >
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  arch/arm/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > index d812685c98..fca6ef6d7e 100644
> > > > --- a/arch/arm/Kconfig
> > > > +++ b/arch/arm/Kconfig
> > > > @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
> > > >         imply CMD_DM
> > > >         imply DEBUG_UART_BOARD_INIT
> > > >         imply BOOTSTD_DEFAULTS
> > > > +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
> > >
> > > Yes, but better to give this option to specific board vendors as
> > > defaults are enough to boot 1st bootflow and what ever media's it has=
.
> > >
> >
> > Yes, that's correct it is enough to boot but by default there is no opt=
ion
> > to choose what to boot from.
> > This was discussed in an earlier version of this patch [0] where I was
> > explicitly enabling only for RP64.
>
> What actual extra functionality does this provide, what is the impact
> on the size of images? You've not provided reasonable justification
> outside of very vague statements, it would be useful to know what the
> added options actually solves.

BOOTSTD_FULL enables all the options in bootflow commands. This is needed i=
f
- you want to choose between multiple available bootflows rather than
just boot one default.
- if you need to list the available bootflows that bootstd has found
- if you need to select and boot any bootflow other than default.
By default all other commands in U-boot come with options to show details
For example, nvme info, nvme detail, usb info, usb tree but with
bootstd no way to know anything.

Image size - u-boot.itd without BOOTSTD_FULL - 1193984 bytes
Image size - u-boot.itb with BOOTSTD_FULL - 1214976 bytes
Difference - 20992 bytes

According to binman for RK3399 u-boot can take upto 4M [1] so we have
ample space.

This was discussed in the previous patch in the link below [0]

[0] - https://patchwork.ozlabs.org/project/uboot/patch/20231111001329.53770=
4-1-i@shantur.com/
[1] - https://github.com/shantur/u-boot/blob/master/arch/arm/dts/rk3399-u-b=
oot.dtsi#L68

Kind regards,
Shantur
