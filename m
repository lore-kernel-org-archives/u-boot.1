Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E56C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 14:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B6682DB7;
	Mon, 26 May 2025 16:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Oh9e76SV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 162CE82E17; Mon, 26 May 2025 16:27:38 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E556A82D4A
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 16:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-549b116321aso3216252e87.3
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 07:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748269655; x=1748874455; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=te0lE2CnwmZZP+XYzSnwhd3L7Gt18U5+pyQgmCITnj8=;
 b=Oh9e76SVpq+Fn1S+AGKkAi1knS8E88g0M0Hhl8fWkHOf2PSMyzbTk3Boh6j05rxEoa
 lmUktr75JItv0yFz8ZYHzRkDs1UnNpr3P2VSqQsc9aakCwBUXyWIjKENfk5BR7bfmcsQ
 eckwmIfCQ2EI5tMyDENTNEmkppVv+6bmAuhqvFunQt0b3AeByVSsaG7yYdhsqIfp06qX
 qVHp3CQmitdeyvM42ZnkXrXJLzjFJGwYOhGjLzcRg9q61MZUeVCWVam5GPxuax8OS9Hc
 +tJI05fgf/Zut+x2bUhyR2IWVh6ZcapUcwGK8Db0iFkYu86dl1HwOGk6clz9omIZsm1+
 L1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269655; x=1748874455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=te0lE2CnwmZZP+XYzSnwhd3L7Gt18U5+pyQgmCITnj8=;
 b=Mg1oLzPIAYOXd/6/BTVZ03PVPSS/m1zqmpY5vNPtOn9eC9rhffo8XUJwA7C2M1QYkl
 SgCG0rtGyzWcUWwypOGyIo8Xs72/U7SlowSgYceKvRY0EKtDECQF8+ORmXqv/SM2gydC
 GjFp5mkO4fLAY5iF2IzCZIScDrUM3j8KWsSIFK0J40QAJV+DZLo+2SV2DbxxZSiskcNW
 BeaIPY8owZYNVvoz/opAOlhSs5JPhyXJOJyxdn7BWf3NGAnJRrQdIiYQiH+tZPDQundo
 drleVg5pRzhncoyjRCHk1fnAL9DOBqe05OqcMQybQ6EG9SW2LDwotZXyfkMAO/h+eNAY
 u8zQ==
X-Gm-Message-State: AOJu0YwfBSQH7cAVyypK09dSszEy3BB38ltd1C3hpKyI4CfSNtBaYxk5
 jDH7Xk+ijsrQ9HgSaUyhPRO6b+nbGJuxoxLcUPdofTuFh542H79d7UTZkpF0u8U1Ryy2/hvaKOw
 X9Q9f36oI+WuWRjIr1xSrvWXrbtbtJCg=
X-Gm-Gg: ASbGnctPyySs8HtErtw8M3IgeOxt3nQLX7tiPaojMx1JsTPAU1RrInRfoTH8v63AHzs
 LL4mJL6rOxhsvxjFqg31nPHv4NR2FPOw8V0jB4XdKaX7KirNxTAznTTpF8K1yNp2WPW0PPp6hX9
 Hea3Om69ziZ1FT5+cxayU2YG/RBDoh1c1xgLW2WpeJGivi5RhaTJoPs2GBgG4gpnEv
X-Google-Smtp-Source: AGHT+IGzRnojYbTAAMgTXrWhrsiD76tcCl+3P3tIxEG/ATGK8R9kob0nkYYBlbcvAqpkfuxyO7f7P++4dAaZbeQUD58=
X-Received: by 2002:a05:6512:234c:b0:553:25f4:695b with SMTP id
 2adb3069b0e04-55325f46ac2mr318553e87.6.1748269654901; Mon, 26 May 2025
 07:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250525122316.661999-1-michael@amarulasolutions.com>
 <20250525122316.661999-3-michael@amarulasolutions.com>
In-Reply-To: <20250525122316.661999-3-michael@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 26 May 2025 11:27:23 -0300
X-Gm-Features: AX0GCFs8S_qtwQU-dNiec8xN7wGCKHOrAWhdWuk02gubhidF7h5OjrCzsc1eSYQ
Message-ID: <CAOMZO5CdLBngWjE=ozR-sFdXRUS36t-PKiG1O5L1JujrxUWAkw@mail.gmail.com>
Subject: Re: [PATCH 3/4] mtd: nand: Add support for EDO mode 1-5 to IMX6ULL
 platform
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
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

On Sun, May 25, 2025 at 9:33=E2=80=AFAM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> The clock driver allow to burst the performance of the nand

allows to boost....NAND

> controller. Make changes to let it use the new clock driver
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>
>  drivers/mtd/nand/raw/mxs_nand.c    | 12 ++++++++++++
>  drivers/mtd/nand/raw/mxs_nand_dt.c |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/raw/mxs_nand.c b/drivers/mtd/nand/raw/mxs_n=
and.c
> index 80d9307cdd1..2679b6ab650 100644
> --- a/drivers/mtd/nand/raw/mxs_nand.c
> +++ b/drivers/mtd/nand/raw/mxs_nand.c
> @@ -1507,8 +1507,20 @@ static void mxs_compute_timings(struct nand_chip *=
chip,
>         writel(GPMI_CTRL1_CLEAR_MASK, &nand_info->gpmi_regs->hw_gpmi_ctrl=
1_clr);
>         writel(ctrl1n, &nand_info->gpmi_regs->hw_gpmi_ctrl1_set);
>
> +       /* Clock dividers do NOT guarantee a clean clock signal on its ou=
tput

their output.

> +        * during the change of the divide factor on i.MX6Q/UL/SX. On i.M=
X7/8,
> +        * all clock dividers provide these guarantee.

this guarantee

> +        */
> +       if (IS_ENABLED(CONFIG_MX6ULL)) {
> +               clk_disable(nand_info->gpmi_clk);
> +       }

Please remove { } for single-line statements.

> +
>         clk_set_rate(nand_info->gpmi_clk, clk_rate);
>
> +       if (IS_ENABLED(CONFIG_MX6ULL)) {
> +               clk_enable(nand_info->gpmi_clk);
> +       }

Ditto.
