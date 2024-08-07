Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19767C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 06:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A2BC88AAD;
	Wed,  7 Aug 2024 08:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CH382uPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CD8588A82; Wed,  7 Aug 2024 08:35:09 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFD0B88AD6
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 08:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-36bd70f6522so821472f8f.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 23:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723012501; x=1723617301;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GDoIz3YRdH8b6vG8fCOTvGk0ZwN1eQRLNsVlTfTq4CM=;
 b=CH382uPOVC0sapyih7RL6IvKG0tqSVmeGO47b1OjcrhpsBKbLXhyVX2N8BlD5ABsCi
 J0QqNIgnEuns955djqiaCzyKdwJvTRRjKN6gEzFZ7XDnfMUcXfNfAaEQrPWaLIrG/EOw
 EhzL5pyiZuGHfxYf2eFBZCi0NpOffpyDM3uEUSSp4bpUjuU148HR7hH7YchpJaeXLDz1
 OyijKurstPsyO902w2dlQkqs7oCfT7IgQaXlSqAgwvhFC1nYM2ioRBeQddUMouq//S5/
 ALGXyJn4fVo8ONJee5l23tQvW0KG/SDcAxN2PgHrgGEB3Oxaux8sDMzr2kTRrzKeYRje
 zXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723012501; x=1723617301;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GDoIz3YRdH8b6vG8fCOTvGk0ZwN1eQRLNsVlTfTq4CM=;
 b=l3NzF+p4BGh29zYheadgZRIy0s1rDnU7D9j1Y7xVLIyOK7WVwm2/yyq54ophTQ7mdn
 Nr56c2dZcg95ak7v4furOV6Fe0twLG5wHwece8YJSys8J+xpff7DHznQZbuo8aRQGujU
 GnItyYegSmhV8ldLl0f4NZMf7NIeNI7sazLZzecWedd1+EgKcv2oS+FL736sr+P8ta/M
 9NwyELV6DQuxS/IWEs51Kx3jYiokwLomW9FOYTkRdtqhCc4738lviEoPo/POtEkp4DFm
 MXTwdYX1DZ66TSD8uJp7xCrWS9kzPfCdDOBl8pDLGLt0UhFmsrxiatoTI4sEu0E7H012
 Rs+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjSPOuV7tTKMdCUX3ASKkRPhEDeROUeozWRMRAiVGA5wOT9eBjCtxgPoiNbxU+yYRz+xrD4uzG0Gwd0B7ZBpizBFVwww==
X-Gm-Message-State: AOJu0YwqzBNUKVfw/FmVxK/lr0RPd5ghrUZPo20t/ngg0PnWvLh8sH6z
 OCd1zCpHc3lNqVKa0pzTdHLso9KMRZoHq35+738VeHaIncMb2ZuXaUYjSEmc0SE=
X-Google-Smtp-Source: AGHT+IF9Tn1H6t8P7UAcmCj1/kej5qIQuL/gK0wDmO0d1MbpfEihT+BR06yQWZaJR+wFiIi1wxBCKw==
X-Received: by 2002:adf:fa02:0:b0:367:8f81:fa09 with SMTP id
 ffacd0b85a97d-36bbc14a4bamr10398315f8f.47.1723012500312; 
 Tue, 06 Aug 2024 23:35:00 -0700 (PDT)
Received: from localhost ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0c348sm14885086f8f.24.2024.08.06.23.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 23:34:59 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] usb: gadget: ether: Handle gadget driver registration
 in start and stop
In-Reply-To: <CA+GyqeaD26fE9Ks+KP7X+Bok2gF8VE_hgeE2Qfiub8X=REO4EA@mail.gmail.com>
References: <20240726083102.380719-1-admin@hifiphile.com>
 <87y159oio6.fsf@baylibre.com>
 <CA+GyqeaD26fE9Ks+KP7X+Bok2gF8VE_hgeE2Qfiub8X=REO4EA@mail.gmail.com>
Date: Wed, 07 Aug 2024 08:34:35 +0200
Message-ID: <87msloon7o.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Zixun,

On mar., ao=C3=BBt 06, 2024 at 22:28, Zixun LI <admin@hifiphile.com> wrote:

> Hi Mattijs,
>
> On Tue, Aug 6, 2024 at 4:00=E2=80=AFPM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> I'd like to test this on my end as well. Could you please give some
>> details on how this has been tested?
>>
>> A sequence of U-Boot commands would be helpful, for example.
>
> My tests are done on a custom ATMEL SAM9G25 board powered
> by USB Gadget port.
>
> Gadget is enabled in the DT:
> &usb2 {
> status =3D "okay";
> };
>
> usb_ether enabled in board late init:
> int board_late_init(void)
> {
> #ifdef CONFIG_USB_ETHER
> usb_ether_init();
> #endif
> return 0;
> }
>
> Without this patch the host will try to enumerate the USB device once
>  U-Boot is loaded and result in the error I mentioned.

Thank you for the details. I could reproduce the issue on Khadas VIM3
board and I could also test that your patch fixes the issue.

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> With this patch USB is connected only when ethernet command, like dhcp
> is run, then disconnect when it's finished:
> usb 1-1: new high-speed USB device number 91 using xhci_hcd
> usb 1-1: New USB device found, idVendor=3D0000, idProduct=3D0000, bcdDevi=
ce=3D 3.17
> usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
> usb 1-1: Product: Ethernet Gadget
> usb 1-1: Manufacturer: U-Boot
> cdc_ether 1-1:1.0 usb0: register 'cdc_ether' at usb-0000:04:00.3-1,
> CDC Ethernet Device, de:ad:be:ef:00:00
> cdc_ether 1-1:1.0 enp4s0f3u1: renamed from usb0
> gadget0: port 1(enp4s0f3u1) entered blocking state
> gadget0: port 1(enp4s0f3u1) entered disabled state
> cdc_ether 1-1:1.0 enp4s0f3u1: entered allmulticast mode
> cdc_ether 1-1:1.0 enp4s0f3u1: entered promiscuous mode
> gadget0: port 1(enp4s0f3u1) entered blocking state
> gadget0: port 1(enp4s0f3u1) entered forwarding state
> usb 1-1: USB disconnect, device number 91
