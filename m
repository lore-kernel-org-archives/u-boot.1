Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE08CC3DA64
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 19:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 780D688703;
	Sun, 28 Jul 2024 21:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T867XDIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6014287F7D; Sun, 28 Jul 2024 21:36:22 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47BB387F7D
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 21:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b97097f7fdso16780866d6.0
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722195379; x=1722800179; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wneMNhR3YHmt5zuxNSXTTOCvLwZLHvRr8GYYUPGgPIY=;
 b=T867XDICrMvnLcwtgZJm+bqeW+FKw+et/F2H5Jdovo5BUpwOWfqeSlnkRWtdd0iFHZ
 wyeRKohl3KtBcIa2DdMNkH0EHCLg1Rk1dI/GkA+3oTcpmwBdlM93+Igpbx1aMcUys+ik
 jmf3IPOy+h5qrokBHvtbf7s96Fw9pS9ySHr9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722195379; x=1722800179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wneMNhR3YHmt5zuxNSXTTOCvLwZLHvRr8GYYUPGgPIY=;
 b=eGPZuYgrQ2Y+RpsbFBEDziH1qB0cyFqKcQcJie4jWHLAVJ1UPH+VluE434ZjNju7Lf
 8sp1SjexsP5ntWqURRbW3uHhoynQV2So6SxInnEwsOATsA6WmuObzM90y80IAyqNCh9E
 TBQuU8WxAcdbKQjquaO/yiCsfemUr4N6rjPqwo6gHBtqknNzbP3G3CMzLXvuvGyyiPhE
 yPEE1BJ7v/SspmCMdfb4MPbDxuI5FbYTHRL4sdZ+4xx74HD9cY0+ZQpQl/bI9rTTjTjb
 AL0HwFJ7pux1zODk387EqeD/X6bSCUka6Xevu0BMEsQAz1uugsJ5gCOaZzbTbbfXp38t
 wORQ==
X-Gm-Message-State: AOJu0YzzTQAOkVBCcj41uB+A+D0IXoDJtc9jGuQ2fX7N9z9AmVvywh4K
 pAL72QBK/Ac6FGHSf9FBQF+xkkZZGwX4RAqe7pi74vCtwvMeQRVAFjIaUBJGfgyR/KEfUf8URms
 Wla4EivWJSYGMJC9cv0+IWKvGbfniDqkaaBO0
X-Google-Smtp-Source: AGHT+IGBNg1hRUGohwZ59rkPEzaPSVVpY+bAWhLwwxJ4KrUYCZN96PxJobS9si5G/L6IaW1NKW4bQpWy6VejttdORZQ=
X-Received: by 2002:a05:6214:48b:b0:6b4:fd84:1cdf with SMTP id
 6a1803df08f44-6bb559baed8mr93355926d6.18.1722195379198; Sun, 28 Jul 2024
 12:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <a68bffff608d11f4249ede9e51226f9ec917da59.1721819159.git.love.kumar@amd.com>
In-Reply-To: <a68bffff608d11f4249ede9e51226f9ec917da59.1721819159.git.love.kumar@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 28 Jul 2024 13:36:08 -0600
Message-ID: <CAFLszTiMk_oJTwU8K4CZGJa9FXnSgkJs2xgcD0fAWz_9iPjftQ@mail.gmail.com>
Subject: Re: [PATCH v2] test/py: spi: Add tests for SPI flash device
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
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

Hi Love,

On Wed, 24 Jul 2024 at 05:07, Love Kumar <love.kumar@amd.com> wrote:
>
> Add test cases for sf commands to verify various SPI flash operations
> such as erase, write and read. It also adds qspi lock unlock cases.
> This test relies on boardenv_* configurations to run it for different
> SPI flash family such as single SPI, QSPI, and OSPI.
>
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
> Changes in v2:
>  - Fix the pylint errors
>  - Re-order/organize the tests
> ---
>  test/py/tests/test_spi.py | 680 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 680 insertions(+)
>  create mode 100644 test/py/tests/test_spi.py
>

How is this test enabled? Can it run in CI?

With nits below:

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
> new file mode 100644
> index 000000000000..4774b4151b4e
> --- /dev/null
> +++ b/test/py/tests/test_spi.py
> @@ -0,0 +1,680 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# (C) Copyright 2024, Advanced Micro Devices, Inc.
> +
> +"""
> +Note: This test relies on boardenv_* containing configuration values to define
> +spi minimum and maximum frequnecies at which the flash part can operate on and

spelling

> +these tests run at 5 different spi frequnecy randomised values in the range.

spelling

> +It also defines the SPI bus number containing the SPI-flash chip, SPI
> +chip-select, SPI mode, SPI flash part name and timeout parameters. If minimum
> +and maximum frequency is not defined, it will run on freq 0 by default.
> +
> +Without the boardenv_* configuration, this test will be automatically skipped.
> +
> +It also relies on configuration values for supported flashes for lock and
> +unlock cases for SPI family flash. It will run lock-unlock cases only for the
> +supported flash parts.
> +
> +Example:
> +env__spi_device_test = {
> +    'bus': 0,
> +    'chip_select': 0,
> +    'min_freq': 10000000,
> +    'max_freq': 100000000,
> +    'mode': 0,
> +    'part_name': 'n25q00a',
> +    'timeout': 100000,
> +    'iteration': 5,
> +}

Can you please describe what these params are?

> +
> +env__spi_lock_unlock = {
> +    'supported_flash': 'mt25qu512a, n25q00a, n25q512ax3',
> +}
> +"""
> +
> +import random
> +import re
> +import pytest
> +import u_boot_utils
> +
[..]

Regards,
Simon
