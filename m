Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E6DCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 08:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B241986EDB;
	Fri, 13 Oct 2023 10:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DmC7UV+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 507CC86EDB; Fri, 13 Oct 2023 10:56:59 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7020586ECB
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 10:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rickchen36@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c50cd16f3bso145011fa.2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697187402; x=1697792202; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCGWRmqzMTf3AdQf8OVpNJlpftcj01I2nAUBdx5ylRc=;
 b=DmC7UV+Upa3JPYaNfcslzDRTG073UPlNhhNGNTtCibSgA8KxyFaGl87UVdmNFbNBAU
 8smBkutcYS5IOI7zxn4x9z77taIesIfGR85d92b98MLKgq9i2jzpTbdBZj/2QswMNSsm
 Vhx0d9pd0tFBe2xRe3IGaa2Nt67BDmIt8Gwe1KNSo97zUm5gGLvoh58wiH3E/MAWkrG7
 e5oWih8XK2s+kh1Fkl7GxdmXg3ZEnSqW90ZJFwLCLGRMv2j0AXmk32TWlgpVaGd/Bdbg
 vjPVROEs0RiBrkU/qPNonHeLNydFpUqMR6FXYv5XObVEKJKqBbfm6t+dU4rjUQKjXGBN
 Ld6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187402; x=1697792202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HCGWRmqzMTf3AdQf8OVpNJlpftcj01I2nAUBdx5ylRc=;
 b=CFKy2lyr23lWbOE1fvEoOTm9WjdRs7hx/o5r/QzT3e3JTDW8eHpfnWADIdbfquiFC1
 RtuduPnNLPFEkt2yDaorspFYuKQiNUr6wtzECbm+FOgKUHX4TvdBSIk+OLpSsPoSYDK6
 PirrwvN9Dt3cQKfK+CW/0HaGDgNA7k4MaojdtOifVHQE9BUalDSRZqEBClSuULpH7F6J
 JsGSnkb2kXALHTL1g4KO0MJ2e8C4bnjVGAx2hUdl4tBQRbxRgFPYmzZYnpylQn8Vc0+Q
 l1Vq/qsP1f/l5rD3LOoy6mUDOhY7FtxvU6AvAxTGlBWlhaqkk3/cBLe3bdYGL96IKLPm
 Gmhw==
X-Gm-Message-State: AOJu0YyTntZqBFKdKwRZZzuNpF+bwJ+LlA8fcCiOnxEowx293oQ7bwa/
 Kbnt79J/m4TyGLSDDvEAhuMdRWbkzZoybh1VwBFNrkvUwsI=
X-Google-Smtp-Source: AGHT+IHKlLNh2A9gchSEc88+Gp57OUxudP1uzmhP8So0TsWMq7I2kPQdg3KCFyjEbSLBWTuSxFdVPe5tymLzqihOGFs=
X-Received: by 2002:a05:651c:1a22:b0:2c5:55a:b6b5 with SMTP id
 by34-20020a05651c1a2200b002c5055ab6b5mr1479354ljb.28.1697187401503; Fri, 13
 Oct 2023 01:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230922233526.62642-1-heinrich.schuchardt@canonical.com>
 <SEZPR03MB80642D16D9A52EE66C34D730C1D2A@SEZPR03MB8064.apcprd03.prod.outlook.com>
In-Reply-To: <SEZPR03MB80642D16D9A52EE66C34D730C1D2A@SEZPR03MB8064.apcprd03.prod.outlook.com>
From: Rick Chen <rickchen36@gmail.com>
Date: Fri, 13 Oct 2023 16:56:30 +0800
Message-ID: <CAN5B=e+gv3Z5nF8ABJWxfaT79oSwEATyFXu4PK6TuYPUorArFw@mail.gmail.com>
Subject: Re: [PATCH 1/1] riscv: enable CONFIG_DEBUG_UART by default
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 rick <rick@andestech.com>, Leo Liang <ycliang@andestech.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Sent: Saturday, September 23, 2023 7:35 AM
> To: Rick Jian-Zhi Chen(=E9=99=B3=E5=BB=BA=E5=BF=97) <rick@andestech.com>;=
 Leo Yu-Chi Liang(=E6=A2=81=E8=82=B2=E9=BD=8A) <ycliang@andestech.com>
> Cc: u-boot@lists.denx.de; Heinrich Schuchardt <heinrich.schuchardt@canoni=
cal.com>
> Subject: [PATCH 1/1] riscv: enable CONFIG_DEBUG_UART by default
>
> Most boards don't enable the pre-console buffer. So we will not see any e=
arly messages. OpenSBI 1.3 provides us with the debug console extension tha=
t can fill this gap.
>
> For S-Mode U-Boot enable CONFIG_DEBUG_UART by default.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rick Chen <rick@andestech.com>
