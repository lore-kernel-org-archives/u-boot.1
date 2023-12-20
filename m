Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1918C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 11:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA7B871C3;
	Wed, 20 Dec 2023 12:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RSdQfIaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F126A86FCE; Wed, 20 Dec 2023 12:39:55 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C74F9871C3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 12:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d3ae9d1109so6993005ad.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 03:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703072392; x=1703677192; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gyt6AskjU+ZnTOvRIYMGKEGPu3PPQKi+83Fs4GsejiA=;
 b=RSdQfIaF4DixmroS8JPWY1OdBZeVk7qquigpAudTJjzQSOHCG17pejKlYsF5yeXspe
 wnR1v/ysTkrW/alxWoUnKFgidcB+ix2Ri3gjOk2075SCF3cygvahJStgqlv1RkSshLsQ
 H1L5K+dQ/72Fa4xQiatPt6x8h4lHb7UVPRVYOwPfWjZyE1qH8hjeWsmyc/8wASs6AmHM
 YFYcfD3YUop3mQWIBknQP5thtzhzxYbX9HCJ6IrdZ7PKS43bkO3SRkeKhGBAQqUyZ1eG
 YoajWGbaW49Kkf408HQj7qFuLBXFWSZ989k7rFPYo7aCriLki3lFoMvV6htrht4iJCHz
 IKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703072392; x=1703677192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gyt6AskjU+ZnTOvRIYMGKEGPu3PPQKi+83Fs4GsejiA=;
 b=XD+Us8Lpt+Gn3S9C4bpK6lhFWyROH4t9xe7fqS+z+8sTX9ccU7eZxXMjkx/f0nS9dT
 428OycKx5X0OU0Jklj12Z0b6Bz5JMwjNb6eYUTPrR8Ay3DJh8ww87KHc4fkE7HcKmSMo
 gJkmY+u3x/+fM5aPNHfvzd4r0Bsf5RCzQHMivTXYacMPvDAcz3Z/hGGpW+3QrvFGg3Oi
 62iXGCZXZnCPf06BJc64WtY1WmXb7qiyVMkBV+Pw0a8kWKKQC+bhmZQjoOG5KtSIejPp
 Gv/vd6r8P+kJ5VS4J8W/TV26gRz4aMKlmLElvqdc6tKzV9QUeOLXaTEMglu1Z23UYryA
 l+tA==
X-Gm-Message-State: AOJu0YxuNCia7OtFlvMy2a8rH9gt1obIBEGcdghsW8V85XPXGt9No8CN
 WqTsSytk4V4Ng9A1uuhNGxJ2gG7PpOhra4XSmnM=
X-Google-Smtp-Source: AGHT+IGgWioQ7RMigtra1Gm3hl6xKetxjp9EY8hembRHxGpyqTwVXFd5HddJb02d9WeKI+z70N1wRTPnH/lGEKcX1Jw=
X-Received: by 2002:a05:6a21:3814:b0:194:dbd6:9c1e with SMTP id
 yi20-20020a056a21381400b00194dbd69c1emr950102pzb.2.1703072391642; Wed, 20 Dec
 2023 03:39:51 -0800 (PST)
MIME-Version: 1.0
References: <20231220103811.228515-1-andrejs.cainikovs@gmail.com>
 <20231220103811.228515-4-andrejs.cainikovs@gmail.com>
 <CAOMZO5ChYdS=V16TUjh1bevHXoTybRWk+uX4ir9Y9T7zzEvV7g@mail.gmail.com>
 <ZYLQX+WzAlITahTH@francesco-nb.int.toradex.com>
In-Reply-To: <ZYLQX+WzAlITahTH@francesco-nb.int.toradex.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 20 Dec 2023 08:39:38 -0300
Message-ID: <CAOMZO5AxX+RTBwpZ+DE-rT5gtYB=pv-tWesMx3NGcheiCL5ReQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] colibri-imx8x: configure usb hub to bypass mode
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>, u-boot@lists.denx.de, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
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

Hi Francesco,

On Wed, Dec 20, 2023 at 8:30=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:

> Valid point.
>
> In general re-using the DTS for the kernel would not work.
>
> The bypass and reset signals are part of the USB HUB node [1], and we
> would need to add such a driver to U-Boot to be able to properly
> implement it (despite the recent plans to make SPL a full blown
> bootloader and U-Boot proper the operating system and kick out Linux I
> would not go into that direction ;-)
>
> Given that I believe that overriding the Linux DTS to use these 2
> signals are simple GPIO HOG for U-Boot is the correct approach.

Yes, this series can go as-is.

My main concern is why U-Boot still uses the NXP-based
fsl-imx8qxp-mek.dts, fsl-imx8qxp-colibri.dts
variant instead of the mainline versions.

The other i.MX SoCs in U-Boot are better synced with the Linux kernel DTs.

I don't have access to i.MX8QXP/i.MX8QM boards to help on this, but
for better long-term support it would be nice if someone could sync
the U-Boot i.MX8QXP/i.MX8QM DTs with Linux.
