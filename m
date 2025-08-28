Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3147ECA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 08:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B6DD831D5;
	Thu, 28 Aug 2025 10:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hMSb37dv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 079588323A; Thu, 28 Aug 2025 10:40:06 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3AD2831BB
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 10:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-61c4f73cf20so1213634a12.0
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 01:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756370403; x=1756975203; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ubbkTN6UeFJ5xpalinjjOcJuL7cS5QTCorcR5ozyDas=;
 b=hMSb37dvyJ3vC5ojK0/MntsMU6b3fERsLn+Psbt4DrNI84BgBp5SQIZ5XZppHR/I3m
 G52apaLD/udhFEZFDUMPRrg9NcvBPUbCuT8UFouXfB3cR/6LdzXLYEGdrnHwSYNuhQed
 4tRNiPAD/EsbI+XS+BkIrwKB4SloO53ptSoG4gZEE7JfsCwEdpOA/kk3VM8wjn3+Q03L
 CryIa7TvmAfOAma5t70Q/fh7ixxW4wY4enOj0C/DhhevR6HzNBQgrhuMBFe1wGe+hFV/
 cQ2XfT8QJTx7nXDnKxEaprcDJxxy8aRySTa43JjdjhECV1A8Q2/KRHt9wr5WJ2mzgBmD
 JW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756370403; x=1756975203;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ubbkTN6UeFJ5xpalinjjOcJuL7cS5QTCorcR5ozyDas=;
 b=Fjp9YKUHkNq7VoSPR0hwOSNv6SVulHYpcgeucZvUB/vXT3TOWyxsI9KIdl2Wd8Xclo
 7BQ+N/amqGBCOs4AFWIUjOaUMbzANuVPTYQN1qurKr3Q3FbHFkX4BxJg149SGJkexaVW
 9up9TVgzHostS1yS7AJwRpMyYjYWDfbyeCqlqdzeaJidvDGlq0+WimE1fhuYKGxsZfjH
 fHtGBCmBrnaHGTjVdVUquW+7y5snbsylx9Tl7FIT+B/lUQK70YQsnk5i5Tz5zUV+A/PK
 4jHn9YxC2CKM5JK/9rYhHd5ecRzUd7K5QzB9U/eORNPsvQeC10BI2p4xC9neGKlWHtZN
 Rv1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGXcdbNdpU6Dz4LcZ/HKZwjCCUzGesgNAWutc7uivJV0ukvIG733VV/TYrliGifYx+4V2M98k=@lists.denx.de
X-Gm-Message-State: AOJu0YxgSOjXNX3l+0+7x1hqpX5kUMwmVWS9jQUR/LOwQmrxHPCpIg5g
 qHfHxdf6A9TkXEcc8HyP5jtVT6SpLfX2NygVqJhWv+0YNyBSVZwbndwp4ReFVAS/tLsw8bMszIf
 sSHDVXCI2i8M8uDjlSaDUp8cKVI+sTEg=
X-Gm-Gg: ASbGncutJOeiwzvA+LDx/qV5ye+/HKb6hdexj2DyetU2Dblha6uSTx7QkMfRR2f6o5S
 aYDXsDbWwtwGnOxQBh+UO07Z1yCyTPU8eOC6p1NMH32CFj2nzfjjpd1L9AVSyHIsH53De1f+Y7Q
 9nIKN7WLKlUpFry6nlHssEV7WUQK71pnGpSPQirtjMkDK8x1SEh3T+RBIkEYpTwG1HdM9Yab0eN
 fjHEfsmlLp0sqGkxbz1GYfl8XYcRu2sRKI/k5SoWq7OITu3eYqMeT2R
X-Google-Smtp-Source: AGHT+IHQpE39mNKC4tKCIzE63wy0Un9yJm5erS9Y7gglXF4UurMLIKI6uoIxs2GXSGRYCWHIfGhrzqmDYcVHr8DvYt4=
X-Received: by 2002:a05:6402:3548:b0:61c:bc9c:311a with SMTP id
 4fb4d7f45d1cf-61cbc9c33bamr3753677a12.31.1756370402659; Thu, 28 Aug 2025
 01:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250507005325.15612-1-andre.przywara@arm.com>
In-Reply-To: <20250507005325.15612-1-andre.przywara@arm.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 28 Aug 2025 09:39:49 +0100
X-Gm-Features: Ac12FXzGwXrG_EUZGXFMpIooRqqA1QRobqJtFESuKtRBL-nBoezZIqxx80_7HLs
Message-ID: <CALeDE9P66r+2QMD+y1YCpT=sapZZ_JvmcoBE3d7JJyrme0Xqtg@mail.gmail.com>
Subject: Re: [PATCH 0/2] sunxi: A64: enable AXP driver support
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de, 
 Sunil Mohan Adapa <sunil@medhas.org>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
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

On Wed, 7 May 2025 at 02:32, Andre Przywara <andre.przywara@arm.com> wrote:
>
> Hi,
>
> this series enables the build of the AXP driver in U-Boot proper for all
> boards using the Allwinner A64 SoC. So far some static PMIC rail setup
> was done by TF-A, but this was rather static (enabling too many) and
> increases the code size of the rather limited BL31 build.
>
> Do this for the A64 only first, since this uses RSB consistently, while
> the H6 boards are undergoing a transition to use I2C.
>
> Please have a look and test!

For the series:
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

Tested on a Pine64+, I enabled CMD_PMIC and CMD_REGULATOR and could
see all the expected details as well as in the output in 'dm tree' and
it boots and runs as expected with Fedora 43.

Peter

> Cheers,
> Andre
>
> Andre Przywara (2):
>   sunxi: A64: enable DRIVEVBUS support for respective boards
>   sunxi: A64: enable AXP drivers
>
>  arch/arm/Kconfig                     | 1 +
>  arch/arm/mach-sunxi/Kconfig          | 3 +++
>  configs/a64-olinuxino-emmc_defconfig | 1 +
>  configs/a64-olinuxino_defconfig      | 1 +
>  configs/amarula_a64_relic_defconfig  | 1 +
>  configs/bananapi_m64_defconfig       | 1 +
>  configs/orangepi_win_defconfig       | 1 +
>  configs/pinetab_defconfig            | 1 +
>  8 files changed, 10 insertions(+)
>
> --
> 2.46.3
>
