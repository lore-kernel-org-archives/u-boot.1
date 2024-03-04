Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7642C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 11:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE3F87E92;
	Mon,  4 Mar 2024 12:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jc4Q+tTT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6667C87F10; Mon,  4 Mar 2024 12:16:49 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D4EA87E4D
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 12:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d09cf00214so53942521fa.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 03:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709551005; x=1710155805; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jCGJKi3vfYkuo65wd51kNl6IuqX2ZLLig1NQjKjKvvg=;
 b=Jc4Q+tTT+wc22Q3adVtLuE3wT4gGZ1wtfKCCj646x0OCp4DLD+cITjS6azekLwNANy
 qbKr07hFj6P6/4ip49PL8LVT76NJDyE+6Kdnwk3oNl0oe9NS87tBHZGkB/HkTDuRGKXQ
 +lC41n5BL0MVPRdl+rGNMvM3uOKY5gxLQXIRqmMgfWfGMJGd+hC2hTOH8OS22b/lHSBl
 NIrwahkUOZ2bDAjECfNbD7M6Ph4SvcRzx51BI0flWjKpXMQgkhbqWpPHByB5qgCjKG+A
 Lzrjd610ex/ZcetB4ztURIQtz0H+9xdK8EJcjCNhMVFu0HnqtefcXptx1g3IdQrO4R1i
 3k3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709551005; x=1710155805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jCGJKi3vfYkuo65wd51kNl6IuqX2ZLLig1NQjKjKvvg=;
 b=KhA2WaQ0ViVWe+hZWh31kpTTCJTN1zCwCJbnI2P1HRHF7zt627kRZqm3trFr7jB0Xz
 WVmf7xBc7SpYI38iZyEXqgcHk7uzPXs7PNJGqcwJVfc1JIWPv+UrvfaH6EKoUfWW5Bza
 P56lxJOPMrX5cAmiT7bZ864mxbrLOWoXPF+rfeE1EE7SvFh/m0G0LmgejhwwFDrqx6hY
 UWDpzeoff5+1Ood2KXzGomBX/y+GSiLGCNxrfk+VF9BKMkgsAUNdZB+1bPed/3f4EB5r
 KScFl2FWlqXLA/typ5xuCXMf1PjUZPE5xD/6GchadTYYISePWJMoezJA/d3qWJZujYHZ
 ueJw==
X-Gm-Message-State: AOJu0Yy+Om/Uq1VQ+QNx51ATHrVjAiNZPeTGamSM1BvPPeEBdnyDmD9s
 KWEaJvHv6XIX3KOUQL8gmlQ4aWDorSlj6vK+6jvhgvAuGhSocDrND1OpGr8NhOBBUXAkSe58KkT
 LQmAlIdlyQFwTIXxvcyyrQc/w3YbwBcTB4lxfcw==
X-Google-Smtp-Source: AGHT+IEhC7PD/7dlXXfetnmlvbwGa4NzyrFNlQQKs+/TopYioCDo5wqqvDXFwK3Nhqj75hNVaJgYQw0l4F7yYxhASfA=
X-Received: by 2002:ac2:4834:0:b0:513:1829:57f with SMTP id
 20-20020ac24834000000b005131829057fmr5959048lft.5.1709551004918; Mon, 04 Mar
 2024 03:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20240302220108.720637-1-igor.opaniuk@gmail.com>
In-Reply-To: <20240302220108.720637-1-igor.opaniuk@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 4 Mar 2024 13:16:08 +0200
Message-ID: <CAC_iWjK+f-ZBKT=Mf6629HxV=NCgoZ_taRMFhGK04aA1Xw-BCA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] TEE: minor cleanup
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
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi Igor,

On Sun, 3 Mar 2024 at 00:01, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>
>
> - Address some spelling errors and typos
> - Support CMD_OPTEE_RPMB for SANDBOX configurations and add python tests
> - Remove common.h inclusion for drivers/tee
>
> Changes in v2:
> - Fixed chimp_optee.c:37:9: error: implicit declaration of function 'memset'
> - Applied R-b and T-b tags

https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/19808
this seems to have a few failures

Cheers
/Ilias
>
> Igor Opaniuk (5):
>   tee: optee: fix description in Kconfig
>   tee: sandbox: fix spelling errors
>   cmd: optee_rpmb: build cmd for sandbox
>   test: py: add optee_rpmb tests
>   tee: remove common.h inclusion
>
>  cmd/Kconfig                        |  4 +++-
>  drivers/tee/broadcom/chimp_optee.c |  3 ++-
>  drivers/tee/optee/Kconfig          |  2 +-
>  drivers/tee/optee/core.c           |  1 -
>  drivers/tee/optee/i2c.c            |  1 -
>  drivers/tee/optee/rpmb.c           |  1 -
>  drivers/tee/optee/supplicant.c     |  2 +-
>  drivers/tee/sandbox.c              | 10 +++++-----
>  drivers/tee/tee-uclass.c           |  1 -
>  test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
>  10 files changed, 32 insertions(+), 13 deletions(-)
>  create mode 100644 test/py/tests/test_optee_rpmb.py
>
> --
> 2.34.1
>
