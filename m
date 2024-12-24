Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97743E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 07:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0222E80711;
	Tue, 24 Dec 2024 08:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vU41AJp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 552F880786; Tue, 24 Dec 2024 08:03:00 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D034D80708
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 08:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e53aa843a24so2327277276.0
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 23:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735023776; x=1735628576; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Go1e2H/qPm+mBN9ifI1xZNPWSvFj/vRCJhfIsioqo80=;
 b=vU41AJp6kGrBoEXF/ge/L0djzqG1H1dI75KznlaYGTdJheasvfJzUmos3e9BGTscVc
 JFQEe47xwt/TKlZB+5z/g86WAx5zCc6FtdOOuaVTPCceAARUnpqRP1wumiNF3e5FVzjq
 uN70xiWSAc1kS6FwVW2/oR925LfVTTsjD9vnJzePuPXKUzEaT8T/ezdxKPdFJR76CKrI
 2zKxYkQTlZ9NwB71cqwiwbNnRsWZxKyoBLFeTqt3HzauihNoPEq0GEXC5tqNLn2EJDiL
 Vl0spUOLYnnxAX+3Dl9tq+FmdVn44c/h2cbzMOzc7bnvF3ozw7Qew10CDg5Aa1z7KfKG
 zxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735023776; x=1735628576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Go1e2H/qPm+mBN9ifI1xZNPWSvFj/vRCJhfIsioqo80=;
 b=a82BnHMRnmjmQme83dKr+pXQ0wpZcoMOE2oTzJvAcVS8H1yBxNggw+aJGIVehkJEvc
 weu91hx9PP6do+EhPUQtWD5DxmnX3V7Lc/SW3TT5fNKoVXMoDCxl/chQIHR+Wq1vwWet
 48PNh4h0oFQjRUkdvz74idnArJatCvo4Nx7dAQWk8bnYUAn/pWgSADsnq25r/MTII30m
 2kthLmvlj4fLFBr8nZHbsBq5NKNJbSVc2/6OKouiWLXg6F499ew3PGnPkZ22uGhab70g
 t9JS2H+2X25DbxEdEY9IGJYaE3fUF55wk+YuvjfzEkAomv7vrvENU1pbPDvqDrueatzF
 BiJg==
X-Gm-Message-State: AOJu0YyuADcUHNQFiTBANbDaHkRWJW/J1+ZyuCeZKBxLsUiWuS8umXuX
 1Ac1szEgEXanSiQcipwL6dloFqg/i1GKGJuPXjdsfVvnuOaTjfT3pqi7+Malfw2ym3dA0NWuxsb
 Hlrv4ZUQeXdFKx4TQyvzhoBSnUu9SceK5qYdgTg==
X-Gm-Gg: ASbGncuW3OOlAgBXkJD0GcE5B/yY9vsUV8VB1P4nVAJ++W1c7/KCglZyvVEKas77GLK
 eMDCKknztWnS7WzbQ+xbnEcnoW4CFjFl0t2FUhw==
X-Google-Smtp-Source: AGHT+IGu9AJqlnlKJkeAqDf/k9KmCRVlNqJEQ5Yi7F//POlP41r9812zYo8r9D0C8/aTxF5m4JOv/z7XJiz+A8iXUxc=
X-Received: by 2002:a25:bac4:0:b0:e30:cc41:2abe with SMTP id
 3f1490d57ef6-e537675d44cmr14276630276.16.1735023776654; Mon, 23 Dec 2024
 23:02:56 -0800 (PST)
MIME-Version: 1.0
References: <20241223144737.554992-1-raymond.mao@linaro.org>
 <20241223144737.554992-5-raymond.mao@linaro.org>
In-Reply-To: <20241223144737.554992-5-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Dec 2024 09:02:21 +0200
Message-ID: <CAC_iWjJUhbp1hFnpAhHJh5Cw0uO67qnAZ+614===J++KFt9zUQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] tpm: refactor tcg2_get_pcr_info()
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tim Harvey <tharvey@gateworks.com>, 
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 23 Dec 2024 at 16:48, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Rename the arguments of tcg2_get_pcr_info() to clarify
> they are bank masks, not PCR mask.
> Remove the unused local variable.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  include/tpm_tcg2.h | 12 ++++++------
>  lib/tpm_tcg2.c     | 19 ++++++++-----------
>  2 files changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
> index 6519004cc4..eb6afe49e7 100644
> --- a/include/tpm_tcg2.h
> +++ b/include/tpm_tcg2.h
> @@ -94,17 +94,17 @@ struct tcg_pcr_event {
>  } __packed;
>
>  /**
> - * tcg2_get_pcr_info() - get the supported, active PCRs and number of banks
> + * tcg2_get_pcr_info() - get the supported, active banks and number of banks
>   *
>   * @dev:               TPM device
> - * @supported_pcr:     bitmask with the algorithms supported
> - * @active_pcr:                bitmask with the active algorithms
> - * @pcr_banks:         number of PCR banks
> + * @supported_bank:    bitmask with the algorithms supported
> + * @active_bank:       bitmask with the active algorithms
> + * @bank_num:          number of PCR banks
>   *
>   * @return 0 on success, code of operation or negative errno on failure
>   */
> -int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
> -                     u32 *pcr_banks);
> +int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
> +                     u32 *bank_num);
>
>  /**
>   * Crypto Agile Log Entry Format
> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> index dc5a0644fd..16f41cbfd1 100644
> --- a/lib/tpm_tcg2.c
> +++ b/lib/tpm_tcg2.c
> @@ -21,19 +21,16 @@
>  #include "tpm-utils.h"
>  #include <bloblist.h>
>
> -int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
> -                     u32 *pcr_banks)
> +int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
> +                     u32 *bank_num)
>  {
> -       u8 response[(sizeof(struct tpms_capability_data) -
> -               offsetof(struct tpms_capability_data, data))];
>         struct tpml_pcr_selection pcrs;
>         size_t i;
>         u32 ret;
>
> -       *supported_pcr = 0;
> -       *active_pcr = 0;
> -       *pcr_banks = 0;
> -       memset(response, 0, sizeof(response));
> +       *supported_bank = 0;
> +       *active_bank = 0;
> +       *bank_num = 0;
>
>         ret = tpm2_get_pcr_info(dev, &pcrs);
>         if (ret)
> @@ -43,16 +40,16 @@ int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
>                 u32 hash_mask = tcg2_algorithm_to_mask(pcrs.selection[i].hash);
>
>                 if (hash_mask) {
> -                       *supported_pcr |= hash_mask;
> +                       *supported_bank |= hash_mask;
>                         if (tpm2_is_active_bank(&pcrs.selection[i]))
> -                               *active_pcr |= hash_mask;
> +                               *active_bank |= hash_mask;
>                 } else {
>                         printf("%s: unknown algorithm %x\n", __func__,
>                                pcrs.selection[i].hash);
>                 }
>         }
>
> -       *pcr_banks = pcrs.count;
> +       *bank_num = pcrs.count;
>
>         return 0;
>  }
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
