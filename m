Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCC7C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 18:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB21F888DE;
	Thu,  4 Jul 2024 20:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tYq2fKom";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2837288924; Thu,  4 Jul 2024 20:50:48 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AAE7888DE
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 20:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-701f397e8ffso517742a34.0
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720119045; x=1720723845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlPKAxcdp7uHTf40f9Qzt4qAZY3oOYLTi3e7PH68b6k=;
 b=tYq2fKomCOqr9g1TethciS0b3BYP6uBV8zOCwuAuU8sFXq8BfNNanzRbvjdo/lTshJ
 oHP0I3Eo3E/bxWvJBqZMZOFx4pfMuFSDKcDS85ETy+dSAnixahzhuAajZLPWwolJunJu
 bW2IbySyllVjSqWoWN0AucZ/PF/OBpM75KicQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720119045; x=1720723845;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OlPKAxcdp7uHTf40f9Qzt4qAZY3oOYLTi3e7PH68b6k=;
 b=GRrOrqcLSdmgmnzZhuVVRayeVn1hS6KYWMSWzUUDIy5LvIVf+fwOIIxm7CP6Zcw61q
 Z5bHwDGZX5R4ebp2/iPUoxQQAZEchqOFyuOn2mN+xNdBVS/AICoeNukrdiryPQEwNV45
 N8oGAUZt9LFouQfH8DH/Ytxl4Sfjp6VsIIEx24HJMSGMQhMcF/TFPl9tj1oIBIvefjHf
 pkN7ZbaW6P7U6UGLhNcuwLs9O7cRLNvKz+Fkgp5EVYpV/GQFUpfrRvd0cyzpQK0FPmjE
 8lB/8RmwQkeeh+FjmbXobriTQF6bY7I8GgHkrvztpxkDnsNawFqnCIZDutws5yTyOttx
 0L+A==
X-Gm-Message-State: AOJu0YyeMDxDbJsz9e8TZ9Jyom7tKgTcWuVYoS4JHB1EmqBJSm1ZGed8
 jbFTsJ2HPloKHH5eCARUpgAW+ftuLTNNN1VMgts3R2JQDVQfl7f4zTrziTRZwNc=
X-Google-Smtp-Source: AGHT+IFKMYVLcYTDxMgwlnWohBLxAXBZRdaTWzdn2w8R0XGhRVBR91/lpfH2H4+m6At8eYov9A0RFw==
X-Received: by 2002:a05:6830:206:b0:700:cf6e:e261 with SMTP id
 46e09a7af769-7034a80cfbamr2692107a34.31.1720119044693; 
 Thu, 04 Jul 2024 11:50:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-45.totalplay.net. [189.203.97.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7ac8dccsm2454997a34.34.2024.07.04.11.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:50:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Alexander Gendin <agendin@matrox.com>, 
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
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Samuel Holland <samuel@sholland.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Trevor Woerner <twoerner@gmail.com>, 
 u-boot-amlogic@groups.io
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH 00/14] testb: Various tweaks and fixes for Labgrid
Message-Id: <172011904231.1502730.5769264481687986280.b4-ty@konsulko.com>
Date: Thu, 04 Jul 2024 12:50:42 -0600
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

Applied to u-boot/master, thanks!

-- 
Tom


