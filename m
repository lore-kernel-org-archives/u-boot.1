Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A3CCD11DD
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 12:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B3F188246;
	Fri, 29 Mar 2024 13:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Txi0S0cE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9757688243; Fri, 29 Mar 2024 13:48:35 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9985587E53
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 13:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-513cf9bacf1so2358142e87.0
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 05:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711716513; x=1712321313; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DdITQpz23zXCvaTOjJ8DN+MRmHNSMfPr7Xmq1auFKYw=;
 b=Txi0S0cEfO3V8GHHKFLK4FKdoE59hhQ1iEdhK0CZgLQc7d9TP11M2s3SMXVIEW+KEs
 yiYnqlpd97tqPH2R0rxdiMf1qZcdWeaQp5KfC+SP6LiAOGCkGQS3mLltKfbx2irHUJiQ
 69wqJpXhDkFCo3po+SgXOufSOfj3fEV3dWLj/deqWvU3QBRXnSa8nWXJwtQbAn6UzXAr
 Ipc999hYE4Qa/E1I5NEZZ1VLYddod8m+6XAWwSu6+HWRXzDiOuPic7HfAIXPyQnoDPfb
 Xkb3o9/xEFzI4Gbarq26U0L/nk+ul/lPOrn5ENzoCQb5fyAWxod699l+h+VIi+SrHEEo
 XTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711716513; x=1712321313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DdITQpz23zXCvaTOjJ8DN+MRmHNSMfPr7Xmq1auFKYw=;
 b=wm3KkQzNLg5bTTMk6opbu/Ak0rcQHRmBMJvHKl0EDjIUl7WkinxShqSuG+ESI+aIu1
 MB8cJ9ccb93j2Fk3l4XxJWGnb2UtUivOOesUmwUU6lAfKn5fSeSjNITpRgHJBxOZPFwL
 EYWb18aOWuSscA0oC3PPtHNsEA4t0sNpzSfFufoDXPaGFYb+otWiRJcedU2883RlNc1y
 2sj42lP2eCAMsbqDke/bpTaGt21T3tRcGExSPrsaga8tVZNTY0LFEK7pvp7VlGUttSHe
 MAGTkHBuQ72K2b0zKEoJj7YYiN01iQSbTsrlOn/u5JjVSPpCWQwWvrBp2DL8MPKSdx+3
 2fMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3oUILQ9l/5iqmmXvyx3jjU6tOBkJocr3Pc5fl73liA+9U6JSbyk8EDzufv6d+gUiuQI7BN5kFt7vXedxCxwWvZKDplw==
X-Gm-Message-State: AOJu0YwbN18vn1M1Y2TrcelDKFb+W3ddMZ+tEhzgkyUy1tJJoHJ5PIJq
 7rX5CIJEZYILmMoZeaHlt9cEHlSPjK4CGM/QcVvqIMm7SbkKXI8S1rQjU50OHA7+oxwKM48Cich
 YQm3h+XaIoItq4x28r3aD2YZQxMwDV9ASpfhxbg==
X-Google-Smtp-Source: AGHT+IHDeOmi7BEr/TIHKojGKrEvGpIR2B4Xpk6tU/cW6QMBMS2bGvLsITmgPjBNN7EcQYBSoaa/KKE8BJeMo1bTiI0=
X-Received: by 2002:a05:651c:1508:b0:2d6:a1f7:2a12 with SMTP id
 e8-20020a05651c150800b002d6a1f72a12mr1667711ljf.38.1711716512940; Fri, 29 Mar
 2024 05:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240329071929.2461441-1-ilias.apalodimas@linaro.org>
 <87msqh8bta.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87msqh8bta.fsf@bloch.sibelius.xs4all.nl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 29 Mar 2024 14:47:56 +0200
Message-ID: <CAC_iWjL_xd-ax9uoX2Sba-xX16TtNvk-7_EhUPov9gaLpjmfoA@mail.gmail.com>
Subject: Re: [RFC PATCH] efi_loader: conditionally enable SetvariableRT
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: ardb@kernel.org, kettenis@openbsd.org, pbrobinson@gmail.com, 
 xypron.glpk@gmx.de, u-boot@lists.denx.de, trini@konsulko.com, 
 caleb.connolly@linaro.org, sumit.garg@linaro.org, sjg@chromium.org, 
 abdellatif.elkhlifi@arm.com, takahiro.akashi@linaro.org, 
 sughosh.ganu@linaro.org, kojima.masahisa@socionext.com, bmeng@tinylab.org
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

Hi Mark,

[...]

> >
> > Open questions:
> > Looking at the EFI spec, I can't find a documented way of notifying the OS
> > that the storage is volatile. I would like to send a hint to the OS about
> > that and I was thinking of adding a configuration table with the filename,
> > which U-Boot expects to be on the ESP. Alternatively we could add a device
> > path which would be a bit harder to parse from the userspace application,
> > but safer in case multiple ESPs are present.
>
> Should there be a way for the OS to opt-in to this new behaviour?

The feature itself is in a Kconfig option. If we agree on a way to
notify the OS that the variable storage is in RAM and hence volatile,
the OS is free to ignore it I guess

>
> > Since I am not too familiar with how BSDs treat and expose config tables,
> > we could instead add a RO efi variable with identical semantics, which
> > would be easier to read from userspace.
>
> There is an EFIIOC_GET_TABLE ioctl that allows retreiving a table by GUID.

Ah thanks. I am leaning towards an EFI variable now to signal the OS

[...]

/Ilias
