Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A1AC83030
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 01:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ED5583189;
	Tue,  8 Jul 2025 03:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F/o7PjX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF8F48318E; Tue,  8 Jul 2025 03:37:03 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9384983145
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 03:37:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-553b6a349ccso4610043e87.0
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 18:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751938621; x=1752543421; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nmFMoRPuQTStRk+fuZmV+YtCXItgSutEi2itY/Cid58=;
 b=F/o7PjX0XqbtLiCtHJzc9eYx+8KKtfisOlU6ZWNI2tZ2BjAcjDz4rg6TfmzEOlASCw
 rwtNMKunnjdAZFvHnual/jE/Mea1LgvL87hIRkcHpKwkIgYmVWI+fyIz8RREQyo4FA9p
 atw8OuhsYOjkELKh8HjmvaIhQdOJZ1bx4gzYjEPUgrFr9N166WR1KoYJn+zm7e+b2NRI
 S9TLRILdtls3XhM2FqCjl4+IFT1RAqTrAOtl5j0EdXeVnZjYk4KyI1zqry7XDW+rM8dA
 ggrEAijclOjRChI0NfURpOckjrXWTN382bYHdszLQlXDqZAvZqnHa6gWjE9clfjp4OZ7
 n4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751938621; x=1752543421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nmFMoRPuQTStRk+fuZmV+YtCXItgSutEi2itY/Cid58=;
 b=WOEp7FGoRin6C7niADMGIiMywGD97mr/3rAGIhtGxgfdRsF1L/18R4fE6/dOiybyJw
 pueWv4/KqmPFF3wPGPurI7L6dUQ37gMygW4ympvU6nmAKXhRMNiYFeivLktKJcWRYe8n
 JmIJd1PbnaML5+qjp0V/m6+QDZBomg+yeoR8rQKhcNi116tmDxLUckvxgQd02X/Wpywe
 jeIICPkwXhzy2MYZ44DYIPeeSYRI/dlhrcuNu/LnfBxX1xwAYveC4X870aTX5K2QDOL4
 AfDm4eBZ0i3p+8CTMzTM2/avxrmcfK32S5KoTToXgLVzA84GUTVflQsHzoRPG3vRIwhX
 GgWg==
X-Gm-Message-State: AOJu0YxedGggMi9u/55wYPCO/tNE5rByE2TV4RTCPX8BZjLlka7dUvqu
 bJarPk9ORbRMXyM4aWtLTMW2EUSzAqYDRO2Itec8vzHn4V6nbxWiE43LvUgAHX4Xk8yYZLBjpS/
 E2Z0tdycYD1ZNzor7wuHtUhN1n9jF2qE=
X-Gm-Gg: ASbGncujhmmaDG5GiIKHbSvBGxwyKGVur6m/yli02u0Ae7L3FxGyt2cnj1kzKvKuK7S
 nzFrTRlzNtuzU9M8c5LLpq3Q9C86wbc5SgJIU71+VW1hDOAt6X8S0LHRAfa5XlgU/oG55sSNJ4k
 3C9Skg2+jw92sT4eWOdGajADWjUwiWSj12RXFIa0rQw+mNDUt9B2RkFcMSWFH9uy4jHzqhEsq8q
 k4=
X-Google-Smtp-Source: AGHT+IF374EqO6TL0Ktcyys/FjgD6tGfjN+IX+XiEf0SaOO7DJw1izKeaBO+Xu03FmTaDdNedeSECB+CDps4RmtUqLc=
X-Received: by 2002:a05:6512:124d:b0:553:2c65:f1d1 with SMTP id
 2adb3069b0e04-556d5e2d95cmr3772661e87.13.1751938620407; Mon, 07 Jul 2025
 18:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5Ag7CmRBhpvOB5btNvHiAMayBoxSYMoBJXbV3-w1ET7jA@mail.gmail.com>
 <072c3a1f-7501-891c-b2b7-a55ea47be0f4@denx.de>
In-Reply-To: <072c3a1f-7501-891c-b2b7-a55ea47be0f4@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 7 Jul 2025 22:36:49 -0300
X-Gm-Features: Ac12FXyyziS95nx9-at5du_OlDU7BldTq-w02pqeEGSvfEZyOoEbcvMtPmY5HQw
Message-ID: <CAOMZO5A_7Ruaq9mE=owPctK-6uDu56kaBkqth-Vngr_CvAMHKQ@mail.gmail.com>
Subject: Re: i.MX6UL: Adding bootcount support
To: hs@denx.de
Cc: U-Boot-Denx <u-boot@lists.denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Schrempf Frieder <frieder.schrempf@kontron.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>
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

Hi Heiko,

Thanks for your email.

On Mon, Jul 7, 2025 at 1:30=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:

> Have you checked if CONFIG_SYS_BOOTCOUNT_ADDR address is stable over
> reset? May someone overwrites it...

When I inspect via md.l, it is always zero.

> I had it working on imx6ull
>
> CONFIG_BOOTCOUNT_BOOTLIMIT=3D3
> CONFIG_SYS_BOOTCOUNT_ADDR=3D0x20d8024
> CONFIG_SYS_BOOTCOUNT_SINGLEWORD=3Dy
> CONFIG_BOOTCOUNT_LIMIT=3Dy

I tried these changes, but they did not help.

Do you happen to remember which U-Boot version you used?

> I did not needed
>
>  > +CONFIG_SYS_BOOTCOUNT_MAGIC=3D0xB0C4000
>  > +CONFIG_SYS_BOOTCOUNT_BE=3Dy
>
> but may because I have an older base...
>
> Hmm.. your register seems fine ... I read in RM:
> """
> For backward compatibility with earlier
> versions of SNVS LPGPR0 is aliased at its original offset of 68h.The GPR =
will be
> automatically zeroized when a tamper event occurs, unless GPR zeroization=
 is disabled
> via the GPR_Z_DIS bit in the LP Control Register.
> """
>
> May try 0x20b00090 ... just a try...

Also, tried, but it also stays at 0.

> May tamper event occurs? And the register is in "low power domain" ... ma=
y
> there is a problem... so no real idea here from my side, just speculation=
...

It seems that I am missing something to get the LPGPR register to increment=
.

Regards,

Fabio Estevam
