Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23B6EE021E
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 03:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4DB886CF6;
	Thu, 14 Sep 2023 05:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HbbsNWVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CDD486993; Thu, 14 Sep 2023 05:38:06 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52ECC86E1A
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 05:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so66158666b.3
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 20:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694662684; x=1695267484; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a5wiDDbY/vY+a0xwcUAizhP687LvnMj1PW5er/c/i84=;
 b=HbbsNWVrJ2rL/5VyNOcLMeRCcoARMsGYfrExZjzWPy2kX8PBnlFP528GxehGo8lCoH
 dvRVBz9WWAKfWfDiBI3BMxOMJyDV4gSdWHf63+WimElEinhcP2zRwwTwed0v5aDebFvn
 zfdrR8CqNEmToID7w4GHhG2gJrgGsV8qfI2ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694662684; x=1695267484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a5wiDDbY/vY+a0xwcUAizhP687LvnMj1PW5er/c/i84=;
 b=XM2UmVVrdxF3U+4f7el7WyYGqXYJu2iOTQCc6hxQZnycMxR0rPs6jDxrpbOSZ0TeN8
 IeqMprLQ2o3X5nNztvufdnnC+gPpgB7YrMpR4V6fit14iF0g5ZdiJjPq6ITcpAX7FjRe
 aspMyqRgwrOYhQWsaVu3NPHFP28NB2LIU/VQ8F42zA8oQtD3RS3eeY1MGa33MsYdueCd
 g1iStaYcBNKyh/jIaqJCrT8VcDeHS3M4voNcpeb15848DMm12Pj3vknl82zvIS6BvXNg
 +qjdkbwyuWOtGaKMwtOT9AxYhFaDCi6+E6t+XTeONd8VN+jWO/FI2VfEQXq7dajTdN1k
 zOng==
X-Gm-Message-State: AOJu0YzQ5xvccrpljVqDJ0i9EXUqCntpuwjYiWVd6f9tZ0dmdpUH16eh
 mcFQkzx6ERsmp70C08nMUWCHffTmbqnTc+fNY4MKVA==
X-Google-Smtp-Source: AGHT+IFGodQ7nLngIYznRoF3nZmPl6LofuCPHCZavVd4Khvubm0XCPVhU7FP6wHXSTbKwp9XcEewjAqq4fTZ/HUy5w0=
X-Received: by 2002:a17:906:3f49:b0:9a5:cf23:de5a with SMTP id
 f9-20020a1709063f4900b009a5cf23de5amr3172098ejj.45.1694662683601; Wed, 13 Sep
 2023 20:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFyTMW40gdMRjQhSTcUb_4ZRtLPo119EfBih9k_bcpNbdg@mail.gmail.com>
 <20230913162217.GN305624@bill-the-cat>
 <CAJaLiFw9btZtcro_qqtYqTJziZwLuUJ=0QAuu+E5=Ooux4-WkA@mail.gmail.com>
 <20230913201355.GR305624@bill-the-cat>
In-Reply-To: <20230913201355.GR305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Sep 2023 21:37:46 -0600
Message-ID: <CAPnjgZ3rMLpRh_uEjsvipeTp92UEXDrO98q7e8M7f-Hh60NpYg@mail.gmail.com>
Subject: Re: bootstd: CACHE Misaligned operation errors (Marvell Armada 385)
To: Tom Rini <trini@konsulko.com>
Cc: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, 13 Sept 2023 at 14:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Sep 13, 2023 at 12:56:53PM -0700, Tony Dinh wrote:
> > Hi Tom,
> >
> > On Wed, Sep 13, 2023 at 9:22=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Tue, Sep 12, 2023 at 12:38:00PM -0700, Tony Dinh wrote:
> > >
> > > > I've been testing the boostd for a few Marvell boards and seeing
this
> > > > error on the Thecus N2350 (Marvell Armada 385, dual-core CPU). The
> > > > "bootflow scan scsi" command triggered the "CACHE: Misaligned
> > > > operation at range" error. However, this error did not affect the
> > > > result of the scan, i.e. the bootflow for scsi partition was create=
d
> > > > correctly, and u-boot is running normally.
> > > >
> > > > Enabling CONFIG_SYS_DCACHE_OFF got rid of the errors altogether.
> > > > Perhaps this is a case where the DCACHE is not required and should
be
> > > > turned off?
> > > >
> > > > Please see the log after the break below.
> > >
> > > Can you please try -next ?  There's at least one SCSI related cache
> > > alignment fix there that's not in master, thanks.
> >
> > Unfortunately I got the same errors. This time the ranges are
> > different, of course.
> >
> > master:
> >
> > N2350 > bootflow scan scsi
> > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> > ERROR: v7_outer_cache_inval_range - start address is not aligned -
0x3fb99f88
> > ERROR: v7_outer_cache_inval_range - stop address is not aligned -
0x3fb9a388
> >
> > next:
> >
> > N2350 > bootflow scan scsi
> > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> > ERROR: v7_outer_cache_inval_range - start address is not aligned -
0x3fb80388
> > ERROR: v7_outer_cache_inval_range - stop address is not aligned -
0x3fb80788
>
> Can you debug to where these calls are so we can align these buffers?
> See 02660defdc8a ("scsi: Cache align temporary buffer") for an example.

I wonder if we need to use memalign() when allocating memory to read things
from the media? But I am not sure which file time is being read, or which
bootmeth it is.

Regards,
Simon
