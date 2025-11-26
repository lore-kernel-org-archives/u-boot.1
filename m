Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7E3D10F43
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 13:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 712C18422F;
	Wed, 26 Nov 2025 14:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O60/M2xb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE99883E0E; Wed, 26 Nov 2025 10:06:50 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 659CF83C53
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 10:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-37a415a22ecso6201091fa.0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 01:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764148007; x=1764752807; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vLD4iCtGjSSkVw/9kgCVQ2ApNxA4gjWGu5JsUxQZqqk=;
 b=O60/M2xbFyNZzmh7ZVV5eSiwIzI8G5KRz9jjTfAQRRbEgDf0WaMTyUh7GVXYAfIlct
 4bkTEHaMF18dnWxOH9sWbHiFyKmEWrc1Cop/W1iWoRchWlmNy5/BZ9S/nc3HOMFvsIqr
 NZ+zyiIGalpjz0ftJnEY44jlRh50IfPv/yqR/Qw8Y8ulldDAElbjrpMw99Lr1ZoqmEYp
 GU8WN0WwnOZl8P5+QjdN6t4dyc2O2FZ3KGFzoITpQYk75S9txtzutVBcIwVVIkvVH3NX
 T+vvQuopwMmfywW1RaJYv8uBYOCm3LQHeygkRY1s57P/o2BSvnENOuJFd2DRTVYumOYK
 uLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764148008; x=1764752808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLD4iCtGjSSkVw/9kgCVQ2ApNxA4gjWGu5JsUxQZqqk=;
 b=XO+4iKzXxrrFihNLjR2PBv+BnsmV1Mk7+0MUquneyRtq8kGdbXpnDLUOOlQg0+4wGX
 6CkIzqnQI2TUdyuJorjMF3EuvtvHRIzA6cfZg+tERrdxdqo5/h2Z0W8NfdnN0rcZZmt8
 wORsXZHLbek86MOaPKfzD+3lmvKsJNpErR6bvf5n54iq/S/y+Oja7kim0vGNaI5Vt+Yr
 1xrGYRJo21fLqCEfMJS4Gr8Ce6mU7l1D/on6iPwSmazhJBokdqlXHGGCV7opUJNLYFLx
 vMfIYkp9OxEfxb9OKHWCtuLPaCdwy1HBuboyU+d9VISsT+xaFd8EHpqKh/5S810gekjc
 9qgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgNBdXIjHq3ACfI5A9XxQjQWCVtlP3xA40/a3+9QHXETiFZF3drhHwAZQgokENfy0/BzsGGeQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxI/g6j8Yt7Ktg235KPLJJ83/LA1UKYGCr2djrPuAgXXwmhN/+A
 ZNaOyjwnVT45WAPPlGoeturQV/dW+bevy/ifVPPH/61F9CG7Eagh23q4oTU8lGcMB5fTogY0cP8
 pdekIJ2PqZ1gLL7rpCJHdT6nxOFVzjKvscGKY
X-Gm-Gg: ASbGnct6eLsIU/u+q3hXmQbgaeicbyuzimvtJEDoRYW0z4B2YtiVW2ugqExqlda+Vh5
 sl23YFGUdpt/aYGjr4gn3UBhBAuCeKjoKQj7sR94YM/de0w5p3eNmTGC2tdxdjrN2Uqz8nOewZz
 UWOssiOP5T2umPMhCZHWrGcgZZgyxM8CsV+a7vGHxx6j7C4Ib6WpTrexkkC16LLXbHR2ygCQIy2
 613A1ftaqjGl5C6QCPejsfZKXBC3CPIpVCQA1/YCLV5Ff7if00wr4yKWejrqnLU1bV0Adux2rLB
 EeHKYAcObZxSeifCe35nCrLQQ6D4
X-Google-Smtp-Source: AGHT+IFM9cJuLQkx1V4t9OqowYsgJbhhmn23s/EjO4oJ8THJLLqT46y+LKnMdst9jU8GQOVPc3FvmI+NUyNOc6rXCGM=
X-Received: by 2002:a05:651c:1111:b0:37a:4277:86f8 with SMTP id
 38308e7fff4ca-37cd802f8a6mr44478711fa.10.1764148007333; Wed, 26 Nov 2025
 01:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20251118232119.17928-1-semen.protsenko@linaro.org>
 <CAPLW+4m9eTWDYfJt7rjorHpwZcM2MCKR-aq+uddN6=v=2m0rkA@mail.gmail.com>
