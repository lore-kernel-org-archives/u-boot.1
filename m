Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A15CC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 16:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C0D3877F3;
	Wed, 27 Dec 2023 17:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u0KgmERf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFDD9879B6; Wed, 27 Dec 2023 17:11:18 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78A0E877F3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 17:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-28b82dc11e6so2004819a91.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 08:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703693475; x=1704298275; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qQmIACnIyDqhlfBXm+dRNQ6T3TzMr9CywGvJaHMig1E=;
 b=u0KgmERfMPEEWn7fSZnOctOOKZHZ0aHi8k3RVxjO7PydwrW1DR2XNiv3kwacySbvwu
 bt5VtGq/d8EnlGBaXRcl8HEv89sVqUdBl14VY5NZT4c2UhKQjR7gKmV2EpS2ff9JhL6F
 Ap4MA4y/tZ7Iy0Hk0RVBN3oSl8siNgskvymVXxcZTN1Vr50MHRdHBqyeJz1+KCX/Hj/B
 uJl//O+MGN+Jd+90doRXGkNHULTB+8KZ977BVoBy1APuVsKpRq6zqrn5N/AD/c2yXkI8
 OE7F9ag5bFVGxF2Ilxm3B1ZjfRABYtqQ9laZ1xS4+UUzqFDWAEFCeI16WP4nRImj4kdu
 YlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703693475; x=1704298275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qQmIACnIyDqhlfBXm+dRNQ6T3TzMr9CywGvJaHMig1E=;
 b=K7+/h7bI1F1Cz2Zrioq0VI21SyMlrepDIiIZ+9yBUoAo+BmfM2EEuA1c6PceP2gWRP
 H9EZtgAMn/8k40QQamOg07XG+OE+C3VyKUdxvMDKGSlGnWuLw3MQJgz2vHDa73LOAsUw
 /Sp+lRydMtpvSHBeL1T0gtjpAy436AozcUjW57oifJxTo97FXIW+rkJymho0wtSm1+mN
 WOhqWkAN8sni7LMoEfsVyXkYXg+KrRbeqzWhuKbcrV1BqoTjMtYRf5yjj5XXIh2zeRCU
 LL/gBA10wq4S+XSntGZVI9hscudfIAYdtBXeQiYf7wquLa6AS2aYK7KtTONpBW3R3DSn
 Ggew==
X-Gm-Message-State: AOJu0YwWfmNMOyCgC40m7Aarx2xlYXXgEy8GkT6vgmvSRXNwlzrWCExQ
 Y0xu4HnSzm7+hF2MYfSesZtWG3ZIMUdMBg9JZdTUFDpvR2w1HA==
X-Google-Smtp-Source: AGHT+IG+VWSLPGcEhh4iMK21p7AEfG76wTQEgI/E77e4uysn674hLbTc+iDCv7WirEq1mw3T1qT3Q7C2B+CEZUmqX30=
X-Received: by 2002:a17:90a:be14:b0:28b:d983:a104 with SMTP id
 a20-20020a17090abe1400b0028bd983a104mr2568155pjs.39.1703693474795; Wed, 27
 Dec 2023 08:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-9-raymond.mao@linaro.org>
 <CAFLszTg=TZaO-EKoqRf8dH1Kf9WHO-OGWzsg0k8-+riuyN8EDQ@mail.gmail.com>
In-Reply-To: <CAFLszTg=TZaO-EKoqRf8dH1Kf9WHO-OGWzsg0k8-+riuyN8EDQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 11:11:04 -0500
Message-ID: <CAEfUkUKe-JPHEN7bkrB+tkQnKbJdAkbqt3sC-Je8ox-9V++_sA@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] fdt: update the document and Kconfig description
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>
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

Hi Simon,

On Tue, 26 Dec 2023 at 04:48, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Fri, Dec 22, 2023 at 9:32=E2=80=AFPM Raymond Mao <raymond.mao@linaro.o=
rg>
> wrote:
> >
> > Update the document and Kconfig to describe the behavior of board
> > specific custom functions when CONFIG_OF_BOARD is defined.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  doc/develop/devicetree/control.rst | 6 +++---
> >  dts/Kconfig                        | 7 +++++--
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/doc/develop/devicetree/control.rst
> b/doc/develop/devicetree/control.rst
> > index cbb65c9b17..e061f4e812 100644
> > --- a/doc/develop/devicetree/control.rst
> > +++ b/doc/develop/devicetree/control.rst
> > @@ -104,9 +104,9 @@ in u-boot.bin so you can still just flash u-boot.bi=
n
> onto your board. If you are
> >  using CONFIG_SPL_FRAMEWORK, then u-boot.img will be built to include
> the device
> >  tree binary.
> >
> > -If CONFIG_OF_BOARD is defined, a board-specific routine will provide t=
he
> > -devicetree at runtime, for example if an earlier bootloader stage
> creates
> > -it and passes it to U-Boot.
> > +If CONFIG_OF_BOARD is defined, board-specific routines will provide th=
e
> > +bloblist and devicetree at runtime, for example if an earlier
> bootloader stage
> > +creates it and passes it to U-Boot.
> >
> >  If CONFIG_SANDBOX is defined, then it will be read from a file on
> >  startup. Use the -d flag to U-Boot to specify the file to read, -D for
> the
> > diff --git a/dts/Kconfig b/dts/Kconfig
> > index 00c0aeff89..12d61dc748 100644
> > --- a/dts/Kconfig
> > +++ b/dts/Kconfig
> > @@ -110,8 +110,11 @@ config OF_BOARD
> >         default y if SANDBOX || OF_HAS_PRIOR_STAGE
> >         help
> >           If this option is enabled, the device tree is provided at
> runtime by
> > -         a custom function called board_fdt_blob_setup(). The board mu=
st
> > -         implement this function if it wishes to provide special
> behaviour.
> > +         a custom function called board_fdt_blob_setup().
> > +         If this option is enabled, bloblist is provided at runtime by=
 a
> > +         custom function called board_bloblist_from_boot_arg().
> > +         The board must implement these functions if it wishes to
> provide
> > +         special behaviour.
>
> Again, this spec is not board-specific, so it should work on any ARM
> board, without board-specific code, just by enabling the feature.
>
> dts/Kconfig is for all platforms. And from the view of a non-ARM platform=
,
this is
still platform-specific.

[...]

Regards,
Raymond
