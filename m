Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F2BC4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 13:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BFCA87F6F;
	Sun, 14 Apr 2024 15:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TXTmMfc6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A31F88802E; Sun, 14 Apr 2024 15:41:53 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DED1787D42
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 15:41:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-61ab31d63edso5310247b3.1
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 06:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1713102109; x=1713706909;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6zJZN9ZiYSKJuwevxMtS2eYhx+kXkNKDgxrOJfN8K5E=;
 b=TXTmMfc6CJJfTJlOq7yPivWpzXA4nDrY7d/cuL8UoXHNzPPOteXAO36ojS0YmOjZAk
 sFxMM1bA7Ip/6CDXdigECSqb+yzz3I0ZrSgWmQ0nqij1V22qIpD9xXkZETyGo9ogGLG2
 2mqH1qE4eBvTWxoz/UmBpNNmXxLFH95+hCrpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713102109; x=1713706909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6zJZN9ZiYSKJuwevxMtS2eYhx+kXkNKDgxrOJfN8K5E=;
 b=gPhVTnBieMdwygQX38UlvcOykhXN97Kzpuft6/cCwFwIZ1BC6vfD3g9chRhQUHEqTq
 zu01jGwBaPb3hkxrRK5Ob/Yp3mPKWw7gxTW+bGPbx5fLEusr6dsQuIc6QeraeAx7AJ2L
 vW5yCkI22BLMYg5O6RKLWw65LM0TQkLZS//JWxXgnPOb4AS/ha+yTZKSDq7985WODUi4
 TNMF9yaTBi3+GH36wsLzXzxzUq+/X+BsIrPWikua8cUrlLvh29OqIKb55PakSoWP7vJ2
 1waIuHv2mzOVDNyLM9nnzZSJ71ZXrFKjek8LrrWGAtzQi0Pl4phIsyv9/MDpUr6w+hFD
 Lxlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEP0v9x1MvSZufslz4WwqwqtQe9Qn8wXOAUtgzbC2J4EZpPQmGkPKYd9qkp+KEoBYQSPxL7fY/7iAgzM/zNHDQNetMdA==
X-Gm-Message-State: AOJu0YzSlcg3mMEa3UH874TuhV/XKDQiSaz4xg4yVtvJeghe/HuHkVfH
 9rQK8JRRYWePza2tSCqh09cP3c1PX9WhfZRSfTOyyzue59QvkjAbhHCHU+DY4bPi2De+4tdZF6X
 gokjTFCKfrc50I1haTW4oCqisspHZhQCS+91IWQ==
X-Google-Smtp-Source: AGHT+IF9yvMQrkOsvuiGG1JTd4as1cNy1VU8V7dWV6py9Pxwx739JjOzDp4kC31Gdm3alLtCQ5uvCMQkMw5ED1hxlMk=
X-Received: by 2002:a05:690c:2e0d:b0:61a:a6d6:5b3c with SMTP id
 et13-20020a05690c2e0d00b0061aa6d65b3cmr2165121ywb.11.1713102109673; Sun, 14
 Apr 2024 06:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240320090214.40465-1-ada@thorsis.com>
In-Reply-To: <20240320090214.40465-1-ada@thorsis.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sun, 14 Apr 2024 15:41:38 +0200
Message-ID: <CABGWkvrF3UxEzw2eh1kb7To+aQ8iaWMyrnU8Qz0tYJGumY0QGw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mtd: nand: raw: Collected improvements
To: Alexander Dahl <ada@thorsis.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>,
 Mihai Sain <mihai.sain@microchip.com>, 
 Li Bin <bin.li@microchip.com>, u-boot@lists.denx.de
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

Hi Alexander,

On Wed, Mar 20, 2024 at 10:02=E2=80=AFAM Alexander Dahl <ada@thorsis.com> w=
rote:
>
> Hello everyone,
>
> while working on NAND flash support for a custom board based on the at91
> SAM9X60 SoC I stumbled over some issues in the raw nand subsystem.
>
> Four of six patches are minor fixes.
>
> Patch 4 introduces a new subcommand for the new atmel nand controller
> driver.  Patch 6 introduces a new subcommand for the nand command to
> override ONFI timing mode.  Both are are for debugging purposes only and
> thus optional, and need to be enabled through menu.  Both helped me a
> lot when investigating issues.
>
> Series is based on upstream next branch, but should also apply to master
> cleanly.
>
> Greets
> Alex
>
> v1:
>
> Link: https://lore.kernel.org/u-boot/20240307091014.39796-1-ada@thorsis.c=
om/T/#t
>
> v2:
>
> - rebased on recent next
> - collected tags
> - improved patch 4 after feedback from Mihai
> - added new patch 5 with another help text fix
> - added new patch 6 with a new debug command
> - reworded cover letter
>
> See per patch changes in patches for more detailed changes.
>
> Alexander Dahl (6):
>   mtd: nand: raw: Use macro nand_to_mtd() where appropriate
>   mtd: nand: raw: Port another option flag from Linux
>   mtd: nand: raw: Fix (most) Kconfig indentation
>   mtd: nand: raw: atmel: Introduce optional debug commands
>   mtd: nand: raw: atmel: Fix comment in timings preparation
>   cmd: nand: Add new optional sub-command 'onfi'
>
>  cmd/Kconfig                                  |  10 +
>  cmd/nand.c                                   |  61 ++++
>  drivers/mtd/nand/raw/Kconfig                 | 115 +++----
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 299 ++++++++++++++++++-
>  drivers/mtd/nand/raw/nand_base.c             |   8 +-
>  include/linux/mtd/rawnand.h                  |   8 +
>  6 files changed, 441 insertions(+), 60 deletions(-)
>
>
> base-commit: f048104999db28d49362201eaebfc91adb14f47c
> --
> 2.39.2
>
Applied to nand-next the first 4 patches.
For the others, we will conduct further testing before applying them.

Thanks and regards,
Dario
--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
