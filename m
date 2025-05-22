Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3974CC54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 20:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C8083108;
	Thu, 22 May 2025 22:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ikd3FmIQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F4298310F; Thu, 22 May 2025 22:15:46 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A81A830EB
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 22:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-70e0bcd0c75so9068357b3.3
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 13:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747944942; x=1748549742; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUx7i49Xm4eGcUEo7s7Mi8uKNjOdiyErKN1vQZ9SgfQ=;
 b=ikd3FmIQEavzXNfAR8nFwXFchISU+M2n7s/XMVEqek4E6oRdZA4SKhZlctGG/2petN
 9WnpV6Nx1BmkjfSKO3QZwA61PJRg4N781AVmVa32yX1yq7AUhofSh7LsFxOMnLF+pVNO
 Vlbr2JNdqXh9mxlnedc9BQwUF3nb+S3RPWtTclnr2HipDChRh9RU4QRZ82ukwEqyhGz0
 juZ5uRr82g69O0B+G/Mkh09iJdViKvSYb8H9+1JiSS2CVyPgCknTHf1h/9nCAo6rlVkn
 7/G87qPWWAIiwxA+BiiMeV2AS+0pEO3G1G5Qune+lK27olg71oIzGIloQHkf/0dqY8Ju
 8b/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747944942; x=1748549742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUx7i49Xm4eGcUEo7s7Mi8uKNjOdiyErKN1vQZ9SgfQ=;
 b=k91ajwaY10FR4dempBPviznfAKQHCyj6jbv3PkYfhDhJfn/LYwZ5Tk/ZMtquWA0CGs
 oCPaj9sQUABJ4zaKYQmuzTbrbNZTu/rhIe+YeZa2otb4/tNg2MucJyuxaU4dlO6ZmE8o
 tcMf4vmyiRJADP0BXrSUiZqm9TYTuvE2nAx0uDzzo5CQ+qL2xQ5f0S318XujzPaGysJ6
 +rj3OzlPs9k6YPcU/DsQxsjFjWG2rU3OT7mry3VEqqzpiRIrVTnTsCkGWxDdE8jrTFM1
 a4JaaXAPesMimc3KCkk/Ag0QDb5GYYq7AxQ8ysuRp5B92X3sSqPvBSu5zHP44cgoGvJo
 eViQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoh09+Zu8l7Z8QuQgb3YGBjG4uTqUAaWSkk01CXAyQb7FjM9yui1n8ogNCDWutHhLQdLZYV1Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yxp1C0gZgqnXWeblnQ3FU8EW7qvTTk9DK/nl0XjlbHQu6rocGwh
 siBr8CrHyqZuyrxbUuAr433UB2rnsCly+I7EMVAlCwSbbefI7aCxcatU7Psu6xttu6BdW+Dm/MD
 nUo3tDPY4pv3NL5gwlbIPdDzP0NKci3Y=
X-Gm-Gg: ASbGnctV38fewUxQyic6bK8hNYp6P2+eqKn+GKUW3+fCYhSy5ESwqJF2s6sx9n1oCl5
 FOuzYqzdQqcp97Dky0C8xOPE7+Kf7+59eALTZ2v2/gsK1VRnWw61X2VWT0hUy3g3w28eLAZ77IH
 /H+PFV3j5eUgKlPIpvTzMSeF180cV72ov2BA==
X-Google-Smtp-Source: AGHT+IHMif06A4BJ/Xnaaw9VJ6e3E8VvzUAgay21wW7qbjVJugP+WmzuOYFKd8ZkoceKApNp49FgVazL1cnPs+9HtDM=
X-Received: by 2002:a05:690c:4913:b0:70d:fe74:1812 with SMTP id
 00721157ae682-70dfe741d6amr90968037b3.23.1747944942309; Thu, 22 May 2025
 13:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250522141002.1212408-1-Eoin.Dickson@microchip.com>
 <d42bff2b-5257-48cc-9d4c-9f55fc4de1d0@microchip.com>
In-Reply-To: <d42bff2b-5257-48cc-9d4c-9f55fc4de1d0@microchip.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Thu, 22 May 2025 15:15:15 -0500
X-Gm-Features: AX0GCFvrPnAgqc89EDbgUdvXBu6bvM6f6AHPXqSn3sDOAMm-i2bzie80dj1soCw
Message-ID: <CAOCHtYhne5PW+oxF+AoVsAZFw63fMXjUGsHZ88X9d1AMX0SMcw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Add SD card support to the Beagle-V-Fire
To: Conor.Dooley@microchip.com
Cc: Eoin.Dickson@microchip.com, u-boot@lists.denx.de, rick@andestech.com, 
 ycliang@andestech.com, Jamie.Gibbons@microchip.com, 
 Praveen.Kumar@microchip.com, Cyril.Jean@microchip.com, 
 jagan@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, May 22, 2025 at 9:48=E2=80=AFAM <Conor.Dooley@microchip.com> wrote:
>
> On 22/05/2025 15:09, Eoin Dickson wrote:
> > From: Eoin Dickson <eoin.dickson@microchip.com>
> >
> > This series add SD card support for the Beagle-V-Fire. The Beagle-V-Fir=
e uses the
> > Microchip coreqspi xfer function and a gpio chip select, so this series=
 adds gpio
> > support for PolarFire SoC and the xfer function into the Microchip core=
qspi driver.
> >
> > Eoin Dickson (4):
> >    gpio: add PolarFire SoC GPIO and Core GPIO driver
> >    spi: coreqspi: add xfer function for PolarFire SoC
>
> >    configs: beaglev_fire: Enable GPIO and MMC_SPI
> >    riscv: dts: microchip: enable gpio banks in Beagle-V Fire
>
> I think what you need/want gpio wise is already in dts/upstream/
> but the config you're citing here doesn't exist in upstream
> yet, so in v2 either drop the beagle-v specific bits and just
> include the driver stuff or else bring the whole beaglev support
> along. The former might be a better option, since the platform
> support portion probably needs a wee chat with the TI folks
> about whther it goes with the "real" TI beagles or not.

What's easier for you guys? Sticking it under ./board/beagle/ in
u-boot would be the way to go.. The TH1520 Beagle will also eventually
be there..

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
