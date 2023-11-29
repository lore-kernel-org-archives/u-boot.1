Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF898C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 17:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B9CC87691;
	Wed, 29 Nov 2023 18:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lU25IKWR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0095B86EA3; Wed, 29 Nov 2023 17:25:44 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAAFB875EE
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 17:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andy.shevchenko@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-67a22fb8ee0so22251916d6.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 08:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701275140; x=1701879940; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpRi6KZII8sZKLFgLpyHfxQCc9h3esV5KRyi51k5LiI=;
 b=lU25IKWRqKWhqYtnRgqXQby2pQUEdfhr/lhrNaf4J414veogwv11tt/ZUuzqwXLycP
 LF2WuR6H9/z4giLGqirDtdPGAR6mINawMjDqDiCWl2JWTYXcnjp1RV/CW+NILrpSRx1b
 1RRUIU81meB3UE6Og3qy6/eChOLidiZO+v+etMSiGdNCVR8kP44cZHtNa1TVswTB+KeY
 FuBkHet2PQAXCAs9FaWKb1gh33Hz5h6SUC4tgpPSOOJNNBeQ7IBciUc3EV4i73w5tEIR
 t9TRVz6hxSWfgZU6n/m5WOQaS6HYK91a+yzOAF9vEmr9ZghrkJ2vzwLVoj92PiQFc5WF
 0ZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701275140; x=1701879940;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dpRi6KZII8sZKLFgLpyHfxQCc9h3esV5KRyi51k5LiI=;
 b=X4nRLrkAsEtYyOLx5v/s5M1k6INqh/RgpMCTU9aFbZv8vXWox+muVSwYAKuscFGdJh
 /vJDkSyEjabp+IuSyNWTOZ88MyUPhYr9zh24Q2/AzgGPYdDBjs41rEoN7hdvOxcaR8Mb
 IZqwBPX4c//dC77GLex9451vw5Z87rxLa8L6xygEoMIEdEYo5zYC4BoxCYTqsE7u/091
 ciGCwCUqSRqBF/rVbz2cDn9IMdX26hSZ+eZrWC9NOX/LPCD6jefDgHjYKJ/Y0vdC59XI
 pPn7KxG8bzP2/VZBBxNvxvfOiJuTxZ/h2zTxOxhy0JyxBSINdEb3OOFrwQt45tP5cHM6
 A8GA==
X-Gm-Message-State: AOJu0YzhZxaYNmhuJSfNvY1OzGe3h99PVjK6DE5JCmQ9d3r6hU5btS0u
 M1pIJT3+zNG/3Yk7+jvPmt4zSPvl+9nNufKVaXE=
X-Google-Smtp-Source: AGHT+IHYx3F4GI5Ebr8N5rDife+wTQocWHCYhHulOraU6PuAjtkq2cRuRmTA04ewfhr1+yHeiohAexDtv3r1j6dz1Ps=
X-Received: by 2002:a0c:ea50:0:b0:67a:3852:288b with SMTP id
 u16-20020a0cea50000000b0067a3852288bmr11844129qvp.24.1701275140577; Wed, 29
 Nov 2023 08:25:40 -0800 (PST)
MIME-Version: 1.0
References: <CAK9R8u_QmcHLv6KbNm8+8EDvnmgehFZfoPNVCVn8n5P17ArErw@mail.gmail.com>
In-Reply-To: <CAK9R8u_QmcHLv6KbNm8+8EDvnmgehFZfoPNVCVn8n5P17ArErw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 29 Nov 2023 18:25:04 +0200
Message-ID: <CAHp75VeD9pE85aU5MMROJvbPiboOaoeWnLE752=0YXxS9-jnRw@mail.gmail.com>
Subject: Re: Setting up boot chain ACPI on ARM with STM32MPU
To: Ba Gia Bao Phan <phanbagiabao2001@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 29 Nov 2023 18:00:17 +0100
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

On Wed, Nov 29, 2023 at 5:29=E2=80=AFPM Ba Gia Bao Phan
<phanbagiabao2001@gmail.com> wrote:
>
> Hello everyone,
>
> I am a trainee at STMicroelectronics France. I am working on a project "S=
etting up a boot chain ACPI" for STM32MPU, which is based on ARM Cortex-A .=
 The objective of my project is to add a way of booting (with ACPI) besides=
 Device Tree available on STM32MPU.
>
> I found that ACPI was enabled on some x86 platforms

I believe you meant here the niche of the (x86) platforms that are not
ACPI-enabled. By default 99% of the x86 platforms are ACPI enabled
with the exceptions:
- Intel MID (2010-2015, SFI based, enabled in U-Boot)
- Tunnel Creek (2010, DT based)
- A few SpreadTrum SoCs (2017, DT based)

> but I don't know whether it was set up on ARM or not. I found a PATCH tha=
t discussed Enabling ACPI booting on ARM with Raspberry Pi 4 but I don't kn=
ow if it functioned or not. Did anyone here succeed in setting up ACPI on A=
RM by U-boot?
>
> What are the differences between x86 and ARM platforms when enabling ACPI=
? The architecture of my board STM32PMU is ARM so can I apply the technique=
 used on platform x86 for my board?



--=20
With Best Regards,
Andy Shevchenko
