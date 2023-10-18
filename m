Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB928CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 15:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FBCE86F40;
	Wed, 18 Oct 2023 17:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TL3QDbR0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1204386EA4; Wed, 18 Oct 2023 17:25:21 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 159CE86F92
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 17:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53da72739c3so11574340a12.3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697642718; x=1698247518; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1wv9jyorNID3OLzi9wf+G577t6CQsgfjF7DaGtwXpwQ=;
 b=TL3QDbR04D4+vqvkUvIDJXqvcSmHaDzqm8r3EagXCWkY5ttU5rc+DBvkXWD6YzhwA0
 a9YB+17rXSrWTSnN1yS2ZWilA28VKbxYT8wcfa9WjLky6Afwb9+xcukZaS/e1GxWMPuk
 sJ06bSs3rSk4O04ue0+n8Qw/u81/ZBzcCJrCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697642718; x=1698247518;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1wv9jyorNID3OLzi9wf+G577t6CQsgfjF7DaGtwXpwQ=;
 b=MK47DuqQbgdcQuqctG/Kc7f+TpJo1QgiBjDWu2oh0yt5cfPtnNXJSDAHhnBDLzxeTY
 6y8cUoJYSYa2QtsbK3bkFX44qDP3cidkAeEUBGV8kKR+ng5TZHLLCVIrR+VU6uvqlHlU
 3yA3dp64sXLkOQatmZNEwQ2KhQcKFBo3FISQ9b43dqt0dHSXrGLwk0tO84mopAzcsXdj
 7IHS6/1Lk4Oh5Gd49q3KLg7uYWm4yzZCid4GpDBjE3PIvwWpB49X995ZDbsbucrn/dRZ
 yMGsgkVsjKVAl0M9VyW4vDqwVo/9k1cJ7+HYdCaoqYKlMT2x28TIUe/IuFt9ZIZnbYpc
 oMRg==
X-Gm-Message-State: AOJu0YxMLGISZvcEAKf0irraBaa3JLgs1QV/iQD/fnj6DNgD2S+EKIJb
 kall0tLqCQDoO2VbkdwT2JDZRiwoWirlK4L00mABFGFv5yqyGEHb1Tc=
X-Google-Smtp-Source: AGHT+IEqDLWQewACHgqKU49o6GuzDpXmKzWTymwqBskCFpllqs5To/o1yH0PI/KJfLeJMyIMpqsrNxqicYyQydQBxpo=
X-Received: by 2002:a50:9312:0:b0:53e:3b8f:8a59 with SMTP id
 m18-20020a509312000000b0053e3b8f8a59mr3311593eda.40.1697642718192; Wed, 18
 Oct 2023 08:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-3-sjg@chromium.org>
 <20231018144232.GA3785604@bill-the-cat>
In-Reply-To: <20231018144232.GA3785604@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 18 Oct 2023 09:25:06 -0600
Message-ID: <CAPnjgZ2zS-7FH+7L2Oc8iZk0B_PT7biG=0kO79DDh+gPGia6LQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/32] bootstd: Correct dependencies on CMDLINE
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

On Wed, 18 Oct 2023 at 08:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 16, 2023 at 04:27:53PM -0600, Simon Glass wrote:
> > With recent changes over the last few years in boot/Kconfig it is
> > no-longer possible to disable CMDLINE. It results in various link
> > errors because some options which require CMDLINE are enabled
> > regardless of whether it is available.
> >
> > Add the necessary conditions to fix this.
> >
> > Note that it would be better to have all commands depend on CMDLINE,
> > but that is extremely difficult at present, since some functions use
> > CMD_xxx to enable feature xxx. For example networking and environment
> > have a number of problems to tease apart.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Reword commit message slightly
> >
> >  boot/Kconfig           | 19 ++++++++++++-------
> >  lib/efi_loader/Kconfig |  1 +
> >  2 files changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index a01e6cb8aafe..f74ac7e9cc72 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -342,6 +342,7 @@ endif # FIT
> >
> >  config PXE_UTILS
> >       bool
> > +     depends on CMDLINE
> >       select MENU
> >       help
> >         Utilities for parsing PXE file formats.
>
> So, this part here is because of CONFIG_SYS_PBSIZE, which I think we can
> / should solve another way.

Perhaps it would help if you just clarify your goal.

My goal with this series is to allow CMDLINE to be disabled without
build errors, so we can start the work booting via bootstd (with
CMDLINE disabled).

This isn't a straight-line activity. It involves changes that will
become redundant later, simply because I haven't written the 100s of
patches needed to figure it all out. Even if I did it would be
unreviewable and require lots of rework based on feedback.

Regards,
Simon
