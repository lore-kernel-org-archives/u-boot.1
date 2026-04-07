Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4064CEDB7CF
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 08:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65BA783A41;
	Tue,  7 Apr 2026 10:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oMC3JJxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0510683F98; Tue,  7 Apr 2026 10:47:57 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 176468352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 10:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-66bd3d05e03so4984832a12.2
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 01:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775551674; cv=none;
 d=google.com; s=arc-20240605;
 b=OTAy4+XsxQuq5EFaXrLCAE9fltW6tH7WlMs/r3J0ixzn1VHTH1isDIYX88/PwZNwrP
 sKhXzWEhtjtuzo1ITlT8JHFeBNKV2bKU/uXE+HVPea2JqQX8yPQSxsf22sbolu6HTD0J
 yr9NgVPD3rU0XtYTPQNYa1+MQh4yWSWt7B7PVgn8ozib/vXBKARdHJAH9vNjDyvZxszh
 CCangYLQ4a46gBn7+ijtfAcr8d34dekZImgj7qhwaZi1+eQoNnvjFAVg1nxRtfXhvBqt
 hkWSI3OnL2XPGZi29DeMgxTlANZ5GhURtKVKo35hndqsV8Hq4hFN8uy/t8oHHBv12aho
 vJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=A+DwOWBWtNZZuO0xuLDj2kI9ua455lHSzmW56wTGOAQ=;
 fh=XohqLLtwbZUF7AfqOPK4AIeJcUUl3GcNFXtTWh5nw7I=;
 b=NJWGnAivdPfSQgcQSYRdZ4OFOyS4VfzdljHoA/2texvwG5PD8ZW/9uzAbV+wEddpWb
 PghRQ5sxktUpCygnxAqUI/MIa7o6nVSUdmrxpYNl8fc1nB9m6zGpX47BMyzoq2zYhrGt
 fM4B2NIOGgKP9G/MXHbHKM3RuH60qM5cw2NGdR/DMqerChUB+wx7Tx0g224zEivf/ILt
 lUNVG1ghW3n3fZMqNFWgQPe+USfM2Lddp+7iMg5lSiDZmDcRrEGAcnH83ZDpr0Zu9Wsq
 hHCqGoz/WQE/S9RJVSzRP7CVAesI2WCOTWNUGf3Je14mOLq7ZzjrMJIj4leQ6BjFVyJd
 uXdA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775551674; x=1776156474; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+DwOWBWtNZZuO0xuLDj2kI9ua455lHSzmW56wTGOAQ=;
 b=oMC3JJxoI5DffCQT3187EEstr966zsS75PEsVm8PzJ5OpOjzwdLqdWXTb9OgnMHizs
 VmJfSDiaHInGT67OhvDCZmwnk0IAQm9cUbfmbW59IZxxFwyXyWDbpTVNgw55JNwqUcvC
 +qVXpxBuvoA6gJFWnYxfC7HCXgiZfO5DfyUxf2pABnl0kXDl1gDbnTNCStDdLlPFTMYw
 N/UsTAuqn0al71H1XWRusEvZ/t+HhHr2qorNDvuyGAKlnYtItZ7J7XhkkhAB8kwgW7t2
 a2XRcXHYnQ8+HpUHSSluwUEJZKVDcFXpPsK8CoRPQH5YRZWx8f3vttnoy2WUg7/SG9mT
 8SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775551674; x=1776156474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A+DwOWBWtNZZuO0xuLDj2kI9ua455lHSzmW56wTGOAQ=;
 b=YLCWjHa/2TaWte6u/3LxHEs5mcmrdC+3B+d8oYc73hl3weAaI7wPSEAKqBB/baeusA
 ihHHC1xY221IcKgddXuoO0Hl4jWWGoyM6DzUh+5k9YDGulued4LkSBeDjOWBKRCf01kF
 k5VwIE2pbn1HDF2IP6mNnwHPIX4lZFuTTTHTOMNsUFB/I43gCRInlPuHud9bZlv/v+Qy
 69eJRIjduLR8cfi1FeLxfKCuJt2o9hpe2UXPj/lSWgRSzeTivtHkrDn30cgvC4Tzlmbf
 aBT7lBBgTAKW6IMHIOfyGi8efqbkgG7mEySG1qK///s+Po+vn527Qmc34X2IfdI9Qd2j
 kLTg==
X-Gm-Message-State: AOJu0YxYlS+OkfxhqtAQ20z/xMt3pMFv5AQDH8Zqs3uXO8f/oxwPyJQO
 KAYQBHgatmk4YbjcnFIxAOYKtgwe3JWShDEmswcBTC9sOt+IpJwBFZMd094sICOmgowy5Mhv7+T
 yKZ5VI9pSBaT4GZakbl8yT299fkdwdgM=
X-Gm-Gg: AeBDieu0By0w+w91BL86Dj5Wf6/4o9R3epa3MxlSpilcp9mpBXlr2XD83hJogWyUOTj
 ijwxMYMOguPByFTFlpviipznyOmVlVGbzE5iUj0gnV8w9yYGDb9Zw2fXZ9iXlQ2AXyav+SwkVmU
 zzIYbDtTp9cEPz/Eo8ALCaGbfa4NgJlAXuXozcirhI+IlmI+pVz7p5RQD3c5fSB4aaumMNMEN9N
 8H81hPB5iu4s/9SU02bMty0gerZ4I1X1xJcWw0nd+NBrzjldEMqLgwm4kEYoUR0mLqTYBPhRpON
 0OTOxDdHgB4LduC0XWKLoXB0Kw87RYSqrP5plpj40bMMBiTJe1Ry4kQynIH7nh8lPSR6NgEwxuh
 NK2YsaOD3D7GaVVZTxH+I8C7ilFwze68BaVyTwpsv78oi5DmH
X-Received: by 2002:a05:6402:847:b0:66d:d1b1:dddc with SMTP id
 4fb4d7f45d1cf-66e3f867db1mr7271945a12.26.1775551674254; Tue, 07 Apr 2026
 01:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMFOmXFjh1rXWb7bacrLHAZahe6tcyEyjYAKv5=SHP=dJf3nA@mail.gmail.com>
In-Reply-To: <CAOMFOmXFjh1rXWb7bacrLHAZahe6tcyEyjYAKv5=SHP=dJf3nA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 7 Apr 2026 09:47:42 +0100
X-Gm-Features: AQROBzCDnql2Oa9jsMFrdAfWECn8k153tJRCUvcDZqcFdlWMTkm0eZfcdXc4SLU
Message-ID: <CALeDE9P3osSPj=SH-OebBw9SVgH6=rxj58te=23Y_z_qFZLaKw@mail.gmail.com>
Subject: Re: Switch ARMv7 Cortex-A processor to ARM mode right before jumping
 to target
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Anatol,

> I=E2=80=99m facing an instruction set mismatch issue on ARMv7. The system=
 uses
> a proprietary U-Boot=E2=80=93based bootloader (based on v2022.07) that ru=
ns in
> ARM mode and then jumps directly to my application. The application
> itself (Zephyr-based) is built in Thumb mode by default, which leads
> to problems when execution is handed off.
>
> Unfortunately, I cannot modify or rebuild the U-Boot binaries, as they
> are closed-source in this case. The only control I have is through the
> U-Boot environment (uboot_env).
>
> Given these constraints, is there any way - via U-Boot environment
> configuration - to switch the processor into Thumb mode right before
> jumping to the application?
>
> If not, are there any recommended workarounds for handling this ARM
> <=3D> Thumb transition when the bootloader itself cannot be modified?
>
> Thanks in advance for your help!

So you're going to need to raise
