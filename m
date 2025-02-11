Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B71DC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 13:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9942F803CC;
	Tue, 11 Feb 2025 14:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NEu6mNEO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56FAD803CC; Tue, 11 Feb 2025 14:09:18 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 048F0800B3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:09:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5de594e2555so6041625a12.2
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 05:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739279355; x=1739884155; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0h0eyu1Dhh/DMdvhGFDkx+Er3Yk8cTfTjwPaKdgagvI=;
 b=NEu6mNEOpmwByyLOmkRIRFNaNR+a3yH6MDzo++HoFzCU5I3alHBCxQG/QBrzmDbu8O
 oV5sKpSDVfZgqbfdvOYyB9eBJ028ez7TgOyPPE7Lcua8Cz3gF57nNvvB7MAn90zPW9jf
 TRwh7T7HCX/HMGOMgg/6oUiJiV+JMu5+wCFP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739279355; x=1739884155;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0h0eyu1Dhh/DMdvhGFDkx+Er3Yk8cTfTjwPaKdgagvI=;
 b=k9Ls8Oj+lY508LlcRa0Fi0TcYnUvjAW9dqjN1j6TMyWyNOYnTtt4c63L5yG+/+9dWy
 gm/xeKFWnr9uYU7BLfG4Qw3lDPc4AkI8vfuRx0eeJBey3a23WUtH8hgCEGO7OkuyzVjS
 bXc1Jbp35l9qruXIhOweq4GOBJHV+va9DCQ3IuKDlgM3vE3efwhfIMi8GJ2ZR4ZgSXMC
 sxZjM2BhADx82iM7rr39hWyir93hDeVecOLzf/OR+wjNe8yjprycXslWjt/lFSYmEVQ8
 gngRX+n3/Hk0Pi5mPBx9izdalP/FoyASLbSZxieGKfOj4cw+bmcnoOBJc5RjEB3Gv2px
 sROQ==
X-Gm-Message-State: AOJu0Yw41x+rs/ru+nnCue79HIfyOsbfgMEZO2hUr1JPncg9T/RuY0+5
 ZUcSQrGrD4q/eh4M3SRbsVumXdAHnvgFGpbFORNj8Ld7oWtxhXLm7i9DXG8y6fbE45X2L3wzVPD
 6lP2KFRz+wFrfnhCZYkb2G5Yf2xy3WIzKJb01sULk+NcMybY=
X-Gm-Gg: ASbGnctGbPz2k+4QGPujtjBb374h2ou54rUrFgc5LYZ37PpuotSHDBnox8jvoizMtOG
 ITxtVbJtMz0uSjEzRXaU+YKtIxs0RMjQuH3ALryhwQM9FJnyVEjeEaxxaJibl0Qc/GVsq1K6rYO
 a/zA+1hOw2upnw7PFTK8mj74BVAxBP8w==
X-Google-Smtp-Source: AGHT+IGFfOR+a1CP2cuYizFIyBDQdwCg8/JCrEtA87hSV0F1+SJ4Z7Y8xpLUJKJffTBC54XCiurebvUVDTsOWhHsr+k=
X-Received: by 2002:a05:6402:348c:b0:5d3:e45d:ba91 with SMTP id
 4fb4d7f45d1cf-5de4509996bmr19449887a12.32.1739279355394; Tue, 11 Feb 2025
 05:09:15 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-36-sjg@chromium.org>
 <20250210143312.GB1233568@bill-the-cat>
In-Reply-To: <20250210143312.GB1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Feb 2025 06:09:03 -0700
X-Gm-Features: AWEUYZkkphxqPkXN3w-CZWqChkcny8SQI7cR69ivG9ulD4EKQ4JQuWCTBFdHJWs
Message-ID: <CAFLszTiX-rNzEmrLOZ4PMMa9m3fHiLkchbJ=xtGh3RpZLmZ6Cw@mail.gmail.com>
Subject: Re: [PATCH v2 35/35] bloblist: Allow using a different bloblist
 address
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Levi Yun <yeoreum.yun@arm.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Roese <sr@denx.de>
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

On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 09, 2025 at 02:14:56PM -0700, Simon Glass wrote:
>
> > Where the bloblist is located in internal memory and TF-A's BL31 blob
> > removes access to this memory, the best option seems to be to relocate
> > the bloblist just before running TF-A.
> >
> > We can do the relocation in board-specific code, but need an option to
> > pick up the correct address within U-Boot proper.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Move the actual relocation code to a previous board-specific patch
> >
> >  common/Kconfig    | 20 ++++++++++++++++++++
> >  common/bloblist.c | 15 ++++++++++++++-
> >  2 files changed, 34 insertions(+), 1 deletion(-)
>
> I'm going to NAK this whole concept. The whole nightmare thread about
> these platforms comes from using a fixed address. We need to pass in a
> bloblist or see that one is not passed to us, via register. And then use
> that mechanism to pass the bloblist to the next phase. When we don't
> have a bloblist passed to us, we allocate one, and not at a fixed
> location.

Well I understand that Linaro may be doing some work to head in that direction.

The 'piror-stage' stuff is what has made this all too hard and
confusing. We should think of things from a U-Boot perspective and
make that work. The new case can be handled by standard passage, along
the lines that Raymond suggested, i.e. just checking for it first.

For x86 we don't need this path as there is no bloblist in TPL, i.e.
it can be placed in DRAM from the start.

Regards,
Simon
