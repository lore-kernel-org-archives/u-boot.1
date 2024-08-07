Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71D4C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 07:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B9E58873C;
	Wed,  7 Aug 2024 09:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Iw1Dlwj8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB8F886DBD; Wed,  7 Aug 2024 09:13:13 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDBA58873C
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 09:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-368526b1333so313469f8f.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 00:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723014790; x=1723619590;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g8N9UscKhrJ2kN5yBn+bH3OJCReJC6iBvTIJXuVDpic=;
 b=Iw1Dlwj8bkjA+BfFIpUkhzqZskmPp92mTCAD0Xxq84CsZ6hizb2RVwUjf1ETma53Z/
 l58AtaOHSsZ1eMnUN5Vh6wR33eOqCm5NwQDiQ5kUcVXPPX6xpOTLL/B8KEAKYv0tookQ
 MVbyzOOQSzzjB8z6kjwhzqGio/uksjPU6mRsm6MVeBlkOhgsGhc3xA0AhMVywsiUe+Pa
 HUFFeGYGlJBMfTE46Qg2uLyDj/DUxR1ivtLRKu82agmOjxF0ltutjEdodCexDdY9ULrl
 kLEXieRNXOe4EylT0ewXzubjmqZ+eArzK+/nX2s3DC0YUpQWbamRZid6UowoqFQB23S7
 Q9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723014790; x=1723619590;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8N9UscKhrJ2kN5yBn+bH3OJCReJC6iBvTIJXuVDpic=;
 b=Q/naMoz9JK/CZRh00fJJprkRq8/9eQeWWJKCk3bS1k+rOmGJLZgwD3s280MPkec7zC
 0i3NgVrT6ge8smHnfaOS4OR9TfYCx9E6JV/X0kHKzO5oo2EzpN3fj7n2CbBQxvRDJV2i
 80JY2E5W/w3wJBjohFqdCxdMNFLtlSz4w1QhBfMBaxSCA8MGN3oT9NVaZKgHJNAKUw2s
 bPPH3PIjR5TDhigYud0Oeg1SVHmRJQtz74tyIVDRbAqqmRRrj+mkB4rhBQEtLZNz5XtH
 qAruA7Hg3W5i/1gfaJjpPZggcBnIm3sKtakqUfeCgvL/ZWfqDHCc83qQ9TroVI+7Ttmi
 TGTA==
X-Gm-Message-State: AOJu0YyyQL3yC1Ly5K5PLZHzMFket9xdoG4ofEJtMhaSFPBPWZE/CDAm
 XsDkWqga8gcXvHnfp+0VmHPmfa6+eDGUYU6YmURqrox0CwLHL5RcI75AOz8JNNu4fiJFbYMs2ZP
 k
X-Google-Smtp-Source: AGHT+IEAsxyJuhlQk9uuACJeFaYmmEoOKmLFL3d8wOZcYHvU+KYjK+4n7R4Gr6LhnLhHKzNxqMPzgA==
X-Received: by 2002:a05:6000:18a7:b0:366:595c:ca0c with SMTP id
 ffacd0b85a97d-36bf0eea477mr808697f8f.24.1723014789261; 
 Wed, 07 Aug 2024 00:13:09 -0700 (PDT)
Received: from localhost ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0598a7sm14949157f8f.67.2024.08.07.00.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 00:13:08 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>, Jonas Karlman
 <jonas@kwiboo.se>, Lukasz Majewski <lukma@denx.de>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH] usb: gadget: usbhs: Add Renesas USBHS device driver
In-Reply-To: <172301332974.246690.13564435454732613935.b4-ty@baylibre.com>
References: <20240620005608.211147-1-marek.vasut+renesas@mailbox.org>
 <172301332974.246690.13564435454732613935.b4-ty@baylibre.com>
Date: Wed, 07 Aug 2024 09:13:03 +0200
Message-ID: <87cymkolfk.fsf@baylibre.com>
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

Hi Marek,

On mer., ao=C3=BBt 07, 2024 at 08:48, Mattijs Korpershoek <mkorpershoek@bay=
libre.com> wrote:

> Hi,
>
> On Thu, 20 Jun 2024 02:55:15 +0200, Marek Vasut wrote:
>> Add UDC driver for Renesas USBHS controller found in R-Car Gen3 SoCs.
>> This is mostly ported from the Linux kernel, with additional porting
>> glue. The code has been synchronized with 1b4861e32e46 ("Linux 6.9.3")
>> and cleaned up and ported to DM since the original implementation by
>> Vitaliy.
>>=20
>>=20
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u=
-boot-dfu-next)
>
> [1/1] usb: gadget: usbhs: Add Renesas USBHS device driver
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/b61ed3=
c87f977bde4ed47ce1161cebf7fb814765

This patch fails CI check "check for new CONFIG symbols outside
Kconfig", see:
https://source.denx.de/u-boot/custodians/u-boot-dfu/-/jobs/882942

Could you have a look when possible, please ?

>
> --
> Mattijs
