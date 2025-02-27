Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17035C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 06:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EB7380FE1;
	Thu, 27 Feb 2025 07:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uho4vkbO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11DA580FE2; Thu, 27 Feb 2025 07:01:13 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87657807FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 07:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5dca468c5e4so796427a12.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 22:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740636070; x=1741240870; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VeSummTcHWcFb7CvmeD36N+3pFpoxfeCVB8gE1cUYFg=;
 b=Uho4vkbOM++4L6Eim+UY7SfnZYbOS+tpELZRrfAk/hvdRoBICH/+NZRAVm/yLQaypD
 YGT9X37p1uolVFop6K7IbEMmVV9V+YO27qnZUIctpWTDWXifLZ7fYXOES6d2w8R7ilN7
 mQa4oBZdKI8co6BfgKeXSsSjwsT6YvfFJd6tYMAW3Q3/3twolnepm+FP1JKHf3nx4QeX
 yOwiAnANMwlVIl48Wt7aqxb2l037BKBUyUJoxgQGx2oI4OQNZBfc04KsIjNfs6fDBHH9
 2SZpLKSISzb6lK7HZktzSM1fIT1K2oTEC54UbAlwsDanBQaEDnjzwrirVzwnzjOjP2vq
 LwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740636070; x=1741240870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VeSummTcHWcFb7CvmeD36N+3pFpoxfeCVB8gE1cUYFg=;
 b=qK+C0QzHiCuMoMTe9NgpAzKxkd5D4R6xYYlKSSUx/f9/zCTjYgqs7Tx0AIjrP7N33A
 R8J/K8EwMA861k5vXShTZ3wtCz3PpzlhRtOn4NoGQv3KGsLo4Ol47/aD2CRkRvsEZJkz
 fSiDU85oq/+CZvJ7iV5PTnm2Uds2BJyB6LZAaVw7z6ZCE8Ye96ZVEgsLCkJGG+67bvUd
 8bL3pVkHwZzhoz4hmuy/yvKxMqH5uU4MN4VJO9clpwJkEX96TufhJ2yPJT0chcCFtGze
 x2uyykSmzTpGU6MR24QOj2c4+Cgr2RMNIyqdvlDnjurOCexszmGXycKi1r0SsZlftLUy
 Fu9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpyQ9am5W65a1awMnxjhZuYuAJuvfYZndpdpZGwIbcMXh9vNitexufW7ct4WZ81qAtRDzRJMo=@lists.denx.de
X-Gm-Message-State: AOJu0YwtDvBF4X3/Qji+FSMfj0zxl0k9n2SCksW67aLLn4TSxMScrF1T
 RnbbDGxQNxtn614BFlVPPVEcKicytOHvE4UyRfrFeH5ww3z6qHae89R1JSQHoYvPt+aUCjDfyMp
 50GcVvqiKD40VpvW3hx9Z1N7BXKM=
X-Gm-Gg: ASbGnct0NC47yi8DL9HsHBZV4Y7Bt8YX2pwNyyJcLtuk6Ths28G0NvKceGXmeUTO+uj
 aC+s+TIDso9CzecwjRsYh5Xo0o+47rFajUcY+6/NVbGhkJDuzOUcvVOLlPLEAXsLTrkFMAVmz7y
 w64CX+Jqg=
X-Google-Smtp-Source: AGHT+IG7q/FNfH0dEPYJqI9nN5ImOgoxsktJJeDoBOoO2sItrHCZfenLvVPCq7wJaM0TbTyi3i1IIT4MM2pRFILYdBw=
X-Received: by 2002:a05:6402:2546:b0:5d0:aa2d:6eee with SMTP id
 4fb4d7f45d1cf-5e44a254bd1mr12629292a12.26.1740636069773; Wed, 26 Feb 2025
 22:01:09 -0800 (PST)
MIME-Version: 1.0
References: <20250226184506.64114-1-sebastian.reichel@collabora.com>
In-Reply-To: <20250226184506.64114-1-sebastian.reichel@collabora.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 27 Feb 2025 11:30:52 +0530
X-Gm-Features: AQ5f1JoNaGNTVxgH4qjkOxvtb_rhtuDjYvI_KDFJw0Dh3Z_2hfMPHloQl1H62Ds
Message-ID: <CANAwSgSur2VawHniSEZBD3AO63YnvUGf9m1_8p-XMNxQF+yziQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] USB-PD TCPM improvements
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, 
 Soeren Moch <smoch@web.de>, Tim Harvey <tharvey@gateworks.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Maxim Kiselev <bigunclemax@gmail.com>
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

Hi Sebastian,

On Thu, 27 Feb 2025 at 00:15, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> I have a couple of fixes/improvements for the TCPM code. Three are fixing
> actual problems I noticed on the Rock 5B, which prevented booting up the
> system. One of them simply adds an error print before potentially committing
> hara-kiri by triggering a hard reset, which helps people understanding
> why their boards reset themself in case there are more problems. I've
> recently added the same print to the kernel TCPM code.
>
I have encountered issues with the Raspberry Pi Type C power supply on
a few occasions.
Thanks for these changes, but it dose not resolve the issue completely.

Do you have plans to add a device tree node for this board?

> Changes since PATCHv1:
>  * https://lore.kernel.org/u-boot/20241031175404.114773-5-sebastian.reichel@collabora.com/
>  * rebased to v2025.04-rc3 (no changes needed)
>
I am observing the following logs.

Radxa 65W power supply with a USB-C connector.
--------------------------------------------------------------------
U-Boot 2025.04-rc3-00011-g3ddae9d42a89 (Feb 27 2025 - 09:36:45 +0530)

Model: Radxa ROCK 5B
SoC:   RK3588
DRAM:  8 GiB
fusb302 usb-typec@22: TCPM: data role mismatch, initiating error recovery
fusb302 usb-typec@22: TCPM: Unrecognized ctrl message type 0x0
DDR 9fa84341ce typ 24/09/06-09:51:11,fwver: v1.18

With Raspberry Pi 4 Type C charger
--------------------------------------------------------------------
U-Boot 2025.04-rc3-00011-g3ddae9d42a89 (Feb 27 2025 - 09:36:45 +0530)

Model: Radxa ROCK 5B
SoC:   RK3588
DRAM:  8 GiB
fusb302 usb-typec@22: Initiating hard-reset, which might result in
machine power-loss.
fusb302 usb-typec@22: TCPM: PD transmit data failed: -110
Core:  362 devices, 34 uclasses, devicetree: separate

With Raspberry Pi 5 Type C charger
--------------------------------------------------------------------
U-Boot 2025.04-rc3-00011-g3ddae9d42a89 (Feb 27 2025 - 09:36:45 +0530)

Model: Radxa ROCK 5B
SoC:   RK3588
DRAM:  8 GiB
fusb302 usb-typec@22: Initiating hard-reset, which might result in
machine power-loss.
fusb302 usb-typec@22: TCPM: PD transmit data failed: -110

Is there any issue with the power supply side
since Radxa also lists this issue with some power source

[1] https://wiki.radxa.com/Rock5/5b/power_supply

Thanks
-Anand
