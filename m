Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52926C5AD4C
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2692875EF;
	Tue, 21 Nov 2023 03:17:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CJZzriaN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14C3D875D1; Tue, 21 Nov 2023 03:17:27 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6408E875DD
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5ca8c606bb7so15488957b3.1
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700533043; x=1701137843; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pHH7m1grM7cLbpt1cMCOtRx/mIsH3GwMULvS5X5ecPI=;
 b=CJZzriaNNgmluxwHbgaAEPnvUd8gvvC1fOCKm7XB5nTB8sCaa3WtFbn+TAl7yaVR+i
 4avcqKdpB3tTpWmhdzhO5ww02U8Tivu2+Hs63VcFZn3AY8SIfkkrbYyRUpv0dFzpXdjT
 4aeA+N3L0V4r5DOvtB431ZBHmf7DsuaM8YY6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700533043; x=1701137843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pHH7m1grM7cLbpt1cMCOtRx/mIsH3GwMULvS5X5ecPI=;
 b=lHnmlZeP6c30qP8P/uT5zRCJruItnxgWgE0E0I2+mj2RrhyJIpa7ZQF1yb6wkPVqOG
 K1cFDeEAbU3x8jZ5vmBQLHGikSdVat1Hw2/eJdO/Ia4MAzUQM+OrA5Zlwd/XutrofgEo
 lGDQiYK1LK2OL5YB9Ytl7BUJD4hYWipo9tq4ESOQ60glABTylTWpNHJvr8/ZkwT6TBJA
 9qXi55XwK8lcV8LVm1ROckhXtDfwRxOE/srNi4ZwyxTXBjtvZeu8b/WQffEW5uDmh6bi
 S65PLGJ/yuN5z1MGIAEKJdQRTfPJHHIlnFSnwobxt8E29OjkreF5AonjpWDn7ZipmP69
 IFgw==
X-Gm-Message-State: AOJu0Yyxx2cIfXMsbNszkKCl9jEQwTmVx28vcxEYUTL1c9QMEm0gvZ+H
 UI4WFu4hE//JUQAQBsP/xNc/n4jhHRSHr7NogoIQ8Q==
X-Google-Smtp-Source: AGHT+IFcxfSaRudqwtK/1l2ugwF+xnXjeykXwFAfoEbypN4MGB+VoOhtGWdRkMxLZ08MlP5dHpMHWknvgLpWZapeu0E=
X-Received: by 2002:a81:400a:0:b0:5ca:e51c:791b with SMTP id
 l10-20020a81400a000000b005cae51c791bmr3104579ywn.39.1700533042948; Mon, 20
 Nov 2023 18:17:22 -0800 (PST)
MIME-Version: 1.0
References: <ZVu_3pxqP7Xg7DTn@alg-gentoo>
In-Reply-To: <ZVu_3pxqP7Xg7DTn@alg-gentoo>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Nov 2023 19:16:07 -0700
Message-ID: <CAPnjgZ16rBV4B09yz6Zbu1J4RwV0z-cE9Vi7mLU9KY33zYePrw@mail.gmail.com>
Subject: Re: [PATCH] drivers: misc: Kconfig: Fix SPL_FS_LOADER prompt
To: Alexander Gendin <agendin@matrox.com>
Cc: U-Boot mailing list <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

On Mon, 20 Nov 2023 at 13:22, Alexander Gendin <agendin@matrox.com> wrote:
>
> Both FS_LOADER and SPL_FS_LOADER have the same menu prompt.
> To avoid confusion, make prompt for SPL_FS_LOADER different.
>
> Signed-off-by: Alexander Gendin <agendin@matrox.com>
> ---
>  drivers/misc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
