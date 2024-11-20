Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D6ED711B4
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5C3389301;
	Wed, 20 Nov 2024 16:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ecRpVNh4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A02858933D; Wed, 20 Nov 2024 16:34:28 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54C53892DE
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:34:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7eae96e6624so1807609a12.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732116865; x=1732721665; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K7SWrL5LqaSbRpuX5jmemD90J8efozF0TkRw7UrqPN8=;
 b=ecRpVNh4LGC+xKMi6sQvKoZGC7HHxu6z5ClQBrhxyJyzE4TuMZUJ3FYyTn8LxiTSza
 f65feLEYEWVuFV+I+ENVLo6GNWniof3yncnf63Fv0xUh0R2IX5Bc1mf7dxXGo0EKuqyw
 p0+VDwUPkDJ6h3OofEOvZRFzw8hRpFWv0enJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732116865; x=1732721665;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K7SWrL5LqaSbRpuX5jmemD90J8efozF0TkRw7UrqPN8=;
 b=gdmJ12sb1LxNQyl6LiGpX+rLOT4kqW174+tUEcsV1dnbvOBm7hDg3qqw+Zg4X65D9u
 e+DNf3dtJDzns/D8k+jV+R40C79JNuJUmAutXbWm2GKNt6I7wKHJN5eX33i5axyqJjvI
 GJVO5V2eZQPxpJSvEzs1M5NcRHI2a4Ps/1Y71dzXtF/fOUWPfzZw/q/UQHnVpWTvrjHg
 O3zx7f0rgtP10g8G+BcXHEZ+RbPTbC6TyCM1+KtUNDgcwgmDdhUi4kBu4O2qyAQZdCQd
 mrZZUNGgyXLfvfkvrADTY6buOU/jl+gypPFXDGNCFIsxqmMUjYfP/nVV1EtCOLmuOZ4f
 Kehg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZpAnwcRI4moSojcIk7ucgCuUjIZvNUhMD5clbl8uD9JyNkqOowpxKtzCI+URESyg67K8TGI8=@lists.denx.de
X-Gm-Message-State: AOJu0Yzr9v8z4E/DGqogl+Myra1Li4C5sZUcuyNCrxzDiehroJnDyCY3
 ctCHS/nALWz6t0ZVfo8eY3jR+q49B9PQIJk8VkFUYWv+ITJkkFxdHiTMVr4vFz5Q637zA711epU
 YM5FF4xy625Z0y+mrz0tN7dtOiW1HT1iL8II0
X-Google-Smtp-Source: AGHT+IF3xlBSmdFtlq/iMZMRU8u5vIkIZYjySQ1Hh+SaZ1ptHNpezoFPZfaIOMP0n3nAbwjRwETVIafuog/Jnxn7leU=
X-Received: by 2002:a05:6a20:4314:b0:1d9:c615:d1e6 with SMTP id
 adf61e73a8af0-1dda22857cbmr4737115637.0.1732116864877; Wed, 20 Nov 2024
 07:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20241119131844.4078144-1-sjg@chromium.org>
 <07dd3c79-2f06-4d76-bdb5-8c1c6b39ca4e@gmx.de>
In-Reply-To: <07dd3c79-2f06-4d76-bdb5-8c1c6b39ca4e@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 08:33:46 -0700
Message-ID: <CAFLszTi941E3OUpPc3B4zhbHUAhamztOQ8jNnCepn2aRnoJ5NQ@mail.gmail.com>
Subject: Re: [PATCH 00/39] pxe: Support read_all() for extlinux and PXE
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ion Agorria <ion@agorria.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Hi Heinrich,

On Tue, 19 Nov 2024 at 10:12, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 19.11.24 14:18, Simon Glass wrote:
> > This series implements read_all() so that it is possible to read all the
> > files relating to a bootflow, make adjustments and then boot.
> >
> > Unfortunately quite a few things stand in the way, so this series
> > finishes off several pending items: zboot without CONFIG_CMDLINE,
> > required support in pxe_utils and the differing code in the extlinux and
> > PXE bootmeths. There is very little new code, but quite a lot of
> > refactoring.
> >
> > The bootm, booti and bootz commands have all been refactored previously,
> > so that they can operate without needing CONFIG_CMDLINE to be enabled.
> > At the, time, zboot was left alone, since it is x86-specific and a bit
> > more trouble.
> >
> > This series adds a programatic API for zboot and uses the forthcoming
> > bootstd 'image list' to collect information from an extlinux file. It is
> > therefore possible to parse the file, load the resulting images and then
> > examine/adjust the resulting bootflow, before booting.
> >
> > The addition of options to extlinux resulted in the PXE and extlinux
> > bootmeth having slightly different features. This is tidied up in this
> > series, with common functions for both. This allows the same features
> > (loading images as a separate step) to be provided for PXE.
>
> The biggest problem I see currently with PXE in U-Boot is:
>
> eth_bootdev_hunt() invokes dhcp_run() which may lead to actually
> downloading and booting a file (assuming autostart=yes).
>
> We should only check that a network device exists and can be probed.
> Maybe check that the medium is attached when probing. But actually
> reading a file should be left to one of the different boot methods that
> can make use of the boot device (PXE, HTTP-Boot, ...).
>
> But I cannot see a fix for net/eth_bootdev.c in this series.

No, it doesn't include anything for that.

We could maintain a flag to indicate whether the net dev has had DHCP
run on it, then make sure only to do it once.

Regards,
Simon
