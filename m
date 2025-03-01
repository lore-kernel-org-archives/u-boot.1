Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F1BC021B8
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 18:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 695C5810F6;
	Sat,  1 Mar 2025 19:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CorKBzFF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D7DA81101; Sat,  1 Mar 2025 19:11:58 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE8CE809A5
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 19:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-abf5358984bso92165466b.3
 for <u-boot@lists.denx.de>; Sat, 01 Mar 2025 10:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740852715; x=1741457515; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aR9vk8Qrc7RXOfo03w9D2/ljxPdI/GQ/sUQDAfmrWDE=;
 b=CorKBzFFCpHpX3fklFveUxcn1J0q7O/hSvh4fLKjkVeXsKovTbIKxjLhVuPNJt6ZA6
 ZhjY3XSwRucE2u2skkKixLGK0AVGLPFfnpbcVlJukoA/9NpPBs/U0OuSwbzp+mpdEM8C
 3JCoQZaBTdpZvzAcRwoKRfZmNrRr7MeZ7aocDr6WAtwhc0Zy1OEiqb/dIhPDwwuiNEts
 tQ1PFvol1PIOMjZdCi8AaRfN7/KiTwcZKZKSvbzOyc210WV2XGAv3/ZXP2L6do//RO+d
 l366ADxPcVXa4sWiwPBELznQrZqEFuWQTlSzuGCA+7SD1843nRnj543hR7juampwNtYb
 Aoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740852715; x=1741457515;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aR9vk8Qrc7RXOfo03w9D2/ljxPdI/GQ/sUQDAfmrWDE=;
 b=k9JOKSKe8TzVST5zxFz/UfpEZ9RwBfqIitI2zXAWz4ie7Cuop41WJ/cleC8mKTntTF
 pJGI+6A1vB+b0/xLPFJpqhoz80rR6uTBzOV1frcBLFJCKt6riRPZMhWzLblOMWckret2
 FBNr42TsH8ueBec66pOA7719VTA8cxYqpXv8QARTG8d/TZdyKWADidhKnCUrefNGVPy9
 FbDVw07aVDlD5/xdW/hkxm3Edjw4fJ74+3G9HC3QF8jHyHOAqxJ1HBnsK8ldMJ0Oyr2v
 H3lIR4xDsla9uzg+rrmgiKuBiuctvYcAAh+4tKTB7tJfuSjthraL6X5tQnVLN2VKqKhg
 XoAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxOjWxxgoyQ7T6qggOPFOLi09gCHq7bxTaIStLFry+g0zyCdAnGheHHqer8FqZ3jgzsXhqq0I=@lists.denx.de
X-Gm-Message-State: AOJu0YwLtI9nEBpzihrGPHkcDgxrJANgvk/h3KoGwlBln/ZILTnWkHTb
 AHPk3y38x5epVX6g1s4Ha58Q8Yz7PPa61AVYddjgxolJxydFcEt66dP/b4SrZ3pet+p70+8tfSB
 EWXI0Gm9Mould2eovCSHwvQuaYR0=
X-Gm-Gg: ASbGnct/sP8hdOCwlHOD2qzjWPgop4nx6wuTTAhQ5goxwbveVrfeLvvdlqC19SB4MWk
 472j8ZM1LV01RhYC7egChZQNQTTc4cY/l3kYGAH2mBtlUYu5GHzkuHPE46haWCBZDcGxxCgbXy3
 wRy8Cp3BNbNikIGxOAa6keAQwrfX0xCtokZrUFnMy8aDHCAqL7iS31QHQQzHI=
X-Google-Smtp-Source: AGHT+IH5bsXF6NGqcX0spZJ8cVRfrhC9CMDe+47IKV9JoN2Y9YWXbsCwDXZUsFidGGSVuPlwKXpr7rrrOH7Hr7W0o8M=
X-Received: by 2002:a17:906:4fd0:b0:abf:4d97:9ec3 with SMTP id
 a640c23a62f3a-abf4d97a54dmr502285266b.13.1740852714918; Sat, 01 Mar 2025
 10:11:54 -0800 (PST)
