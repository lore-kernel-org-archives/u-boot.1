Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AC6D30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F90A89285;
	Fri, 18 Oct 2024 16:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EdfiycJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41DF78921C; Fri, 18 Oct 2024 16:59:13 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 370088922D
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cbe68f787dso12042616d6.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263434; x=1729868234; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xVNIWs1s0EpbpFuiVknDKEq6ikvsEwxX0PLGGHM6COg=;
 b=EdfiycJSy2RZJseRRqJG1fAz3sq4KTZcgRpKSUPonbUCL+dgHgrp/T/7wOsoKVH7g2
 My8ycb8tX581vgGfcW/AelGlu4eCPU8VVoAHwwUUMmUXy2ME/Tj7owWGZYne5gpTrB71
 5+Phmg7FpZ7Elx8F9Jt/ljs6IYA1DB/Q04Omo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263434; x=1729868234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xVNIWs1s0EpbpFuiVknDKEq6ikvsEwxX0PLGGHM6COg=;
 b=w01D8EboYx3tFcqzc6rmm1fbroW107lzNfcNOWP2pHc4yGQL/plZF0zx0u1hWr6OxT
 mYD7jTqoti4gfYDzI+qnDUcGwovBq6zMBicmd7koph3hDDuEJkIkuIVHBQfRSyTdGuK+
 BvEQdbbh6K5iGH4uQlxCMeSb03qgYgiCZ5DgEKi5pqWb3zf+qM0zvspJ5FWCEzI84otM
 1sfo6H7ujFQFxY62AjkwfCgsAXEQVrjdmizyX2t06EAziceGOdJiW2twiQ802R28HRgw
 kGeR8XZeBhlUI20YvKASs4qWseByJs0iGASyD9KssJ5XiNP11WigfFlHBfHi/NU++cxM
 MmMw==
X-Gm-Message-State: AOJu0YyZbIp5Pa023oRpN9Erojog2MU4K0ERQCYim1JNFwWq9AheQagh
 zFCoG3s/QF+dfjDxzihMryO+u163zw5JKh98p0b3+YgBlLk7ORoZ9oonl+MLNuQ7AeeVOc2TR1q
 X8EKNZyUfI6SJDcz/IOivmSXtc6x69uMUFgsI
X-Google-Smtp-Source: AGHT+IG8qYZeyPYtYiS3Aj1FOLfAW4kfhGE4ocKHuQIfpuAkliJzcAWAmF+PkEW79xSvSg300dE4hG09lNBvy5QUq3E=
X-Received: by 2002:a05:6214:2dca:b0:6cc:380:b04f with SMTP id
 6a1803df08f44-6cde14b82f7mr33493856d6.6.1729263434108; Fri, 18 Oct 2024
 07:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-16-sjg@chromium.org>
 <20241018031455.GU4959@bill-the-cat>
In-Reply-To: <20241018031455.GU4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 08:57:02 -0600
Message-ID: <CAFLszTiELZL3ZAm38z9y0yLx+XEU-EUuV5GVfjU=-3WdpkTUDA@mail.gmail.com>
Subject: Re: [PATCH 15/34] image: Add a new type for extlinux
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Thu, 17 Oct 2024 at 21:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 17, 2024 at 05:23:54PM -0600, Simon Glass wrote:
>
> > Add an image type for the extlinux.cfg file, which U-Boot supports
> > reading.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  boot/image.c    | 1 +
> >  include/image.h | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/boot/image.c b/boot/image.c
> > index abac254e026..cf16fb7fbf7 100644
> > --- a/boot/image.c
> > +++ b/boot/image.c
> > @@ -183,6 +183,7 @@ static const table_entry_t uimage_type[] = {
> >       {       IH_TYPE_FDT_LEGACY, "fdt_legacy", "legacy Image with Flat Device Tree ", },
> >       {       IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPKG Image" },
> >       {       IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
> > +     {       IH_TYPE_EXTLINUX_CFG, "extlinux_cfg", "Extlinux configuration" },
> >       {       -1,                 "",           "",                   },
> >  };
>
> This whole part of the series feels like we're abusing IH_TYPE_ far past
> what it's used for. Especially the command line string one. It seems
> like the main use is to be able to later on print something human
> friendly. Please try and figure out some other way to do that. Thanks.

Yes I had the same thought, particularly with cmdline, as you say.

The obvious alternative is to just have a string which communicates
the type. Then I can use IH_TYPE_INVALID, perhaps, with an extra
string indicating what it really is.

But one advantage of the approach in this patch is that, for bootmeths
which include a cmdline, it can be identified and added as a file.
That includes zimage and ChromiumOS, but not EFI. It will allow me to
get rid of the cmdline in struct bootflow, perhaps.

Regards,
Simon
