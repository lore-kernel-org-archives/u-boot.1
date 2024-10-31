Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A654ED767F2
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 17:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C68188E67;
	Thu, 31 Oct 2024 18:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ij5aVUYq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5C8D8929F; Thu, 31 Oct 2024 18:52:03 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8E838928E
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 18:52:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9a0c7abaa6so130951966b.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397121; x=1731001921; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oGBTSLYSUsIhKYVcfXUqkogO1S8a38cw/NOBVNnh+5c=;
 b=Ij5aVUYqzKrZhTkaBAoZIIKTVivGlAAOhGW/RhmXNoA/g/cB/Z10wM29yTclr93lFW
 HzbAS7ek6Qg/Zlbb9zx+r0GROE0VTzdzhMXsmA0wJvimecB3dkPmO/Dq9poS5aXEs9rD
 x95BLIPTL8B8q4RMtZ+JRVN5kPQ7F+3NftL1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397121; x=1731001921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oGBTSLYSUsIhKYVcfXUqkogO1S8a38cw/NOBVNnh+5c=;
 b=pFBWNJCwa2KPyMb+34t7lpF/yu2+Cy8hXajoGtpfclWP3ZNP98/xBX0CoLY733oO9F
 WgvnNSL8JMxN0f6oRmkKs0iqh3Bdk8oR/cUORKe+NMUTTjLE4DwWznjOZuEJL1pMmA69
 LoQ3NQ067M7Hvguh4mDjGUG0ge24qS33+PRXyhW/0pnJRg+QxYHymCXB12S/4qo5FvpG
 q14nKu23hRV5OAkzwgFgnJZHz9cW5DEj/EutvSVt/0vhQjBbOrcx0vIEhswxpY2oMG+x
 K41yoLZF3MzLjBEzb2wDbsupeMAH3bkLRacPm684N4n+nFqAY1fXZQqk6wnG/eDkIqMp
 hCXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+10tLnJuvxUjnK7C44DOaZpHq5BdpVsaxTnVXXr1iwdZyjAdSQ/VmbTgtMnT8EIAumVncO3Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0Q9fSwQAAd/5TINHaI7o7Tz9KhYjVYYITVMTohopD5UtwbJlh
 SFiYEfqB3G3d0wbnYxo7s5lGqsihTJqKFTXZc9pptRf6v/MxL0WlZnio3QBzJUoeklnBMgfYtFc
 FRlsbkCWElfq9PE05/JBwnV61q+ElQo5m59A7
X-Google-Smtp-Source: AGHT+IHSEFAihW8b+d67IQQZIjR82KbFVSMJo34e/Oh30ZOjkBV0f4VdyQ/2x4zM8n4P49vztTWCSVjlFLPtwivZcMA=
X-Received: by 2002:a17:906:6a03:b0:a8a:8d81:97ac with SMTP id
 a640c23a62f3a-a9e6553ae44mr75968366b.4.1730397121140; Thu, 31 Oct 2024
 10:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241028124815.47262-1-sjg@chromium.org>
 <20241028124815.47262-10-sjg@chromium.org>
 <CAC_iWj+H_m3jiQ-Q-BK=9vtdMEnw0GHyQT2_LFHUYyEnnZh3EQ@mail.gmail.com>
 <CAFLszTgG423MQ0iK-2XnOHZN+qVy_-xZNkaPGGsQM=Th=kaeGA@mail.gmail.com>
 <B86C7011-6650-4F3D-9078-67150BADFDEA@gmx.de>
In-Reply-To: <B86C7011-6650-4F3D-9078-67150BADFDEA@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 18:51:48 +0100
Message-ID: <CAFLszTgT4XApKuSdTG9bN=EW56s0+Q2Kv96rnH92-tBnstYieA@mail.gmail.com>
Subject: Re: [PATCH 09/15] efi_loader: Fix free in
 ..._media_device_boot_option()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Tue, 29 Oct 2024 at 23:13, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 29. Oktober 2024 16:45:29 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Ilias,
> >
> >On Tue, 29 Oct 2024 at 11:02, Ilias Apalodimas
> ><ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Simon,
> >>
> >> On Mon, 28 Oct 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
> >> >
> >> > Freeing a NULL pointer is an error in EFI, so check the pointer first,
> >> > before freeing it.
> >> >
> >> > Signed-off-by: Simon Glass <sjg@chromium.org>
> >> > ---
> >> >
> >> >  lib/efi_loader/efi_bootmgr.c | 3 ++-
> >> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> >> > index a3aa2b8d1b9..431a38704e9 100644
> >> > --- a/lib/efi_loader/efi_bootmgr.c
> >> > +++ b/lib/efi_loader/efi_bootmgr.c
> >> > @@ -1180,7 +1180,8 @@ out:
> >> >                         free(opt[i].lo);
> >> >         }
> >> >         free(opt);
> >> > -       efi_free_pool(handles);
> >> > +       if (handles)
> >> > +               efi_free_pool(handles);
> >>
> >> We don't need this, efi_free_pool() checks the pointer already.
> >
> >Yes, but it then returns an error (EFI_INVALID_PARAMETER), which gets
> >logged, with this series.
>
> So this is not a problem of the existing code but of your patch series which creates a superfluous log message.

Is it an error to free a zero pointer in EFI?

Regards,
Simon
