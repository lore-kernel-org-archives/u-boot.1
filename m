Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDF5CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 17:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4736788CE9;
	Mon,  2 Sep 2024 19:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DgckvSIN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD5A88CEB; Mon,  2 Sep 2024 19:46:31 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FABB88C53
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 19:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5353d0b7463so7543171e87.3
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 10:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725299189; x=1725903989; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSvW+v4eqHKGVsOulrN/2E8nfE9OXlzmd+KeH6BG17A=;
 b=DgckvSINX/Rvzj5Oz999GIIIzbHIwYDeNo70pnFK+EpSj7C4rKSuVBPvdSdwU4Vnii
 swsbksJ9zBeaehukPXUHzyjdetDq/qTdH2UITKLFISG9MHKGPv+piIchocnWZeLWsn3P
 N/JS5Iyh+XnhpRtH/bvHb/hyLBVGsNz7Fms3qCV9IjoNu/HPkQ8R8Ldg4yzonSQ0suGy
 Y/5KYGbN5ueS5wl3so9nD8K+y2HowVui4xbycSrqGfD7/CnWc1fZK0eha82uc/SIuz5Y
 W4o1+bYdeJefg9G4dvpTB/JoPsgKqhYqX7AkWmtaOhpwe7qwU19HjQgYRTRX0vZP4dli
 sLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725299189; x=1725903989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iSvW+v4eqHKGVsOulrN/2E8nfE9OXlzmd+KeH6BG17A=;
 b=alvYwLR4TznVOpUhodSKQGnlysORXn2e2zsvxHWIDAS9Zldtx9oHL/HFXRQnEJsUXY
 xTSkHtlCMIdpQX4/ljtc3SuJi8BNvkxdvTp7CaUoUdl24BdQnEp2YY2WNlyGxhQCoXzn
 Gl1d0Txj8S5kBXr5ZylRs7mUSw46Fv2vpCvKtdRt5h8MfU6MQ5+slpGPBySapwXCIG5O
 5uv4ILQT4Assi6dO4Hs/VeFF1ZUUH4eD2X/M9cAcGE03lQH+6x4c1yS531bB7vll835Y
 tRWfhYyR5SA/qUF5fW0ilMhK49lzSCx0LynqDQDhS67Z+BUTYn5KNncd5yCT1sVedCI6
 5i/g==
X-Gm-Message-State: AOJu0YzS3Fy/DOxZfOaQM1bnPDvee6VJwxHcMLNT5Z5aOGdy7OvsMLZF
 1N9xs5NJJBDCRTdDgpKWfBGhGXF8K9kBlOVHQFRo/QIfizMOmVV6/ECTEK1Uyj/4ydVxb35kHSM
 Lq4Lp0U6zWKEDl5LAIyASk7iYOdE=
X-Google-Smtp-Source: AGHT+IGHEs5gRuKEdVCsRQUhkFEWv7CepJKD5H98cIqE2dhKZcftqzVhC8+1uPMe9niy0dv0BjHaQrEEIPxpibYr6l0=
X-Received: by 2002:a05:6512:6ca:b0:535:3da7:5b59 with SMTP id
 2adb3069b0e04-53546b1c7f8mr9266166e87.12.1725299188571; Mon, 02 Sep 2024
 10:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <py.Zbyp.4iSBCzZ4lgW.1cpo6S@seznam.cz>
In-Reply-To: <py.Zbyp.4iSBCzZ4lgW.1cpo6S@seznam.cz>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 2 Sep 2024 14:46:17 -0300
Message-ID: <CAOMZO5By67qkxz0u9A6NxqzaMTRtd=rAYVZLFNE=gtfiW7X2NA@mail.gmail.com>
Subject: Re: [PATCH v4] gpio: mxc_gpio: fix reading state of GPIO pins in
 output mode
To: Tomas Paukrt <tomaspaukrt@email.cz>
Cc: u-boot@lists.denx.de, marex@denx.de, trini@konsulko.com, 
 francesco.dolcini@toradex.com, tharvey@gateworks.com, aford173@gmail.com, 
 peng.fan@nxp.com, ye.li@nxp.com, michael@amarulasolutions.com
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

On Wed, Aug 28, 2024 at 10:09=E2=80=AFAM Tomas Paukrt <tomaspaukrt@email.cz=
> wrote:
>
> The PSR register works correctly for GPIO pins in input mode,
> but always returns 0 for GPIO pins in output mode unless the SION
> bit is set.
>
> The DR register should be used for GPIO pins in output mode
> to allow correct getting of previously set output value.
>
> Please note that the Linux gpio-mxc driver and the NXP U-Boot mxc_gpio
> driver already use the DR register for all GPIO pins in output mode:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D442b2494b17d1a4f0a14721580271eb23ebffd42
> https://github.com/nxp-imx/uboot-imx/commit/4afc3f90943c6b117f79b66d2cd04=
e64f437b0c2
>
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>

Applied, thanks.
