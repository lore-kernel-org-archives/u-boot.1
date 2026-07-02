Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1C6C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 07:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CC4984C85;
	Thu,  2 Jul 2026 09:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lJMx/VP7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A043E84C9D; Thu,  2 Jul 2026 09:43:27 +0200 (CEST)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FA77849FB
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 09:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-664c535f1a0so2059703d50.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 00:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782978204; cv=none;
 d=google.com; s=arc-20260327;
 b=lv6mL2EXk1thaMuaGQyTmWSnE2D6WAPxsoUcDUMYg2wR39IeNiL/IRXtNFLxOp1ujZ
 divFZJB0GDWHwZGIXIYnkAi6esbDhOHlzZS2h/45ygsinlEqwFiDHvr3kRsdvr/cnrX7
 abnrvMw4jbM+fOsc38V+8WQk2KJdmri7X+go2WZxVLP51scApp2zncaj1sKq+ZJMa4nT
 tpQ3CedN5JjpnqfiWjb60iJDfudtXraacRd378L5UWSFpxPSkYVJJ5Ta2OLEjSO0kErp
 vib3TE0w1HmD8g1Mnf1/2xYkLu7QyZx18tvcKzs0ee59fhxu7eZlw7UMNAb+X8KwGfS7
 CvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9OOeAK5XA6L1lwvE3qlJEaYUXl5XPOKutyEb/MUL3KY=;
 fh=/BZaRa1uluko6x8jjnvEWzL1SOD+PN2GFswiW+QeU1s=;
 b=AvGKBY63xeQg0oGMOMna1OQBzFTzu2ovqcYh0X9hkyB3Kyln05SlqQIAkIkcJ8zGcB
 at3fAF2CJ80jrRMP5/0vmG0wqHgQZfSzYkqvAeAzRdsIADV2ZIyWTqXvQhqjzgUmyMPV
 fNHM4XF99ZTPbZlDt8ZHn6GKKVrtBZ6lerIvpYtBljWt7rkzevlTRBsJ1L2ufoJAtAnU
 nTPCrN84VGtLzaar5RZQGicnL0HA5N08atJHBl2NQeeHE3BqW5WW9btcHhbzvLuYZaLd
 GzRMciAa8JUU2HDWYTwPD0TjwmVm5UtF5Jhc2BSdPO0HC02oqNvaKIENIVzkdvMC9Eou
 9NeA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782978204; x=1783583004; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9OOeAK5XA6L1lwvE3qlJEaYUXl5XPOKutyEb/MUL3KY=;
 b=lJMx/VP7ulNO2ZCJETi1ol66Tp7XXviSf1krHnLz5pEqXQk6h0lG0mFQV353YzeO1p
 +kp/c4vVkyJ6Lx8tEQusEEex4g6D47FJKMrkWSV5FAcHSB3tztfGNX0qu+2VMVzxDFAd
 BgfK6UGFL40C1rMiKn0y8UiQ+rQMrAmDlHYANGj/bSAvBF1RCpfAIoqXu9RTv4nRguDv
 3DJeyhDJMvm+VlV5IHNmZCNOtPBewnqUkdwmeE4SPxYTv92FBPMn15agYzgqNp4EWkK/
 SdMUx6CXZtn3H8zZ7UmVnGIGy89G2pXutiShfrqlBd+Q40/ouSv/eBJ3YKT7c4xknvk+
 NcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782978204; x=1783583004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OOeAK5XA6L1lwvE3qlJEaYUXl5XPOKutyEb/MUL3KY=;
 b=bNiYmuGuz2Y75ITHf8d+gZ176tgmLo4l2tgfYlz8p8mTu9+qWlMcN9slq/HHWDqBdO
 b5nO5d6VLnIO9jxpqpWFEHRKJML2dNRI1JsMhrTrERzS+fLSqVkr5vtRXqYJ4m0TCk6N
 0qaAm/Y4oqvjHnk3MJqwgAY8kiEmxPUgg1GAZ258mOLUvOVxQjYK6/n2olyDXfoaqpT7
 JHhVuAwMwvn0t7ZfiRoAvhZfeVN9C+qCealy94lUWD/j4F1E09GAIhX6oRbapNKVwWGw
 ZMkl+r9mGqL7dWrZzCZ1kR1Palz98h3bz0b0tYye4WMBh0uFKuXMgiKDLw3CHPins/dx
 k0FA==
