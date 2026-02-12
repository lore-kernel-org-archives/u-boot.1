Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210C0EEA84B
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 18:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 324758367F;
	Thu, 12 Feb 2026 19:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jU0CRngb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEFDA83A47; Thu, 12 Feb 2026 19:36:33 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30E7583015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 19:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-3871017fea2so10331201fa.0
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 10:36:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770921390; cv=none;
 d=google.com; s=arc-20240605;
 b=g+VOVXrwX8S5et/Ao2rv0Dn/SMDOtNLsFM5wSbknULb/ncrx8c+o3tQNFd1jC7zIDZ
 VB4XCweMkOrebKqUEudVQ2p/5fd0scSHu9fygEuQpUj1OXlOdCOCENbYgW9a1Rpbcmjs
 sb//O2smU2Ut6PX9gNbIKGUl7PqekHPNzvVQNg7XwwF2ZlW9Pfn8xiO848woTIw1QeMv
 ZrJTTFLw2sclmPFQGdpIAAuwAw21cc05jI/woJwU78YXMJYgIFJZWo4F515EH+KrP4mY
 U3MEoyTm35vda1OkLyuzhe5NCz76J8POCTkiVJ/dSq3T+ObLbxFdgmAZrttgIerL6Cyx
 vibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M4xB0ODEudeHvgjuAGeFXPTX8gscyPACRdmOA1I7qWI=;
 fh=W/BMFDlMVlIRZKEDeRaCE+Mzoqg6SH83fTjjOSD9pyU=;
 b=jHJGUBPqk2kVBEpNwHiBvrpyXgUPqFTk7HF9POFFF+HdCZL6zTpZSUqAr42ybgdNfv
 cnd1h5paGQSEh8Qv9tCJear/TTW6P193IqmsSwwBnNkk/SefPmSVv6O1rKsXB1vOuR3f
 Tg+AfpuZML/fexiCu94NOQ6+N8bIqsP6i2nYe3Te7dgV0jAeAn7FjVhz6VxZ5pTpt0z5
 hOObDdFXlyChj39VQyKicmjUxtS2r8BJ2ul8d+lnvJe9buVvtD0j+T3ZKChsJCnkynBk
 2x6vrw2gN2Xg6fDlVqDj0FyURvH8j7jhABKR/RAMEeunli1cLsF11ddygvNi8+yLlVuk
 idEA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770921390; x=1771526190; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4xB0ODEudeHvgjuAGeFXPTX8gscyPACRdmOA1I7qWI=;
 b=jU0CRngb0Sqh95Gf+I8venYv5Q/ft3V6XXgm2sbbEkwCJGTpoK6XPcdFhz8PHA5d2n
 RvwE/sB8BLPIE3t+Whrgw+tBRG+EHpm/9xvTMHs0jCCotfWY0zS2Ay9rED6qlWmpSOGP
 MSfrcwhTKJ1f1KOotOJhg3gzgu9JWtADSmHgVK7ZtPmhizFHERl7vYkckPxFjsMLL4Cs
 EnfQNq1oAxPDDFr9bI5g0zCjMuEp35TDmrOa9ck3p7hXEiwVrqszchG8OlgGIDqwVr20
 On8GZGTmF0O908zjDrBDugYs865haMHd2Dje3dM9Hml1WMsUy9sk4LzxmXulqKqx+GE1
 6krQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770921390; x=1771526190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M4xB0ODEudeHvgjuAGeFXPTX8gscyPACRdmOA1I7qWI=;
 b=VR+fd38TQt1VAN8sMeGBCF6Agz06VvUAvbiMRALGJObiAooYUAy0BFb8Nc2IK0Fs4u
 cgnU3hO5UfY8i02pHRQioRvPCiImCKZApCHqxANMEUU20BrOzYA6h0p7VGJPjNnMMhl1
 eki2AnCkY5ieksRsrSOrIFrBMlJRXEuQhzJDR9DZUEk6BmDF0qpSHhamq8hC5ho5fhnk
 RtINAmo35fdZE1mVc3wPdL6WR7kQNRQmHk1K6Xxws58fOIgKukTYWktv6pm5piCIX/lh
 mOorxoSaVaB077th7WXjC4IHWMRIjZsKn0LCwOVH3mGTNkE6Sa6/OGmIPDRjypfFYNFi
 GFsA==
