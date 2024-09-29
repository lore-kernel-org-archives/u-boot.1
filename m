Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC64CF6499
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 11:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CEC388D03;
	Sun, 29 Sep 2024 13:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AaErBwYw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 002FA88D06; Sun, 29 Sep 2024 13:50:43 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C75328891B
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 13:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4583068795eso31858541cf.1
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 04:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727610640; x=1728215440; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YrVz6QnqgEDnjkx6pXwWAq1MwqkXtYpwugcN4w8ObW8=;
 b=AaErBwYwqc3rJgNMsYQM4nbAFovZTY+balRm1JPE7YNgQ1wXIiYa2xhBMvdfhKU5g5
 cZT+rljz7QfNWzHOaomaYlHAHWhwKoJPtjTExf1FPrr+69SMdBNqWJZeqh7z/7em+nwJ
 no4NAg36+zpCYyyN0+p+90k4Pv0Y4l3Yi21/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727610640; x=1728215440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YrVz6QnqgEDnjkx6pXwWAq1MwqkXtYpwugcN4w8ObW8=;
 b=q8wf8b10qbj2b45Di6W0imHkC1jZ61Gu+ybc3HVTZAKsdQEsGBEUAPK0K3+OXnsJv9
 YczEHKCVKdO1lY/UtwJXVvvCR8aUruL2yaArWH32Iz5Cw0mj3ARNN8UXSGUr636DCQvj
 WCCnl+uZL82yIlYmC7cfvnT8tNq+18VPp+Zmx84rdYyCZYSHQG4RXl1xHoI3pqlWfZfG
 BDOagWLiesVqGT2KOtM6OylNMH0bUAile/Vh6SqZXGED+NMSQpI0+uIDGIoD3Se3Bh0x
 pJYeaiyo2wEpPzbyUb2aEJgffKf5FNOeN7Og/kgzP9dclW4QWaBzFW3n4pbvrvDKS1i7
 OnfQ==
X-Gm-Message-State: AOJu0YypaSJkj4C/T/1Yva54i0v0exp7HrzPp6ayHA8ygXFVbS64Zwry
 i5CVGiO3DzjTIz5YPtf/TO6ZGTQSE0hbe2E30UEQojp9c1KUfDFqktBVpvYgWduFXMXo9MX0I8y
 7MtRLqSOwRHQMD5EdQEK1tgaEZDzGMgk5QR8v
X-Google-Smtp-Source: AGHT+IF1oJo1alIbXcAv/GlwjCLFdEn5WQoHkBEjnqrd61e+Gb9ftXzmlev1+coJfhk1nY2nsLOO71AJwpgsU+QxDUY=
X-Received: by 2002:a05:6214:14a8:b0:6cb:3e17:f4cc with SMTP id
 6a1803df08f44-6cb3e17f54bmr81991686d6.31.1727610640433; Sun, 29 Sep 2024
 04:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240928200030.194546-1-sjg@chromium.org>
 <20240928200030.194546-5-sjg@chromium.org>
 <7a415f72-01e3-4257-ac6d-c21c1610abe9@kwiboo.se>
In-Reply-To: <7a415f72-01e3-4257-ac6d-c21c1610abe9@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 29 Sep 2024 13:50:29 +0200
Message-ID: <CAFLszThSMO_Gi_kXyS+nwn-u+vLnTT3WsPcwzBVG-rGa8d25QQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/30] scripts: Define CONFIG_XPL_BUILD for all xPL
 builds
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Bryan Brattlof <bb@ti.com>, 
 Greg Malysa <greg.malysa@timesys.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>
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

Hi Jonas,

On Sat, 28 Sept 2024 at 22:56, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-09-28 22:00, Simon Glass wrote:
> > The new name 'xPL' is intended to indicate a build of any phase which is
> > not U-Boot proper. Define it for all such phases.
> >
> > Note that we also define CONFIG_SPL_BUILD for all xPL builds. This
> > preserves existing behaviour, but future patches will adjust that.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  scripts/Makefile.autoconf | 6 +++---
> >  scripts/Makefile.xpl      | 9 +++++----
> >  2 files changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
> > index b42f9b525fe..d7544022a31 100644
> > --- a/scripts/Makefile.autoconf
> > +++ b/scripts/Makefile.autoconf
> > @@ -83,15 +83,15 @@ u-boot.cfg: include/config.h FORCE
> >
> >  spl/u-boot.cfg: include/config.h FORCE
> >       $(Q)mkdir -p $(dir $@)
> > -     $(call cmd,u_boot_cfg,-DCONFIG_SPL_BUILD)
> > +     $(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_SPL_BUILD)
> >
> >  tpl/u-boot.cfg: include/config.h FORCE
> >       $(Q)mkdir -p $(dir $@)
> > -     $(call cmd,u_boot_cfg,-DCONFIG_SPL_BUILD -DCONFIG_TPL_BUILD)
> > +     $(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_SPL_BUILD -DCONFIG_TPL_BUILD)
> >
> >  vpl/u-boot.cfg: include/config.h FORCE
> >       $(Q)mkdir -p $(dir $@)
> > -     $(call cmd,u_boot_cfg,-DCONFIG_SPL_BUILD -DCONFIG_VPL_BUILD)
> > +     $(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_SPL_BUILD -DCONFIG_VPL_BUILD)
> >
> >  include/autoconf.mk: u-boot.cfg
> >       $(call cmd,autoconf)
> > diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> > index 3091311a3d2..ad21d451a30 100644
> > --- a/scripts/Makefile.xpl
> > +++ b/scripts/Makefile.xpl
> > @@ -21,15 +21,16 @@ include $(srctree)/scripts/Kbuild.include
> >
> >  -include include/config/auto.conf
> >
> > -# This file contains 0, 1 or 2 lines
> > +# This file contains 0, 2 or 3 lines
> >  # It is empty for U-Boot proper (where $(obj) is empty)
> > -# For any xPL build it contains CONFIG_SPL_BUILD=y
> > -# For TPL builds it has CONFIG_SPL_BUILD=y and CONFIG_TPL_BUILD=y
> > -# For VPL builds it has CONFIG_SPL_BUILD=y and CONFIG_VPL_BUILD=y
> > +# For any xPL build it contains CONFIG_SPL_BUILD=y and CONFIG_XPL_BUILD=y
> > +#    - for TPL builds it also contains CONFIG_TPL_BUILD=y
> > +#    - for VPL builds it also contains CONFIG_VPL_BUILD=y
>
> This comment block was just added in the prior patch, and now changed
> and re-formatted, why not just add the comments in this patch or at
> least this patch should only contain the addition of XPL_BUILD.

It is changing because this patch changes how things work. I
documented it properly in the previous patch so that it is clear what
is changing in this patch.

I suppose I could just drop the changes in the previous patch, but I
like the idea of clearly documenting what is going on, in case we have
to come back to this later.

[..]

Regards,
Simon