X-Forwarded-Encrypted: i=1;
 AHgh+Roj7zXXtRancpAh+eUSShfVBVfW6qA/DzpDnuszqOi1RTUko7jEuwcR1RBXIYWpBe6Gkk07Dag=@lists.denx.de
X-Gm-Message-State: AOJu0YwXUarbINBR7aUhg1NRhHLDKMp5clW6lJd7eTXlYR+HalPlM8R5
 +q4QJgsO2Q+zq+Fp6tC/1B/nfaKlrw28wOlnTMCFrA0He20TPobDlod8SkWqls+3RIueMKdENja
 Bc0BMbcDnM2ZTN/4ldmNuULXFLtHzA1lbsWh+ofefSg==
X-Gm-Gg: AfdE7ckcWNJ0u/BU+XBkiAqOo0QF5WFSrGi7RYvdAUIkIIF2RYt262ySkOAvUWuvfH2
 Vx/ovtxc+oXw2M378lzgdiTRxQTNDh7IKlyhyXrB7xLcSsNOJHIbdc2Jt09ZU5e3N4n1U8qyE76
 vrcKhCsRISQfbLvY+nR/D/8A6tQRv/2h/W93bUzaLJKkaSQ3P25yBT8ZJuSQQUqeZgxMlCqCi8G
 wt0bTZbyjoXfA8W+/Y/fsjYr/sqmwwLJ11+KmIdRSHkZzH+Hvvqm7D+8QpXrf8Jyii3aWpmnyXg
 EcAR8XUQ7Vm4MJII77tHhR+rxbC9wsD/AHUx0nE0PdeIcZO5haGyFYncgFhpNyn1DynkATwPtpO
 P9AQ8pKQTf28IuNmMMWPVc4dHOmESE/mzb4INPQqvuJdU+DLImZQJTdAGT7qdGkwD6LyjKbtaN7
 wOxyG56STDEJ4hLOx5V14b7RfNXtHKylE7U83ni/kh4yY+dxDrrez1HFcZXA28L13YmFx3lmRNL
 N9IAF8GrnaCxi1j2XJaJoToOKI6xOA/BsVaIm/BfQjNaQYzOGsfuSKQarzMxMZlhgymf6v70b14
 gCIi6K4IcoqCu8trYpRqvnAxBYd1+fXaSHXivUNpGrSV9q5Kp7ITtrM/uGhhSLdIBHxIaEE=
X-Received: by 2002:a05:690e:dcd:b0:664:ae6a:e9a4 with SMTP id
 956f58d0204a3-66521d39dacmr4935030d50.74.1782978203682; Thu, 02 Jul 2026
 00:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
 <20260628082810.175862-8-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260628082810.175862-8-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Jul 2026 10:42:46 +0300
X-Gm-Features: AVVi8CdR2vPcv1tQGMJmP4OxJm3fsIajeChuvj1srWSXtCTbUfogReBlGMhyla8
Message-ID: <CAC_iWjKN2S5Xu5+YeWB6uo_yydqAxE=gZjR1zzfzFrepXx7W+w@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] efi_loader: move string helpers to efi_app_common
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de
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

