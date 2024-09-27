Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334C6CDE02F
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 12:34:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3265890C6;
	Fri, 27 Sep 2024 14:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N9uCowYg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1C4389102; Fri, 27 Sep 2024 14:34:00 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 873CD890BB
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 14:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7091558067eso875665a34.3
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 05:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727440437; x=1728045237; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kwv79AErk0nHrtyQPaTo9qcy918IBS3Jj834AIGYVHU=;
 b=N9uCowYgTlSYltEIVzKa+j34tVRDGW6YI6EgAcgO9EP8Kya7IwABPtjyqjrU6qUYs0
 ZCHeBa84OM0/A1GPA9Kdxz1Bkbl9TVpo/70RSWtODs4Edmz4WPnzvq8QndhidtaUpRt1
 NTkK3BPYJxNT8Y3EdsNpuZUMGlJRI4uhAKiNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727440437; x=1728045237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kwv79AErk0nHrtyQPaTo9qcy918IBS3Jj834AIGYVHU=;
 b=uI9eNGRbsvFAZ0vDENklBvmYyd6SyDgC3Bo0sI3pkNI8Yp3KC/nn8CxK1rXE24I7NS
 5xN+u32RU5LdDy+FDqIx5hMbOMYlfS6dOBohaGx5ktGkDyoBPGN6i0K2Y9m58gPEEMrs
 FevGrohU8Nfi4IpPS7OX26v/8Hnf2v2RzOskXu4DOmtVW/3SvgiHdQHvflLPStqUPnSh
 SOh3cYyrr3DZ/zV8+Hkf3340yqQJkdC+yTkw5U8mUtzsHGjmUKMUp1W79D6nvutHGeXh
 PmnRa2O18uLb6nAHyGfNSYKblEHH6GhBjfz6/dRiZdZsD/JeFC+UpyyOpVfKSrthpT1u
 0CDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU23k4eOcTExLcww2yHNM78Ez1Kcowtw/ULQDANPMMpnhWKyNL8goqgZtsWhUyhHLYbwGpuKSA=@lists.denx.de
X-Gm-Message-State: AOJu0YzyV4GYoS9zJQNlRGJTvLNRcjkYgjbKKCoA/raNWvDFOoRB2pra
 IUb4xPnfbPSiA4zhmvjfu1TkLkyqaqmSsIINPdf4gPdlcKHrKkHslPhjE+I8dAV4QQWeu89tI0O
 WX2Wuw4yswourOAPudAMS9C0wsPqB3AVBmtT9
X-Google-Smtp-Source: AGHT+IHWraN3bZbJ1CCpzSTP9WahSmYyJrLv2JZ6uRBEI3PuqdlSB1dDiktjrKgc2jnvDy91+A9xLRt2vSDgVSxs6VE=
X-Received: by 2002:a05:6358:4314:b0:1b1:ac2e:af69 with SMTP id
 e5c5f4694b2df-1becbd0a143mr165097655d.17.1727440437273; Fri, 27 Sep 2024
 05:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-3-sughosh.ganu@linaro.org>
 <b83d04eb-bc3a-4387-b812-6973d851ae90@gmx.de>
 <CADg8p95VsW99mr=Y62_DYeRvrxBDT9zEz+H_nrt6oyYM76f1dA@mail.gmail.com>
 <CAFLszTjitzss7SCPhO8_wuRdXWVmF20M4pbxWjkXO0Ef9nyiVA@mail.gmail.com>
 <CAC_iWj+c375QaygfGwbHBKCr7ruaksHe85so3Nx5rr144coo6g@mail.gmail.com>
In-Reply-To: <CAC_iWj+c375QaygfGwbHBKCr7ruaksHe85so3Nx5rr144coo6g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Sep 2024 06:33:46 -0600
Message-ID: <CAFLszTh92Lnynbh3rxqb8+QsM1+9xGZmZy3D9Dc759EMer4wDA@mail.gmail.com>
Subject: Re: [PATCH 02/16] lmb: add a flag to allow suppressing memory map
 change notification
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
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

Hi Ilias,

On Fri, 27 Sept 2024 at 05:08, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 19 Sept 2024 at 17:12, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, 17 Sept 2024 at 13:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Sat, 14 Sept 2024 at 20:14, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> > > > On 9/5/24 10:27, Sughosh Ganu wrote:
> > > > > Add a flag LMB_NONOTIFY that can be passed to the LMB API's for
> > > > > reserving memory. This will then result in no notification being sent
> > > > > from the LMB module for the changes to the LMB's memory map.
> > > >
> > > > You seem to be using this in patch 3 and 7.
> > > >
> > > > Please, describe in this patch why you want to be able to suppress
> > > > notification.
> > >
> > > Will add the reasoning behind this flag in the commit message.
> > >
> > > >
> > > > In the EFI context we should use LMB notification to notify the
> > > > EFI_EVENT_GROUP_MEMORY_MAP_CHANGE event.
> > > >
> > > > See chapter 7.1.2 EFI_BOOT_SERVICES.CreateEventEx() in the UEFI
> > > > specification.
> > >
> > > So, do you want me to use the EFI event signaling mechanism for this
> > > purpose ? Is my understanding correct ? If so, this will mean that we
> > > have an event notification specifically for EFI, and there might be
> > > one needed for any other consumers of this event. Currently there
> > > aren't any other consumers of the LMB memory map change event other
> > > than EFI, but using the U-Boot's event notification mechanism means
> > > that the same notification mechanism can be used if there were any
> > > additional consumers of this event in the future. In that case, we
> > > would have two separate event notifications, one for EFI, and one for
> > > non-EFI consumers.
> >
> > As I have previously said, none of this is necessary.
> >
> > Essentially all of the EFI setup that is done in U-Boot can be delayed
> > until we are actually starting an EFI app.
>
> Can you explain how you plan to deal with EFI variables, the TPM
> eventlog, measuring events when tables are added, capsules updates etc
> etc, which expect certain EFI services to be up and running?

Yes, sure. Accessing EFI variables is going to require EFI to be
inited, I assume. For capsule updates, I believe that is triggered on
boot, so again it would need EFI services. It's fine to use EFI when
it is needed. But this memory-map thing has really got out of hand.
BTW we need TPM eventlog and measuring for any type of boot so it
needs to work without EFI.

>
> > The current approach of
> > keeping parallel EFI tables everywhere is causing much confusion.
>
> Apart from all of the above the EFI app can return. Which makes all of
> the above just a burden

It's fine if it returns, isn't it? What is the burden?

>
> >
> > For EFI, it should be enough to read the lmb tables at the end and add
> > whatever parallel tables are needed to boot the app.
>
> Yes apart from the fact that LMB has no idea about memory types or permissions.

Neither should it. It is for laying out images in memory. We need to
maintain some separation of concerns here, or we'll end up with a
complex mess. Memory types are really an EFI construct which should be
easy enough to add statically - e.g. U-Boot code is
EFI_BOOT_SERVICES_CODE. Memory permissions are known based on the
memory areas, so I don't think lmb needs to know about that.


>
> > We should not
> > need to keep things in sync through the life of U-Boot, since:
> >
> > 1. EFI pool-allocations should use malloc() until the app starts
> > 2. EFI page allocations should not be allowed until the app starts
> >
> > This whole area needs a healthy dose of 'keep it simple'.

Regards,
Simon
