Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0ACC54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 13:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF4E68309A;
	Thu, 22 May 2025 15:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iijq/I8f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 992A78309E; Thu, 22 May 2025 15:06:36 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABAF68006D
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 15:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-54b166fa41bso12164104e87.0
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 06:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747919194; x=1748523994; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3dNAtot4GCxgY+Ixm8/qWuWEl0p4vft+SrLRsObBSQ=;
 b=iijq/I8f3b7zkmx/e7zXBbfxMzVnypQvWl2BChGoVXeBQYMUargEPGDZGywX53baLk
 wZZ7KF2txUTIdwsMeYTd59Kwtyly08a0VATkCi5IHVVRswkynOFlHxNV2DYa+Po6OQtr
 yHCqrhXWqIUUQxYgmCrZVbPW39NdIwPyQbzQVbxM2gdyEyokLDna+w0GjVpNIljhhvp6
 4P/47WK2rgE7okXirx2uwfp3J15QVMf7SvXXGFDrGrKoLkQINj4heWwpsx3+1ym8FAZi
 J++n2k907pfDDKFZKlR8EIzHz6smeyhoeY+CO7aPz4P3ZE9rGlIanKzbidOOvM4sHIVa
 lVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747919194; x=1748523994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3dNAtot4GCxgY+Ixm8/qWuWEl0p4vft+SrLRsObBSQ=;
 b=urYcs7HfBFZ8/sl1VsoyZLw4vrye6xS+oU4797QAlLyqbDmO6vEcGFbMhaVllGfiBB
 9mirTuVSC+ht3qU5YlhFbTUSx3IJ3x+XcwpPgBQyHpGyoMKS8ZxdblAU8m9nxqejnioF
 jNBtHV7vSLE99OPhgcYDv75EHQLsmMwYMPxFcqrMatRPA77ij06VtohXIVYqoc0yioxj
 qkCYizu1iAGmf+e7Gn5oGwjcaOq8PpA1CCiKB+fO0hTR4eD9TNoOvutcqFwNLpF/moFv
 FkiMzwoBhoQId9iRreg9a9xrq12kMBfjaF7EK+Y6xWxnPSIMof6BCv8FnIFKQU/mbfof
 PZ7g==
X-Gm-Message-State: AOJu0Yxkw5DBSgTe2mymxECMhLGQGWV7WMrZc3V/c4kvf7FHM3Aaw+Ip
 K/ClfzTvkp67mGBlTz7btV+KygCE/2/f05BoghPO6XDX4N3knb8WQLWQKxAke4skxgA0xaVegB8
 9wXHM3EZAD5TykFXaWMn7yAaG7H8r0KctIw==
X-Gm-Gg: ASbGncsXiVaQb9kfp4ZfxPGzmiSNJcniSPqo8C8GQH9Jv78xbgcdkr92Pp4GT/n4T/f
 YqvY5x32mmXqEoAeOBtxt6FEF2YnDhb42ANl7jYMyxXvaP7ReuS+NM+pVhasabmfTqnZFeN4BTJ
 BNc1JObmZ/7tm1q6zhSB6ZuzfGwaX9qT2n/7TEsY4CyRfiy2TN24geV3as0YBvKiI=
X-Google-Smtp-Source: AGHT+IHa4FTj6BmGOoQuDzl8OvqSsqgMeMvccKPUuNEitISvstMv1dK26MTlk6IbLzYgH6WCryjFI7GLUqHQcES41wY=
X-Received: by 2002:a2e:a551:0:b0:30b:d562:c154 with SMTP id
 38308e7fff4ca-328077321a5mr95133881fa.19.1747919193724; Thu, 22 May 2025
 06:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250520085436.925901-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20250520085436.925901-1-dario.binacchi@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 May 2025 10:06:21 -0300
X-Gm-Features: AX0GCFvsJ1qCPNxSFqNX0fXDoi1EyviEIB3jI6CzJ7S907UmDy9AhcCwlB2Y0PI
Message-ID: <CAOMZO5A8-7-KfnVaFpHuEJsnHc4xO3re_LChVp=gppR4kE4pKQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Restore imx8mn_bsh_smm_s2 properly booting
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Sven Dembiann <Sven.Dembianny@bshg.com>, 
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com, 
 Simon Holesch <simon.holesch@bshg.com>, Anshul Dalal <anshuld@ti.com>, 
 Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>
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

On Tue, May 20, 2025 at 5:55=E2=80=AFAM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> Commits [1] and [2] broke the booting of the BSH SMM S2 board. The
> patches in this series restore proper booting.
>
> [1] 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
> [2] dda454e933c6 ("serial: mxc: Support bulk enabling clocks")

Applied the series, thanks.
