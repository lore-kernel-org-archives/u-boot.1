Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA97C83000
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 07:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 978F581E13;
	Mon, 30 Jun 2025 09:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CUwqQit/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70CC981FEE; Mon, 30 Jun 2025 09:23:44 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 197D680B9B
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 09:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-70e3e0415a7so38412317b3.0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 00:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751268219; x=1751873019; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qb3u8q2k68qjHnDf5TitdCbZta15+jmt66v4Wpqm/qE=;
 b=CUwqQit/OvE4NPsMqDAD4l9AnfbqIBeBEjD/NaGK28U8prXmobdtHJSpwNpYmeb1s7
 mvvGarjdISGo2IsJOoWAiwz4oQxG7giMuu0Dg6LMTt9bWZwfqsvyyJUKh3MjLBO6g4Iu
 uId+D3M4UWPe0O0dQXIh7YYT4eJXwyrgia57j7Q0kJ1OHd4Ls4CWD63x0/xGu3659pIV
 1T3t3uDU9BmsYr5lZgSkxJsZSBBUzcQFAkFH7TfQB3IUhzbNZW0K+3yH98QM/ZX5Zlz3
 CyN68JE4fCwzOMJYFHdQzvRG3n7DQ2w7L93ENmqeMowcAFj504Zd5wsh12yU/z/baTr6
 cgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751268219; x=1751873019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qb3u8q2k68qjHnDf5TitdCbZta15+jmt66v4Wpqm/qE=;
 b=vdmEHILCyCNYmknrOtkCgsCZqWdXzhLw80ERdIPZoDDCBO4/OPMGUjjVKRj+yxo+ZT
 W/fQWhsda7N9t+cDppZ4EuUSivofMzGgWqKXLYlv4hrBcbjzKqtwtgV0TTbqX+YGX0C0
 gJn8/iU236YK9v/JgN4vPeaqV2rjTDdIJ1qqHVDp4BrRcDzA5QmcNr9dUugTpuigsyiB
 OrjPIEzcvnAFPRqk6waNaoLzC6kQG0Ca+TJgJ6o3dc/4SLMPWuKgAEVWZie/qUctHCTn
 +vlkIoVqiiqdq3CXuXaINECUZY8ClVs38CjoBPtu4KwcRCX6CzYYjn9ml7JbAtui4JJw
 ALyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4WViJdyRRYaLWF9l7bQEcPrzESfSK2TVjwy1ya3NG61L/ZQ0ToFhvsYAlNIxnK+8xPGq10qQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzMaM/zoKuDDk0oATo9CAEqbOphiHVGwbZ93qgcGa89pLWi0rIj
 xDq4Kg09LIfoYBgJVpNyssS2fgg2p3NWJHqRaRkeXSzfjf9Ejk8hmcooeq/ABBFXE0htfRtNfKl
 AN8TomiDdIRG6hJmTDMXQtakldyFFnzM+UXM/w4XyOA==
X-Gm-Gg: ASbGncv3LgLa8hAexEHnj62slCeEJUrvp3n7h1j/aBoPhSfMeMJoJ7vAenoDf6h+bgn
 YtIevxcxpW1hMIZCOR2kA8QfOoWClAKlkmhRMqm+6ANWldC2pYDxF3lZmAH3dzP9BmmLXFiE5sx
 bYvABeYLBFm/Uc65xmW758kBydCfPFVNIfwGxFH5lgLLL4
X-Google-Smtp-Source: AGHT+IGGoerzQh1ej2NZ7Zo/tlJaT2SIPc6xdjkvQ5gbzknMux3ZPSUQlomaYlszTCxLhP358lvEx+2rJ6QhiO3kGt8=
X-Received: by 2002:a05:690c:7089:b0:70e:4d8:5cab with SMTP id
 00721157ae682-7151755887dmr179803767b3.2.1751268218824; Mon, 30 Jun 2025
 00:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250625-tpm_enum-v2-0-ea3f84f6b639@linaro.org>
 <20250625-tpm_enum-v2-1-ea3f84f6b639@linaro.org>
In-Reply-To: <20250625-tpm_enum-v2-1-ea3f84f6b639@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 30 Jun 2025 10:23:03 +0300
X-Gm-Features: Ac12FXxaKVF0eGIo61of-MMVOmaOK412ZO6c8SeOE6ZnArHSke5mlz_JClkIXHw
Message-ID: <CAC_iWjJ69F_1n7V3jFLDggcot2OW+VaSAMuKs07SXjGk0P1J3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cmd: tpm: Fix attempt to return value not in enum
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
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

Hi Andrew



On Fri, 27 Jun 2025 at 12:37, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> The function tpm2_name_to_algorithm is defined as returning an
> enum for the algorithm specified but it also attempts to return
> an error on failure, but that error is not included in the enum.
> Add the error to the enum so that it can be returned.
>
> This issue was reported by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  cmd/tpm-v1.c                 | 1 +
>  cmd/tpm_test.c               | 1 +
>  drivers/tpm/sandbox_common.c | 1 +
>  include/tpm-v2.h             | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/cmd/tpm-v1.c b/cmd/tpm-v1.c
> index 6e019d1c729..25402f7543b 100644
> --- a/cmd/tpm-v1.c
> +++ b/cmd/tpm-v1.c
> @@ -8,6 +8,7 @@
>  #include <malloc.h>
>  #include <vsprintf.h>
>  #include <asm/unaligned.h>
> +#include <linux/errno.h>

Why is this needed? Shouldn't it only be on the header file?

Thanks
/Ilias
>  #include <tpm-common.h>
>  #include <tpm-v1.h>
>  #include "tpm-user-utils.h"
> diff --git a/cmd/tpm_test.c b/cmd/tpm_test.c
> index af83d78c3fe..1d9644d5aae 100644
> --- a/cmd/tpm_test.c
> +++ b/cmd/tpm_test.c
> @@ -7,6 +7,7 @@
>  #include <cpu_func.h>
>  #include <log.h>
>  #include <time.h>
> +#include <linux/errno.h>
>  #include <tpm-v1.h>
>  #include <linux/printk.h>
>  #include "tpm-user-utils.h"
> diff --git a/drivers/tpm/sandbox_common.c b/drivers/tpm/sandbox_common.c
> index 596e0156389..4bc003a2c09 100644
> --- a/drivers/tpm/sandbox_common.c
> +++ b/drivers/tpm/sandbox_common.c
> @@ -7,6 +7,7 @@
>
>  #define LOG_CATEGORY   UCLASS_TPM
>
> +#include <linux/errno.h>
>  #include <tpm-v1.h>
>  #include <tpm-v2.h>
>  #include <asm/unaligned.h>
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index ece422df0c7..6c516dd3c9b 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -266,6 +266,7 @@ enum tpm2_return_codes {
>   * TPM2 algorithms.
>   */
>  enum tpm2_algorithms {
> +       TPM2_ALG_INVAL          = -EINVAL,
>         TPM2_ALG_SHA1           = 0x04,
>         TPM2_ALG_XOR            = 0x0A,
>         TPM2_ALG_SHA256         = 0x0B,
>
> --
> 2.39.5
>
