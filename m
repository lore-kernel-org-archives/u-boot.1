Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D84EE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A35C88E8A;
	Thu, 12 Sep 2024 03:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WT564QLo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A4E688E8A; Thu, 12 Sep 2024 03:02:28 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5836588E7D
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-718e285544fso256705b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102944; x=1726707744; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KL3+dFmFHiAANGPq/eQ50T+7gu0riObuVukE2a/bnls=;
 b=WT564QLomKwzprXtx25IWilfww+PtnOBNkiLkY/0RB79OkPP1kzHeV8TfK/CPKRWh7
 YLb5lwcoy7xPeziw8RHhdgH4gG+U6ibbElYY1LDwqJcrspLuYHnvsRY2e48l36AsirNj
 qlQL6UEFcfZm/7ZQ8wgZkis+C480SywRlNQXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102944; x=1726707744;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KL3+dFmFHiAANGPq/eQ50T+7gu0riObuVukE2a/bnls=;
 b=mdoxUKN/IrM0dav/oheP5yFplTZTL5z3OYHKuHuvKiU7AyjpdHC4irCtCicCdZO8RH
 D05qOPxhg2X4HudjUAYl8OHXUp4QdlYqCCyEYep3vHn06Ug8X3uGErnVSw7nPnDXLgyf
 1dNT8o7Nhl35kbsxpMHYzej8Lld4hBUGXugr4zkG7pHxvxkJwxd8skB7GjuGQwBDx2bO
 wquoM3DzEvvGrI+h0UBEub3+AueW03TRNc6C7qLwj71nQxcNOGjk/TFonId/9Teifi5t
 HHPrmx+mJ3iyeCLWmqHdD6QrPventOn1RR1ffccNG5U3TE6EFay4ADBUmXl4lcny8jQY
 DPYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULUNSZKsuFLdyITIgutQzwOMjqasF5Pai81tpOLip07kSUwTerpApwxHNPZcF2jdKGQEV+cQc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+/AEKbTNUmWKDWQPWrEVA8OOhshrFW8fSitZj6PI32Y8im1Sp
 YrKQ/Y2V4VvbrP+DSFvj6CJiPznKIgCpdEoerBB1JlIWT6HQ2ZOVN/9+5RzeC3oeFyHEz5hlX6R
 m6PYqWV47pmfVd2hOQdpLDJ7xJiQ1HPRX6RPWFXiJhKKlC/U=
X-Google-Smtp-Source: AGHT+IFS+l0fpyUgaDDBi7LYVksqScLxj8XfiQVh7EyUHbr/fgSxlYp4pplK+04giiJ5T0apIbRKofNdKVxeoKoTbYY=
X-Received: by 2002:a05:6a00:2789:b0:718:d516:a024 with SMTP id
 d2e1a72fcca58-7192606d4e9mr1871048b3a.7.1726102944179; Wed, 11 Sep 2024
 18:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
 <20240911214945.15873-2-ddrokosov@salutedevices.com>
In-Reply-To: <20240911214945.15873-2-ddrokosov@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:02:12 -0600
Message-ID: <CAFLszThxBMgipnDeUyxDOBUP8vjCT0ODzevaOS0hbQ3HDRiAPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] include/android_ab: move ab_select_slot()
 documentation to @ notation
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: igor.opaniuk@gmail.com, mkorpershoek@baylibre.com, 
 semen.protsenko@linaro.org, trini@konsulko.com, colin.mcallister@garmin.com, 
 4.shket@gmail.com, avromanov@salutedevices.com, u-boot@lists.denx.de, 
 kernel@salutedevices.com, rockosov@gmail.com
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

On Wed, 11 Sept 2024 at 15:49, Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> There are new function documentation requirements in U-Boot, so apply
> these changes for android_ab.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  boot/android_ab.c    | 43 ++++++++++++++++++++++++-------------------
>  include/android_ab.h |  7 ++++---
>  2 files changed, 28 insertions(+), 22 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
