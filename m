Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E83FA374B
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 14:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6378883A1E;
	Fri,  2 Jan 2026 15:50:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X6fmsUM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B9BF83A3D; Fri,  2 Jan 2026 15:50:38 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A10839E8
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 15:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-64b560e425eso15937120a12.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 06:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767365436; x=1767970236; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ymt9rrPX9vKEAhA9umBf6vtvY1NJdK/TCHeFx43vgas=;
 b=X6fmsUM+e+3VuIlNJAyG9jLTZYZJfqpTmfd1n9mdT4EDP0IBU564Z6cXkxsco3VDmn
 P+h/IinuEhGg1KEeuFRH2UfGSHRBMuz+/BB97ptZRf7GLlZpSkSApDhUVO5uFEbvXvaL
 l6rmf5nXLKuvw6kGTe47YbiNxM1iCi47o1mib2yGb8vlgQRPAirqW3CBN7iavhU4CEcC
 OMvJR6Vi1NWyyOxJs3vS5g/odQGKpzkk6bMZnlNw6yPbjOSsdayVYUioD1Edlk/uUItz
 sCZQt6oKf2vD17k0rHTzJbeOicKvPyFL+pv177Rqz01BGvVqAqLjCQXgEeJWTRLeWJTX
 YYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767365436; x=1767970236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ymt9rrPX9vKEAhA9umBf6vtvY1NJdK/TCHeFx43vgas=;
 b=gixBLPIJIIBX+IPwcWA7xpYtIM56lF1F6ovX6TPM9p9VyjLLIWJ+sL5sEfkgizWsFf
 te1nNc81t2FfR+VSaz579KP1ipeLZ5DF8slj8QtbPDK6lm4POEK8jS/5JJ7xMNwo/f/x
 UXbl0FoXdCCJ05mTlV9vzMdFNpPXY2qdAB1Qpn/UNLodW5whdBi7iQ7SxKKkw/+OhUdT
 mAm/1oThNS1NTdsD2DvsmLR2LkebqdzVxzjr1Dpkc8QkbYMd7gnkQjl9VzmPlo7ZVmub
 GQ/x9ANzRV8kdLDSj6sr3DoEorzFL70k0AKKdpypyFngb9tt7fhOWnqoKQseLlb4zjGS
 i6ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB0+hJOr9mX8a9bZxCW+V+yhLm9jzzh8nSxZRmXSKxal7nBRORO7F5PdtzZvMXw4XGqbJZcGs=@lists.denx.de
X-Gm-Message-State: AOJu0YwExRDHpLNw4Wabm2YFZlr4Sxt/iB1k+B21e36RmR8x02WL5oaq
 JBjG1XW2Qb6H5PQmSh8dT5HsN+CkSqRdWRKRwBxkoSGR3tt+p+qHTLKRQGcJx4Aj94z4Igt0qYt
 q0OlB72ddmhC+K5MXEMZIbFb2ZfbySMQ=
X-Gm-Gg: AY/fxX4fcACsskN7UrUNHGoqDI0HIVuU+5G5r7TExwgNgZ5yv4gVJ5AKIL1SzRPkfO3
 Sn42L70ySgAHQ4k0ezRXOVd8w+hbT/kAzfewczrLDq0gf2895+m+nTvh9eAxI9QVb8p0ipuDsiE
 0FmCzi4LRx6X/y7C56PAnSoKyKZXorTkXnsnkphZw/W5CrwOLo5WRlcUyLycgGYIj0hJAwN7TND
 xBGUYekKLmeK8KI93gEkjtSEJZZJ4Hz0VT40j7bG31aIEyuH0z1rY4byyPghuCbaaMyukKCflYQ
 E0Vmfj/VmcFoYNkI/YshJestL5jmLfRZwdRzNVvIZNzwLkBB6uER9Fhrgc90IOhXate+V7JFv/Q
 qq2INYj4y+HTgoIBppor0jHuq4cKJgQuKkE8=
X-Google-Smtp-Source: AGHT+IFJbfnOvptIrDMmK8mmySITPGVOsFCUhI2ExcQaUuN/SuZ+2LgrVdunymjhBxfP0vxcvHcRZ/+FiGEZqBSo3G0=
X-Received: by 2002:a05:6402:34cf:b0:64b:5562:c8f7 with SMTP id
 4fb4d7f45d1cf-64b8e944d82mr40094910a12.5.1767365435661; Fri, 02 Jan 2026
 06:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20260102125622.144573-1-heinrich.schuchardt@canonical.com>
 <da40c4d0-8c8a-4341-b779-96f571b7db87@mailbox.org>
 <CALeDE9Oue=0L3PRVs7O8suPVDFBXL_i6o0hc50jLQ49HtaX2nQ@mail.gmail.com>
 <67fefad5-ce05-486b-81f9-f28798195bc1@mailbox.org>
In-Reply-To: <67fefad5-ce05-486b-81f9-f28798195bc1@mailbox.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 2 Jan 2026 14:50:23 +0000
X-Gm-Features: AQt7F2rd6276R1xOEwzMXKAxFiaA3jKPCZfYKYMKYGLEaW_RWTn0oTq-WXxJcgw
Message-ID: <CALeDE9NVNR8pA5G6um7p0CTmuQqmK4LWLoxj--jRKnBWJ5+dhg@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb_kbd: remove match string
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de
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

On Fri, 2 Jan 2026 at 14:36, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 1/2/26 3:22 PM, Peter Robinson wrote:
> > On Fri, 2 Jan 2026 at 13:47, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>
> >> On 1/2/26 1:56 PM, Heinrich Schuchardt wrote:
> >>> USB keyboards are identified via a USB interface descriptor or via USB
> >>> vendor and product IDs but never via the device-tree.
> >>>
> >>> Remove the device-tree match string.
> >> The commit message is wrong, you can actually describe USB devices in
> >> DT, see e.g. Linux:
> >>
> >> arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi:              compatible =
> >> "usb424,2514";
> >>
> >> Documentation/devicetree/bindings/usb/microchip,usb2514.yaml:          -
> >> usb424,2514
> >
> > I think there's nuance there because I think those USB hubs at times
> > can have a GPIO to control power or something like that and hence the
> > compat.
>
> I can imagine laptop keyboard can have the same thing, either for power
> regulator or for backlight under keys.

To date the backlights have been controlled under different
interfaces, at least on the Lenovo laptops, the Pinebooks (the only
laptops we have in U-Boot) don't have fancy interfaces like that and
the power buttons are some times different GPIO buttons.

I think, at least for what we support ATM, this patch should be fine.

> >> However, it seems this particular compatible string is ad-hoc and
> >> unused. I wonder if this might break some users like RPi which supply
> >> external DT and may depend on this support ?
> >
> > I've never seen the USB keyboards described in any of the RPi DTs
>
> OK
