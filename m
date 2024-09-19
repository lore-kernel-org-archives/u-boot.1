Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6C3CF3944
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32BE28921B;
	Thu, 19 Sep 2024 16:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iAEZXCCC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9562C8923B; Thu, 19 Sep 2024 16:13:02 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65571891F7
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2d89229ac81so789999a91.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755179; x=1727359979; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Aer8A+/FhXOxnKwW44w/mqqKGHC9S1oRzdwcRfGuWdo=;
 b=iAEZXCCC1L3UFtdmBcBRn9XDsQKAmta4LpRjcnK0T3sYC+13/X/vB/BZByj5A5onG+
 5/l1COAu/qSdyvewKpNmfjLix1yshEQPwq0E0dzeEJ8QcbaTRDfoXTWFXZp4AjUbnjCD
 UdDquLeGVYzMLXmAJ1TZKFddaKoyXxlzpZnw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755179; x=1727359979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Aer8A+/FhXOxnKwW44w/mqqKGHC9S1oRzdwcRfGuWdo=;
 b=LkQg4gvorUAqaeMa9GIhpiqmylYgn/24eWqz3IWGu4NxYcAEpBTQMVvelnmgbmoZ09
 FKIapqZVdcaKUpcyBPQrESP/Ke2ssba31GniMYgtcxEKokcF+UbKGDypn5iG5AxcIw1z
 KnQTMoE5vErmSBZU9v1QeuLj/p1g6GQ7eM5R5C5LJ+dwcMuQHFnzyqZjbit9OTqp822G
 CFlT0t2nBYhZCeNnSyggniR4H9nnYU8ZL39Tur04vbmA1nZStx2IRbjdKvD04ubryLRL
 dUn33wLQyxxgV/7L6dRR02PC2VG604AQER0e6Zyuwfk9e25rkhhTy8qzxAHcUU4j6z8/
 nDcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwnB0p9ZHWakVAp4WK0ZOe/8NEMXIxHrAgGhaKQTcweyNzTfftxl2ntWfOjYiXKrrspBD0SNs=@lists.denx.de
X-Gm-Message-State: AOJu0YzYbVoh92zr1ObrkzKHLUwD3ILzxernxG2gOymdkMBGDcLkA+1L
 nzTk1k/voHdsHLaZAxFyWHt/wuITFUbb+wqQqKadp55fAbiGYUn5t0a52s9Gv+4jCfX4LIbzqAQ
 Enp/ZwSGzJtsdTdYWm4r3d3hE7PaMdZ+N53OCPukHRlTxNNqsgPmoPSA=
X-Google-Smtp-Source: AGHT+IGKfB2VWzKRNl6DNNGp1qRxTatx/4t8G+qZrqS9LPWqs5QnaC2YfiWh2ZOfsP7Xg9RXaOsHg4eicTuyjKdbH+8=
X-Received: by 2002:a17:90a:f2c9:b0:2da:6a4d:53a6 with SMTP id
 98e67ed59e1d1-2db9ffb3672mr32789932a91.19.1726755178987; Thu, 19 Sep 2024
 07:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-3-sughosh.ganu@linaro.org>
 <b83d04eb-bc3a-4387-b812-6973d851ae90@gmx.de>
 <CADg8p95VsW99mr=Y62_DYeRvrxBDT9zEz+H_nrt6oyYM76f1dA@mail.gmail.com>
In-Reply-To: <CADg8p95VsW99mr=Y62_DYeRvrxBDT9zEz+H_nrt6oyYM76f1dA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:12:47 +0200
Message-ID: <CAFLszTjitzss7SCPhO8_wuRdXWVmF20M4pbxWjkXO0Ef9nyiVA@mail.gmail.com>
Subject: Re: [PATCH 02/16] lmb: add a flag to allow suppressing memory map
 change notification
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
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

Hi,

On Tue, 17 Sept 2024 at 13:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Sat, 14 Sept 2024 at 20:14, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 9/5/24 10:27, Sughosh Ganu wrote:
> > > Add a flag LMB_NONOTIFY that can be passed to the LMB API's for
> > > reserving memory. This will then result in no notification being sent
> > > from the LMB module for the changes to the LMB's memory map.
> >
> > You seem to be using this in patch 3 and 7.
> >
> > Please, describe in this patch why you want to be able to suppress
> > notification.
>
> Will add the reasoning behind this flag in the commit message.
>
> >
> > In the EFI context we should use LMB notification to notify the
> > EFI_EVENT_GROUP_MEMORY_MAP_CHANGE event.
> >
> > See chapter 7.1.2 EFI_BOOT_SERVICES.CreateEventEx() in the UEFI
> > specification.
>
> So, do you want me to use the EFI event signaling mechanism for this
> purpose ? Is my understanding correct ? If so, this will mean that we
> have an event notification specifically for EFI, and there might be
> one needed for any other consumers of this event. Currently there
> aren't any other consumers of the LMB memory map change event other
> than EFI, but using the U-Boot's event notification mechanism means
> that the same notification mechanism can be used if there were any
> additional consumers of this event in the future. In that case, we
> would have two separate event notifications, one for EFI, and one for
> non-EFI consumers.

As I have previously said, none of this is necessary.

Essentially all of the EFI setup that is done in U-Boot can be delayed
until we are actually starting an EFI app. The current approach of
keeping parallel EFI tables everywhere is causing much confusion.

For EFI, it should be enough to read the lmb tables at the end and add
whatever parallel tables are needed to boot the app. We should not
need to keep things in sync through the life of U-Boot, since:

1. EFI pool-allocations should use malloc() until the app starts
2. EFI page allocations should not be allowed until the app starts

This whole area needs a healthy dose of 'keep it simple'.

Regards,
Simon
