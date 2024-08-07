Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349D1C52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DA9E88BE1;
	Wed,  7 Aug 2024 16:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lXqv/JGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4C9988BFD; Wed,  7 Aug 2024 16:13:53 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B13C88A2A
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedorross@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7a9185e1c0so193513866b.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723040031; x=1723644831; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42fQMPcs7ZSooJTLGFm6sGpLeLkIGtmgVhQkDduRUeg=;
 b=lXqv/JGGQ1wscsefom3Ts3EC2e2ycXtPDdlIIJod2+0aZb+fErgUcNP5MqgUgQRFQm
 s/CUvHFAif7qxKFt33+Gd1YOvK2I6r1P2L48FHs2aF/7XCV5JN3NjA4hFZu7Jr9Egxk8
 eSe7Vk5PKq3YdK0Y4ma+H9jJECfLHLTQtfqYDhDd4fXvWmUw9snLv1cgy7oD2x4wy0go
 DmCBtAIQOkz6MBV2rCqMzdqBH64ezIOdt9BzY1agkzAzri22j4a3BPxmt5mYgeegobYJ
 ou0Vo/pOGuTdnAgYo8OOg8Yhy3VyBJU/jgnPKvimYQw6AFAN0rx6/z5vbJe+V55YLLJH
 lxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723040031; x=1723644831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=42fQMPcs7ZSooJTLGFm6sGpLeLkIGtmgVhQkDduRUeg=;
 b=fHt8Ul+TS4aA0dMnKXzRfzzYQcrG6DfWhqDNYOMevd6egRfXQV0LdW57B9Z0nBzO0C
 iRL0F9z4GLTlhNrq07qV5VnejXIneGRSX8KxmDW5tQSNap2CaqMLZo0eyWvaT+AQ2Sd7
 4bXqqvPRtPksn6v7i7eEBvPpUW/eB8rsVt3GN5mfkD284Xs0+HmoEI2n8fsckaXmQ3bY
 UFWy0ayubhkIJP6ACMUqrf9XpDo5re8w61x2B+jxf4VEX3N3RmLFlOUNgzcXaNKPXqIb
 izyVjY/EHl7+UMwoE0P1ynbv9wLRacVRBo8vcLcylJ4p+229k+Cl7kZbgHiEae2cRQOL
 124A==
X-Gm-Message-State: AOJu0Yw6T/eZH14vPCGSRcXrLYYQyNe+Qhxr8ZH/zAB1uS8riQnlkiDH
 kFRY6RpxXXA/+dqbu0ZY7R3zkqi6mz0JHpnlkp/dRDzHu0UsYeEaL+RAqSdIyrhhVOV4rRc7A9W
 5cZqaPeFkDnxDUv7EO04tVoT4LAI=
X-Google-Smtp-Source: AGHT+IHGY5kXcwak/sUKatM4tV9Tgo/2UNB0z1YAE4mmP1sWugpEMpqk+LQHFOfJQfK6yrKKme747RdZNC6RZoZv8dA=
X-Received: by 2002:a17:906:730f:b0:a6f:501d:c224 with SMTP id
 a640c23a62f3a-a7dc5100bbcmr1435968666b.57.1723040030413; Wed, 07 Aug 2024
 07:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240730152529.143651-1-fedor.ross@ifm.com>
 <20240730152529.143651-3-fedor.ross@ifm.com>
 <ae537f45-a55f-fe39-bb3f-3d0fbf4603b1@denx.de>
In-Reply-To: <ae537f45-a55f-fe39-bb3f-3d0fbf4603b1@denx.de>
From: Fedor Ross <fedorross@gmail.com>
Date: Wed, 7 Aug 2024 16:13:39 +0200
Message-ID: <CAEGWRBD3TMH-LPrXtvnuHheL=Pnzn9PCVs=6hyujDfoWjb7Jvw@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] i2c: imx_lpi2c: Support read transfers longer than
 256 bytes
To: hs@denx.de
Cc: u-boot@lists.denx.de, Fedor Ross <fedor.ross@ifm.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
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

On Wed, Aug 7, 2024 at 12:50=E2=80=AFPM Heiko Schocher <hs@denx.de> wrote:

Hello Heiko,

> On 30.07.24 17:25, fedorross@gmail.com wrote:
> > From: Fedor Ross <fedor.ross@ifm.com>
> >
> > The TXFIFO register of LPI2C only has one byte length, and if the lengt=
h
> > of the data that needs to be read exceeds 256 bytes, it needs to be
> > written to TXFIFO multiple times.
> >
> > Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
> > ---
> > Cc: Heiko Schocher <hs@denx.de>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Marek Vasut <marex@denx.de>
> > ---
> >
> > Changes in v2:
> > - Add additional '---' below SoB line to separate Cc list. This way it
> >    does not get included in the commit message when the patch is applie=
d.
> > - Prefix 'CHUNK_DATA' macro with 'LPI2C_' to namespace it.
> > - Do bit manipulation in writel() function directly and drop the
> >    'val =3D assignment' .
> >
> >   drivers/i2c/imx_lpi2c.c | 71 ++++++++++++++++++++++++++--------------=
-
> >   1 file changed, 46 insertions(+), 25 deletions(-)
>
> Patch breaks world build, see for example
>
> https://dev.azure.com/hs0298/hs/_build/results?buildId=3D114&view=3Dlogs&=
j=3D9261107f-b16b-528d-034d-a5b366785bfc&t=3Daa057498-3634-5fad-2ef8-82ed58=
702aca&l=3D1197
>
> Find the whole pipeline (with other patches too...)
>
> https://dev.azure.com/hs0298/hs/_build/results?buildId=3D114&view=3Dresul=
ts
>
> Could you take a look please?

Done.
Sorry for the inconvenience.

[...]

Best regards,
Fedor
