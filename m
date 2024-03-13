Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70200C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 06:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B36848799C;
	Wed, 13 Mar 2024 07:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="E8Pv/uoV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BDB587C77; Wed, 13 Mar 2024 07:41:23 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E1DA87653
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 07:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-513c847c24dso387698e87.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 23:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1710312080; x=1710916880;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxF72Y3Rigua/eKRCoQlMi0On2rNSKiUTXcO6toBCjU=;
 b=E8Pv/uoVq1OgzeGEdezGPKO3IULG0GFlt9w7OsJoJQJeUdQjPuVumjMnmAN/r12Cga
 U0N/6UhgdG0bFx0/em9t9F86moHYptp3+98cmeT1w+1FwRGf1c7MbYZlXr78SPz7iGQS
 sHU+nB7pkWVnWu67yAbhUQCGuVH/egdFOxV5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710312080; x=1710916880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NxF72Y3Rigua/eKRCoQlMi0On2rNSKiUTXcO6toBCjU=;
 b=FwdtZHXXrJC/yAcJQxy/knYQHuLyFTIOBo1rbrzxr1Z9YT+vNfEFEoLFKH4Aixgwyv
 T6yKQyOU3+f15MN8dvQI7MGz4WNO3rt3hU41bktp+rJZ935F4OR/gz/E31TP6qXa9Gdi
 342VnwcoTwKuetX2U2e+NscUVlf829y282bkMnE+8Wnd9xWuzQxIyZJxx1dn13r7TIx3
 b/8jA2AuHtWnhvxv2JW/3jrpftLPKREuwYsd5KBXu2iP6MswuCsJEjZ0G8QNyWIHYAoO
 HbrYnrm3xsE9SQqTqXmHMfaZ4IHRaOcOq0DcCjBQy1HKQFMn5KPgUCjwoSo0UiMzi0Lj
 REGA==
X-Gm-Message-State: AOJu0YzeTtd2svDNlmakUwpLwmu7KEfJyKyh1P73MzI/HBuIPwdn6w9b
 sY73T9ZUGsNInDLJcV42krehazcbNJQLCbS1kCVSmYr/Aqx9/XHnGwxgwqfSoNHju2OoLkEGmaF
 6kLRWJokm2CjvIbijqE6JyjQ7GSjXegj7QAg/Uw==
X-Google-Smtp-Source: AGHT+IG6o/47jR4HTVmDXBe0NEDBFh2xwdIqy2OfQ7RsUDHW8rT222aDJ4P8TKpJpIzTz7l3CzOnb1vXXRpVVm3vdko=
X-Received: by 2002:a19:7716:0:b0:513:c2ad:8b05 with SMTP id
 s22-20020a197716000000b00513c2ad8b05mr1957702lfc.34.1710312080153; Tue, 12
 Mar 2024 23:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240313033732.77733-1-weijie.gao@mediatek.com>
In-Reply-To: <20240313033732.77733-1-weijie.gao@mediatek.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 13 Mar 2024 07:41:08 +0100
Message-ID: <CAOf5uwnfVtcDyMqUAT2hY3MKGj98mxMaoJ9kbR=+2GG74qY0Tg@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: raw: mt7621-nand: allow writing ecc region in
 raw mode
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
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

On Wed, Mar 13, 2024 at 4:38=E2=80=AFAM Weijie Gao <weijie.gao@mediatek.com=
> wrote:
>
> Allow writing ecc parity region in raw mode. This makes sure the
> nand write.raw command can write the flash data as-is.
>
> Change-Id: Ibed3bdf13c9cf81e54041c5ac7a78192b97dcedc
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> CR-Id: WCNCR00180092

I think this is for internal tracking

> ---
>  drivers/mtd/nand/raw/mt7621_nand.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/mt7621_nand.c b/drivers/mtd/nand/raw/mt=
7621_nand.c
> index f6eddb84a9..341ef0bf2d 100644
> --- a/drivers/mtd/nand/raw/mt7621_nand.c
> +++ b/drivers/mtd/nand/raw/mt7621_nand.c
> @@ -1003,9 +1003,9 @@ static int mt7621_nfc_write_page_raw(struct mtd_inf=
o *mtd,
>                 mt7621_nfc_write_data(nfc, oob_fdm_ptr(nand, i),
>                                       NFI_FDM_SIZE);
>
> -               /* Write dummy ECC parity data */
> -               mt7621_nfc_write_data_empty(nfc, nfc->spare_per_sector -
> -                                           NFI_FDM_SIZE);
> +               /* Write ECC parity data */
> +               mt7621_nfc_write_data(nfc, oob_ecc_ptr(nfc, i),
> +                                     nfc->spare_per_sector - NFI_FDM_SIZ=
E);
>         }
>

Please describe better what regression you are trying to fix in the
commit message
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

Michael

>         mt7621_nfc_wait_write_completion(nfc, nand);
> --
> 2.34.1
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
