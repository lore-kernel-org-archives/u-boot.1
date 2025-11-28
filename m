Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD0DCFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 11:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CCE1844FD;
	Fri, 28 Nov 2025 12:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GG8ObR78";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B962884506; Fri, 28 Nov 2025 12:07:54 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 869DC844F4
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c6d3676455so533168a34.2
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 03:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764328071; x=1764932871; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=flaWoLHwPKpPfi1KAuZq1w/SkCl+5GyQETMwKOSnsfk=;
 b=GG8ObR78p/vabYp1vL0GRPWNfmHFol53orGp0lTk+kMy98XVWde1AkTEreeZKab4IE
 AupGu1g5li0oy7wjolTSBpbGHZEXG2Cm01tVnbiDLPDqkC9lFyLV9ABobDnbqEnTnKXT
 Jz5dQzT2oFvkVtnNcXyF8o7aHtRGyW2SaZTPBb/SUPj/gwzSEgeGJViQ2WZZD/ZMVsqS
 CB7xndmbWLJNysHlccYx0Y39PiWWTI0g9HZQJKjBga0d0jkobbcobtuiVlKrhuOreybs
 c7jZxXTdrEhiWAEZ4AsUDqEoBT92/ZuNqFj+bVqGX21WL4yg5FURxVsp25JU0RGfLVm5
 R9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764328071; x=1764932871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=flaWoLHwPKpPfi1KAuZq1w/SkCl+5GyQETMwKOSnsfk=;
 b=vk5BUcJn1Fyn/dBgkJ6j1W3bX0SU+N8G8EIxpC/JakjPomZWxzoeHAz0tUR3h6X729
 wdXhrBdcjZQSmSMta3xAp5DassqHK8zXRhyv/VUYnYfHw9QwEKe0KGDpzCQAD3edRIGs
 BBPhlYuBbUtUsiR6DYKb93us3tsCXXnt0gz/aK21qZTTIJ76KIBROg+XLtYhV309pw7a
 oSZPI8baYvUJE/g/a+6GIRShzwgjiGYH/VpZLEfl1kMuxVTlM3Qbn/G0230u5XG8JZrW
 6IlqyuyjEjfBE3yxnfJEyYWluhaeCnLaPvMn4mjc0mm/jnU7IewpMa5KtTAPg/PpSTdI
 YjKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVByQ/0+CxHsF2/6VHsWKSx/2M9trw20tWmhgqu3Bdo4l6hg4xzauPotVVhKc1/2HGjsaThhUI=@lists.denx.de
X-Gm-Message-State: AOJu0YzwDDfaDAPid0wxIk+14OueuAe6EqXOZaUitvRu7ddk7AphmPme
 LjocszFovvOFVDSDTUSMAN7YYEg2y0GrS/n4D4LSq8oqaTlsKUh3MmQRL4Bz6frTwPMBC4sIqZG
 K5djzOON1dNspccPrV/L7ZSZCUFc88eebxUUCyvlk+w==
X-Gm-Gg: ASbGncvCaOhZT67RriY+nOK8wHOiS7kZROZBuCc1qnOeuWMzMMPSph8t/AnrXP2Ovm5
 oGgCcPc4b0SMrGdO1NqrVFcwzPBYtXy1oPcCoedyXRhI7eqJMbi5uSi+TtefTDzagCglhA8OvQQ
 Hbid7FGgSATl9NTTSunmi5I8D9pOwFDrXBc6wxSanXRIqyvhKmiwDYyDXFvZWh833p92uRTmsk5
 WCAecvNlvWTT/QH5z6P+N0A+hY8DjWF8DwB+atMlSr0c7SsEGMkVTibEEUw23ChV6Eys3U=
X-Google-Smtp-Source: AGHT+IHJ7vLS/M46mUdN1F8szNA59yEgOX7RTWIRmIrPOp8wep7CddzMdiYfcmNUwkJ8GjwxQRluQ0CzdORGLVz25mc=
X-Received: by 2002:a05:6830:67a1:b0:758:5a29:cba0 with SMTP id
 46e09a7af769-7c7990ae795mr11738105a34.33.1764328071076; Fri, 28 Nov 2025
 03:07:51 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
In-Reply-To: <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 28 Nov 2025 19:07:39 +0800
X-Gm-Features: AWmQ_bkfWVmpJPn-rhn1DBw_UCXIqU1VDwwFe1ikNYOootrWthPt4ALOiMENJyg
Message-ID: <CAN7C2SCx8VyuMZfYbUH1pnqdPykJ-G_S3_ND+wVGHcu+7sBdwQ@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

> Thanks for sharing your findings. However, based on the behavior you
> described, I=E2=80=99m not fully convinced that enabling cyclic/watchdog =
is
> actually fixing the SDRAM calibration issue itself. From the SPL side,
> there is no clear timeout or calibration control path that would
> logically be corrected by turning on the cyclic framework, so the
> improvement may simply be due to timing shifts rather than a real fix.

BTW T.F. I want to point out a very important setup.
By default the Altera trunk had turned on

  =E2=94=82 =E2=94=82       [*] Enable U-Boot watchdog reset
                   =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82       [*] Automatically start watchdog timer
                   =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82       (10000) Watchdog timeout in msec
                   =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82       [ ] Enable Watchdog Timer support for IMX and L=
SCH2 of NXP
                   =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82       [ ] i.MX7ULP watchdog
                   =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82       -*- Designware watchdog timer support
                   =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82       [*] Enable driver model for watchdog timer driv=
ers

So maybe you can also reverse investigate on your side via real board.
Removing all CYCLIC WDT drivers and all dst watchdog "okay" do
not introduce sdram calibration issue?

Lets cross check.

Thanks,
Brian