X-Gm-Message-State: AOJu0YygaMATAzKQWomLpe1u37yVC3DHrZfB5pizVvrjxkbwXuoXVR0i
 Q+ortyZX986IGzdNTqkBf5MKVjhGhnarRgo+G7AbQBNM3J9M8MqowR1DEsLKYiJJfp4VUU5U9cx
 GBnsC4+8hZCYGw8lnrLlZMxNf1XekMaI=
X-Gm-Gg: AZuq6aKH2FNHnQf7HEiEx8TCumA+XB1kThWfrD1dY6+EhC3WDIDjSN49YbQZERhDP7N
 jwt2u2iTBkDUPu8rY4gn1xshfAJBzgfH3+2jChbNzlgBSAShrreXD7bhJqKQFmU+vk0zm2lvLR2
 B/mMJbSASZv0QBU+mtqaXe1p0LPZ34t4Gs+qgLsEZ2JD3QjfKGyJgLLZYwjCvER19+6JIIxcdvk
 bmL0FxRFLrDppUoOqf9sngbweyzCI0Zv6s7x8oncsBwB0yasC1Ag2xpqiYdSZy45SMTz63wFC6j
 xpEUaGl0fwwAQpy15iJE2lWL3929Oloovf4AN9t3RLaBwY+47VBb+BDaA/D84SC92nP+v1o=
X-Received: by 2002:a2e:a016:0:20b0:385:beb9:dbfa with SMTP id
 38308e7fff4ca-38711d63c28mr9874351fa.22.1770921390113; Thu, 12 Feb 2026
 10:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20260212-imx95_frdm-v2-0-9a535a506b95@nxp.com>
 <20260212-imx95_frdm-v2-2-9a535a506b95@nxp.com>
In-Reply-To: <20260212-imx95_frdm-v2-2-9a535a506b95@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 12 Feb 2026 15:36:18 -0300
X-Gm-Features: AZwV_QimODLK8KdQ_sl2FIJu_nchv8q1TPGYq4fLcF6z2GUu2I67pVAsgmeEtdY
Message-ID: <CAOMZO5BAe0JYvqdothTunajpbA37K5R7xG6GCOv2MdGK0ohdAQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] imx: Add FRDM-IMX95 initial support
To: Joseph Guo <qijian.guo@nxp.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Lei Xu <lei.xu@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Ji Luo <ji.luo@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Justin Jiang <justin.jiang@nxp.com>,
 qijian.guo@oss.nxp.com, xinyu.chen@nxp.com, Jacky Bai <ping.bai@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
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

Hi Joseph,

On Wed, Feb 11, 2026 at 11:41=E2=80=AFPM Joseph Guo <qijian.guo@nxp.com> wr=
ote:

> +++ b/board/nxp/imx95_frdm/imx95_frdm.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <asm/gpio.h>
> +#include <asm/arch/clock.h>
> +#include <asm/mach-imx/sys_proto.h>
> +
> +int board_early_init_f(void)
> +{
> +       /* UART1: A55, UART2: M33, UART3: M7 */
> +       init_uart_clk(0);
> +
> +       return 0;
> +}

Can't the board_early_init_f() be removed?

Peng has recently sent a series that removes it from several items.MX8/9 bo=
ards.

> +cntr_file=3Dos_cntr_signed.bin
> +boot_fit=3Dno
> +fdtfile=3DCONFIG_DEFAULT_FDT_FILE

Please see this patch from Tom and adapt accordingly:

https://patchwork.ozlabs.org/project/uboot/patch/20260211221135.1738981-1-t=
rini@konsulko.com/

> +#define WDOG_BASE_ADDR                 WDG3_BASE_ADDR

In another patch, I asked Alice to rework the watchdog driver to
retrieve the base address from the devicetree.

Please work with her and remove WDOG_BASE_ADDR in v3.
