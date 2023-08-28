Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2C1C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BC31864C4;
	Mon, 28 Aug 2023 17:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="f+FBCyed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4D6F864CD; Mon, 28 Aug 2023 17:30:16 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC92E846B8
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fef56f7223so30164085e9.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1693236613; x=1693841413; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c46g52C8nLECdy87YNxNZ/n4dXq4ANEZNANvWG58/bk=;
 b=f+FBCyedZYG08RFYhXZQENoSMroOmzoE4/i14MMdCFyWOIOrLG+ISPybBG65qnKxQx
 Sfg+kWeHFz4wmeP1aPP63fSrHXkPZtxzYVaeZ9ggDE/UGs4UkcP+0UsdBbP4xtEjLzSl
 MLbHwapMn0WaVKJKHexVRNsaYvtMmyUEBb2Q4DUQR8DqvFDMgBh58zc33FexUnIBJ8rX
 FjuHb3TIZ5+3HDkB0DdIuKoNrk/d50xrV4e0Dc7Z7Zy3VSJUTFxE3BVbTDUN75ZIyfO8
 YHCndaAzoSfrmH89ORGshoFJLM636BDfrksfMYR+57+J5cEffcIgUGsJJrgl5Cn31xA/
 lssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693236613; x=1693841413;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c46g52C8nLECdy87YNxNZ/n4dXq4ANEZNANvWG58/bk=;
 b=CrZVG72r2Ap7v+7EdYLVbLbVJpJYl4119dhGsXlYkzZIX3BACIVK6JmjjBwxTBkCSc
 A1Seryu10TM2GV4hS6IIkjRS4Xjw99wVHRpfPliqHvVO68q977kn1yIPZ0KvDbF9eo/F
 5JC4MMzbFWLQQtQwwtvTBjpCTnV28d1mLWFUAi3NpzWYT+UZMFo+Yt3m4LR8CGlr4j4L
 IxUwIbYd7f78MPYyWNvY8uOHaiCJMGMHGCChnF1qF/THmtmxMBMsehItLIdKSHHINdwB
 LTICYZ0NoDGOERk05M137/gFE2sqP3eKpG83bzZ4gQHUQcD7uysVnYdDp8N9HN4wyNpM
 TESw==
X-Gm-Message-State: AOJu0Yz45CQDw3tEa43dL3w4V+MJwHlHksxXO/58du3O4VWZK1EgfTCG
 Qj737hw88mgCGoF0eaWqlRiGaw==
X-Google-Smtp-Source: AGHT+IFTG0UXIbxMx34ZV/WaHCk9u3CmT5EF4gj3+RW1HIAqiNfeIut7h+6Uo1HAgpWvG7+IcCvQ8Q==
X-Received: by 2002:a05:600c:2296:b0:401:73b2:f03f with SMTP id
 22-20020a05600c229600b0040173b2f03fmr9046768wmf.0.1693236613249; 
 Mon, 28 Aug 2023 08:30:13 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 m24-20020a7bca58000000b00401b242e2e6sm12158695wml.47.2023.08.28.08.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:30:12 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V6 08/20] include: configs: am62x_evm: Drop
 distro_bootcmd usage
In-Reply-To: <20230825180305.69515-9-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-9-nm@ti.com>
Date: Mon, 28 Aug 2023 17:30:12 +0200
Message-ID: <875y4zw5ff.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On ven., ao=C3=BBt 25, 2023 at 13:02, Nishanth Menon <nm@ti.com> wrote:

> Now that BOOTSTD is used by default, drop un-used header file
> inclusion.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> No change other than picking up reviews, tested tags along the way.
> V5: https://lore.kernel.org/r/20230824031101.3460411-7-nm@ti.com
>  include/configs/am62x_evm.h | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/include/configs/am62x_evm.h b/include/configs/am62x_evm.h
> index 81d7658cdb0d..c8fe59b75313 100644
> --- a/include/configs/am62x_evm.h
> +++ b/include/configs/am62x_evm.h
> @@ -9,11 +9,6 @@
>  #ifndef __CONFIG_AM625_EVM_H
>  #define __CONFIG_AM625_EVM_H
>=20=20
> -#ifdef CONFIG_DISTRO_DEFAULTS
> -#include <config_distro_bootcmd.h>
> -#include <env/ti/mmc.h>
> -#endif
> -
>  /* Now for the remaining common defines */
>  #include <configs/ti_armv7_common.h>
>=20=20
> --=20
> 2.40.0
