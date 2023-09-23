Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F2ACE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 413F886C22;
	Sat, 23 Sep 2023 21:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JqAiArF4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD45E86BE7; Sat, 23 Sep 2023 21:47:47 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A94E386C15
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c00df105f8so66101801fa.2
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498465; x=1696103265; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NfYO+I7yWnwD45XSbYdGkIo77g7dy6czCucEUFYM6XE=;
 b=JqAiArF4nl7zrkfivHS85N2EuXwX0Fh+2OVZX9Ru5jaoKq5OnuEzfatf5jys3JiyGi
 oVX8gZLRigXwHIzeVf1Lt/QN+zuCjjvh5lVyhRa/rmQkWhxW/spOAfTA9eRLNApAagCw
 sYOBlIMOkgnjAQEYGdLlqd98XMaMyFu9hK+KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498465; x=1696103265;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NfYO+I7yWnwD45XSbYdGkIo77g7dy6czCucEUFYM6XE=;
 b=Q95rpbIzlYL/WaecFQrKy341R3bMYDJxYDnEhdqpaPLfRv5k75qbZzs1nDu7Xp5TJ3
 +RVD+qD/Svs2vo4w4AzFt3nCsPSDz6Jst6jRDFZMs34BN8/WYNPzH4aJNaym4RPL3n3O
 mFDUbSBkk6C/K9igDLBiiP/M5tVzUZ2Ft39cWv9Tn7T/QURuLTvsg/7xKbjv07p3AT82
 vQG6VpFKeAgi6IqodUOkYO8byB1VdPsbVc0coCFceerbUv7xsUdndHWKuHsx9lFKcOT4
 +MYGJ244dH8x4V+Pa7KLGZ35BqFkDcQZK5MTSQPUSSd474+LBeaMDSCIHa8JVobAGjGu
 VkOA==
X-Gm-Message-State: AOJu0Yw/C11dWUgdmxByRevcxaFOzBgT0/co5z5Z+NqXT8W8y2C/FBQ9
 8WtTTTtuFi5wxNdC8ndIL7QGkA9JD+wsVvzsbP5T/g==
X-Google-Smtp-Source: AGHT+IGOOi1VYHlN0XlqKoiFjQJhVAQMxdbiQOPIcTIDxMaWzdmWWct8FUKbOyjgEJsRVzk0Z4RDXZ882uxfMnYlJQQ=
X-Received: by 2002:a19:6756:0:b0:500:b88c:ea79 with SMTP id
 e22-20020a196756000000b00500b88cea79mr2188733lfj.54.1695498464754; Sat, 23
 Sep 2023 12:47:44 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 23 Sep 2023 12:47:44 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0MLtct1gspOHyMHeYkNDU3drr+-4Ohrp4j74W=f6oggQ@mail.gmail.com>
References: <CAPnjgZ0MLtct1gspOHyMHeYkNDU3drr+-4Ohrp4j74W=f6oggQ@mail.gmail.com>
 <20230823014947.20876-1-takahiro.akashi@linaro.org>
 <CAPnjgZ3XKONQXhcjU0sU=3GNx8D4VjVUhSQ5de0dsVFt1bb54w@mail.gmail.com>
 <ZPAYZnzF+KeIwMMr@octopus>
Date: Sat, 23 Sep 2023 12:47:44 -0700
X-Google-Sender-Auth: qDh0UQjao72Pa6KsQbtub0LSHAk
Message-ID: <CAPnjgZ3JR7ovE3jPV-NDmqGKwYXXrq9_PpFN1gvZQUsv7HgODw@mail.gmail.com>
Subject: Re: [PATCH v2] cmd: dm: allow for selecting uclass and device
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>
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

