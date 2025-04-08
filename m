Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D9AC3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 12:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A49C482F50;
	Tue,  8 Apr 2025 14:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nBPK2F4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76D0A82F5A; Tue,  8 Apr 2025 14:58:30 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ABF982EAA
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 14:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-549946c5346so6511882e87.2
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744117108; x=1744721908; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gEn+zIYHI7UKE0e9aniKMOsh9mWcMTuVgZzkgFJ0/k=;
 b=nBPK2F4LB5P1qKtc2R8PHndwlKX4hq36zm1jnAXaFGi0TAnO10CyQUHgXKH/qVA/Vv
 qnObWjH5rFyF96rOzr+3K/+h83i2UV0hM+JDEMzMHIJOadAXCUePMmtTTkassgD3PcjV
 Iy8HiK4mvj4kXqRPBEqxtkpZ4t78T0ygpFStSF1e3A+SIW2hE0sQwB5VxPmbY7ht9Jnk
 AGYNqXdY4x+Ry4RrGR38fAB/cuwedfEMSHBUEqBxfd6s+ydq8UZDYE0rS5bAyjg3T/X4
 JpinaxdrBdxcBUGqIMpmRQqY1152Ap2fcYn0sI75pzILr0Y3xJlgjY/9cKA5t6Vqt5oF
 MF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744117108; x=1744721908;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gEn+zIYHI7UKE0e9aniKMOsh9mWcMTuVgZzkgFJ0/k=;
 b=mOIKBOpsG9hg5hIiqIYF4Kb11jbQIWwU4qbX+Owv098KoFAL9FXGKDxnOs9tsDLZi5
 LfeIZkBsumDdy4wQjzfRyREAiv33pQl69xuX9Avs2T9GXXm9hXFYfsSrNk2sm/gyuXai
 W41iD2pHsbgF8WamBgBu9CLpUg6cMZRXpJmu3Hi4sUCraYHgR2i8OcX8a2+X7dBDQ9CU
 Zy2YeA1tHSs5NOtSn0So8MbAkWHzYF1DRrJ9m2DD/k12xYOSek91t2pzHB+4sUKoLSav
 6BaAexQVyZsTN1gcVwRJ5sRc3SpXYL1RcUubHXg9RgviKlzM7c+tmcquWXRWyawzv0ZJ
 R4Xg==
X-Gm-Message-State: AOJu0YydaAHXEO9a0E56gSsvxRWiKNRWKmla3mW7l9nFgIe50JEGe1dT
 owvKvBHQp6MAYsExGbMe98zW+kUDKMK6rSqEpJyMXN97p4iv9uVuXSMNd+16mgsyyvc6rZ1cknG
 hMebx7mZ7jY1Ck3PLsrNz4Aeosb0=
X-Gm-Gg: ASbGncvcKWQLTMgyP1sPYuf1qJYU3xjUWGSJVJmCzDHETUYDq9tqU53ZOEgqDgVtB2n
 qNFhnLCpG0B/DzS6sDdi54bBxmym94sTttiT3gQX6tzb4UofogLfHyPGwgvHe8T4uCLKeOcNtg1
 73yYZdZoXK1y9j8Fqyqw9O+kXNPR9RqpN4+tBlr/bFA4OJFSHa0ctQkdnEog==
X-Google-Smtp-Source: AGHT+IEHQNk/LhaVe/zEJzo3FP7rmuok7ljIDiZrRuyph9QMOp/yMV1pkyE3hAYsqv3O/pK5CNBWNjqY0roWnFnhg64=
X-Received: by 2002:a2e:9fc5:0:b0:30d:e104:a496 with SMTP id
 38308e7fff4ca-30f0a18e5f2mr42925391fa.40.1744117107374; Tue, 08 Apr 2025
 05:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250402003738.1241719-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20250402003738.1241719-1-Mr.Bossman075@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 8 Apr 2025 09:58:16 -0300
X-Gm-Features: ATxdqUEdhLcN8R61SCamYnJVTlx7xcIWsDxhlwiN6z7FRMCQ9qwrurXil7bJBZw
Message-ID: <CAOMZO5AypPzjPBqUX9Lta90mBhs+4xpdqczsqjcwy6JQakRUfQ@mail.gmail.com>
Subject: Re: [PATCH] common: Add CONFIG_SKIP_RELOCATE
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Paul Kocialkowski <contact@paulk.fr>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Trevor Woerner <twoerner@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Richard Weinberger <richard@nod.at>
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

On Tue, Apr 1, 2025 at 9:37=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.com=
> wrote:
>
> Add a check for CONFIG_SKIP_RELOCATE in reserve_uboot to skip the
> relocation of the U-Boot image.
> CONFIG_SKIP_RELOCATE skips relocation of U-Boot to the end of RAM
> allowing for systems that have extremely limited ram to run U-Boot.

Nit: s/ram/RAM

>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>  Kconfig          | 7 +++++++
>  common/board_f.c | 7 +++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/Kconfig b/Kconfig
> index 6379a454166..f518768615f 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -443,6 +443,13 @@ config TOOLS_DEBUG
>           it is possible to set breakpoints on particular lines, single-s=
tep
>           debug through the source code, etc.
>
> +config SKIP_RELOCATE
> +       bool "Skips relocation of U-Boot to end of RAM"
> +       default n

As Tom pointed out, please drop this line.

> +       help
> +         Skips relocation of U-Boot allowing for systems that have extre=
mely
> +         limited ram to run U-Boot.

s/ram/RAM
