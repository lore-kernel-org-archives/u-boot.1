Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A63DD2CE07
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 17:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5596A88F62;
	Tue, 22 Oct 2024 19:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HZjMD5wb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90D5589251; Tue, 22 Oct 2024 19:01:33 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F68688ECB
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 19:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-539ee1acb86so4095087e87.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729616488; x=1730221288; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zu485c5QOL9Uq0W8KFhjSs4H9Jf95wyVtKN5ZwvCgPo=;
 b=HZjMD5wb6c4YImMiNv9DY2SyTyPV6itkPZYTE6GIW4LRhniW38zAA9bP1fasMtML4e
 KGW7yX364PsjH9dmGxznJ8kwkKPMO+d5ZbDpfEhtuuHM9i7Zhvp5hWcOMR70pLK71upU
 zpEoJHah3EnlAh2upvzTwczOBxWfXC39jFmfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729616488; x=1730221288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zu485c5QOL9Uq0W8KFhjSs4H9Jf95wyVtKN5ZwvCgPo=;
 b=g8wvxgwqf2WlmVf3lAPQ6+5LwrI2G3NyyWhx+Yx1ELr+HqLeUviiN5KTx7wAv598VM
 kmOIveGAPK+LhYt7F+iJxKeHEAVhJBBJrc1EGeF/cLnCc87cvpCvfzcIH0Ek/T9ziR32
 uwdp542Fk0mYegLaMb22hY1q4MzLds9r7KaH2rrwvVuZ+X4d7y/WdyErT/XIX4+BzVju
 Vtd/lsLrHjkFGKnIUkOi940i6V7N4Enq3rgzuRuReI+J6dbwXEqmUs5z7gr4BI5ms3Jx
 tc1/0BOWyNyTLpM2b/Bf1pJdll6Zq5MkDXr1smnkDggHUQxPcUYr7Phsfbf3i9i5fFBV
 qm6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFo1hdws0YHWyUkw2pF9CixsuRgBDNSd9xD6JQkIDRhUR65MlGBWNlB1u1mjB9BwzsArl4TP4=@lists.denx.de
X-Gm-Message-State: AOJu0YwoieZLRvVOGQtmfT9ivQOzSPoIROu01aE74nctQ252c/WkFG/G
 Vj0C+FvHqNV/j0P6qXVPpjgQFTVGheknPMIq2NGGJgvWPgPyYLvmP0vg70g09oGjbZ6ccsQ4HO8
 1DKyIRvlay7HDZporJO9maMo7851cM4FndjOu
X-Google-Smtp-Source: AGHT+IFk0LVKitzrieTk4+PMmay3cOKMkCi2sdX689/k1/29p+yeo4Qup0q7blMbJZfrxrvdnadXpMVuYG4zN5k7whQ=
X-Received: by 2002:a05:6512:2208:b0:539:8fcd:51f with SMTP id
 2adb3069b0e04-53b1921f298mr148961e87.30.1729616488343; Tue, 22 Oct 2024
 10:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-25-patrick.rudolph@9elements.com>
 <CAFLszTh4Z8p-8d8ASrpUTnNdDhmijDm8fcct-wDWR1nRFxs5JA@mail.gmail.com>
 <CALNFmy1=R4vp6S3H3a_3HTDjGufDxu+Heo-vk=GRjb0aj0z0Dg@mail.gmail.com>
 <CAFLszTjTA98Re5rWXHpMQZADXU7uLbCayxNTtugYRxHZaFUL_w@mail.gmail.com>
 <CALeDE9P04s7uX0Egq+seDbHyn_QXgz+NWPHtJ2W1CGKtATPLsw@mail.gmail.com>
 <CAFLszTgE+fjXGXFvJ0KWdw=q8CP_53kfWq0nrGZzJzyHJhdHFA@mail.gmail.com>
 <CALNFmy1P-K6j1q9dm92iJ87h9WnjnvnzwhC1a3jaugahFhv6ZQ@mail.gmail.com>
In-Reply-To: <CALNFmy1P-K6j1q9dm92iJ87h9WnjnvnzwhC1a3jaugahFhv6ZQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 19:00:49 +0200
Message-ID: <CAFLszTiWxQjjfg4ydQDEOH2-J0_7O5rYNowFPPJB9w86QY3gXw@mail.gmail.com>
Subject: Re: [PATCH v9 24/37] common: Enable BLOBLIST_TABLES on arm
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, 
 linux-kernel@vger.kernel.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 22 Oct 2024 at 18:18, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Hi Simon,
> On Tue, Oct 22, 2024 at 2:16=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Peter,
> >
> > On Mon, 21 Oct 2024 at 19:57, Peter Robinson <pbrobinson@gmail.com> wro=
te:
> > >
> > > > > > > Allow to use BLOBLIST_TABLES on arm to store ACPI or other ta=
bles.
> > > > > > >
> > > > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com=
>
> > > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > > ---
> > > > > > > Changelog v9:
> > > > > > > - default to BLOBLIST_ALLOC on arm
> > > > > > > - Move default for BLOBLIST_SIZE_RELOC up
> > > > > > > ---
> > > > > > >  common/Kconfig |  2 ++
> > > > > > >  lib/Kconfig    | 15 +++++++++------
> > > > > > >  2 files changed, 11 insertions(+), 6 deletions(-)
> > > > > > >
> > > > > >
> > > > > > This is fine, but please disable it for snow since it needs the=
 FIXED
> > > > > > option for now.
> > > > >
> > > > > I cannot follow. What needs the FIXED option and what to disable?
> > > > > I run this patch on the CI and test_py_sandbox tests are still wo=
rking.
> > > >
> > > > I mean that snow cannot use BLOBLIST_ALLOC and needs BLOBLIST_FIXED=
 so
> > > > if you make ALLOC the default you need to change the default for sn=
ow.
> > >
> > > Simon by snow do you mean the device (configs/snow_defconfig) snow, I
> > > think Patrick doesn't know you're referring to what I believe to be a
> > > device config.
> >
> > Oh OK, yes that is what I mean. If it is too confusing I can send a
> > fix-up patch after this series is applied.
> >
> Oh OK, got it.
> I wasn't aware that BLOBLIST is already used on some ARM devices.
> I'll send an updated version.
> Is it possible to migrate those to BLOBLIST_ALLOC? Any reason they
> would use a fixed address?

Not easily, since it puts the table in SRAM. But it would be possible
to migrate snow to use the handle protocol.

Regards,
Simon
