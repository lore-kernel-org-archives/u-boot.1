Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4323C35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 12:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BECA1803DF;
	Fri, 21 Mar 2025 13:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qonpd1iI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 185DF805C8; Fri, 21 Mar 2025 13:10:21 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA6938001F
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 13:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5499d2134e8so2455915e87.0
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742559017; x=1743163817; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Azs0WjsUX14x4+AaGLrJDg2AxfcAqxb83kEQYt5t3gg=;
 b=Qonpd1iI3M0Fvxd7IMzer9UVL0I4lbvM6FO3iAvkl95hSuIYZVarCwtkPSWyQxcDaX
 WyIOjZygCWSy0om6WEw3W2sgBQ6zvgpJRqxlRvT43XFXZmXa6BdIgyrGNplx0dma3Imt
 PkK1BFHWsUbEza5SdqsPTPIEgFeKSpLwCITityzxY3K8OGRxYR7hRnwGJFykvyD/lm7B
 2z3nyMZFJcaPk0dtGSWQ+EPyoEfHelPemcF+mpBeFZ7LoKqCaM07T16oaIDfzXy+ooB3
 RgaVqQZLYhvimB6wnzLqLdZAfvVaM537koWB32As6tyWCJApc1kqzALT42KNwRjEbnNV
 75EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742559017; x=1743163817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Azs0WjsUX14x4+AaGLrJDg2AxfcAqxb83kEQYt5t3gg=;
 b=CDg0g4A5LmYZTC0pdOLpCCp4q0L/Zoz/gXBg1OetKh9LORh9kzgjOVwBOW6uIEZwYD
 CuqVQP8xws/MXG8TtwAolH3X+nbVIexu/SwArS1TyqYI7uXaGzSaBRjdTu05fr64Ag/K
 bwHLBAHVzFQXRmY3n1v1k0Hs9e4pya/zLKtFD/59AKRNrauG3CgQqttpvDRbndTN6XKc
 MQPMdyVYwN0Eowhalh7zuQwZOT5isK+IvofnUuDONt8XZqo8ABSnAu6vyx5FM6zJ0XSj
 kTDoAzAbXyLvXzEkfyAE+rl7gY8zUQ6jz+QBybmNLp4ZFFLjzopYnAEvgUL94SPoTKbh
 zc+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEP3h2plBmaWmE3VnlOfI0q9BQho5N7UYZ6tZKq23WMzXDL8M83bf0mbLupF60i7KT9HBLH/4=@lists.denx.de
X-Gm-Message-State: AOJu0YwIpgDRkP4zv4xumhEUwgwYrF10w0zxJNRe+hv/3eJ42lQ3D6zW
 505Tknz1f2hOBNmyMJvdJvj9HGpeZzrfykWeXPyD4/MW/AHAHFLstttOsAcEdnYyhZCRzSmwEXs
 RLXK7BY7zM+wo+khiqSNV34fHfHw=
X-Gm-Gg: ASbGncvR704zTmSu/3BxBI9U7Z2kEMw03cWoHkPVBP29XVcru8Hd7kG7cF9qgA6jUye
 pJs8dMXN7Vne1YWA5ObFHK3fmeg1mJx/mFsVr9NAWrcjDX3GE8SeW9oOTv+BJ1Npf8aVjj2BhZ5
 m+RlOC+x9El7PHFIxBvlikRx38NpRtMBIDxvm/kQZ/IeepICH/0AryR2VI1Q==
X-Google-Smtp-Source: AGHT+IFxRtrN4pqnhHHhdVkl+lvdDLQVTqgYwacj65Legf3OtuKkNrG7FvHG0I+dTWaSb+qTOsIRXKYSFJ868eyhADo=
X-Received: by 2002:a05:6512:31c7:b0:545:d35:6be2 with SMTP id
 2adb3069b0e04-54ad64ef3fdmr1083070e87.34.1742559016577; Fri, 21 Mar 2025
 05:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250321013109.709431-1-aford173@gmail.com>
 <20250321013109.709431-3-aford173@gmail.com>
 <7592b048-da30-4512-b6a3-f435b6f3bc3d@mailbox.org>
 <CAHCN7xKStps4Cyr8=WaCU5bUY_doeh4jcUHv4XFUm7CLjq2JWg@mail.gmail.com>
 <2d30bdbe-ff01-42e8-bdfd-0748e0546240@mailbox.org>
In-Reply-To: <2d30bdbe-ff01-42e8-bdfd-0748e0546240@mailbox.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 21 Mar 2025 09:10:04 -0300
X-Gm-Features: AQ5f1Jo4aqBQPEbDTPcFASheZpXGo7OXFLKeucirVGtrA2vz9IFzftwOrCHStxE
Message-ID: <CAOMZO5DqTbRdeL=h69wSNoMfCFLT9KGUGz7S4R67hoaB4nOZ1g@mail.gmail.com>
Subject: Re: [PATCH V2 3/5] arm64: imx: imx8mm-beacon: Enable CPU_IMX
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de,
 aford@beaconembedded.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Christoph Stoidner <c.stoidner@phytec.de>, Yannic Moog <y.moog@phytec.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sumit Garg <sumit.garg@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>
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

On Thu, Mar 20, 2025 at 11:27=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.o=
rg> wrote:

> Yes, I know. But then, I can safely say it is desired on hardware I
> maintain, I think we could try and run a quick poll and see if others
> see it the same way ?

I think it is a good idea to imply the thermal driver at the SoC level
instead of per board.

Thanks
