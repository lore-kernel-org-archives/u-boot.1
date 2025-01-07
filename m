Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B25EE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 19:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 392A7803DC;
	Tue,  7 Jan 2025 20:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A4nkuLyz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF328805C5; Tue,  7 Jan 2025 20:25:08 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFDD58036B
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 20:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-540201cfedbso1680419e87.3
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 11:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736277904; x=1736882704; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYsAfZyVbSIfkjDnbQDb6svLTlKjHHNsO/SH437xUuw=;
 b=A4nkuLyzx/7rA96a4NeZIUQjb62Q0DfAv1a/WmUJHM4ZN4Z6BifXgrNfyI94GDe05U
 TL1O5cIWC+EEe9O44ZrenVbwDqbkKqGGS4E2LpPaRi4T3dVVNWNBYVTNw9vBbjTNEWJo
 wlVVF+U/3aShMPWcK4kfqooL414WRwO7g2cc8J/OBMKjfsf7h78s4fhfQviNrt4TAkz5
 MMTishJa1h1iybJZ7HmPeIbPdBHT5o3Zs8EfzXae9EFl9TfWSVWh2zi0IXy76tk7gWUj
 aAHao+vUNdk9fvbQj+9qxQAEGkjQqtzzGP44wMXkHyqpT9QlsPdoCMADIT29L7YvSwFY
 QekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736277904; x=1736882704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cYsAfZyVbSIfkjDnbQDb6svLTlKjHHNsO/SH437xUuw=;
 b=hnYvpT++FmH3JIUiWMVAxP9na3mpNTZpKcHkYLCKisShkYhRDAK+y/h91Y4H72chBk
 53Ev2ttEVv6umBwSIMCMupCcYbDyW96EoBCY1GlykVolmgj2FenQ3hQCN08ToWX0mOJl
 ePK7wjJAWuxRJ2psV77/y55hhoKvxMe+7cFniB40YutjuBAzkb4GQNBrIVhGi3jQk7qa
 Fi9/6pUPI3IVwazDF9V6AejFYNRFczytgz9invYLvn6+gXFskFuet/4FB8ZY0AYIB1Uv
 rhAC3T4+3z6P0e6HGLDCNfThqSif4F/y6vOzUthGYk9TJ2OOYbr45TL4YSsUL+vH62kG
 f8bA==
X-Gm-Message-State: AOJu0Yy45jAEVMgiR0Vr61yI9CwpAoX23URs02cB1PppLF1mlzGDFuso
 W69unnhdSQCi+BQHMeY2UayjJ7Dl0cmN74JB2cYuvm1XX/LnSGblu745mbOua5Ev0AyP1h7D/yu
 3Dl3txQeepyDyUJS8NDVk3CpgbsrnJwMA
X-Gm-Gg: ASbGncu058Py+zzce8fU6sEcMy+I7NDlsFRGCoPK8YMbZneD1snlfLfF+gBnc0T9uWn
 EZHv3JtscohYS3mp3j1VJjtODu32gyRKFcs24Xzd7oL9F5zKok8cYQ4d8QGYXpOi1rm7vtA==
X-Google-Smtp-Source: AGHT+IGxNUla1zL7MVjpvGX2dN0pW56S5v90C1SjzGaSu3tth5UvfaWoXvPE80pQHcf7Kkk7nWBDh2TdeLSZsyJHpWo=
X-Received: by 2002:a05:6512:2354:b0:53e:395c:688d with SMTP id
 2adb3069b0e04-542845b9739mr10345e87.43.1736277903836; Tue, 07 Jan 2025
 11:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20250102092305.GA18027@lisa.dawes.za.net>
 <CAOMZO5AAtOP8RvyrKJuh4qY7xk+7bS5K5mWT9RZn5E5xKaacxQ@mail.gmail.com>
 <20250107153051.GA21569@lisa.dawes.za.net>
In-Reply-To: <20250107153051.GA21569@lisa.dawes.za.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 7 Jan 2025 16:24:51 -0300
X-Gm-Features: AbW1kvZJ_aC6t8IqZbzwyXcKIX-hSFzuW9S6G6_owPdhA-qJhwD8kTcsuvpIj7w
Message-ID: <CAOMZO5AN0Gob+HV1CJS_MrVWYxaWM6188ENeSwfcT14qyoTWYQ@mail.gmail.com>
Subject: Re: MUSB compile failure for imx28
To: Rogan Dawes <lists@dawes.za.net>
Cc: u-boot@lists.denx.de
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

On Tue, Jan 7, 2025 at 12:30=E2=80=AFPM Rogan Dawes <lists@dawes.za.net> wr=
ote:

> That would explain it, then! :facepalm:

I tested to access the console via usbacm and it worked on my imx28evk:

--- a/configs/mx28evk_defconfig
+++ b/configs/mx28evk_defconfig
@@ -70,3 +70,5 @@ CONFIG_USB_GADGET_VENDOR_NUM=3D0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=3D0xa4a5
 CONFIG_CI_UDC=3Dy
 CONFIG_USB_GADGET_DOWNLOAD=3Dy
+CONFIG_USB_FUNCTION_ACM=3Dy
+CONFIG_BOOTDELAY=3D100

First, I booted via normal serial console and run:

=3D> setenv stderr usbacm && setenv stdout usbacm && setenv stdin usbacm
&& saveenv

Then booted again, and I saw on the console:

U-Boot 2025.01-dirty (Jan 07 2025 - 16:10:42 -0300)

CPU:   Freescale i.MX28 rev1.2 at 454 MHz
BOOT:  SSP SD/MMC #0, 3V3
DRAM:  128 MiB
Core:  91 devices, 13 uclasses, devicetree: separate
NAND:  2048 MiB
MMC:   MXS MMC: 0
Loading Environment from MMC... Reading from MMC(0)... OK
In:    usbacm
Out:   usbacm
Err:   usbacm

Then, on another PC window:

sudo picocom -b 115200 /dev/ttyACM0

And the console can be seen there.
