Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD824CF3959
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 15:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F7C89260;
	Thu, 19 Sep 2024 17:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i+v12D+b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCB6A8926E; Thu, 19 Sep 2024 17:31:10 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 019B5889CD
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 17:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f75aaaade6so11222211fa.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726759868; x=1727364668; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FabW0iTgMz68uQGRAVLGdfLA1/sTKngblQUGDVqJrD8=;
 b=i+v12D+bji5NuNXmvIJsfJWe/MXsDoJ0Ray6+u/xGmnNeS3RadS4mTWpvkHIdpXYPE
 5JgOr6sNPc4p/YuzvDf5jVgGiSCLDrVwsiwxV77E+MWyi8BlBzn/lCtFCxnnF4EiL7fR
 9AT/LTGhafthLfwVweAlwJ0u1MMw1cvrRJ6DPu29t/wXOK5Om+BMwoB6SWuN6TPK2oPN
 2MgOZ0FEAnQTcsvtImNHy4kwH34PhsfyFbpCm3N29+42Cs2ZmFulwyI1JaCKtl54wnYT
 nZc/le6bks1FkdOJ+LDd/sEVki7doLvBStipBJj14S4OgHMWugaGpdPhtVT/RssGpSIB
 ApHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726759868; x=1727364668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FabW0iTgMz68uQGRAVLGdfLA1/sTKngblQUGDVqJrD8=;
 b=kCJKlba2DEBedDXbtz3E47bSq67WO+tyNDj+9lAQf4ABx1oYqUyGpJGaYRradPOVvX
 sCGr2FK3GHnEGWpU9oP8dx+Aj0SIOJVUvrCGEpwSXKtOXikU7R64cNGwc7aHDTQ3Qldm
 s29Gpm9ic+/K+2G8klKA2ciQvlFefQ+OwYihddEqvqt76BMwmPp7uxhj8GgJsHsfZl9+
 2l8eyBwangXyBkjJpymMuuyeB8ulUnhIEO6jfTgZ6hKwGvryi03rxa6FynQITRoBI2I1
 0l2wGo3qjlXwZcsossLGpMSvuoAZ7QbTeQ0rx8CZvSFTgcWjWLu71bPN8f0X/UDG075b
 4m6g==
X-Gm-Message-State: AOJu0Yy0AecVtGTPXhZYO77NJZYiM4WogRxRULdFkGJWV01/IURY8oOu
 5r7n6d2bAIZZ83t9L4ngG90CuS37nV9iQ2Nm+qbkiKZTJ2b4I78KuSuKtfwFpRfE7BXvUE7d5qo
 +98HW8MckzDgIRnMt4BVAkfrVgpk=
X-Google-Smtp-Source: AGHT+IHWy0MQcBOqxd0Dh2TdWi4up09uo2Qm6CyIu0m4PGLlTM3NxEmCZafp8UNAiUiIiBBD3BPbedFN+hqWSKy2LNg=
X-Received: by 2002:a05:651c:b28:b0:2f7:7ef7:7434 with SMTP id
 38308e7fff4ca-2f787f4f47dmr151221661fa.37.1726759867994; Thu, 19 Sep 2024
 08:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240919144507.249682-1-konnorrigby@gmail.com>
In-Reply-To: <20240919144507.249682-1-konnorrigby@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 19 Sep 2024 12:30:56 -0300
Message-ID: <CAOMZO5DKD0ZziHb8YmKdz_yxCx--vLyydC4wFK5MEQVvB8mddg@mail.gmail.com>
Subject: Re: [PATCH] arm: imx: fix board_mmc_init for google coral
To: Connor Rigby <konnorrigby@gmail.com>
Cc: u-boot@lists.denx.de, Alifer Moraes <alifer.wsdm@gmail.com>, 
 Marco Franchi <marcofrk@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
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

Hi Connor,

On Thu, Sep 19, 2024 at 11:45=E2=80=AFAM Connor Rigby <konnorrigby@gmail.co=
m> wrote:
>
> This fixes a typo in the mxc_get_clock function preventing SPL
> from initializing USDHC1 and USDHC2.

I am not able to reproduce the problem with the top of tree U-Boot:

U-Boot SPL 2024.10-rc4-00034-ga7b83ade98e0 (Sep 19 2024 - 12:24:44 -0300)
Normal Boot
Trying to boot from MMC2


U-Boot 2024.10-rc4-00034-ga7b83ade98e0 (Sep 19 2024 - 12:24:44 -0300)

CPU:   Freescale i.MX8MQ rev2.0 at 1000 MHz
Reset cause: POR
Model: Google i.MX8MQ Phanbell
DRAM:  1 GiB
Core:  67 devices, 18 uclasses, devicetree: separate
MMC:   FSL_SDHC: 0, FSL_SDHC: 1
Loading Environment from MMC... Reading from MMC(1)... OK
In:    serial@30860000
Out:   serial@30860000
Err:   serial@30860000
Net:   eth0: ethernet@30be0000
Hit any key to stop autoboot:  0
=3D> saveenv
Saving Environment to MMC... Writing to MMC(1)... OK
=3D>

imx8mq_evk also uses the same mxc_get_clock() parameter and also boot.

Which TF-A version you are using?
