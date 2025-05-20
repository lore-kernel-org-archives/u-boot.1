Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D4FC3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 11:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE15382B00;
	Tue, 20 May 2025 13:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ek66BPvF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3722E82B07; Tue, 20 May 2025 13:55:08 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E08482A8D
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 13:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-551fe540b74so663777e87.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 04:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747742105; x=1748346905; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+lXJwqTmoZIi4uqtR9CsiLNBdAWY22BW4K75kS77Pc=;
 b=Ek66BPvFZ9ubT9EbrTexKS3fQe2N2suBW7m3Pha9VB+E8juXzS+oGIUjAVZdHP910o
 SxHLMWO6g/jZl5t1orm6Ddupc+PSG7MVDkpDIjsy5O89CEPZNFvRaN1PXJ1EedXG/l8P
 Ncs3X4pk22/gsYPQdmQBlWUeUR8k76dWOQVRh3Fs3vIY8k5YcTaodI0XOknyhFMK1E51
 oTxczc0UsvrOb+GDKD5vhvTB32yeWrt58jHht40gLBQP13xNhCBELvudfU+q7ABEvlTY
 S+PMSwnQNaQ21e11eEc11CfL2/kL4FIWpirmvYoU58PF741OsapkU8Htscgtsab7gawf
 GONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747742105; x=1748346905;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+lXJwqTmoZIi4uqtR9CsiLNBdAWY22BW4K75kS77Pc=;
 b=OVtF/5FNtisfn4THrJ2IuDQim3RcBuYrmf3LJxAQ8Xq0NEyGMjlTDYd4eiNM21WS+x
 N13huPQVTNEXguvoFnm3fYEHkfY++byRMJ04bX+ByN1TB8GMzKP2KKpvmfcdwSW0jx/T
 I+KH/n6+VmpzDq+7RTrkYlvN6k58W5XWkDH+ZRYHcWPm3UT8YVg03YUrCajTqKhp1OEA
 2mdwPE/FvLv3jQo8ZICRux+q+wq+bS8hxTKD1s0kDV6EPVV9beLq89hYvFexj0xHbVUv
 yEzOgMzZLULj4X7vdIwTnBmtrvu/CuasSQCFW5S64xw46fMehWGqIlt4viMFLLhlM//U
 FTbA==
X-Gm-Message-State: AOJu0YwRWZvFOR8ogxFqigPwTyWXnv/rB8apRPqjYBmSn9EVXNzce970
 WI0j9mlJGWOfALsXtN4qgyjhWxeTuWUIZf5Md/H0wh45vT68CMVNPkUnMWIhE9wrCYrGIYiAinG
 r2W0XSLG7naXNyLDJwuuM0EVrLcSk3oA=
X-Gm-Gg: ASbGnctbIN1EwXOzePC9tdBrRK8ujdOImv3BAoDx4IhP1fPIva5m1N/y5R6tA608YBG
 VT3DONhcUtjws5dGsRLn84jxC+cGZOTIIGEHrgKkQyqY3bvNs1Essm6NAF4E4GhBeQiWdCONZIe
 q0kmHldwRD0fQsKSZCMN+V4NI+fBijKqRccDPbGiaaNysXTemPrGb3doG1SaFSSW4=
X-Google-Smtp-Source: AGHT+IHUvoh4A4QdkofbwIv5hQIzKiIcyyHOBz1mYZRbbRP5PH8u1D/eOVTnTV05lC+TvOw1zne5xa4dwo0mpMsF6Ow=
X-Received: by 2002:a2e:a9a5:0:b0:30d:b3f3:bcc6 with SMTP id
 38308e7fff4ca-328096dd6aemr59238421fa.21.1747742105176; Tue, 20 May 2025
 04:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250513163633.1803464-1-dario.binacchi@amarulasolutions.com>
 <20250513163633.1803464-2-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20250513163633.1803464-2-dario.binacchi@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 20 May 2025 08:54:53 -0300
X-Gm-Features: AX0GCFtb0mdg4GM2NfOtKnj2Gul1xeFGG-_92-mbcAwOYqMrj_rGYN86wIk9aek
Message-ID: <CAOMZO5AW1QuWKmj+OdbpU1NP6sLduTTuhDZ98CWqfMgUGTw9rA@mail.gmail.com>
Subject: Re: [PATCH 2/4] board: bsh: imx6ulz_smm_m2: Add support for 256 MiB
 DRAM
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Simon Holesch <simon.holesch@bshg.com>, 
 Wolfgang Birkner <wolfgang.birkner@bshg.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Bode <michael.bode@bshg.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Tue, May 13, 2025 at 1:36=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:

> +static const struct dram_cfg_param ddr_ddrc_cfg_128mb[] =3D {
> +       // IOMUX
> +
> +       //DDR IO TYPE:

Same comment as in the previous patch.
> +       //read data bit delay: 3 is the reccommended default value, altho=
ugh out of reset value is 0

recommended.

> +       //Lower RALAT benefits:
> +       //a. better operation at low frequency, for LPDDR2 freq < 100MHz,=
 change RALAT to 3
> +       //b. Small performence improvment

performance improvement

> +       //MDMISC: RALAT kept to the high level of 5.
> +       //MDMISC: consider reducing RALAT if your 528MHz board design all=
ow that.
> +       //Lower RALAT benefits:
> +       //a. better operation at low frequency, for LPDDR2 freq < 100MHz,=
 change RALAT to 3
> +       //b. Small performence improvment

performance improvement.

>  static void ddr_cfg_write(const struct dram_timing_info *dram_timing_inf=
o)
>  {
>         int i =3D 0;

You don't need to initialize i.

> +++ b/board/bsh/imx6ulz_smm_m2/spl_mtypes.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2025 BSH Hausgeraete GmbH
> + *
> + * Written by: Simon Holesch <simon.holesch@bshg.com>
> + */
> +
> +#ifndef __SPL_BOARD__
> +#define __SPL_BOARD__

This symbol does not match the file name.