On Sun, 28 Jun 2026 at 11:28, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Move the shared string-processing helper to efi_app_common:
>
> * skip_whitespace() - advance past leading whitespace
>
> Remove the now-duplicate static definition from dtbdump, initrddump,
> smbiosdump and dbginfodump.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> v3:
>         no change
> v2:
>         new patch
> ---
>  lib/efi_loader/dbginfodump.c    | 13 -------------
>  lib/efi_loader/dtbdump.c        | 13 -------------
>  lib/efi_loader/efi_app_common.c |  7 +++++++
>  lib/efi_loader/efi_app_common.h |  8 ++++++++
>  lib/efi_loader/initrddump.c     | 13 -------------
>  lib/efi_loader/smbiosdump.c     | 13 -------------
>  6 files changed, 15 insertions(+), 52 deletions(-)
>
> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
> index b39d47ff9bb..39ffbb59d82 100644
> --- a/lib/efi_loader/dbginfodump.c
> +++ b/lib/efi_loader/dbginfodump.c
> @@ -82,19 +82,6 @@ static void printp(void *p)
>         print(str);
>  }
>
> -/**
> - * skip_whitespace() - skip over leading whitespace
> - *
> - * @pos:       UTF-16 string
> - * Return:     pointer to first non-whitespace
> - */
> -static u16 *skip_whitespace(u16 *pos)
> -{
> -       for (; *pos && *pos <= 0x20; ++pos)
> -               ;
> -       return pos;
> -}
> -
>  /**
>   * do_help() - print help
>   */
> diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
> index 716daf4a90f..559c64be7f7 100644
> --- a/lib/efi_loader/dtbdump.c
> +++ b/lib/efi_loader/dtbdump.c
> @@ -87,19 +87,6 @@ static void *get_dtb(struct efi_system_table *systable)
>         return dtb;
>  }
>
> -/**
> - * skip_whitespace() - skip over leading whitespace
> - *
> - * @pos:       UTF-16 string
> - * Return:     pointer to first non-whitespace
> - */
> -static u16 *skip_whitespace(u16 *pos)
> -{
> -       for (; *pos && *pos <= 0x20; ++pos)
> -               ;
> -       return pos;
> -}
> -
>  /**
>   * do_help() - print help
>   */
> diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
> index 406cd236f6f..6bd52e08d28 100644
> --- a/lib/efi_loader/efi_app_common.c
> +++ b/lib/efi_loader/efi_app_common.c
> @@ -96,6 +96,13 @@ void error(u16 *string)
>         color(EFI_LIGHTBLUE);
>  }
>
> +u16 *skip_whitespace(u16 *pos)
> +{
> +       for (; *pos && *pos <= 0x20; ++pos)
> +               ;
> +       return pos;
> +}
> +
>  bool starts_with(u16 *string, u16 *keyword)
>  {
>         if (!string)
> diff --git a/lib/efi_loader/efi_app_common.h b/lib/efi_loader/efi_app_common.h
> index 4498607ef07..ff37f3413eb 100644
> --- a/lib/efi_loader/efi_app_common.h
> +++ b/lib/efi_loader/efi_app_common.h
> @@ -55,6 +55,14 @@ void cls(void);
>   */
>  void error(u16 *string);
>
> +/**
> + * skip_whitespace() - skip over leading whitespace
> + *
> + * @pos:       UTF-16 string
> + * Return:      pointer to first non-whitespace
> + */
> +u16 *skip_whitespace(u16 *pos);
> +
>  /**
>   * starts_with() - check if string starts with keyword
>   *
> diff --git a/lib/efi_loader/initrddump.c b/lib/efi_loader/initrddump.c
> index 52562be048d..0a025c1a841 100644
> --- a/lib/efi_loader/initrddump.c
> +++ b/lib/efi_loader/initrddump.c
> @@ -45,19 +45,6 @@ static const struct efi_lo_dp_prefix initrd_dp = {
>         }
>  };
>
> -/**
> - * skip_whitespace() - skip over leading whitespace
> - *
> - * @pos:       UTF-16 string
> - * Return:     pointer to first non-whitespace
> - */
> -static u16 *skip_whitespace(u16 *pos)
> -{
> -       for (; *pos && *pos <= 0x20; ++pos)
> -               ;
> -       return pos;
> -}
> -
>  /**
>   * do_help() - print help
>   */
> diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
> index 100e03294e5..351e103fb97 100644
> --- a/lib/efi_loader/smbiosdump.c
> +++ b/lib/efi_loader/smbiosdump.c
> @@ -25,19 +25,6 @@ static const efi_guid_t guid_simple_file_system_protocol =
>                                         EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
>  static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
>
> -/**
> - * skip_whitespace() - skip over leading whitespace
> - *
> - * @pos:       UTF-16 string
> - * Return:     pointer to first non-whitespace
> - */
> -static u16 *skip_whitespace(u16 *pos)
> -{
> -       for (; *pos && *pos <= 0x20; ++pos)
> -               ;
> -       return pos;
> -}
> -
>  /**
>   * open_file_system() - open simple file system protocol
>   *
> --
> 2.53.0
>
