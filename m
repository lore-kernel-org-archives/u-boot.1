Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DDCD116EA
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 21:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC9283759;
	Sat, 29 Nov 2025 22:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DWig7X6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5736F8391B; Sat, 29 Nov 2025 22:24:53 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B659836F0
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 22:24:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5959187c5a9so2573732e87.1
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 13:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764451490; x=1765056290; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Xdpx/Uio57YgFj/02wgI54o24ZvjhL4kF2LOVxEzVI=;
 b=DWig7X6et6JUXD7tGlHAKL+eJp4XrKfTSfIjNxctEPb/xs+5TSIgjdNMaPU1Wq9azQ
 MgHLUr0WZFW2We8G5LcwI2P9eYGv3nFdoewESHFxR27h8RTBiHUmRQjLHtRWfn1YU9tO
 GnvaTHcs3kqtGD9Q9V1coys/3DTKnGdJCX2zqz9hrYA3aPROmOgN57NnaaofPrh66Kv6
 R1VqKvTy34sRMgZDYitVMtP4tEPKzpeIQRQvIcpptdTJAijssddxrjCezpAUdr5WK3YY
 6NARRLbkBrUMqZq7Aze2pqv7fIyf16U3LChCxUsAJ9ndX+T+54+GnBsPZPKbJb6r66fi
 36OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764451490; x=1765056290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Xdpx/Uio57YgFj/02wgI54o24ZvjhL4kF2LOVxEzVI=;
 b=izsdqQ53mPUo4sdQvLyMz2R6MdIZkhXX1i5TUbTzE8VBONqfwLGOnpZG7c2gzcps2C
 uJeTQeb/ZdMVEHfgBwPe9feh0nz809MKRy3z+gz863Bd7dJJdaKEbIvo4NwPk8P+SWx5
 2EFBzzu1eP8odX3QOYGkccbmP8E/8He8ojv2DceAyB/EUyExkPR6Ijj0OLFDp/3nIWcq
 mC/GGDiP0Toi532eVrE14PnpCmVZhBPnsd95VgzC3JRMPz1290K0ztY9U/BxbN7lJHMi
 K0zrgXGfVT6dDQt8rbEIdSaz00fRrELn8R9F2fNR81omf788KpKC0Fp8TULft6A1WfwP
 Cg+g==
X-Gm-Message-State: AOJu0YyFs/SYF++wvt7HX5OhPVJ4zJesJM3SNFDUUQu0bciXUHiGrXjA
 vvOH0DxSAWlOUD+4bGLPTf4zEHkJ2ZE3szbJm6q83e9fEiCx/7ngHNT6pPX5mIDUdyErv412kOD
 YPT8zqTXGWyTFB7g68whzvoHz3rSwMnM=
X-Gm-Gg: ASbGncuu+GyulKQwZSIJzKsFz5NoyShZCcMTM3yClUx6NGbZvsTZLa1ytORTtXRGR5u
 iNnGKrFls5XedmmsApeawuOk/vM1xJjCt+BJd9L2PbyFw4j75rdz28FFX664b7Wze3CzwD0pGOo
 RDVovbxCXG3uxGdPSpPHOv9lCyz7b5LnbZboOgyoDB1xzzLqEoxTCskcadQHWDCILUL0p7mC9XU
 0YV4pX+v0QdHYVsIif+Zg4cSvQtfGteHVMQn+3WMAh7tVdRPLLYEnlb6pNZUs3C1dlA8J56RfKH
 aoamNMsSpX+rVypoCJjvRLKOKeLIUSuR011Tcg==
X-Google-Smtp-Source: AGHT+IE/3zRxEYPesMsECm0UG2NT5XyQWoYezjZEYpInKaB5OImxVl//lGd8tDu8fS9txwjoBBD26TOqdp/KcbtGpLs=
X-Received: by 2002:a05:6512:3341:b0:595:7f2e:ddfa with SMTP id
 2adb3069b0e04-596a3eb5d9fmr11652865e87.3.1764451490374; Sat, 29 Nov 2025
 13:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20251118180344.590898-1-trini@konsulko.com>
In-Reply-To: <20251118180344.590898-1-trini@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 29 Nov 2025 18:24:38 -0300
X-Gm-Features: AWmQ_bm7olBcjgUQRaSDw2wFOYw4d7E2f4OXwMlPHuuMUsXHXvv0iSclh-uLgRM
Message-ID: <CAOMZO5CrLFO5ugB2h1FDDVmJoNSS-s9ysP8LN14oqzsEqGsaYQ@mail.gmail.com>
Subject: Re: [PATCH] opos6uldev: Stop disabling device tree relocation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, 
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
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

On Tue, Nov 18, 2025 at 3:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> If there is some window of memory that must be used for where the device
> tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
> or bootm_mapsize are the correct way do this. Please see
> doc/usage/environment.rst for more details.

Applied this one and the other similar patches to u-boot-imx/next, thanks.
