Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6180BC5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 18:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B37AD803DF;
	Thu,  5 Jun 2025 20:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N9TbEy7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06FAD8091A; Thu,  5 Jun 2025 20:04:39 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F7D80050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 20:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-55351af2fc6so1635568e87.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749146676; x=1749751476; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fi6hM8ksM13B4Ub4gK5GbzJ9ASUCHOg0/6RHAqiRPqw=;
 b=N9TbEy7NzCG/xm4jVf3/QhENrrGeDJ1PnT7R+eqtqRKhBFdzkVnhjp6D64tQztSyYB
 W/BTkZTRRxQi3H6tqOWiJ++u4VCwd6tsEQOwKVhaZfLZ0nWUbpibCzWtNkodO5/0OHhb
 nWuSd8QzsYlq0XCvS/fNw/QQqelrOGnpxw2aZ7hEjeH0zj3eK1BKEM7rDLzJYc9lC019
 X+uMp9CG7gSr5NiuL4tEGFGLnl0Q+vrc9TAdZbdwlXjdf3K1UalNOMxuUA1z1CCL2q3x
 lRBFaIXU5bx2o9TfxhvNJM72Y7WNPtgtq2jirp/NNW24uDNaQFusnvvSCMLSTWH/YGL0
 Agpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749146676; x=1749751476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fi6hM8ksM13B4Ub4gK5GbzJ9ASUCHOg0/6RHAqiRPqw=;
 b=u0pei1xU1KLgrmFkh3W3YHhBmPvg0D30vssiIolYGZogSpO7bN+9q4FxZE7GNnzW2P
 tAfAwbd1G6/NSdXsMi9XAKU/wzyFWofkdA1wWncrOwoKnVsCmzfeqzVW3ATeCBgRnOkv
 gA4O5mVLheIG183x1hs6ZTd6To3RGABnNObGW1d+1DhIgCyQ3u4LZG3uymA61Iu+YKWI
 wylBai70pvWjT9wP+BDK7+xiNO9PUjt+/XB1nAAr9tJjWfFZJ60iRDQg5UYvJxvDGKd9
 wcJN2Tnt+AhFszV9botu9pPaJXE0YE1F7S2yNrjSL9f2JezC/KkA6lBu/hl+88IAUDhe
 2Zbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH5JDo4Krr0ZB8Tio5L3oG2uXi8H7Ds5CYLGhKc21LSJAv1AE4e2BTkFMg42d24k71RyxseDY=@lists.denx.de
X-Gm-Message-State: AOJu0YyYl12QXoGqYWVEmbkzXZMFvTT2Es5QMTVA08RiEOXMY6whfrQv
 wV+2YeY4/ZwYtF0PVaCZZq+Sd420q29jF910rp5+HU4WcGWyz/p0KjlLJAch2+UaLzh0LcE71wL
 KFyop6bzR1CRdhUFMpPaW+Miwof68Kmc=
X-Gm-Gg: ASbGncsk5/2P8z4Rfpv1WggK6m9CgwwG9npxnfQ3lwmzemKRCqitJ61kNvetztH+Uo1
 0LGUEliplG63S+quV+dzmG6nnwksfwlhmSmObCtpt4jVYrBC/eo6Ob3/Feq081PxJHzzL9pNLJ/
 p0IOpWunAUjq3e+EAM3qgzwC2TBMht7d90Wd5ruA7BSk33Wrxp7AZjTfKYIOPt95Qk
X-Google-Smtp-Source: AGHT+IEhXlYFYswn49NyBjD5nydcWDfSM7otOb5iDsO4SnoBuWEq756b+wdBygKTh6KvzlO6hfv+riedVLYhLIcYZbw=
X-Received: by 2002:a05:6512:2247:b0:54f:c10b:7290 with SMTP id
 2adb3069b0e04-55366bff443mr31209e87.26.1749146675918; Thu, 05 Jun 2025
 11:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250605123657.1083000-1-lukma@denx.de>
In-Reply-To: <20250605123657.1083000-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 5 Jun 2025 15:04:24 -0300
X-Gm-Features: AX0GCFu8-p_mOFaAuImo9edwAyn_LN8nL2LACHYEIqTJviU9rdDblCPy8LIwfpY
Message-ID: <CAOMZO5DpMpK-JYcK-dHjRjAQb+y48C30pz7th23isxsrv9C8QQ@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: imx: mxs: Add support for imx287 based BTT devices
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Lukasz,

On Thu, Jun 5, 2025 at 9:37=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wrot=
e:
>
> The btt[c3] devices are based on imx287 SoC.
>
> U-Boot SPL 2025.04-01081-g07e086681d26 (Apr 16 2025 - 12:24:36 +0200)
> Trying to boot from MMC1
>
> U-Boot 2025.04-01081-g07e086681d26 (Apr 16 2025 - 12:24:36 +0200)
>
> CPU:   Freescale i.MX28 rev1.2 at 454 MHz
> BOOT:  SSP SPI #3, master, 3V3 NOR
> Model: BTT3
> Board: LWE BTT SoM HW rev 0
> DRAM:  256 MiB
> Core:  86 devices, 15 uclasses, devicetree: separate
> MMC:   MXS MMC: 0
> Loading Environment from SPIFlash... SF: Detected is25lp128 with page
>                     size 256 Bytes, erase size 64 KiB, total 16 MiB
> OK
> In:    serial@80074000
> Out:   serial@80074000
> Err:   serial@80074000
> Net:   eth0: ethernet@800f0000
> Hit any key to stop autoboot:  0
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

I ran this patch through CI, and the following error is seen:

+board/liebherr/btt/btt.c: In function 'board_late_init':
+board/liebherr/btt/btt.c:362:19: error: implicit declaration of
function 'env_set_ulong'; did you mean 'env_get_vlan'?
[-Wimplicit-function-declaration]
+  362 |         int ret =3D env_set_ulong("board_som_rev", get_som_rev());
+      |                   ^~~~~~~~~~~~~
+      |                   env_get_vlan
+board/liebherr/btt/btt.c:367:15: error: implicit declaration of
function 'env_set' [-Wimplicit-function-declaration]
+  367 |         ret =3D env_set("arch", get_board_name());
+      |               ^~~~~~~
+make[2]: *** [scripts/Makefile.build:249: board/liebherr/btt/btt.o] Error =
1
+make[1]: *** [Makefile:1923: board/liebherr/btt] Error 2
+make: *** [Makefile:185: sub-make] Error 2

Please run v4 through CI and make sure it passes.
