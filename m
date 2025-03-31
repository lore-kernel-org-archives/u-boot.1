Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F36C36017
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 05:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19ABE812BC;
	Mon, 31 Mar 2025 07:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WqC74ZDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A86A18144A; Mon, 31 Mar 2025 07:42:25 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB58880F9C
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 07:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso30408835e9.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 22:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743399743; x=1744004543; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IacKPf3NvvKfAhEtEZEWm8BUb9UYeLeSuMfL5GKIHRg=;
 b=WqC74ZDeVy/Q/qB+qdCnX0sOrHc0w7BO5oUs1MbV18mGHAlr30fw526Idc6/kL8bia
 /FPz/1md/MaPcTmkZxCiqc0ZUBvhS2sLF46K3gPdJ/HaiQ1redCprpfdYowldRsWYsX5
 gj6NMfVa6fixyocVwx9YsasGIeV+A1A+kbp6P/6u7tjaP9/mTwf7a09xmaHUxxiH4VWA
 yZjJnsbWzaKIiPVFhrh/Vq0tip6+eV6vvxNOMdkhOZWz6KCV6PaNHYqjviaheQRhzozG
 W1lxLxQ13FiSw8LOx8PDmVEf0x16SpwGEO2nubGMGqw5Hb6pXrWWV5+zyHsusM5VudDV
 l3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743399743; x=1744004543;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IacKPf3NvvKfAhEtEZEWm8BUb9UYeLeSuMfL5GKIHRg=;
 b=n3YR9U+pR7Ix5D2bVNg3+9CuLrRsxsJKsRwbpOP8ZNUp2JPcRN4aNtAA4AFur3IRUB
 FjMyQ05f2pvRublc6SL8PtlSxnybypjDya0v5coLc03KFyBYqH1P/tZj739AgNVUvWOT
 OBgm7feCqkpttUmju8BadLf39fpGRpe9CfOMNwA/ATUffbybEUbOrbFz5ZXre1D1xdiI
 jCZ87S9v2JZKqz8eTdx2hI1w/iDSGUEVK4MwRZQW8xwSdl0yPzeARdW7Lqe7zWxCV82P
 tHcIFW/Xppltgtqa9LNQuhiVETC2+Q5JpCc5pzUleCZfRoHZmumLFGbqJAaf3RS0Gs7D
 g0VQ==
X-Gm-Message-State: AOJu0YyiOSZpW5pthi1goetmuJLigM9m6SsPOPiYyHtxW0DiPBv3LTT/
 E77qp2qcr0I5tU4X4USCwSxDB9I7DgKjdqGAzljaO602e9mHON3xQ3b/CYD/rxj3+7bOfszkRme
 ZnYjB8d8ARpJl/LyxA1s94DpkHgo=
X-Gm-Gg: ASbGncukYiPNA1G0+m5ZKg2sT1wibd01grSOOdAoyU1LWgW6kjyt9Fb89/bmBB+CXj3
 pZr/gUVRGHcVu/9UXd7aXrEQpEnCKlRCey4s8UTdh3/zsmS4PX54+v6xNHkjgoLm/odq2/H3Ilv
 uWH6gpKNc+mDvJ3kWWXiTlB3xefiE=
X-Google-Smtp-Source: AGHT+IExw4s1cY3S0c77qLU9znG68v3RuXn9fT/zr3WwUDfOORq3WMnlBVOCV6BsBLfea6ouCKH53ghafahs9tizlFU=
X-Received: by 2002:a5d:588c:0:b0:391:487f:282a with SMTP id
 ffacd0b85a97d-39c1211d654mr4275963f8f.50.1743399742971; Sun, 30 Mar 2025
 22:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250330192656.1280403-1-arturkow2000@gmail.com>
 <20250330212638.v2.1.Ib55fe26f355e42f7853676779e89e22356bd7230@changeid>
In-Reply-To: <20250330212638.v2.1.Ib55fe26f355e42f7853676779e89e22356bd7230@changeid>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 31 Mar 2025 08:42:11 +0300
X-Gm-Features: AQ5f1JqcrAQb8Q9V2ZzAHb9c1VBk-aJurC3YBPWUrPMxJvIvj9Z26L9V3MYcXbA
Message-ID: <CAPVz0n3f4Op=7A1LTvKyTkeg_Y31wsfMj0SOgtor-TEgEHd96A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tegra: add funcmux for exposing UART over uSD slot
 on Tegra 20
To: Artur Kowalski <arturkow2000@gmail.com>
Cc: u-boot@lists.denx.de,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stephen Warren <swarren@nvidia.com>, 
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Tom Warren <twarren@nvidia.com>
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

=D0=BD=D0=B4, 30 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 22:27 Artu=
r Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> UART-A can be exposed through uSD, this was tested on Transformer T20
> but should work on all Ventana-based boards.
>
> TX is exported on SDD pingroup corresponding to uSD CLK pin
> RX is exported on SDB which is CMD pin in uSD slot
>
> Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
> ---
>
> Changes in v2:
> - fixed indentation of preprocessor directives
>
>  arch/arm/include/asm/arch-tegra20/funcmux.h | 1 +
>  arch/arm/mach-tegra/board.c                 | 2 ++
>  arch/arm/mach-tegra/tegra20/Kconfig         | 3 +++
>  drivers/pinctrl/tegra/funcmux-tegra20.c     | 9 ++++++++-
>  4 files changed, 14 insertions(+), 1 deletion(-)
>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
