Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF19D2A53E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 18:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FA0488DC7;
	Wed, 16 Oct 2024 20:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j3A2d4jY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1871588DE5; Wed, 16 Oct 2024 20:44:42 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1519388DC7
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb5743074bso924201fa.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729104279; x=1729709079; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKlXuc5DNfZVVZatH6eXqmwpyzZY0K+q7bjz/DI2nfI=;
 b=j3A2d4jY1lEaTwfsJO5CtmmCW6Ew6RQ1fq9zYzuh7vHhD0M5Ltm3ZKCwTVE6fVyS5H
 D8NkZdVlya7baeRhKYhRKHkl3quej0CMxSDl6InmLDm/nH3GQgJTCDnMna2v5VLWq0he
 XhzMfP/tVveNY+45LUxDfnSf0DOLO9HhMgPcTA4Y1Cz3M2U0Ifxw2IG+Ci/pvigl6vkh
 oK4iIBm43h8DYgj7F9D6tnWpv2P0kDtTK+e43frGVYyyscQSp89op8Vq480T2mnVAUSe
 dzahaFqST679GF7hMMTNr27E6hqN9rDKbSgCTJCOKE+483kn4kTyRbXvh8JRB3rsryk/
 BZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729104279; x=1729709079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dKlXuc5DNfZVVZatH6eXqmwpyzZY0K+q7bjz/DI2nfI=;
 b=CK5EqPfZg7Ny5Ca/O1U4I/ELJBQ+rFSydCOQUMXgDvnZw+ZK4gsSTIZsyo20ohdgx8
 apy2cYLPZQpZjA4QKe1x50JDEY8tioKIBWz8Dr7Xjer2Yf0qM4QyED4KNKOxRaGUJVAB
 EczR7HrmPJ2wzzg1QBBKceIfzFTm1Vlyomn9Ss78VdD/hZidJRn0J9acTao3wl+uR2ib
 mDGtIxJZneGZ0mGsyfuj295tmRLKOitIsUUbGzI8AbaqHW7ZO2zgbZGb59FgbWlpdf07
 gtBgu5eb8hx0IJSuZezxmW/BxAJH0lIxvGRMTFk5A44OAHxF3+jMOmAyYKWqMbRbw8YQ
 yLAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5wcgh2o//t9fEot7/FtFAViBJcmDHcZVJKOs4Jc2xW1mzloRr2Jla1WcpheDq12nVQ5NXdj0=@lists.denx.de
X-Gm-Message-State: AOJu0YwDpbW247pKMjKempHsJQIZfPtiHKvS+XmBfqeuQ9nCyMUfKhqA
 tWausCSi8sbTGjLo/1ty3I0At3Aci+Prq6nlymrynLY7GTVMdu+OdDfjqP6XTz05xbHEcXDhPW4
 Y9b153IVE7fbrek1Q13Kv/7MV+As=
X-Google-Smtp-Source: AGHT+IFJW2NqnBNdXwTtXzUomEG9LmIUCNUrHd/bjiw8kLa8Cm52S16801Nzw7LSjzSgyN3t5tqoQ24qRZ0SigXofKQ=
X-Received: by 2002:a2e:4a12:0:b0:2f7:5ca2:6d10 with SMTP id
 38308e7fff4ca-2fb6da109bbmr1583651fa.15.1729104279119; Wed, 16 Oct 2024
 11:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20241016151035.709351-1-ravi@prevas.dk>
In-Reply-To: <20241016151035.709351-1-ravi@prevas.dk>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Oct 2024 15:44:27 -0300
Message-ID: <CAOMZO5AOBX+bydadzHsj1Zn4xqOSyy9681879DvoJ_BZcaDhEg@mail.gmail.com>
Subject: Re: [PATCH] envtools: make them build again
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, emkan@prevas.dk, 
 Joe Hershberger <joe.hershberger@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Oct 16, 2024 at 12:10=E2=80=AFPM Rasmus Villemoes <ravi@prevas.dk> =
wrote:
>
> In v2024.10, "make envtools" is broken for at least these defconfigs:
>
>    am335x_evm_defconfig
>    rpi_3_defconfig
>    rpi_4_defconfig
>    mx7dsabresd_defconfig
>    wandboard_defconfig
>    imx8mp_evk_defconfig
>
> The only defconfig we use for which it is not broken is
> stm32mp13_defconfig. They all work just fine in v2024.07.
>
> The symptoms are slightly different, but all related to the fact that
> some transitively included header uses IS_ENABLED or CONFIG_IS_ENABLED
> without linux/kconfig.h having already been included.
>
> A simple git bisect doesn't produce anything sensible, it ends up at
> 3a9f642ca94 (crypto: nuvoton: npcm_sha: Support SHA 384/512) which
> clearly has nothing to do with this. But digging deeper, one
> eventually finds 0f92fa45603 ("env: Remove <common.h> and add needed
> includes").
>
> So at first I tried adding "#include <linux/kconfig.h>" in
> include/env_default.h and include/env_flags.h. That fixes it for some,
> but not all, of the above. For example rpi_3_defconfig still fails,
> then in log.h complaining about BIT() and u8 not being defined. At
> least BIT() is should have gotten from bitops.h, except that that's
> behind ifdef __KERNEL__, so not set for the envtools build.
>
> It turns out that the envtools source code in fw_env_private.h already
> has some hackery to deal with all this, in the form of the __ASSEMBLY__
> games it plays before including config.h. It seems that if we just
> make sure to do that include early enough, so that config.h is indeed
> parsed with that __ASSEMBLY__ hackery in place, everything builds
> fine.
>
> Fixes: 0f92fa45603 ("env: Remove <common.h> and add needed includes")
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Thanks for the fix.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
