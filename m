Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA7DCA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 17:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B056802C1;
	Tue, 19 Aug 2025 19:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gvj0GY0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91E4780FA1; Tue, 19 Aug 2025 19:39:00 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFF8C80107
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 19:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-618adc251f0so7315169a12.3
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755625138; x=1756229938; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IxVbnzWas2fdmhYx/mEbpynaulucbt5xWQ2+WIRPFBA=;
 b=gvj0GY0TM0lstknOUYbpz5Am5UnAFNv5mkIjkFt2j8XMEpjKaqLhvzVEkWpj91XEYw
 7U/bRQFNtpXPhV7DsOT3lFHB0r1ZO7Mn3n2amwNnghHfVNM06B94I1T0Pprg/ZGIDqDr
 VaMwZ8SDlrgEWUTL1gtgw10ns1d0JAUpg3Z48PkNN4T+Wdl056VUxQZ/yszTxU1Y7zlw
 RcmUMxInJcaePk62J98neSbmOqyPoaxFB7IancRFqjm5r6zblRSFTgxUHEzDiUeWf03v
 /nHQmOuT5OaqlYmtQ6mQq9L3G3fOsI8tgmLkqpekkZFFH91id+hW2OKTvPEQ4uKUgUze
 Q2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755625138; x=1756229938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IxVbnzWas2fdmhYx/mEbpynaulucbt5xWQ2+WIRPFBA=;
 b=OFCGlqlQCd650SE9bC7aWJPbXJJFztLhay6GvVfAEWu4ezTWntafyFbLy1jeG2AhFE
 ubdYDCiyQYgnEIjc0f9Jf5S02Srq8YefE0UohIdL43zZwBLb3z4qFOYVj02D1ONqCAW7
 RxJWPQMirNNarep0SMwszl44Bz5gRHJ64KMJXJnlfAPlU7iXJJCN8xw71m6BRRRjiV98
 8sMjo3/L7T2Py28YuaR6fCCdMQeNLsPiu3ggkpfAdDhiLayvJxXYgTvDl1vfTsdjGRUn
 wAWUNE3jJkVsF6by6rx4/KCjJgzGrl08wYYM1V6AcOWeaMw3BRLc5aqdCrD1PNIxLLEH
 eRAw==
X-Gm-Message-State: AOJu0Yzat1riXjbp/YDEyoVun7ZwrT2aKDJjmEdwGPYB1J1vZQpPk8ou
 Fl5dmeeQ6tOI4c+Gm8P9TCAJoKBVRyYjRDbpYa3UXVBpXhtxHFdCg4Pc9d76zRbutOyX0LC8wxt
 QbG8gOHa2LMXJJZYN/p2ubZEsaQeQOvGpE0NxGJU=
X-Gm-Gg: ASbGncuBrOoFIY38CPNCkHVMzhRfmXYW/eePMbWKIvrtXMZjCZTGfhsbmHRogemHotk
 +1WMJ9k0+1oZ9OXrkutZI8IokbVd6THe2o3bNuWnCAcvsgV2Zlh0unVSanNVTTyXyQ4J/CkoO+J
 jA1KmSeyeYYkz/ahCgnQW54Igiz5p8vSnaL160Mij5wDhNyG343qZgfWzbMKo8b8Yp/AIyW9uOw
 PAVKw==
X-Google-Smtp-Source: AGHT+IGY+ZWJJNWniRjlaCwRpah+BwQmGeiVgqmVv9SggJq8cYwKvGUmeoTynHjZyu/yfcL8/1GUNd1bs5EAB7f6xWs=
X-Received: by 2002:a05:6402:2086:b0:61a:87c8:1b2b with SMTP id
 4fb4d7f45d1cf-61a9752bademr132122a12.3.1755625137868; Tue, 19 Aug 2025
 10:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250818165119.3193853-1-trini@konsulko.com>
 <CALeDE9PqJBA9gS+YaNjM605fH011wL1SyT8Odk_k2Lm_V9EHLQ@mail.gmail.com>
 <20250819145737.GB124814@bill-the-cat>
 <CALeDE9PXjSh9kySvOEc-4KDVp7dT+DUUQVYh7JUk2pS+vohe7w@mail.gmail.com>
 <20250819153522.GE124814@bill-the-cat>
In-Reply-To: <20250819153522.GE124814@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 19 Aug 2025 18:38:46 +0100
X-Gm-Features: Ac12FXxjhdanHZC6aSzF3B7tyhSc0AyYw6JM87O_3lTVFP_hBpjhYLxd7yPcvvk
Message-ID: <CALeDE9Nt9j7Hq-C1Etxh5EpdD-r09+XYeafL=U4O5cV1rvejHw@mail.gmail.com>
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

On Tue, 19 Aug 2025 at 16:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Aug 19, 2025 at 04:33:07PM +0100, Peter Robinson wrote:
> > On Tue, 19 Aug 2025 at 15:57, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Aug 19, 2025 at 12:13:31PM +0100, Peter Robinson wrote:
> > > > On Mon, 18 Aug 2025 at 17:51, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > At this time there are still major Linux distributions which by default
> > > > > boot using LEGACY_IMAGE_FORMAT type scripts. Add this option to
> > > > > DISTRO_DEFAULTS to ensure these platforms can still boot.
> > > >
> > > > What is the legacy image format exactly? Does select make it non
> > > > optional, can we use imply or similar here?
> > >
> > > In this case "legacy image format" is uImage-style images, rather than
> > > FIT images. And no, we can't imply it because then we'd break Debian
> > > (which doesn't boot on a handful of platforms now which do have
> > > DISTRO_DEFAULTS but don't have this).
> >
> > The distro boot stuff, which if my memory servers, is what the
> > DISTRO_DEFAULTS is used for, never used the uImage style kernels.
>
> The same uImage-style header is what's on top of a "boot.scr" type file.

The distro default scripts never used that either, the whole point of
them was to move away from manually crafted scripts and custom formats
to boot a device.
