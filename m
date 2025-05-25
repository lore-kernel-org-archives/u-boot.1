Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED2AC54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44E3282E28;
	Sun, 25 May 2025 12:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EgKuif3m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75FA782D08; Sun, 25 May 2025 12:53:12 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C01882B53
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6049431b409so233900a12.3
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170390; x=1748775190; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RT51onGsrXc71FhWFfIlEaQdb04lEsyn5Ov+YAeVasA=;
 b=EgKuif3mO667l5xsEzj283MSOEqZbeZ6hldgBTwj36sY1uYqf3NXuUbyg5un3rAq6d
 /4KAbDquFyUb4CxfLjZekNNuAhCnN2OGoLl/ZWKihSKyK4bmlzpet8k075nFsU1G4pXC
 /pRkb3+hpOQ48HTR9l8FXUfnr8Zh3qX215mR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170390; x=1748775190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RT51onGsrXc71FhWFfIlEaQdb04lEsyn5Ov+YAeVasA=;
 b=WlqAdohWIiMW3Ui1eDoQUdApSZIw+F572a0KyLbWQATRvlB/SVFGGtYlQ/gTa0m1mC
 X/cckVz8Z2YoOTQjyenNqTvMlxKWnjxtIXUkSS73Ctao46ieicEmI/eVJk/VlLbjc5xH
 L8wzQZbmjIRRCUVObMwbMOwvqFBZWTQutcwuR4TDNWla1t9GJLTtXs0W7/oZDEweY4eR
 SRG0y+1EfJUj2WfEJPQutvyMCGVJZQocD6WPKIOfLK85zXSS3q++nmai5EOr1yaEIsnp
 9x4STs3D/c5XbTQFB76D+IjIK8PLq9evc3ZO2iLsydSmz0tNk6dkED1NbenaPKYw7w2k
 ZPUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTJ59BeBrxkKAKUkJ376V6/b+f1CM6rf0COOuebf3SYFFY6vbTeA+mPkwrPlhjbjPoVwhLEMo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2AfKRTBjym0CZmPHTpHqeLI2BKRD1avcd5X9lJFnBc3puPoF3
 EDGMdwweCLajkiJxq7mllp7TNte5yp9Die6DEo/knSv8YvrFZ/n8MpH+6h2gwE2ZWyR8GC7bd71
 ujHV6SrDghbPGG3weA8ClRtPZXynasqnyf0F0O2By
X-Gm-Gg: ASbGnctIgXXbh2B9UPIBjXwuDoNnyvCQ5b3goazslRUosYfRqHhJd+VoHtitufScboa
 wkbcsyJlJI6ibHM1GJ6p4eeZDs8wuojpoHfSmaIE0ci9yGsRQU/he3gTjppr2/aIU+eu7rgyHyx
 WGLRxCse540DMsvgPg7zzLtuyqdwnHftI=
X-Google-Smtp-Source: AGHT+IG9ngbAW7ZQyJzxYU8TvsYXUeNwi5U4/5lgWDlhhL4eaMEfJcnMjp2VQSqfPIHsbeU6b/JUfOa+0g85nzFTB6U=
X-Received: by 2002:a05:6402:2713:b0:601:fc17:91ee with SMTP id
 4fb4d7f45d1cf-602d9bf639cmr3529563a12.12.1748170389877; Sun, 25 May 2025
 03:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250524172827.1243975-1-sjg@chromium.org>
 <20250524172827.1243975-2-sjg@chromium.org>
 <501660c5-2c69-4f93-ae10-d83253706890@gmx.de>
In-Reply-To: <501660c5-2c69-4f93-ae10-d83253706890@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 25 May 2025 11:52:58 +0100
X-Gm-Features: AX0GCFs15ICf38xJjewfcJ906yeI7sDs9cVMOtYtl1UsPqVnccf7caR6HdSI0oA
Message-ID: <CAFLszTguUou4TMev8m0rnr5JLxDG_Gwy6S21p=hfrL15nkNWDA@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi: Include device-path functions in the EFI API docs
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Heinrich,

On Sun, 25 May 2025 at 10:18, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 5/24/25 19:28, Simon Glass wrote:
> > Include these function so they can be browsed in the API docs. Exclude
> > END since it causes a warning, which becomes an error:
> >
> >     ./include/efi_device_path.h:22: warning: cannot understand function
> >        prototype: 'const struct efi_device_path END; '
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> We expect builds to succeed after each patch.
>
> In patch 1/3 you need to change '/**' to '/*' for variable END to let
> 'make htmldocs' succeed after this patch.

Thanks for resolving these.

>
> Somehow you dropped Ilias from the Cc list for the series.

Ilias asked to not receive emails related to my tree. So far I don't
have a way to cc him on some patches but not others, if he is in the
maintainers list. If I remember, I can manually drop him from the
patman bounce list, but then I have to remember to add him back, so I
generally just leave it. I am thinking of adding a feature to patman
for this though.

Regards,
Simon

>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> > ---
> >
> > (no changes since v1)
> >
> >   doc/api/efi.rst           | 6 ++++++
> >   include/efi_device_path.h | 2 +-
> >   2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/doc/api/efi.rst b/doc/api/efi.rst
> > index 43d6f936fb0..a98298f93dc 100644
> > --- a/doc/api/efi.rst
> > +++ b/doc/api/efi.rst
> > @@ -178,6 +178,12 @@ Driver binding protocol
> >   .. kernel-doc:: include/efi_driver.h
> >      :internal:
> >
> > +Device paths
> > +------------
> > +
> > +.. kernel-doc:: include/efi_device_path.h
> > +   :internal:
> > +
> >   Unit testing
> >   ------------
> >
> > diff --git a/include/efi_device_path.h b/include/efi_device_path.h
> > index 67474d6d0c1..33b6cfe9b79 100644
> > --- a/include/efi_device_path.h
> > +++ b/include/efi_device_path.h
> > @@ -14,7 +14,7 @@ struct blk_desc;
> >   struct efi_load_option;
> >   struct udevice;
> >
> > -/**
> > +/*
> >    * END - Template end node for EFI device paths.
> >    *
> >    * Represents the terminating node of an EFI device path.
>
