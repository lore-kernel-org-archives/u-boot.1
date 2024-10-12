Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88362D1A443
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 07:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3D0288E0F;
	Sat, 12 Oct 2024 09:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AnrDS+kD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE8788E11; Sat, 12 Oct 2024 09:40:37 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BA9F88970
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 09:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c721803a89so3786396a12.1
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 00:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728718834; x=1729323634; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FHfl0l7MNXKAVfkg95QuMt9xRD/1AiIhszx4jlSCnfQ=;
 b=AnrDS+kD+X5kc4ZxCZwjUqhtuURG4PsgrCLRNkC2OI9ybPdfeiN1xa08fEgFx2C03i
 S97aaeBEJUGJlBnuZwmewc/qLfzzd2TQAfKF7Er02xF/Ht+PjQIXJs/MD2NmLLmre+of
 r0+gTb/lB7pnnbE8+ieVzXxtVwsseyv6UwWCkoQHo5ua23ylFddGlRhlGLFUsQRV1BEs
 RAwsH9FEnLt1CX296uXRkneaylW5CDt3cpZa5iw1+J1j7GJzTBr800kVVt4YwtoaVB7s
 oKMTNHR2JrqILrKyPrgQZWKY5FqDjJ0Z0UFV2R5U117j42PWe+JA4T+87UL9fo86gbHq
 yggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728718834; x=1729323634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FHfl0l7MNXKAVfkg95QuMt9xRD/1AiIhszx4jlSCnfQ=;
 b=ONx5WKva4DSm9ugwcaQULvMSiiKAhgQCj+6UoYxQhS4cRp60pWIViqjMbRyDehrAjn
 ajXCgsMuNmTaTE6mAzqJYZdJOzN59WlmJ6FRfWcatnhZ3usdRhvQTTZbPTHlrdS894E6
 QeGtOv/zvIfu20CYQwcYo0flrJXFNLsnOdyw3HKLBpaEZVquAar9VPdcZ2EjQV0eOypZ
 D5MNGY2Ax2TVE2G2bEHAjpzSS6Gx+mZsXZWcq/RDeeIroahOMEvktwc6BgJNn28beI6o
 AJ3yArnMR3Po0lAEXrPsWRDnln821xSOGFqMNdaPECPr80ys4gdzawLnYcqdrF0a7YHs
 bCrA==
X-Gm-Message-State: AOJu0YzP1xj+nmQFO/Fmqu5EBq3eJ9n6eiGzSJaEEa8UutckUc3f0zPP
 TDoeVLgS76Obe7ZLnRc86YmtWhwZgXFvvwU7RNP5ANITMtUvs9e2LF7a7CGyLsUhC8Gl0+cBO9P
 M0SfHSQedGjW9oCuvrwDH6lweaR8MiQWm9QyQttWZ7I2dGYQv
X-Google-Smtp-Source: AGHT+IFzmsnREVloTNiP10ZXrsPFG1rGO0urHgthcRCqHmFkW7/IejngeskIJPC/doluCXW84pEiIIkdlMyhulOpSFo=
X-Received: by 2002:a50:c907:0:b0:5c9:f49:fbc6 with SMTP id
 4fb4d7f45d1cf-5c95ac610b8mr923572a12.34.1728718834507; Sat, 12 Oct 2024
 00:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
 <20241008181435.1753814-5-sughosh.ganu@linaro.org>
 <CAC_iWjKMoLz2=cwMP6gebeHYdf0XBXfai+ou5F0_6OVMchEGhQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKMoLz2=cwMP6gebeHYdf0XBXfai+ou5F0_6OVMchEGhQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Sat, 12 Oct 2024 13:10:23 +0530
Message-ID: <CADg8p963a4d5DLZ-ZvvR55HjAz4dT_gpvGrRVEp3RT7afFEwbw@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] lib: Kconfig: add a config symbol for getting
 lmb memory map updates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 11 Oct 2024 at 15:56, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh
>
> On Tue, 8 Oct 2024 at 21:15, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Add a Kconfig symbol to enable getting updates on any memory map
> > changes that might be done by the LMB module. This notification
> > mechanism can then be used to have a synchronous view of allocated and
> > free memory.
> >
>
> Are there size concerns to enable or disable this? I think we should
> always sync and get rid of this

This is needed only for platforms that enable EFI_LOADER. I haven't
checked if not having this check would result in any kind of build
failures and/or size impact on platforms that do not enable
EFI_LOADER. I will check this, and keep it if any build/size impact
happens.

-sughosh

>
> Thanks
> /Ilias
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1:
> > * Add a config for SPL stage
> >
> >  lib/Kconfig | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 1dd4f271595..61452f7ac94 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -75,6 +75,23 @@ config LIB_UUID
> >         bool
> >         select SHA1
> >
> > +config MEM_MAP_UPDATE_NOTIFY
> > +       bool "Get notified of any changes to the LMB memory map"
> > +       default y if EFI_LOADER
> > +       help
> > +         Enable this option to get notification on any changes to the
> > +         memory that is allocated or freed by the LMB module. This will
> > +         allow different modules that allocate memory or maintain a memory
> > +         map to have a synchronous view of available and allocated memory.
> > +
> > +config SPL_MEM_MAP_UPDATE_NOTIFY
> > +       bool "Get notified of any changes to the LMB memory map in SPL"
> > +       help
> > +         Enable this option to get notification on any changes to the
> > +         memory that is allocated or freed by the LMB module. This will
> > +         allow different modules that allocate memory or maintain a memory
> > +         map to have a synchronous view of available and allocated memory.
> > +
> >  config RANDOM_UUID
> >         bool "GPT Random UUID generation"
> >         select LIB_UUID
> > --
> > 2.34.1
> >
