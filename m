Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC09FC8303F
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 09:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A22831D5;
	Thu, 28 Aug 2025 11:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S/Jg9fmk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 053098328F; Thu, 28 Aug 2025 11:17:30 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC655831BB
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 11:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-61cbc8259fbso1084856a12.2
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 02:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756372647; x=1756977447; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bUiZatcGtKWUT+c26T01H1O0IjjfNgbvv7ZC6GRqgZ4=;
 b=S/Jg9fmkISKGcB1NlfE6qEVHamNLWZJxZ9jDkfxfuPeMiWPRXNDcjqKG5EFo2bX6YB
 1cfQYBpfHS9vkeoUekfzycvAskasDX42g+3z3Qc4rVgpg4yY17jrvRN6DzBNI+Vc1OfC
 tux6TtAnapJYh1PcoI9GCN4BGk5tgHfriZWOTdtbJsuUMnWGrlMm8Xf8Ltcy43vBv7kb
 M5U++JILJoM6MNl+5BCZqgayO6t9vick24i5KwxjLw+Z1ntQPi91xlbe4iTpCTSUWU59
 /imk+VSbFUZzG8iBGWI7bEdrU5Gen8V6RNFioX35FvNdQDxJKYMzilRbtWqxZo+NsNR6
 GX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756372647; x=1756977447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bUiZatcGtKWUT+c26T01H1O0IjjfNgbvv7ZC6GRqgZ4=;
 b=XXR+9aXh+3ckP9cL2fXVNot+GwSrRQr2TOIBmHNnKxuf8icURqqlRYfEco1HlgJvsI
 UnP2xZqRQqBPApbJc23XcsqUl4fI0L2r+MldcHVpHeW0UXjDf4AvzItcmd3D2Ymo+RMc
 yx27pBxhykU+fIaZPzZMO1BJDNlBLL6OjZTXbrYfZs/mPhGVx76gU4fp+30h/z7VzoG8
 b0O3HGIhbICaq9AaZ7Y/Tf12dDKraEvBI/6JPx62BnzKpiEACROPp3pcdeg2SJ/txc2L
 X71ExGJ6YpKzrpemFjwtAMSCzrqkYCuEqOpe918p2/6JkSpYGdGP4TFJ1X7RAHRC9uNo
 G2LA==
X-Gm-Message-State: AOJu0YzGIO4aRmPgXNlM8PS4UUheQXoEdHp8rV1Baibd6eyrZFv4YyO6
 tZXkBsw0E8BMwesujA8WQmukKZmFDS1d/o32HHX5j0gAocYtSOur212hnjEQqkgJOpAiraK/s6z
 iGWB5nf5CEj0zxDtKMnbfmswkvGHX4oeYcwhe
X-Gm-Gg: ASbGncum0wGgYnmrLSD8DjAQTpnHWg5ia3tYUB13rnzESuSkPWsRovvNWtA1SfDoL3G
 l210HU2zmL9wCqVvqew55J76k0MMJQcx4rBWknKrYZ59cI5wBxgkTtu5HANhRwgiVILQ0JCC5pm
 V0DXKybSOXUa9+RGu9pGi1JMl27ZkeZFkCNNdpfokrLdXJqTqcz5b3zVqthMtniPxNcPHlJA+FM
 OG2O8/KrMHLei4785N4SVdNyRUlWn0DbUF6lkdSF3liZg==
X-Google-Smtp-Source: AGHT+IGcyzYryUsKg8CGHm0EEbalz0fXrvB8vFjo4RnXpMSoFxv3g5H9XIMo3G94x3yc8M0nw7xRiY9mcRASVx7JwQI=
X-Received: by 2002:a05:6402:5247:b0:61c:9193:a54 with SMTP id
 4fb4d7f45d1cf-61c91931481mr7676196a12.30.1756372647126; Thu, 28 Aug 2025
 02:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <013401dc0165$67e6b5d0$37b42170$@race-technology.com>
In-Reply-To: <013401dc0165$67e6b5d0$37b42170$@race-technology.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 28 Aug 2025 10:17:14 +0100
X-Gm-Features: Ac12FXz7r1fbpIZVSwMh068C_rUg1SJxN0PsWlgoeVH4GIQ80vtIZV_vXNiM01c
Message-ID: <CALeDE9MYrxVVFEMXPzz4BOsLkSGRiv+hRdLFQcDvRZ7uBax1ww@mail.gmail.com>
Subject: Re: RPI CM5 has 130s delay on boot
To: andrew@race-technology.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Andrew,

Sorry for the delayed reply.

> I'm feeling a bit out my depth and hoping someone can help me. We've been
> using uboot on the RPI CM4 with great success, it's been perfect.
>
> We are migrating some projects to the RPI CM5 but have hit a roadblock. The
> boot process regularly (but not always) gets stuck for exactly 130s, as
> shown here:

So I don't have a CM5, only a couple of RPi5s, the early and later
revs, for U-Boot testing/development.



> [ 3.403341] Waiting for root device /dev/mmcblk0p2...
> [ 3.403453] usb 1-1.7: Product: WS170120
> [ 3.403454] usb 1-1.7: Manufacturer: WaveShare
> [ 3.403455] usb 1-1.7: SerialNumber: 220211
> [ 3.429612] input: WaveShare WS170120 Touchscreen as
> /devices/platform/axi/1000480000.usb/usb1/1-1/1-1.7/1-1.7:1.0/0003:0EEF:0005
> .0001/input/input0
> [ 3.443253] hid-generic 0003:0EEF:0005.0001: input,hiddev96,hidraw0: USB HID
> v1.11 Device [WaveShare WS170120] on usb-1000480000.usb-1.7/input0
> [ 134.202779] mmc0: Command Queue Engine enabled, 16 tags
> [ 134.208450] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> [ 134.215432] mmcblk0: mmc0:0001 BJTD4R 29.1 GiB
> [ 134.221178] mmcblk0: p1 p2 p3 p4 < p5 p6 >
> [ 134.226023] mmcblk0: mmc0:0001 BJTD4R 29.1 GiB
> [ 134.230952] mmcblk0boot0: mmc0:0001 BJTD4R 4.00 MiB
>
>
>
> After searching, this appears to be the same issue as reported here:
>
>
>
> https://lore.kernel.org/u-boot/421019670.5226453.1745000686387@mail.yahoo.co
> m/
>
>
>
> but I cannot see any solution. Can anyone assist please?

Is this the eMMC that's built into the SoM or is it external on a
carrier board? Can you provide more details.

On the RPi5 the uSD slot is using the SoC built in controller, I
presume that's the case on the CM5 or whatever you're using as the RP1
needs to be bought up first. We don't currently support the RP1 in
U-Boot so I'm not sure that's coming into play, I suspect purely the
SDHCI controllers.

Unfortunately the details of most of the broadcom chips are closed and
even the RPi U-Boot maintainers don't have access to those so we might
be at a bit of a loss ATM.
