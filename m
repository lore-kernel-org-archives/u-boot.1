Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15661E6B24D
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 12:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B33488FBB;
	Fri,  1 Nov 2024 13:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QoUWJTkf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFC1F88E1B; Fri,  1 Nov 2024 13:30:40 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76BFA88FBB
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 13:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fc96f9c41fso20471241fa.0
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 05:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730464238; x=1731069038; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDYQf+EdeRIres9wmDmEqk97zFN9j8f0WGITxbId90U=;
 b=QoUWJTkf7EcfiK/4d7CLZ7ENK3v/zX0BX/MOKq4TmqoMVtckKkqCJXzBPIjMY8F9DE
 W5B/tZxyj3KObOA6v+0px9JiWnnnp75Rh9hSzAnbV66dMEclf47GivMjWMrjQL5uXxYt
 jfVme9rBhEq/b8VWjV1wUasScAMkUmy2G7firppOQreRh9KNZzibEV8MxGRyoFOhK+4n
 GJM9cXDPMRJ+Eowm/qtHj60hFSsEn5MkeXh73T4y9HIF3M9XljA/iYLiojz0WKCzGjZa
 xMg1VcUznuf+ZIiVp0+4gvLyT7T6QT3Tjud2mFSOGfXsUueF8GA5Gzz2c2g0NSrw41VQ
 TpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730464238; x=1731069038;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FDYQf+EdeRIres9wmDmEqk97zFN9j8f0WGITxbId90U=;
 b=Ysr1sgsEoVSk/mkvaaoLH9/C2L45R7dn5LYbOC3T55lIs1dusUGxIuIQM0qk3xxzOk
 GwJZLUTsRxMV0BQfxmNF40sB5YqkPQJd02Ay3DKu81erx40DR/8MCNUpQhnTFDlBiYhv
 LmnjQVmj0CsHgXNHSuenCtqJ5VylKY1C5oEE1CLvEnmb+jARPN0QmGrHxuklT/oCZFzp
 hw38S+1uTq3Z5d2taKJEBUoRVQzY+TZb+6n/N0CplU+1cRcXDUNeSjJW/Sgv2y08vYeX
 mwK7dcucqmgqXZrFr09K8wkAIaS5RKt3DJ8h/12xEJ8Klu/yrEp29VEF2vAZr0Q3cgro
 LzHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYBufrc0IBlViYWRO8fi3ZZDixtA/NnXVPU1wc/2DB4iwgLacdO/+PoGzaWOWyLLDZsuvIX9Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1mNmAj/xZoAssLbsMuQpuEGctWBRaNUABDDWjM1eezdAtpi9r
 29gBgDMLwo3eWdhiQtf4UBfuWNkcP3zj6PXFLG8RjQnHtZkPtz0DLLncFL4n2+wSyxhiIwSzlWb
 lqCkT9zAeDWVWnLWihzr3eTAjAW1q7Nab
X-Google-Smtp-Source: AGHT+IHJTg8I4ZjuVCCsP2YG53dDjbrxYPuW29EGNnYbVhpQ/Z/MY6eJm6ED8rpv367MxFvv1KaWtI22I7L+InWPuac=
X-Received: by 2002:a05:651c:542:b0:2fb:62ad:89e4 with SMTP id
 38308e7fff4ca-2fdef2a8192mr18495021fa.19.1730464237378; Fri, 01 Nov 2024
 05:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20241013174120.1872-1-egyszeregy@freemail.hu>
 <PAXPR04MB845929FE951FCEC327F9F54788442@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAOMZO5DBDDYr+9K8rq56L-=5EGWDNXY514rz5zoqPdXOQ2x=jw@mail.gmail.com>
 <93d2989d-7d55-40a3-a44b-ef64e1feb511@freemail.hu>
 <CAOMZO5Bvkqj6uYpSU=JsWd_t7yfvHAqhs9J08fGiEa1nfCX3Hw@mail.gmail.com>
 <DB9PR04MB8461C9D5EB7ADA89A2D335CE884C2@DB9PR04MB8461.eurprd04.prod.outlook.com>
 <9a06d2e7-37f8-4371-a4b2-0daaa38e2032@freemail.hu>
In-Reply-To: <9a06d2e7-37f8-4371-a4b2-0daaa38e2032@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 1 Nov 2024 09:30:26 -0300
Message-ID: <CAOMZO5DPZMRV-mYydxbLL8CGTocXp1ex6DSMgL5JJwP_FN1i9Q@mail.gmail.com>
Subject: Re: [PATCH] imx9: Improve boot device auto-selection
To: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
Cc: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "sbabic@denx.de" <sbabic@denx.de>
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

On Fri, Nov 1, 2024 at 7:56=E2=80=AFAM Sz=C5=91ke Benjamin <egyszeregy@free=
mail.hu> wrote:

> If both CONFIG_ENV_IS_IN_MMC=3Dy and CONFIG_ENV_IS_NOWHERE=3Dy are in the=
 config,
> CONFIG_ENV_IS_IN_MMC=3Dy will be overrideing default CONFIG_ENV_IS_NOWHER=
E
> settings, so in imx9 defconfig it is useless to use both of them.
>
> In my board i can use CONFIG_ENV_IS_NOWHERE=3Dy without CONFIG_ENV_IS_IN_=
MMC=3Dy in
> imX93 EVK board but i needed to make this patch in imx9/soc.c and imx93_e=
vk.c
> source files imx9 to get it work.
>
> It will not break any rules. In this boot mode selection it just a simple
> process to set "mmcdev" and "mmcroot" according your actual MMC device ID=
s from
> boot switches states. It never be able to break any rules for UUU booting=
 in
> Serial download mode because you have to use manual commands from UUU scr=
ipt
> which will never use this mmc variables.
> https://elixir.bootlin.com/u-boot/v2024.10/source/board/congatec/common/m=
mc.c#L41
>
> Goal in my patch to able to use the boot mode autodecetion in case of use=
 only
> CONFIG_ENV_IS_NOWHERE=3Dy option (without CONFIG_ENV_IS_IN_MMC). It works=
 for me.
> Please sit down, put your NXP board i your desk and try it, then analyse =
how
> well works for you also.

It would help to put some of the details you add above into the commit log.

There are checkpatch errors in your patch:

$ ./scripts/checkpatch.pl
~/Downloads/imx9-Improve-boot-device-auto-selection.patch
WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef'
where possible
#121: FILE: arch/arm/mach-imx/imx9/soc.c:45:
+#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC) || CONFIG_IS_ENABLED(ENV_IS_NOWHERE)

WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef'
where possible
#127: FILE: arch/arm/mach-imx/imx9/soc.c:51:
+#ifndef CONFIG_SYS_MMC_ENV_DEV

ERROR: All CONFIG symbols are managed by Kconfig
#128: FILE: arch/arm/mach-imx/imx9/soc.c:52:
+#define CONFIG_SYS_MMC_ENV_DEV 0

WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef'
where possible
#143: FILE: board/freescale/imx93_evk/imx93_evk.c:61:
+#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC) || CONFIG_IS_ENABLED(ENV_IS_NOWHERE)

ERROR: All CONFIG symbols are managed by Kconfig
#157: FILE: include/configs/imx93_evk.h:32:
+#define CONFIG_SYS_MMC_ENV_DEV 0

total: 2 errors, 3 warnings, 0 checks, 37 lines checked
