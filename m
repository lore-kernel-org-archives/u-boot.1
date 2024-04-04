Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB32CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 11:01:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC0C88415;
	Thu,  4 Apr 2024 13:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I8wKfAmh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ADA088421; Thu,  4 Apr 2024 13:01:04 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE3A387D8E
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 13:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d48d75ab70so10961761fa.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 04:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712228461; x=1712833261; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rVUJAG/oXJ9Zn/rCB0Dc8o+pKlwT/eIzjdgxmHvQ9lg=;
 b=I8wKfAmh/3DlfdFCJHx8JnBAlIz2+Bn3lPV6JMSxTDquVhThiNS27eYvkGHt11TWg+
 y7h20ByWCft6TyQMZHYccBssap1A/pJtiG4yrHPF7n4JIJ9d+XzcCI5ck3ASax5Axeym
 ujcJhDlbv+0kit2FfRVwZSFx52Qv19ng5QDNjYotcaWXWQ+ai0spgURYYluSWpXPloWP
 htYVpVWGuHlehgElMhX/25Z7C+orCgUPOoKTot/Y7nMXFh2EoMi7A1Pf40bS3Cjc4LGy
 jH4sp24Rw9vdO6S2qkxKR0+QnxFcqmG5QTKhcixD0mvAb6oY5i32owIUit3rrd6m00IH
 GsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712228461; x=1712833261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rVUJAG/oXJ9Zn/rCB0Dc8o+pKlwT/eIzjdgxmHvQ9lg=;
 b=v4+9re6jcnzReMU3A65LPit+4JDuT18e8V+NywDaVH2h63Z2tJx2JnOHyO93x+L/yR
 mj8w/Nhlqv9VW/a4PC5vDrhnukNYKcV3eg0oG/vgQtSZyPaPG0m6GP7aeB8tCfGVYWR6
 0kP0QLyFkCL8B/MJESsvfZhnAkpUOWizVbdErxCDoQZuL/rpME+s4JCPnO9t2CNg4VwF
 u6Fh8Dt/TnHuuq50DQ1qj4P7sapsgmYf9VK/AlevmEfhiaTFPFLBd66HWDLDM/nTXAVM
 dbBUuF6HIXa7QE7vICMeImOJdkZ+Y9Fj6c+0m2JGyRoSMsYCy+3n7x5D/8MCIpj/TStj
 ae3g==
X-Gm-Message-State: AOJu0YxqzkuYv5Zm4Bo7THOJrF8bIRv8PaEIGBs9yQ7Y7M7206GR7X6P
 GheZeUBSjm0JfAmf57NVpEGmAzi5pGojNXrbqzWdnDOrfPb4LIxxVffK5Ef1WBfZAkBnnPX7XL7
 +Ame0JjEpaqOZbn/a2b4KnUgH8bk4U2KBWQngQA==
X-Google-Smtp-Source: AGHT+IFGSphrTJ+7BbXg55GYL1TA5/0Wuj8BSa8oKiAoY2HcvpHS4a6k0Zg+kfG1aIIspBRB6A+hZY24VDclgeHZAto=
X-Received: by 2002:a2e:9994:0:b0:2d8:4982:b52e with SMTP id
 w20-20020a2e9994000000b002d84982b52emr1521759lji.22.1712228461295; Thu, 04
 Apr 2024 04:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240404105248.3241506-1-igor.opaniuk@gmail.com>
In-Reply-To: <20240404105248.3241506-1-igor.opaniuk@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Apr 2024 14:00:25 +0300
Message-ID: <CAC_iWjKX94N+PhGEumTngiPRv7tSb7YxOpZHFAo33ZD9+ft2Dg@mail.gmail.com>
Subject: Re: [PATCH v1] MAINTAINERS: add entries for tee-related orphaned files
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: u-boot@lists.denx.de, jens.wiklander@linaro.org, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
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

Thanks!


On Thu, 4 Apr 2024 at 13:52, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>
> Add orphaned TEE/OP-TEE-related files to TEE subsystem entry in
> MAINTAINERS. This includes:
> - optee_rpmb cmd and test for it
> - Misc. OP-TEE tests
> - OP-TEE SCMI agent implementation
> - Documentation, including device tree bindings
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
>
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0462ade4ac6..0f7325d6045 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1642,9 +1642,18 @@ M:       Jens Wiklander <jens.wiklander@linaro.org>
>  M:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  T:     git https://source.denx.de/u-boot/custodians/u-boot-tpm.git
>  S:     Maintained
> +F:     cmd/optee*
> +F:     doc/README.tee
> +F:     doc/device-tree-bindings/firmware/linaro,optee-tz.txt
> +F:     drivers/firmware/scmi/optee_agent.c
>  F:     drivers/tee/
> +F:     include/sandboxtee.h
>  F:     include/tee.h
>  F:     include/tee/
> +F:     include/test/optee.h
> +F:     test/dm/tee.c
> +F:     test/optee/
> +F:     test/py/tests/test_optee_rpmb.py
>
>  TEE-lib
>  M:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
