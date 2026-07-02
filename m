Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E35C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD70984CB3;
	Thu,  2 Jul 2026 10:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TU/KQZWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27BC684CC1; Thu,  2 Jul 2026 10:56:04 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B14B184CA3
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66493875766so2115837d50.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782982560; cv=none;
 d=google.com; s=arc-20260327;
 b=s++dbYcAYWq4XKfptujWwu2utWdHKpouWkHu5LWbvbhnk/8zEn8CyNK/tEgEQOIM0d
 hd2ipdW6EQycnwvc4e/daGKKKC8nHO5XBMfKRFJ1rLlsLT2dSKEFcgeuZv27g7sNugx2
 Jd6wmvS+f1bUiM/xL8PEJ8GnxhIl9cG6xoYhBBsMXk0YPirSYqMaWQCHSIBX2VfHv8Lj
 +seaxXZ9ovLPryWhyWwJc73iTpIfYDertFWtsYVQFU0avII401cANRPi2DJ1JyNbLCJX
 gbv0aRM/8dP/Jj3sEHA9WeU6Fs0wXFISaLipQ8DmalEPbLyfDBWkgPA7iH0hMUBD0QFu
 1J/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YAtajG793ShkqaLXBEpZjRM8//AWh/xmHWjxP95LKZk=;
 fh=uRbiZDD8/GzX63fpgcBB3BzGdX9DSS2G8/9/Hya3HWM=;
 b=Mp9MxvKvzNxj2OfH6Kk1EbGCy/+CCz7KPysv4O6RAWnWLZREKXgg6AVMYozG7GCVjm
 MDJxWgiBbRldZOq71zOWuSlM6ve39qHDoRJ4ztlytsarx6nKtUQMtknMEe2o0GfLne0s
 M/Q+mdJ9Lekkt9bl+DfgQVwvdmJKfLYMOzgO2mxLFZNncjPAngtNn1daTkJ27G/jvBEc
 7w6IzK3HhjFey123HjkJTKQnagXyl1vGtG4yTbX3nDZjRazP6WYlOZWEmg7OQuIhFenf
 H9iFsNZAnzJ0c62VLFsA9QgNmfHcTHxRegTDSknyiPg2c2f8xhphHy4a2dxWPg+VCBzG
 1/jA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782982560; x=1783587360; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YAtajG793ShkqaLXBEpZjRM8//AWh/xmHWjxP95LKZk=;
 b=TU/KQZWO3tI5AUGNlkDRGWEYqI2ntDw4odw8OpOc9FWaZcF0eZHQrPKvL4a4IvZiJ5
 SM1fvDd0MCbHTeLAYnbaw1CHKcOZAvkdCk6Efvodqm1jlHqaCjgtdF343HIybPoTUzW1
 d9LoBtRPx47Pv7tAbAXAL6WP/jKTSfMR7wZ/clImeCPHz0J8tgg/1ceI3cZL1TGk10pZ
 aNVgbklpADPcSDAy2Ln8FtHdCmc2cv/JnW2eytbXylFJU/+0pQflPuZw1Krmqr/hrXPI
 F17dUUH58TO3XELPl186A8PW6Czf35kiGQaEdPk8aJbZRTotNrEl83m8x+hSbnuOSlUS
 k0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782982560; x=1783587360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YAtajG793ShkqaLXBEpZjRM8//AWh/xmHWjxP95LKZk=;
 b=At0K3VIdPGMcPxngRYVdanhul4lrcQhYU9gzwR/QCE+xi7oYaKexdKYwLq2lb5wMHQ
 +6buoY0DBwLSosMfKWFRqb7DVnYtRTRJH3OGBpcPW5XcqUoSg8ovagwKAl7f2BDNblEy
 p0f3dWT+DgbeTbo4+MlbZu7AmvE57r42jUusUz+2p6ZR2CoDyWoEICQxSCU6ZzflN7JQ
 Tndsfg9wrWBviQfDy84GlQcmrsFc4/QnXbijwkefKB13uOvWIyI7RSTFqDUMoyCPQfqp
 xYrsJh7URLJ+JoxG/P2uLFEv4VsmChV4cNUSRUs9h3bneTz3Qt2uQ1HuwDN+t9J6/z7m
 1ENw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzAehF44MDCGFn1E1BJ+XyHs349QcdrHs/ANDw4JRajF3Ce4NUXHLCIg9qLIzjYZJLEauqFZE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywzb+BoRNfxqsRlYPSh/0/rUkYhU27AeKACL3gPeqJp2zDu14Oy
 DRJrdP6BQKFXjPbOzUT7uEFbvFTobuhIzx9F5s4GFBO083QtTlZAyRr5l/R89y2LpHjQpMyPCCB
 Oxo39hdTlU1OopFzzWg82/i0Mcj0twbzgiHpbOZCOOQ==
