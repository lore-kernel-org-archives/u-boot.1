Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E171C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 17:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A823480A55;
	Mon, 10 Feb 2025 18:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vs/VzOJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A3FC80AE6; Mon, 10 Feb 2025 18:08:18 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66D8780821
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 18:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5de4a8b4f86so5044185a12.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 09:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739207296; x=1739812096; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jcJb95AtyO+CKdryVFRrOSUPO42HKBtxNIfKUMU9Wrk=;
 b=Vs/VzOJI+y3AYeikHYNwImN6M/X7fLLfQuJy/92GUZ3k9u78TS4tEs+ykouhU0yPaM
 q+qoYARgidDaA9brGuZ8rcGnwyUk/GD17k5+Qcrp05IX5ZSvDJdvbXL1IONRgDi/hrcN
 DBs7lAQfR2KcTVT7uBaflg4BmCHp33gOW5NkXcdZVrFZBK57xmYcGv62VMU2EJhivgG7
 gAOhxb8bWtx+Qbt9q3e2qklSTcY3Z9gN8svDo1rygNOzoLsdx3vIhNkOizCYalWXjNjw
 VLHAByelt7DYAXtH8oSWuVmVFvm/AuAAvfQy8IEZwjNVdZcpcGvTaSCHxS0qtm2Mqqru
 lemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739207296; x=1739812096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jcJb95AtyO+CKdryVFRrOSUPO42HKBtxNIfKUMU9Wrk=;
 b=qxso9IpTes5XEjMkgWk3u0cx1Vx7szyOSdr8L5JlNT68B+nMTdQfDFw1mgYzSNRZJ2
 O7mazjR9egcGZHL8w80A42ucGyxzbD+G0N/VfFW4Go/Gyu/yHT+FNwRX1LNUCRWaFXTU
 1HSAWmcxKqsSRghG0GoQCVNbtmoPNzvGRkoVYhPP+ss1mx6PSPhMSZpxfhpmMegyW37H
 SHZ9qhP7fxvOJBRjz++k2xLLTvjIyfy4ru8VTo+v0ry8qQOugAaP1b68Zn8PcH/yaBwL
 060by8WOEv5rK3dOabmKDyXlEZUevbiOUX2r5IP+g0l++l8UpTxYUbQ03E50lBWlwZv6
 cu9Q==
X-Gm-Message-State: AOJu0YwnTpFNPEcZvhNCoR0K7i+mXyQ9RzZfXW4gKhXRIGBMmDJAH8sd
 79D2FCwqUNzMfHPQdQS/0Y+0sWFNJHLMglzJ3ayZ4wvFziXL7iALu/gZ9TgsO0DWSA0MaIWK34N
 5O1YVrlXr5o5ym1DV3Tv+8WyVnuQ=
X-Gm-Gg: ASbGnct91D5jSbIT7g80cBFW/SRe/QOo6P/wfJLfxdhrKviKlT5Wlhq0n8/lPBnFuld
 wcnk4m+W/7RQoO4j4GgaD0TuOuULrkVM36VDpTwa5a4kw3qchuprkyPGXg2dTTiDMu4w6r/fhtZ
 k=
X-Google-Smtp-Source: AGHT+IHRF8YxoFVVmAzM64A/CBkGCW2ehPlMDjlTHNKITqf+coLWnO79iwUhRUmatRhPrTES9riFXFhd7wjNJblR8Bg=
X-Received: by 2002:a05:6402:26cf:b0:5da:105b:86dd with SMTP id
 4fb4d7f45d1cf-5de45087fd2mr15815039a12.29.1739207295584; Mon, 10 Feb 2025
 09:08:15 -0800 (PST)
MIME-Version: 1.0
References: <01020194f07b3323-afacb0f8-267a-465d-b377-390312be437e-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020194f07b3323-afacb0f8-267a-465d-b377-390312be437e-000000@eu-west-1.amazonses.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 10 Feb 2025 17:08:04 +0000
X-Gm-Features: AWEUYZlk7h6kJzukG5Fe2gzJEdix-hwjYzMXmQA9hOiBI2EGibUqLIdPP83sed4
Message-ID: <CALeDE9M0ZCtGHWDSF8DSTVfANtnMmE-1VrAx9YHJjcstcgtyTg@mail.gmail.com>
Subject: Re: [PATCH 0/6] roc-pc-rk3399: Add SPL_DFU support
To: Arnaud Patard <arnaud.patard@collabora.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 10 Feb 2025 at 16:48, Arnaud Patard <arnaud.patard@collabora.com>
wrote:

> This patch series aims at allowing to boot u-boot proper over DFU on
> roc-pc-rk3399.
> While the changes are pretty generic, I wanted to enable the device I've
> tested. I may try later to test that on my pinebook pro.
>
> What I tried was to boot u-boot TPL+SPL with the device in maskrom mode,
> downloaded over the otg port with a file generated with Rockchip
> boot_merger.
> Then u-boot SPL is downloading/booting over DFU the u-boot proper
> (uboot.itb).
>
> Arnaud Patard (6):
>   drivers/Makefile: Fix TPL build with dwc3 generic
>   arch/arm/mach-rockchip/spl-boot-order.c:  Add DFU boot media
>

The full paths aren't usually included in the summary, please look at the
conventions for the various subsystems to ensure these are readable.


>   arch/arm/mach-rockchip/rk3399/rk3399.c: Add gadget device to boot
>     devices
>   include/configs/rk3399_common.h: define CFG_EXTRA_ENV_SETTINGS in XPL
>     build
>   arch/arm/dts/rk3399-roc-pc-u-boot.dtsi: Prepare for SPL DFU
>   configs/roc-pc-rk3399_defconfig: Enable SPL DFU for roc-pc-rk3399
>
>  arch/arm/dts/rk3399-roc-pc-u-boot.dtsi  | 23 +++++++++++++++++++++++
>  arch/arm/mach-rockchip/rk3399/rk3399.c  |  1 +
>  arch/arm/mach-rockchip/spl-boot-order.c |  3 +++
>  configs/roc-pc-rk3399_defconfig         | 14 +++++++++++++-
>  drivers/Makefile                        |  1 +
>  include/configs/rk3399_common.h         | 18 ++++++++++++++++--
>  6 files changed, 57 insertions(+), 3 deletions(-)
>
> --
> 2.39.5
>
>
