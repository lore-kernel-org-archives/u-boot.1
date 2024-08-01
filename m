Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9922DC52D54
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24BB488AE4;
	Thu,  1 Aug 2024 16:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W/4L5cfm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9348A889FC; Thu,  1 Aug 2024 16:32:04 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B72288667
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 16:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52ef9714673so1170122e87.0
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 07:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722522718; x=1723127518; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1p8WenxLJcTw5OpyvDSx4yjC5bLeNKXJVFsNnjU8BA=;
 b=W/4L5cfmYUj0T9vjXS6CNrRUSw7kjP1/C+JdfrP1o6Vie0n2RinXPUZqV5ywsBNLjm
 ohvS3qZz4Pd9+gADNDf5qZrrq+hKq2DSc5Dc6bvQglH9dV8iJEVO/HasUSeIgBZkvzKR
 4ONrZ3iYacZ3H7aVucEjFI3MhL02+v987buZntukGxkmTunlexrhqwodOPxDDWS2Ho/m
 s3/YBFY8gxdgA61NAs0z0Hw85byK4LP+vOZY9H+SBeKoXSPgIXh6xE/zOwe7niR9XAlB
 eFNmtGbNZBHuE3RHSymi/Rkz0rJ6qvsj1MgIps8F/1quX0FUhabmJz0kKeZHfx1TX5Q8
 Bmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722522718; x=1723127518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1p8WenxLJcTw5OpyvDSx4yjC5bLeNKXJVFsNnjU8BA=;
 b=vjc+iWxT8C1t+eknI9YkRzpdKwrlhFbHrpxJLT0WcA9Wav6h5VySBPC2ZVNVfp02Dv
 awFXalFa6zd1m6AYxKCkFQ1hfW/3VJuRruFA3NfdI6UoL2AvMvvIo1uhl9Q3DiPufAl1
 kxDwQfK6Wg8Q1na68dDzJ+KYlzOr5DY9gPfBo6UvU+iVPnuuqif4XMq8hHQG5Y6krTiV
 LXgpajZFeTi5b1PzeoCvspfVcI9mYAG6zi9dcBei4jYrazHu7HAuSm4u9TTgndZds7yp
 kkf4pcqpsfLYhU+TaMSO5IW/el4lz0lKdJ4g/dVSlKTGAfS0gz1JY/UBl4npGjDo7Kec
 mw4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwZ00y+amWI1lC/j2ebRPpyrUKJv9aX31SJUybrMSSSYDNbXI+JbnsE6Sm37qYeaNDsqbWmebSlxsXtBMfx6Lk75tPsQ==
X-Gm-Message-State: AOJu0YxX/6LP2YefzrEpoL+5OtB33PjyW635D1yU/jR/3RNSnpsEVDRr
 /UyZ5n8HTJqKp+83wzwbK147AXdI3usPAqgz2ZkuFBg4BYsL/HDiISnmMSYjydD8fkBs0+b2WyO
 1lbmQ7v4oKZtlNcb8Ltz7z/nzAhg=
X-Google-Smtp-Source: AGHT+IFtB8DUbF406RyQ2npOphjAYtLMCDQeB1zUOgKqyPhiP1Tdd5HKLvT1tCK8DudE3uy5Cr89veKOCp5L2kLh5h4=
X-Received: by 2002:a05:6512:3a93:b0:52f:10b:666c with SMTP id
 2adb3069b0e04-530bb396b78mr21764e87.5.1722522717242; Thu, 01 Aug 2024
 07:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240801125416.1582652-1-lukma@denx.de>
 <20240801125416.1582652-2-lukma@denx.de>
In-Reply-To: <20240801125416.1582652-2-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 1 Aug 2024 11:31:45 -0300
Message-ID: <CAOMZO5CqQtUOt1zgL7x8goSaH=HeFwQkg3-CJtY=ynyHgg7=bA@mail.gmail.com>
Subject: Re: [PATCH 2/2] config: Adjust Phytec imx8mm module config to support
 NVME disk
To: Lukasz Majewski <lukma@denx.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Cem Tenruh <c.tenruh@phytec.de>, 
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>
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

Hi Lukasz,

On Thu, Aug 1, 2024 at 9:54=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wrot=
e:

> +CONFIG_CYCLIC_MAX_CPU_TIME_US=3D1000

Please explain why this option was added.
