Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1465DC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 20:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 808D686F1E;
	Tue, 19 Dec 2023 21:19:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JvGRDIlC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8650D86F42; Tue, 19 Dec 2023 21:19:21 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DDAE86EF3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 21:19:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2cc6acf5e3dso37577731fa.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 12:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703017158; x=1703621958; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G6XVYM5ceoSY5E0sB9M8AHP0+C3mbdYcgnGsikHIiZo=;
 b=JvGRDIlCnMcFn+Qvw8zkDWgmgpV3bjgQaYOeKWz0XbR9z316DMgg2drRNeFqrBTEha
 ad8+nF3QJMGkHsiN0VsWRTV5vVAa7lAxPriCC2Tlui7/WBkZdO8Cfqt2OPrNJIrJHRBZ
 Rup9WFj6M98ama9klURASGebeZ+VeCOcvSlrScrPlWQVyAOwot3vBz26wj1ZMv3kShFq
 8Zg9A2FmqsYlzIezFVw6hddxUHhBfAImBe5lazNhrmt4JbfGkcsFimxwkSV5pJ+7zv9f
 kT2S55zq1BZmbEVL8INLUWlZVWRVdazQ53US8G87aikAhv0GJSPRoyIKkvA9WL+1Zn8+
 Ybqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703017158; x=1703621958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G6XVYM5ceoSY5E0sB9M8AHP0+C3mbdYcgnGsikHIiZo=;
 b=tg7dmpBu3PlLnGQ4SKia5D520sPwKybIcS9Bq7MgUd/DMTKAyjZzZC0W8t/ntcuNRM
 8v3XgsJ8PtySwyh85QIYOhoxVZV4Jt2JJTADAlmzdTOc5HHCpodXOhQpLnKUzYCjEipy
 ZaqWXFCxI/RmnjSMyZNS/udbA70jvReA2IDQUVOV0CDGaF4MUso+tr6yc2klKzWXE4Js
 SxSyZr+Mr3bpkKMVtZRxnYWdB4x324pmyaP71Xx3pS0PyPKwtF77pvPoUJMiPhd6dqag
 hfopkLv2OKEJ+FSXn4t2GmIuzRqYb2f+Wj8sP8KDfHFiP0sQeHblFXzwLW9iMrZ0vUqU
 /X2w==
X-Gm-Message-State: AOJu0YyaFtYomqL0oEmEJa1LyOzAZHmBZ76230HYA8EvkSLRrO0qQi1l
 iM+aqlF4iYgk/jX7IWJMi6AcBh6Xysxe/Xi+GYfbwSn7mZw=
X-Google-Smtp-Source: AGHT+IG0nJUQBqL1GWdyzldLWQoBycVcT/J3qbv+Xg9ZAQZVwaOGwVGxX6jvVHx9lWGOMtJuYFDw2JUeDIXiVINcGmo=
X-Received: by 2002:a2e:2e12:0:b0:2cc:6bbf:ea8c with SMTP id
 u18-20020a2e2e12000000b002cc6bbfea8cmr1109232lju.176.1703017158226; Tue, 19
 Dec 2023 12:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2PtQQ81x-SqMs6NKSjMKFGShT65Rrtfc-CDOsdBxgJDQ@mail.gmail.com>
 <CAC_iWjJ52eK-v30T6XC1jHDDLvcuOX0p43PW8UCfakRPxMkQCw@mail.gmail.com>
 <CAPnjgZ2Ubr6kNfn+7bg+F_CV4H_wZMKaPq8F8njSfQNUF02+iA@mail.gmail.com>
 <CAC_iWj+X9Kw=1YOX0bny01JwkzCSyeZ6PB2-r_V-2TisgVG7WQ@mail.gmail.com>
 <20231209184915.GY2513409@bill-the-cat>
 <CAC_iWjKKG50d5QhUZFLUgxqO+VhgE7bC9Tk_SmCR0x4f3zD74g@mail.gmail.com>
 <CAPnjgZ27G=6fDadAiJk_aG9He2ZpyFhhsZDYxUwEp5+0AQatYg@mail.gmail.com>
 <20231213201909.GG2513409@bill-the-cat>
 <CAPnjgZ2Ljm2aR0w9zgJZ2O49XU8oNYsDi-EJ-PD=Z5mx2sQHrg@mail.gmail.com>
In-Reply-To: <CAPnjgZ2Ljm2aR0w9zgJZ2O49XU8oNYsDi-EJ-PD=Z5mx2sQHrg@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 19 Dec 2023 20:19:06 +0000
Message-ID: <CALeDE9OH4Yqir53rYzbDXLL_sRtCRy2cT7HHD3CmYLeh3C_fPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 sean.anderson@seco.com, neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
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

> > > > > > Not always.  I am not sure if x86 does that, but on the rest of the
> > > > > > architectures, they are only initialized when the efi smbios code
> > > > > > runs. Wasn't this something you were trying to change?
> > > > >
> > > > > One of those things I keep repeating is that we don't know for sure what
> > > > > the right values here are until we load the DT the OS _will_ use. It's
> > > > > quite valid to start U-Boot and pass it a generic "good enough" DT at
> > > > > run time until U-Boot can see (GPIOs, EEPROM, whatever) what it's on and
> > > > > what the real DT to load before passing to the OS is. Since U-Boot
> > > > > doesn't need SMBIOS tables itself, we should make these "late" not
> > > > > "early".
> > > >
> > > > Fair enough, we can defer the init and testing of those late, just
> > > > before we are about to boot. But this is irrelevant to what this patch
> > > > does, can we get the fallback mechanism in first, assuming everyone is
> > > > ok with the patch now?
> > > >
> > >
> > > I would like this behind a Kconfig. Making it the default means people
> > > are going to start relying on (in user space) and then discover later
> > > that it is wrong.
> >
> > What do you mean wrong, exactly?
>
> "raspberrypi" instead of "Raspberry Pi", for example, or "friendlyarm"
> instead of "FriendlyElec"

Well "raspberrypi" is better that what we get on the Raspberry Pi with
my testing at the moment which is "Unknown", which from what I can
tell from commit 330419727 should have at least the minimal amount but
it doesn't.

> I just wonder what this information is actually used for. If it is
> just for fun, that is fine, but I believe some tools do use dmidecode,
> at which point it needs to be accurate and should not change later,
> e.g. when someone decides to actually add the info.

So a lot of tools use the output of dmidecode, it's used extensively
through various support platforms and management tools.

In Fedora I would generally get around a dozen reports every few
months because anything booted with U-Boot was basically populated
with "Unknown".

At the moment, on the RPi4 with default upstream I get Unkown [1] with
these patches I get at least some useful information [2]. I've been
shipping this patch set, in various versions, for a while and have not
had a single bug report about wrong information.

When Ilias and I first spoke about these patches the intention was to
get initial useful information, them they could be possibly expanded
using things like information from eFuses (serial numbers etc).

In some cases with U-Boot you get SMBIOS tables that are incorrect and
crash the tools.

With this patch set you get at least the basics which is important
because support teams can easily work out the basics of what they're
working with even if they don't have physical access all without the
vendor of the HW having to work out what to do in firmware to make
something work.

This patch set moves the needle forward, if we wait for everything to
be properly formatted we will wait for ever, with information we
already have available ON EVERY DEVICE.

Peter

[1] https://pbrobinson.fedorapeople.org/dmi-decode-rpi-defaults.txt
[2] https://pbrobinson.fedorapeople.org/dmi-decode-rpi-auto-fallback-patchset.txt
