Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59976D18138
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 18:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D633A88D72;
	Mon, 14 Oct 2024 20:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QUcdo/57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A12B88E35; Mon, 14 Oct 2024 20:13:05 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F6FD88CEA
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 20:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3e5d3f039ccso966430b6e.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728929582; x=1729534382; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+9yEkXX1HnR4/176wu514PmjpQCFXvjVRk5nog78mM=;
 b=QUcdo/57oYdHlbBHvzsAP8nCf2Bznh6C44Bm/YM06tSMbvFRGzWSyY+NMJsQc1/8yp
 VJ2tsI0xadTbmCjquZfLZaZ/vKZ08qSVv55LERhgCNnqFpDm9y+QmNNQiarIa9/+OUnZ
 xsUA6ZOK+eoX8B52MObEP2YbU8L9xL6e0zR9pS1trAvv09jMmqqA7CY+4n2K70veE0nS
 5jFFGGXpD5Q5E9F8Bkz8Om60e2Q94bP8zKNzbW8/T4Rb91eMnYpMfdbEigPbVVpZ6uvb
 V/0hovZTCYnsExWzJlXZZldHM3LrVd3i55XK2UadwI/Qg+k3HE4EZXZ6gWVGF+tErsU4
 c9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728929582; x=1729534382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c+9yEkXX1HnR4/176wu514PmjpQCFXvjVRk5nog78mM=;
 b=Q7iy42anaAyAvrCDEkYdmoVez9QiJQb40cXQCt+LIXRXqfnxF+odQRm03TiuOKIIk9
 YW+SmTXefkJRfX4fcT4qWBrQNlEhNrICbEFR+Kvj2wXQkb4ZYirY9fOArcfXY7TAp3ee
 cAstjg0rybw4jKLSjOGS/bB5UzYc3P8Tt4eCIJ6rYJnUxtCDRUk2ZMlnpANiEvMAERjh
 ephYs5c/QZHHNCkJ7z2t3XLSeT9icPmEU8e9MzJBFs8jwtYn4Jrol80RF9kWvRCws6UH
 9IB3shBqb6X2O+7wvLrr5unYohGMMszSYshAaF6ukDGPYMN7DH1wLnVXXCP8ds2c+VXS
 q43Q==
X-Gm-Message-State: AOJu0YyGFnC1cVfbZVEx1t4PJFpmm2CqFTgkqcllFAjt7u0M0ZpP5CNn
 brQ9Alh4szPr9wYHTjcdyqdt8esp+icubYGnvvUraAHZIY1rqMnf+JWBQWd9FBKqQ+t/2FJOt5E
 zWuT72nFCLElG5Kj0iW9Y7mpiqi8=
X-Google-Smtp-Source: AGHT+IHtt2iC5yFYwT3sFf5Lx9o2Zy5FDDIzKuyj1MFYUnV8ZCA+NcBp5agv4LlYjDpY8jY5KFguGXQbuh+458igzbQ=
X-Received: by 2002:a05:6808:210b:b0:3e0:5596:c998 with SMTP id
 5614622812f47-3e5c90d75bamr8317906b6e.17.1728929582285; Mon, 14 Oct 2024
 11:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241013093244.817790-1-alexthreed@gmail.com>
 <31e0be9e-ba50-4bc6-b07f-d20426b650be@denx.de>
 <CAF4oh-PE7epxtH9FS2PSbcGcd+aVH=7jYhaAUMNKALZNc80x5w@mail.gmail.com>
 <ef7b756e-b72a-4d76-9168-03371235df19@denx.de>
In-Reply-To: <ef7b756e-b72a-4d76-9168-03371235df19@denx.de>
From: Alex ThreeD <alexthreed@gmail.com>
Date: Mon, 14 Oct 2024 21:12:51 +0300
Message-ID: <CAF4oh-MzDpuTgLmXyXSwm-zNFMd6Fx_NZz_bxa6vPL_8QU_0eg@mail.gmail.com>
Subject: Re: [PATCH] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
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

On Mon, Oct 14, 2024 at 1:34=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> > Actually it seems that entropy required to init pool early has decrease=
d in
> > Linux 5.19 from 64 bytes (2 * CHACHA_KEY_SIZE) to 32 bytes
> > (BLAKE2S_HASH_SIZE)
>
> A couple more random numbers would cover all the bases then.

Oops, missed this in v2. Is it vital to add support for 2.5 years old linux=
?
Old devices probably stay with older uboot, and new devices will get new li=
nux
(maybe not that new but not 2.5 years old).
