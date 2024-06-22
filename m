Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35D2C27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 16:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21CD38803E;
	Sat, 22 Jun 2024 18:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MW+eaKas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19148880DB; Sat, 22 Jun 2024 18:39:14 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB64A87A09
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 18:39:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f700e4cb92so25509245ad.2
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 09:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719074350; x=1719679150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AlDXEheFbl+u/+9duCwe2DNVAL5UfIPQmYiiO1p4ydU=;
 b=MW+eaKasily90mU1ExYhdIxEptCyGL3C6z56RaJIvSZ15m8uaHSx1W3qGuJvPDa1yE
 DT85t7bytQfmcDG5A5CZzKT4yvKCGMK+v5lim4CK95uZBLTQqVj6BINKBgeFe3TlmJoj
 9fNDv9/v8K6nc6EUwkrhnYyv8230hl/xQHi8R2ujDhlzNlSXwDB/yRI5u1gI0Lo5vmNb
 vgXqJn8QJVYZ38sz+uv/f3xwfTAg6kvBNpt2TtI6VaV6gsREyQYgU8uzVBuQRLzHxF01
 5LtBEBu8gx4sXlKxFzs0W7cbP7MoYYPFbhYY3XVAImz+Q9AoLUJ6mqzzailzdax1AJ6/
 G2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719074350; x=1719679150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AlDXEheFbl+u/+9duCwe2DNVAL5UfIPQmYiiO1p4ydU=;
 b=asxEjwVPqmqMId8cKvbH0ajxCVqE1hqaHkk+fxoFQ7zoPlmBC2Ozpjrazxa/Ongig/
 q64PcQxmdBn7kY8nN3QVcyqZ2WeWHwRrEQx5So7SWsfVEdTQrS6QjB875HXjuY4FbDwO
 qWtfrZrTA8Hg5cvTaLrBy3fOYpJCjHYh6nOZ5aI/lwkAOB5sQRmyh39iHtAKfDRYflCc
 HGNU//G/DSRnZ2A8Fy6cCGIyTsLd7p71/Bv9ThtXkYVHjuhMNTygOolj+qFOIHCM+/ra
 EUFw2+V3X2G0B7xAQJ7CKGqpGBAk2mxme12JdTyQqh9ivUBoRr0CijmC25qVUKdI3ju5
 mnpA==
X-Gm-Message-State: AOJu0YywCHZoDvtyEB+qMw0l+7cMhqRpqO+epgoH/61EbHhcS1K1N8Gt
 tXLbQKWibepxPDiQp3sEhdHIHvn3gG4OOLhu6eVKcTHl/ERduD347Ae294k1Zm7neaA9+MwYN+i
 gD6h8iNEVynn26j9w2U5XzKfMn2BkP1/JcOXlZGbnc3co/bosvM8=
X-Google-Smtp-Source: AGHT+IH7xpPuzZIhhyBRm8aoHKfHRvWs8KQBMJwPXIVVDt/W8wIV1ORAcSnnrUQnBTjtnURXf9M/kaBTIyOQRkhh310=
X-Received: by 2002:a17:902:e80c:b0:1fa:199d:6d66 with SMTP id
 d9443c01a7336-1fa23f1f71dmr3972485ad.59.1719074350100; Sat, 22 Jun 2024
 09:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240620201531.321110-1-ilias.apalodimas@linaro.org>
 <2a1d9bf4-1790-4186-b8e0-3a5001af9f72@gmx.de>
In-Reply-To: <2a1d9bf4-1790-4186-b8e0-3a5001af9f72@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 22 Jun 2024 19:38:33 +0300
Message-ID: <CAC_iWjKLdkbaxFXbogprgcaBMXtVGnp+j0_ED-izZaydQcAxEQ@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: adjust config options for capsule updates
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, jhumphreysti@gmail.com
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

On Sat, 22 Jun 2024 at 19:36, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 20.06.24 22:15, Ilias Apalodimas wrote:
> > EFI_IGNORE_OSINDICATIONS is used to ignore OsIndications if setvariable
> > at runtime is not supported and allow the platform to perform capsule
> > updates on disk. With the recent changes boards can conditionally enable
> > setvariable at runtime using EFI_RT_VOLATILE_STORE.
> >
> > Let's make that visible in our Kconfigs and enable EFI_IGNORE_OSINDICATIONS
> > when set variable at runtime is disabled.
> >
> > Since EFI_RT_VOLATILE_STORE needs help from the OS to persist the
> > variables, allow users to ignore OsIndications even if setvariable at
> > runtime is enabled.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> So this v2:

Yes sorry, forgot to add the tile and log...

>
> v2:
>         allow EFI_IGNORE_OSINDICATIONS if EFI_RT_VOLATILE_STORE=y
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Thanks Heinrich

>
> > ---
> >   lib/efi_loader/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index ee71f417147a..6006e845cb1f 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -220,6 +220,7 @@ config EFI_CAPSULE_ON_DISK
> >   config EFI_IGNORE_OSINDICATIONS
> >       bool "Ignore OsIndications for CapsuleUpdate on-disk"
> >       depends on EFI_CAPSULE_ON_DISK
> > +     default y if !EFI_RT_VOLATILE_STORE
> >       help
> >         There are boards where U-Boot does not support SetVariable at runtime.
> >         Select this option if you want to use the capsule-on-disk feature
> > --
> > 2.43.0
> >
>
