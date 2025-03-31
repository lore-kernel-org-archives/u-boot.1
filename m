Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1165C36017
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 05:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6700812BC;
	Mon, 31 Mar 2025 07:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hHEC7oCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F648144A; Mon, 31 Mar 2025 07:48:31 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E429480F9C
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 07:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so3373411f8f.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 22:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743400108; x=1744004908; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FvZnVWFYWoWCzFvvjfMM3PgOB36ZNRMGTa61WFjnzjg=;
 b=hHEC7oCNDYtNO1aZP2Up7B+8f+UGI4SRmix9eJWE2ZfFhOamMIsJcx0c0Pjfxb4uZU
 eAiUm3thFIrCxoetSUlGov9h4R1R2OPGpq1+M/gkw14NCKycrMU44r2qlDyya1QVcNNw
 jjAES8i/LzGrBztvF9huzVBgH1HXassqDQmpdjX5BEmzswRuRuZc8/kcQmisCHvWDqhu
 bFnKJIG+MHH36dDhnryZpD8o3f/SyJSoDTIqe7Wdfu4UjSYvPKpLnyAdpqiS9AXbZRPY
 ka6VTN0EsCnAiKE92YPY+2T6uIM4UgXSTFjjYfRN/mGJoWJ/q9RAbPmGnI9XgR6qDpXZ
 i9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743400108; x=1744004908;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FvZnVWFYWoWCzFvvjfMM3PgOB36ZNRMGTa61WFjnzjg=;
 b=X9Sfz+9iqpebKo8wmwqHCCvtS8ZRWWETAOr1cWKkKuayM3jPa9q6T8ka9SxaAAqNe+
 ZRXkORkhxYLSY767RF/aLNJMYNRqImDQiN7y2niCLWxTNeqFc30qNW46lfUI3Na5N0Sy
 nPP7C5v9zq+MoqxEn0BF3wq+RQw6/nqrx4tUQuYIUWUdw++tQTAhUnhkr+Tvs8UxHFSN
 DwnTdOkwhzJZ7lr+f8KjD3J/VOELSycjIyjrLItrMOVOLsBC02H0SEN09exGXNDF/HYD
 LyMsq7jBCjIrXzRxY1/N+vw4Uhukdqr0YwLRN5LHWvvGppUp1WDA1lT+jQNtRcEEvcfk
 MJgw==
X-Gm-Message-State: AOJu0YxCU+rxgVBKo8MO03JxWyHkmI/uvXLsRebVjaRYMIxG+NQ+9Rip
 lgn5KmkZWB7mUIJAhyf9bE6aHcB4tkCcqYbedJUJWxJhRfz5652AKPMHHJo4+WATduwZG36H+4V
 Z6XXa++nQIjyPNiCoXXxqi3ky2kE=
X-Gm-Gg: ASbGncuyhNu63KvuevfSOi30oBpbqHMxtf1DcNOx/k9hgWJJKiwPUEfh/DjzeS3X2o3
 P95KcOsYLIxB7wI7lKynmJZ0ozQdfohTAsqSGnGUEMCIUQ/w47n8MvJETIrPAt8sIhzHFVSveKx
 xbq6xtorcJTBVvFyCfi/5Fv6qctHE=
X-Google-Smtp-Source: AGHT+IE/6/XC3mGT1fwX3cjh77kZL6VnjjPLRf0r/nYkfutjmjqpor5XVEwMaOywygHZJY7NqoUbI9WYvCUK/NJwA00=
X-Received: by 2002:a05:6000:4282:b0:391:1652:f0bf with SMTP id
 ffacd0b85a97d-39c120f741amr5691581f8f.33.1743400108086; Sun, 30 Mar 2025
 22:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250330192656.1280403-1-arturkow2000@gmail.com>
 <20250330212638.v2.2.I04194142897633b6272f2f235daed4f3a0b8939b@changeid>
In-Reply-To: <20250330212638.v2.2.I04194142897633b6272f2f235daed4f3a0b8939b@changeid>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 31 Mar 2025 08:48:16 +0300
X-Gm-Features: AQ5f1JpvQ9mlNcMIdfOhW3vKrWO_DK_iMLeGanO6ixOe8Ss6KodglSCqMpLfwHw
Message-ID: <CAPVz0n2qCOx6dF7DnwEdnptw1hmvbR7ky70zB6ESM7pqeEuVdw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] tegra: respect CONFIG_TEGRA_ENABLE_UART* options
 on Transformer T20
To: Artur Kowalski <arturkow2000@gmail.com>
Cc: u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Simon Glass <sjg@chromium.org>, Stephen Warren <swarren@nvidia.com>,
 Tom Rini <trini@konsulko.com>, Tom Warren <twarren@nvidia.com>
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

=D0=BD=D0=B4, 30 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 22:27 Artu=
r Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> If debug UART is set to anything other than UARTD, U-Boot's SPL hangs
> trying to communicate with UARTD which clock won't be ungated. With this
> patch it is possible to boot with UARTA enabled.
>
> Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
> ---
>
> (no changes since v1)
>
>  include/configs/transformer-t20.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/configs/transformer-t20.h b/include/configs/transfor=
mer-t20.h
> index 6a3d9b24036..d3a98cc5a70 100644
> --- a/include/configs/transformer-t20.h
> +++ b/include/configs/transformer-t20.h
> @@ -16,7 +16,17 @@
>  #define CFG_TEGRA_BOARD_STRING         "ASUS Transformer"
>
>  /* Board-specific serial config */
> +#if defined(CONFIG_TEGRA_ENABLE_UARTA)
> +#define CFG_SYS_NS16550_COM1           NV_PA_APB_UARTA_BASE
> +#elif defined(CONFIG_TEGRA_ENABLE_UARTB)
> +#define CFG_SYS_NS16550_COM1           NV_PA_APB_UARTB_BASE
> +#elif defined(CONFIG_TEGRA_ENABLE_UARTC)
> +#define CFG_SYS_NS16550_COM1           NV_PA_APB_UARCD_BASE
> +#elif defined(CONFIG_TEGRA_ENABLE_UARTD)
>  #define CFG_SYS_NS16550_COM1           NV_PA_APB_UARTD_BASE
> +#elif defined(CONFIG_TEGRA_ENABLE_UARTE)
> +#define CFG_SYS_NS16550_COM1           NV_PA_APB_UARTE_BASE
> +#endif
>

Here you are actually hitting much much deeper thing. You are applying
fix to the result, not the cause. Adjustment should be done in the
tegra board itself with amending all existing tegra boards. As a
maintainer I cannot insist on you doing this unless you willingly
agree. You have time to answer till 02.03.25 and if no answer I will
apply patch on my own to custodian tegra/staging branch.

>  #include "tegra-common-post.h"
>
> --
> 2.48.1
>
