Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73E3CA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 17:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08DB580FA1;
	Tue, 19 Aug 2025 19:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U+UIxK3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27C4782E34; Tue, 19 Aug 2025 19:46:33 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42C3E802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 19:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-61a1663bd7dso4734492a12.1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755625591; x=1756230391; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ercXCvZ3WFWrzGbReI0uO2rXNEmsvcFdQGabUGCoVhQ=;
 b=U+UIxK3b4wT11sI5rcMZJ1M4DldNE6fJ+svYkVZ0s+inbTUM024Na44lvDZjxYFfe/
 SVoEH1/z6ilL+zUweiHjS1dEcrnUhjupqKeQGr+f2FNgl+xw2/TLmppQGOHttW84UnQ/
 F4K8heyPS8JpfrMARk1Ed2EhQYy9zkOilh6LjnwqXebdPRAqoOiYwCboz09g40zCgZUr
 9k+uh/pb7FZBpYjoXbXe6ar2Kt1k/qn4JPjO8PgpiKOwK2bNkE3sVbfGDzoLFkrOMk19
 SEO8TOFhkDI81Q5l9Zyu1wjUaaPldmU6yNerF6LZTy9ZGhA9mW6WbSMPeotGy/MHiD5I
 hoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755625591; x=1756230391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ercXCvZ3WFWrzGbReI0uO2rXNEmsvcFdQGabUGCoVhQ=;
 b=EhlkRyvSC1y9anhXwEzvwoQxA6KfHsWtSWMqEoSR/pRXq6pCULTiVY0pYlduRlmadn
 YjkeoPg/hhK5GShduD5wLKoGCFhYr8ry5QD/Ylp0aThBCXjANcLTZ8S2zPRRXyLfq3JK
 Kc50DJ+daIJATXnxk0bL9PquvJkHpvbGvlqQVhrSeyXzcWyVJHkQDeGcxBCXIHm19K6g
 me7ppbc9ox/KwqFhyjMs6xEg9suTQX1fE7UbfhMUZWEjX5ASAQkkrfI4wMFpiT4ijQ88
 lBFJGBV9OEoMxZ8dLpItVXY4cwvx3xSHyH0YBsWemiO+UrIJ0P178OQnQx4/HWHBiPcb
 A5yw==
X-Gm-Message-State: AOJu0Yy+nA7zeDpNASXwaEFejj4UAxF1BdNFYbzKe17bObHleaobLsIm
 s3r/RC2q68TJh+n933ElI8Uey1FRVjIlXo4o3agjw3Yii1SLg7OcI8YFWehOvouEvu3C6dpsLDR
 i5ZtEmkBmSVR1+QSWo6xsBElT/qSPnyoy8xqyyzc=
X-Gm-Gg: ASbGncvIw23xlV5e2rVuradiQI0Z0YQ0WoHXwX28Qne6/OGEQPq3Oe0yiUssdDpxOvL
 mqkEDDVu6813jsh41MhBl/T4dqE8aOuOn5OoD9AHsgxBWH+yTNujgnFqi5o6WbdswzI4N0tGk3k
 +0UaJ3rADAC1cLsGAw3oyD1HaZPvhXODDbEe4NfETztfESdp0CivNv8dYFSbgIOGPwaX6LgMvTx
 y3obUvNppbq32NG
X-Google-Smtp-Source: AGHT+IEj6TS9WLlNmPFwH6IMomWsyrcfkB5w1/V/a2ILd4Vm3N9WkhnU/3JXmu+VxbFduagGsRtFyjqicTsJWw2VQEQ=
X-Received: by 2002:a05:6402:2709:b0:618:66a9:72da with SMTP id
 4fb4d7f45d1cf-61a97584c9cmr170315a12.15.1755625590493; Tue, 19 Aug 2025
 10:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250818165119.3193853-1-trini@konsulko.com>
 <CALeDE9PqJBA9gS+YaNjM605fH011wL1SyT8Odk_k2Lm_V9EHLQ@mail.gmail.com>
 <20250819145737.GB124814@bill-the-cat>
 <CALeDE9PXjSh9kySvOEc-4KDVp7dT+DUUQVYh7JUk2pS+vohe7w@mail.gmail.com>
 <20250819153522.GE124814@bill-the-cat>
 <CALeDE9Nt9j7Hq-C1Etxh5EpdD-r09+XYeafL=U4O5cV1rvejHw@mail.gmail.com>
 <20250819174415.GG124814@bill-the-cat>
In-Reply-To: <20250819174415.GG124814@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 19 Aug 2025 18:46:19 +0100
X-Gm-Features: Ac12FXypUGz9Rw6i47oYwscZzEPMTGu8xUXYwfPTyM3lJADW7f_nT2syxKwgqHs
Message-ID: <CALeDE9MMah7DndMf8TrF9yXPHdk=LtefX5=uM6qV4ZSW6baiFw@mail.gmail.com>
Subject: Re: [PATCH] boot: Add LEGACY_IMAGE_FORMAT to DISTRO_DEFAULTS
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sascha Silbe <sascha-pgp@silbe.org>
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

On Tue, 19 Aug 2025 at 18:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Aug 19, 2025 at 06:38:46PM +0100, Peter Robinson wrote:
> > On Tue, 19 Aug 2025 at 16:35, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Aug 19, 2025 at 04:33:07PM +0100, Peter Robinson wrote:
> > > > On Tue, 19 Aug 2025 at 15:57, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Aug 19, 2025 at 12:13:31PM +0100, Peter Robinson wrote:
> > > > > > On Mon, 18 Aug 2025 at 17:51, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > At this time there are still major Linux distributions which by default
> > > > > > > boot using LEGACY_IMAGE_FORMAT type scripts. Add this option to
> > > > > > > DISTRO_DEFAULTS to ensure these platforms can still boot.
> > > > > >
> > > > > > What is the legacy image format exactly? Does select make it non
> > > > > > optional, can we use imply or similar here?
> > > > >
> > > > > In this case "legacy image format" is uImage-style images, rather than
> > > > > FIT images. And no, we can't imply it because then we'd break Debian
> > > > > (which doesn't boot on a handful of platforms now which do have
> > > > > DISTRO_DEFAULTS but don't have this).
> > > >
> > > > The distro boot stuff, which if my memory servers, is what the
> > > > DISTRO_DEFAULTS is used for, never used the uImage style kernels.
> > >
> > > The same uImage-style header is what's on top of a "boot.scr" type file.
> >
> > The distro default scripts never used that either, the whole point of
> > them was to move away from manually crafted scripts and custom formats
> > to boot a device.
>
> Maybe we're talking past each other now. If distro_bootcmd never would
> have found /boot/boot.scr, erm, OK. But the resulting U-Boot image could
> still be used by Debian (and I think others, perhaps armbian) that would
> still rather write their own logic and set the bootcmd, and relied on a
> set of standard features being enabled in any board.

The major concern I have here is not being able to turn it off for
boards that are constrained, which is typically the older/smaller
boards like BBone, Jetson Nano etc
