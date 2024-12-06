Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEFEE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3FD989376;
	Fri,  6 Dec 2024 20:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cixFeKCI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08BB28971C; Fri,  6 Dec 2024 20:17:29 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C449C88F0C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7258bce5289so2003508b3a.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512645; x=1734117445; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vVTwZY6DdwiJvvXdb2iHwHGFx6Q7H1OypfronoaJrnU=;
 b=cixFeKCICAWcRZ1E+ZRT8B9Y44PDTx0I5ESLQ5SXJaHEsR0s5AEa7ocQEmLrauc8s+
 GQ/RT+kZpkOdGkos2RJndkzFHK/XHEJ8dgeZrvYs86a00smkCvHwVw0xqax5WJfVqnWT
 W8+2TtHHJho3TWTIeL6/FAvT84Xg1n7+uE4Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512645; x=1734117445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vVTwZY6DdwiJvvXdb2iHwHGFx6Q7H1OypfronoaJrnU=;
 b=GfoC0d3a3Y1l/yMnI8Nqv1QIbV3EovRdCUWtySEJvCryEpfBRRwmO3Xs8PdG3mc3ff
 qBMdXrWG0XPTagEDDHtYFn/Q2SWTlBARZjs0ndWuS+TCru1uluWJnBP3V3GswZIpFbX1
 ygJfFOZYtu1qPngFE9531hcB0wnj6Ogwbm2vmePOEzf1ShZ6JMi1ViEu30shqIsjdXe4
 kEPii3RWgTBxP4jXj4jn9IIdSHkWB2bX+ZzNMDwe9FVwjglxUR86Malcwtj9s2zg3WD4
 5RvtewNPQT4yDTfFSDsRyr575nRjEXvkfEJHMFyU8HEdwaAc0bWKgs7FyBDmaQ42B43A
 6txQ==
X-Gm-Message-State: AOJu0Ywtyw3NtUHwP2XUmpzLJ03X/SROUCv3gTGwMri3nzS6th/Btz/J
 4k2XDHH/Q7+5d7tFwRo+yL/xHlTOgl+gNXWr9bEzJ6k8W/vwKg7mIWyHLRRqb7wdfZLT059LyzC
 RNZo5xw6qewALXD/64/MXZbaE7UjVK3+/neOX
X-Gm-Gg: ASbGncs6bSRbwUSQFGbSP4pP3diBqbcY3j8Tmoo4HIFW06xFbN2iiAzguFZD/dbYpPb
 hQG6QhaKbIKpT77DC3ZcpyS7bfSq6ZdfaYViW
X-Google-Smtp-Source: AGHT+IFVZ7Cm3heQVth24ySOD/RpAQUXiHT60ehs4aSEtfklJ6UCqMenOSHkdyyOeffzIbm/57wBQRAX9Hv6E6y03dQ=
X-Received: by 2002:a17:90b:5204:b0:2ee:d371:3227 with SMTP id
 98e67ed59e1d1-2ef6a6bdc2amr7187193a91.17.1733512645420; Fri, 06 Dec 2024
 11:17:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730452668.git.michal.simek@amd.com>
 <22109373594b6a5d1110be9420ccd8fbb93a61d3.1730452668.git.michal.simek@amd.com>
In-Reply-To: <22109373594b6a5d1110be9420ccd8fbb93a61d3.1730452668.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:16:34 -0700
Message-ID: <CAFLszThwL6i7XT6hey4QE87wfGkq=Et0TjzH+kgQjPUZzvYRQg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] Makefile: Drop SPL_FIT_GENERATOR support
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, neal.frager@amd.com, 
 Marek Vasut <marex@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Fri, 1 Nov 2024 at 03:18, Michal Simek <michal.simek@amd.com> wrote:
>
> From: Marek Vasut <marex@denx.de>
>
> The SPL_FIT_GENERATOR is long superseded by binman, drop SPL_FIT_GENERATOR
> support as there are no more users.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Changes in v2:
> - Rebase on the top of my series which do conversion to binman
> - Taken from git with all tags
>
>  Makefile                | 18 ------------------
>  boot/Kconfig            | 14 --------------
>  doc/usage/fit/howto.rst |  4 ----
>  3 files changed, 36 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks!
