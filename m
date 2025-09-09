Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589CECAC583
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 16:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEFEB8313B;
	Tue,  9 Sep 2025 18:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RXj5qK/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CCEB8318E; Tue,  9 Sep 2025 18:08:48 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A118312A
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 18:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3e249a4d605so4670352f8f.3
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 09:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757434126; x=1758038926; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5K4XeWP6jt+Y1J1Ut2ynmm1qja5sTiVRDywpRx314q0=;
 b=RXj5qK/f8NSw1rh8EJ3rJQ3b0X+4x5BHik/p42PRmOh+rNYhfxti8LPVDKkmTq1T+k
 A1fdGwf0cgMsydKzdwj5hZeCnrywc2xTF6eLW68aQsnoc3QweoKyNPAhtk+ZNvysy+23
 17R1pWlukZngIWZyi4dRg9b1Q6QWwGf3KGr8lGccXUT9J3GrZX1wud+re1DLaAMO9Jeh
 SnlwfYKODtWvJJvy4mUK5OZ828i+q4waGXfDQBaxKGrq/nBQSf31VeFZLzdWKpsGkduj
 hrIkl/Mb+hbd4uMpHKM3EKEENmzAcX4/Mz9FPF7Dxu88bNysIDUilDk9qCiOEy6xutU6
 HYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757434126; x=1758038926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5K4XeWP6jt+Y1J1Ut2ynmm1qja5sTiVRDywpRx314q0=;
 b=P+yE6V1DLF4SvHCEjLo3jT90MfpIxwqCOKxxKx6Wt8iE7nChi4eMqLEDkoo5edKHCI
 RTxamP5vsh6tUjs+f8SZkkhoHkk+50mdRIMstlw9kbxZ1eLwe6QoYWXm7IQ0ua+zcRAr
 1nDNFn3qw8E8myQC0goWoP0kL0zOulf5FIMDd8N5kwPCYYYulb887XrO1mr29KQztXRQ
 cVePf19MJPouXcDGMs5LBwL0YP9WanzA/iexeTKWlRG7mlMPc/mqixkB88mwfueQeYxn
 Cx40yBgP0bIeUAlLOTOXB2qBhXMhA8K/lZM4+kWHRle17GuWF9Zo4CZv4fUmwb7ho1hJ
 Aqkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfu5jzpVtVVEuWhyBzLOyr2pBOETCM69Xw0wIwkqvb9VR5d5J7NC2qFIXlGMqcNsVpOIMpyqg=@lists.denx.de
X-Gm-Message-State: AOJu0YznMdzjoa7uxD1ai6Qlt84nYK42Xqa3D90IsKGP0LAKj5GmmZlB
 YehB87dsE639ecazwJtT6AIaKyNp57G6tpFnzY3v57eqTBTE9Fg0crIczbbqyK0I4yv0+6MmXMN
 4wKRZqNq06OI1XZJSidC6UAIP15Mop9Y=
X-Gm-Gg: ASbGncvwQLJryJ72+ml50wHIxJFMtcj8R3HLzMBRf5x8aTXU+oAx5h4KOtMNn7dKRtR
 KLtdURXhSjz1fuFB0zmQaNJBiB+Z/2dOvkvLbeGqG4MYpN7eNfLxG+s29h9QkiKH0Wl6enP1XGT
 bYGpRrWK4nRBxS7ZrFiTmmWm+yM5gFEaOvohoNge/kWXSZv7TpC8QiWrhdXLoHG2WZzb2GF2Nh2
 I0+zW54
X-Google-Smtp-Source: AGHT+IH8q6tf0cOJbuiYpNZOgGLeHsLAefcrQ5d87sE9aHbmSZAYHAoJ80vgpnmF01ZivgQ/dAdc2gZb+p9mfFv2DMI=
X-Received: by 2002:a05:6000:2486:b0:3e2:e079:86cf with SMTP id
 ffacd0b85a97d-3e64bde66d6mr12898644f8f.36.1757434126048; Tue, 09 Sep 2025
 09:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250826093936.3521235-1-lukma@nabladev.com>
 <CAPVz0n3wpLtXB=1ZS4WiihVkDPTza75dXDKMjD63OyeSQwACRQ@mail.gmail.com>
 <20250908144107.10bcb8a1@wsk>
 <CAPVz0n3XoeMmGO7YpVPrej-R2m-vR1T_D1GsEbxJM+iJVGhAfQ@mail.gmail.com>
 <20250909121537.1c2a95b1@wsk>
 <CAPVz0n3M-GQCO=bpD9pMBsaW90xSqYRZZjsFpZp4p7-BF5MrTw@mail.gmail.com>
 <20250909153948.GY124814@bill-the-cat>
 <CAPVz0n1xCXPq6Qhd+EuJxkno=g8p5VXjxw0MaAz3ePumCzU4mg@mail.gmail.com>
 <20250909154710.GZ124814@bill-the-cat>
In-Reply-To: <20250909154710.GZ124814@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 9 Sep 2025 19:08:34 +0300
X-Gm-Features: AS18NWAtLcioiiJx-aZPkvpMYFblw--Csb9rdcdHZ6Rc9UWMj9vmmNbSjtriobI
Message-ID: <CAPVz0n0Yk8GzX7Y3qUET2EK=UWyGwn7FLn5HGfLP7i9ms9ht2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] timer: tegra: Bind watchdog driver when timer node is
 processed
To: Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>, 
 Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de, 
 Stephen Warren <swarren@nvidia.com>
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

=D0=B2=D1=82, 9 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 18:47 Tom R=
ini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
...
> It's a devkit where I'm pretty sure the watchdog exists, so we can
> enable it there and be done. Just because it doesn't use it today
> doesn't mean it can't use it in the future if we enable it, the "use
> watchdog to make sure A/B system configures are stable" is a common use
> case.
>

Alright, fair. Patches seem to be fine, but I would like Thierry to
review them and then I can pick them via tegra device tree. Not sure
if changes into colibri_t30_defconfig are needed, but if Francesco
would like them, then ok.

> --
> Tom
