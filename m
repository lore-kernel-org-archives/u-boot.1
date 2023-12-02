Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B565DC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B51787787;
	Sat,  2 Dec 2023 19:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DgtsqRQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF34787782; Sat,  2 Dec 2023 19:30:14 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 657C487778
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:30:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40b4744d603so33361585e9.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541809; x=1702146609; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wPA0goTU+fUOWl2uQdXJ+wjgLIp/yD/VOulNr9t66Fo=;
 b=DgtsqRQIYohkjoYNhlPw3JQl8K0+zBfcOshWTt6t/Ue57UO5IQZ43f/BImQNPt9riO
 2gAJjUkUaALNo07BuCv1iBYj2CxMljeQvjZa20p9+pGId+FqUMF4/y0TS9VWVvZDIHDX
 hKKSF65wkRL6sJEpNa1P3OvQ0TKyIWKkVSOGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541809; x=1702146609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wPA0goTU+fUOWl2uQdXJ+wjgLIp/yD/VOulNr9t66Fo=;
 b=FWSAKEJCvB3g0921q+DomtY5nZHqrpfmbXldGyNiwKQLEZ69F8NI1SoSLB07Hpo8ew
 Yhp2f36r3KPRGzznDGXGQa8ZuHFJ3ngKnzKnOkB9ED7EaApkiljz3F+CMXOOyrxeop0T
 I6/fP8uLuSiJ9GOn4SCyC/JrwA6pB63lpb4/8aQV7W9zGnrVZRNqciMatb5SyJIx150b
 MGRYEnVT/UArQOv4szCxEy7vvXDvN9Bc1HmPPDq3XLN0+m3lMynHJkecgdRFElFk4MXx
 R4ugaf9YagZueh7PLbBcK1oGRnp/QTwNyCc8bi4xOvFGKrgxoKLDuRdk180lyhHYpqGQ
 ePoQ==
X-Gm-Message-State: AOJu0YwyPhibfXHe+dLe2llr8Fnvtf9awFXrwYE+hFtHd4qvKGTN5XLP
 fmZt106bbl2Ns3Ux948beTDBmsgwgycRQxKlk3TPHRF7exR32ORF0jJ77w==
X-Google-Smtp-Source: AGHT+IF1JH0nOR841ObfCrRlUVvi3wptxSL6yTB/TeJma7KY2yW7Zl7AT4l9BH6P1JNXImQzH8sNqkI+4Kx4GkKbB6g=
X-Received: by 2002:a7b:cbd8:0:b0:40b:5f03:b432 with SMTP id
 n24-20020a7bcbd8000000b0040b5f03b432mr534408wmi.340.1701541808672; Sat, 02
 Dec 2023 10:30:08 -0800 (PST)
MIME-Version: 1.0
References: <20231117225313.2144665-1-trini@konsulko.com>
 <20231117225313.2144665-4-trini@konsulko.com>
 <CAPnjgZ2N__uy8qdhJfwzrk088dyG8fFGXbsh4-Z4yWa6rkDFNA@mail.gmail.com>
 <20231118174550.GI170968@bill-the-cat>
 <CAPnjgZ2vYJbk_pU9DgnQTfr_DavFM970v4PfWdEpUtjEx441cw@mail.gmail.com>
 <20231118180413.GJ170968@bill-the-cat>
In-Reply-To: <20231118180413.GJ170968@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:29:43 -0700
Message-ID: <CAPnjgZ0DoKe+s3qWNcOSZVcNbSbbkW6jYBHY_-iYKgmMhY2Fvw@mail.gmail.com>
Subject: Re: [PATCH 4/5] sandbox: Audit config.h and common.h usage
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Sat, 18 Nov 2023 at 11:04, Tom Rini <trini@konsulko.com> wrote:
>
> Splitting this in to two different threads..
>
> On Sat, Nov 18, 2023 at 10:58:50AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 18 Nov 2023 at 10:45, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Nov 18, 2023 at 10:09:55AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 17 Nov 2023 at 15:54, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > Remove and replace common.h and config.h in sandbox when it's not needed
> > > > > and add some explicit includes where needed.
> > > > >
> > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > ---
> > > > >  arch/sandbox/cpu/cache.c         | 1 -
> > > > >  arch/sandbox/cpu/cpu.c           | 1 -
> > > > >  arch/sandbox/cpu/sdl.c           | 2 +-
> > > > >  arch/sandbox/cpu/spl.c           | 1 -
> > > > >  arch/sandbox/cpu/start.c         | 2 +-
> > > > >  arch/sandbox/cpu/state.c         | 2 +-
> > > > >  arch/sandbox/include/asm/io.h    | 2 ++
> > > > >  arch/sandbox/include/asm/state.h | 1 -
> > > > >  arch/sandbox/lib/bootm.c         | 1 -
> > > > >  arch/sandbox/lib/fdt_fixup.c     | 1 -
> > > > >  arch/sandbox/lib/interrupts.c    | 1 -
> > > > >  arch/sandbox/lib/pci_io.c        | 1 -
> > > > >  board/sandbox/sandbox.c          | 2 +-
> > > > >  13 files changed, 6 insertions(+), 12 deletions(-)
> > > >
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > Is it possible to move CFG_SYS_SDRAM_BASE/SIZE to Kconfig?
> > >
> > > Possible? Sure. But I think it would end up being fairly horrible. What
> > > would be nice I think is some Zephyr-style "convert
> > > CONFIG_DEFAULT_DEVICE_TREE to some defines" because we could parse out
> > > /memory to CFG_SYS_SDRAM_BASE/SIZE and that's something we _need_ at
> > > build time.
> >
> > That would be pretty easy to do. But I would prefer to have it create
> > CONFIG_SYS_SDRAM_BASE/SIZE so that it fits in with Kconfig, just that
> > the value is set for you.
>
> I _think_ we need it to be non-CONFIG namespace or we'll run in to other
> problems? We could get the new autogenerated header to be included along
> with generated/autoconf.h but since we couldn't use it within Kconfig
> logic it would be confusing.
>
> > If you like you could create an issue for it.
>
> Please, thanks.

https://source.denx.de/u-boot/u-boot/-/issues/27

Regards,
Simon
