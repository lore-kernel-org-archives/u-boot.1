Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6D5C46CA2
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 11:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D69D687DD5;
	Mon, 18 Dec 2023 12:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="is0IYSza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E3A887DD5; Mon, 18 Dec 2023 12:28:43 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5225787E04
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 12:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-da7ea62e76cso2259702276.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 03:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702898915; x=1703503715;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fy346Lkkb3BQfRWs60pRmSLqRSFyGPaoOaJVVIgiYqg=;
 b=is0IYSzaiu6XQFWwgGVbF135ol0YN1RbyTzEeB4JFSeO1IDA6FR9B/U90ExBRhjsz8
 XGVL85zDGkPEgPiv55Ud4zX1ibAqNV1Zr5d7wp+FyLzbaxmtShOognebuBLEvBX1txxN
 Ua4UiQC7VSUmrDuZw+mpFBfqG5F5Y6+C7tQ18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702898915; x=1703503715;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fy346Lkkb3BQfRWs60pRmSLqRSFyGPaoOaJVVIgiYqg=;
 b=Ft21NKGYPEqWrEcFrv+CZHvlsIFxUGCXiGemLxA0AIqMf5wWn81RyExOpId4/2yZwG
 MmSRMtmxHVA3Q6rxeseRSyK3poTzoASEnA0bbRXefGslItN5BBdHHbQ3r4izP9iDSdvN
 A2vYp1n0pRzQwF5oblj37+ipiK+qc9oIfUiGSA1uT1DoymrfGtIUgKB1/B9wMsAyhKCG
 0DyAJoAIWjx3c6+YbAExY0QP9uYpDcNf5OSrOFUc4GqOYWWVjm/JrxsBosIaVbSCpSBM
 raZ2UPwFo6AdSVsAdaO4gillISmfEKG2HecrHu5s+zWVjmnC5LL5boZINceCu5bnMyJm
 7cGQ==
X-Gm-Message-State: AOJu0YzIB0PZlZ4kH/CrJCXcn5CABGGt6GqNIAhHNexhsYnPlku3/mRk
 A+4Mw8aGYxo5hIx3F00szlSlThepyNWUpkLYbVaWYb8tB0w1PyUjQno=
X-Google-Smtp-Source: AGHT+IESwilEgevxgLaFblwXrsZbsWIybdJw3DQhAWWoJtSUS9M6JT2j3yDjYjNm8dPSa077zC9/6xwOTI9y6yzWwDo=
X-Received: by 2002:a5b:f08:0:b0:dbd:13cc:5305 with SMTP id
 x8-20020a5b0f08000000b00dbd13cc5305mr871237ybr.65.1702898915259; Mon, 18 Dec
 2023 03:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20231017070507.1254286-1-bigunclemax@gmail.com>
In-Reply-To: <20231017070507.1254286-1-bigunclemax@gmail.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 18 Dec 2023 16:58:24 +0530
Message-ID: <CAMty3ZCubyd9y5dqGTaEHDGNbai1Yg3vgiY-oivBQqUznqe0dw@mail.gmail.com>
Subject: Re: [PATCH v1] spi: dw: add check for Rx FIFO overflow
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: u-boot@lists.denx.de
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

On Tue, Oct 17, 2023 at 12:35=E2=80=AFPM Maksim Kiselev <bigunclemax@gmail.=
com> wrote:
>
> If even one byte is lost due to Rx FIFO overflow then we will never
> exit the read loop. Because the (priv->rx !=3D priv->rx_end) condition wi=
ll
> be always true.
>
> Let's check if Rx FIFO overflow occurred and exit the read loop
> in this case.
>
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>  drivers/spi/designware_spi.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_spi.c
> index 1c7d0ca310..0f443bff8e 100644
> --- a/drivers/spi/designware_spi.c
> +++ b/drivers/spi/designware_spi.c
> @@ -111,6 +111,15 @@
>  #define SR_TX_ERR                      BIT(5)
>  #define SR_DCOL                                BIT(6)
>
> +/* Bit fields in ISR, IMR, RISR, 7 bits */
> +#define DW_SPI_INT_MASK                        GENMASK(5, 0)
> +#define DW_SPI_INT_TXEI                        BIT(0)
> +#define DW_SPI_INT_TXOI                        BIT(1)
> +#define DW_SPI_INT_RXUI                        BIT(2)
> +#define DW_SPI_INT_RXOI                        BIT(3)
> +#define DW_SPI_INT_RXFI                        BIT(4)
> +#define DW_SPI_INT_MSTI                        BIT(5)

Why do we need unused macros?

Jagan.
