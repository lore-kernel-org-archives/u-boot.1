Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF31C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 933588895E;
	Sun,  1 Sep 2024 22:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VgezRfyh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFBBF88A5B; Sun,  1 Sep 2024 22:09:55 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D80488916
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-70f6732a16dso2094272a34.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221391; x=1725826191; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JfDUFLSVSW3wt0U8AkqAqYXRox+dRXIV6RcJchF8Iyo=;
 b=VgezRfyhzTz1k+sKo7UPcaRcdRUjFfsTrm8xbBK9NOTdqrQjKdK6XXPeVyqE4hnnwn
 C3tVfF03P2gOoQh1B3hGlVmoZQ4soEcNtcODocXTSB8IhgiCDTry/EqXoSTs1VA8Xk51
 cewmNmwn13fV+bUkODDJFgGkVTULEOhh6JYb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221391; x=1725826191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JfDUFLSVSW3wt0U8AkqAqYXRox+dRXIV6RcJchF8Iyo=;
 b=iAYauF1mxDRS3FgbCTbBqdgdiXBNLFbBxoXGcUUXWmfra3ijwquWEPNI4H6q0ZoKXm
 XsA5of+RKIr8ab3ZV4b0xs87BKyMsZZebHEPiyZfnG6pjvlI3zRSTTLi1bemIPkfG2D7
 tpppRuaHMDv3PkG6HYwnDstHfmnPwiiPcg7O0+gGcPeFJgBLtVKSXmnq5g/+HVhdkoV9
 7zJP9HDsiyrOyZunOlUGOI+XefFanUNYNs39Bn9WZqG9U7NkJ5d797uTHlhInVndSpfo
 Xz2sleIziKOCLULLZxfEVwbbOtx/+NxQ8a7UcVAmMDOpHzsAqrorwkjanslWYM0QJwCT
 F3UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuPXZaGervJfXmY1avOECRNb4xexzM+9tqYeQhLA4igcDHBpgMAgtNUiSHeXu8HyZGmW5MnBg=@lists.denx.de
X-Gm-Message-State: AOJu0YwawpSts3FRaAoQDYv8HDI8YX0JWZmLDGyKUTtSCjK5+KdF0xB1
 o06fosAvUT9rUgMvs30KibZK5/OjU/hpFhYDDhhXAGJxgdSlUp95sh55rO7f42cC9l3GJf7iQBM
 TBuW88R/LgvexQPPkdvz3fbFMLMIJBQOxtX3b
X-Google-Smtp-Source: AGHT+IGlWTRyU0rVO0GFfEaWoeKo3GqzFuaqO2mNHiHxP2civspbTrqMgeXDCv8b5XxXxiQfN3qy5Gbub/XKdg6gGbY=
X-Received: by 2002:a05:6830:2705:b0:70c:9c66:af53 with SMTP id
 46e09a7af769-70f5c3e53c0mr13387138a34.25.1725221391172; Sun, 01 Sep 2024
 13:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <1a6084e845a0612546a1e86d142208af945c8f77.1724846454.git.jerome.forissier@linaro.org>
 <CAC_iWjL9g0c8UHF3L44b8HEG-2=d57XsDXPpSogthWDPgzPcaw@mail.gmail.com>
 <CAFLszTjLmgXO-31CwAOv1qQ9x0aDk4aHGVkScDF1bz-WhfrHGw@mail.gmail.com>
 <CAFLszTgQNatTrhY_PVwN96tbuRvS=PRqawhH93+1TM9y_Mg79Q@mail.gmail.com>
 <CAC_iWjLg5h5uPgK0rO04ajGL1z8bpxYAzv3j048hsXAwz22MzQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLg5h5uPgK0rO04ajGL1z8bpxYAzv3j048hsXAwz22MzQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:09:40 -0600
Message-ID: <CAFLszTjsTYi_jddj+05i77xjQ7gdvYC115C2hYYauAv7xTEhNg@mail.gmail.com>
Subject: Re: [PATCH 09/13] net: wget: allow EFI boot
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Peter Robinson <pbrobinson@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

Hi Ilias,

On Fri, 30 Aug 2024 at 08:28, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon
>
> On Fri, 30 Aug 2024 at 17:18, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Jerome,
> >
> > On Thu, 29 Aug 2024 at 08:04, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > On Thu, 29 Aug 2024 at 01:34, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Wed, 28 Aug 2024 at 15:10, Jerome Forissier
> > > > <jerome.forissier@linaro.org> wrote:
> > > > >
> > > > > wget followed by bootefi currently fails as follows:
> > > > >
> > > > >  U-Boot> wget 200000 192.168.0.30:helloworld.efi
> > > > >  Waiting for Ethernet connection... done.
> > > > >  HTTP/1.0 200 OK
> > > > >  Packets received 13, Transfer Successful
> > > > >  Bytes transferred = 12720 (31b0 hex)
> > > > >  U-Boot> bootefi 200000
> > > > >  No UEFI binary known at 200000
> > > > >  U-Boot>
> > > > >
> > > > > Fix the problem by adding the missing efi_set_bootdev() call.
> > > > >
> > > > > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > > > ---
> > > > >  net/wget.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > >
> > > OMG the hack never dies. I hope I will someday create a series to tidy this up.
> >
> > I'm sorry for that remark, not helpful to collaboration.
>
> If you've figured out what needs to be done to remove it, I can deal with it.
> If not I'll put it on my backlog and have a look

Mostly...my idea is to track loads within bootstd, adding a way for
bootmeths to record files they load, in struct bootflow. Then when
booting EFI, we just pass that info from distro_efi_boot() to
efi_binary_run().

Regards,
Simon
