Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96008C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 18:43:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E4888756;
	Thu,  8 Aug 2024 20:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UVbx2nFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489EC88967; Thu,  8 Aug 2024 20:43:47 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BAF587B1A
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 20:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b7a4668f07so6928386d6.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 11:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723142624; x=1723747424; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uwfQ2S04mxUuhacAX6PuhVGsoS/emNhSvTXYuGnz6Ko=;
 b=UVbx2nFRo77irnIVe2tUPk9Y1DZt2jHnU3xFD6S2W+BgoaAa0w/4/BnzzsiOvmu17B
 LV8P4DmYzZqXfNRqjIgAU6QkR3q89oxIkp5jGKusZHV+IOcO87BlCL3CIOMaPEcRCOZy
 4SJw7oRVTforU/MQ6qxm68oUbctb/OSfzLbis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723142624; x=1723747424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uwfQ2S04mxUuhacAX6PuhVGsoS/emNhSvTXYuGnz6Ko=;
 b=ZxDt9jDUDaSpHrDJCOSd9i8F5nTIB4yhf3/4Oxpwv0ZV7wAM21VH9N7KfPUkXIsw4H
 rPEcm7NjhTnoL19QwtYYd77zqSz3KBzmqgMoMIxlVbQ4ddjbW0vj5JrKdw0C+CBaBdI2
 RCCer5Ty0iKXA9viITHOddVT52IG5LjKfuhtHsZYeYH4EnEiTsmbzdyDi9tkl706+DXE
 0rG+vu2XKg5J1XR+zgvV4iRnyl9uxYca6DPkU9D8mPIssXN/D1GtTLVgdKW1S40bZ/ws
 NQW9YV5WFQr+aTv0IirzdRQ6vWAWlSH9I6ncgi+Ew+HpoBm1W4NRZ1WejVQ5Fey1qMDG
 vXZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgkg+ZclrcyxVhYq9p6bvKKs4fGF/VAsBDZvbR1tMKCn0UZ0zMg/0DQKVvOo6MyrEhsu2WgpU=@lists.denx.de
X-Gm-Message-State: AOJu0YyqjXQfpQhSLdkW4vF59HkeMk4ceD58pWqnt21f+WsLInFDZhvs
 wSMhKr1U4RZEvvkHkJgJ352sBcUKUjQcdPSuw85Nfyc7QGI7ktl+FfQtJm+E6dqoLM+brZfxqVj
 GjyQzQO6LU81Gopyy5xnViUuD6Xcacv/N7xDE
X-Google-Smtp-Source: AGHT+IEtbw8nT24ys7nqXtz4lxaLkCM/SiXaq/1GV4vhov1TpN8qKxNobhs7aNBZYLubugmOilCM3+cUw2OXKVWYQLs=
X-Received: by 2002:a05:6214:54c8:b0:6b5:423:52bc with SMTP id
 6a1803df08f44-6bd6bcb3193mr30704336d6.3.1723142623902; Thu, 08 Aug 2024
 11:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240807001345.296937-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjw=WEQsPdxoxjdZ980Vq4wvb1tuvFnevOiVBZNARGGJA@mail.gmail.com>
 <dde17dfb-bf49-4b79-906a-54127c6f0e87@canonical.com>
 <CAFLszThdWBVC0aR1kTO0-DGCFAUuq5dqaH2qYxME4jZV++b-yA@mail.gmail.com>
In-Reply-To: <CAFLszThdWBVC0aR1kTO0-DGCFAUuq5dqaH2qYxME4jZV++b-yA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Aug 2024 12:43:33 -0600
Message-ID: <CAFLszTgrZwAdn8omnayC0Y09wGQyc2K6q4E+WtCgb5O24YHhpA@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot: set correct block device name in
 set_efi_bootdev()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shantur Rathore <i@shantur.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Wed, 7 Aug 2024 at 14:52, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Heinrich,
>
> On Wed, 7 Aug 2024 at 08:39, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 07.08.24 16:36, Simon Glass wrote:
> > > On Tue, 6 Aug 2024 at 18:13, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > >>
> > >> For SATA devices the class name is 'ahci' but the block device name is
> > >> 'sata'.
> > >>
> > >> Use function blk_get_uclass_name() to retrieve the correct string.
> > >>
> > >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > >> ---
> > >>   boot/bootmeth_efi.c | 7 +++----
> > >>   1 file changed, 3 insertions(+), 4 deletions(-)
> > >>
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > Hmm I suppose I need to do another round to try to get rid of
> > > blk_desc->uclass_id
> >
> > efi_set_bootdev() should take a udevice in future.
> >
> > We are converting to string and later back to device before we create a
> > device-path. This makes little sense.
>
> Yes indeed. I've added it to my list.

But sadly, we still have code for ~DM_BLK so that has to happen first,
so I've taken it off my list. I tried to send a series to remove old
I2C stuff, but it is still pending.

Regards,
Simon
