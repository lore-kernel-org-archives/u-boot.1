Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C48C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 16:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 901DE88840;
	Tue, 20 Aug 2024 18:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PywwN4kQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C06DF88660; Tue, 20 Aug 2024 18:11:15 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1982888840
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 18:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42ab880b73eso7647375e9.0
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724170270; x=1724775070;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hj9Qh84kTqcHQbVVjQ+8E7RBZdSvo4s9SnMGwbZNy+w=;
 b=PywwN4kQFmpz/iQ1xbMA2kr/Pg6a0U2U7kz//1ZgGDVGmOGXabpltII9pJlYm5IR8+
 q2uJ/vk5xWxq1fKU9pu35UI+7Om2uMbnkmEE4THYkgfTgKwuwRHqUppEOnyvVqK5R3Fy
 2vD4gZGNPafYiHjkBNv2v/Nj4RXz60sWYefs0SLbYq7rKVM399s1gUPJ5XirM+z2UuxT
 bhlcbPn6T4yN9Fcg6rAWqzUdzW6DOaOR/J9B1zm/dy3GxnEhHpME/FrnMvq5KIFEYj0l
 qtjV5er+L8oBCFYRku04CQmyJm8aYjGgUzMY4qg5WF+wItuerm4bGVsscqz6bR86jYkL
 7FLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724170270; x=1724775070;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hj9Qh84kTqcHQbVVjQ+8E7RBZdSvo4s9SnMGwbZNy+w=;
 b=S5b4x/8DuXbQCydYdEtBlZrcoHx+Sq4Gem6+nh4Mp1b7yqBbJO1HfXSdHqfn26D2zu
 akc4bnbZaYSSv4fOt/Y3OYGkL4B3MqXnpaqjiPo0FPe0WvWJSkiTh97wXRWnD1I5oJK1
 xfcbsRiG8AZkRWN1agUy7S3LrzwTmfjxzzCrR22y0oNqICU//g/HDzn41TbDKHjysIIt
 QejlbQ4SlC5YC2lGqh4wvzdlBLtAFaWoxgcvHTZX+QWvI8ybdPSRxO+OH8+EF3j7q5M0
 apOxrwIKO3pN8O0+Yggp5B1r9ytGgqOxEfpAfrhdNnVkJYO/oZe+0Df38SXgShncpvv+
 E8qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6tM7Lfdt+V8fvl7wv+BfEZAcCGyyE6S4afQBz9nCIbwut36eMnPkavNL3iEK3AtjDDZijCKk=@lists.denx.de
X-Gm-Message-State: AOJu0Ywn5z2z4proX8L/mkmZ6QJIi04LqstMjfeMREcJiN55D1jj0qVV
 ju8hyDGXkF+NTRCbj3FtuPZc4DMp83N52MPMYoew5aLlIGaGVG6DJ9sxg3y7h7k=
X-Google-Smtp-Source: AGHT+IEktzanct4I4gbLb3Ls/IESBexrPFhfsrIOHA+apgwYy5WTuaplytvku4AJIbbUlrHy7donVQ==
X-Received: by 2002:a05:600c:4fcc:b0:429:a3e:c785 with SMTP id
 5b1f17b1804b1-429ed7c1cf6mr111683545e9.21.1724170269977; 
 Tue, 20 Aug 2024 09:11:09 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded7d5bfsm204551245e9.46.2024.08.20.09.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 09:11:09 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] usb: gadget: ether: Handle gadget driver registration
 in start and stop
In-Reply-To: <172301272563.244852.18199647448023901472.b4-ty@baylibre.com>
References: <20240726083102.380719-1-admin@hifiphile.com>
 <172301272563.244852.18199647448023901472.b4-ty@baylibre.com>
Date: Tue, 20 Aug 2024 18:11:08 +0200
Message-ID: <87le0ruqcj.fsf@baylibre.com>
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

On mer., ao=C3=BBt 07, 2024 at 08:38, Mattijs Korpershoek <mkorpershoek@bay=
libre.com> wrote:

> Hi,
>
> On Fri, 26 Jul 2024 10:31:00 +0200, Zixun LI wrote:
>> Revert part of 718f1d41 to move
>>  usb_gadget_register_driver()/usb_gadget_unregister_driver()
>> back to usb_eth_start()/usb_eth_stop().
>>=20
>> usb_gadget_register_driver() will initialize the USB controller which
>> enters ready to connect state with pull-up resistor enabled.
>>=20
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u=
-boot-dfu)
>
> [1/1] usb: gadget: ether: Handle gadget driver registration in start and =
stop
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/d94c0e=
e1de89e2fbd3cc5bea6351dbaa9462c84f
>
> --
> Mattijs

There has been some ongoing discussion on IRC about this patch:
https://libera.irclog.whitequark.org/u-boot/2024-08-20

Marek, who has quite some knowledge about the USB stack in U-Boot (more
than myself) suggested that using usb_ether_init() should not be used
anymore.

Instead, to enable usb ethernet, we should manually bind the UDC driver
to the usb_ether gadget.

For example, on Khadas VIM3 board, this can be done with:

=3D> bind /soc/usb@ffe09000/usb@ff400000 usb_ether

Use "dm tree" to find the node path for your UDC.

Then, I can enable Ethernet Gadget with:

=3D> setenv ethact usb_ether

And only when using it, I will see enumerations:

=3D> dhcp

[437548.488938] usb 1-1: New USB device found, idVendor=3D1b8e, idProduct=
=3Dfada, bcdDevice=3D7e.8a
[437548.488950] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D0
[437548.488957] usb 1-1: Product: RNDIS/Ethernet Gadget
[437548.488963] usb 1-1: Manufacturer: U-Boot
[437548.634417] usbcore: registered new interface driver cdc_ether
[437548.640519] rndis_host 1-1:2.0 usb0: register 'rndis_host' at usb-0000:=
00:14.0-1, RNDIS device, de:ad:be:ef:00:00
[437548.640588] usbcore: registered new interface driver rndis_host
[437548.694343] rndis_host 1-1:2.0 enp0s20f0u1c2: renamed from usb0

So, with this method, I can't reproduce the problem that this patch was
initially try to solve.

Could you please try using the bind method instead of the (deprecated)
usb_ether_init() ?

