Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C49BCD6E75
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 00:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2262848BF;
	Fri,  5 Jun 2026 02:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TnT5K2hQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFA8F849E0; Fri,  5 Jun 2026 02:14:04 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE69684874
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 02:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-396775c2720so12027611fa.2
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 17:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780618442; cv=none;
 d=google.com; s=arc-20240605;
 b=RSUP8DejYa1ZFcxvYppOoTeLnkt6Ylu0f5vnCHPMzbFWRTyHrwjowBf/pIrlo6/R4v
 VO0keb0tUIbuCzIbr5f0frR7iAJ0Go81/JuKZmNckqmz1dH9b34nSU5qWuX6pVnYvT0s
 RSkz7RqCYlR50XK711huvd1LHBPChp5mUXC2YjLseOioeBpwOvcxOPdisE3uFlvb7Jaj
 JJ7AgnykaxLT+BRjH0IgXXZTepBk0JRUajVUBs08GheHPr9se1WYxQpJcxML+5MxePst
 1pZ3D6unkZqwvGhbl2pvoOLsLtohhmGd59ZPZVI/yF55OuhD5c3FrN9gZzVrGshm2bx0
 RUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AwAFpHkqh9g1z8+VaUl4y7K0viNctNWuevgOSk8TL2s=;
 fh=NRFM2gW6pFNNWYCYabUkzVmyCZlDyuyONd/hNT9XRcs=;
 b=lumWaVhgNyVAvkt7hcRsFVifV3/d3UDNwphYjGo4PscfNyznQ5yZ1uxLas2tUy2gFk
 LIi9nBr0g8jik3rp2qCiQOxW4RzSZGXz3fvyftjkW6kn73Y8LRMwK8HlUD+UJtg4G3lQ
 hrt9Q8PtW4eUfI34yWZwe4R95Nmm3Mpgcqwv+kDMoOwf4TyvYt0/Cps93wMXdpT/dJTd
 TIZPRplCIV0rCTEeR/nNQKdl8u31W0H+JbUWiF+S1vtTd9l5e/Fomc2Dd/U/YsnzoUxt
 AG8Tzy4zTvsia+IRwaNTBcf18cjCCwwCG+IEmZ9tXk23z1lv4MS6ipvy4XZ7pxathbvQ
 lIFw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780618442; x=1781223242; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AwAFpHkqh9g1z8+VaUl4y7K0viNctNWuevgOSk8TL2s=;
 b=TnT5K2hQKodS7yzwrrX9W0RkrmiAxmuj57z2UtKip5kmAdCVxRZ7PZhFXWkngagruy
 UJ8ewP0Oi3g2OM0S6sh8HCr7Vyo79ZJngA4aURCDcfiGsRHG+ycWFIlegUmmf0x94p5W
 sP/45G2fQxAR8KORYDLXOgUFrq3DAJ2pxz0okvw/joXV0NaNGi48Lxx50bJryWcUVp6P
 IAcK9DDT0jvvCwXZW+rNUEaqUQMaOwsFBhfZKRoE/hw3iBLs+oiTqVyt3qadFGcgueII
 dklADg5WgsVUaqxF6Q9VJGpXizUmrtCnlTJjRl/yKLGUIEw0vk3FErOlgz9/aPK5B4pb
 81FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780618442; x=1781223242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AwAFpHkqh9g1z8+VaUl4y7K0viNctNWuevgOSk8TL2s=;
 b=W9iEQoticECjjrsXY8wMJhy4teaYHPAIvp52wQa9i1HsPjiINeMhNDI+yI2DhNmdek
 UfqV1bT87S2P9NzA2e1ItriqBbmNDAjj0JNLI4B0nSQdW0dOBkOWoFyz7+tv27gwsc6U
 IfT7w0b+uMhs+bozcjedVa832o+p9QVYum2aq09w4uVMbKpPFt0yt7HHHDKo2Yw1ZL1o
 dHkIJjQCVeOjHyW0Jayd1JF/P+yaRZ2oI97mAjrup3uY/MpE76aR56mvue/j9VLQ2Pqc
 17VJ2Gl0e9F9Ri5OWLeBncF+HYFf0ohvVphOGabXA0kcK/k0rVM7xxAvF5cFjzvcfzlr
 qmfA==