MIME-Version: 1.0
References: <20250226184506.64114-1-sebastian.reichel@collabora.com>
 <CANAwSgSur2VawHniSEZBD3AO63YnvUGf9m1_8p-XMNxQF+yziQ@mail.gmail.com>
In-Reply-To: <CANAwSgSur2VawHniSEZBD3AO63YnvUGf9m1_8p-XMNxQF+yziQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 1 Mar 2025 18:11:43 +0000
X-Gm-Features: AQ5f1JobR72LhN6uYVlkDxtU3J2aOc8vH0PR2QkE3ShCQ2BUmdVPhxmPRDZUilU
Message-ID: <CALeDE9Nq_xbOc3W8hefPQuVBi_Xc_2r18cw6+jeEHeGKyHEa-g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] USB-PD TCPM improvements
To: Anand Moon <linux.amoon@gmail.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>,
 Tim Harvey <tharvey@gateworks.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Maxim Kiselev <bigunclemax@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, 27 Feb 2025 at 06:01, Anand Moon <linux.amoon@gmail.com> wrote:

> Hi Sebastian,
>
> On Thu, 27 Feb 2025 at 00:15, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> >
> > Hi,
> >
> > I have a couple of fixes/improvements for the TCPM code. Three are fixing
> > actual problems I noticed on the Rock 5B, which prevented booting up the
> > system. One of them simply adds an error print before potentially
> committing
> > hara-kiri by triggering a hard reset, which helps people understanding
> > why their boards reset themself in case there are more problems. I've
> > recently added the same print to the kernel TCPM code.
> >
> I have encountered issues with the Raspberry Pi Type C power supply on
> a few occasions.
> Thanks for these changes, but it dose not resolve the issue completely.
>

I don't believe the RPi Type-C power supply supports power delivery.


> Do you have plans to add a device tree node for this board?
>

For which board?


> > Changes since PATCHv1:
> >  *
> https://lore.kernel.org/u-boot/20241031175404.114773-5-sebastian.reichel@collabora.com/
> >  * rebased to v2025.04-rc3 (no changes needed)
> >
> I am observing the following logs.
>
> Radxa 65W power supply with a USB-C connector.
> --------------------------------------------------------------------
> U-Boot 2025.04-rc3-00011-g3ddae9d42a89 (Feb 27 2025 - 09:36:45 +0530)
>
> Model: Radxa ROCK 5B
> SoC:   RK3588
> DRAM:  8 GiB
> fusb302 usb-typec@22: TCPM: data role mismatch, initiating error recovery
> fusb302 usb-typec@22: TCPM: Unrecognized ctrl message type 0x0
> DDR 9fa84341ce typ 24/09/06-09:51:11,fwver: v1.18
>
> With Raspberry Pi 4 Type C charger
> --------------------------------------------------------------------
> U-Boot 2025.04-rc3-00011-g3ddae9d42a89 (Feb 27 2025 - 09:36:45 +0530)
>
> Model: Radxa ROCK 5B
> SoC:   RK3588
> DRAM:  8 GiB
> fusb302 usb-typec@22: Initiating hard-reset, which might result in
> machine power-loss.
> fusb302 usb-typec@22: TCPM: PD transmit data failed: -110
> Core:  362 devices, 34 uclasses, devicetree: separate
>
> With Raspberry Pi 5 Type C charger
> --------------------------------------------------------------------
> U-Boot 2025.04-rc3-00011-g3ddae9d42a89 (Feb 27 2025 - 09:36:45 +0530)
>
> Model: Radxa ROCK 5B
> SoC:   RK3588
> DRAM:  8 GiB
> fusb302 usb-typec@22: Initiating hard-reset, which might result in
> machine power-loss.
> fusb302 usb-typec@22: TCPM: PD transmit data failed: -110
>
> Is there any issue with the power supply side
> since Radxa also lists this issue with some power source
>
> [1] https://wiki.radxa.com/Rock5/5b/power_supply
>
> Thanks
> -Anand
>