On Wed, 30 Aug 2023 at 22:34, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> On Wed, Aug 30, 2023 at 09:48:48PM -0600, Simon Glass wrote:
> > Hi AKASHI,
> >
> > On Tue, 22 Aug 2023 at 19:50, AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> > >
> > > The output from "dm tree" or "dm uclass" is a bit annoying
> > > if the number of devices available on the system is huge.
> > > (This is especially true on sandbox when I debug some DM code.)
> > >
> > > With this patch, we can specify the uclass name or the device
> > > name that we are interested in in order to limit the output.
> > >
> > > For instance,
> > >
> > > => dm uclass usb
> > > uclass 121: usb
> > > 0     usb@1 @ 0bcff8b0, seq 1
> > >
> > > uclass 124: usb
> > >
> > > => dm tree usb:usb@1
> > >  Class     Index  Probed  Driver                Name
> > > -----------------------------------------------------------
> > >  usb           0  [   ]   usb_sandbox           usb@1
> > >  usb_hub       0  [   ]   usb_hub               `-- hub
> > >  usb_emul      0  [   ]   usb_sandbox_hub           `-- hub-emul
> > >  usb_emul      1  [   ]   usb_sandbox_flash             |-- flash-stick@0
> > >  usb_emul      2  [   ]   usb_sandbox_flash             |-- flash-stick@1
> > >  usb_emul      3  [   ]   usb_sandbox_flash             |-- flash-stick@2
> > >  usb_emul      4  [   ]   usb_sandbox_keyb              `-- keyb@3
> > >
> > > If you want forward-matching against a uclass or udevice name,
> > > you can specify "-e" option.
> >
> > I don't really know what 'forward matching' means.
>
> Really? I believed that forward-matching was a common word.
> I meant that it searches for any string starting with
> a specific sub-string. In other words, it would be
> "^<sub-string>" in a regular expression.
> So, for example, "usb" should match with "usbABC", "usb-DEF",
> "usb_GHI" and so on, but not match with "ABCusb".
>
> > Please use forward instead of forword in the code

Well let's just go with what you have. We can always tweak it when
people start using it, if needed.

> >
> > >
> > > => dm uclass -e usb
> > > uclass 15: usb_emul
> > > 0     hub-emul @ 0bcffb00, seq 0
> > > 1     flash-stick@0 @ 0bcffc30, seq 1
> > > 2     flash-stick@1 @ 0bcffdc0, seq 2
> > > 3     flash-stick@2 @ 0bcfff50, seq 3
> > > 4     keyb@3 @ 0bd000e0, seq 4
> > >
> > > uclass 64: usb_mass_storage
> > >
> > > uclass 121: usb
> > > 0     usb@1 @ 0bcff8b0, seq 1
> > >
> > > uclass 122: usb_dev_generic
> > >
> > > uclass 123: usb_hub
> > > 0     hub @ 0bcff9b0, seq 0
> > >
> > > uclass 124: usb
> > >
> > > => dm tree -e usb
> > >  Class     Index  Probed  Driver                Name
> > > -----------------------------------------------------------
> > >  usb           0  [   ]   usb_sandbox           usb@1
> > >  usb_hub       0  [   ]   usb_hub               `-- hub
> > >  usb_emul      0  [   ]   usb_sandbox_hub           `-- hub-emul
> > >  usb_emul      1  [   ]   usb_sandbox_flash             |-- flash-stick@0
> > >  usb_emul      2  [   ]   usb_sandbox_flash             |-- flash-stick@1
> > >  usb_emul      3  [   ]   usb_sandbox_flash             |-- flash-stick@2
> > >  usb_emul      4  [   ]   usb_sandbox_keyb              `-- keyb@3
> > >
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > ---
> > > v2
> > > - allow for forward-matching against the name
> > > - update command doc
> > > ---
> > >  cmd/dm.c             |  48 ++++++++++++++----
> > >  doc/usage/cmd/dm.rst |  30 ++++++++++-
> > >  drivers/core/dump.c  | 116 ++++++++++++++++++++++++++++++++-----------
> > >  include/dm/util.h    |  15 ++++--
> > >  4 files changed, 165 insertions(+), 44 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Thanks for doing this. It will be a big time-saver. I also wonder if
> > it would be better if the default were to do a substring search and
>
> Initially, I implemented so, but felt it is annoying to see
> (sometimes many) unexpected matched devices, especially
> when you know the exact name of device.
> See my example "dm uclass -e usb".
>
> > you have to add a flag to search for a single device?
>
> Does 'single' mean the first matched word or exactly-same one?
>
> Either way, I don't have a strong opinion here, though.
>
> Thanks,
> -Takahiro Akashi
>
> >
> > See below
> >
> > >
Applied to u-boot-dm/next, thanks!
