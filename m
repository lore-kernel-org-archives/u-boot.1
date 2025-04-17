Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BDBC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 14:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D73882BA4;
	Thu, 17 Apr 2025 16:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A6YuUsww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC04582BD6; Thu, 17 Apr 2025 16:08:34 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C89F682BA2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 16:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso129890066b.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 07:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744898912; x=1745503712; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FAmoCFfbYie/QBIf82S5/+oLYdyk+jQMQdsvM2i5NRk=;
 b=A6YuUswwve1oa6nQf5PcC0Fa2k8KK+6zqStnnX0xW3P+qKjQthX9bSPND4xkqXshWw
 8pY7L0rxtA7ls603+XCJ5zJXL+smsfJywtF/cGce5DNRjor7mZJ4jxaxnoGKRx0usCiH
 4riQ9/MHEECKAysV3EfebMdo+voWULDf+J4F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744898912; x=1745503712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FAmoCFfbYie/QBIf82S5/+oLYdyk+jQMQdsvM2i5NRk=;
 b=Owhl1mJcI7K+rMpTueRe4y0R2vUywgON/cEZf04PnAblv0l6l9jfs97iEGFZ3fcKVZ
 rHcTY0vWYN8srSouUykZkziqTSoN5OutFLOeoaPoQ2o9CdnGXfEjnb3eMh1cmCYDiOuR
 DeKTZdlbtd1XSOQCfcCI8qnYl7exSZpV1fHWEtsOM+8Lk8ItWj4gMGtBvGC5h8+a3a5r
 abwCMPA9HFSl+yAfrBpQzdWA7wXCoMlbR/Ev0uLMIhjDNQb/JSNWeGsnOHiyFlb9C790
 ATHXWXOOWJAXKK2C2swT4iGglrpbt03pUradyR00oTt6lrjRaVwP5ZgI7b8xNRBLW8LW
 mR8Q==
X-Gm-Message-State: AOJu0YzQ5Fe/BU+dcPknInx0SLoVtjgAJML20+jCBdZt0wLTOlf+MHFI
 pzI4jWePObqIVZN2Ngnvi7nbHWRhN1K2COFusoIDmSPCAn3wvO/CUEsAnB3cR9eqRiTDyeMZ+J4
 U3ENT8LDag787F13iZZa6kkh91gy9VgsRjDSt
X-Gm-Gg: ASbGncsED/tXoZw1qc4bUAjzXYmILVZS+JUha6JLAI6Vo8ZuuZtIXH47bQrolMZlECJ
 c2RnPB7bmFFa3x/oHoCsVdrgTRowcRLl6QMdeM0mEqn7MMvLJ4onFehplXtHVD69JVjAf6ZPtFd
 +6TOJssR5YL4w/hfGRww4sUGQ=
X-Google-Smtp-Source: AGHT+IGM2wbv+ve7I1qtxvtE5V3uUJkB72IRRgBa0zcm/+QGDmSzImNxvceCc20XrasdIauFFzTyv5UL17AOidn8eW0=
X-Received: by 2002:a17:907:7206:b0:ac8:1efc:b993 with SMTP id
 a640c23a62f3a-acb42ad9886mr584686066b.44.1744898912075; Thu, 17 Apr 2025
 07:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250417135615.2974560-1-trini@konsulko.com>
In-Reply-To: <20250417135615.2974560-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Apr 2025 08:08:19 -0600
X-Gm-Features: ATxdqUGNes85Ily0uJBlFt_KntqSe1sb_T3a9ZqciQhouCfLSbit60QXZz3sRm0
Message-ID: <CAFLszTgWq5MwHa9Tdg0QLOmpdh1Np2x-=atuCc18Wz59pUHpfg@mail.gmail.com>
Subject: Re: [PATCH] cros_ec_sandbox.c: Drop spi.h include
To: Tom Rini <trini@konsulko.com>
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

On Thu, 17 Apr 2025 at 07:56, Tom Rini <trini@konsulko.com> wrote:
>
> As this driver needs to use the special sandbox <asm/malloc.h> header
> rather than normal malloc, it must be careful of the includes it brings
> in. It does not need <spi.h> for anything, so drop it.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  drivers/misc/cros_ec_sandbox.c | 1 -
>  1 file changed, 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/drivers/misc/cros_ec_sandbox.c b/drivers/misc/cros_ec_sandbox.c
> index 1cad51d474de..3ac690a37336 100644
> --- a/drivers/misc/cros_ec_sandbox.c
> +++ b/drivers/misc/cros_ec_sandbox.c
> @@ -15,7 +15,6 @@
>  #include <log.h>
>  #include <os.h>
>  #include <u-boot/sha256.h>
> -#include <spi.h>
>  #include <time.h>
>  #include <asm/malloc.h>
>  #include <asm/state.h>
> --
> 2.43.0
>
