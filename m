Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBBDE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 14:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC78480241;
	Wed, 18 Dec 2024 15:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H+1LSPWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B5198022B; Wed, 18 Dec 2024 15:22:38 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1AF1802EF
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 15:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-3011c7b39c7so71649661fa.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 06:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734531755; x=1735136555; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ksaFMkerj5x2N7vzckh5MQgJQM+71MYbMy0hNvQTyM=;
 b=H+1LSPWwnDv+ooJw1NkP9eH273jqX4IN6F0cAhH1IsxsZK52Qqo6OpLHJ7a0FR4Y4r
 iVpgRODtxk5FvdVfn+wLydkyoA3z/WMqDl9vq2WYiY+fz38pXbKEqpuLngFKVyy/PphV
 L+K5MK/K4K6xUqYAxWaXzRkj9TSPG97kFt1BYqckQ2WM6D+qkardeeyLaIDnag67X2p2
 7IO4uQ8MYffvyKaImqiONeoT5PU2YRKk2yVrW6S94f+ORO7grm3jnGYqiaaviJwZupgt
 u0qlyi3vN+xw8uvZ69H57QROC6UlBHelCI2SpXdTdtrx9Mc6EONfj9JS3dbsMQvliK11
 P6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734531755; x=1735136555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ksaFMkerj5x2N7vzckh5MQgJQM+71MYbMy0hNvQTyM=;
 b=OeN3h+uMu5rZUMIuBGnevUypCICCEvi53f09wxdfQn022fbFtFqiVrFLyTAmHROP2C
 9Ep/s/2WkOsDFhr1Etq2nXOvLg3+rWiHo1YqXA5P5Y8Y8SX3sB67+DomYkO6PrIgt7Zc
 kJNAkw2pinTuuIHKjbgB+f3URJuXappvG8JuDzGisF6UtB6wfv9HW6JUxy9XZUT7FQVG
 VGD/O0yRt5TMllIn0/B0QDSDH1cDquUCbtGbGBXQ2wDvs8UVk1wbF3b0D6Qrz7zDqVyA
 q8gpsK3nTOIrEAO/m2nc6cVqGD+ORMUsbd0yeaB5CLl1yKmK49lZhiSo0+pnm8R8Gbe2
 97ew==
X-Gm-Message-State: AOJu0Ywu6vDbqdL8PYGJ1aFQOvA/cCc32fg7GTsUmhfSdRFiDDCwGhi4
 kmdOCqyeZg3/ZZ9MtYTjLIPBLRe/TvDijt7j0M3MQc2/Hwt90EOF1FgNdMxvHXn6+r2wBtp3CNp
 1RC5bO/S5MXJVzU4b6YIKH0So35M=
X-Gm-Gg: ASbGncvIB3OM+wzdUCeQW7Ovth2Smi7V0bY7NEiTZPs+6ilz+urUUGrhuMvUBVApUcM
 GHMhCBOSFt/xbbGI9vpIXJhNStTvMeUjmSIccLmgTCR+ABg/2MVntMLF4Y6s0x94NOdMbuA==
X-Google-Smtp-Source: AGHT+IErQzsQuS2NXrE2numzOIr1zwKNPl/RIzXTctCN3lZsW+/0wpHobbYhfWmsMdkjDcnufDLQw4154YEzKy+1nqo=
X-Received: by 2002:a05:6512:3193:b0:540:2292:50b2 with SMTP id
 2adb3069b0e04-541ed902ef5mr1196332e87.52.1734531754783; Wed, 18 Dec 2024
 06:22:34 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTiU0K2Wc0iOvWnnK21H+JiGbswc1avqrS9BP8wXF1uV9g@mail.gmail.com>
In-Reply-To: <CAFLszTiU0K2Wc0iOvWnnK21H+JiGbswc1avqrS9BP8wXF1uV9g@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 18 Dec 2024 11:22:23 -0300
Message-ID: <CAOMZO5A0m1fmrwu4fp0THHEvi+5N4aizPHD_uPxU_t9ULKbgnQ@mail.gmail.com>
Subject: Re: cm_fx6 booting
To: Simon Glass <sjg@chromium.org>, Nikita Kiryanov <nikita@compulab.co.il>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon,

On Wed, Dec 18, 2024 at 11:14=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi,
>
> I have a Compulab Utilite cm_fx6 in my lab but I am not sure how to
> make it boot.
>
> I am using:
>
> dd if=3Du-boot-with-spl.imx of=3D/dev/sdt bs=3D1K seek=3D1
>
> It does seem to detect an image on the mmc (since it doesn't boot from
> SPI flash), but SPL and U-Boot output nothing.
>
> Does anyone have any ideas? Perhaps this device is a bit old.

Adding Nikita on Cc, who is the board maintainer.

Looking at https://www.mediawiki.compulab.com/w/index.php?title=3DCM-FX6:_U=
-Boot:_Creating_a_bootable_SD_card

"Booting from an SD card

Plug the SD card into the SDIO3(BOOT) SD card socket of the SB-FX6
Hold the BOOT SELECT (SW5) button while resetting/powering on the
CM-FX6 evaluation system
The CM-FX6 will boot from the SD card"

Do you think this helps?
