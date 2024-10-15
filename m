Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B241D2169C
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A909C881A5;
	Tue, 15 Oct 2024 15:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UipJ2xPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 501C48811C; Tue, 15 Oct 2024 15:10:42 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA54A88009
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-45f05a65398so41327321cf.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728997838; x=1729602638; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lEZiUC22gt7wFgY7FS3SEYXSF1Bq91dj2rKOFOr/jTU=;
 b=UipJ2xPevh0x+F3MOLZOvDnxAyzvc+QFPnjtr2+eW/N/2JfXlPrJxOc+CTiPSmMJwF
 ix8jEa7cXMACmr1O+j5QcZ9MicSjnsg+oYnqrxSIxT4CBgCwAimzMxHf8NIQ1k7TEQmb
 4Aki0m8tD9q/2rhixWckIHVtYMZMzz1/Q8tvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728997838; x=1729602638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lEZiUC22gt7wFgY7FS3SEYXSF1Bq91dj2rKOFOr/jTU=;
 b=Yv3Ye9qhuiN7tZk4DnmZJ0jsNCD9MYQpGnaUpQpm+sXY5bYtzJkAeD7inR2ECsTYIc
 UdTb5dGb8QaQHg1bMjYPIXq/TwFXnqkzlZGdhwWrJnfNxM0zlj/xYzxNRveUisylKrE2
 ZbwZsmkDncNwIvJBobL9GZbUsRY/ckz88zrSdtHpyhKB0ePjLxGw89lJtFM8/leAHFTi
 Audn1pIUC9ydaZE1DjxQodSBuROQigahfaubJ0tpwZ5Xj9NQdiz2MdY3aEjy9BGKIGei
 h7DDWLwGsQOwrf2gyA6XaaLfh3blyA6SkwDznaDlrKAXw8sJUrZ4zUxlnZq0jibKTYC3
 6IUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUezCBBMPV+N4l6wwlfPVdkVvSLZGIud2+obatfuJwDrDGMDLxP+XtfTYydBtezSb6m1e9eg5I=@lists.denx.de
X-Gm-Message-State: AOJu0YxdIggM/IkMPtEzt/1cTiyhY7UbySWez8kCfJzuwECu8G+RgkRU
 VqvPPmMl8V3XizmV2s4XuE/AoPf0ZxZKN+7VOuvxBcMsdOAeDwuf4BH6l31oEvRHLQYn03bobvM
 gYG9Qo47jKitXudo0SRUnIkQPHVK+9vDjbfWM
X-Google-Smtp-Source: AGHT+IHl3BmUizXZ/dtgZ2u1vO8vteqZzEjgaRpCjN5dT3Uz2saZuxxQiiRcwKNb8JnKnpCewMq5pc5llofCyCg3r7s=
X-Received: by 2002:a05:6214:3bc7:b0:6cb:cedb:a389 with SMTP id
 6a1803df08f44-6cbf0044a4dmr197669626d6.14.1728997838061; Tue, 15 Oct 2024
 06:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-4-sughosh.ganu@linaro.org>
 <CAFLszTiov914NOS9_5UU4oLi0fCQ84a-Et82BeSEJbts4MEOVQ@mail.gmail.com>
 <20241014155642.GO53053@bill-the-cat>
 <CAFLszThVP_OgyTt_ksJ1_7HAHT+K-wcixWB+k+fmzAjh6+5Bmg@mail.gmail.com>
 <20241014210453.GU53053@bill-the-cat>
 <CAFLszTgm=t=y1kj7Ju5Ls7nf0ghLCqRppVnY7yorD6v1hoeN1g@mail.gmail.com>
 <20241014212718.GZ53053@bill-the-cat>
 <CAFLszTiW_N-DvivnC_Fq4LWv+H+S2h8A-8o5dXPtGMsii1ToxQ@mail.gmail.com>
 <20241014214841.GD53053@bill-the-cat>
 <CAFLszThxdPd7ty2=X66ZRWopzE0R1ChhdRZzah5tYLS+FvZ-Jg@mail.gmail.com>
 <20241014230725.GH53053@bill-the-cat>
In-Reply-To: <20241014230725.GH53053@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Oct 2024 07:10:27 -0600
Message-ID: <CAFLszTj6y-aC=bJ+9c8un+=zG=yGb7bs60wPzDOeMVAKMgVchQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] efi: memory: use the lmb API's for allocating
 and freeing memory
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Mon, 14 Oct 2024 at 17:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 14, 2024 at 03:55:05PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 14 Oct 2024 at 15:48, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 14, 2024 at 03:35:12PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 14 Oct 2024 at 15:27, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Oct 14, 2024 at 03:13:01PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 14 Oct 2024 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Mon, Oct 14, 2024 at 01:13:17PM -0600, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Mon, 14 Oct 2024 at 09:56, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Oct 14, 2024 at 09:50:37AM -0600, Simon Glass wrote:
> > > > > > > > > > Hi Sughosh,
> > > > > > > > > >
> > > > > > > > > > On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Use the LMB API's for allocating and freeing up memory. With this, the
> > > > > > > > > > > LMB module becomes the common backend for managing non U-Boot image
> > > > > > > > > > > memory that might be requested by other modules.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > > > > > ---
> > > > > > > > > > > Changes since V2:
> > > > > > > > > > > * Use map_to_sysmem() to get the user-visible address to be shared
> > > > > > > > > > >   with the lmb API's for sandbox.
> > > > > > > > > > >
> > > > > > > > > > >  lib/efi_loader/Kconfig      |  1 +
> > > > > > > > > > >  lib/efi_loader/efi_memory.c | 77 +++++++++++--------------------------
> > > > > > > > > > >  2 files changed, 24 insertions(+), 54 deletions(-)
> > > > > > > > > >
> > > > > > > > > > When efi_init_obj() is called, it should be able to add the lmb memory
> > > > > > > > > > to its own tables. There is no need to worry about lmb after that,
> > > > >
> > > > > Saying "There is no need to worry about lmb after that" is not true.
> > > > > Invoking the "env" command for example will have efi_init_obj() be
> > > > > called, among the others that Heinrich listed. And to possibly refute
> > > > > a next issue, that is intentional so that efivars, the standard
> > > > > mechanism used by an OS to talk with the firmware can be available to
> > > > > U-Boot, if I recall things correctly.
> > > > >
> > > > > My understanding of your assumption is that you believe that once the
> > > > > EFI_LOADER subsystem has started work on a payload we're just a few call
> > > > > chains away from the OS being started and runtime services aside U-Boot
> > > > > being done.
> > > > >
> > > > > My understanding of how things are used today is that this is incorrect.
> > > >
> > > > What I am getting at is that once we have called that function we know
> > > > we are booting an EFI app or using an EFI feature in preparation for
> > > > doing so. Let's start there. Is that correct?
> > >
> > > No, it is not correct.
> >
> > Can you give me a code link?
>
> env_set() -> env_do_env_set() -> do_env_set_efi() -> efi_init_obj_list()

That's with the '-e' option, though, so people doing that are
specifically choosing EFI.

What I am saying is that, if we are not booting an EFI app or using an
EFI feature. Since 'env set -e' is an EFI feature, efi_init_obj_list()
is called, and EFI is in the picture.

Even if efi_init_obj_list(), I don't like treating U-Boot's memory as
a stack to just grow into. But as a first step, I do want to ensure
that non-EFI boot can be more like U-Boot.

Regards,
Simon
