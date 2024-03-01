Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BFDC5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 16:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2EDB88142;
	Fri,  1 Mar 2024 17:50:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d/C4hJd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D9E588142; Fri,  1 Mar 2024 17:50:16 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6112687D65
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 17:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dbd81000b6so6212505ad.0
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 08:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709311812; x=1709916612; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAHdv1wOLsskB/fdjI7U1MVzzLVAK/rywVTe1L7gPQ8=;
 b=d/C4hJd7oqc5POtdR5sbn2kO/6rXUsaAiJ1owyKLaEW0YnYi1MIAdSrqgJaw2m9l37
 JEzYCN4t7K429g8YgC0Dmr0XwU8EKmvAeDn5HsCetg4jo90HNc5pjTIOPvFOwYQ/ztIO
 wqJCEtXZSKJVJssWmn65xvy27ow59BJ1RJPYldyEDswK5s1SrxXy3AjQos9YUJkb2D0/
 FFrLqlX7hdSPPT/ivDhQEvcoIqRfshQ7gbpmZ4LPx6Le7Uy2e/pOE8tPGXgGuQMv90GB
 0QivYwUNGQy9IlaEH4AwmYZwgM4CzeZ326cxVdeyfIWGXVQBiB4okRcLCS27ymglZOZU
 Dmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709311812; x=1709916612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bAHdv1wOLsskB/fdjI7U1MVzzLVAK/rywVTe1L7gPQ8=;
 b=EktIozSueBk2jbkwjh0WUsMqI5qXWRek/wWJ73IO5RhnDyWQYicLDh3IQgiLihvwqc
 e8jQkSzBHsGm1cEPH2qc9leY+7SIlSsaXdZOyVmh3iQkPLkDDZHOg9J1NF+tBbGEGAS2
 jjBuSnFKiusvHypl+rkBnXFnWQwMATlKz2QUHsdeFYStyTdIU+F91rHyRs09mcv3taqw
 sn4WiyG3288zin7N6bj+y3zbL4qOWObyhTJArfcDy3oKW75r2pT3Qspx+opw7EHb2xHo
 lZBQPbI/0Zfw9Pkt5jZoZ/RlKseK5qY4uXLZQ6J+DM8fztHW7o2c0P2jrDZxe9Rd9Jd6
 LKyQ==
X-Gm-Message-State: AOJu0YxxVpvur5quakStBwNPhplmZmOV+pYT2LzYpF/SAUWw2bjDtntW
 O+d4dRsxtuUjsFWk9sswJQ8B4pNNURXgsaal4qDQYYsvQ4YJ21YrvLJQ5mD6OW/YLG+no0piYX9
 Q9kc1XhkIyLA0KsbbS/pEneb8k+Y=
X-Google-Smtp-Source: AGHT+IEr98czgYle/k1TwTb/yzE2lXBuUTjtCSKE294u+JUHfiQYiM9o9+0rbIyQ9g4djEhsOq8V/3Y+L83Lm+eq06E=
X-Received: by 2002:a17:90b:1909:b0:298:b736:ecf7 with SMTP id
 mp9-20020a17090b190900b00298b736ecf7mr2145967pjb.0.1709311811670; Fri, 01 Mar
 2024 08:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
 <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
In-Reply-To: <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 1 Mar 2024 13:49:59 -0300
Message-ID: <CAOMZO5CjeUhFfLBs3FRt4Hbk0ULXrRoOZaZqvSRzWbNySdsOhQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, marex@denx.de
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

Hi Sumit,

On Fri, Mar 1, 2024 at 9:57=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, 22 Feb 2024 15:05:56 +0530, Sumit Garg wrote:
>
> > Changes in v6:
> > --------------
> > - v6_dt: https://github.com/b49020/u-boot/tree/v6_dt
> > - Patch #3: Incorporate fix for sandbox CI failure.
> > - Patch #6: Incorporate shell script comments from Marek.
> > - Patch #8: Incorporate documentation review comments from Paul.
> >
> > [...]
>
> Applied to u-boot/next, thanks!

I am trying to use OF_UPSTREAM with imx8mp_evk_defconfig:

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kcon=
fig
index 328c3e388051..29d0c5ce6485 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -8,6 +8,7 @@ config IMX8M
        select LTO
        select ROM_UNIFIED_SECTIONS
        select ARMV8_CRYPTO
+       imply OF_UPSTREAM

 config IMX8MQ
        bool
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 2350d2f409b7..cdf840c683c0 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
 CONFIG_ENV_SIZE=3D0x1000
 CONFIG_ENV_OFFSET=3D0x400000
 CONFIG_DM_GPIO=3Dy
-CONFIG_DEFAULT_DEVICE_TREE=3D"imx8mp-evk"
+CONFIG_DEFAULT_DEVICE_TREE=3D"freescale/imx8mp-evk"
 CONFIG_SPL_TEXT_BASE=3D0x920000
 CONFIG_TARGET_IMX8MP_EVK=3Dy
 CONFIG_SYS_MONITOR_LEN=3D524288

I ran "./dts/update-dts-subtree.sh pull v6.8-rc6-dts".

make mrproper
make imx8mp_evk_defconfig
make

The dtb is built: dts/upstream/src/arm64/freescale/imx8mp-evk.dtb

but mkimage still looks for the old path:

 MKIMAGE u-boot.img
./tools/mkimage: Can't open arch/arm/dts/freescale/imx8mp-evk.dtb: No
such file or directory
./tools/mkimage: failed to build FIT

Any suggestions?

Thanks
