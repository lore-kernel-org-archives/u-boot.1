Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF8DC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 08:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BBFB81D6C;
	Fri, 28 Mar 2025 09:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KU3+igOk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11C7881DCA; Fri, 28 Mar 2025 09:27:12 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 110CC81951
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ff85fec403so5983819a91.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1743150427; x=1743755227;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SaLBilISrwmPgW8Tu0DqNxV7m/nb2GWG9OCjrSHCpzA=;
 b=KU3+igOkS/eag70YGf1YpCvPXnatQsn71BfpctIoaHufitTd/88GJP/0AjRQ3Oy/oG
 nea9Izqdk6teRGsU6wi3JsdfHxtycc81eg0kOuROVGNx/n3uHkTlso5XM3e5Pv1SgVjP
 enWYSyJXQ22tJH/tlgxKgl34ba7jpA4C9CGSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743150427; x=1743755227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SaLBilISrwmPgW8Tu0DqNxV7m/nb2GWG9OCjrSHCpzA=;
 b=Rap1t5JOjEP/cWV7ER3PLZ3aw6+BXEeuSRHJ2s3s+PZPhQ7+D4LGgRqG7KLi4zJiFZ
 C41VeUXxbzTl1W01K0fX2ilHi/bk7ukdcPrZ1FFX9munjFlaxKANWus7NOrVHxx6WjsQ
 F3NPL+mORNyHjldsShb1+qgKxXOa9qnsTASjoj4GBtKq8wyWhor6U25+GLcWGbTUDj1I
 0RrDKztemNTdmXhs9DufV4srry+wtr3EhrFYQaR2JHjzd/rSdWZdB8GjR2MLKqzL7i0N
 VYKj16b5x86bEk9Zg91i0o5h2Llvpzwk4EoUCctSLL0NBe7xTHTpVWMUEnawUcD79OV/
 zHrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrv9Vd+/vpz4RCS5yj30Uv0il03/STpTKMTd4tP8ttOWAGwFUu/uFnAZVnCvSF0MCh6JMmqhQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxw/S/TOi7P2ACggpaIBWMa+Kwd087T2/MmJWmdsl2TcqRNnQIa
 tI660Bq96kUKT+885XmKwlw9T+2M8lh/sYDCfarzqkm4r/UCtcXU5TD2yQCCwd1ivRXmq9ECuoP
 kDA2OshyeIRZiUIVJ7IbXHxqVM/966j3kIVrRlA==
X-Gm-Gg: ASbGnctCA5Spr+GFb8rOJUaHluN3i52bT4faK7S5N5Vw2FlljLoD+rRsxsH0znE6jU9
 qKsqpMwwOLCEJGmE7ueObETOTzQn84iiiXN36L/HfbuFJBptlkPir/zOZj2Tfza+z5QVYYNor/U
 exVVkk8+RJ2Gsf1ciFuu3eBO7P
X-Google-Smtp-Source: AGHT+IGWgFf9klSS/JIPA2NqdbtIIvWQyV4LUeNWblLz6CN9cUCPxvLFI/ZkrwnulJD65shRxAwJ8ctM9E9amtg3Z6Y=
X-Received: by 2002:a17:90a:d643:b0:2e2:c2b0:d03e with SMTP id
 98e67ed59e1d1-3051cbedbe6mr2966986a91.5.1743150427409; Fri, 28 Mar 2025
 01:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-16-andre.przywara@arm.com>
In-Reply-To: <20250327153313.2105227-16-andre.przywara@arm.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 28 Mar 2025 09:26:55 +0100
X-Gm-Features: AQ5f1JpJmv1cdXdceyS1D-pvxa5Prbt77KklUcDdTrE2i65zf82eF7WNeDKJ9mI
Message-ID: <CAOf5uwnuh8u=_AcUovwPtTRmt1K4LNz3ej_-SDb7v-QzUffunA@mail.gmail.com>
Subject: Re: [PATCH 15/18] mtd: rawnand: nand_base: annotate switch/case
 fallthrough
To: Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Thu, Mar 27, 2025 at 4:33=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com>
wrote:

> The raw NAND flash code uses an implicit switch/case fallthrough to
> share code when dealing with different ECC modes, and also when handling
> some read command.
>
> Add our "fallthrough;" statement-like macro before the respective labels
> in the NAND code, to avoid a warning when GCC's -Wimplicit-fallthrough
> warning option is enabled.
>
> This copies the fallthrough annotations that the original kernel code
> gained, before this function got refactored there.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/nand_base.c
> b/drivers/mtd/nand/raw/nand_base.c
> index 1b65c6f6443..daf12807c67 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -774,6 +774,7 @@ static void nand_command_lp(struct mtd_info *mtd,
> unsigned int command,
>                                NAND_NCE | NAND_CTRL_CHANGE);
>
>                 /* This applies to read commands */
> +               fallthrough;
>         default:
>                 /*
>                  * If we don't have access to the busy pin, we apply the
> given
> @@ -4974,6 +4975,7 @@ int nand_scan_tail(struct mtd_info *mtd)
>                 if (!ecc->read_page)
>                         ecc->read_page =3D nand_read_page_hwecc_oob_first=
;
>
> +               fallthrough;
>         case NAND_ECC_HW:
>                 /* Use standard hwecc read page function? */
>                 if (!ecc->read_page)
> @@ -4993,6 +4995,7 @@ int nand_scan_tail(struct mtd_info *mtd)
>                 if (!ecc->write_subpage && ecc->hwctl && ecc->calculate)
>                         ecc->write_subpage =3D nand_write_subpage_hwecc;
>
> +               fallthrough;
>         case NAND_ECC_HW_SYNDROME:
>                 if ((!ecc->calculate || !ecc->correct || !ecc->hwctl) &&
>                     (!ecc->read_page ||
> @@ -5027,6 +5030,7 @@ int nand_scan_tail(struct mtd_info *mtd)
>                         ecc->size, mtd->writesize);
>                 ecc->mode =3D NAND_ECC_SOFT;
>
> +               fallthrough;
>         case NAND_ECC_SOFT:
>                 ecc->calculate =3D nand_calculate_ecc;
>                 ecc->correct =3D nand_correct_data;
> --
> 2.25.1
>

Reviewed-by: Michael Trimrachi <michael@amarulasolutions.com>

I think I will apply the relative patches on mtd tree

Michael


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
