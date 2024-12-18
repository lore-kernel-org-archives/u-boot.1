Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4D5E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 14:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A56580269;
	Wed, 18 Dec 2024 15:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KzT/HKXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35679802B4; Wed, 18 Dec 2024 15:50:58 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40DE080314
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 15:50:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so1054343966b.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 06:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734533455; x=1735138255; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3a43kkK9T+m0+K7ruR83dSaxENCMZBi6xOnCEYJS07o=;
 b=KzT/HKXe4h01KE4/wmNmRprxaYCGfQAZGq/u5Hz6Vqdbjz3j3i19L0VfGjcFxDcPiI
 aZ0kwau3zhswwrDltQURRbVZ6nBTaG0mOV5o8vpSlUqwd7LeeJdqu5Q4R5T+poiuSbPV
 BKDFzudteHky1N5BkIauVUqofgWEInQkSUIeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734533455; x=1735138255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3a43kkK9T+m0+K7ruR83dSaxENCMZBi6xOnCEYJS07o=;
 b=ZUoQcOybBU9V2TYiRPpf1xmlV+pm1zNGHSakKyJSjdhd6U8umR773kjl16HzZk98hn
 qxlPMJ0rqai7yFbOw9hUXUlca3gU2WiNUr9UuVsQe3mEMjh37zEgN2B+D/n6wWjSeGzN
 y0dSHM/0XTg44NMGmeZNVJxTT+Hhe2jcaCzsvuRl9YPsP3HgIdhl/15tP+yc+3ApSzzv
 OM5aZRtARd2iIm8/jXdNsUOXW9YBP+f9s4pXT3Sj4nbcvZBjZKtYET/l6n6zp0T3MsYW
 zH8A1ceIU+DpTyumy41Jg7buzgQle27sVvMBjgZWugE3RpGQaCTEuF8K0JtFZ8YWiIa/
 aKbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBh8tur33XlEkjnwosUeezwGgx79eNSs3KifH7JOa2C+SoU+XTQleB4kb5QwpadGkx3bZveMs=@lists.denx.de
X-Gm-Message-State: AOJu0YxWIdx400zv18GHJqbK/p1qvCZXLSCuDlGhkludwu71Rrj/EzHd
 gkZqzjEvTMuWcMmZZU00bfAQuqzMnZ/jTHtiI/zQ7zogAMhCdl0qSQJOMsIiFqTmkE0enBC7aEm
 KDbYYwzr6SAIVBXUZuWuG9vlQ4R//GJCzJnluGdieRDaw+P/PuQ==
X-Gm-Gg: ASbGnctZ0FBIlTrnRKOT2cttOlxxZhJb17SVfESUvNQuZw04osZHKSqKh2LRRESF025
 Hc+3W6hqqpdVPV7I2v+ufJNgr7vB4IvXG4Rpf/p0=
X-Google-Smtp-Source: AGHT+IHyOucJkFUKQb1F701RmfoOhcQatkZdpoyHSe8Q+kue88laubgubnNQqFThwWY231QzSaxlPQaR4hE/VtW+7JU=
X-Received: by 2002:a17:907:9625:b0:aab:da37:95c3 with SMTP id
 a640c23a62f3a-aabf490764amr278838666b.45.1734533454738; Wed, 18 Dec 2024
 06:50:54 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTiU0K2Wc0iOvWnnK21H+JiGbswc1avqrS9BP8wXF1uV9g@mail.gmail.com>
 <CAOMZO5A0m1fmrwu4fp0THHEvi+5N4aizPHD_uPxU_t9ULKbgnQ@mail.gmail.com>
In-Reply-To: <CAOMZO5A0m1fmrwu4fp0THHEvi+5N4aizPHD_uPxU_t9ULKbgnQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 18 Dec 2024 07:50:41 -0700
Message-ID: <CAFLszTjaW2-AWEQo9EXeUGxMAj_O3HGOxFt=tWRaCkDFpcHZTw@mail.gmail.com>
Subject: Re: cm_fx6 booting
To: Fabio Estevam <festevam@gmail.com>
Cc: Nikita Kiryanov <nikita@compulab.co.il>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Fabio,

On Wed, 18 Dec 2024 at 07:22, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Simon,
>
> On Wed, Dec 18, 2024 at 11:14=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > Hi,
> >
> > I have a Compulab Utilite cm_fx6 in my lab but I am not sure how to
> > make it boot.
> >
> > I am using:
> >
> > dd if=3Du-boot-with-spl.imx of=3D/dev/sdt bs=3D1K seek=3D1
> >
> > It does seem to detect an image on the mmc (since it doesn't boot from
> > SPI flash), but SPL and U-Boot output nothing.
> >
> > Does anyone have any ideas? Perhaps this device is a bit old.
>
> Adding Nikita on Cc, who is the board maintainer.
>
> Looking at https://www.mediawiki.compulab.com/w/index.php?title=3DCM-FX6:=
_U-Boot:_Creating_a_bootable_SD_card
>
> "Booting from an SD card
>
> Plug the SD card into the SDIO3(BOOT) SD card socket of the SB-FX6
> Hold the BOOT SELECT (SW5) button while resetting/powering on the
> CM-FX6 evaluation system
> The CM-FX6 will boot from the SD card"
>
> Do you think this helps?

Thanks for the reply.

For whatever reason, it does actually boot from SD if there is an
image on there, otherwise it boots from SPI. It seems to be automatic.
If I remove the SD card, it boots from flash.

I can write a really old image and it boots OK. It is just mainline
which doesn't work.

Regards,
Simon
