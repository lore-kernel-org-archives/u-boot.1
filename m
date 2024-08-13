Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598DFC52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 16:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A83C88842;
	Tue, 13 Aug 2024 18:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jyOelVoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A50F889A1; Tue, 13 Aug 2024 18:26:38 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F376880A5
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 18:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52f00427236so933267e87.0
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723566395; x=1724171195; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qt1Fs24gXEY2mREhfY11FwA+QA1hX0uj7hKfizGDvWE=;
 b=jyOelVoHAlo2hbLL6N6lpxYZ3IrK66PiVzIQ9TUUSiNhM/c7yVaAp7jp4j1b7GIarI
 p4NRwpDQ0dCLV6hHpaMSzJHpimFcHg+xpREkFEVp83QmHLw0Hr7SK+NXyJv3DWk3djZN
 u8JRUcRdL9JVO/r1mFsqm4mAVTSj5vy6Xa5kcckYSRZyK2ngeiYztZaf1QgkHAfcI22c
 rXxyZxIRfwXE3wO5Rz3CgibGi3zcbc5cc26bKjcwK0hAk+RGFkRhI4PWb4z8fzqVAJjk
 NOyH00H5tca1PEjiATfRLPZ2NJAJNS0C+dRF6tRHR+TWmmv9GTgbsHQidFAvqOe8aVDU
 FY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723566395; x=1724171195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qt1Fs24gXEY2mREhfY11FwA+QA1hX0uj7hKfizGDvWE=;
 b=Eig0/mHjqtHeJyuZQx3JeYqVfQx1LXX4fPbpuUqMKMQKYlMseQoOnsr7TyH1EEw48o
 +/+myf++kAyfNSZ73fPpj80oBMj2O8cQRo3kbFiWHPa4wH7Pe1cr0MCMF4SapRtkj/vA
 y77HGgAMJBLPBh1TNstTbTLc9Fyv5EYoddzuIRFdHf5XRRKkEsYRFtlNDhwf15kd/dzx
 FKr+bNQlNM9TMMY7MTAO8jGnVZI2mU9UfuowRfFkem5eAy/yEZdM4CUeelpUUJkXXCRY
 v3HXhIKfrkJuGmSZ/v/QgN33R1pQuz2dVaCJha80TSO4gMXfPIEgO1uypEDvU8peD90d
 R0Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdalZRQ3TzrX86S4UFfiJb8I7H7xlP5QqE57p5NJxQbRaaecJr0AIQ2d/gzeZbonwE9stRL9I=@lists.denx.de
X-Gm-Message-State: AOJu0YzPrB9+CD29Arn5gByGPUNtwBtCvOUn4pBw2eDno1qIxe4NYCxf
 DkIdPZFk6SiPs+BJjV2g5E9HWy+vdyj2B6VxaF+2a/nqw7yY58Lp8ne3QSBFDiEfTgrDc1fs4Ie
 0sc4Ad5vAmi7EJ6hioWXo6JBZCmY=
X-Google-Smtp-Source: AGHT+IFijpZ9lws/3ylGoBXW/3MdT3g5EHprmjlVJzsHPGIOa51XXRNedZWtf7xJjIByP9mDG3mlvBu052iGPMEgOZ4=
X-Received: by 2002:a05:6512:3b99:b0:52f:287:a083 with SMTP id
 2adb3069b0e04-53215be2ab8mr1339398e87.0.1723566395047; Tue, 13 Aug 2024
 09:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240807133919.4155815-1-max.oss.09@gmail.com>
 <PAXPR04MB8459DAB001E8D22E23873CB488B92@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <ZrSXoq7CEEtFMu5G@toolbox>
In-Reply-To: <ZrSXoq7CEEtFMu5G@toolbox>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 Aug 2024 13:26:23 -0300
Message-ID: <CAOMZO5CfoHyJa6CGo9duLHeuj8yQoT5fTio_=Xp6YAaBpUXKYQ@mail.gmail.com>
Subject: Re: [PATCH] imx: imx8: fix build when CONFIG_IMX_BOOTAUX is set
To: Max Krummenacher <max.oss.09@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, dl-uboot-imx <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
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

Hi Max,

On Thu, Aug 8, 2024 at 7:02=E2=80=AFAM Max Krummenacher <max.oss.09@gmail.c=
om> wrote:

> The current code does call a function which does not exist. Thus the
> compile fails if enabling CONFIG_IMX_BOOTAUX for a i.MX 8X and likely
> always did.
> I think that would merrit fixing it now rather than waiting until the
> more modern API is ported into U-Boot and the code using it changed to
> the new API.

Agreed, applied it.

Peng, feel free to submit additional patches to address this issue.
