Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16173C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 04:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A74F80657;
	Sat, 18 Jan 2025 05:34:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BOzy3l89";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4EBC8070C; Sat, 18 Jan 2025 05:33:59 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 995988036F
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 05:33:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d647d5df90so4688678a12.2
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 20:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737174837; x=1737779637; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ESJZwf+BQGUuOXeuqbYGGZ0hs//YYnKCNjYToscc4L4=;
 b=BOzy3l89U3iyqn0k8K83SYBWulyRn2/nBMAqxemyGdvPuvBmJ5YZOrv+NNwdXh9WnE
 kz6yNPteUHPuBW2uYkglytq/1LeEdzv3gQEOzmGia8kucangetvB03rhQBJpW9wQJ15A
 b6CyKySXXpTAjVXN12DyWJjelqt9txBGW+5Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737174837; x=1737779637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ESJZwf+BQGUuOXeuqbYGGZ0hs//YYnKCNjYToscc4L4=;
 b=wkkXoLs3z0CpIiwiRPvC0lOCq/AWWxTZQVE2cHLEut5WLMvY1s4EQgGna4Cvqf/N6b
 tOrMuPTP183RR7PloTFh1tU9lp0WXzrKBKb3q+4QJGmZE/rRFOYeZfr4rNN6GuUQ2N4n
 YuZpXtzUYIrbJPtTU7L6BTKU0uxyQ3IGlk2PrUwoXrprTPUJ4xYU/4djhy6Qge0uEDa1
 n7UEVWWrQQyz5EMSbtbTAco5T4C5Q12UhExvfezcu5mW0JALSHZeeaW8JwrXS1vO91nE
 LAANV3jEanHOJFhTiDYlf2h0UFV/e7jYBNnW2oQj1ztxZhBzML0CLr1CtBTF8UMm0JaF
 4Uvw==
X-Gm-Message-State: AOJu0Yw+XmhWWfWboZixEZX/G1GgT4OEvcFsAweHQuhOR9h1wWyfSjuL
 xpU10Y/rGUZF/KlUPToWi0aI1UiqP9XI5sgOeQ3WUTHA9xbROXnfQTkl7A8xx8kcMb0hzEwfOX8
 8yknpSxu/YJ67TkANPT0gDoD2BU4YamOpPgQt
X-Gm-Gg: ASbGncuJPdc6P4wSOsayiV1ri1VMwAadJpxuBwY7qPQl+WJ4SNCD8XAhkSl6Zk/v2a6
 qGJWlQYOlStymtZPVMkgLtKGiVm5ASvl69gIftPb8C57cy9uG1vBvj82ZmfnhhYcjJF0EBAu+L5
 oG591YkNmA
X-Google-Smtp-Source: AGHT+IFb1ZsMLh0t932O0Eb9IKBK+Kdl2YmBH+UzpTRVNpIAjeYJMwG9mYTjJMusVh8rtiHwOIPomJMswJArRtxZHwo=
X-Received: by 2002:a17:907:7d9e:b0:ab2:eb1a:9479 with SMTP id
 a640c23a62f3a-ab38b0b7efemr516542866b.2.1737174836899; Fri, 17 Jan 2025
 20:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20250116012723.2820301-1-sjg@chromium.org>
 <20250117000026.GO3476@bill-the-cat>
In-Reply-To: <20250117000026.GO3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jan 2025 20:33:35 -0800
X-Gm-Features: AbW1kvZFGrAD3q2fjoGBJ6CtnEqWlJVziV6P7ptK8qL73Yg01WQvblwod9V2zug
Message-ID: <CAFLszTgmgb-sNDO4kx4DzM=Uoq2VrOww3QHQ8i0e9vBcttRKSw@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] vbe: Series part F
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Gary Bisson <bisson.gary@gmail.com>, Greg Malysa <greg.malysa@timesys.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Trevor Woerner <twoerner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, 16 Jan 2025 at 17:00, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jan 15, 2025 at 06:27:01PM -0700, Simon Glass wrote:
>
> > This includes various patches towards implementing the VBE abrec
> > bootmeth in U-Boot. It mostly focuses on introducing a relocating
> > SPL-loader so that VBE can run in the limited amount of SRAM available
> > on many devices.
> >
> > Another minor new feature is support in VBE for specifying the image
> > phase when loading from a FIT. This allows a single FIT to include
> > images for several boot phases, thus simplifying image-creation.
> >
> > One lingering niggle in this series is that it has a different code path
> > for sandbox, since it does not support the relocating jump. It should be
> > possible to resolve this with additional work, but I have not attempted
> > this so far.
> >
> > For v2, I have split the first patch into 5 pieces, to make it easier to
> > see the code-size impact, plus added a few tweaks to reduce code size.
>
> Overall, size wise this looks better than v1, so I'm generally happy
> enough. That said:
>
> [snip]
> >  boot/vbe_common.c      | 375 +++++++++++++++++++++++++++++++++++++++++
> >  boot/vbe_common.h      | 137 +++++++++++++++
> >  boot/vbe_simple.c      |  98 ++---------
> >  boot/vbe_simple.h      |  16 +-
> >  boot/vbe_simple_fw.c   | 207 +++++++++--------------
>
> The size growth indeed comes from the compiler/linker not having as much
> insight as it used to (except for when LTO is enabled). Perhaps once we
> have more device types available it'll be clearer to see some way to
> better re-organize things for savings again. Thanks!

We need a clear idea of what data needs to be checked and what is
considered trusted. One idea would be to have some extra checks which can
be disabled to save code size. That is something which could help across
U-Boot.

Regards,
Simon
