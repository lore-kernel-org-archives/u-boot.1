Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2898BD18151
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CFF18921E;
	Mon, 14 Oct 2024 23:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KIpcQKS4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B7178921C; Mon, 14 Oct 2024 23:55:19 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4BD287DC7
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbf693d794so24768926d6.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728942915; x=1729547715; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jzgJGi0MiV6RH2+HaM89MTFeFZM1zSFSxv3InNd6Yro=;
 b=KIpcQKS4jL+PQjIxWPPEXaoB3bT/Y553I7wh2WAyRxPBkXLc135N+CRKQ869pWf67X
 qhjoZFBMW3QXTD6F/nAxf5E+AuuoaQRfi4sHEHP31SG9LiYu4AAWuJ8gbxLbuWt3njeo
 pjIR3tyV1l+LppvEJVaY5JRJA35lhoXUhkQ18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728942915; x=1729547715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jzgJGi0MiV6RH2+HaM89MTFeFZM1zSFSxv3InNd6Yro=;
 b=iJiIZjLDWd8QR85nrDtaf3AknEnVvo6/SFVONlz4wskIgnRtvcbfq6D97Ugtj1pLls
 4+zHqjC/tP3jXX7IHl38ERmxvWVW4aclVL2eCCRYO3N5RaR0kla/CuQCRivGXLzj5fEY
 AhUNNqqESWzX7OLJrhNbSUDgjoausUBMgkxHkjSnbUmEJJiuD8zcZBXviMk7KpYCgHf9
 gFff9cvAENefC2m8r01mYLw1OwRFB4d/ACCYPC5rRWPVIJXsRpW19OFhrvVG27eIRXBw
 QzMIZbgV8ub1jJqyuprhLAikKm49hcsE0m+t8iONtAvHVHwEtmUksLNMP/bvZfG3UX0O
 NnGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgbyPF9t5sSrrvXguoP0iAh8g2InqrSC0Y/hmAYHobhCvktNAktg2zV9v5yq0PdzbnMld3SZg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyul7VJu6JITZ5G7G5+BevjBy0mOVtl0SMr6xdc3PFeXyYOGVpp
 6UL5bp0iDTOwzzzOGy0cB4qUUeSLxGDG3wOAH3oKhO/qAa4SMgjFLqvZIe8e8oyMUfZQgl3DTRm
 6Y3jT72kGunwxU6mWYfBXXXobqPoggwkQbbln
X-Google-Smtp-Source: AGHT+IHTt6u8b60KB6EatV30FhQlLyMnNWGkDJq+U53w3shLq4gh37admAe+h/VsI+7h3nC3OCk1Oy9XIm23PZq+qlk=
X-Received: by 2002:ad4:4501:0:b0:6cb:e6f4:dc47 with SMTP id
 6a1803df08f44-6cbe6f4e02cmr220634906d6.16.1728942915670; Mon, 14 Oct 2024
 14:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-4-sughosh.ganu@linaro.org>
 <CAFLszTiov914NOS9_5UU4oLi0fCQ84a-Et82BeSEJbts4MEOVQ@mail.gmail.com>
 <20241014155642.GO53053@bill-the-cat>
 <CAFLszThVP_OgyTt_ksJ1_7HAHT+K-wcixWB+k+fmzAjh6+5Bmg@mail.gmail.com>
 <20241014210453.GU53053@bill-the-cat>
 <CAFLszTgm=t=y1kj7Ju5Ls7nf0ghLCqRppVnY7yorD6v1hoeN1g@mail.gmail.com>
 <20241014212718.GZ53053@bill-the-cat>
 <CAFLszTiW_N-DvivnC_Fq4LWv+H+S2h8A-8o5dXPtGMsii1ToxQ@mail.gmail.com>
 <20241014214841.GD53053@bill-the-cat>
In-Reply-To: <20241014214841.GD53053@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 15:55:05 -0600
Message-ID: <CAFLszThxdPd7ty2=X66ZRWopzE0R1ChhdRZzah5tYLS+FvZ-Jg@mail.gmail.com>
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

On Mon, 14 Oct 2024 at 15:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 14, 2024 at 03:35:12PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 14 Oct 2024 at 15:27, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 14, 2024 at 03:13:01PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 14 Oct 2024 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Oct 14, 2024 at 01:13:17PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 14 Oct 2024 at 09:56, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Mon, Oct 14, 2024 at 09:50:37AM -0600, Simon Glass wrote:
> > > > > > > > Hi Sughosh,
> > > > > > > >
> > > > > > > > On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Use the LMB API's for allocating and freeing up memory. With this, the
> > > > > > > > > LMB module becomes the common backend for managing non U-Boot image
> > > > > > > > > memory that might be requested by other modules.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > > > ---
> > > > > > > > > Changes since V2:
> > > > > > > > > * Use map_to_sysmem() to get the user-visible address to be shared
> > > > > > > > >   with the lmb API's for sandbox.
> > > > > > > > >
> > > > > > > > >  lib/efi_loader/Kconfig      |  1 +
> > > > > > > > >  lib/efi_loader/efi_memory.c | 77 +++++++++++--------------------------
> > > > > > > > >  2 files changed, 24 insertions(+), 54 deletions(-)
> > > > > > > >
> > > > > > > > When efi_init_obj() is called, it should be able to add the lmb memory
> > > > > > > > to its own tables. There is no need to worry about lmb after that,
> > >
> > > Saying "There is no need to worry about lmb after that" is not true.
> > > Invoking the "env" command for example will have efi_init_obj() be
> > > called, among the others that Heinrich listed. And to possibly refute
> > > a next issue, that is intentional so that efivars, the standard
> > > mechanism used by an OS to talk with the firmware can be available to
> > > U-Boot, if I recall things correctly.
> > >
> > > My understanding of your assumption is that you believe that once the
> > > EFI_LOADER subsystem has started work on a payload we're just a few call
> > > chains away from the OS being started and runtime services aside U-Boot
> > > being done.
> > >
> > > My understanding of how things are used today is that this is incorrect.
> >
> > What I am getting at is that once we have called that function we know
> > we are booting an EFI app or using an EFI feature in preparation for
> > doing so. Let's start there. Is that correct?
>
> No, it is not correct.

Can you give me a code link?

Regards,
Simon
