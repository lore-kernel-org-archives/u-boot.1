Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFE0D5CCAE
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 13:32:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0D5188C8F;
	Wed, 30 Oct 2024 14:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kpi2FIP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 959EC88FD5; Wed, 30 Oct 2024 14:31:59 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D75288BB7
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 14:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-539f1292a9bso7929898e87.2
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 06:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730295117; x=1730899917; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hwo4LRr6xQo4IMYrpohsQY2Pw1UOcsgEmKAcGe1W6rI=;
 b=kpi2FIP8lGX7qe/2y5GKP25tQsiJn66C3GsTJWZ75uTv415cQSiqSUIYJZ7y4nSG+p
 gGAY+0wWVAR18wsBl6S/EcVM+Qei59E1LCTKHuRZeeJJRghKhwM5M5XNNiIrG0bGZkN0
 MAWGmR/kBvHve2L0+zsrDsvLfvjxKgLvu+fO5zJ8r3wsKukE4cxrNWnIAM9GQWXNjUgZ
 QOLusSt0K+5AoFRzJCr/i7tJGhr72ukCJXn1e1vDD/4CxCQOY6StcPKiWteBQb5d8N5A
 iFU+LL9p44KIx9ly03ILo8ANtbWDZ+r3+C7YCs8+JMP6A4JvVa5qNRmBoShSNLH9hBTD
 NlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730295117; x=1730899917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hwo4LRr6xQo4IMYrpohsQY2Pw1UOcsgEmKAcGe1W6rI=;
 b=fNQNQOLPgwvthM3j1YZkBRDRpQl8CsbXc+Q9vMtY27YtyE7hm9hyseCeZlOBjK4jPi
 FHT+kduPoaK0yurMJel6TUOCQ4BEondsRD2EbdYhRoSDC7tAcMNyWgUkEWMVWp11F80z
 0i5kVhYAlE1oO4I9PY0tyNHEft4quEXWczmLwgq/InsrKLqmTMf7NpqiHoMXW7vBTUSx
 0hdNckdVJQ20WRokE37cptg9vrK1XoLiLHpmVEWQZtl6ngzQXhONgx99KHuWbkLTHllH
 dGSu4VANn+cMVDEpzsUXCi6tMXaY2GevS32i1MwdgDWX0w1rTmW3aHSy79VdDsiIsUkm
 F8/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz27ogmTZsGuuDwyI7KsrdzhfJYmxMAFG/rH5EGaaIQZu4XsrpI7S3P0UZbgG54z0sjbeDcdQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzVk8Ti5uQRqvR7KA7AQkTQ7JU5VQnWPEGVpQ11ZYmSXKVhElcC
 lPxWbcQ0FsQN7g+CmwitqNUxmQB1vn6WkBs3ZJjUAp7lkwmWid2L5Q9tIV98AX+rMwXZtPyHkpg
 TZ4v+1uhbcAxXHJ2TpDiedHjCx5tgXQ==
X-Google-Smtp-Source: AGHT+IED0bT2gO+ACogdeBc2/iqKixwyD98qj6C8VDEOdGacZMCsR2BjQBFmjCfcylW9NMB1TZy6k13tWpOXP3P1Xd0=
X-Received: by 2002:a05:6512:1082:b0:539:fcf9:6332 with SMTP id
 2adb3069b0e04-53b348e554bmr7954440e87.33.1730295116538; Wed, 30 Oct 2024
 06:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241030110221.3321315-1-tudor.ambarus@linaro.org>
In-Reply-To: <20241030110221.3321315-1-tudor.ambarus@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 Oct 2024 10:31:44 -0300
Message-ID: <CAOMZO5CmFGgrhHX43T_K_bnJdV0xqp_6Y=oJra6v9TgX+bkJbw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add tambarus as reviewer for SPI NOR
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, marex@denx.de, 
 trini@konsulko.com, u-boot@lists.denx.de
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

Hi Tudor,

On Wed, Oct 30, 2024 at 10:18=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linar=
o.org> wrote:
>
> I'd like to get Cc'ed to u-boot's SPI NOR patches to help review them.
> The ultimate goal is to have an aligned approach in u-boot and linux.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 38c714cf46..df046192ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1604,6 +1604,7 @@ F:        drivers/mtd/nand/spi/
>  SPI-NOR
>  M:     Jagan Teki <jagan@amarulasolutions.com>
>  M:     Vignesh R <vigneshr@ti.com>
> +R:     Tudor Ambarus <tudor.ambarus@linaro.org>

Your help is appreciated, thanks:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
