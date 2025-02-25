Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD371C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 21:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F328C80805;
	Tue, 25 Feb 2025 22:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UCkgkAWM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F69780977; Tue, 25 Feb 2025 22:26:54 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAD00801CF
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 22:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5deb956aa5eso8484756a12.2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 13:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740518811; x=1741123611; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oG1Rwdf8D2rC53Obfat5r8U3fx6ll/5VwQ0bheTt+EI=;
 b=UCkgkAWMuxNH4vxaTpDVmJn2z76y4rZ2FhZYmKVhI2TvJJkYDLmPlh+rOXAIQcECCC
 Z/B4KD1NJp31s36xbxl3yxrC/Z68AS8eyR5LTzX1FE1o5waFqhNhhurE1XihGtobgZ8H
 Ph+EQTNfZ8xSkqke9tS44Xnrc2vCIyp3ZsF+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740518811; x=1741123611;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oG1Rwdf8D2rC53Obfat5r8U3fx6ll/5VwQ0bheTt+EI=;
 b=wpeb3chOGIDpVNHSd35A0OnxnVAyj3SMqYqbMBb9RWR21mY4e/9puuCHk0kyOtMECa
 8KPWkCh9YqnbhGp44LTneAZZBobsBcaNWHw24F+ZpARQTQT9GoQINa28Y2rr31c1RRR3
 HjdQ4YqpnVykJTmVdRunPFoNsKjxw/QJ9AEsKnUJNGprSo42TQD/oNKTEDmUehqp/6hN
 AWdDe5gtDf/Aoj45NYdhyvdDFwreNCNRsNmszvbMRG3upXezNDvnSPwMlRVtkIxHkSeG
 WViy2s8I9oo6BArZ+B7dpOj7XRTAYieG0Kzk33e+DxTTA+nQvwY6SSzd14xg7A6rX1tx
 +ODQ==
X-Gm-Message-State: AOJu0Yy7qFZWdbOufk5OF78UOdOavumWrQ5AKrtYTDs3EbRJKSCqDlql
 IJcyzMhAAyXt9DFBtmmVxABLfp9O2K0ejOlFI9KyB48uDEJRmBKMXjUi76l2xfszMzY03OpsGDQ
 C5OqoeoLvH3sK9yXJjz7N21Ry5fsWCvYCVBrz
X-Gm-Gg: ASbGncvuJfO7E8KF6dmJ5qu6jLYIDs8SPaMhLJh8zD+106DA11Cl8j/bFHlIpPWiL45
 EwTowBmgVnplPE51LsW8EP3rEnNMqf1CfB0FF3ojZ/kplHn3K1ti0X8F9RjJqw8yN0DvApJ16Lx
 a0d3cVPvKA
X-Google-Smtp-Source: AGHT+IFJIEw6qHlEEBpNa7njn+ewiXOFC9/YLPhlLuTW5+R99+bsI+9b/h2N6eGQfrxfNLzmnSfgmLWy3ljWDXMzhR0=
X-Received: by 2002:a05:6402:3512:b0:5dc:ea7e:8c56 with SMTP id
 4fb4d7f45d1cf-5e44a256cc9mr9719577a12.22.1740518811222; Tue, 25 Feb 2025
 13:26:51 -0800 (PST)
MIME-Version: 1.0
References: <20250225200635.3781149-1-sjg@chromium.org>
 <20250225210645.GA2640854@bill-the-cat>
In-Reply-To: <20250225210645.GA2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Feb 2025 14:26:39 -0700
X-Gm-Features: AQ5f1JoUjtkfykLsPJXsGrVSGfk92wiEoC19ehrdcQOl8lpC_RwkWEOlBAGR_YA
Message-ID: <CAFLszTig7O=Eyx+C0xAsxkJi+rP_ghXgXBxUwN47GZLxg-KFwA@mail.gmail.com>
Subject: Re: [PATCH 0/7] binman: Check code-coverage requirements
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Kochetkov <al.kochet@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
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

On Tue, 25 Feb 2025 at 14:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 25, 2025 at 01:06:25PM -0700, Simon Glass wrote:
>
> > This series adds a cover-coverage check to CI for Binman. The iMX8 tests
> > are still not completed, so a work-around is included for those.
> >
> > A few fixes are included for some other problems.
> >
> >
> > Jiaxun Yang (1):
> >   binman: Workaround lz4 cli padding in test cases
> >
> > Simon Glass (6):
> >   binman: Exclude dist-packages and site-packages
> >   binman: Drop GetRootSkipAtStart()
> >   binman: fit: Drop unused code
> >   binman: Drop algo check in CheckSetHashValue()
> >   binman: Workaround missing test coverage
> >   CI: Run code-coverage test for Binman
>
> While we likely need Jiaxun's fix in order to be able to update to
> Ubuntu 24.04, the series itself doesn't apply to -next, please rebase if
> you intend for this to be in mainline, thanks.

OK, would you able to pick this series up?

https://patchwork.ozlabs.org/project/uboot/list/?series=444576

Regards,
Simon
