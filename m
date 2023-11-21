Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3506C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 21:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 322DA87582;
	Tue, 21 Nov 2023 22:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Uj5Uhut9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 273198758B; Tue, 21 Nov 2023 22:07:10 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62DE78743A
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 22:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50aab0ca90aso4174867e87.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 13:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700600826; x=1701205626; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bmrwI3tlxx3Njq1DvyOsu5GcKl78NMy4sY+iVQMlAq4=;
 b=Uj5Uhut9YsI3dIMY2Rk2I0HeVEkADr9kx0matd/zi/dFVtZrCteJ591ArJndFh5+us
 mpKtxNdaR+Ih+SU0mjezsn1zq7VfhJGffqKkZRc7pCqJ4iZBaVnpEo3lSMxveOkWK1/k
 R9raU6XqSvDxBKQ8VZj7M5saxvfs8C4saDb340ljuuxcQNWMrfJjWFiD0zl4UJJL32sh
 WkN4bfUcuDalIH51hXzGQqT/wL+lrVoNze3V2tFozozZGwh1a1IFaj9B1q5pSU43k4JL
 bnjAo2SQmIWQcnHTT50G9HTqTGAclSvS7vJPGrAbAqCz6rFHYGpqcO500VojRdX6li4q
 J6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700600826; x=1701205626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bmrwI3tlxx3Njq1DvyOsu5GcKl78NMy4sY+iVQMlAq4=;
 b=mOIaOs651n2pibIAWHuUdJJjq1rJYTZFkfxYBfTcHBC4Ospi6XcSdNQQkNzW5WKTX7
 icId2LRmCiNN0998H75Tvoc4/1a7zRGZdxKgl38PmfVy3kzO72K9QaHAmzQvYAgqkd7k
 VqOJr97XYZCeVXC92EygQ9nFW2UcqKJ/RUCb10ma0bar3vccaC3wQNLR8t9lg1D4gWVF
 SRlKR0RK9KHDUicnpRv0lBNIIiEj7Qclv78pUVAFoZWC83B8z7etluVVz8cSTRm3gKSA
 Q9O7t04PcP3etnw7btaIirx4GFdWYE+ik5UbKUqsyeI0fqjMyJ97I02dYtmkktBu4ocr
 gQHQ==
X-Gm-Message-State: AOJu0Ywlf7V52aPSkNUunYDO4pUkcr4TmdpBnjo0olWbfEMzVn8HjGwA
 eTaP97ZbOHVepaKZLtqiKEV8yy7sGPR7dxMJS/Cu9YloXnLQEItHHco=
X-Google-Smtp-Source: AGHT+IGnwzyvGxMhMXxUQUmTxlg7ODsgeg1MIy3coi14XY+pWO7XsiP02+yO7kQunIfaz0+GTF2PuCI6iq9WpeGUm98=
X-Received: by 2002:a19:c511:0:b0:507:a001:792e with SMTP id
 w17-20020a19c511000000b00507a001792emr45305lfe.46.1700600826660; Tue, 21 Nov
 2023 13:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20231120222558.32014-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231120222558.32014-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 Nov 2023 23:06:30 +0200
Message-ID: <CAC_iWj+nkBWDtnZks=eticrPhqikLiNw+m8AEGB96srgU6pCmA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: generated SMBIOS table below 4 GiB
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
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

Hi Heinrich,

On Tue, 21 Nov 2023 at 00:33, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We currently use an outdated format 32-bit format for SMBIOS tables.
> So we must allocate SMBIOS tables below 4 GiB.

Can we please adjust the commit message to something that would
represent the situation better 6 months from now?
Mention that this fixes 53fab13a7 ("efi: Use the installed SMBIOS
tables") and keeps the x86 changes while reverting back to allocate
memory < 4GB

Other than that
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks
/Ilias
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_smbios.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> index 48446f654d..0fbf51b98d 100644
> --- a/lib/efi_loader/efi_smbios.c
> +++ b/lib/efi_loader/efi_smbios.c
> @@ -49,25 +49,27 @@ efi_status_t efi_smbios_register(void)
>
>  static int install_smbios_table(void)
>  {
> -       ulong addr;
> -       void *buf;
> +       u64 addr;
> +       efi_status_t ret;
>
>         if (!IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE) || IS_ENABLED(CONFIG_X86))
>                 return 0;
>
> -       /* Align the table to a 4KB boundary to keep EFI happy */
> -       buf = memalign(SZ_4K, TABLE_SIZE);
> -       if (!buf)
> +       addr = SZ_4G;
> +       ret = efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
> +                                EFI_RUNTIME_SERVICES_DATA,
> +                                efi_size_in_pages(TABLE_SIZE), &addr);
> +       if (ret != EFI_SUCCESS)
>                 return log_msg_ret("mem", -ENOMEM);
>
> -       addr = map_to_sysmem(buf);
> +       addr = map_to_sysmem((void *)(uintptr_t)addr);
>         if (!write_smbios_table(addr)) {
>                 log_err("Failed to write SMBIOS table\n");
>                 return log_msg_ret("smbios", -EINVAL);
>         }
>
>         /* Make a note of where we put it */
> -       log_debug("SMBIOS tables written to %lx\n", addr);
> +       log_debug("SMBIOS tables written to %llx\n", addr);
>         gd->arch.smbios_start = addr;
>
>         return 0;
> --
> 2.40.1
>
