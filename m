Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE16C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D14481E6C;
	Tue,  1 Apr 2025 17:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CnP9sSov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C5A781E6C; Tue,  1 Apr 2025 17:46:39 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18F5D81DE3
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac25d2b2354so932058766b.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743522396; x=1744127196; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JDE+XRAaRAiECoKbV6k+uJGADiV2jhspAyyFDST7tM8=;
 b=CnP9sSovXln2JybF/Bjv/QcL9iyc/D/Um2wDjfzQOyZdgTmH4iYoau9AnvMVSZH9XQ
 tzCAFhMycfLHu4LcI5w///EmyDXKgP3R5vPaCXmWyz7+3pPk+GRQgHMMiXyYvwasnf3n
 2ovSjoNjQ7whw8EQAEUesrQioMrSgoi2mGPcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743522396; x=1744127196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JDE+XRAaRAiECoKbV6k+uJGADiV2jhspAyyFDST7tM8=;
 b=mzkwcM5NycSjBI5lYqoGtUyfxkMV/wOI4DaKcsL6k/w+oaAsyMq0Mjl7DMvCvhS1qG
 4bAycbu8zjL0We6S/4KLugBBt0DPmkpyVPVbkiAdptMY8sXhopssWRCov+gQaWOgGGI1
 HuKGm/8fPkKiP4IeoXqqDf4kBp7RX2s4Jg2fuQps3AYDOMPM6yTonJmSM8bbKo34PYZX
 HbHl0IULytENvyo+/9R5kQ9gUVaGVrs2HQSA8pjVI7mjXOT1VBEwSZ1jyfquQIHc2nlN
 7nNbFX/M6Wz6l8P26voeQN9OCP4mNJ19IiHHKfpzC9AJ+RBtwkrOR9FkxATgz/U/maqC
 oxdQ==
X-Gm-Message-State: AOJu0Yy0P7tgkGfCQPAZ1dGgiaYcpSK8vvVtbL0K3V3E1ZykFn2x03oP
 BKmTtNczfQxnfF92zn4i27layNpbv5JEgDdNlIspI0hXU8Jt+ZcdYfAjIhKQhYZ6jb2I9A/jCXr
 q9nbU589kVwbHvulTyplF0Zj8duzurBLIt4tr
X-Gm-Gg: ASbGncv+7pwyoa9qMS4cU/ZE0vlZaO4UqmGpNtv3LXhHuQkXH/z+Wjy8/ZCwdOAzCyL
 Vs5/ZO+tbEsNPG+7SD8AmeDFB6ySMnJ/hJjlOhX7MBSjPvoL5jeiMV7TFa14aYHSuFKJnUOfzVq
 HL3dyCcf/o8I9LThUfmRaQUcUo0z39oabg1iZsbSY=
X-Google-Smtp-Source: AGHT+IGI/GKmfcWvO853cGj6+yIVzHbO2Va9WWop0hGpJJWoIcNT+rO13Xdg0D+w0UVhbnFRxL2Umbv+lp95MsKITy4=
X-Received: by 2002:a17:906:c148:b0:ac7:9817:60aa with SMTP id
 a640c23a62f3a-ac7981769famr35481366b.2.1743522396480; Tue, 01 Apr 2025
 08:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250319143820.2385092-1-sjg@chromium.org>
 <20250319143820.2385092-2-sjg@chromium.org>
 <20250331174237.GJ93000@bill-the-cat>
In-Reply-To: <20250331174237.GJ93000@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 04:46:23 +1300
X-Gm-Features: AQ5f1Jpw5W5RRI2-0YBzpGlsf-8YpedLTxzu8L48ZiYb_q4RAXCpRI7mc_WsKJ8
Message-ID: <CAFLszTipRBusG+oxusk5rzGJO1bdorE5uBhpEMfGGpjfH6yywg@mail.gmail.com>
Subject: Re: [PATCH 01/17] fs: boot: Update fs_read_alloc() to use abuf
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nam Cao <namcao@linutronix.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Tue, 1 Apr 2025 at 06:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 19, 2025 at 03:37:55PM +0100, Simon Glass wrote:
>
> > Using an abuf for this function simplifies returning the size and also
> > makes it easier to free memory afterwards. Update the API and callers.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  boot/bootmeth-uclass.c | 19 ++++++++++---------
> >  fs/fs.c                | 25 +++++++++++--------------
> >  include/fs.h           |  8 +++++---
> >  3 files changed, 26 insertions(+), 26 deletions(-)
>
> So we grow platforms by ~200 bytes:
>             sama7g54_curiosity_nandflash: all +204 text +204
>                u-boot: add: 6/0, grow: 2/0 bytes: 204/0 (204)
>                  function                                   old     new   delta
>                  abuf_realloc                                 -      76     +76
>                  abuf_uninit_move                             -      42     +42
>                  memdup                                       -      28     +28
>                  abuf_uninit                                  -      24     +24
>                  fs_read_alloc                               96     106     +10
>                  fs_load_alloc                              114     124     +10
>                  abuf_init                                    -      10     +10
>                  abuf_addr                                    -       4      +4
>
> To move away from standard buffer usage and unwinding to move to
> something homegrown instead. I am not a fan of growing using abuf here.
> When it was introduced in:
>
> commit 67bc59df05331eaac56cd0a00219d1386130aee2
> Author: Simon Glass <sjg@chromium.org>
> Date:   Sat Sep 25 07:03:07 2021 -0600
>
>     Add support for an owned buffer
>
> It sounded like something for some special cases. Not something to be
> used everywhere to be different.

From what I can tell this is a one-off hit that I believe is worth
taking at some point. However I haven't seen a code-size reduction
yet, so I can understand your reluctance.

Regards,
Simon
