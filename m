Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238A2C4167B
	for <u-boot@archiver.kernel.org>; Sun, 10 Dec 2023 00:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C8686308;
	Sun, 10 Dec 2023 01:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="Hl3bCg9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA39087078; Sun, 10 Dec 2023 01:04:38 +0100 (CET)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5191A803AE
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 01:04:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7cac4a9faccso290386241.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 16:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1702166675; x=1702771475;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9z8VGgJzkJclJAaFmfaqA3N63FGIxVQJCSI9qtljYE=;
 b=Hl3bCg9g/RS70hhr9OAK27l0+9nafPxh2efYUvpE0L9fjg6d6tDuVufBW3KfPFu9s9
 JykY7+QY2dWJL95ZLUsRWUnxwZja6iNvvji0m5xuy8HVFdAbHxwwJunSIZ4Y7w6Qr62e
 uZLhCHsEcVX0ps6X4OfXZj8d1SzIdULweCDSagjJC92/Ji3xQqD8zTWEsnH0pbJlvZZT
 A8dYb4LwtIZj1MGp92Q/S/GIZOLsCzE73UgxLxcaCjf18XcIJbN3k0OAopaIaVJ0FVdk
 4e35SlM8vWqJ5SvLUTxr66fvCdSqna+1KVBZuxAJNZUYuullPU/50oq/driHm0321chM
 UKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702166675; x=1702771475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9z8VGgJzkJclJAaFmfaqA3N63FGIxVQJCSI9qtljYE=;
 b=T/iNrouSD/N1Hz/PWzIpv9h3QFLVhk9u4FxpkYZiWoC9xcBUSkhKm6B0Y4r1uw5VpT
 FYLUillABUGJrQwQkMQ7xoCavtXbPPeHvM3jBV6QB9ohbXALcdob748fxE1aP2QeoHih
 Djk+k40xglS8ST/IZ7ZCUp3vO/xsKBhSIPC6KxOBzCaUgVsapUkUrI3kbUxu9yBbvfDg
 0F/kKGtlNl+EFakKs/kR6M3UvoYDaf2aCeLvqQPizzKJ2GFdbXN4z8ZPhGo7S11/l0Sc
 hWyxlA0U18QhtaqJjmy2UgijqX+x8vzdkQ1PFiY6BQbW4os+WEabt5XDqxwf2GTPtMAI
 4oSw==
X-Gm-Message-State: AOJu0Yzty+lW99zbp19LFNhii1xUaxXnGfsxzdQ26P/vWEPvx8Djb6tT
 ZN9mkJO7SgHLxghva0YXTq2VZx8bQ3Oyuu0zWEB37A==
X-Google-Smtp-Source: AGHT+IH0EI5hdcPjXCR3j57T+20bwTGgHU9XGZM7S/n/VcnQtd6DT5igXiBITJZdyoVYOBAWtlkpFz56Px4cAcvmh+4=
X-Received: by 2002:a1f:6ec3:0:b0:4b2:e4e1:827f with SMTP id
 j186-20020a1f6ec3000000b004b2e4e1827fmr1939008vkc.9.1702166674968; Sat, 09
 Dec 2023 16:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20231208000947.248849-1-i@shantur.com>
 <20231208000947.248849-3-i@shantur.com>
 <edd57912-f38f-4589-bb21-c638db8535e1@denx.de>
 <CABEcMwWA1FzdPtvRBwk_9KaXC12R1OCDMoOtuFSvuG8XhphQdQ@mail.gmail.com>
 <e9e44210-0330-4ecd-96e1-629ef519202d@denx.de>
 <CABEcMwWhBUj4CFz8XbYYuhntRzJGZXKUoQ47QLo29XC3DNdGmw@mail.gmail.com>
In-Reply-To: <CABEcMwWhBUj4CFz8XbYYuhntRzJGZXKUoQ47QLo29XC3DNdGmw@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Sun, 10 Dec 2023 00:04:24 +0000
Message-ID: <CABEcMwVO+z15kLMRMxydxL8rdNi7rN4H_EEdFmKiNz5HdKv3QQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dts: rockpro64: Disable usb regulators-always-on
To: Marek Vasut <marex@denx.de>
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, 
 Jagan Teki <jagan@amarulasolutions.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
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

On Sat, Dec 9, 2023 at 10:20=E2=80=AFPM Shantur Rathore <i@shantur.com> wro=
te:
>
> On Sat, Dec 9, 2023 at 10:05=E2=80=AFPM Marek Vasut <marex@denx.de> wrote=
:
> >
> > On 12/9/23 18:57, Shantur Rathore wrote:
> > > Hi Marek,
> > >
> > > On Sat, Dec 9, 2023 at 5:31=E2=80=AFPM Marek Vasut <marex@denx.de> wr=
ote:
> > >>
> > >> On 12/8/23 01:09, Shantur Rathore wrote:
> > >>> USB port regulators should be controlled by phys
> > >>
> > >> PHYs
> > >>
> > >>> so we remove always-on property and let phy manage the
> > >>> regulator.
> > >>>
> > >>> Typec port has misconfugred
> > >>
> > >> misconfigured (typo)
> > >
> > > Thanks will fix both typos in v3
> > >
> > >>
> > >>> phy-supply in upstream and
> > >>> now that we are removing always-on, we need to fix the
> > >>> phy-supply until its fixed upstream.
> > >>
> > >> Where is the upstream Linux kernel patch ?
> > >> Was it submitted already ?
> > >>
> > >
> > > No, there is no patch yet for this in Linux upstream.
> >
> > Why not ? I would expect the fix should be consistent between both
> > U-Boot and Linux .
>
> Yes you are right. I will be raising a patch for linux too.

This has been published to devicetree -
https://lore.kernel.org/linux-devicetree/20231209233536.350876-1-i@shantur.=
com/
