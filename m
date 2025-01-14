Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A099FC02180
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 00:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EACAA805C5;
	Tue, 14 Jan 2025 01:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C7TPsQc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 661C58060C; Tue, 14 Jan 2025 01:15:15 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EA2E80285
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 01:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab2b29dfc65so756305266b.1
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 16:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736813712; x=1737418512; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vRnveguGH5okgHXE0lltO7FkBHNaLmlINhbSQ96ZaE8=;
 b=C7TPsQc84CMwHNYPX2mZK8IXHUHHkNoGQ5z077uEYqUSd18JVwkbumMygqAcNSNe/p
 7keo/Q3iQ5U23TIXQDVY5oafQ4pm8r/DBx7ikFOKwJ2/jseEJomCntno/RSZ8KVlhpLT
 tBAjbgVvKs4GYQoFRWgN6El7j6fTG1C1rUnvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736813712; x=1737418512;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vRnveguGH5okgHXE0lltO7FkBHNaLmlINhbSQ96ZaE8=;
 b=cErx3C6lKKMhBDVLKtH2iGmylTp9KbQ9lR6+oOU5lCjJ+edligDHJSSSbCa10V+PDb
 iMSc9gycLQsxlYCA4sMXvtPiZiM9h3rO/3ZeUMjVviYIrzt24yTiC9RtsnraYvurN1TY
 XdRXg6T/bdey+KZl2PUB9yOIguQ2M4OvVjJ8x28WyJ89b+MgcAltjNqpqsWqNBbWAiTq
 jLRI9HRAnSycDPMHXh2JihT6OoEvvXVNZWsfgNbz94RIFLo0q+iXjqyRZg2x3TPxWRTi
 vKh+AcUOJIe6IOUbFgew4ItfkOT/kNFR6mMFY/dkFqzNJX9UUzsK48TKQczNC+KHOtgo
 CQGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsGTrH4SvntRZZT0mp/OI44akuGAWHWV1Kcvrc6oFJkj/FabSmaxwbO6nVvJ/EQMhXtOVgYmw=@lists.denx.de
X-Gm-Message-State: AOJu0YwxWjAbBRkkCiOYlphXa4T0O0ziC6UaH7RQd/Gz04kSKFd4/6yL
 9Kb9OKvAN2pR+DcvReT7IYJZnYBOKvhB38OEQUwgfIhGpR+Wu08Wp24oLGqgaEQFO6BSSpzW/eF
 dZuKTeUWqG9R3fGfDAdxOHvsnk+1bSWPn/Qx5
X-Gm-Gg: ASbGncunS9hvK9FbGz8VgTJhfxzoSyKCwnfw6B/KqqEIiXl4Mwca/aliySUsH24gMmE
 qsIfczlCv1FSttq1uQj8TMxi38lrcppioqMSldu4=
X-Google-Smtp-Source: AGHT+IGj0G4RBmh4ZnnH0wcmlQRJYOpAAh57wetsp+XJDe6qwlKPtPyQuho7nb3a7iOKeEtz1/zyBWH2ZSfNvAqZv88=
X-Received: by 2002:a17:907:3a96:b0:ab2:b5f1:568c with SMTP id
 a640c23a62f3a-ab2b5f15bf1mr1367896666b.28.1736813712545; Mon, 13 Jan 2025
 16:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
 <20241127070631.16412-6-heinrich.schuchardt@canonical.com>
 <20250110224554.GA2278614@bill-the-cat>
 <CAM=mAOmee=By9ErZrvk0hVbZyLH_viguu_wMfOsV3LzTwddArw@mail.gmail.com>
 <20250113015108.GT3476@bill-the-cat>
 <CAFLszTh7S=jmezZNwg=b+96+6ravY41iRbgJ_ssJ48nx4d=0QA@mail.gmail.com>
 <20250113192352.GZ3476@bill-the-cat>
 <CAFLszTht-DdniDnZDgMsf7F5oK3X19ahjcNsM6u1-sN-D_8kdQ@mail.gmail.com>
 <20250113203519.GD3476@bill-the-cat>
In-Reply-To: <20250113203519.GD3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jan 2025 17:15:08 -0700
X-Gm-Features: AbW1kvaAPTcpEXCCyEo1I7IYQhLyoR-u5ycyxzd81FYmIBC6OXGYwZ5sceGe1GI
Message-ID: <CAFLszTjWf546_gO9UEUzWkc1tFcf70dGw1Oxe=3UCvzgGsWgSA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] cmd: bootmenu: add parameter -e for UEFI boot
 options
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, 13 Jan 2025 at 13:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 13, 2025 at 01:09:16PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 13 Jan 2025 at 12:24, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Jan 13, 2025 at 12:01:45PM -0700, Simon Glass wrote:
> > > > Hi,
> > > >
> > > > On Sun, 12 Jan 2025 at 18:51, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Jan 12, 2025 at 08:08:13PM +0100, Heinrich Schuchardt wrote:
> > > > > > Tom Rini <trini@konsulko.com> schrieb am Fr., 10. Jan. 2025, 23:46:
> > > > > >
> > > > > > > On Wed, Nov 27, 2024 at 08:06:30AM +0100, Heinrich Schuchardt wrote:
> > > > > > >
> > > > > > > > The bootmenu command can display
> > > > > > > >
> > > > > > > > * menu entries defined by environment variables
> > > > > > > > * menu entries defined by UEFI boot options
> > > > > > > >
> > > > > > > > Not in all cases showing the UEFI boot options is desired.
> > > > > > > > Provide a new parameter '-e' to select the display of UEFI boot options.
> > > > > > > >
> > > > > > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > > > >
> > > > > > > Very strangely, this leads to the EFI selftest "Executing 'random number
> > > > > > > generator'" test failing on Pi 4, where was was passing previously (and
> > > > > > > Pi 4 has an RNG, unlike Pi 3), and this is
> > > > > >
> > > > > > Do you have a link to the log?
> > > > >
> > > > > Here's the failing part:
> > > > > Setting up 'random number generator'
> > > > > ESC[0;37;40mESC[1;32;40mSetting up 'random number generator' succeeded
> > > > > ESC[0;37;40mESC[1;34;40m
> > > > > Executing 'random number generator'
> > > > > ESC[0;37;40mESC[1;31;40mlib/efi_selftest/efi_selftest_rng.c(52):
> > > > > ERROR: ESC[0;37;40mESC[1;31;40mRandom number generator protocol not
> > > > > available
> > > > > ESC[0;37;40mESC[1;31;40mlib/efi_selftest/efi_selftest.c(114):
> > > > > ERROR: ESC[0;37;40mESC[1;31;40mExecuting 'random number generator'
> > > > > failed
> > > > > ESC[0;37;40mESC[1;34;40m
> > > >
> > > > This might help make the log more intelligible.
> > > >
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20240811145209.4191404-37-sjg@chromium.org/
> > >
> > > Shrug, it's the age old problem of sending raw stdout to a file. It
> > > looks fine on console as it happens, I was just grabbing from an
> > > existing log.
> >
> > Oh well. I would probably suggest only writing this junk to log files
> > if we actually need it in there (i.e. something is programmatically
> > checking), but it seems like this is a different situation from the
> > one my patch fixes.
>
> I mean, yes? The problem here is that the random number generator test
> now fails, when it didn't before. As far as I know (and I think the rest
> of us understood?) your problem was that the ANSI sequences exist.

Yes, I want them to be controlled, so we can have them when needed
(e.g. for user benefit, getting the terminal size) but not when not
needed (CI output, log files, testing that ANSI works, etc.)

Regards,
Simon
