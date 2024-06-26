Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74451C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 09:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3730B884DD;
	Wed, 26 Jun 2024 11:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xux0G0WG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A83884BC; Wed, 26 Jun 2024 11:43:56 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE1E0884FF
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 11:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4255fa23f7bso1695225e9.2
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719395032; x=1719999832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBpK95HsKn8tqL5eWnQabaZgJfuPWAfbgXD9A1iKlM0=;
 b=Xux0G0WGWe0yUl6y+yeGh3yjLt0Em5y7PaGmubVD9lIxw0ycWDVwlUgRKa9ymbHNXF
 8/pJxfNTokstclxaEzf7ZlGEhN9iT9B4Fw64vwru6HgQLLycp7rAETN0JYjrz/ANcymS
 FZ9wqmEa2NUdSnb9afQPggR5CafXWxQiTzzsIk6whAFKnaC6zlJ5f2f2oXpE1YFdA78V
 A0tpIvJMZ83atXT4AasTIgY4xX4h/ti6DuY3z4xokww7emOlpajbQUggkQ9A3+YZwPDL
 U0pelI8YY+xixzGByY1stQa6UkpPiXEjKwNv9xCswM9HX+58WQRuqQBn6t+s6XqMNjER
 z4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719395032; x=1719999832;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBpK95HsKn8tqL5eWnQabaZgJfuPWAfbgXD9A1iKlM0=;
 b=SIAByJ+oo9cIZs+5DhjUi2QptrHfuEgvY6jLf4VPJ4Yc7puIeX+n+ZkPyBEecX92gg
 ICJZfoKYv3SAg5LRwqwm2qLbU8T4I6/U1HNePYGs0mtnnkB2iz/078r+nWOXCGjgaxPL
 +MknErJBK2xeHvTg3eWYSTPR6eP4pxAYNGDG41sJJiObdWOyCPxTB3PolmcRXzSGGfuk
 qUFGU78f56DA8hhxjKpVTZNkGpxWaZbgCSFkClMgFgVXEB2W9We639IWd95y4dJMe3jw
 Fz/qpPENrN2INXKzkev5m8ydtU7Gua0Yx+tIsBBaK/HLyFnRnsS3DbEAgTWz+DG00ycy
 xSuw==
X-Gm-Message-State: AOJu0Ywv3T+NeZvK9nu0p93wx72OVz4GxCTH4bgwmnOwIdqgv4N50IxY
 xNuwXB8b6Gyp5qKGSfSG730r9fjFLDlgQgYdY14zsOHoiflzSnQtNKixHAwpxMk=
X-Google-Smtp-Source: AGHT+IFYe7ftfjzkblkfpRPeZIk86qwv8keN8jYFzlQXl4kQ42DD2A78YF70uB+DPJyZoBo23QG2DQ==
X-Received: by 2002:a05:600c:4348:b0:424:a774:2ba with SMTP id
 5b1f17b1804b1-424a7740338mr17148975e9.14.1719395031710; 
 Wed, 26 Jun 2024 02:43:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c84692c0sm18857175e9.43.2024.06.26.02.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 02:43:51 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Alexander Gendin <agendin@matrox.com>, 
 Allen Martin <amartin@nvidia.com>, Andre Przywara <andre.przywara@arm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Nishanth Menon <nm@ti.com>, Pavel Herrmann <morpheus.ibis@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Samuel Holland <samuel@sholland.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Trevor Woerner <twoerner@gmail.com>, 
 u-boot-amlogic@groups.io
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH 00/14] testb: Various tweaks and fixes for Labgrid
Message-Id: <171939503058.2754394.2844444802537886889.b4-ty@linaro.org>
Date: Wed, 26 Jun 2024 11:43:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

Hi,

On Sun, 23 Jun 2024 14:30:19 -0600, Simon Glass wrote:
> This series includes a number of mostly unrelated changes which are in
> service of running U-Boot on a lab using Labgrid.
> 
> Changes in v2:
> - Add new patch to update u-boot.cfg with CFG_... options
> 
> Simon Glass (14):
>   trace: Update test to tolerate different trace-cmd version
>   dm: core: Enhance comments on bind_drivers_pass()
>   initcall: Correct use of relocation offset
>   am33xx: Provide a function to set up the debug UART
>   sunxi: Mark scp as optional
>   google: Disable TPMv2 on most Chromebooks
>   meson: Correct driver declaration for meson_axg_gpio
>   test: Make bootstd init run only on sandbox
>   log: Allow tests to pass with CONFIG_LOGF_FUNC_PAD set
>   test: dm: Show failing driver name
>   test: Decode exceptions only with sandbox
>   test: Check help output
>   Update u-boot.cfg to include CFG also
>   smbios: Correct error handling when writing tables
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[07/14] meson: Correct driver declaration for meson_axg_gpio
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/96e1a156e90a0674b21c56e7121b17a9211176ec

-- 
Neil

