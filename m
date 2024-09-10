Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF153EDE9AB
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 18:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A8EA88CE7;
	Tue, 10 Sep 2024 20:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H36IPIn4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B35890C4; Tue, 10 Sep 2024 20:41:45 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 528F1890C5
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 20:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6c35334dfb1so40187356d6.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725993702; x=1726598502; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dWcV2yos/zPr6utuUjCu1cfmxrR5Z3O7mA8x2P4CE1Y=;
 b=H36IPIn4BQeMLTtuWsP4YetrOXN+dFB/jaNgnCd4BphNY3u9Tmb/hozTBPMlc4ABSM
 np1fefvfCAk4fs8eBjRWjQGAtP/nf6r+896wEntth0uDdcZTbARdjQqNARLRT6XzBlvV
 bKrz+u9fk7TGhLhGTR1aTnDyaTbpDCHumx9vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725993702; x=1726598502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dWcV2yos/zPr6utuUjCu1cfmxrR5Z3O7mA8x2P4CE1Y=;
 b=kb2q/DdUOlcr2m/3jA5RqJu2A9vLPF7N1Na3OBz9rL4jaEDhInt37ZGM8yNqDUEIoy
 X7+NuNuHGIWKUmzc/jFusEZvWEYuRc8TR2Kz/ZgYaea2dRnSn3cZUPzFKXee1w9roHe5
 HFbNSYoc3NBl0/w5r5a+l8kc+Ruwce6SN07otKUfLMAgwv6gVbYGDMxKHtU3EnOoCZke
 tyhgugowVVhx2WPSspjPTx7r0hbmh3OGioSt2NTmG3QURA79vUW3XgxkpOh1JjDFdaKJ
 r0zfQKMcqr1G2f5b5WHA5uUR8U7gJUqjyEkhacP5hU+GZ5FaA2HivG4SN9a75vdt5UER
 X1+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2XXBY0xlwCvko2RkoDbe7NQLqpEeO6NrjZsrNkSbPiz8kSi3bD7Ecoom5+0xZz3aeCuHDjkI=@lists.denx.de
X-Gm-Message-State: AOJu0YwE7liE8SrR7QuZ6VS2kVqasgeSIDKFTe6mgD+M2Hka910BVKBb
 cxUPFXpqZoxyoVXvOqqtjkRC4Pelq87rTxokQp41U91Yc54RPkffhMtUu05HsuVc+Af28wpRmsN
 KtXGCBcaGm544bMtxj2ygocATQzDYTyTPBa49
X-Google-Smtp-Source: AGHT+IHu9aXJpvz4rIaaYX9FQ3Sc9HDt3AgRt+WN+Hq4hbxDRSbxyBrT7xbAgn3LmWjiBNatd2QrzwONJDwgiFjeifQ=
X-Received: by 2002:a05:6214:c9:b0:6c5:3338:4e34 with SMTP id
 6a1803df08f44-6c533384f65mr136895736d6.32.1725993702165; Tue, 10 Sep 2024
 11:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <1a6084e845a0612546a1e86d142208af945c8f77.1724846454.git.jerome.forissier@linaro.org>
 <CAC_iWjL9g0c8UHF3L44b8HEG-2=d57XsDXPpSogthWDPgzPcaw@mail.gmail.com>
 <CAFLszTjLmgXO-31CwAOv1qQ9x0aDk4aHGVkScDF1bz-WhfrHGw@mail.gmail.com>
 <CAFLszTgQNatTrhY_PVwN96tbuRvS=PRqawhH93+1TM9y_Mg79Q@mail.gmail.com>
 <CAC_iWjLg5h5uPgK0rO04ajGL1z8bpxYAzv3j048hsXAwz22MzQ@mail.gmail.com>
 <CAFLszTjsTYi_jddj+05i77xjQ7gdvYC115C2hYYauAv7xTEhNg@mail.gmail.com>
 <20240902154155.GA2479150@bill-the-cat>
In-Reply-To: <20240902154155.GA2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Sep 2024 12:41:31 -0600
Message-ID: <CAFLszTi_PGoDzDPyqF69W3umEFXt6dGZRx-e3Tm5su-Ov6d6-w@mail.gmail.com>
Subject: Re: [PATCH 09/13] net: wget: allow EFI boot
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Peter Robinson <pbrobinson@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
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

Hi Tom,

On Mon, 2 Sept 2024 at 09:41, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Sep 01, 2024 at 02:09:40PM -0600, Simon Glass wrote:
> > Hi Ilias,
> >
> > On Fri, 30 Aug 2024 at 08:28, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon
> > >
> > > On Fri, 30 Aug 2024 at 17:18, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Jerome,
> > > >
> > > > On Thu, 29 Aug 2024 at 08:04, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > On Thu, 29 Aug 2024 at 01:34, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > On Wed, 28 Aug 2024 at 15:10, Jerome Forissier
> > > > > > <jerome.forissier@linaro.org> wrote:
> > > > > > >
> > > > > > > wget followed by bootefi currently fails as follows:
> > > > > > >
> > > > > > >  U-Boot> wget 200000 192.168.0.30:helloworld.efi
> > > > > > >  Waiting for Ethernet connection... done.
> > > > > > >  HTTP/1.0 200 OK
> > > > > > >  Packets received 13, Transfer Successful
> > > > > > >  Bytes transferred = 12720 (31b0 hex)
> > > > > > >  U-Boot> bootefi 200000
> > > > > > >  No UEFI binary known at 200000
> > > > > > >  U-Boot>
> > > > > > >
> > > > > > > Fix the problem by adding the missing efi_set_bootdev() call.
> > > > > > >
> > > > > > > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > > > > > ---
> > > > > > >  net/wget.c | 4 ++++
> > > > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > OMG the hack never dies. I hope I will someday create a series to tidy this up.
> > > >
> > > > I'm sorry for that remark, not helpful to collaboration.
> > >
> > > If you've figured out what needs to be done to remove it, I can deal with it.
> > > If not I'll put it on my backlog and have a look
> >
> > Mostly...my idea is to track loads within bootstd, adding a way for
> > bootmeths to record files they load, in struct bootflow. Then when
> > booting EFI, we just pass that info from distro_efi_boot() to
> > efi_binary_run().
>
> I worry about conflating "loaded something" with "need to boot thing
> thing". Maybe it's not a problem in the end, but there is not a 1:1
> between "loaded something" and "will boot this thing".

Yes, exactly. Bootstd tries to search for things and build a table of
what is there. Only when something is booted does it go ahead and set
it up to boot. In fact, some bootmeths delay kernel loading until
needed.

Regards,
Simon
