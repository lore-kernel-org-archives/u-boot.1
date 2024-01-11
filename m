Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C9BC4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 02:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D085E8771B;
	Thu, 11 Jan 2024 03:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YRqNS8ay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C455581EC8; Thu, 11 Jan 2024 03:20:32 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A7FD8771B
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 03:20:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-59502aa878aso2399939eaf.1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 18:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704939628; x=1705544428; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QOYuga1JrjCi3+oGimhnQ09lRprt530cPWKZulnOv8Y=;
 b=YRqNS8ayXsw429SrQLc3df+1Mue4Imi3Py9mHYuHSpNqkdEi3/znuloyLww9wWpBk9
 +aUGkQqSMnlk+wHPfaR+Cj9tCFWqt9ESqB08VG6iwNDu7ceXl2kSGc4CIm61YM6+7sAo
 WTxYD2ZPq1iBHi/9k9+p+rNwzF4uoX1gyWhh1xPr7ChcLOUpDbDkhqygAov4sgZkt0bf
 PTIfi3FCcRehmufVTmDo2ZrCGyu4DJM+jjDNM8PiksTtPnsKf3L2KiyAm4FriQQYUrpF
 EgNMp/K1C9WPhkVoyyg0mQUOhfTY9ZdO+Z7En/AzcWLqcvRcNfN71BZwAjoE3tAXWJUG
 phiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704939628; x=1705544428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOYuga1JrjCi3+oGimhnQ09lRprt530cPWKZulnOv8Y=;
 b=mP6Kt0JP0eXovIIdl13EO+qKQj6lknnQfa0/w6lNgauCIrSJ2aJ/iixyz9mdw4g267
 h8sy7Drr7YlFLaxe3dJ+e0unn3mUeLiRWuDgymP7aBqqCnqflxlw8nwLJj7qtsh1SFv6
 WXzTu+b7UZLm5lb438JgR/TIrMZs9yS6IHFAM9yLADmtBAHJunJFyR3JI6gLRbkgMBE9
 qUtt+OTMprXbg8bNBJ9wcnA1Ov28yzghc9ndJvGj0mNV3Ch5gEHStQ5jdGeRXCUhVya9
 NSvIiqRfA38ixF3lgwuV6owGJObxfmVMm84E7MtHhx50YP6YfEMsC4zAJh6LDbg4KE0G
 XslA==
X-Gm-Message-State: AOJu0YxPDqYcX3lk0H6B2Aoe8x1GbvrMkBugf+PbfL/YsNLCDwGSCMPn
 +KqByXX90GkZv3/8zc7vFWscaD/Q5oHBrMxaJuBMaJrnTnLUyg==
X-Google-Smtp-Source: AGHT+IE5MBx2cvBwkIowNjvjzx7sntyDDUOtRwfUyNjZ1Z88UtZRGKhJ4V9DaI+HulIbcQFoGysOeJ+UzzH7FTcy+30=
X-Received: by 2002:a05:6359:595:b0:175:9e9a:45c4 with SMTP id
 ee21-20020a056359059500b001759e9a45c4mr485376rwb.28.1704939627765; Wed, 10
 Jan 2024 18:20:27 -0800 (PST)
MIME-Version: 1.0
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
 <20231213031646.28828-5-semen.protsenko@linaro.org>
 <CAFLszTiALRT-32ZzdUa14FfBz6nwREbGsJnZw=-5gpi4L=y9sw@mail.gmail.com>
In-Reply-To: <CAFLszTiALRT-32ZzdUa14FfBz6nwREbGsJnZw=-5gpi4L=y9sw@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 10 Jan 2024 20:20:16 -0600
Message-ID: <CAPLW+4=P7nd0WhrbPCgUEfqQMhmAVeK0TDW+QzC2oo71Hu2SKA@mail.gmail.com>
Subject: Re: [PATCH 04/13] soc: samsung: Add Exynos USI driver
To: Simon Glass <sjg@chromium.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
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

On Wed, Dec 27, 2023 at 11:49=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Sam,
>

[snip]

>
> Just a few nits here
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>

[snip]

> > +
> > +struct exynos_usi {
> > +       struct udevice *dev;
>
> Can we drop this? It doesn't seem very useful and we try to avoid
> having bidirectional pointers. since it is possible to get the 'priv'
> pointer from the device.
>

Sure. I tried to keep the driver as close as possible to Linux
kernel's version, where I borrowed it from. But if it's the current
preference in U-Boot, I'll fix this in v2.

[snip]

> > +static int exynos_usi_parse_dt(struct exynos_usi *usi)
>
> Use of_to_plat() method?
>

Will do in v2. Thanks for the review!

[snip]
