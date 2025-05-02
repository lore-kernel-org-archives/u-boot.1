Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FD2C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 13:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B62E820E2;
	Fri,  2 May 2025 15:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AX5Yas0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 596FD820EB; Fri,  2 May 2025 15:29:26 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D31BB810EB
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 15:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7081165a238so14937327b3.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746192562; x=1746797362; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3bYVaIrwRa4S2cu3A8UxtDrEiEjKrdKz+fi7kdKTi0=;
 b=AX5Yas0eRnJOFL7SO0QtpKzLaaGCZBxQTLzemopqnO+O4b7mj/hiWENLZbMX2gljBt
 Mh6gt7NgmcZoxEaYlafNfiFs1lLBZ50AUZ71hH5NQ8QoWAv6UNVpu6vtk7Dul/wC+Qqe
 Js9ED5Duy4rH0rFLdPRwdHDKebQbCG0W0L6HN3ZBKbaS7eVwyreDYch9XeLYw9NYiixI
 isC3m0ZR5d0WhOq8kLNq/OGbp86hrdiN8+nUDDhnPH05uoEkm3mvHpC7DYsL+fAJaxOq
 ThXJiBXg4SflljqKk/2u7lkLfwxNXp7OciZKKpR808HScmwBUBU7lwgRhIqGJwZaPJDn
 Kdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746192562; x=1746797362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q3bYVaIrwRa4S2cu3A8UxtDrEiEjKrdKz+fi7kdKTi0=;
 b=dMfUbNfHvdvsA+/1utuDoMN7hdjVr8NN2ESqZXfk452UCLgs8nHcf43O9tBpwlthxk
 7ttdo0DjlNg/0Ci/ZsMcMgUg04Yp3kZ5Q4VJlNebupKF50cCBHdkyzxVc4tVmRrzDTY6
 86wra3sU4iPK/2D4fErTXpaoX+wvh96fSJ+WyQmzPjmQcJCm3zO2I/zm9xfzbXI3GTab
 zVvCSmY2NpbRhdphRUdP32YWdzrjEKaUkszUwDv/SQFQPbBWWK3aRHPFeRgRV/PZnOwk
 Iye/+akdGlEkBKgN03EKJiLiMYWC38lOOcIjEJaWadVMmlhA15J42Mzj9V9V7X4ozqcZ
 o7yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlOblGVCBTOrXtSyzkFnTrCb3AhNO/qb4f/JXjNVn2FtwmadXKtQYuYD3Tnp2mVZbb8HbaXno=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0bcxnwSS3rSZ2D24m1TIqmhDNu0sPp6+bO3ffJXIIJqPRLxI/
 WRohCQPs/1c2wnsKl7CGrwfBzKm5s8ZSwi+M1UYRs8WXrkRmOnFEHYoJwfG0uqjOAUMe/qRM9LL
 YESrB/6BobozDHO/PFVGmRNe9n+7LcXoswgWQZQ==
X-Gm-Gg: ASbGncvRkSFs8i15woqlCDI45pgIZjiGCODiLoXce+4xjeG4hLhtV1B5P48jCktD6bD
 OkzD7PyXtVa4a2x5fiEGBQa8g3L2jv64Xm2uzo//hWrHOM73R9H9YSRwcul9Rj6eUp0Zc0WsXuC
 RIdmxCM1mxNzODiwXmHxI8Mjg=
X-Google-Smtp-Source: AGHT+IGa+TsD8YV9ssW64Pp/7IP5GGd6xv+er9RoRu5P2VOIBFObhWUdXuiolB5PnAGdvJnjiCFpwPQALIsWgTbucO4=
X-Received: by 2002:a05:690c:4989:b0:700:a988:59dc with SMTP id
 00721157ae682-708cee12fd7mr45592207b3.31.1746192562633; Fri, 02 May 2025
 06:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-3-heinrich.schuchardt@canonical.com>
 <CAFLszTgn3kXFrbsfbQCpJ0pHmgAvF2Df_V7_tTZ732k3Q4UVew@mail.gmail.com>
 <2c28be83-aab4-455a-9ced-602b7c6b1354@canonical.com>
 <D9LKH17KOI3W.1X2BUOB3TJWX1@linaro.org>
 <CAFLszTi32wXAnzeL3uP2kS18vx38rbPgnpcySyrn2+Sf-AM7JA@mail.gmail.com>
In-Reply-To: <CAFLszTi32wXAnzeL3uP2kS18vx38rbPgnpcySyrn2+Sf-AM7JA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 2 May 2025 16:28:46 +0300
X-Gm-Features: ATxdqUFCn_RkOUhUpR3MLNc6dIcrqLtlOh0yHKzRnSZxm8IBWr8yo744wh1AWbA
Message-ID: <CAC_iWjLLvW4Wd-0-zXeHs4_ucUjKDAUxKYDAe5-nj6QoRCxS9A@mail.gmail.com>
Subject: Re: [RFC 2/8] boot: BOOTMETH_DISTRO should select BOOTMETH_EFI_BOOTMGR
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

On Fri, 2 May 2025 at 16:23, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Fri, 2 May 2025 at 03:28, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Heinrich
> >
> > On Wed Apr 23, 2025 at 3:53 PM EEST, Heinrich Schuchardt wrote:
> > > On 23.04.25 14:28, Simon Glass wrote:
> > >> Hi Heinrich,
> > >>
> > >> On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> > >> <heinrich.schuchardt@canonical.com> wrote:
> > >>>
> > >>> Distros expect the EFI boot manager to run. It falls back to launching
> > >>> EFI\BOOT\BOOT<ARCH>.EFI from the ESP.
> > >>>
> > >>> BOOTMETH_EFILOADER is obsolete.
> > >>>
> > >>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > >>> ---
> > >>>   boot/Kconfig | 5 ++++-
> > >>>   1 file changed, 4 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/boot/Kconfig b/boot/Kconfig
> > >>> index fb37d912bc9..71ddb37f6bb 100644
> > >>> --- a/boot/Kconfig
> > >>> +++ b/boot/Kconfig
> > >>> @@ -597,6 +597,9 @@ config BOOTMETH_EFILOADER
> > >>>          imply CMD_TFTPBOOT if CMD_NET
> > >>>          default y
> > >>>          help
> > >>> +         This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
> > >>> +         launching EFI\BOOT\BOOT<ARCH>.EFI if not boot option matches.
> > >>> +
> > >>
> > >> I don't agree with marking this as obsolete and your commit message
> > >> doesn't explain why it should be.
> > >
> > > This method was written in a way that per se violates the UEFI
> > > specification as it does not set up required UEFI variables.
> > >
> > > You must never run this before the boot manager as booting
> > > EFI/BOOT/BOOT<ARCH>.EFI if there is a boot option violates the UEFI
> > > specification-
> > >
> > > The boot manager covers the functionality of this bootmeth.
> > >
> > > We should delete this method.
> >
> > +1. Do you plan to propose a patch to remove it and only leave the bootmanager?
> > Or you prefer marking it as obsolete for a while?
>
> No, neither.
>
> The work-around that Heinrich and I discussed was to insert bootmgr
> later in the bootdev sequence, not to disable this bootmeth.

Can you explain why you want to keep this bootmethod? Both Heinrich
and I explained why the bootmanager is the appropriate one for EFI.
Do you have any use cases in mind that isn't covered by the manager
and you need this?

Thanks
/Ilias
>
> Regards,
> Simon
