Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698B0D49775
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1BFA89137;
	Sun,  1 Dec 2024 16:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mM5URMxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA2A38917A; Sun,  1 Dec 2024 16:23:08 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E5EA89189
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d0bfa52bd9so2226639a12.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066585; x=1733671385; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vk5K/ukMpmKgugUeX47T42GzqdfZyaxB7x8BKGmVpP8=;
 b=mM5URMxd9iGT/VmBTYb8FWvugArNVbpJmwn9txoPlUorW8Ky/W3cVVvSERX0knY0O4
 G4jOnqcW8fhjgo5MKJaqpz0D4vaqi156FVV8ZnJ2SaWG46HLE27t/JoUCct25tUzsf10
 CAcHiBQhNCa6KajDHYK0gIoJBhgMDS1jnygmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066585; x=1733671385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vk5K/ukMpmKgugUeX47T42GzqdfZyaxB7x8BKGmVpP8=;
 b=FW9VarP8qcE6tPiQK4KXG5PyXCYXZWfAo0WuK6Bk7lK3Xgg1zBUd2OOtVvIl9wzCCr
 caCFVT+QjyiBJYJgSRduFur3HTswToK33XsbvYHVNUIXrquVRbsd1e39y5V9ivDFaxGE
 6jOS+wmo7zexDv+Pa9skXJ1X4MnKB+Y7kMNnEohouSboUlXEvl2dHvRa00siuA8ojpSv
 ZUynxSlc6iFdjfdsSnth5Jhdz6KU4lIMwMrsoA38EtIMRIOWDNHKmb0UDiZqGTvENbj9
 f4a0OQom0hQXpdFVDtP9tUf7GJzuywotNatfD9DUBIerWTgfdXLxdIFqplTVfjNyFd6I
 vYHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkp9vBbt25KsTb+qoEm7HYz32pm2wdjXaj8sc7723TKO4JMkowEHFh50LafjhWz2wCG7gKKC4=@lists.denx.de
X-Gm-Message-State: AOJu0YwhYmtb5gd5dHL+HQBm9Gh9RYbQ+HCVtABUW95lo/xM+wHVzlBW
 iaGNkQOJoSBlLMvKMzeiqC8Msw5597QBTtnuAdJEvEFxuzQFi6CA34IB8Q8otQJnoNvgLK3nydX
 JQwOlJnGksr6VenLyIHJLRN9IcUkeYtacJ5zxPAQCPKl9SUE=
X-Gm-Gg: ASbGnct3EJuSHtVuvyB4E4tQ4e+no8Jq+PL3cEIOxjtvDvOcyMgK2ezh/6KYjBk+9VL
 tuwWjbsrT5wdm/ea284lmRjJb/SRgMQ==
X-Google-Smtp-Source: AGHT+IG5TzwNTWOHYCHZC00gHuneIdVSkBR9OYHpvZY2+8EiMTvSmZTBlllCZrnMQZD5IdFSbIHMCuMcmsGy+UW5mbI=
X-Received: by 2002:a17:907:9389:b0:aa5:b3b:4d7f with SMTP id
 a640c23a62f3a-aa581055411mr1427090166b.41.1733066585245; Sun, 01 Dec 2024
 07:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-3-sjg@chromium.org>
 <CAPVz0n0RGrgUSrNzyT16FKMBcqYs00qb+3jEHsq4tiYyWGR-Nw@mail.gmail.com>
 <65cef924-a16a-4af1-819c-a15410d92f4c@denx.de>
In-Reply-To: <65cef924-a16a-4af1-819c-a15410d92f4c@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Dec 2024 08:22:53 -0700
Message-ID: <CAFLszTg1Na9ziMv4J1Pb9vjw=fYPh+RLGvT-KyYcjGEEonGk2Q@mail.gmail.com>
Subject: Re: [PATCH 2/8] Revert "power: regulator: Trigger probe of regulators
 which are always-on or boot-on"
To: Marek Vasut <marex@denx.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Svyatoslav,

On Sun, 1 Dec 2024 at 08:20, Marek Vasut <marex@denx.de> wrote:
>
> On 12/1/24 4:05 PM, Svyatoslav Ryhel wrote:
>
> [...]
>
> >> @@ -288,7 +289,8 @@ static int dm_test_power_regulator_autoset(struct unit_test_state *uts)
> >>           * Expected output state: uV=1200000; uA=200000; output enabled
> >>           */
> >>          platname = regulator_names[BUCK1][PLATNAME];
> >> -       ut_asserteq(-EALREADY, regulator_autoset_by_name(platname, &dev_autoset));
> >> +       ut_asserteq(-EALREADY,
> >> +                   regulator_autoset_by_name(platname, &dev_autoset));
> >>
> >>          /* Check, that the returned device is proper */
> >>          ut_assertok(regulator_get_by_platname(platname, &dev));
> >> --
> >> 2.43.0
> >>
> >
> > It seems that I have found a fix for this issue. Simon, please test
> > this commit https://gitlab.com/clamor-s/u-boot/-/commit/6149722aa48f84d9ea037ae990141a231106244e
>
> So this regulator problem was a tegra platform specific issue after all.
>
> Nice find, thanks !

That's great! Are you planning to send a patch?

Regards,
Simon
