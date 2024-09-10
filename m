Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4F4EDE9AB
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 18:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84925890B9;
	Tue, 10 Sep 2024 20:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AAWFVxbK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CA7B88216; Tue, 10 Sep 2024 20:41:54 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F36E890B9
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 20:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c54b1f52f7so8079156d6.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725993708; x=1726598508; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bEnVpAgU5D1g0YIjaJyhDk5TGL9k8vK9au1+OWYzTyw=;
 b=AAWFVxbKZxwr1JD91M9nV18f4W2wk8bc81iflRbtr9mgJvWqGOL0DhOu0lt38SPmHV
 XC6C5To7R1t3Uu0D3tTbHQ0aD7QF7nzf8gEtBq9XLjeRBVZUiszrHJMHVkmVLMha9xZV
 kg4PFCf/5N5+v3ydpr5HiEq3jZf7dhwgm+F3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725993708; x=1726598508;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bEnVpAgU5D1g0YIjaJyhDk5TGL9k8vK9au1+OWYzTyw=;
 b=gGSoC2MeGoIVXnPYLQfFbxeHycM4le7a1r0q/yD/bW8Xv9y587xnoD3UX1hl68repF
 wMQOoPPyuKzD5V0oenh1sqLevswzfOPohzHI5sS+WCfWg3U7kzfxwn0hV+hlk0ee2uzQ
 BxMs12dnulQ33SSdeuoi8IIthAdWc3z3FXuwXK2DJL6yn8+/lywhe/4AlX+oSYUzlRTj
 b4/enQn0JuS3a1pEsJtpYmf53AMDFRHhuEu0l8aYZNBygO8JsFjPOvHTfZs79EqUGSed
 3Ryajflglzz/JxuCtIKg3OwhiaThx076fYi/OJAWFvbQkFeGoo/B6m+GDWmnl4g7GdZI
 nFlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUtBLY15J8gSghrzUFuU3GmX4xoxpLK4cavd1fzHiKon1HC/M73LlHzRrZTACXpevoWoRiX+I=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0xu6656oLaaAmyLLXXNJ9fBjwqY/ZYZa2ntX/k+2tlnWpXxrL
 hvMV7c4LcHePzAU1VB0BrRyv8CLPpwOQMxeh9mPkZQ2/Ypk9nEVlSg53KcnXAvOdqmgJjYtpE0d
 Thc8wXg6x3UNTF3J9ZkuRIBo73Sc+6Ehlfv8Q
X-Google-Smtp-Source: AGHT+IF9PcxMyEotP9TR0wWsxud0tRcyK3sOXcnbhUcOBn5xRl/DUou5RnKBvGWAQb0ZmHYpT6x/sVBeFpfyt+LTlxc=
X-Received: by 2002:a05:6214:3991:b0:6c3:68dd:b71f with SMTP id
 6a1803df08f44-6c55fb7633emr3480596d6.51.1725993707986; Tue, 10 Sep 2024
 11:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222634.460873-1-sjg@chromium.org>
 <20240901222634.460873-3-sjg@chromium.org>
 <20240902161047.GC2479150@bill-the-cat>
In-Reply-To: <20240902161047.GC2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Sep 2024 12:41:37 -0600
Message-ID: <CAFLszTg0-+m_hZf0n+-t+8gZz1m_ByJ=h=Ga1GkB37LL+6_7rg@mail.gmail.com>
Subject: Re: [PATCH v4 02/23] nvmxip: Avoid probing on boot
To: Tom Rini <trini@konsulko.com>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, 2 Sept 2024 at 10:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Sep 01, 2024 at 04:26:13PM -0600, Simon Glass wrote:
>
> > Devices should be probed when they are used, not before. Drop this
> > boot-time probing.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/mtd/nvmxip/nvmxip-uclass.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/drivers/mtd/nvmxip/nvmxip-uclass.c b/drivers/mtd/nvmxip/nvmxip-uclass.c
> > index 58e8c3fb74b..d18bd0e3d6b 100644
> > --- a/drivers/mtd/nvmxip/nvmxip-uclass.c
> > +++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
> > @@ -53,14 +53,7 @@ int nvmxip_probe(struct udevice *udev)
> >       return 0;
> >  }
> >
> > -static int nvmxip_post_bind(struct udevice *udev)
> > -{
> > -     dev_or_flags(udev, DM_FLAG_PROBE_AFTER_BIND);
> > -     return 0;
> > -}
> > -
> >  UCLASS_DRIVER(nvmxip) = {
> >       .name      = "nvmxip",
> >       .id        = UCLASS_NVMXIP,
> > -     .post_bind = nvmxip_post_bind,
> >  };
>
> Once again, adding in the corstone1000 maintainers as the platform that
> actually uses this.

Just to mention that Abdellatif was added automatically by patman for
the first version, but if there is no reply, after v2 I tend to drop
it back, to avoid sending too many emails.

Regards,
Simon
