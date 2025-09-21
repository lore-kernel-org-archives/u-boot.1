Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D4DCAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF05083423;
	Mon, 22 Sep 2025 16:40:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cl2ZTIrh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D559832DA; Mon, 22 Sep 2025 00:04:10 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C52F38317B
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 00:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=davidzangcs@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-77f1a79d7e5so1406171b3a.1
 for <u-boot@lists.denx.de>; Sun, 21 Sep 2025 15:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758492245; x=1759097045; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lB3jVZjxgvOqltI2nxu9UoIbSsHxjIuD2E42hMfRDe0=;
 b=Cl2ZTIrh6wbeUo+cec4wBv4Qyx2gCQ2Q9euYQuA2JKxEzm5dceFV3yc9xDq23UpLBD
 Ax2nWCOByNWtFIGc5J0ourj8siPcUekLWoVEaC0JNs3U9crWBJrbFs26lERiea+pfOIq
 lnZFmcqHBu5qr5SuJwsj8JMeS7iq2zdI/fhw8IPqqPvB/po10VfGATQeA6AwSdoFL3Jg
 WwY9cu9edXi8mYfUk3EMuIsrwGVXk41lZxun9MaZDI9joMT4NHH5BjbtR2gc3LBQ3yhu
 SMJtWD69TDg9+AItUtv2gU64+4Fmy2/97qZSwzgccojiuRh+eTYV6wI4wkLhutcEFqFv
 w2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758492245; x=1759097045;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lB3jVZjxgvOqltI2nxu9UoIbSsHxjIuD2E42hMfRDe0=;
 b=pxHIve4aBvnAhDt6aa+MGHqPK1t4L/jrulyW1pPRcvMGLGD32eZOrHLszQ1sJMl0Tg
 tV3mi9Yj9AnBAA1d5X+vWHT14nbi+OoE1EgCG17LAAybIjXV1Pq08Nzhgu6d36m7pF6F
 nJZ2hDXtal5uNaaGfOpy2p6zKK1aNpItZqIn/F8wRaf9IUtUyhH9S3mcCdKNOQ15ZGsa
 o31BbLELFAcADJe4SUXQwl74DEzHJSfy8JWxvxqA6oWNJGokP69wxe+boER7VAtY23P2
 bJm5jgqDV2+FOinP4TZXEFvDqqex+5WrGlrSeC8HdtK8MfP6N+uQ07C3bgq8rQRDhCNc
 xB4g==
X-Gm-Message-State: AOJu0Yxej0vW7GKeI/6UNw0ykNfv6FDyWdsvoZ8tA2BUFxBHKzFWrNs3
 MmwMc+pr9ZWE/5uPjMzVaXyVTP3bQhgTcmc6m3tWecAH1s9dXdpzzB6g8AKZZ1f3q7ApG/Lm+A9
 fgHuGHKs0Nj3X7P4vmpLPmXgWqfOm6w4=
X-Gm-Gg: ASbGnctCm9HG5vL6wQAyuVMbn8W/TJxP0MCIDkgIGCBvHYpH9zqbM0zPh9EzIzYVvi/
 WC1qeSw6hyq1EtUeCNenTi000CF4yo4jVs6vmJ2TS3niIiuWRLvAU8tlznOuFDXehwtCYYnDw5T
 IKmG8MK9Dz78LuQ5d1TVNKLnpPMXF78s3vZI5ZkW1NcWD84oWFckUGZ6HMQZaIYMocLYws1cGGA
 yZD
X-Google-Smtp-Source: AGHT+IGARXcPswD4C/1K1ZBm8YUvwJ+PnDtT//M3FCxqzKrv9y7Xt3vvr1aAHH7D2jkuzZRZCtQxsmgtlc9IwtHHzuk=
X-Received: by 2002:a05:6a21:e097:b0:249:d3d:a506 with SMTP id
 adf61e73a8af0-2927808cd1amr14842113637.57.1758492245128; Sun, 21 Sep 2025
 15:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250906000609.284902-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250906000609.284902-1-marek.vasut+renesas@mailbox.org>
From: David Zang <davidzangcs@gmail.com>
Date: Sun, 21 Sep 2025 17:03:53 -0500
X-Gm-Features: AS18NWBrJlaNFJM0YUe7-KjQ9EQ2UwPrZ1A_m9YhF2mnsjaIteDl8UXb4k0-QvQ
Message-ID: <CACwB3C-nrN7O8PH_oCHNXGuwJTudJ+BeCOjkFC=fW4eBcbFuOw@mail.gmail.com>
Subject: Re: [PATCH] thermal: Convert .get_temp() return value to millicelsius
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Mathieu Othacehe <othacehe@gnu.org>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
X-Mailman-Approved-At: Mon, 22 Sep 2025 16:40:04 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Sep 5, 2025 at 7:06=E2=80=AFPM Marek Vasut <marek.vasut+renesas@mai=
lbox.org>
wrote:

> Linux kernel .get_temp() callback reports values in millicelsius,
> U-Boot currently reports them in celsius. Align the two and report
> in millicelsius. Update drivers accordingly. Update callsites that
> use thermal_get_temp() as well.
>
> The 'temperature' command now reports temperature in millicelsius
> as well, with additional accuracy. This changes command line ABI
> slightly.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Alice Guo <alice.guo@nxp.com>
> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> Cc: David Zang <davidzangcs@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Mathieu Othacehe <othacehe@gnu.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefano Babic <sbabic@nabladev.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ye Li <ye.li@nxp.com>
> Cc: u-boot@lists.denx.de
> ---
>  arch/arm/mach-imx/cpu.c             | 1 +
>  arch/arm/mach-imx/imx8ulp/soc.c     | 2 +-
>  cmd/temperature.c                   | 2 +-
>  drivers/cpu/imx8_cpu.c              | 2 +-
>  drivers/mmc/omap_hsmmc.c            | 1 +
>  drivers/thermal/imx_scu_thermal.c   | 2 +-
>  drivers/thermal/imx_thermal.c       | 2 +-
>  drivers/thermal/imx_tmu.c           | 2 +-
>  drivers/thermal/rcar_gen3_thermal.c | 6 +++---
>  drivers/thermal/thermal_sandbox.c   | 2 +-
>  drivers/thermal/ti-bandgap.c        | 2 +-
>  drivers/thermal/ti-lm74.c           | 2 +-
>  include/thermal.h                   | 2 +-
>  13 files changed, 15 insertions(+), 13 deletions(-)
>

Reviewed-by: David Zang <davidzangcs@gmail.com>
David