In-Reply-To: <CAPLW+4m9eTWDYfJt7rjorHpwZcM2MCKR-aq+uddN6=v=2m0rkA@mail.gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Wed, 26 Nov 2025 18:06:34 +0900
X-Gm-Features: AWmQ_bmtH5Kii8Mt00U4rvHTIZOag-NsyhePtN9dovkzino5rQMz_f3hdw5dPc4
Message-ID: <CALrBrZ0mDfjAJmjbUsunabjStbqKU1_C-CJdNDmKVHEY_J0BHA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] board: samsung: e850-96: Support USB boot
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, U-Boot Mailing List <u-boot@lists.denx.de>
X-Mailman-Approved-At: Wed, 26 Nov 2025 14:01:59 +0100
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

Hi,


2025=EB=85=84 11=EC=9B=94 25=EC=9D=BC (=ED=99=94) 05:47, Sam Protsenko <sem=
en.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Hi Minkyu,
>
> If there are no objections, can you please apply this series to your tree=
?
>
> Thanks!
>
> On Tue, Nov 18, 2025 at 5:21=E2=80=AFPM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> >
> > When U-Boot is executed during USB boot [1,2] on E850-96 board, two
> > issues happen:
> >
> >   1. eMMC fails to initialize
> >   2. Attempt to use USB PHY driver leads to abort
> >
> > It was identified that issue #1 happens due to enalbed Flash Memory
> > Protector bits in MMC block registers during USB boot, and it's handled
> > in patch series [3].
> >
> > Issue #2 on the other hand happens because ROM code expects the
> > bootloader (U-Boot) to download remaining binaries (LDFW and TZSW) over
> > USB using SMC calls. Before that, the access to USB blocks (USB PHY and
> > DWC3) is disabled, probably because corresponding TrustZone domains are
> > configured for access from Secure World only.
> >
> > This patch series implements downloading LDFW and TZSW firmware over US=
B
> > during USB boot, which makes it possible to use U-Boot for flashing
> > images to eMMC using fastboot and DFU protocols. That in turn simplifie=
s
> > the U-Boot development, as one can use `dltool' [1] to run U-Boot binar=
y
> > during USB boot, and update U-Boot on eMMC this way (e.g. using DFU).
> > It's not possible when using LittleKernel bootloader, as it expects
> > non-standard Samsung GPT partition, but in case of U-Boot we use the
> > regular one.
> >
> > Once this patch series and patch series [3] are applied it'll be
> > possible to use U-Boot during USB boot. The two series are independent
> > of each other, and can be applied in any particular order.
> >
> > Changes in v3:
> >   - Added PATCH #6 (enter DFU automatically on USB boot)
> >   - Rebased on top of the most recent master
> >
> > Changes in v2:
> >   - PATCH #4: Return 0 on success in load_image_usb()
> >
> > [1] https://gitlab.com/LinaroLtd/e850-96/tools/dltool
> > [2] https://docs.u-boot.org/en/latest/board/samsung/e850-96.html
> > [3]
> https://lore.kernel.org/u-boot/20251026010658.19271-1-semen.protsenko@lin=
aro.org/
> >
> > Sam Protsenko (6):
> >   board: samsung: e850-96: Keep public functions together
> >   board: samsung: e850-96: Add routines for checking boot dev
> >   board: samsung: e850-96: Split LDFW loading and init
> >   board: samsung: e850-96: Add routine for loading images over USB
> >   board: samsung: e850-96: Load firmwares over USB on USB boot
> >   board: samsung: e850-96: Enter DFU automatically on USB boot
> >
> >  board/samsung/e850-96/Makefile  |  2 +-
> >  board/samsung/e850-96/bootdev.c | 99 +++++++++++++++++++++++++++++++++
> >  board/samsung/e850-96/bootdev.h | 23 ++++++++
> >  board/samsung/e850-96/e850-96.c | 71 ++++++++++++++++++-----
> >  board/samsung/e850-96/fw.c      | 76 ++++++++++++++++++-------
> >  board/samsung/e850-96/fw.h      | 10 +++-
> >  6 files changed, 246 insertions(+), 35 deletions(-)
> >  create mode 100644 board/samsung/e850-96/bootdev.c
> >  create mode 100644 board/samsung/e850-96/bootdev.h
> >
> >
> > base-commit: 91861e5a30d217d8e70130c9124c1646f4afef29
> > --
> > 2.47.3
> >
>

applied to u-boot-samsung.

Thanks,
Minkyu Kang.

>