X-Gm-Gg: AfdE7clLh36BYgW+8w8D0ZpfazdU4hjR8TvRnOG7KiTbXI4POQWdEFmCnz5zfEuyQOL
 BxL6vELnAghC5BSK3vOJUmZ8u2SdJRMdQRBZnTnHWcW1AbFZdH71VR+B6LEV6ov9O3xRPo/cvMA
 2HC0957lDUrqUC+oD8a+WC2YPuKL9n1avtwUNgul8xTcbJP7m9XNvMl7xykQ4tdThbS6jwVkLfT
 MUhzcPd8fHAJ2S/weRr9n4cim7jbbLwGxW/uOrzKKDjAMgtc5OxeYsETZFxm8hZkQ+QaMBkZeBY
 tU5Iep+jZVUyU84X6baEHfU0yWz4tgw8LG3GtbCqO+zHO0VIu1N0cLYW2kGlcnsdwAnDtxqF8ns
 DgNy227E+YnYg83iMzazBX5cwow0vVGSL8hYcwmGa3g6XpXqPG1gi/cO2bjOg0vsXCzb9kAKi97
 VyZL4KqBMm74gojwTYtcxPAy371RMTivlkSFIPrYupHMSSE9CA+1WVnlVFI5yVWFCjjjmbda0g5
 lA2+/jvc7D8S79lRr4hoSUvTsAs9ax99ISngFpfFxj4Ed0N+LuVPZVW9ufI8cQ3OBs5O1agAGfb
 G/HN1iywF64sSwiqMMrp95/QO3MqLpbqiyMQO2yrjjv1bSjipEXWDKc9JVLYnTlCF9sIRik=
X-Received: by 2002:a05:690e:128b:b0:664:ef34:4b with SMTP id
 956f58d0204a3-66521d4b4femr4785556d50.76.1782982560253; Thu, 02 Jul 2026
 01:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
 <20260628082810.175862-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260628082810.175862-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Jul 2026 11:55:24 +0300
X-Gm-Features: AVVi8CcIhIpI8YLC0vVparGbRth7MiR32Uc4iqFNNaOWfOF_dESPsLdOM6fZCd4
Message-ID: <CAC_iWjLkwoqwv2Q77b3hi+dPpiv7aBKhWRSn7EX7KrpSDt6rbQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] efi_selftest: add ACPI configuration table test
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

Hi Heinrich

[...]

> +               }
> +               if (!checksum_ok(rsdp, rsdp_len)) {
> +                       efi_st_error("Invalid RSDP extended checksum\n");
> +                       return EFI_ST_FAILURE;
> +               }
> +       }
> +
> +       memcpy(&rsdt_addr32, &rsdp->rsdt_address, sizeof(rsdt_addr32));
> +       rsdt_addr = rsdt_addr32;
> +
> +       xsdt_addr64 = 0;
> +       if (rsdp->revision >= ACPI_RSDP_REV_ACPI_2_0)
> +               memcpy(&xsdt_addr64, &rsdp->xsdt_address, sizeof(xsdt_addr64));
> +       xsdt_addr = xsdt_addr64;
> +
> +       if (!rsdt_addr && !xsdt_addr) {
> +               efi_st_error("Neither RSDT nor XSDT address is set\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       if (xsdt_addr) {
> +               table = (struct acpi_table_header *)xsdt_addr;
> +               if (!memcmp(table->signature, "XSDT", 4))
> +                       return EFI_ST_SUCCESS;

We should check for both the RSDT and XSDT.
Just invert the memcmp I guess?

Thanks
/Ilias
> +               efi_st_error("XSDT address does not point to XSDT\n");
> +       }
> +
> +       if (rsdt_addr) {
> +               table = (struct acpi_table_header *)rsdt_addr;
> +               if (!memcmp(table->signature, "RSDT", 4))
> +                       return EFI_ST_SUCCESS;
> +               efi_st_error("RSDT address does not point to RSDT\n");
> +       }
> +
> +       return EFI_ST_FAILURE;
> +}
> +
> +/**
> + * efi_st_acpi_execute() - execute ACPI selftest
> + *
> + * Return: status code
> + */
> +static int efi_st_acpi_execute(void)
> +{
> +       struct acpi_rsdp *rsdp2, *rsdp1;
> +       int ret;
> +
> +       rsdp2 = efi_st_get_config_table(&acpi2_guid);
> +       rsdp1 = efi_st_get_config_table(&acpi1_guid);
> +
> +       if (!rsdp2 && !rsdp1) {
> +               efi_st_printf("No ACPI configuration table, test skipped\n");
> +               return EFI_ST_SUCCESS;
> +       }
> +
> +       if (rsdp2) {
> +               ret = check_rsdp(rsdp2);
> +               if (ret != EFI_ST_SUCCESS)
> +                       return ret;
> +       }
> +
> +       if (rsdp1) {
> +               ret = check_rsdp(rsdp1);
> +               if (ret != EFI_ST_SUCCESS)
> +                       return ret;
> +       }
> +
> +       return EFI_ST_SUCCESS;
> +}
> +
> +EFI_UNIT_TEST(acpi) = {
> +       .name = "acpi",
> +       .phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
> +       .execute = efi_st_acpi_execute,
> +};
> --
> 2.53.0
>
