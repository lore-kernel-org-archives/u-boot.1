Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15BCE7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 13:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E8528036B;
	Fri, 10 Jan 2025 14:41:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bzLNQAL3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1873E80658; Fri, 10 Jan 2025 14:41:09 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FCF280619
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 14:41:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so2970548a91.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 05:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736516463; x=1737121263; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T14nG3mPtJIXSBPsSXEUWvazF0MbhS6N5TgR+f/yU+0=;
 b=bzLNQAL3GPUVUQ4KdsrDmeu6d+KIZUQ5eG0dYiRQwxYDlV9llv+iouezjhYj2xHsF9
 34jrjz9hr95zstEcsL0S4uFAipoRgeGbS7baAy9OfNxqlq+9fRqQxRVpChS7wZzS1G2w
 5ZetHGiPuDO+9zgPgRHI9Di+Wj+X8Zf8rK8Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736516463; x=1737121263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T14nG3mPtJIXSBPsSXEUWvazF0MbhS6N5TgR+f/yU+0=;
 b=qfYaq0zgUXclcszlBM0ekR3MffD8Y1MznUo6OrMhPrv0rQyMr5gkAv+cYbLNhX2BLL
 f0tZleQO6IT7gMXCTsHK6rq8cxYPcaHPLjPnItzonttedpr6V87y6Y1/ddmBVe7g1cO7
 1DGUdyvTAe9IcbN4yJ2wZq9VPklWOinTIu3d/Bss9ZT5evdOjCVmW3PhulwNcVJonpCK
 3OHxFXIzBdWJ4gqqi0YhnPOayjWtG3E2aUjGFxIMkvGeFRaZJ6zVvcP0UjT6naevL4uH
 PI3pHCrWVqzQ3QD7XQkJo5LodHFLoYWL7OYeT4OaqSYz5Ps3rJz0hEQyxv48kb8l7WaM
 R49w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsarGbdsH0j8HWLJzmsisTKY4csYuKCGKLB8S0ggeGH41hvjGl3/zcG55SRDbqh6g5ej21+2g=@lists.denx.de
X-Gm-Message-State: AOJu0YxZhy0XB9w1XdYvgodtpd2mlKVBwuF4oZry9Wi3M7gm7ts/5lSX
 SERL0cAXvS/24IgzOD3hvrKDnSR4MLRgnjYDs+/Bo/WZJBbK2hU6HBlMOE9vxzJNdPVMOU0PxdJ
 eX8xdCgcPRw6f2QK6d4fzk86rOAYhQfORJ8vk
X-Gm-Gg: ASbGncslx+8J9wP7NSVeN/vyZzTZUdIp1xRwe0T6n+A/lXzT8rthgH1f5XEWLpiEqCu
 77S+cXP/HR2Le7vxvgCw8jeQyWmKA0X3Im+b7cW0=
X-Google-Smtp-Source: AGHT+IH2q78B3MkmDAnrjOd3KNXKCuAioVDCSsOtuxBLOUttzfqslS9WkdV/qkgEnhxK5zyx2mehy+ZBAIKW8vzL3r0=
X-Received: by 2002:a17:90b:280a:b0:2ee:d186:fe48 with SMTP id
 98e67ed59e1d1-2f548f1b5cfmr15167860a91.28.1736516462887; Fri, 10 Jan 2025
 05:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20241219023832.1098689-1-sjg@chromium.org>
 <20241219023832.1098689-5-sjg@chromium.org>
 <4a0a3ab8-d828-426f-93b8-364e0eeb9f74@gmx.de>
 <CAC_iWjKyBV3xYDNcXQkZ8QOiWPJxn53kgqoPoT1ZXDSD_SDevw@mail.gmail.com>
 <CAFLszTi02WTz1TRZBtH1JKQo-zfdX345f_HiA9V4ia8j==8fAg@mail.gmail.com>
 <875xmongv1.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <875xmongv1.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Jan 2025 06:40:42 -0700
X-Gm-Features: AbW1kvZiIEv3VgCH_qjZ8scSr-ht9lTBl6JXFVdNmU7u1CzL2IpjJlbSKr2NQ10
Message-ID: <CAFLszTg7tiCX3pfXmLs92vN1aj3SQux1JVygB4x=d-xjgUnLdw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] efi_loader: Add a version of efi_binary_run() with
 more parameters
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, trini@konsulko.com, 
 akashi.tkhro@gmail.com, adrianox@gmail.com, u-boot@lists.denx.de, 
 moritzf@google.com
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

Hi Mark,

On Thu, 9 Jan 2025 at 08:31, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> > Date: Thu, 9 Jan 2025 08:01:34 -0700
> >
> > Hi guys,
> >
> > On Sun, 22 Dec 2024 at 06:17, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Heinrich
> > >
> > > On Sun, 22 Dec 2024 at 14:45, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> > > > On 12/19/24 03:38, Simon Glass wrote:
> > > > > This uses a few global variables at present. With the bootflow we have
> > > > > the required parameters, so add a function which accepts these. Update
> > > > > the existing function to call the new one with the globals.
> > > > >
> > > > > - Rename efi_binary_run_() to _efi_binary_run()
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >   lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
> > > > >   1 file changed, 25 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > > > > index b42ff3cb4e0..f7aedeaab8a 100644
> > > > > --- a/lib/efi_loader/efi_bootbin.c
> > > > > +++ b/lib/efi_loader/efi_bootbin.c
> > > > > @@ -228,18 +228,22 @@ out:
> > > > >   }
> > > > >
> > > > >   /**
> > > > > - * efi_binary_run() - run loaded UEFI image
> > > > > + * efi_binary_run_() - run loaded UEFI image
> > > > >    *
> > > > >    * @image_ptr:      memory address of the UEFI image
> > > > >    * @size:   size of the UEFI image
> > > > >    * @fdt:    device-tree
> > > > > + * @device:  EFI device-path
> > > > > + * @image:   EFI image-path
> > > > >    *
> > > > >    * Execute an EFI binary image loaded at @image.
> > > > >    * @size may be zero if the binary is loaded with U-Boot load command.
> > > > >    *
> > > > >    * Return:  status code
> > > > >    */
> > > > > -efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> > > > > +efi_status_t _efi_binary_run(void *image_ptr, size_t size, void *fdt,
> > > > > +                          struct efi_device_path *device,
> > > > > +                          struct efi_device_path *image)
> > > >
> > > > A non-static function starting with underscore? Please, avoid this.
> > >
> > > I was the one who requested this, the v1 had it as efi_binary_run_,
> > > but i a dont mind any of those
> >
> > Well I'm not changing it again :-) Heinrich you are free to send a
> > patch later.
>
> Well, you shouldn't commit a diff where the function starts with an
> underscore but the comment documenting the function ends with an
> underscore.

Oh dear...perhaps Heinrich can fix it up / decide when applying.

Regards,
Simon