X-Gm-Message-State: AOJu0Yz4QYdZOxjRLWfkK3a+d+vthOs4fhm+Mz5MIPt6PA1rFXaAcqzE
 WRr2qcCtKAcYD3sEV2kgK/wWd4512yTKTNQJ0y8m6ubW6Ti0huKgq8C4gXzb+3z+D4aUfh/SenE
 wjv8BSIBkIn6TX613ZXioaMduLwb+kLU=
X-Gm-Gg: Acq92OGF53YSkFd62e5cbu0zK0Oo5aYctVFNXDELHIO1DL38vMcJo1CPNFwU1WBmzLX
 JOsEGLGFdhLR75ImkMImuFEOXBxAX2D267dY58BX/7/g1UvBexoXr6dSi9pei9C56+yVl1Lg9H+
 t+6ckhYEUTt+JiDeVAiSTJm5ZC9qJ9r+txgdWMGwztwo5tyzrcCBHfzru7uglWbXahJoFBEGmlA
 tKJ2a4Yc6zQ6PR0QMwvPtO7Yj+jrCBvqXRVIw/+jZSUf+kwQPpo55jYZUHBryLn2MBI+o2ASjeZ
 SqX/46QCizI8TEXNjoAMZaBq6n2gM9qS/QsQc3vQQv4pb4/KVPujGQX0nE6gJ+0lp+PyBJ1SHUT
 AQT79MQ==
X-Received: by 2002:a2e:bc24:0:b0:396:7707:b2ef with SMTP id
 38308e7fff4ca-396d09f62f9mr1927191fa.27.1780618441663; Thu, 04 Jun 2026
 17:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260530170954.239682-1-marex@nabladev.com>
In-Reply-To: <20260530170954.239682-1-marex@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 4 Jun 2026 21:13:49 -0300
X-Gm-Features: AVHnY4Jxb7iMkqVs6dIVV2d4TukQlVoJcVgNlugpnYL0P1fg_At8CCNe2vDka4c
Message-ID: <CAOMZO5A23MTWuFZ-tQa20hBkF_pEY1-tkoHtEWrY+GCyfhbv7g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] binman: imx8mimage: Handle nxp,boot-from = "fspi"
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, 
 Alexander Koch <akoch@initse.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Sat, May 30, 2026 at 2:10=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:
>
> Boot from FSPI requires additional 448 Byte long header, with U-Boot SPL
> starting at offset 0x1000. Currently, both i.MX8MM and i.MX8MN attempt
> to generate this header using fspi_conf_block with filename pointing at
> CONFIG_FSPI_CONF_FILE file. This does not work, for two reasons.
>
> First, the CONFIG_FSPI_CONF_FILE is generated by mkimage -T imx8mimage
> and may not be available yet when the fspi_conf_block is evaluated. That
> leads to a race condition where highly parallel builds fail to find the
> CONFIG_FSPI_CONF_FILE, which is usually called fspi_header.bin, on first
> build attempt.
>
> Second, binman gets confused and patches incorrect offset of DDR PHY
> firmware blobs into U-Boot SPL, the offset is incremented by exactly
> 0x1000 which is the size of fspi_conf_block.
>
> Fix both problems at once, make imx8mimage handle the generated FSPI
> header and prepend it in front of the imx8mimage processed data. This
> way, the race condition is solved, because the data generated by the
> imx8mimage are surely combined only after mkimage -T imx8mimage ran.
> The binman offset calculation is also solved, because there is no
> fspi_conf_block node in the DT anymore.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Applied the series to u-boot-imx/master, thanks.
