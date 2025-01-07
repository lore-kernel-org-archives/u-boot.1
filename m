Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC95E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 12:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B39801FD;
	Tue,  7 Jan 2025 13:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OEQEXOLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 916528036D; Tue,  7 Jan 2025 13:04:34 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DF6E801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 13:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d3f65844deso26340744a12.0
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 04:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736251469; x=1736856269; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MHhp3RdSTQtbC7odmHR0C2Q2zwVt1nkoq9CvHVAtXFg=;
 b=OEQEXOLwCX56VEu1IlvFfMQc0vwSjC+XSWYBu/miOQ8BJ/Wlhn6AT0I0VQp8V+5rnL
 gIFE16zGgL9EKBsIdqllq2ACx8FzvAn9ZausbeZJ/QujweiS1zp7U6IXAckdutikNPN7
 cfozOcg+wr6TSOUVTYu16gZJ2faVy66dHAUCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736251469; x=1736856269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MHhp3RdSTQtbC7odmHR0C2Q2zwVt1nkoq9CvHVAtXFg=;
 b=vSG5s48uoVgSBPfZfBLa48EPA87LGqdHIT4ct6z6bEWM/dSKTR2KQi6JYJIJLYMHaK
 DTGKxRvCulR7jYCrV1f4q1o5NXYq/8An/xlecR75AsaPbuO2fcS29/jdDaR7cASDdqy/
 1+RI4TnCI5uabuUOZjfo9V4WR5+5Df0MwJVVdVr1IeSi4ZKZqvnOlcMe9Mf0dSrqJZId
 Rb+Xe/L8VhL9MPoDlxTJ7w8tl0woukTQM3iuPSgjnj6smc93c4fEiGLSOWx5Mmhx9bfx
 LAMW/vdJONjHUhBhBBJzdXDxJFZXPy4HFiAGeWAPjBKi4RFK9/1YTDfGdEUe1u373XlZ
 WknQ==
X-Gm-Message-State: AOJu0YwE4sSIcjwHKCnLj+jhP5R+atjgxet55Y5D3mFwEHD/yo4KVceh
 4u/UHU/m3tYx/GGBx2EcTTLe+EStNUyJukNazgCqcKv4Vrfqiq0zfRAsXa+xQwIIherkCXVygEY
 8Gvzsc8O2EPDFwZLZm+xrUyE0KF2vwQ37UYc2SDzUqELbyw0=
X-Gm-Gg: ASbGnctvZCTCCusAvbV9n6pG+/n9/0mm06UAxjx4l54mSxkWXOahXFwXkf6Yc2vNhvo
 qyICMtaBExTtcCPC0aD9oIB9vwslQGJ8ba3c0u9A=
X-Google-Smtp-Source: AGHT+IEIxjZJ6EZx/NcpMjfIShLUmLQ4PPYyK7RM7/U43yuDy5Q/vJ0Beh2PaP8XaJFkKZVEs0OkihxqvbUxi6I7UjQ=
X-Received: by 2002:a17:906:c106:b0:aa6:7cae:db98 with SMTP id
 a640c23a62f3a-aac2d447333mr5053653866b.10.1736251469453; Tue, 07 Jan 2025
 04:04:29 -0800 (PST)
MIME-Version: 1.0
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-3-sjg@chromium.org>
 <CAC_iWj+KzQhhKAJgnF9SdYk0kka8d+epNF8Fzm388zqUidvPOw@mail.gmail.com>
In-Reply-To: <CAC_iWj+KzQhhKAJgnF9SdYk0kka8d+epNF8Fzm388zqUidvPOw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 05:04:17 -0700
X-Gm-Features: AbW1kvbM8aH-EmxE-jR_ZBFo5k8g4fagcHeiremGO2QrTaC14vE1yDSJjinVNkU
Message-ID: <CAFLszTjtVg1U5ovYdAwrV5ESQr+PWB-Lp5ejHGOJW2Y0ufBAeQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/33] bloblist: Drop BSD license
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Tue, 7 Jan 2025 at 03:37, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Mon, 6 Jan 2025 at 16:32, Simon Glass <sjg@chromium.org> wrote:
> >
> > Linaro has decided to write their own version of bloblist from scratch,
> > so there is no point in having a non-GPL license on this file. Change
> > it, to better fit with the U-Boot project.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Link: https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/22215
>
> NAK on the commit message. I explained why it was wrong and
> inappropriate in the previous version

I didn't mean to resend this patch. Let's keep the discussion to the
original patch.

Regards,
Simon


>
> /Ilias
> >
> > ---
> >
> > (no changes since v1)
> >
> >  common/bloblist.c  | 2 +-
> >  include/bloblist.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/common/bloblist.c b/common/bloblist.c
> > index ecce3da9331..c441498ec56 100644
> > --- a/common/bloblist.c
> > +++ b/common/bloblist.c
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause
> > +// SPDX-License-Identifier: GPL-2.0+
> >  /*
> >   * Copyright 2018 Google, Inc
> >   * Written by Simon Glass <sjg@chromium.org>
> > diff --git a/include/bloblist.h b/include/bloblist.h
> > index 7d462e71914..be7303e1504 100644
> > --- a/include/bloblist.h
> > +++ b/include/bloblist.h
> > @@ -1,4 +1,4 @@
> > -/* SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause */
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> >  /*
> >   * This provides a standard way of passing information between boot phases
> >   * (TPL -> SPL -> U-Boot proper.)
> > --
> > 2.34.1
> >
