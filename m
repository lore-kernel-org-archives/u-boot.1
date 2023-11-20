Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D412FC2BB3F
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 20:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E3D9874FC;
	Mon, 20 Nov 2023 21:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LPn+AlQG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3215C871FC; Mon, 20 Nov 2023 21:47:03 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3634B87562
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 21:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5098e423ba2so6719768e87.2
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 12:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700513220; x=1701118020; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9v3NHT9EroVLludgMR0XhLPGZplubQL5ZP3t7mOYcOM=;
 b=LPn+AlQG7B+cK4FsJ4shqEy6JdHVfkvooCXawumzlMLohd0rOlWjZqryOgpXkKx0oM
 OG/RXl8Xb/n4aZfDsBI6RMpiMz9nBMlCcklM2+TM0AB9Hk9BpYOl5qPhp/ZEvSZckaWG
 MuISxww+qBsRA9keGB4YpRV/p3KeoniDs9weLwlHvurVoCjQJ0ctlBE9v/UtDG5LuZ+A
 Uo1cqOGQGzFdB5gIep5g9WWhGCwO3KNuhKoYiq0OpYCgdVPT8Gv5p7zrh5QD2yQeHwTG
 ToQDc/dL7TbC9B4P63lCrOZz6lTvnnwY5tp1coZBV8sWTnpvF7q+P2HOIYIlsC9fxPPi
 fsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700513220; x=1701118020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9v3NHT9EroVLludgMR0XhLPGZplubQL5ZP3t7mOYcOM=;
 b=lp4nY+xe62cR1D9fN45Y8fIJjj/TqRK1xsE2Xgoxt5lWOUea330CnU2FdcNeuKaUYM
 bre6DsjgS3MX4Fdpu8WgQH92g0AV4SXrzib64D5C0FR3I+PDkPI2JTw99iSjrb4M6Y4P
 sAfeAD+eFz8jc7t8dU43bFm0/GUUqoPSU4N7Qx0uXIinPim5qZ1xiKcnk19B/ItXCBVc
 sbBje3XDSF3ldzZXvu2p2v8qKASnOx1+EIu4mOTPtSbXiLJ16ZZtBnMZbekS1mUp4qlA
 M/SvYYnfmveW+vL3LFzLcmwwC983DeV7vRW09Q1huImT0eBVf99rN3VCHEJgj/Q4ztHL
 2wnw==
X-Gm-Message-State: AOJu0YyuGT1zxCae6OrOLfB4EVSCtSVMnibFyaTMEJB0L2GYDeY2LhkQ
 Cdwg0AVIWJzj4+d7HLWqgZTidGeWmQ2r4mEplrZAKg==
X-Google-Smtp-Source: AGHT+IFSr37zuiMUbWRgS4cc53opSJp1IHt99RFkSnz8QvtLoA1u8etkU6Ep6TNcFieZmq3ecWF3A1jjCrb+r0tPcFQ=
X-Received: by 2002:ac2:44d0:0:b0:4f8:7513:8cac with SMTP id
 d16-20020ac244d0000000b004f875138cacmr6056102lfm.48.1700513220487; Mon, 20
 Nov 2023 12:47:00 -0800 (PST)
MIME-Version: 1.0
References: <20231118210547.577026-1-sjg@chromium.org>
 <20231118210547.577026-4-sjg@chromium.org>
In-Reply-To: <20231118210547.577026-4-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 20 Nov 2023 22:46:24 +0200
Message-ID: <CAC_iWjJkrT2pAoB7hRLYDwB4wsCh_sa37d_MhT-SuwkHCAZ++A@mail.gmail.com>
Subject: Re: [PATCH v3 03/32] mmc: env: Unify the U_BOOT_ENV_LOCATION
 conditions
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Peng Fan <peng.fan@nxp.com>
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

On Sat, 18 Nov 2023 at 23:05, Simon Glass <sjg@chromium.org> wrote:
>
> The declaration of U_BOOT_ENV_LOCATION() uses a different #ifdef
> condition from the code it calls. Use the same condition to avoid a
> build warning if CONFIG_CMD_SAVEENV is disabled.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>
> (no changes since v1)
>
>  env/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/env/mmc.c b/env/mmc.c
> index cb14bbb58f13..da84cddd74f0 100644
> --- a/env/mmc.c
> +++ b/env/mmc.c
> @@ -495,7 +495,7 @@ U_BOOT_ENV_LOCATION(mmc) = {
>         .location       = ENVL_MMC,
>         ENV_NAME("MMC")
>         .load           = env_mmc_load,
> -#ifndef CONFIG_SPL_BUILD
> +#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_SPL_BUILD)
>         .save           = env_save_ptr(env_mmc_save),
>         .erase          = ENV_ERASE_PTR(env_mmc_erase)
>  #endif
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>
