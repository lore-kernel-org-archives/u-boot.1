Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72C3C54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 19:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38E2888A2E;
	Tue, 27 Aug 2024 21:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PHkJJFL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1489088A3E; Tue, 27 Aug 2024 21:54:03 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D730688717
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 21:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f43de7ad5eso75973851fa.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724788440; x=1725393240; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmUaoTpK0y5IhpvAhI2yt0Nk9uJky2rzAsZeHNZGTm4=;
 b=PHkJJFL6NJjqv1eGQ6FT6VTKzy7g1GdY084HqnoFipxR0IzMHpoehfDnoHsRYfv8uc
 6FEFK1wsWbB5OcehXyJBaRMna9BJjGRcJCyas1UzX8ICeiLNCYAIZ4WYX7g/ne/QB5hh
 vD3VPxXhn8b4F7pTW+Jmk4DLvbkDCObA4g3zTCEmbzUg+u2m1+0BZLb57z/cNwU+ZVqI
 iL5jUvcizp7fobCP6hnLQlJjj41dwYPJiRLOk1AX9LBs/uAEWWnpPwRP8xd8u7jEuOWl
 L8WWDzWk8PO5DDFgJ8cP9VG2FmotwLfOUuydmlw2kW+sZt5gbotztCosuR3DOrcmTAar
 ZPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724788440; x=1725393240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VmUaoTpK0y5IhpvAhI2yt0Nk9uJky2rzAsZeHNZGTm4=;
 b=riJhMoJCaNhF5szAai4AmI4fUne3lTHBGQ1AkFc5KNhmSw2MT8A0hWfa+0JHR/vQMo
 zko+auvr5i/X1mNt7otBHI9IE/RbkzL+NIfT4Z7/akgw8gW2fXi0s1qeZdCkDjG67WYA
 oW54fkLzL7cucjqC5HGqzF1zwdhxxvIKwP4RkRC4OR2TjFMxU6jfyy3v7X1fG+3TtvOK
 wyHRtBQJ4Zu3AStRDSZGaEpSxe8wQWmxJIpFz/0h4pRmErnqWF/vfI6fGjD39oEgyDo/
 W8kM+/J8IKMq53gPFO1fmS6mNQcCKmWTOyCThATYF1AqbjXYC+8xmlXahnYym9n4v9mX
 4Jwg==
X-Gm-Message-State: AOJu0Yy4aSdjAJMC5f9/H+7gPV+QWWJWr2Kjx5PrfCTHzi9edBYFvEC8
 3zzlQmN3Zbib7Bz71W0Gx+ffma0alNY767HYCVbZln9vaMVKGhvATNzn5ctGrdd3Ilt7Ocs8qlL
 MWZc0gAySvZ5S90MfqggXv4a/3wQ=
X-Google-Smtp-Source: AGHT+IGWydHbCMVEKeBuKIORenSFSloz+apHVG+RLEpV0US1ZhdZYZP54r5CcKOxYMeOga1pCrmAgdmlthQpsDu26o0=
X-Received: by 2002:a2e:7311:0:b0:2ef:2061:8bf5 with SMTP id
 38308e7fff4ca-2f4f4932e4emr87620771fa.40.1724788439627; Tue, 27 Aug 2024
 12:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <GI.Za6b.48b6UC5Rsur.1cpWwh@seznam.cz>
 <CAOMZO5Aj9zSEWF9Gm5-tF9hTaczf6FXv0zo_z+Jws+BGPYPwrg@mail.gmail.com>
 <K9.Za7d.77W3I8GjZaJ.1cpYlf@seznam.cz>
In-Reply-To: <K9.Za7d.77W3I8GjZaJ.1cpYlf@seznam.cz>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 27 Aug 2024 16:53:46 -0300
Message-ID: <CAOMZO5BshEknpJEeEiqip3e_YkN21kAKtKva0ik=8SKGJxmngw@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc_gpio: fix reading state of GPIO pins in output
 mode
To: Tomas Paukrt <tomaspaukrt@email.cz>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Tue, Aug 27, 2024 at 4:41=E2=80=AFPM Tomas Paukrt <tomaspaukrt@email.cz>=
 wrote:

> Hi Fabio,
>
> you are correct that the existing code will work if the SION bit is set, =
but this is not always possible or desirable. For example, if you use the c=
ommand "gpio set" to set the state of a pin that is not configured in DTS t=
hen you will get the error message "Warning: value of pin is still 0". Also=
 the command "gpio status -a" shows wrong states of some output pins withou=
t this patch.

This happens due to an incorrect devicetree description, i.e, the lack
of setting the SION bit.

> Please see the chapters "GPIO data register (GPIOx_DR)" and "GPIO pad sta=
tus register (GPIOx_PSR)" in the document IMX6ULLRM.pdf which show that it =
is possible to use the DR register instead of the PSR register in this case=
.
>
> I also found the exactly same modification in NXP version of U-Boot (http=
s://github.com/nxp-imx/uboot-imx/commit/4afc3f90943c6b117f79b66d2cd04e64f43=
7b0c2) made by an NXP employee.

Adding Ye Li on Cc.

There were many attempts to fix this in both U-Boot and the kernel,
but the recommendation has always been: "Set the SION bit if you need
to read the output state".

Regards,

Fabio Estevam
