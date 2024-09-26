Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F6DCCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 11:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAA4788CD9;
	Thu, 26 Sep 2024 13:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nswWozy9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7836588D38; Thu, 26 Sep 2024 13:04:07 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA26A88A0A
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cb2f271043so7478896d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 04:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727348643; x=1727953443; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rpcpH8X9ypVnI9IuDiMMfy5ZvUHmsaWgdCgUB4W9CIY=;
 b=nswWozy9zMjV2dZewm/R/SY9G6Mv4+qUxFsblnAvmUawo7qMGUBw0KZgfzcULeLrNG
 L+RWe3l/2rnTlJMBdyegP4xkb58kG9kNhBqSIKXVSKAyP030zlEheOJczVqYnVOTTtk4
 +BTxPx6LG0dIeRkvjTeIUfMiSZS9UZM4A1Ldg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727348643; x=1727953443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rpcpH8X9ypVnI9IuDiMMfy5ZvUHmsaWgdCgUB4W9CIY=;
 b=WJ/9ezHULp6tXOm3EpLn9FiHEEtJV7ivg0oNcZSJAAHuQDp02lOBOw5oxjibE2ra85
 OBpY2oqGzfwcOGTHDEvyMOpuGtw/uMxqYMa/F7HyCtfgnRaW18BsQfT4NoR812Uixxzq
 kVFF1eaYA7/6OUORncYJ0pV+p0//ggKpWvBiTYaRyKXNSW/5Rmx57hrIGAqGG/9mUhIp
 U7griFAH79bUAb9lhvd+pjmQ2MLD++rBuPduCBkOQa3b0QMKBVruRxumyO+I7/G10mVd
 F09/h00TvvZ9JxyLYFMYq4PjXHjzq2IZTK4dcrRL+oO43qCz+WZS5Vr2u9KZdhVGHTFo
 O+gw==
X-Gm-Message-State: AOJu0Yw3SKUJB37RvrEfs3W1kIHoQ+yB5F6Hc1pWtN1jNjZxUWcU30uW
 dpwsYhOURNR87ozbBYHmnbGnK66HJC2PTj4cBv7v8iTMp+9bYJf8qId0EokdmcE6m4nvcIibva1
 hoRVE2j9frnA+r0CjXH41zr+f0HVF4OjvuIU82Ee0iIrx1dVb0sxA
X-Google-Smtp-Source: AGHT+IFgf2Wng+p0jpxcQ8e43+SEP0hHxUaLYkU5W/vxpZ3vr0bc2O3BZkVOvrE2bXORON5khzVzO7qfViBOmbUf/As=
X-Received: by 2002:a05:6214:3992:b0:6c5:c4dc:91f1 with SMTP id
 6a1803df08f44-6cb1de275aamr57657936d6.32.1727348643442; Thu, 26 Sep 2024
 04:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240925094745.37922-1-sjg@chromium.org>
 <20240925172627.GE4252@bill-the-cat>
In-Reply-To: <20240925172627.GE4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 13:03:28 +0200
Message-ID: <CAFLszTiurio66FAaKLkOKfBadonw5BBRa-2uP=ZOPUvR4ViSog@mail.gmail.com>
Subject: Re: [u-boot-test-hooks PATCH] qemu_arm64_tpl: Add a new board
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 25 Sept 2024 at 19:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Sep 25, 2024 at 11:47:40AM +0200, Simon Glass wrote:
>
> > Add this new board, to support testing the relocating SPL loader.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  bin/travis-ci/conf.qemu_arm64_tpl_na | 29 ++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 bin/travis-ci/conf.qemu_arm64_tpl_na
>
> I assume we're NOT testing all of the normal U-Boot stuff and so that's
> why qemu_extra_args is so minimal.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Yes, just running one test, since the others are already covered with
the normal qemu_arm64

Regards,
Simon
