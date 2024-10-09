Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F325CF042E
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B290D8912E;
	Wed,  9 Oct 2024 03:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CboSOf2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4B13885F4; Wed,  9 Oct 2024 03:57:31 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F18BC82BA7
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbc7976a6dso4170906d6.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439047; x=1729043847; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2pIbHQoLunftIinQY8Ln27ftQhEoMf6EpA08zh4sRTI=;
 b=CboSOf2FQ+H/a5TNcd7E40UyCZic1byhMLGjA7l5vQ9RDUyXusrKc8Yh7sdgSU2aat
 9dBLcda69nPlFgMj93cxicP3rVp/7d471xke8w+I9HYYHYcQX53qEc22airbZJWcbJqN
 4a4y4V08ZvND4dmQermTOFPKbGWcJmYawnMhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439047; x=1729043847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2pIbHQoLunftIinQY8Ln27ftQhEoMf6EpA08zh4sRTI=;
 b=BKM00nl/vQAKm+qKo9ZYXZnbLSNY0mMyOJbiAPC0Y+d4LvrnMLJNJIPKD62piIOmRq
 iJRH3O0zfDRTx0QGWItFunuEJFtJlGP10q+cmRZd/AtLuPeNy6N36ocoGbu+y05fVDMK
 0Gty3Nhwl41gdf8FhgP28ElikE/zJjh27IHl79vkhSNKrSvR/rY7vhO4rdZURzEci4Op
 n5eex8IWl4VfzmjTwz31UkIPVv3aZ0xEIReR9/Yy5nfOdP/bTLPnjwL27+WU4xbkyd8V
 YFzmn+0K7C+PTcy0RvriKw9AonFp4k+xDZ39g8+I29ekkLZ/lHPjZfiDgZdnCDHIK1zT
 iI7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGANWPUa1qqd2WbUQ19M8p4xnvK0T5Gs5J/ZF6B1+o7ximpIyrQnO0wWf7d2zTFgSQn5RWVjs=@lists.denx.de
X-Gm-Message-State: AOJu0Yyj3xmeaC+oImdwf7k6ywmnhapddqr0oa/yrNmjvVFb0a/q70nZ
 tDlnD74U90tHTR0Fi8jOkkFutlrRz3bIm6E9uK1zFkF+DSqLvVzkpqM4u4Gtu7fKVCfqCBe5gnq
 /WwVGIb4m/bk+xnWGkDZQ74HfBsI5ee4aUFNA
X-Google-Smtp-Source: AGHT+IG9o8XvhScOIJ2obJfSs+zP22fDBtvtJP8twsULQFCWLWlWXtLG1zR51Rii4UUvdZzqdr/UJC6T0esiq6LD2vE=
X-Received: by 2002:a05:6214:5a04:b0:6cb:3c1e:76d0 with SMTP id
 6a1803df08f44-6cbc95a0b7emr16388846d6.40.1728439046899; Tue, 08 Oct 2024
 18:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
In-Reply-To: <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:57:15 -0600
Message-ID: <CAFLszTh7qjUN__MvAbcMPL+W4V=mfBrgt9zcg8zyfx+WBN=9bg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] cmd: bcb: introduce 'ab_dump' command to print BCB
 block content
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
 "Andrew F. Davis" <afd@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com, 
 kernel@salutedevices.com
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

On Tue, 8 Oct 2024 at 14:18, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
>
> It's really helpful to have the ability to dump BCB block for debugging
> A/B logic on the board supported this partition schema.
>
> Command 'bcb ab_dump' prints all fields of bootloader_control struct
> including slot_metadata for all presented slots.
>
> Output example:
> =====
> > board# bcb ab_dump ubi 0#misc
> > Read 512 bytes from volume misc to 000000000bf07580
> > Read 512 bytes from volume misc to 000000000bf42f40
> > Bootloader Control:       [misc]
> > Active Slot:              _a
> > Magic Number:             0x42414342
> > Version:                  1
> > Number of Slots:          2
> > Recovery Tries Remaining: 0
> > CRC:                      0x2c8b50bc (Valid)
> >
> > Slot[0] Metadata:
> >       - Priority:         15
> >       - Tries Remaining:  0
> >       - Successful Boot:  1
> >       - Verity Corrupted: 0
> >
> > Slot[1] Metadata:
> >       - Priority:         14
> >       - Tries Remaining:  7
> >       - Successful Boot:  0
> >       - Verity Corrupted: 0
> ====
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  cmd/bcb.c            | 35 +++++++++++++++++++++++++++
>  include/android_ab.h | 10 ++++++++
>  3 files changed, 113 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Can you also update the test?
