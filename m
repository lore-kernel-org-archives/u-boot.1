Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1689EE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 17:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75DDD803E4;
	Fri, 20 Dec 2024 18:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Edn+iR//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF04880381; Fri, 20 Dec 2024 18:37:13 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CBBE803CB
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 18:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so304160766b.3
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 09:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734716231; x=1735321031; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f+Onx1lQsPqnePPkZwOaJpy7LKNHRLjl5AUIWpcgJZc=;
 b=Edn+iR//CTmrDbQu/MLY4RjsJ3pmkAurqHvy4OSxP6ocD/XdoLth8F/PMQPzAdDF+b
 WmDQKA+fPevKdoq6j1rdxliwrQdiMFQcp03u5/JamiuMEyf0oB63QCz51dnx2u4+333c
 0rmUmKH2UBbRRqiXTP1YJnhIze0+nrM0n7Bg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734716231; x=1735321031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f+Onx1lQsPqnePPkZwOaJpy7LKNHRLjl5AUIWpcgJZc=;
 b=Liunei5lz7mttJpCXiIKHDw+BhHJK8chD7GZiQuxdWN1D3kh65s6d4TBVJwPZyuTzs
 km6yVvsrDhwAZFIY7js3pdT7fpCNr42kFb1rDqxbjKllrATZq3u9r2RuSmgfQzjX3UjY
 +hdQg/88gW6/fajcsKyvZQmjDYfFmezp/jcDA84N8n0OCcQgqb6i/NcYRArJbalLfJbN
 lPQyrBDTM6zL9jQ9NfPbsK5ABVOnGZV7ICT5Uyb2aR+1kW+LX5NYhJWFsYSC01tDv1x2
 SSPQIBlEwaEGy2GXtpP2KdQyMclvztlioPfVwAzf1mQxS4UUsNKUzI2iAw+A/04UnZLp
 G9DA==
X-Gm-Message-State: AOJu0YyQO+ZKos9fVT+dCC/TsjwRXgbXRUXHTyZXS+y4/mbvqcSagfAD
 cY0OzSlRHQ5WhJ1KGbUII/3Z+Tp9SbpJV2K8ncsJmHKHdCZnVdeS1yJaUUZEiL5zP2JqmV6eeDK
 ViP0wMcbKt05h95duPXwwvOb7qR2a3xvFo83Y
X-Gm-Gg: ASbGncuDNlSmOG5NXna/J9jXEfPVLApP9d2maUiMiFrMx/Mi6eYdl+znT+y0WP1eMmz
 bHk1aFhVRtgtwLrHt+w2vU0KDnI6C2xrCpiYNGk0=
X-Google-Smtp-Source: AGHT+IFPn8AVejXfoH4cetM2Mfh4vEFae/QmxBZGRX9lq4eZBu0LFoeoL4dyCsy7dRTZff1ikJGeFEdsm6F77dtDkMw=
X-Received: by 2002:a05:6402:3206:b0:5d1:2377:5af3 with SMTP id
 4fb4d7f45d1cf-5d81dd83b23mr8400421a12.5.1734716230949; Fri, 20 Dec 2024
 09:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-6-sjg@chromium.org>
 <20241220144453.GB1505244@bill-the-cat>
In-Reply-To: <20241220144453.GB1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Dec 2024 10:36:56 -0700
Message-ID: <CAFLszThceeEktXy0zQLny5Hh4wAq0jXks4qijVyzgN0uHtG95Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] pxe_utils: Support the SAY command
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Richard Weinberger <richard@nod.at>
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

On Fri, 20 Dec 2024 at 07:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 19, 2024 at 09:01:20PM -0700, Simon Glass wrote:
>
> > This shows a message for the user. Implement it to keep the user
> > informed.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Where does the SAY command come from? This is in neither
> https://systemd.io/BOOT_LOADER_SPECIFICATION/ (which redirects and is
> limited) nor https://wiki.syslinux.org/wiki/index.php?title=PXELINUX
> (which is where http://syslinux.zytor.com/wiki/index.php/Doc/pxelinux
> redirects to now).

https://wiki.syslinux.org/wiki/index.php?title=SYSLINUX

Regards,
Simon
