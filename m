Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132BFCE8379
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 18:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51D5C89003;
	Mon, 30 Sep 2024 20:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ha9b6AN9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D650F87D1A; Mon, 30 Sep 2024 20:52:19 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CBA0884DB
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 20:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cb3d2ce75eso30418146d6.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727722335; x=1728327135; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5oJHcdGCdvtaZbnTHrZbgfoGPSvnPGY+/1aPUsrl4Mw=;
 b=Ha9b6AN92iGvuSmVIPnJL9UNYlyiIAYH3glA72Iadv0o7N7IU6AQeGwQNgqr8j4ow5
 r5OLVFESgcy/hDTb2/XCXT5pj8FfIIYa0bYy+M70uo4FXCQpwdomG5NGj+zgIfUpZLnK
 NKhQyX+r8mkOaA16rKNJW0aus3ouLHZODBaV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727722335; x=1728327135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5oJHcdGCdvtaZbnTHrZbgfoGPSvnPGY+/1aPUsrl4Mw=;
 b=svOLTlQgk4ub08H7mLErfkO8CZyueGL5jj2RPGaLM7tY2M9lDqwQt5fBlPCVWWcjC1
 F8+1mYr6Ws5s90PZdcmeQtbStJuk5gZ/c2RZ1IC60uL3G2Yhl4nAm1jXkM8aMJ53PrWX
 wHlA31TrUGDhmVd6/oP694cIrOiNCCCW3Cwnci8yyY7uQIO0pdGCOXtKUr1ok8wJbr9+
 8Kd1jG41WR67b+CNEoOdTgAaYg/LOnvopKPySrOZ7Mdzq/ImOic9V/4sdtWc9Z39HHKx
 kCBe6ibg5pDvO8ncQZl9ZTYU92iktYDJ/tL3uZqgQK+gGlqWHnm7WMXdv+oZjVZZA0U1
 RcRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsYTzUj26cweNIKzlXxElvVuSR7J6HCtESLffwQTT3jOuWjn4Q3J4C5wLG1AziA2NMjJ5+YVA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2zGvaWmaAr/ZMadXHxSoclgNHgxzUUv2ZkfrsgUzuIxWBWrbm
 D9laisFilnDTkRGHpnrnp4AJSUcnD1VAMvYAL7i5hjPESWa84yzWMuOiopE12lIqI/zi2JTwkBb
 PcUS1T1xymOyNeT5Ffzk1nx4VWhdI6fLPXPUV
X-Google-Smtp-Source: AGHT+IHYw1/K1EcU6QbxS3xD822xQPEMpMvJPn5bxOQv0tGmHPpuWGPmFaFOZfYMhNTrRoxAsvoTnJtsLKMH95wBFRM=
X-Received: by 2002:a05:6214:acb:b0:6cb:46b4:5771 with SMTP id
 6a1803df08f44-6cb729b5b45mr12896156d6.13.1727722335383; Mon, 30 Sep 2024
 11:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <a54b501a-9a98-426c-a5ca-faf547411a30@siemens.com>
 <CAFA6WYOAYQ26vAT8=Z74N6EJ3HcvqmiwshxGkMVe5oQyAfFrrw@mail.gmail.com>
In-Reply-To: <CAFA6WYOAYQ26vAT8=Z74N6EJ3HcvqmiwshxGkMVe5oQyAfFrrw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 30 Sep 2024 12:52:04 -0600
Message-ID: <CAFLszThvgOw-mnD9nMDgGoH1a7v4862Sf8pDNFGjuyVuQU9JMQ@mail.gmail.com>
Subject: Re: [PATCH] Extend usage for OF_OVERLAY_LIST beyond SPL
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Frank Wunderlich <frank-w@public-files.de>, Jonas Karlman <jonas@kwiboo.se>,
 Nishanth Menon <nm@ti.com>, 
 "Li, Hua Qian (DI FA CTR IPC CN PRC4)" <huaqian.li@siemens.com>
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

On Mon, 30 Sept 2024 at 06:05, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Mon, 30 Sept 2024 at 15:50, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > Allow to use OF_OVERLAY_LIST also for the case that the overlays just
> > need be built, e.g. when they will be picked up by binman as artifacts
> > of the final U-Boot image. The IOT2050 boards have such a need when
> > switching to OF_UPSTREAM.
> >
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >
> > While waiting for the merge of v6.12-rc1-dts and while seeing related
> > but different attempts to address the overlay topic. See the patch
> > in use here:
> >
> > https://github.com/siemens/u-boot/commits/jan/iot2050
> >
> >  dts/Kconfig          | 4 ++--
> >  scripts/Makefile.dts | 1 +
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>

Reviewed-by: Simon Glass <sjg@chromium.org>
