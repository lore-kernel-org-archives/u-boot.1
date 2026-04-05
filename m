Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A8EE64016
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 09:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40FC480433;
	Sun,  5 Apr 2026 11:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BNmVY7h3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CD668394E; Sun,  5 Apr 2026 11:07:58 +0200 (CEST)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40FDC80325
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 11:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64edf260b49so4278779d50.0
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 02:07:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775380075; cv=none;
 d=google.com; s=arc-20240605;
 b=O/7Itjd3Sn39mcug03VZ7gQJ0lYQFYasUoCRyuW4yTE6wwb32LdTKlxCXrU0lTNav0
 4Cpm9deGDbOD668ELcWQNVnf3ahQSMAlNCIJ2dPZx3U+KwVj9ctlACa2jW5vfhEWl6NT
 0JHKLTaBnS92pZNKwK1VVUJxyeBGycTWpHXNn8yVXigz6YehCnec7dtgUjIG1yFibqa6
 i4nW2cw1TeJoQK/XVQjyQEQMbZvcwrnGH0RgySqbCjbNMUVvKPrR+SCsyNVbsfDA/06g
 0oUVP+HNiZ8T1xJu2R1E/t/yuK/5g7SmFms9epfPNO6VpyyYAvhLyoEE9KrZIYMr70fg
 trJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pOQ5IBp/zyT384jIiHe5HJ+Rm/jje6D65RyLH7+nT1w=;
 fh=BnpnyMJV8JwsLeyI2TPSjexZl4eVT43xfeL1DZOEHq4=;
 b=SkLNQQvtfLdIm2gO9eAUTrNrzpMx6L7h2UJmLKK+fWp6lJIdT8bIukA61tZOQR+jRo
 JIzpMEQe01cqQi8mRRJ76eLbguiecSDeRGieL4t5B7lDdceH8//SCqQgWEhHnp7VnW6x
 uwF6ZGx56dP63TZm/me3Whcjjpz0EZwgbBikdz44erltXkF4UnYy1icDlN59q3HzO7oa
 1O+lWhUiNua3JhzTqweOwl8wB6+HmCO2VMRxONoStSlsgdvp094ZcQ3nSDuwFfLIqtMX
 3zKjKY2COZ6bSO4mrWQCZwTL2hEFyVWVsAgq2vNyIxAkXAXr80QxUISQ9Yg2ZyLuX2KW
 pHlQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1775380075; x=1775984875;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pOQ5IBp/zyT384jIiHe5HJ+Rm/jje6D65RyLH7+nT1w=;
 b=BNmVY7h3aobJFkxla/J+1i0qu0u2SkzszsoTPtIEVFnyKW8zjoB625zl5JYeYapxPB
 WamwjgEmOjYKG1aEfXinageniU1TMdS5N5uQvdfr6K0ZNJkkbwJObPMt+eCCRNmNfsg5
 +c1r7zHU/hKWSujf1NUtkqDEIZ0NfCL87f+do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775380075; x=1775984875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pOQ5IBp/zyT384jIiHe5HJ+Rm/jje6D65RyLH7+nT1w=;
 b=mDOKpcKMs+dWqKXb4TB34SS23u5S6WbB9Obm9Uzx7mxHpqn7QIcaQeeWtA26vlCIaQ
 T7D/dFNmvWwV+Q0xwuojlBwSkiu6/Txqjv2i2CTYozg9oVQS1hTAm+XqSHXLq70oz0LM
 fTJdqn2uaXLXHfCTugUjVR4u63VsVoLtIIUAMSnoylRh86AE34PyPU1C57JwutqV2W2z
 xPxsqqK8c+l+DnCqqknfmqfQsZUJD+nHQ79HzI/u7t0b567KfMOcJQF7SCSEydP83GSQ
 5gT8S6443q/EPZZYdPdFjiJr5jkSJYtErKRKixf4fkvLx22Dow87MbU+Cf28LEf9Ry1Y
 RIXg==
