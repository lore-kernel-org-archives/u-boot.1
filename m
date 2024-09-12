Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF75EE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC4F88E75;
	Thu, 12 Sep 2024 03:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XR5sTT8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9939888E74; Thu, 12 Sep 2024 03:02:02 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 777EE88E03
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7179802b8fcso264390b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102917; x=1726707717; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=geG8Lax67aFs7P9A3BgH1taEUtq5BJQtKzs2NYwYlvw=;
 b=XR5sTT8mOP+N7w4TjzNZ/g+SwpsZtUDaLub141F7UFfk68dVcIgeXwmyCpc1XTFflh
 qn5CaztMzDZBFbwDRIzxn7UYGVwFxBs1H15SRw5/2ZwMbuG8HYevobCSnYEMshnaDdbR
 PsFF5lZB6xHiXvtRxgoLCwJmDuwExxWyyC0yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102917; x=1726707717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=geG8Lax67aFs7P9A3BgH1taEUtq5BJQtKzs2NYwYlvw=;
 b=erbNWmHS0o/j/E0bFDP0eNxU8FT5hXRtQRy3D7fdbln+8q79x9R8FZnAyFdGhK/PhX
 YEf4ANbmP18er5XMTh+mxt3hPV3Vl+/eOZRqUH9QdKI37QxX6nkp+6B4JR7kFiihzAaU
 ULhIAcnMChsvnXMeVvVpTpJeQuPi1dejnGmBsXiNY7xDmGtjWGK6ZkKnvdsQT+4ArfqD
 ytOmTdp9RVLJuUWCAkzbCc1gUJzANJHKvDRn3XPOdDqoOzXQ/DJYzhCgqDtoEtltkVY5
 SMyQK8QTlNR5lxwacm6Wb4T678+pvtr0Zw5FLdfmzLaiwJ7U1ByIyK/upugNrJXcNO1z
 VMEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeoC3r1myauJ7I7qBWGvBBQy4yrTeioQpJDMwMo6hGT6QS0mXrLH5wqc6iiBJ0w1PpfRJI+WA=@lists.denx.de
X-Gm-Message-State: AOJu0YyTXmS2g9v5m6+sm2rKQsADQ5RaiRpwwiIU73Bdn3TVs4rsIqo7
 lwqNHrpMFfKZtkEC3S0UuSxoFIvVv+WXDddIt1qq1egtMeKtm2QrAkMCmEGLmu+S17ysTXYkxCi
 v+t3OnikDos5gh6YiRVdyFAReQGlwsNiirlhl
X-Google-Smtp-Source: AGHT+IGHNgLXAbNYx9slgMg0wwTNPJ1BOjlFR0rWhT+g+8myA6rx86wZEVm+NnF9P3GDwl+9Ke1sMDa5QtTsMy/OtJk=
X-Received: by 2002:a05:6a21:e88:b0:1cf:42bf:6af1 with SMTP id
 adf61e73a8af0-1cf75ea21bbmr1294521637.2.1726102916814; Wed, 11 Sep 2024
 18:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-14-patrick.rudolph@9elements.com>
 <CALeDE9O6fbvfjyqcd32vo6SYBy9OUm+xfz9DV7akiGRS9jGNCg@mail.gmail.com>
In-Reply-To: <CALeDE9O6fbvfjyqcd32vo6SYBy9OUm+xfz9DV7akiGRS9jGNCg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:01:41 -0600
Message-ID: <CAFLszThHR4DB3Y=PZOdeKVRyYccHD+i57dfEyxB5L6Ua60MouQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/30] acpi: acpi_table: Support ACPI 2.0 platforms
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>
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

Hi Patrick,

On Wed, 11 Sept 2024 at 03:46, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> > On platforms that do not have usable DRAM below 4GiB, like QEMU sbsa,
> > the RSDT cannot be used. Allow both RSDT and XSDT to be null and only
> > fill those tables that are present in acpi_add_table().
>
> I'm not sure what ACPI 2.0 from the subject has to do with the above,
> eg ACPI only started supporting aarch64 with ACPI 5.1

Should perhaps be something like 'Support platforms without an RSDR'?

>
> > Fixes a crash on QEMU sbsa.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> >  lib/acpi/acpi_table.c | 95 ++++++++++++++++++++++++++-----------------
> >  1 file changed, 57 insertions(+), 38 deletions(-)
> >

Reviewed-by: Simon Glass <sjg@chromium.org>

I was trying to see if this patch could be split into something which
refactors the code and then another patch to fix the bug, but I can't
see it.

Regards,
Simon
