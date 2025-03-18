Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EC0C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 15:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 334E781026;
	Tue, 18 Mar 2025 16:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZnuL/5JN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2AA810F4; Tue, 18 Mar 2025 16:24:16 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAF7D800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-abbd96bef64so1014795666b.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742311454; x=1742916254; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9ynchHR1rdhOhNAdlgd6LOVJR3sPIw6GGCPJhAFU4NU=;
 b=ZnuL/5JNBJYXocNdKYQWoI3apH1c/0Wd1SDXbZLTdg54YxPOxfIZGZeClty2SgtYTv
 79V3L1Z2Duwe34EqoHtFf985LlPHOhhyJbp3OOyC3uTcH98SD2Wym0wQUj2Z+Fd//p8Q
 MeoB3tasQdbRsCkBeu8vUVIPtNEYNcuTUA84o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742311454; x=1742916254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ynchHR1rdhOhNAdlgd6LOVJR3sPIw6GGCPJhAFU4NU=;
 b=Km5V9h4jdm4+WASk/QnyF5YCPGiz9W4OMtPI2p++b3RJ7+oKZzcMOPy/9XjsbVe1a8
 4qS4U0CiHkyQufPDOvyGlPcGrA0BaqCNyWFhPnvE21ZBdcAjKFigOh6rnhrGrkhOO4BA
 0ZCNUKp+XKcR+mAQLb4Uf9FF+UR0JVbMrawSeDJSOqAIRPGStIHrTM0g8aRshSenhMiW
 88B4UF9eFREsgx0T81hrQ+G3qc4e4RfF/WVICgUfhtNHC1ViFVEMg6ob0UrqCzMKM7dy
 LQIQSejr71R8m21GiJwES0/0qupYSq9q8Q/cRfIDPDDEy7oINE0ej228zHPiAaYRU+22
 U0Zg==
X-Gm-Message-State: AOJu0YydVKnS5IwrI3789uYi4lVmVeGU4rha1RHiI6WeJm/K4T293OcU
 90167H9HCVAIa9sAzr+MaWhIB+UcMRfunPyuj4bOUBhgXRpnqWnPc1JwfkX71KPzcBwmX72TCD7
 4PBUU+wJ6RPmlAe5VrxMG2pJEo9E4XOcQ4MAf
X-Gm-Gg: ASbGnctYQwLmE3GuC7eGYtJb8p0QSa9+Ceu5og6Sl2jxD56cNWpJkBM3vzS9cyfuByv
 92ciHVhqh1ffyTjKGbZaN/WTy35Njw2jZIT9jUU4VI5h2sYtRc/QDC8r2D4Jhsqu5AKvpwPkH9i
 Vvr0RVNQDpDAMxJQBWRhHrf1p11bY=
X-Google-Smtp-Source: AGHT+IFBlyxgDn1o/Xv9GTLn3xecZZYepNxOrTxY/MpXeXnd3zmL3lo12paeUiIHbctgCJFJ+mJ4TDCWvtW3tAtjgy0=
X-Received: by 2002:a17:906:f597:b0:ac2:a4ec:46c2 with SMTP id
 a640c23a62f3a-ac33041c003mr1619902066b.49.1742311454374; Tue, 18 Mar 2025
 08:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-39-sjg@chromium.org>
 <20250318140400.GX2640854@bill-the-cat>
In-Reply-To: <20250318140400.GX2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Mar 2025 15:24:02 +0000
X-Gm-Features: AQ5f1JoFUNupUV28Ac13N_MNKSvoj1ez2T86bR8fLTszGHdOu9kewiVZmzilqqQ
Message-ID: <CAFLszTgCZSydxeNoeVGrR9SF7-_9pZjU+NBGXVDgXG6WzYyCYA@mail.gmail.com>
Subject: Re: [PATCH v5 38/46] boot: Consider non-bootable partitions
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Tom,

On Tue, 18 Mar 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Mar 15, 2025 at 02:25:58PM +0000, Simon Glass wrote:
>
> > Any 'bootable' flag in a DOS partition causes boostd to only scan
> > bootable partitions for that media. This can mean that extlinux.conf
> > files on the root disk are missed.
> >
> > Put this logic behind a flag and update the documentation.
> >
> > For now, the flag is enabled, to preserve existing behaviour. Future
> > work may provide a command (or some other mechanism) to control this.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Isn't this backwards as the existing behavior (prior to bootstd) was to
> scan and use these files, and so that's the behavior we need to preserve
> by default.

Not so far as I know, but I've already spent too much time trying to
decode those scripts.

If you look at scan_dev_for_boot_part, that is what I was trying to
replicate with bootstd.

Regards,
SImon
