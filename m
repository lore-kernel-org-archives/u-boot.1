Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443E1C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 12:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C95BD80F0B;
	Sat, 15 Feb 2025 13:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MpFWq5g7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B7C80F0B; Sat, 15 Feb 2025 13:06:57 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FC8080F12
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 13:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-abb86beea8cso2301566b.1
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739621214; x=1740226014; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fBMq9n3Y7ShpRsL/50rRsOs0JMmZwHNMocflQXpvx2w=;
 b=MpFWq5g7ziKKd7oC12KmbqqKwgzhlyJIxgRdj1jP/oOkSkDH1tXVQSw/c1MDmiqb7R
 8wlL2qxR2pPrtqPuXVICdu2nl2UPbb9qt1Qg6X2HoxBwMHBiyVNySdT6Z8TVLFUkL5Yn
 uWq8PxdsCAYZKtTWuBhwtZLkIkqk/AvXI9MSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739621214; x=1740226014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fBMq9n3Y7ShpRsL/50rRsOs0JMmZwHNMocflQXpvx2w=;
 b=mTkdKEh1WpFFyVn+Gje9nw5PTfHVr49OAS6ZCwivXwKpPs+88vlqB/XlL+3Z9Wuk0J
 bdkg6Pf5rJ2OZ9tlI6WwLVQnSFHcMV4KU0x1SJWrGDxHPaNbJI+n1l1bdpGLju7ArxGA
 dPCGQuXunUGDVBWOP/3e3KrBBvF0ejLVFS9kDL1lVAY883HYgRh6PqVY9P19KFy1177m
 d+D5kTanqLKXR3n7fAZEtPT0YdrpDz/vBvLbTJ4wxo0UwttLiSe0IvyH94tvSF65AG+n
 mv0GofcuqkLM6UdUrYRGQrJyUv4RCMzOCmK3lngD/BBSW0t4BkXE/PYKeurvXuk/JcGq
 h2GA==
X-Gm-Message-State: AOJu0YxyjN+6phcGFAa/4fxsvclOtMYBvGwGM5MZAr743qn74ECjshYb
 CV6uS6MMvKLk0aWQDxJMpBwJsHfh0M0Vzy1G2bb/pVPk78btkoIxYtsMiBA3bBChC2nrlYa+SKB
 tUAn3ucY0RrSlhLmyo7QGccwouvvcN3LkylAX
X-Gm-Gg: ASbGncu/fFPGZMyvg8jiVCp+IQlTbdi+IPaVZYhvkdWpen31RIYtjbG4nJrpIi8GQl8
 1YEuDb17ln00CnRoUGl4zBhEU/ZZy5k6+cBPNOrL4J6DfJ/pxN8KYA2W5hHNl+t4Y9ySS1M3NzA
 ==
X-Google-Smtp-Source: AGHT+IGrbYrHkos25PofZdhEoB8zDd1KiUcj05QvgAtMOrZqmKnAvz4hp9LeIroT+LKPBf5fbR6HlJVVDHyTmaK5JUg=
X-Received: by 2002:a17:907:770f:b0:ab6:362b:a83a with SMTP id
 a640c23a62f3a-abb70bfe46bmr189682766b.8.1739621214466; Sat, 15 Feb 2025
 04:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20241206023626.2456858-1-sjg@chromium.org>
 <20250124191830.GS60249@bill-the-cat>
In-Reply-To: <20250124191830.GS60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 05:06:42 -0700
X-Gm-Features: AWEUYZl1gpE2sFIcaxcqVKlaJweKQ7npffDVIhzjV_fD5WmglUaHSnA-e2llxG0
Message-ID: <CAFLszTgZKtsCgrptCCJm2Ucbz2b0zPeOymT6aUb2=VBwjOubpA@mail.gmail.com>
Subject: Re: [PATCH v3 00/46] pxe: Support read_all() for extlinux and PXE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ion Agorria <ion@agorria.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, 
 Nam Cao <namcao@linutronix.de>, Peter Korsgaard <peter@korsgaard.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Ramon Fried <rfried.dev@gmail.com>, 
 Rick Chen <rick@andestech.com>, Roman Stratiienko <r.stratiienko@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Fri, 24 Jan 2025 at 12:18, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 05, 2024 at 07:35:39PM -0700, Simon Glass wrote:
>
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
> > However it turns out that the booti support doesn't work with compressed
> > booti images, so this series resolved that problem too.
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
> With v4 of 45/46, this fails with lwIP on Pi in the PXE tests now. You
> likely don't need more than CONFIG_NET_LWIP=y being added but for
> completeness here's everything:
> CONFIG_UNIT_TEST=y
> # CONFIG_CMD_EFIDEBUG is not set
> CONFIG_CMD_BOOTMENU=y
> CONFIG_CMD_LOG=y
> # CONFIG_CMD_BOOTEFI_SELFTEST is not set
> CONFIG_IPV6=y
> CONFIG_IPV6_ROUTER_DISCOVERY=y
> CONFIG_CMD_TFTPPUT=y
> CONFIG_CMD_WGET=y
> CONFIG_FIT=y
> CONFIG_FIT_SIGNATURE=y
> CONFIG_FIT_BEST_MATCH=y
> CONFIG_SYS_BOOTM_LEN=0x4000000
> CONFIG_NET_LWIP=y
> CONFIG_BOOTSTAGE_STASH_ADDR=0x02400000
> CONFIG_BOOTSTAGE=y
> CONFIG_BOOTSTAGE_STASH=y
> CONFIG_CMD_BOOTSTAGE=y
> on top of rpi_3_defconfig.
>
> --
> Tom

I just noticed this response (a bit behind on email), but I don't
think it is reasonable to require out-of-tree changes. We just need CI
to pass, along with any labs. This whole series seems to have been
blocked?

If you like, I would be willing to debug it if this series is applied,
and send a follow-on patch. I have a second rpi3 in my lab which I
could add to gitlab, along with the changes above, so we can catch
this sort of thing in future. It would have to be added with some
documentation, so others can figure out what is going on. Just to be
clear, I have no issue with LWIP, just with this series being blocked
due to out-of-tree changes.

Regards,
Simon
