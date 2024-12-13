Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520C4E7716A
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 03:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7851C801EB;
	Fri, 13 Dec 2024 04:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dM0Zd/sR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E842F801BF; Fri, 13 Dec 2024 04:09:47 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E28180085
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9f60bf4so1973606a12.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 19:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734059384; x=1734664184; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+4R5kKgs2w299eR3q46AWF4o28iFh+Ig7BRje9HBZYc=;
 b=dM0Zd/sRBw6VDqKYc9IF8uWMARsrJSACJMxgaz1UJdmT/CXa8Pzo0bp8wN+ykbconz
 fzXuvqfR7kc12MyAA5en98GaT9s3LuPxiAR9BD1IXIBu9XX3L6yUGWoGvoletIujiGoO
 CuS+4uBw+LuwI6XN2LsTdhgvmXUwV8xCrNE1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734059384; x=1734664184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+4R5kKgs2w299eR3q46AWF4o28iFh+Ig7BRje9HBZYc=;
 b=XJgdMsYb9n339YcgjRdb9ub8RwIIfLluppzMeqtP4+bAAPRvjZbegUIHr+2c2gcMCR
 eQ2xssDHeECwGdZ9YR92vLZ2i2yJsa295BAUdQxEqlDB5zwDyH8nuCIGCfRO5d0UoVCU
 QNJ8ih3iZuYWzafyZzudVWl8TWXXLGKPNlY8kQ+Iw2TWdghUE79uBUXj5la3YNnQbvY/
 LCVdOZt150tz5O+exyJ3OLgKt2gWkzMlEfYVXHmoGirXOSSbgLgO2eUbCYPKYzIN3VFw
 J0mzy8+8p97s+/MfCTJ+dXfBAytUcyBTyV3ca7c9nUzSHhFhozEvIRJQQjOttEMUbAnK
 FxyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDRov6TDMbTdxBdaNxaZtd/Ju/370AdZTuO7DWe85sMGb4Blqu84HamL2Zz1yQPNmLrpevelA=@lists.denx.de
X-Gm-Message-State: AOJu0YxnnYbGT7xf3lG+vbi9OSbVtjLeNtFJY0zqLPzBFZSD8srf3jFc
 HGSWKF3659rOi5wQWvElb5nMwOO2fFIsSnh9SnycmvcFxNzTTY0DtVVFlkv6HUOfRrjfz6+ToS+
 EHi+vrqCNhYG4/rIuYnQDNc1p+MJ74tKzG+hJzIg4qLYG1Bg=
X-Gm-Gg: ASbGncukj1lS49i0TX2qsBpXZXqZIvX2VymhsqurvwO9dY0TQPLXDtDaZRt2zulcrc1
 nvrj+tlweq1E+AQqBdmiEs9WeKuAPg+moImlkD5w=
X-Google-Smtp-Source: AGHT+IFnn47coTiBZrbgMpwl39wjLavtSdb+/9OwkwSb/JjF/tAgaDCkSMDYXBArKZNTMYP3zG9zK7K9w55nr0G75/g=
X-Received: by 2002:a17:907:9710:b0:aa6:90f1:a9bb with SMTP id
 a640c23a62f3a-aab779aa8a9mr91080666b.24.1734059384387; Thu, 12 Dec 2024
 19:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20241212235735.164272-1-jonas@kwiboo.se>
In-Reply-To: <20241212235735.164272-1-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Dec 2024 20:09:32 -0700
Message-ID: <CAFLszTg=UkyZc7qUmgNSv06Sm8vXgS62mHMczH9wudFX1jqHdA@mail.gmail.com>
Subject: Re: [PATCH 00/12] rockchip: rk3399: Migrate to use TPL on bob and
 kevin
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Jonas,

On Thu, 12 Dec 2024 at 16:57, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> This is a continuation of an RFC [1] sent back in August.
>
> All Rockchip aarch64 boards, beside bob and kevin, use TPL to initialize
> DRAM and SPL to load FIT with U-Boot proper and TF-A.
>
> Bob and kevin currently does not use TPL and instead initialize DRAM
> in SPL and directly after tries to load a FIT with only U-Boot proper.
>
> This series migrate bob and kevin to also use TPL to uniform TPL/SPL use
> for all Rockchip aarch64 boards.
>
> Features and changes in this series:
> - Use of Rockchip aarch64 common bss and stack addresses
> - SHA256 checksum/signature check of FIT images in SPL
> - Use of dcache to speed up checksum check in SPL
> - SDMA use for eMMC access to speed up read/write in U-Boot proper
> - FIT location moved from 0x40000 to 0xE0000 in SPI flash
>
> Changes sinc RFC:
> - Include pinctrl props and enable regulators based on DT in SPL
> - Drop bob and kevin board specific code from common rk3399.c
>
> Please note that I do not have any bob or kevin so this has only been
> compile tested and the original RFC [1] was runtime tested by Simon.
>
> [1] https://patchwork.ozlabs.org/patch/1967517/
>
> Jonas Karlman (12):
>   rockchip: rk3399: Fix TPL build of bob and kevin
>   rockchip: rk3399-gru: Use SYS_SPI_U_BOOT_OFFS value in offset prop
>   rockchip: rk3399-gru: Move SPI flash payload offset for bob and kevin
>   rockchip: rk3399-gru: Fix include of TPL in u-boot.rom image
>   rockchip: rk3399-gru: Use TPL with common bss and stack addresses
>   rockchip: rk3399-gru: Include binman generated FIT in u-boot.rom image
>   rockchip: rk3399: Drop common Kconfig options already implied
>   rockchip: rk3399-gru: Remove unused nodes from xPL control FDT
>   rockchip: rk3399-gru: Enable dcache and signature validation in SPL
>   rockchip: rk3399-gru: Use SDMA mode to read from eMMC
>   rockchip: rk3399-gru: Include pinctrl and regulators in SPL
>   rockchip: rk3399: Drop unneeded bob and kevin board specific code
>
>  arch/arm/dts/rk3399-gru-u-boot.dtsi    | 29 ++++++++++++++++++++++++--
>  arch/arm/dts/rk3399-u-boot.dtsi        | 14 +++++++++++--
>  arch/arm/mach-rockchip/rk3399/Kconfig  | 12 -----------
>  arch/arm/mach-rockchip/rk3399/rk3399.c | 23 +-------------------
>  configs/chromebook_bob_defconfig       | 23 ++++++--------------
>  configs/chromebook_kevin_defconfig     | 23 ++++++--------------
>  6 files changed, 52 insertions(+), 72 deletions(-)

Thank you for doing this!

I'm not sure if you have access to your own denx tree. If so, kevin
and bob are in the sjg lab. If not, you can sign up at sjg.u-boot.org
to get access to my tree.

This series eems to work for me, except for the final commit, which
hangs with no output.

Regards,
Simon
