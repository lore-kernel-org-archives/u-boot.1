Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D05C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 14:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A81F88B6E;
	Fri, 16 Aug 2024 16:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SXE96VRS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BF56889F8; Fri, 16 Aug 2024 16:47:36 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF8D488B23
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 16:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-710ece280b6so1697413b3a.2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723819648; x=1724424448; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ogmkjgr0v4nJwyWilU00djDQn495qm1zNwvdNiBXklQ=;
 b=SXE96VRSk3ZIqj3zIAMMBg5OZeyEUCAs5ghVyyrIt6LcPkbjCoqxAeAMg0Uc+MZWSG
 wH6J7e1+T0Tz00M37lzLC/Q9claZ0q4yCEk4/XwiUys6ptP7b74reqUrJn4FCcDc/gQB
 qMQyMU6+XUTJ+ya17ww+fFd0yLNR13Xhoj5KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723819648; x=1724424448;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ogmkjgr0v4nJwyWilU00djDQn495qm1zNwvdNiBXklQ=;
 b=FYE8MWYR1Ge5mXorsNNaiJSnMgXjRseyy/vnLuvtRZ5+vZUt35c8DBp7Pc5A2xpb7m
 vPvxlelaw3RHWFgvs1bzaPU5jeSIYwSxuSI3esxjZCF/aB2MzQAOCoQw4ISqMJ5rUnpt
 JmHtrEreXvwmSNUJjyEkTMURrDo0HCkMFOnwYfCDHn+vsUS//aDZwc9ws/GD57+/fzeL
 uSSP4e6oowI7F51RqTLvAlHvfPjCxF5lgl2SvWZW1S/ZSKxHXs7tcImL7O8fmaF3TUEI
 mMlSGFqrUhNydHPGcYwb8F3VYq8JXqpyHF9IwjyoUGUhI5j0/9UHI0/MLVg/0hyYEeTS
 Lz2Q==
X-Gm-Message-State: AOJu0Yx9YKHKPjTz1KxAZch/6jXPMtn36ap+yZCUani5OXccOglYpP7d
 qQpgpJ++sIg3yAiJd8M04X5VzAcMEpqrQPxLZ1vE15cbhYhaXUcLeDKExxm/fP4cEW3N/gztNXG
 4hW99FBafe86UWlgyaZmZWmYJ117Wsqb35fB8
X-Google-Smtp-Source: AGHT+IGAZW8hQLy/2PYXM8439X2FazGEpGgOUEhA2eHUqrU0LkYnWfe4Tkq/CsevVp0ng53sLsEgqdxtzr/jiJIy+zo=
X-Received: by 2002:a05:6a20:9f03:b0:1c8:9749:a4c1 with SMTP id
 adf61e73a8af0-1c905052afamr3748619637.49.1723819648322; Fri, 16 Aug 2024
 07:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-28-sughosh.ganu@linaro.org>
 <CAFLszTh-5c4_OdZs8F_e=giR+ZFjNB1oX8L8cV8hXi9Je6e+5w@mail.gmail.com>
 <CADg8p954ZtuXpC_b_rfkpWuXBGFV40Kp=DJby_oRsTp2GYbcHw@mail.gmail.com>
In-Reply-To: <CADg8p954ZtuXpC_b_rfkpWuXBGFV40Kp=DJby_oRsTp2GYbcHw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Aug 2024 08:47:16 -0600
Message-ID: <CAFLszTgsbrBefPQ7EGdLbC8fUO=oZUoQ13TYeo=pJzu2Uro_kQ@mail.gmail.com>
Subject: Re: [PATCH v2 27/32] test: cedit: use allocated address for reading
 file
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Fri, 16 Aug 2024 at 04:34, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 16 Aug 2024 at 02:02, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Wed, 14 Aug 2024 at 05:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Instead of a randomly selected address, use an LMB allocated one for
> > > reading the file into memory. With the LMB map now being persistent
> > > and global, the address used for reading the file might be already
> > > allocated as non-overwritable, resulting in a failure. Get a valid
> > > address from LMB and then read the file to that address.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since V1:
> > > * Don't use the API version with flags parameter.
> > >
> > >  test/boot/cedit.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> >
> > No, this address needs to work fine without using lmb. Same with any
> > other tests. Tests make use of the sandbox memory space memory
> > addresses and it makes things easier to code and debug.
>
> Like I had explained earlier [1], not using the LMB API for allocating
> the address results in issues, since the load command internally
> checks if the address can be used for reading the dtb. Without this
> patch, the cmd_ut test fails. I am not sure why you do not like this
> solution. But in any case, can you propose some other solution? I
> believe I can tweak the address to some other value, but that would
> not be a proper solution, but simply kicking the can down the road.
> Thanks.

But this is why I suggested having lmb_push() and lmb_pop(), so you
should be able to use those in the few tests which have this problem.

If it becomes more widespread and affects a lot of tests, we could do
thing automatically in the test framework, but for now, that doesn't
seem necessary.

>
> -sughosh
>
> [1] - https://lists.denx.de/pipermail/u-boot/2024-July/560569.html

Regards,
Simon
