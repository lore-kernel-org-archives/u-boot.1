Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EE6C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 14:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F1FA83095;
	Thu, 22 May 2025 16:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GTddSoo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18F28830B4; Thu, 22 May 2025 16:24:06 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D76D383082
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 16:24:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-708b31650ffso69947367b3.0
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 07:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747923842; x=1748528642; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QfgtXzhZwWrrfDAM22/5E4j0a0egcjkMXyU+u5cRw54=;
 b=GTddSoo6EggCgEMyx+ng8Ro7702PnEMPNzu+7ROD2ArETk9e1+YwJwARsCpm/9Isr0
 Ty8nBjqnvr6knqJWHPk55pCIikkN9q4ZeySjLnmv3me1mt8qoJ33adJBd7OZs+F5ZfGM
 kTle/FZ4iFQ0VyIvkZ6fwIsmAOXU0xR3hToTNnyaz6Y1mjjLB+udld+w9zBG+6raRAsO
 IGMoUfXfBo7cyZBfdf8xasWFJjPS4SWgff3CsZqSa20i4OL30ZDlLYGoNrvtdSHpCF8I
 TGNwTC5GxBP17xjL5MtbehXin+gh+f64BxvdQu5ICEbDhHU9wiOKKRYNRREm5kKqXU7O
 7Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747923842; x=1748528642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QfgtXzhZwWrrfDAM22/5E4j0a0egcjkMXyU+u5cRw54=;
 b=fUDmliDcDTDmnvBzhUaVnAM2v7io6ySn6pHL8flFVvJYUmF8peBOEzkoc/SJV9kwAT
 lR57mlt4hE4Ztmgr5PUWEe2wC2oEOL7eQWyOGK26irdFTvkx0xzDt6gxwJoBghEz/T+4
 sG6+LmlzCVhAiYef2wazBXbzKSo6gvm2M/greVTxaDOYiPKkKcrOLXU8hM0kttIIaHjw
 /pDw20Y54Zofi/waimv+rq2qK5sJB1SJJ27/keNh4VriIAMdRbB1EhEmX7j7gpAtEB1L
 n3v2CeyOeAaVG8gfFZhzdYeYdyIpSDMsWCv8nhiMVGttCK6/SgFS5EC0gFmzU6RWp9EC
 2ukg==
X-Gm-Message-State: AOJu0YwkInQAf+QTp1qG5/+yyAbjIIkSPuNQbeMzdNC3Kcb6IAKWLAJa
 uEz0zZ36WJz3LLNLkgBQURUTP1Y3NK+/DBJ14PbLndKas2tVdzwcgAsHk1aP1p5JJ+C+hEOueNC
 lrK72MzXow7yLy8xJUq+1kJPrO+HQK9cUnz5ntnga6A==
X-Gm-Gg: ASbGnctD/sHjsPfvLO1zTGg6RiUxFPClkx+jaLtHzWnhMZIc8HMntG31TejTtryeA5V
 LQ+Zt9hDi8r3en5qCxb4DHwp5BpwuqF66O8zfeRiaCQmMgsZ5VRYT8bTx6zsMh5uZeNU2Pyj5fE
 a4nhs2H8OaxKTqq+ZL8YHSpUbqKm0//7wrAQ==
X-Google-Smtp-Source: AGHT+IHNg7IzIy5Uc7KVV2M3hJzN0lCBALo2bFYYig3Vj8FiKUAfB936c5AkW0r+nLUF/IujrD+9XS0e5E35WqbGbUw=
X-Received: by 2002:a05:690c:6f85:b0:70c:965b:46f8 with SMTP id
 00721157ae682-70ca7bb31d3mr381366557b3.32.1747923842364; Thu, 22 May 2025
 07:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250521230119.2084088-1-trini@konsulko.com>
 <20250521230119.2084088-13-trini@konsulko.com>
In-Reply-To: <20250521230119.2084088-13-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 22 May 2025 17:23:26 +0300
X-Gm-Features: AX0GCFtdEEQb_sMKS4cWFJ9xvjaz3pHY6u12ZSW-qTPK4TEj-BJSKviZPpZ-_UM
Message-ID: <CAC_iWj+B_FFAKwF93GvW=fkd+23kLDJi+4AXXa_yvmhW_oiaTg@mail.gmail.com>
Subject: Re: [PATCH 12/17] include/efi_loader.h, include/efi_tcg2.h: Audit
 include list
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 22 May 2025 at 02:01, Tom Rini <trini@konsulko.com> wrote:
>
> In include/efi_loader.h we do not directly need <log.h>, <part_efi.h>,
> <pe.h> nor <linux/oid_registry.h> so remove them. In include/efi_tcg2.h
> we make use of <part_efi.h> but did not include it, so add it directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  include/efi_loader.h | 4 ----
>  include/efi_tcg2.h   | 1 +
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 84e8cfe320e2..f3c85ae8d663 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -10,15 +10,11 @@
>
>  #include <blk.h>
>  #include <event.h>
> -#include <log.h>
> -#include <part_efi.h>
>  #include <efi_api.h>
>  #include <image.h>
> -#include <pe.h>
>  #include <setjmp.h>
>  #include <linux/list.h>
>  #include <linux/sizes.h>
> -#include <linux/oid_registry.h>
>
>  struct blk_desc;
>  struct bootflow;
> diff --git a/include/efi_tcg2.h b/include/efi_tcg2.h
> index 7ed88809913b..34a3d4a04346 100644
> --- a/include/efi_tcg2.h
> +++ b/include/efi_tcg2.h
> @@ -17,6 +17,7 @@
>  #define _EFI_TCG2_PROTOCOL_H_
>
>  #include <efi_api.h>
> +#include <part_efi.h>
>  #include <tpm-v2.h>
>  #include <tpm_tcg2.h>
>
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
