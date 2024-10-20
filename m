Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2481FD3C934
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 04:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BE4A8901A;
	Sun, 20 Oct 2024 06:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IaCpZ3/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6D728901A; Sun, 20 Oct 2024 06:32:06 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98CD988DD1
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 06:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e2ed59a35eso2858188a91.0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 21:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729398718; x=1730003518; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WDzqrVbd0S4fgg+fIFUCU8gtaFaUaJIFTV755hvtKg0=;
 b=IaCpZ3/WZRzC1n948oGWIzFFaw4WMZKozaHYBt+EQjrIwGwv+6Y9eU07647AphyQHT
 zzJ86QPycOtJ5qqXBQ5SX732Ub3caZrVcgg7d0XQ3zmEWvfLifmjouYut/MlEDduZGy3
 CEuF/ZTxr9zKhOVIr68tmQC8HAIVSAPRegInsyt0DOXpUHIqrGsyaqZ43IlmVpBEE1qc
 1Vo0roEGA49QjOd19ZG4d9s0o7ZQBgK08gwM0rR+yj2Macs053EeSoR4+85MHyYNdDsV
 t7YFct2mzRzNglPKTmixjJ4GGUZP77AHNCrFunJomrLkNkK7Gy8itnn32qSRzqNZUFrr
 1rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729398718; x=1730003518;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WDzqrVbd0S4fgg+fIFUCU8gtaFaUaJIFTV755hvtKg0=;
 b=uKohk2DI2NRXkl7AgE8UR/Hfoq3DCLX6i9jKRK3sBeRZkNOGQeZRwErrXriAWAay18
 MdZbHPTdvzHCfoPdGX7ajrLKawHDaZzFhkQDk6P+UnDSwabC5AgnUX+HK75LUnRJaCwr
 0KCQc0pr6kNgdx4+sdc1vW6klqK0FUOhQvnMFnAR8ZSUMk6uOqH2qc2wX4IWymG0HFN/
 +2RLjBcVI11sKcz1pWRUVqQmSOlEa9XJp/+tCdblt4m6FvnLfZ5LPF204wN2030KeXmz
 Uk3TNy4AA+O5T9hzC1rWMFPI0joVm9lKeBARk2hHdOb62PMZwpLOkwVZrec73RBiPCEm
 DFAQ==
X-Gm-Message-State: AOJu0YymPgT1MOeSw55yhszDs6KRcBhq2WfedghwbNE0AVT5tP7jsOtS
 ENeW6etmaq/NNr95by02CpnwngjMrvwUURdHHuh1Mj29iDyqNUF/eCkV13yVSqur5Iir+ycKuEL
 qCXOB7xd3GtLOyW6OJfRf/COqhNZXgMS12XjxO9Whn2yHMON/tp0=
X-Google-Smtp-Source: AGHT+IFihsCcbjjOx0NhN8JkC4avVgUZ8sKCLwtItRZL4+hs8Bw5QIM5H0t6ZFWOmj5LJObpIEknqxajNKCiWMTKfaQ=
X-Received: by 2002:a17:90a:6305:b0:2cd:4593:2a8e with SMTP id
 98e67ed59e1d1-2e561733904mr8054214a91.15.1729398718059; Sat, 19 Oct 2024
 21:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241019085029.22151-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241019085029.22151-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 20 Oct 2024 07:31:21 +0300
Message-ID: <CAC_iWjK1aDk86u--BcN9rZnKzjO_O0EukbO8UT088rw2Fu8wDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_selftest: fix typo 'got languages' in HII test
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Sat, 19 Oct 2024 at 11:50, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/got languages are/Available languages:/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_selftest/efi_selftest_hii.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_hii.c b/lib/efi_selftest/efi_selftest_hii.c
> index f219c0120a3..c363df466dc 100644
> --- a/lib/efi_selftest/efi_selftest_hii.c
> +++ b/lib/efi_selftest/efi_selftest_hii.c
> @@ -913,7 +913,7 @@ static int test_hii_string_get_languages(void)
>                 goto out;
>         }
>
> -       efi_st_printf("got languages are %s\n", languages);
> +       efi_st_printf("Available languages: %s\n", languages);
>
>         result = EFI_ST_SUCCESS;
>
> --
> 2.45.2
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
