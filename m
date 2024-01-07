Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5B7C47074
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 18:35:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC78879AC;
	Sun,  7 Jan 2024 19:35:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MGyemCKn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 477FB87A06; Sun,  7 Jan 2024 19:35:32 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDA2E87640
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 19:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33678156e27so1239142f8f.1
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 10:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704652529; x=1705257329; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khatjvfxdu6BR/Y39r6RfBntKMwBgaEZNA3KIDSO8hQ=;
 b=MGyemCKnqqusNLh2qVFi0qAFFbnVu+YebCfNQXO0YQKNQfJzVkztn/dceoQ5W4YA+X
 23pFUYU9IKN7xPaAVuOfh+q/BphNIIIc6+uNBvfx/NeczrdZf4w9/HbF5FqUYRA+5gPs
 N9QF12vJX/l1pXE7AE/NpqrpEgB2ijFNh34XMCY4fRywvMoIUy+c2DHoNV5UHjhMFekE
 fq+rhf+/BAcrKXBHSfepGuxcSbHBbg0tJQAQMZIyYUmz0euyNgjfoPEyeMv5Jh+19FQ7
 qsjNQSOO+vsKznpLaij3kKGhuFyN9TpepUYx0tW+fgwLV9FAp9P8lccP/rxgizl2sWFo
 0DUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704652529; x=1705257329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khatjvfxdu6BR/Y39r6RfBntKMwBgaEZNA3KIDSO8hQ=;
 b=H/ut3inbVrTNbkA4LB8BS8FwdQ6JqDbCLGjEB5kGg8tnRk3tOUD7qrJYMrOc4dq3qb
 CypBmLZOq0BKJ5xemTEfG1FkJDLKYJnz3pBdZ3TY5OO+N4r6FItva0ow+H83nKyEaePd
 LXzCjT8Jlm41gOlzNz+ENwl7iV3EyqaR8bxvIxWndF86+HOjL9itDoGzE3Fl2ZNOcnjB
 jo2h/HAYrA0b8FEH1zKu/V9q0tllzIIE8CB2SAOTIPZxncQ16x0/HJx2DI59GmrBifoQ
 4XQWjyCjYOO3M1KaznSOadsj6+Xvqw4fLklh27a5bz+SlnbrAkzHwbeTocBnDAIFYUqi
 oGiw==
X-Gm-Message-State: AOJu0YwVFzrrNWho8W5d6p9iJ6dYF8h0JUx2366lXW8/f/NfVlr3AMcA
 bFB5XN3IDSQSPMkIovAzQVJwq5+x1F1yFCcZquA=
X-Google-Smtp-Source: AGHT+IEjyfMXknVqwDj39PkUjjWtxt/drtFNww7MMdNrL3oNI/shpC1Wkfp+oGwr78aa1M+rHnj1GMI3+3QxkMRHv3c=
X-Received: by 2002:adf:f6c3:0:b0:336:8485:d870 with SMTP id
 y3-20020adff6c3000000b003368485d870mr1210388wrp.65.1704652528822; Sun, 07 Jan
 2024 10:35:28 -0800 (PST)
MIME-Version: 1.0
References: <20240105160359.634310-1-caleb.connolly@linaro.org>
In-Reply-To: <20240105160359.634310-1-caleb.connolly@linaro.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 7 Jan 2024 20:35:17 +0200
Message-ID: <CAPVz0n2Z1s12A+EjbLNG95RUSU6new+=OhcXZOr8zNmWGs2AgQ@mail.gmail.com>
Subject: Re: [PATCH] boot: add support for button commands
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
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

=D0=BF=D1=82, 5 =D1=81=D1=96=D1=87. 2024=E2=80=AF=D1=80. =D0=BE 18:03 Caleb=
 Connolly <caleb.connolly@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> With the relatively new button API in U-Boot, it's now much easier to
> model the common usecase of mapping arbitrary actions to different
> buttons during boot - for example entering fastboot mode, setting some
> additional kernel cmdline arguments, or booting with a custom recovery
> ramdisk, to name a few.
>
> Historically, this functionality has been implemented in board code,
> making it fixed for a given U-Boot binary and requiring the code be
> duplicated and modified for every board.
>
> Implement a generic abstraction to run an arbitrary command during boot
> when a specific button is pressed. The button -> command mapping is
> configured via environment variables with the following format:
>
>   button_cmd_N_name=3D<button label>
>   button_cmd_N=3D<command to run>
>
> Where N is the mapping number starting from 0. For example:
>
>   button_cmd_0_name=3Dvol_down
>   button_cmd_0=3Dfastboot usb 0
>
> This will cause the device to enter fastboot mode if volume down is held
> during boot.
>
> After we enter the cli loop the button commands are no longer valid,
> this allows the buttons to additionally be used for navigating a boot
> menu.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  boot/Kconfig              | 14 +++++++
>  common/Makefile           |  1 +
>  common/button_cmd.c       | 83 +++++++++++++++++++++++++++++++++++++++
>  common/main.c             |  3 ++
>  doc/usage/environment.rst |  4 ++
>  include/button.h          |  9 +++++
>  6 files changed, 114 insertions(+)
>  create mode 100644 common/button_cmd.c
>
I wonder how I lived without this patch! I hope to see it in the mainline A=
SAP.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegra30
