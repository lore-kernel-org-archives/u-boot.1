Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CC1C5479A
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 09:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4929088744;
	Wed, 28 Aug 2024 11:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NSBC1mb/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 172BC885D1; Wed, 28 Aug 2024 11:59:55 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 454CB88744
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 11:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3719398eafcso3757474f8f.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724839192; x=1725443992; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YK3RK0YWdyYmiFb0OoqI1oMOYTiVs/O7w430JYgBXxk=;
 b=NSBC1mb/qufPc0S63fcvMDXF+QyqLOsl3UhFLDu0lpGY+BJ6jd11Trv/S/L2jzsS9U
 xUdH3D1pL3aueCjODs6aPWZuSYiaFs61+k/Os/wJ6UkhIhOufHEeMAWSGgamp1HQu46c
 U5/+iHykQZgG9Z9LV8i1/i1B3Q+mZy9jq4yrTC4FTYDqnm1o2+QG86c5i37A5MFyntHv
 PDpDcKriHer/il7f4ojd5vJ+m0FpoZXjfUGW+7avxpy8f4IeNdQ2u13mngrCantvwiIv
 Sfxmp0mO9t9ZWrFzb117msVsRtuHqgEMJSvw9xFuDTu7v/jhjMHyC5GnRbGHmiYRocpn
 zXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724839192; x=1725443992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YK3RK0YWdyYmiFb0OoqI1oMOYTiVs/O7w430JYgBXxk=;
 b=iWz7AFzlujbE8ZdyuLbItZbpBIiYatvK9xN8GyObUprZHeN2li2DOeyfXC4/MEGHkC
 yKpSagbVS9RgtaLEmhGFbmILPb6oURjUkt/ryYCj0HMsyP31A5sJ1c4EdJ9Q0gzz9G8B
 shdlGLdJiRsXZ3GfJjt4hHG42FHKzW1yG6e7ETHYyPnNZm5t6jzFsGqRPYn0/YOz8Uo4
 u7bp4dkumQMXZybVYiAkbFK67rbkwmqQehmtFlRTojTKCIUY7De49yEXAXoRZ46fO62d
 2LUMMYRGoJOL9kqezaPzsCqSqUh6hezfKEDMAoby4uR062degPpDVZmLhzXxEnCZVCtT
 1tHw==
X-Gm-Message-State: AOJu0Yx3FzfzPfMcJpc2pDVDmdxVxKlMEOClB/9N2veyOtFrHT1GfXpd
 QC4Q4kB2VqRzKv3MT0bMMRPMK0bE+73TNxDyvGt1so4+47mak6OumjVlnPtzudFS1yTnxKPJ/Tn
 3QKsovvd2ymveohZBm9jzmWyVcuw=
X-Google-Smtp-Source: AGHT+IHvJI8DG7v7Bg+O9GEQZaBQuE8DoZ74E6F84zKgDctAoZWm/3hK3+b8cY5JVJdZtVhAOvEVo2J1hnNBECrzxSM=
X-Received: by 2002:a5d:4e46:0:b0:371:8cd6:b2c1 with SMTP id
 ffacd0b85a97d-373118e3f62mr10866014f8f.48.1724839191021; Wed, 28 Aug 2024
 02:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240828014538.3322013-1-sjg@chromium.org>
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 28 Aug 2024 10:59:39 +0100
Message-ID: <CALeDE9MX6MMECX+vNCjMs8Z2_G3+gSio4BxFHgez-H_a4f2Uyg@mail.gmail.com>
Subject: Re: [PATCH 00/18] vbe: Series part D
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>, 
 Apurva Nandan <a-nandan@ti.com>, Bryan Brattlof <bb@ti.com>,
 Greg Malysa <greg.malysa@timesys.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jayesh Choudhary <j-choudhary@ti.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Stefan Roese <sr@denx.de>,
 Tony Dinh <mibodhi@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 huang lin <hl@rock-chips.com>
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

Hi Simon,

> This includes various patches towards implementing the VBE abrec

What is abrec?

> bootmeth in U-Boot.
>
>
> Simon Glass (18):
>   sandbox: Add missing header file
>   bootstd: Add stub for bootdev_setup_for_sibling_blk()
>   gzip: Correct function comment for gunzip()

Is this from upstream gzip code somewher?

>   fdtdec: Support separate BSS for all XPL builds
>   tiny-printf: Correct return values
>   tpl: Support numbered aliases in device tree
>   ram: Support driver model in TPL
>   serial: Support debug UART in TPL
>   armv8: Support not having separate BSS
>   arm: cache: Drop a stale comment
>   arm: Fix up a stale comment in sections.c
>   mmc: Support driver model in TPL
>   mmc: Add more debugging for SPL
>   mmc: Log the error when init fails
>   mmc: rockchip: Log some error returns
>   mmc: rockchip: Allow clocks to be missing
>   rockchip: mmc: Fix a missing colon
>   rockchip: Provided SPL control over efuse presence

I'm not sure what most of these patches have to do with VBE?

>  arch/arm/cpu/armv8/u-boot-spl.lds   | 12 ++++++++++++
>  arch/arm/lib/cache.c                |  2 --
>  arch/arm/lib/sections.c             |  2 +-
>  arch/sandbox/include/asm/sections.h |  1 +
>  common/spl/spl_mmc.c                | 13 +++++++++++++
>  drivers/core/Kconfig                |  8 ++++++++
>  drivers/misc/Makefile               |  2 +-
>  drivers/mmc/Kconfig                 | 12 ++++++++++++
>  drivers/mmc/mmc.c                   |  2 +-
>  drivers/mmc/rockchip_dw_mmc.c       | 10 ++++------
>  drivers/mmc/rockchip_sdhci.c        | 11 +++++------
>  drivers/ram/Kconfig                 |  9 +++++++++
>  drivers/serial/Kconfig              |  7 +++++++
>  include/bootdev.h                   |  8 ++++++++
>  include/gzip.h                      |  6 ++++--
>  lib/fdtdec.c                        |  2 +-
>  lib/tiny-printf.c                   | 15 ++++++---------
>  17 files changed, 93 insertions(+), 29 deletions(-)
>
> --
> 2.34.1
>
