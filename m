Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E94C531DF
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 16:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1B0288B84;
	Thu, 22 Aug 2024 18:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="PVanWI7g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C1FD88B7F; Thu, 22 Aug 2024 17:54:13 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F93988714
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 17:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f3edb2d908so10066731fa.2
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1724342050; x=1724946850;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dty1tj4/6abfqXRndSpLBSuu1oIZoJcy3xAJh0C/fQ=;
 b=PVanWI7gbpJv1kpFeAEVf2oJvZ65klXjlyy87BU8dm+P/1G8lNVIzm80rch+fQe7cJ
 5idEG2m7miWcQbRBFS0g/0bEDNi1WDrcd7N37SiuRBeXKXyUOeAEPj0jzpVVzjNZAHB1
 tcK2KSPVoUuQastGzZLQMpsXBPCB4oeDfsXEfkgGjhAvPJRxIeJ0bDb6WbnmjxRGyyED
 ymcJuiwuxuM1bqjXttVoegJwFveYHV/hLc6sLmveWI5Nh7Tro+iYhKaxFvDf9ZHy0uT7
 sxJHRw7DxpvByJVG38BLHalGpzs6iogbyiyR/XvN8w2uovhrrFAUufvYyW1hg00ekIvB
 upeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724342050; x=1724946850;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3dty1tj4/6abfqXRndSpLBSuu1oIZoJcy3xAJh0C/fQ=;
 b=X8z3RGR3DK57nuDiFIyE+7CP+HlzvXZMlkyJZNHelZ/h+jrpDt1tepkMpv047Pv8lB
 vheVOM5QnKPj71LOVU9MQP5yVHdbIk/eyvosFNPg0amVOVwLpFDezF9AYkJpS06EXt3j
 GAc9JubduN2o8pIuzLicokqHFEptp28hk5eN8ZU/qBlURcMRjEt8iR2SwYkuY8kZT0WC
 oJDWxxk2MMlUsVP0P3HQFLN6Puc9fcKrD5U49sQR6eSlGm8Qh0ccFt8jfC5Ke5rYXkSM
 vkyCUmUxQO85U+HBmNuS004T7vogOiZdfwgPUAob1oDPfAxbIGaKBO4h54cTdOb5Z1tt
 jrcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeyj8zu2oYItkdVuTEW03053SkishxzcCWTZMYrgD7kzSfAT9jSRex5RLU3KOH9rVReWiFLXk=@lists.denx.de
X-Gm-Message-State: AOJu0YxPiZNGikomvpD5vNUbPuXUgMyTOO2jWm3NOJfHrlohNuVvJkeb
 98XPFOb+VZtdOmU+Xurz7hspsWWrI1WAtQGX0+NLT8PZ3cDZiZkIQHAD0y9XLWZKt7TmJC5sCJX
 cKwgUt/+/QbuQuQJ/UKeGywPzeEGolqsRND98/A==
X-Google-Smtp-Source: AGHT+IFpcNAq4UIQ0VwIepcBA7sidM3X6XCe68eeHqUMpAusKHWT5YQ/+tgvqwR1YMuvcpSJS4xWQU0mEQ+LrsWM3YM=
X-Received: by 2002:a2e:be9e:0:b0:2ef:2016:262e with SMTP id
 38308e7fff4ca-2f3f8721e0fmr54057161fa.0.1724342050334; Thu, 22 Aug 2024
 08:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240821212218.2092540-1-admin@hifiphile.com>
 <5a1367d7-be94-4c75-9f40-891ca79f9c5b@denx.de>
 <CA+GyqeYxig+5pyYaCjPmQodXGjCYK=819cNZx9XmvJOnoYne_w@mail.gmail.com>
 <67e8423d-f8a8-412e-ae4a-014d52bf6a2f@denx.de>
 <CA+Gyqea1r6rP8gXfS6nOtOaKZ=sJ1+z_KguGzzJygQKmSNRakw@mail.gmail.com>
 <c7c61399-8b64-471f-bfcb-71afd387317b@denx.de>
In-Reply-To: <c7c61399-8b64-471f-bfcb-71afd387317b@denx.de>
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 22 Aug 2024 17:53:58 +0200
Message-ID: <CA+GyqebS7gVMpLJuMdxN9c8U=CpBLiTuFkqm_4-bA+LstLJpsQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: gadget: ether: Disable USB pullup in eth probe
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 22 Aug 2024 18:09:39 +0200
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

On Thu, Aug 22, 2024 at 5:24=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Can you change the g_dnl_register() prototype and pass he structure in ?
> I suspect it should be available in the commands which register g_dnl ?
>

There are many places where g_dnl_register() is called, like fastboot, dfu,=
 ums,
etc, need to modify all of them ?

>
> This is no good, this is a workaround, let's not do this.
>

You mean which part, order change or disconnect call ?

Is there a fixed order of udc_start (device init) and driver->bind ?
In non-DM mode most device drivers do init first in their
usb_gadget_register_driver(), except udc-core and DWC2 who does
driver->bind first.

Call usb_gadget_disconnect here could avoid modifying all device driver's i=
nit.
