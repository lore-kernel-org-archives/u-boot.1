Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F837CA0EF5
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 08:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B713F80FA1;
	Tue, 19 Aug 2025 10:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OK1BHHh0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F83881FEE; Tue, 19 Aug 2025 10:23:49 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F284B802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b47173a7e52so3148760a12.1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 01:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1755591825; x=1756196625;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UOqRulCt8XJs7JPve/y1gSvWGlhNGCswAPsNldK5UAU=;
 b=OK1BHHh0RkjSGcGihIThy6/re5XlzHqUs457ydiIZ6922U9Hr5D8ee65jJZJCxe7k0
 WhqUqMAYDzg8RA7BzNv0dGAkJZs/Fi8yCCVXNAN6arLzG7oZK8EV9TIRCY3hHKgw1fjq
 6YIIxkOPtsUpzU0UI9o4uJ46Nk0Eq0qlmtu1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755591825; x=1756196625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UOqRulCt8XJs7JPve/y1gSvWGlhNGCswAPsNldK5UAU=;
 b=DFb2TlIU+psjUKy2mUKqUGJ5DqYU02dFkQ2tXLO2Nb//LNZwcXr03ZeSx72G6V1i2F
 0fYJ5GI/laHSUzmwvDwrux+d0MlTdJ1SaddURNMlInbbpvoZ9jaDd2PXtpNnT9XVqK+X
 tDOnZATafLCa5rc892HWLoqmNLqDl5XAgytdeDFESBnt9MAxBR6A7SpZKlyjTKRxq41U
 waNYca4hC0d4Ndn+WvyeqOymf4tjAjPSDaYlQHHF+74GimWSg0HllnPpnC4pNqa1BcYS
 l4+Mry+F9r04/iOS4n8jYA2A5OPtTVxL2gDxeaKuGxB89qBa1dg1+807d1E9j30Q1WE2
 9x7g==
X-Gm-Message-State: AOJu0YzZd/8IMtjtYgYOesfNYnidaC+uD5nngDE2SVTAGy2t2s0nIOPw
 eyTun3+Rny5Az8pB6ILZMUPvxzn2/8YNf2h+sVyNEIC/UskYqFmkaI0NJjUCK85EtycUE5zXyRW
 dIviI39HBonsKC3QzSKI8fnQH2O8v35rXsiEl5Fvzxw==
X-Gm-Gg: ASbGncswPVPISqaNDbtA3Rc3DeUkgkpbLKV6fqUnryQ6A1Saz9fSR/kqzoVNIsIOR1k
 tTFLWHn9MtQpOEdj8VmvaW5uOXTuZbvOS8DurdxY+Bsv17iuQ4k7HP2HAT1P5Mdc4mI69utSb7M
 GxU+ank236fGbG9zrOCV/DI33aAN5iPtvXGIxfcZ5Hg6vlH1+dWsm+tL8KA743MK6D9cXvxgkF7
 Ap7Eopn
X-Google-Smtp-Source: AGHT+IG74HNtVdXpjfvtN1NNmwU5X6pCgFY157WXuUpkiMUGrAPSGA0/uG9ouZP5JqHN1WdV8JdKM7jLl3ts9/MguFs=
X-Received: by 2002:a17:902:d48b:b0:242:e0f1:f4bf with SMTP id
 d9443c01a7336-245e0309764mr22415435ad.18.1755591825227; Tue, 19 Aug 2025
 01:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250819071636.25197-1-dinesh.maniyam@altera.com>
In-Reply-To: <20250819071636.25197-1-dinesh.maniyam@altera.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 19 Aug 2025 10:23:33 +0200
X-Gm-Features: Ac12FXyuONOWnRDHygw8C3qOE34MTiLOFP3FBB2VXFvr751Em-RIgugME7iPSyw
Message-ID: <CAOf5uwn_ne64ydAOCvYe-=-FJgk+mXxMF1+m=J65=C_ByHN6YA@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: nand: cadence: Fix device assignment to avoid
 warm reset issue
To: dinesh.maniyam@altera.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>, 
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>, 
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>, 
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, Aug 19, 2025 at 9:16=E2=80=AFAM <dinesh.maniyam@altera.com> wrote:

> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>
> The driver currently does:
>     mtd->dev->parent =3D cadence->dev;
>
> This works in Linux because `struct mtd_info` embeds a `struct device`,
> so `mtd->dev` is always valid and its `.parent` can be set.
>
> In U-Boot, however, `mtd->dev` is only a pointer to a `struct udevice`.
> Dereferencing it before assignment is invalid, which breaks the device
> hierarchy. As a result, consumers relying on `mtd->dev` (e.g. partition
> parser, reset and re-init paths) operate on a dangling pointer. This
> leads to failures during warm reset when the NAND device is accessed
> again.
>
> Fix by assigning the device pointer directly:
>     mtd->dev =3D cadence->dev;
>
> This matches U-Boot=E2=80=99s device model, preserves a valid hierarchy, =
and
> resolves the warm reset issue on Cadence NAND.
>
> Fixes: ebc41cad ("drivers: mtd: nand: Add driver for Cadence Nand")
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> ---
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


>  drivers/mtd/nand/raw/cadence_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/raw/cadence_nand.c
> b/drivers/mtd/nand/raw/cadence_nand.c
> index 27aa7f97a45..4771440d1de 100644
> --- a/drivers/mtd/nand/raw/cadence_nand.c
> +++ b/drivers/mtd/nand/raw/cadence_nand.c
> @@ -2196,7 +2196,7 @@ static int cadence_nand_chip_init(struct
> cadence_nand_info *cadence, ofnode node
>         chip->controller =3D &cadence->controller;
>         nand_set_flash_node(chip, node);
>         mtd =3D nand_to_mtd(chip);
> -       mtd->dev->parent =3D cadence->dev;
> +       mtd->dev =3D cadence->dev;
>
>         chip->options |=3D NAND_BUSWIDTH_AUTO;
>         chip->select_chip =3D cadence_nand_select_chip;
> --
> 2.35.3
>
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