X-Gm-Message-State: AOJu0YxAPnycukcw32uRgIDphsSdvCYq+aLAEGhc6Tcdgf4dYFCkkNSb
 Ii0tF0ABcHLBH6bMwqEarj7bW0x4PC88R8t5LPNZR1Bq05YVSqYE+A9DXPiznxRD7b4zhuWX2Vm
 jBJr6XgtgV34L+D5mjCVMyvPjrQL44aLVGmJ6GfWP/A==
X-Gm-Gg: AeBDiesPH1bqfgLyz7WAXacE7umPY6V67GJrGFaM4YU3wfAA5HaiwJo9/FLx1f6ULG+
 4Qh6YHPgtihEcWW9R3Dpjg9xNMhjNeQmJGnjV+f7wDQdoLXQs8tcqtdVmKI+UdYvQgWIPx/jdM8
 Fy6+HKqKbtqvDA4WH6EG07YayItXchvkYQ+NsksfXdY/jWSKVyNVTCe0xaEEnpPcFCaVYxGiZ1J
 9xw+c+2dJ1yZi63TNqU8nj2pVXhSCDlPtLB68PeYqmHDjZkLgaI4Xg10/ElOG29fJB9jaqo5pA2
 qDj5u3uEcwj6fIIRwhE7w/Vx0dqHjIfg2vTi
X-Received: by 2002:a05:690e:140a:b0:650:1526:7e80 with SMTP id
 956f58d0204a3-650480bce33mr6486493d50.19.1775380075017; Sun, 05 Apr 2026
 02:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260403-winbond-ma35d1-v1-0-e2b08c4c5e35@bootlin.com>
 <20260403-winbond-ma35d1-v1-2-e2b08c4c5e35@bootlin.com>
In-Reply-To: <20260403-winbond-ma35d1-v1-2-e2b08c4c5e35@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 5 Apr 2026 11:07:43 +0200
X-Gm-Features: AQROBzDQ7gsucnTzOc1iPe2WQKnC68yBYw6ZwzcycAzjTCcIWfEXljEr6tnCDnI
Message-ID: <CAOf5uwnSm=yEwsDt2sm0L14Qd+ypbxMiuW4Oz2xg-UL_GQAAfg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mtd: spinand: winbond: Add missing QE bit on W25NxxJW
 devices
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: u-boot@lists.denx.de, Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Steam Lin <stlin2@winbond.com>
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

Hi

On Fri, Apr 3, 2026 at 6:17=E2=80=AFPM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> These devices have a bit in their status register to enable the Quad
> capability, make sure it is set when using quad mode.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/spi/winbond.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbon=
d.c
> index a89aaec516b7..79c3354efb65 100644
> --- a/drivers/mtd/nand/spi/winbond.c
> +++ b/drivers/mtd/nand/spi/winbond.c
> @@ -398,7 +398,7 @@ static const struct spinand_info winbond_spinand_tabl=
e[] =3D {
>                      SPINAND_INFO_OP_VARIANTS(&read_cache_dual_quad_dtr_v=
ariants,
>                                               &write_cache_variants,
>                                               &update_cache_variants),
> -                    0,
> +                    SPINAND_HAS_QE_BIT,
>                      SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
>                      SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg)),
>         SPINAND_INFO("W25N01KV", /* 3.3V */
> @@ -458,7 +458,7 @@ static const struct spinand_info winbond_spinand_tabl=
e[] =3D {
>                      SPINAND_INFO_OP_VARIANTS(&read_cache_dual_quad_dtr_v=
ariants,
>                                               &write_cache_variants,
>                                               &update_cache_variants),
> -                    0,
> +                    SPINAND_HAS_QE_BIT,
>                      SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
>                      SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg)),
>         SPINAND_INFO("W25N02KV", /* 3.3V */

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

>
> --
> 2.53.0
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
