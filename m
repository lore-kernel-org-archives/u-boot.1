Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E0FC10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 18:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E9AA8826E;
	Thu,  9 May 2024 20:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VsvrouV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E84088113; Thu,  9 May 2024 20:03:50 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15608884AC
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 20:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2db13ca0363so17903671fa.3
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 11:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715277827; x=1715882627; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RqZ4UD0gTkR0pW/mRn/Y6Y72qA+hg35d8Od6w7zkrtU=;
 b=VsvrouV4cQmSj4X2nIE2kU60tj78lfgkmDJiIPqMijeoXzcNKUMusn80QywlcszVFf
 /FlNvNbDUy+AIJDbL3V6pO6IEXmG2YR9fry+ZJGbv/XmstmzCcVtXCx1JaBSG9N0g/lu
 bOR2GCCwfJvueU9JtKVHJom4DpXZ8FA9ecETxTaglwQhrHD23QN47yvq0MCIPClEGuwM
 OKMvOuYyLsj4Te7gInKY72sdhlMndrREPBPtKsVT/FiisvTr3aAzy0ptHq4WW2UjizAN
 8+X3FFny7pZ8PGUECZIU3GMAbITEldrCju8QuWs69rOCpPZQFcOHWOAj+bXLxROKPBh8
 TyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715277827; x=1715882627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RqZ4UD0gTkR0pW/mRn/Y6Y72qA+hg35d8Od6w7zkrtU=;
 b=TrEacKoWfRaY2uvT3g+/EGawAhk45P9v9ShIyi8RNvASyTs+je3llD5ZAKJrJgU/uo
 ycO0QrFF5C/u6gAL0wRcjOMzxhne6C64vY94GtnT+k+ByiLkixd7dPQvEqqZw47MCX05
 f/6Wlx2CozCVaAhQjcZ4sp14Lsw3HuvnO4cHMoPR3eWoWrQsLa4C/IkuASlCxajWEhZ4
 CUuZa/Jk7rhAVAU0WJjh2ZZQhybDi4qstpJXkE8WkawVRV8q/5qGFq8852uo1FPRPgtC
 MSbdP3Q50yECtVWX5twn3cmp9btpFpxQcsBow0oHYKjii9d+qfP7lFbD+fXOOU6jvEQM
 n+xg==
X-Gm-Message-State: AOJu0YwCbncK/S520/Piu4kXDj1HUUoTwanRY3AJdbxO4Hl2aqt+3u9d
 pk64lPRcaX68hvL1hFeVm5rznPe+XGYppjWoZdyISlaRB+q2ADjfGGgFEl70zoyqsopN1IaW2yh
 vnGtNUhxYcQpcraFvHufw/CJ4WaGvKjrAATzb+A==
X-Google-Smtp-Source: AGHT+IE+JsM7DhM1bTYuPsK6LtHGnVYBrra2UhzBYV/zVauFEqyah8oR7BtHtmLMj82EOBOcv1sqKs07ClzMv9PXZNA=
X-Received: by 2002:a2e:9d14:0:b0:2e1:a504:f9ec with SMTP id
 38308e7fff4ca-2e51fe542bdmr1853441fa.23.1715277826899; Thu, 09 May 2024
 11:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240509143743.1496210-1-raymond.mao@linaro.org>
 <20240509143743.1496210-3-raymond.mao@linaro.org>
In-Reply-To: <20240509143743.1496210-3-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 May 2024 21:03:10 +0300
Message-ID: <CAC_iWj+rfPf7WZpTq+TzNfWfpqx8s5ivDmFfLiL0SuAJTBvquw@mail.gmail.com>
Subject: Re: [PATCH 2/4] efi_loader: remove redundant hash includes
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>
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

On Thu, 9 May 2024 at 17:38, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Remove the redundant includes of u-boot/sha1.h, u-boot/sha256.h
> and u-boot/sha512.h
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  lib/efi_loader/efi_signature.c | 1 -
>  lib/efi_loader/efi_tcg2.c      | 3 ---
>  2 files changed, 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
> index f338e732759..184eac8cddb 100644
> --- a/lib/efi_loader/efi_signature.c
> +++ b/lib/efi_loader/efi_signature.c
> @@ -17,7 +17,6 @@
>  #include <linux/oid_registry.h>
>  #include <u-boot/hash-checksum.h>
>  #include <u-boot/rsa.h>
> -#include <u-boot/sha256.h>
>
>  const efi_guid_t efi_guid_sha256 = EFI_CERT_SHA256_GUID;
>  const efi_guid_t efi_guid_cert_rsa2048 = EFI_CERT_RSA2048_GUID;
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index b07e0099c27..ac056dcfc55 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -19,9 +19,6 @@
>  #include <tpm-v2.h>
>  #include <tpm_api.h>
>  #include <u-boot/hash-checksum.h>
> -#include <u-boot/sha1.h>
> -#include <u-boot/sha256.h>
> -#include <u-boot/sha512.h>
>  #include <linux/unaligned/be_byteshift.h>
>  #include <linux/unaligned/le_byteshift.h>
>  #include <linux/unaligned/generic.h>
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
