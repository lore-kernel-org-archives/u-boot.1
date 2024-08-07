Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF15C52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 13:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 060C888CF2;
	Wed,  7 Aug 2024 15:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="kVdNcBMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A608188BA5; Wed,  7 Aug 2024 14:36:40 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D49BF88BB5
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 14:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f040733086so20279291fa.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 05:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1723034196; x=1723638996;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VC7dWyizfTPtBdzR62Pr6vpGFRGc1uXX4VOlMd9J9o=;
 b=kVdNcBMBV2/ltySQwDcy9lQNwecV818ZKzRi4M8baGlNRyUcwQr6QgZK9B+dM+vIIF
 WBWgwKnz8Q6r7RHuONEjXTxMfP+/aQUuZ4+6GQaxnFVCC1TwqZllOhx7vGRGm4wBvZKQ
 mlj1McIYdWjia2wKIoc0lZVhm2xXM9PMHwc++qaPQcAulFtrpgKux74YND8Jv26yAqoV
 K+7KHvAbr3ZdERRJ+4RmwJ1R6a73fCRQ5le9Aluvw48aWV3jRqUgPr2H6fQ0Q/bYPZxg
 nviFAVJbOEG2LetJ3+ziFSYdgiWbfeKGL6DXYqaRVIBrkN2+mw50q/a3o5Dn3Opq3r7V
 /GvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723034196; x=1723638996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/VC7dWyizfTPtBdzR62Pr6vpGFRGc1uXX4VOlMd9J9o=;
 b=pFed3oPISO3a4VCtSKOHSJpQmbPaSeMvIK8K7vY6CAUTfW347w44n0ggrimEqJmSks
 7NrpgNwE7Q/PJUJE8khfDTI4GVgRLvWIitcJRuk9tuacGCz471KIqEJCCG+VZHyTrjmN
 JyuR67wjDOG+dESTRZO/ArIdQWBGn6q2K5TXTs8NnWtK5LCKwsyCbg2t1+hqsHc8/YjK
 /cvHZ53Otpq7vStG0q2csMdESbPBEjEl5jo9IbZxM0p59b1ndEPLtsr+j0kIBx961RQe
 H/S4sl4LT7hF9/VaOok6YnqIzb329HGEbnBmzBp7kXGOXJYO2r/kQtzTZBEcDtmZYZpB
 J6sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVchCKGSGk/jS7k0HHpNRuLPoiiufvY1nbvP5IfRSwx3+rloriLxpQKco+jUnKpAahWh09YKNUioWINz+gX3Ppez8Am6A==
X-Gm-Message-State: AOJu0Yx3VQkagdJ81o3MjRMgnqQ+4VqMLyjmXIsevxhRJUuvjV2S9mgk
 t1wQXPxgxqdsUHjs7aM57cn4y0Yr6invSJap7VVqV8k21+i8gxE9iY+j2bpBG+nc6k6RQ9edLrH
 vQ2GDskySDm1ZodWfVWV42l0lGOPkX75IY/WjDg==
X-Google-Smtp-Source: AGHT+IG4aSzu8X4SEFGYpaXDOC8w1TnmwYW7AdXJCJIX253C+3iVXQJoJCvMJhS0HIMb+C6S327YJO1mecyxKsOet98=
X-Received: by 2002:a2e:a9a7:0:b0:2f1:8624:a4c with SMTP id
 38308e7fff4ca-2f186240bdemr67742221fa.47.1723034195818; Wed, 07 Aug 2024
 05:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240802092820.917450-1-admin@hifiphile.com>
 <87frrgolp3.fsf@baylibre.com>
In-Reply-To: <87frrgolp3.fsf@baylibre.com>
From: Zixun LI <admin@hifiphile.com>
Date: Wed, 7 Aug 2024 14:36:24 +0200
Message-ID: <CA+Gyqeai5OZY96HU7uD0X5tbGVHODo1tOE51RYraMYwcoP2SrA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: udc: Fix duplicate uclass name
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 07 Aug 2024 15:44:15 +0200
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

Hi Mattijs,

On Wed, Aug 7, 2024 at 9:07=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
>
> Have you identified boards which use the DT alias that will break
> with this patch?
>
> Maybe we can detail the required fix in the commit message a bit as well?
> Or, if you know of a board that uses "usb" as DT alias sequence number,
> we can submit a fix alongside with this one to document the fix.

I did a search and it affects mostly i.MX devices and Nuvoton npcm845 where
host and device controller use the same alias.

like imx6qdl.dtsi:
aliases {
...
    usb0 =3D &usbotg;
    usb1 =3D &usbh1;
    usb2 =3D &usbh2;
    usb3 =3D &usbh3;
};

nuvoton-npcm845-evb.dts:
aliases {
...
    usb0 =3D &udc0;
    usb1 =3D &ehci1;
    usb2 =3D &ehci2;
};

But I got lost in EHCI's code, like in ehci_register() when ctrl->init =3D=
=3D
USB_INIT_DEVICE the function returns without the actual device init ?
I'm not sure how their gadget mode works and if it's really broken or not.
