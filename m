Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4F0C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 08:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7937A87C1D;
	Fri, 26 Jan 2024 09:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CZ301GFc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7252887C1D; Fri, 26 Jan 2024 09:17:52 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A2987BED
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 09:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-51025cafb51so158156e87.2
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 00:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706257070; x=1706861870; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4YMDQLcfCq1gnC+JvKul83KI3HWMI1KUnYbTHrqKZ9Y=;
 b=CZ301GFc6Yykirl12bC7koYzt50MAJ+8O4cvOJbb2uSmWrgVv02q4MK2nNgpEP63uG
 dMV0B+iqTGG/j6ZZnJSzjuXTsMm4bRLeXWLDgoexHRix1qiMSXBpf5k36/Txt7symldf
 XQWdGxSM7cLB7N0rbgPx85Ym6m+rznh9UVIfp1Lss27HfpA3o4zawqLS8XZZOABPhh8y
 NKXLBSdRhvJuFG8aEXmgnxAI9zA/KqMOxKwfA1Q3nprTp6X96K85nvaTULURNfawAyzb
 XGPMosbIPcAg/ekRXkz5fCsySP4HePhWtlxeoA1+IuaXRwD/HEDO4y9lBWF/ucM6LsBR
 /tMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706257070; x=1706861870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4YMDQLcfCq1gnC+JvKul83KI3HWMI1KUnYbTHrqKZ9Y=;
 b=M5Q9kE9nA2ZtO0ky1K7QWzS/SHtcWOp7P/qx5U5BC6VbKxssrsmjxNU+hjFi7+vB0x
 EirQPd7J31Ax9bxQ+azRBQSAzD2A5ys3dJ+8tYeCl+MzGQP2zY+bP53ccjLsI8BsJgQ1
 dcVaiBntG2CKH27EX/HjdJO+j6ORuZyCyUnUMranYF9g9akdwyJp3mVYJLF7r6n0ozof
 iTv5O/QO/J7TV8E9k7BeZ+tdHK5ELNpnHpK1IaU+1QdUTIhfB5QPd+Ma6DSNrmnlXCf3
 iSSdpELH8sBwrotmRG0uL0S6fXmeGaCpKko2WDoB/Yu3O5ahCEPn5tTwF1c4izqsgdET
 1ImA==
X-Gm-Message-State: AOJu0YxyZrXMefnjem0HyvAxoUcVukUOo8EGH0ToQrJRhdch8fPrgoA0
 hOSD+aBz+KYWWjoC5HM7Xoz37sif3sj4NrDmBw+DhIUJnZVBhIg2wdIykLRzDIBxGJLqcv4Nlss
 7sjbV6UUqQxvIoeCgqYUyBe4no7m18Lk/3ZXBIr4XzTmrL3PF9Ec=
X-Google-Smtp-Source: AGHT+IGbPHGFrM9vXUDkopMJTm2QJSC723k6dwx5jDp15MEZ6PjICL7sEMOvJS8livTdE0HNndCjUKmp/6i3qeCM1Kc=
X-Received: by 2002:a05:6512:70:b0:50e:74e2:af58 with SMTP id
 i16-20020a056512007000b0050e74e2af58mr527395lfo.52.1706257069722; Fri, 26 Jan
 2024 00:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20240126081322.25781-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240126081322.25781-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 26 Jan 2024 10:17:13 +0200
Message-ID: <CAC_iWjLQcCQBUfB4w_0bt4J6SE2_G8jje_1qAwKz7fA-48J-jA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: replace find_smbios_table by library
 function
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de
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

On Fri, 26 Jan 2024 at 10:13, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The code in find_smbios_table() is redundant to
> efi_get_configuration_table(). Replace it.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_tcg2.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
>
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index 85562c50a1c..b5d4aa7be52 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -1128,23 +1128,6 @@ out:
>         return ret;
>  }
>
> -/**
> - * find_smbios_table() - find smbios table
> - *
> - * Return:     pointer to the smbios table
> - */
> -static void *find_smbios_table(void)
> -{
> -       u32 i;
> -
> -       for (i = 0; i < systab.nr_tables; i++) {
> -               if (!guidcmp(&smbios3_guid, &systab.tables[i].guid))
> -                       return systab.tables[i].table;
> -       }
> -
> -       return NULL;
> -}
> -
>  /**
>   * tcg2_measure_gpt_table() - measure gpt table
>   *
> @@ -1387,7 +1370,7 @@ efi_status_t efi_tcg2_measure_efi_app_invocation(struct efi_loaded_image_obj *ha
>         if (ret != EFI_SUCCESS)
>                 goto out;
>
> -       entry = (struct smbios3_entry *)find_smbios_table();
> +       entry = efi_get_configuration_table(&smbios3_guid);
>         if (entry) {
>                 ret = tcg2_measure_smbios(dev, entry);
>                 if (ret != EFI_SUCCESS)
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
