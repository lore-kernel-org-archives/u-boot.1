Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C123FC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 10:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20A58878A5;
	Wed, 17 Jan 2024 11:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k9VAtwth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1937887B3F; Wed, 17 Jan 2024 11:27:40 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56DEE8753C
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 11:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50e766937ddso12215992e87.3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 02:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705487256; x=1706092056; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XWjrVgx1AlJ7ITscfCRPsx0dh2aR64PUEqGP01ZD6lQ=;
 b=k9VAtwthrnN6AulDWEV/CnwGOfrw+8LJlLpdFfDBFMU7EY2S14NO5uYddqOrfgK8Du
 kLOWPdG342EUnlCfgKZLstPZPH6V6FAkFndahwy2iZYJUs35Je0eFaU/gkoqM1D+b7PQ
 bUmzoYPzZIoW1K4PtF4zm8UDrinnhVbvQGcfdNsZR/uy95fceH67E8h1lXFWvuGX1gWF
 RAB+HgeMrpRcbjAtjEVeavcRjLeL6ATocjB6lSHu+lz4J3KrREOAXKeU7gqjM0ftvYmL
 fyQfJjr2XAxtw9k4viFCkTpK7z6lWTtpXC4et49CauTEMlKzl7SACMmTwc4YFZ+4j69Q
 3m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705487256; x=1706092056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XWjrVgx1AlJ7ITscfCRPsx0dh2aR64PUEqGP01ZD6lQ=;
 b=Yi3XA9PRqMgXGWD2OPRNMHd/fXxdJ28nPWOFKNdaTOIA/W7nef6YAvZM8u4UyoK/A8
 FJJmGTXBC/EE+HWIpPKSNxixCoWxd77yXWmh16UMMdGDPp11ROfKtJdSlMUs1QGfCwZ3
 qCby0z88PdCj+qIwCdAMLybXkPTCysVqpE9wpBtCSTpVPAtPPb+UG4lTU9IR2F3dTtOk
 gPlbVSa5kxe0h3gChZYuqRVkMgwPUuO98tJO7EslOwRI3eV8hAdQd2SVFDoQTpCpuiJN
 RYxOyy27OayZXnjRIaA4MIuf5lAVZWN46FMaDg6op52DPrwy9LvO7bPyHxBBlwSPegUE
 DWxA==
X-Gm-Message-State: AOJu0Yw6xBO7qCSMNEWHUK/Wx8Oy6ms7Yl2NgGcy8gaAEJGCidedmREr
 2xYEzDDM04Lo4nUXTXxH5bRneANydQF0ytCCV8SWq/fQqC+Tzg==
X-Google-Smtp-Source: AGHT+IFisl426YPh+KvnLV8yComz5I5Qh+ir/AXkIkr6SrmApxKmnq/qapYMKk5qlCYZE0GEVFnatkgQLFVs/rZngko=
X-Received: by 2002:a05:6512:114f:b0:50e:8dd7:82a9 with SMTP id
 m15-20020a056512114f00b0050e8dd782a9mr5157831lfg.99.1705487256615; Wed, 17
 Jan 2024 02:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20240116171356.376801-1-raymond.mao@linaro.org>
In-Reply-To: <20240116171356.376801-1-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 17 Jan 2024 12:27:00 +0200
Message-ID: <CAC_iWjJ9DNuZwAf2FiL7+FCm02BFfyV6gAKFA_5nBmEncJWvpw@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] Handoff bloblist from previous boot stage
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Fabio Estevam <festevam@denx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Linus Walleij <linus.walleij@linaro.org>,
 Andrew Davis <afd@ti.com>, Yang Xiwen <forbidden405@outlook.com>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Peng Fan <peng.fan@nxp.com>, Kevin Chen <kevin_chen@aspeedtech.com>, 
 Sean Anderson <seanga2@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>
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

Hi Raymond,
The patches look sane, however there was a failure on the CI [0]. Can
you have a look?


[0] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/19347
Thanks
/Ilias

On Tue, 16 Jan 2024 at 19:14, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> This patch set adds/adapts a few bloblist APIs and implements Arm arch
> custom function to retrieve the bloblist (aka. Transfer List) from
> previous loader via boot arguments when BLOBLIST option is enabled and
> all boot arguments are compliant to the register conventions defined
> in the Firmware Handoff spec v0.9.
>
> If an arch wishes to have different behaviors for loading bloblist
> from the previous boot stage, it is required to implement the custom
> function xferlist_from_boot_arg().
>
> V5:
> Drop [PATCH v4 8/9] fdt: update the document and Kconfig description.
> V6:
> Drop [PATCH v5 8/8] fdt: get FDT from bloblist.
>
> Raymond Mao (7):
>   bloblist: add API to check the register conventions
>   bloblist: check bloblist with specified buffer size
>   bloblist: refactor of bloblist_reloc()
>   arm: armv7: save boot arguments
>   arm: armv8: save boot arguments
>   arm: Get bloblist from boot arguments
>   bloblist: Load the bloblist from the previous loader
>
>  arch/arm/Kconfig             |  1 -
>  arch/arm/cpu/armv7/start.S   | 19 ++++++++
>  arch/arm/cpu/armv8/start.S   | 14 ++++++
>  arch/arm/lib/Makefile        |  2 +
>  arch/arm/lib/xferlist.c      | 27 ++++++++++++
>  arch/arm/lib/xferlist.h      | 19 ++++++++
>  common/bloblist.c            | 85 +++++++++++++++++++++++++++---------
>  common/board_f.c             |  9 ++--
>  configs/qemu_arm64_defconfig |  3 ++
>  include/bloblist.h           | 47 ++++++++++++++++----
>  test/bloblist.c              |  8 ++--
>  11 files changed, 193 insertions(+), 41 deletions(-)
>  create mode 100644 arch/arm/lib/xferlist.c
>  create mode 100644 arch/arm/lib/xferlist.h
>
> --
> 2.25.1
>
