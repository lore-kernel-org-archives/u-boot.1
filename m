Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B79D149F9
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 00:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2160388D47;
	Sat, 26 Oct 2024 02:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L+xYiaFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3560388EDD; Sat, 26 Oct 2024 02:21:47 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9301188730
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 02:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so40042901fa.0
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 17:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729902096; x=1730506896; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OY1QMkjbRMyl5yyLOdCLYjyXhzv18fmgDeooyMD3l6s=;
 b=L+xYiaFnqFPMURS5IhaguKPURCodHhaAvxjrLlzVWZCHft4sFBhydsxodvBiNryIcN
 XKgi4m2dkfiYa+rBZZyHHN34XI+oNorS9npV5gYsC/2V8DTcpXd/fUdGk22uKHF3EZ4p
 5ccMd/iYB+tENf5qBZuWGRurAbRx69NAqRv/vqiKpqgPfxMNCLvsKdWjI8V4TO4aiq66
 cC8VaJOE0DflTPiSQO0RmtBGVJjmF540I6kIha4ey4ahRCMz24WvE7cgUFneoQb7qRbi
 nA0knxSqI1U5lB0FBFRR8L66dMkT61BSr45cVaP7E1WgvFsJ9RPxz/k1admVzbb2s4xL
 MAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729902096; x=1730506896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OY1QMkjbRMyl5yyLOdCLYjyXhzv18fmgDeooyMD3l6s=;
 b=kN7pqCNjdJk9jj3Ot7QzlhxpclSyLwUjiU2d6lDkOVEXH0C/rSqWazLTOddmNIt9z/
 PXWs9xU+inKHilbSBXqnPPA+AO7Byvo8ExZpL+3iARVeWZrfDfP3rWARagYOedMM/8pG
 qD5nXxSX9/Ye7iq9F3OHg9MtcdCn+fsAA3Vr1MBn99ngrtWm4LivTLKHRa07Ltd663cV
 6mHpR6HyrMZz3wTU130PrKDE7HSD23mSCvEGzM3Em5HgVWLxtGFwqaSEb8U59CZ+bBl3
 DQlvAa1gmVsgD5s+pIKOLZRUUY5qFAIjw3Yxq4TMFchMHExMQErZBnhCnnHy32RtTU5P
 FXdA==
X-Gm-Message-State: AOJu0YwvIZQxcHEDLluivA5K/kQc5nBGRh0e6vy2GsOLAnRJHXQHwFV6
 wRssfOI4/60/AK5Jz7FBhAZSzwW7+dJERS8JnJFhTgppnihN5H5Rb9OtPEwX1yrNZqmWinc/GEK
 oNPt1RZOSUn8izOamBEqC7E+WRsI=
X-Google-Smtp-Source: AGHT+IG2rQXeRwCeO1Edsj8c1pu7eZBUKGfTrDgaR8VQ5ZyuIT792lOxcUZY9G59fEznS1V7Kmeyx3cg8f5giyiNRT4=
X-Received: by 2002:a2e:a9a8:0:b0:2fa:c0c2:d311 with SMTP id
 38308e7fff4ca-2fcbdf66b6dmr6901981fa.5.1729902095476; Fri, 25 Oct 2024
 17:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241020210113.1248062-1-marex@denx.de>
In-Reply-To: <20241020210113.1248062-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Oct 2024 21:21:24 -0300
Message-ID: <CAOMZO5D_TN1Svc9JeS8F1Aamos4dXX8xTOt-XgDwHuW6HeTq+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: imx: soc: Select default TEXT_BASE for i.MX6
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Sun, Oct 20, 2024 at 6:01=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Select default U-Boot and SPL text base for the i.MX6 SoC. The U-Boot
> and SPL text base is picked as the one used by various i.MX6 boards.
> Update all the boards.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied all, thanks.
