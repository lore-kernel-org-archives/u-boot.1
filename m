Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CCCD2C543
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B348488F99;
	Tue, 22 Oct 2024 14:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KY9ybxAR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E973A88969; Tue, 22 Oct 2024 14:16:05 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0199E88969
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539f2b95775so6568458e87.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729599361; x=1730204161; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yNCDYsBPe0Jkk0AlmG4RiF9c3o5m1g4nrO6GN7rOBxQ=;
 b=KY9ybxARbjAFcAngKc2TxKX6QbF4VzotyyDJdMlosglhdJlHsc5kuRBgQnziYsDA+e
 CI23VAqJQCdo2oj8ARjyqBfgjkgcJ3EgRBcWpV5+HvAZmWicueDA8HhNj7X/Q5ZuDnDc
 ONADR5d4Hxw96yBFIuR4ZEBGnRYsEO5Zr023E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729599361; x=1730204161;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yNCDYsBPe0Jkk0AlmG4RiF9c3o5m1g4nrO6GN7rOBxQ=;
 b=qSZtWLE7bCZU6FS6Ghffok5V6t3mHUMP2uFA6TbOdFcgSpl2yBcYELSNDufc0abjrY
 +dFPiw3+m3UNhC2lqNunt6p2+YgvijpjfE1he2GWex5rhqw3iSoLUPKpfBHQev++8Y3g
 m6gi9bal1Gs+hVsrzXXAUrYC7Zq//Fb1rwd84ZTteIbfwtMDv3dnRZmM3RuZdXa6vIpM
 XolFU0z8oSM34tbVNsawdRKtB8pRrZxCOTnol6RlJZs9VZRFt4e6ovFsT4IVRc46hc7J
 d+E5kY17dqlWRja4IbOE3tfmY5qYPFpElKWNRuc7hxM1I0AJJFR7SNrU7X/V3xvN8b3n
 XoKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX24g3AZWS6L8jyBNVaJPv3SOtgyhvQyShOY3GK9dWh8sihsKxnZE+pU7Izpiula9uxx+14cj8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2Qpz7S1iZ6GznhAbaQuw/vqTcU+KEVGR47ecY+e7rfftpd9Cg
 RpSlsLq5Fd24gMTVEwvOBTxQnoZ5Y9pja4nYOdQkAXxyCgqLb6QlZi7Z4ffEOBF5eR97Vf4RCKF
 5/GluesCAGFDEPeHbW27Po6FiO1r2XfkYP8UT
X-Google-Smtp-Source: AGHT+IElDEvTr104OzYQiSWYjXzFLqVLeDdR/85V9cjjpueIQo9urCLWHbsWR/6vbSQyYVLl0hGDT7qcmtUr6f+7NeM=
X-Received: by 2002:a05:6512:1091:b0:539:94f5:bf with SMTP id
 2adb3069b0e04-53a154eb367mr12340140e87.59.1729599361264; Tue, 22 Oct 2024
 05:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-25-patrick.rudolph@9elements.com>
 <CAFLszTh4Z8p-8d8ASrpUTnNdDhmijDm8fcct-wDWR1nRFxs5JA@mail.gmail.com>
 <CALNFmy1=R4vp6S3H3a_3HTDjGufDxu+Heo-vk=GRjb0aj0z0Dg@mail.gmail.com>
 <CAFLszTjTA98Re5rWXHpMQZADXU7uLbCayxNTtugYRxHZaFUL_w@mail.gmail.com>
 <CALeDE9P04s7uX0Egq+seDbHyn_QXgz+NWPHtJ2W1CGKtATPLsw@mail.gmail.com>
In-Reply-To: <CALeDE9P04s7uX0Egq+seDbHyn_QXgz+NWPHtJ2W1CGKtATPLsw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 14:15:50 +0200
Message-ID: <CAFLszTgE+fjXGXFvJ0KWdw=q8CP_53kfWq0nrGZzJzyHJhdHFA@mail.gmail.com>
Subject: Re: [PATCH v9 24/37] common: Enable BLOBLIST_TABLES on arm
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 linux-kernel@vger.kernel.org, Tom Rini <trini@konsulko.com>
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

Hi Peter,

On Mon, 21 Oct 2024 at 19:57, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> > > > > Allow to use BLOBLIST_TABLES on arm to store ACPI or other tables.
> > > > >
> > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > ---
> > > > > Changelog v9:
> > > > > - default to BLOBLIST_ALLOC on arm
> > > > > - Move default for BLOBLIST_SIZE_RELOC up
> > > > > ---
> > > > >  common/Kconfig |  2 ++
> > > > >  lib/Kconfig    | 15 +++++++++------
> > > > >  2 files changed, 11 insertions(+), 6 deletions(-)
> > > > >
> > > >
> > > > This is fine, but please disable it for snow since it needs the FIXED
> > > > option for now.
> > >
> > > I cannot follow. What needs the FIXED option and what to disable?
> > > I run this patch on the CI and test_py_sandbox tests are still working.
> >
> > I mean that snow cannot use BLOBLIST_ALLOC and needs BLOBLIST_FIXED so
> > if you make ALLOC the default you need to change the default for snow.
>
> Simon by snow do you mean the device (configs/snow_defconfig) snow, I
> think Patrick doesn't know you're referring to what I believe to be a
> device config.

Oh OK, yes that is what I mean. If it is too confusing I can send a
fix-up patch after this series is applied.

Regards,
SImon
