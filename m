Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FFFC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 08:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3D0188739;
	Tue, 13 Aug 2024 10:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ra+biX7X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC169886E5; Tue, 13 Aug 2024 10:20:21 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4700188739
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 10:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-530e2548dfdso5397556e87.1
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 01:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723537218; x=1724142018;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RufgXti6jW2+Xwu8RyDcjxQp7qE5Ug/ZP5fX5RbYvOY=;
 b=ra+biX7X6sco5PUG8PYzzMbaWLwNUTalM6r0RFt45QiF+IiDOMWXfEF7xEpbRK3qpI
 hz1Nci6yiDFqWz3pexVc/Tfi4ECyrc5q6PAMndqcw42yi7eMW3ztTRZs6afHs7GXAT9f
 SZo4PSM8Gc1Xsz+OdYXYXTlgKGZu1ykLssG7PMCmVzYQtkClNpZmjikSMJaleylNkfBN
 9SUeIXfn+QrClX9XUMsrx/of9RGBSkWwf2ZVwcJ2gXCffnQkEYcS1LDXJJ5M0quQ28a8
 LZvE2zMw0juvgyK7a1we6pwqY5sZ4zUduYHff/x5pFKYnRMGfyMAh71REJC5sJpo58RW
 GYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723537218; x=1724142018;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RufgXti6jW2+Xwu8RyDcjxQp7qE5Ug/ZP5fX5RbYvOY=;
 b=LKTLlqJEd7d1yIUwNHj0VF0bdnyKlYXL24Hkb6G4/ZylJxs/s06znh3hH0314vRcHD
 tuEMgNWQ51q84Bb89+FWldjuUq1aZKukkqQSXdk10jr5zehArzTPhlLOBI1Jo9YAofXE
 1xNPvHTUAGqVbQCu9pNWD+LTe0YNKV1S8MJfTuaWsfJutqwaHGofzRqCCwOEyuwhRmpF
 KP3ybMFB5wTgNyU4T8xK4tz3Z7URTPi6LOe5VJYFITXVNq10vWOHRpoSQsCg6/m+LyAz
 xy9BoU73F9IK/+o6a2QomQyT8wfPGYT/vxdNzyRmtbVAM8O3aKByBU1Z2ARR69PmIsDl
 DLHg==
X-Gm-Message-State: AOJu0YwW3t4TK+TvXY1Wcv2UxgZ+z//WVC9E//hBfz9szVNNKW88Afke
 qx3BmxPJdRaxSX6naIOFLb9pKlMvkDbOfsBdVxONgzQBMSg0MMTYHPPFy0YVSnyU8ms4UdQzQM6
 NUgk=
X-Google-Smtp-Source: AGHT+IFqb59cXFVGBJwKR46z4wy+5r0dUNEWAjFJlNRt+3TY0AgRb1c22zWYdBHjcLB3syji+u3ReA==
X-Received: by 2002:a05:6512:3d88:b0:52e:fefe:49c9 with SMTP id
 2adb3069b0e04-53213667e91mr1923491e87.36.1723537217408; 
 Tue, 13 Aug 2024 01:20:17 -0700 (PDT)
Received: from localhost (lfbn-tou-1-402-59.w86-206.abo.wanadoo.fr.
 [86.206.229.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290c7bf87fsm216833285e9.48.2024.08.13.01.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 01:20:16 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>, Jonas Karlman
 <jonas@kwiboo.se>, Lukasz Majewski <lukma@denx.de>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH] usb: gadget: usbhs: Add Renesas USBHS device driver
In-Reply-To: <87cymkolfk.fsf@baylibre.com>
References: <20240620005608.211147-1-marek.vasut+renesas@mailbox.org>
 <172301332974.246690.13564435454732613935.b4-ty@baylibre.com>
 <87cymkolfk.fsf@baylibre.com>
Date: Tue, 13 Aug 2024 10:20:14 +0200
Message-ID: <87jzgksukh.fsf@baylibre.com>
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

Hello,

On mer., ao=C3=BBt 07, 2024 at 09:13, Mattijs Korpershoek <mkorpershoek@bay=
libre.com> wrote:

> Hi Marek,
>
> On mer., ao=C3=BBt 07, 2024 at 08:48, Mattijs Korpershoek <mkorpershoek@b=
aylibre.com> wrote:
>
>> Hi,
>>
>> On Thu, 20 Jun 2024 02:55:15 +0200, Marek Vasut wrote:
>>> Add UDC driver for Renesas USBHS controller found in R-Car Gen3 SoCs.
>>> This is mostly ported from the Linux kernel, with additional porting
>>> glue. The code has been synchronized with 1b4861e32e46 ("Linux 6.9.3")
>>> and cleaned up and ported to DM since the original implementation by
>>> Vitaliy.
>>>=20
>>>=20
>>> [...]
>>
>> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (=
u-boot-dfu-next)
>>
>> [1/1] usb: gadget: usbhs: Add Renesas USBHS device driver
>>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/b61ed=
3c87f977bde4ed47ce1161cebf7fb814765
>
> This patch fails CI check "check for new CONFIG symbols outside
> Kconfig", see:
> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/jobs/882942
>
> Could you have a look when possible, please ?

I've heard from Marek that this should not be applied yet. I have
dropped this patch from u-boot-dfu-next to unblock the reported CI
issues.

Thanks
Mattijs

>
>>
>> --
>> Mattijs
