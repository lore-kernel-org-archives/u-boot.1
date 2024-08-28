Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A23EC636EE
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 19:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE44D886E5;
	Wed, 28 Aug 2024 21:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JTFViYYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 414C688744; Wed, 28 Aug 2024 21:40:10 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F280C885C5
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 21:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f3f163e379so110494171fa.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724874007; x=1725478807; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DgYJ0FRW/oGoslcKXJhDCapAGc7ZLwg7PcCDOD3qZ3M=;
 b=JTFViYYSWZWPrg+Ats7iLp+0ZmT8atweo+wZapydXqRUiNJ/BX32oNglh2oRa/Wu1a
 aMLAT0NDoRes6QjyMzOgwaujAKUpoipsu4ZlYNFXTOaCha53O99mrlPYlkFthoKi9vJf
 df3m6VvG+SEnXkOln7Rv8dzDREGM0KpyCqEAuCLNoTeQiw1JDOloeuSiQiDI+dt1WYhZ
 MDUhbOhpuDP9sUaQKwTbGn8m03vse8ffaEdKans4BSKL9inYOIZtUUijrIrGer8xbR46
 D92cU2iYs74tJqZsQPVAq29LpUw8rCH1qLUq7L90z2bhYOnciYUkn8eobUNA5zQfRMBI
 ANxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724874007; x=1725478807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DgYJ0FRW/oGoslcKXJhDCapAGc7ZLwg7PcCDOD3qZ3M=;
 b=OD3mgSZw1aBrcCFZDYFWcUVUmvh1uLlEt7+8iPdv7BCUn12j2bjM0zcZIFINEmYf9I
 FKIRrhT9uGCjgdR3075KmeGnbVfO2a0cwkBZbMFqXMWjjEGWdosNWIYkoTscRVLR3/PZ
 BYtrzzwyRM4I2Xs2nwwNNqLVZPBH2JhHDJdw4+vA14pRYrGVy36A5cN2QjPaqpAnsbkt
 TYWMvqQrMCdi+AAR8pnmmZshO6/yGLghWpl9LyWACrEUToetOI3wGpVG3IfNgIvb72Km
 J/FH/ITS9KCFunErciw9VMZI/BEk6bMaVuMxBmjxIDt+svCvJ4y0Jdrm2OIXJ+6vJkKc
 1i1w==
X-Gm-Message-State: AOJu0YyyXv6rEijnImcLOtXMHhwQZXI65n9J2A8XNGPnhWfLPp9PHsZA
 5V8/J5VQ/GFA94UGj0V4rTtpGF+jFbzzdQCyNGB9C80tmqy9kFdbwVCPC2x1B2ra4rbJdawMYuN
 uy2DYv1//YQa+CNNKo02Ii5A6jO0=
X-Google-Smtp-Source: AGHT+IGLrPXuiRLvfwr5c7+pAw0rXtZV8YUjtb4GdBhOPkwXRQw6mFtqtGu654xehczKaJkwKqMZ4folX+eqLpKwfrI=
X-Received: by 2002:a2e:a546:0:b0:2ef:17ee:62a2 with SMTP id
 38308e7fff4ca-2f6105d8726mr5409961fa.14.1724874006694; Wed, 28 Aug 2024
 12:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <py.Zbyp.4iSBCzZ4lgW.1cpo6S@seznam.cz>
In-Reply-To: <py.Zbyp.4iSBCzZ4lgW.1cpo6S@seznam.cz>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 28 Aug 2024 16:39:55 -0300
Message-ID: <CAOMZO5BeQ5R9Yjj7FbPQNE6cBjutLtZ5KWiK7HRvvVEJGri29A@mail.gmail.com>
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

Hi Tomas,

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

Yes, it makes sense to align the i.MX GPIO behavior with the Linux
driver, thanks:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Tested-by: Fabio Estevam <festevam@gmail.com>
