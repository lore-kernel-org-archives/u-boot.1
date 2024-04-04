Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCF4CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 08:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 996158839F;
	Thu,  4 Apr 2024 10:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mO7FSwIr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36FD4883A2; Thu,  4 Apr 2024 10:21:10 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E41E188275
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 10:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-516bfcc76efso745009e87.3
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 01:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712218866; x=1712823666; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wOqJ+8MWH8krGGW4Ic4UTTSwUWntOCZQeZ9iBi1MpqQ=;
 b=mO7FSwIrZFUvvQjCJDTz/sNY9CeDADIqQ0E1558sUr185V9ul7f99R71+pq+yp+OIb
 k4qqkox3ZAXbhoVQRcqgym/DH6p+DG4a++zu7fTTNyQASQE8e8G7tbRIkW2Lhs4v5I0P
 Oj+62ZDkU5JMfugUUFJjgtt9C0VX2pbPBurlfLgeRbUKvtUsl9Dty4qitPuijUJTqCIN
 hunoeGtguvmACUw12++e1sVHGGvMm3bVhkjlUT7hOyhy/seONCectPQmzVAcQmRNZBTN
 2Rt4hD79yFx6LJI8AIYjSeHMedzFV9on9R+I5t1aLzn77zI2WdZTP4CL4nkI8a1hmiIx
 Uo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712218866; x=1712823666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wOqJ+8MWH8krGGW4Ic4UTTSwUWntOCZQeZ9iBi1MpqQ=;
 b=CZVdlH3yNPtw2IpplMq8RHNqpSFKU4SkZZSDU0mVODglOCTXtMtlECvFbfrYdNYopw
 AyOHkJGcuKiKlWYvtEyiZZ4vmCzgPyl6wUGTppy41m0Ph/eg9bSNvEdm0ENot+p0Meo3
 MKG2dRrlH8uNM/6TdVQf4S6QBRU3WRfCqqg/Q0Uuh3zWIaqC+sax5ZtE8JCcmS0n2rkM
 bsBfzz5mHF+j2jggJ/PopciByPbNk/LQaO9R2v/yI9HArtlxi9WTxsUUPl+A7+pDbKFp
 CqHyOWoxLwclbPAYC/XKmfdOzpoHk/9pMH1G9HPKPft3dG4JVBAcXqG9891IupxRONh5
 jIhQ==
X-Gm-Message-State: AOJu0Yyp9MDlzQSF4lri+MmTmXZqQLSdZNo8UsuAkVteEMDRNs5LnDKN
 TFF942P8QyvI0GOI8gBlfTOQ9U1fehmNCWdz1FI7oF5b7OJa1z8XG83sw0p3995v2vRRMPR6YH+
 aIZz4mmSpdYpxstw6eTnxBW1XVsNjRSuSKsh9sw==
X-Google-Smtp-Source: AGHT+IFn3kW4EBfBY62RnazhyrKXH4HYArYcYfO/qv6wSP5C/hXcE3uubbfb9fWmIDJpOmFkk5fKiPUPTfQNL7Kdrg4=
X-Received: by 2002:a2e:b52d:0:b0:2d8:319b:7d34 with SMTP id
 z13-20020a2eb52d000000b002d8319b7d34mr1018571ljm.2.1712218866211; Thu, 04 Apr
 2024 01:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
In-Reply-To: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Apr 2024 11:20:29 +0300
Message-ID: <CAC_iWjL=PVxzn8Nvcx89+ZoOv2VRT=TdrT_usjxoUgfuvS5rgw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] TEE: minor cleanup
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>, 
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

Thanks Igor

I'll pick this up

On Thu, 4 Apr 2024 at 11:13, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>
> - Address some spelling errors and typos
> - Support CMD_OPTEE_RPMB for SANDBOX configurations and add python tests
> - Remove common.h inclusion for drivers/tee
> - Add calls for closing tee session after every read/write operation.
>
> CI build:
> [1] https://dev.azure.com/igoropaniuk/u-boot/_build/results?buildId=31&view=results
>
> Changes in v4:
> - Rebased on the latest master and excluded "tee: sandbox: fix spelling errors",
>   as it was merged already by Heinrich Schuchardt
>
> Changes in v3:
> - Added calls for closing tee session after every read/write operation
>
> Changes in v2:
> - Fixed chimp_optee.c:37:9: error: implicit declaration of function 'memset'
> - Applied R-b and T-b tags
>
> Igor Opaniuk (5):
>   tee: optee: fix description in Kconfig
>   cmd: optee_rpmb: close tee session
>   cmd: optee_rpmb: build cmd for sandbox
>   test: py: add optee_rpmb tests
>   tee: remove common.h inclusion
>
>  cmd/Kconfig                        |  4 +++-
>  cmd/optee_rpmb.c                   | 23 +++++++++++++++++------
>  drivers/tee/broadcom/chimp_optee.c |  3 ++-
>  drivers/tee/optee/Kconfig          |  2 +-
>  drivers/tee/optee/core.c           |  1 -
>  drivers/tee/optee/i2c.c            |  1 -
>  drivers/tee/optee/rpmb.c           |  1 -
>  drivers/tee/optee/supplicant.c     |  2 +-
>  drivers/tee/sandbox.c              |  2 +-
>  drivers/tee/tee-uclass.c           |  1 -
>  test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
>  11 files changed, 45 insertions(+), 15 deletions(-)
>  create mode 100644 test/py/tests/test_optee_rpmb.py
>
> --
> 2.34.1
>
