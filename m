Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B0DC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 14:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8824F82AF6;
	Fri,  6 Jun 2025 16:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CC6INXjo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 907A5800C1; Fri,  6 Jun 2025 16:21:04 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91BD682A9E
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 16:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-54d98aa5981so2700245e87.0
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 07:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749219662; x=1749824462; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3hHzJBek+Y5AAe1R2Vzeq2TVrcp0evPBhqLarJz83a8=;
 b=CC6INXjo5DldfG6KvY3mHyqUIZx7BgG479fFY7HBsP3Fx39+hRBFDCLZgiKHlouRjD
 E3xp3RijOBhVEZFvfiNkUNmH656pOZVpBMB2vgfmb1xfv3JfLVoRH+C6EKZoAuShLk/f
 LhWwjlzc/VlDZugg7DuX82OwOjZpd6wBihzy2036FMlIuyS9XhRjbmlIiEheYi6kxvY9
 t2BJ7FQ/6JXEXsnyvRCXR19WKc6vFOjcOeInY5Y0x4VnJzYNJBIDTDkasdpwEZZ/WxRM
 WsSULnpNTSp7MFjsq7fGVdiVRly1/YIwcueJNl99L6KIlGhLwHg7JQ/me1mEX0wVWdam
 fL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749219662; x=1749824462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3hHzJBek+Y5AAe1R2Vzeq2TVrcp0evPBhqLarJz83a8=;
 b=pmllBjo+UD0Lgx94fljaT9FltYEd3xskCH0iMC6RFXuKQFLxUMR1pY7UiqvNWLKTRM
 C3yR8+N9Vp4OeRObVmIYwohSdnghT41ANrWYopCUQ3KzEVyMXimNxEwmj5Cf13RJKMpQ
 kDV/cDqVvSSj6CQgL3P8CE1bakKefpWEedB1jJUgqrzqvVyPwKewi7YXI8Z213Opn+0f
 aJJHAmh7q7rB+DQcZ891cRzgVJ5d5gOTvj9KkpB54Hs6qC9m0fBZIh3mwsxfc6M5H6mZ
 ycdAB9UsCNOm4sAt3gFtry4FoH9gMHXWxyATejJIC2knSThkZjbjg9an3BdPPyxSsOtT
 lzFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR1hTMVRyNeH0lIPq/LqfwLQ936Wen4ZG7Fv7V14MApDClvqV9FxnLxaz+29EPtrmoxNVCx7I=@lists.denx.de
X-Gm-Message-State: AOJu0YxFGfFrBkeXKeQJzM9eIHk88pxyAH8TqLCJ29JmycXCrwC6U1pt
 oIpgwBu0rmH9X3e7EUtLxGkILkHvsp8IUou2VOfFvSGkYbTU49U7Sfar3Yw4YOskIWrr82SzL+d
 gjT13A985OVtvtL7X9No1iZxfCYrs5yAwdg==
X-Gm-Gg: ASbGncuNwIi935b66tbYeuKrr0L7i3aj9SV3ezCgmanXz+Zi6wJj4RkDjodVvVrR+4i
 TeSVif/YzoxhuTuXMxQHXtHn7O8tvHfRPIz8/nZLncxJ1rwC0NSkk/gSy+BMXUC5hk1FcoIpq2a
 Sq/j/Ou3/CJjUyMBgsa8+P4jqHbwbaM40rqmX0mDegejRaUTWFsYN+WK0j0RisEMwb
X-Google-Smtp-Source: AGHT+IEmU5llVPAqLYYzrx5gS3AaN4ilVhF0ZoTDBxPxL+PONzzJafZcSX32ZLE65akGIayRAZ8J88AhsBLfd9AMBi4=
X-Received: by 2002:ac2:5d2c:0:b0:553:3892:5ec6 with SMTP id
 2adb3069b0e04-55366c30478mr789643e87.35.1749219661678; Fri, 06 Jun 2025
 07:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250606103838.1862928-1-lukma@denx.de>
In-Reply-To: <20250606103838.1862928-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 6 Jun 2025 11:20:50 -0300
X-Gm-Features: AX0GCFspQiALaxtSAdYSuNSTMWK4HuwvaNJj7KoRJFsW5FidL-J6wDr4yb_1e4Y
Message-ID: <CAOMZO5DVh+YqspbbeupVJiE08Uv5rgcE920BQFVrk6ygbB8mng@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: imx: mxs: Add support for imx287 based BTT devices
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
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

On Fri, Jun 6, 2025 at 7:39=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wrot=
e:
>
> The btt[c3] devices are based on imx287 SoC.
>
> U-Boot SPL 2025.04-01081-g07e086681d26 (Apr 16 2025 - 12:24:36 +0200)
> Trying to boot from MMC1
>
> U-Boot 2025.04-01081-g07e086681d26 (Apr 16 2025 - 12:24:36 +0200)
>
> CPU:   Freescale i.MX28 rev1.2 at 454 MHz
> BOOT:  SSP SPI #3, master, 3V3 NOR
> Model: BTT3
> Board: LWE BTT SoM HW rev 0
> DRAM:  256 MiB
> Core:  86 devices, 15 uclasses, devicetree: separate
> MMC:   MXS MMC: 0
> Loading Environment from SPIFlash... SF: Detected is25lp128 with page
>                     size 256 Bytes, erase size 64 KiB, total 16 MiB
> OK
> In:    serial@80074000
> Out:   serial@80074000
> Err:   serial@80074000
> Net:   eth0: ethernet@800f0000
> Hit any key to stop autoboot:  0
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
