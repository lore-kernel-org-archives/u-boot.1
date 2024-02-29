Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0884DC48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 19:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9BA880ED;
	Thu, 29 Feb 2024 20:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tee2qg8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13F7E880FB; Thu, 29 Feb 2024 20:11:46 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7F2C880EC
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 20:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33e12bcf6adso245637f8f.1
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 11:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709233903; x=1709838703; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rxbwkj9ul4Vy/bXwUW7nbTTzGYVyFvdes7nxZPnWqJ0=;
 b=Tee2qg8FI+m1T5iAgNczIMempTY3N/KhyQHTDLDkQqGI4yN5Tyi63RGEqdbaoOW7zT
 bBLkYnZBPAGaaSAbSfbAReXURzgGRM8bh9YwCXZfeYAmwXExrj7Zs/lsl7A7t87PM2o8
 PCVhAQsWq8HuFsapDuVQAbQ1e2DWx6g+zklKB2+4Vd8Q43zFCgnqhBkOVvl9gaqr7lph
 DBzPLatTVjJKRCadEjrOn/r6bSU12kv8Yf6pB8S12dCmWbL66BdA+DZlFGoAGWqWokXz
 QERxju8tnal1Ozcf8U/daF/pHxrI2s+248orz5zxx8Icios229RmpzPDzLjiCNU0+E+e
 MBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709233903; x=1709838703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rxbwkj9ul4Vy/bXwUW7nbTTzGYVyFvdes7nxZPnWqJ0=;
 b=FpPJ7eDIs0/koGlllvm+PgfyujyqIHdDMHFdzNcVFq9Tfi776SgGqS9+gEd7bGUB/i
 pcDTyaISBqKqZixYP9Z2KAJXQp23WDp6UnB6U4dsv7BrxC7pSDBSuMuAGKiqPHikLRCo
 IDx4Sui+TzEL/IT7vbh0mThwj8pF6pJBsgUYxtJvgALIpTD1vEa/As7w0AomWNQ+mEYg
 +KQTjGMWXqCfpTZB8mbNihL+7xoXZDE+cNuYVl2NHPjISAJd0Ipj3c+kyb3WSH+lXbNZ
 6mH69pGNdmmq5R3raE5UuPtxkKQEIhkcm749XqFY7TdZkE8YiEchZvH3oikGv+aAYOCg
 33Iw==
X-Gm-Message-State: AOJu0YzpkpXcG+MLxZWPYq1mgGfMckDQoPXC0r4JSHa5NhTh5KRlrN6t
 5WsOpycE1q+ExouE+oUe29PNqXftM1S2PKS2kZwMFFMeOjpEKaLVKITjekyb/yDs7M8Q8d5ho7J
 EhbhG0InwNsIVJeV84Ev6xrsUM4k=
X-Google-Smtp-Source: AGHT+IFEkGULpcUa3oPTgcya+sn0o1AiqfChTT58fzB3EvA0BGQ0HvMKsAIk8S7PAaimIl20JRD0YGGkuWMQrB2S890=
X-Received: by 2002:a05:600c:3b82:b0:412:94ab:77c with SMTP id
 n2-20020a05600c3b8200b0041294ab077cmr2442635wms.3.1709233902994; Thu, 29 Feb
 2024 11:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20240214183444.493629-1-igor.opaniuk@gmail.com>
In-Reply-To: <20240214183444.493629-1-igor.opaniuk@gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Thu, 29 Feb 2024 20:11:31 +0100
Message-ID: <CAByghJY_Eyf6s=V+5Hjo1gVxkzCPieABkk_NpFK5HM_K=SE_+g@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] TEE: minor cleanup
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

On Wed, Feb 14, 2024 at 7:34=E2=80=AFPM Igor Opaniuk <igor.opaniuk@foundrie=
s.io>
wrote:

> - Address some spelling errors and typos
> - Support CMD_OPTEE_RPMB for SANDBOX configurations and add python tests
> - Remove common.h inclusion for drivers/tee
>
> Igor Opaniuk (5):
>   tee: optee: fix description in Kconfig
>   tee: sandbox: fix spelling errors
>   cmd: optee_rpmb: build cmd for sandbox
>   test: py: add optee_rpmb tests
>   tee: remove common.h inclusion
>
>  cmd/Kconfig                        |  4 +++-
>  drivers/tee/broadcom/chimp_optee.c |  2 +-
>  drivers/tee/optee/Kconfig          |  2 +-
>  drivers/tee/optee/core.c           |  1 -
>  drivers/tee/optee/i2c.c            |  1 -
>  drivers/tee/optee/rpmb.c           |  1 -
>  drivers/tee/optee/supplicant.c     |  2 +-
>  drivers/tee/sandbox.c              | 10 +++++-----
>  drivers/tee/tee-uclass.c           |  1 -
>  test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
>  10 files changed, 31 insertions(+), 13 deletions(-)
>  create mode 100644 test/py/tests/test_optee_rpmb.py
>
> --
> 2.34.1
>
>
Are there currently any comments/objections that can prevent these cosmetic
changes from being applied? If there are - just let me know, thanks

Regards,
Igor

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
