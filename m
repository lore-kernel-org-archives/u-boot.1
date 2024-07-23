Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB851C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 19:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2187F88747;
	Tue, 23 Jul 2024 21:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ldjkFI//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2799E887F5; Tue, 23 Jul 2024 21:00:09 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F7C88747
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 21:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ef298ff716so5359521fa.1
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721761204; x=1722366004; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+rPUIt6Kh2DIkqcEBjR0GWrLXEoQpy60eHXQII0X2Y=;
 b=ldjkFI//lHtGKtfaY0+fi/5iVEKGfiqmGbrDpf3BuHBZBM74C/kT8vD6p0vdRWpnDv
 1Z4x7q3Rjh9WM3zXRJskEmUuYezyaew/UyaKaGt4AEAx6iv1wk6kA31xk9lygoDrg+z1
 uchz4HT1QjsJEbkdJwA7LBmLhNYeM9Af0LHsvB07MIWeJRSRbQNX+yvFfH7DnR3ehBDW
 cfC3MNK/WofiOuFl2OUrRYN+XVX/x56Ogk/RBXmKkJHXorC+HC7AZI/6Yl+90RkTmq2h
 /06ouwKdz/quGYlfqjylN9AH8g8OnTs6Zhj1qpy/JD8Sza6SwASPF2mxSCNadDYoqv/6
 gPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721761204; x=1722366004;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+rPUIt6Kh2DIkqcEBjR0GWrLXEoQpy60eHXQII0X2Y=;
 b=rbMtOuK228Lm/YHqvHpwWkiCOMr6UBhbPk9S15K66GSOSMPCA5NccNyQRZf9kUj+tM
 gtV/bo+C38b1SjWogPDuGlgE4q9hsbcUtyLUcC21NSWPXTNjlfXZm+ztDYDjx9zxgaUG
 QSol65o0D0lm9VKSi7rfiUlzCV6RZaMvwVUlrs3rC58K8/jSh8AncSBR8efqV0bHx07c
 GerKlYk8tzjfdfapHjxVQhxvEWsQL7TF1kcK73oOG/6Yi5dNO7fzfhsJlwbEkkRz6+qV
 bVYixS/XhdhS5umck9nwz2E9uVPb5ITR7vAlY0aIIfTaLjYOox5l3OZZISyljhzDhW6O
 ouPg==
X-Gm-Message-State: AOJu0YxpkhjJV9Sa68u0rMltViTd5wvGWo6xd62ZnaQAszVMSGQGgKxt
 od9B+VUrl/oiTwzidUm0M3DYsZ9/mVp3ZIqmVMOz6QzYA6n6RIxmnMDE95iiUDQwqb/+OyKjo9K
 9a+msAAZFSzljtDAA3iFbvJYLSBajGkgO
X-Google-Smtp-Source: AGHT+IEsLrvKQaGR5YxCg5q5/y6K5w8WLWECfQyI22l8gMLpDrN4b/58Zh67ozHZ7Kl0XYfHAMb8At6oKpVuMOkI45o=
X-Received: by 2002:a2e:8192:0:b0:2f0:29e7:4dc2 with SMTP id
 38308e7fff4ca-2f029e74eafmr4718401fa.5.1721761203845; Tue, 23 Jul 2024
 12:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <AM9PR09MB4756F18BD16C09C3AF49205FDBA92@AM9PR09MB4756.eurprd09.prod.outlook.com>
In-Reply-To: <AM9PR09MB4756F18BD16C09C3AF49205FDBA92@AM9PR09MB4756.eurprd09.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 23 Jul 2024 15:59:52 -0300
Message-ID: <CAOMZO5DLfOWtSB6K0k7VyfsBbS17T-uidWeZOhkEVSJTjc65QA@mail.gmail.com>
Subject: Re: How is it possible to flash an image (wic-file) to emmc?
To: "Stahl, Michael" <mstahl@moba.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Michael,

On Tue, Jul 23, 2024 at 10:37=E2=80=AFAM Stahl, Michael <mstahl@moba.de> wr=
ote:
>
> Hi,
> after I swichted to the new uboot (2024.01) I can't flash a wic-file to t=
he emmc anymore.

Not so new :-) 2024.07 is the new one.

> I use a uboot version for imx8 processors but I think the fastboot parts =
are equal. There is a special tool supported from NXP called uuu-tool to fl=
ash files by the fastboot protocol

Which i.MX8 processor do you use exactly?

> With the old uboot (2021.04) I can flash the uboot-image as the wic-image=
 as follows:

Is the old U-Boot based on a NXP release?

> Which fastboot command can I use to flash the raw emmc regardless of whet=
her there are already partitions or not?

The scripts you showed should also work with mainline U-Boot.

Have you added fastboot support to your board in U-Boot 2024.01?

Also, does it enter fastboot mode when booting from USB?

Here are some suggestions:

https://lore.kernel.org/u-boot/CAOMZO5Bb9C+9-gj22LnVLGgQbh259h7iuff5jinD3LE=
DpAnkhQ@mail.gmail.com/

Regards,

Fabio Estevam
