Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07FAC04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 12:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D0A88633;
	Mon, 20 May 2024 14:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wm6/aJ74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D4B8869E; Mon, 20 May 2024 14:48:55 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82BA288124
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 14:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56e69888a36so7388533a12.3
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 05:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716209333; x=1716814133; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=th3Jw3Ra488MyIDoF+vI7PjhzrI0uWKpJV2cin7BcqI=;
 b=Wm6/aJ74t8yOSTyTe8ahnxvT9ddh4YcwgmiaHfg2Us5DD2uZRTzEq2t8uiSOYiHbDS
 s+YpkWBcYGt255X6tBCOcuQL4nReLXibXa6H6sJ+xfKKl9PHBdzHbxEyQIwfpNOqGNiI
 m0v/klxG53i7jLvoFSDwnHYOslm9xXWkMzGPiAGfI4nvRQURUvxIHZk43oPyG8oCEMX/
 N59LNbeEcwAqFrPsgtaAdeHSCpV3qIPVjtWscyC+JGDouCNu5QhT2KYhae7hwF7o7vSs
 uFJrQd7X/UZdhi+JDBX02TKiExyum8A2AuaSuqgkYB0GW3i3Tx0fmawRBMrO0J+dIsL0
 pCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716209333; x=1716814133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=th3Jw3Ra488MyIDoF+vI7PjhzrI0uWKpJV2cin7BcqI=;
 b=ehl0w/9l8xgH30eq7qhq0a5VCmLglZelcNA6XJFl6aGA3iv95IrqMVwAuCilUdbj89
 Gc86ISx/56PIgY5KJiYAH8te501IbfYKdnvvrEUflwaPPp7qUsfstZD0DTHdScBBNgpN
 rELmUAkydrjXbJh4dKSiTuyewZRdSM96+BNPSMweYh57Az+HJ86o1ntVY6skO7XW5EWk
 2F6FRhvkL/CysiXUs0ovOHsQcSZclJLSEJ0z5xv1aMbFo9CfMCs1uCXhE1BmSSmmA+Xc
 LGISLYYeObH0C2z9zZ1n6qf24RxUOw38GNxbEPrV03Vsysd4tqPcRV9CcottNTA5UyD+
 AqyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbSq+0b8/KclXP4aBkscHPwj1ypjLQaH6CkiXxa1UzDMpZW7BH3VpUCKzMFTXWUIIGbIa0pK8pnuSBaV5ct5m/NEw6aA==
X-Gm-Message-State: AOJu0YwELFb3hMXkQtRN6Au/bex/ikztW5GNBKa3JmdM8wBuCxNPe46j
 WrMSckST5NUe1FzEAVEN8eZVhNWD2z+n8rddImXJrA7jsxlBNbFkrtU/eIw6br910tzTeWu+0ZZ
 kNsP0KfVwChtFa1/f8qwSx/KMtgk=
X-Google-Smtp-Source: AGHT+IGookqit6t3fppSJK8FP4uPfxywqdNY4ygqwJ/Pc2p1Mj+uD00mLEB6K2NImPajkoDzpViIsVEpvVM/ehkyenM=
X-Received: by 2002:a50:f603:0:b0:572:7142:4594 with SMTP id
 4fb4d7f45d1cf-5734d6ed7b6mr16823029a12.29.1716209332715; Mon, 20 May 2024
 05:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240515234839.26898-1-andre.przywara@arm.com>
In-Reply-To: <20240515234839.26898-1-andre.przywara@arm.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 20 May 2024 13:48:41 +0100
Message-ID: <CALeDE9OrY-wdpbdOWvqkgYE6YD8SLGCw_Fo1FaBsjQ75LQcqtQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] power: pmic: sunxi: consolidate AXP SPL drivers
To: Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Ryan Walklin <ryan@testtoast.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
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

Hi Andre,

> this is the first series in an attempt to clean up the X-Powers AXP PMIC
> drivers used by the SPL for sunxi boards. So far we have a separate
> driver file for each AXP variant, but the code was largely the same,
> just differing by the regulator ranges.
>
> This adds a new generic driver, which reads the regulator description
> from an array of structs. This is similar to how the DM AXP driver used
> for U-Boot proper works, but is simplified, since we won't need the full
> feature set for the SPL, and we want to keep the code size small.

Overall seems a reasonable approach, would it make sense to put the
regulator descriptions in a file that could be shared between this and
the DM driver so the information isn't duplicated and hence may
diverge over time with things like copy/paste errors?

Peter

> To help bisect-ability, and to simplify review, each of the simpler AXP
> drivers covered by this approach is handled in a separate patch.
> We just convert the AXP313, AXP305, AXP717 for now, and on the way add
> support for the AXP707, just because it's now very easy, and we will
> need it soon enough.
> The other AXP SPL drivers are more complex, and support more regulators,
> but my hunch is that we really just need the DC/DC converters in the
> SPL. However I need to prove and test this, so I will convert the other
> AXP chips later.
>
> Please have a look and comment whether the approach in general is a good
> idea.
>
> Cheers,
> Andre
>
> Andre Przywara (6):
>   power: pmic: sunxi: only build AXP drivers for SPL
>   power: pmic: sunxi: introduce generic SPL AXP DC/DC driver
>   power: pmic: sunxi: replace AXP717 SPL driver
>   power: pmic: sunxi: use generic AXP SPL driver for AXP313
>   power: pmic: sunxi: use generic AXP SPL driver for AXP305
>   power: pmic: sunxi: add AXP707 support
>
>  drivers/power/Makefile  |   8 +-
>  drivers/power/axp305.c  |  82 ------------------
>  drivers/power/axp313.c  | 133 -----------------------------
>  drivers/power/axp717.c  |  92 --------------------
>  drivers/power/axp_spl.c | 184 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 189 insertions(+), 310 deletions(-)
>  delete mode 100644 drivers/power/axp305.c
>  delete mode 100644 drivers/power/axp313.c
>  delete mode 100644 drivers/power/axp717.c
>  create mode 100644 drivers/power/axp_spl.c
>
> --
> 2.35.8
>
