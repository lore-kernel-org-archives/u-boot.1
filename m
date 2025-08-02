Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1ABEC87FD2
	for <u-boot@archiver.kernel.org>; Sat,  2 Aug 2025 05:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B93C83B6C;
	Sat,  2 Aug 2025 07:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="auwnfdex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1163883B86; Sat,  2 Aug 2025 07:09:16 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB39A83B5F
 for <u-boot@lists.denx.de>; Sat,  2 Aug 2025 07:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-458aee6e86aso8409335e9.3
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 22:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754111353; x=1754716153; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMUr+UII6ds2mW+tD8ivcGa2e7Qx5myGVxEopOa0LHc=;
 b=auwnfdexSnyL82ACV8tIPl5JDOOWmgkm0dImurDOPTLrwxtIinxokCew5aqi2Zcjnb
 f3oVbRuI1rYVlMnQw7nvwHrhPjKnccQhxXTwOUfmEpWJ4zSNjlZwTKnEkfZD2OeXMJcF
 4udbh96VKdzUzbCQuuzensgRFr2Wm1CCZXGHdPTreqHpaaTzhG6xe9SloqnI/7/urbzS
 ZQl5T1vihRtIXCZn47+xn014bhtFZK8OYS8JLLO/177hTI664ax72I7atMcvbyM+fAZm
 rVg6jPsGjASTYTc9G+fwCW62lKQxtJlz7GyX7CF3pUqhVozAeZB+xJnpATWOBGGoU+dG
 +Zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754111353; x=1754716153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zMUr+UII6ds2mW+tD8ivcGa2e7Qx5myGVxEopOa0LHc=;
 b=tZOSoSBoqCx2YrJZ9UsKQlvWN/gPZ6t9zVULMmRZ59rpcnbYIto4Kc/B58gHoyzeny
 MUPL5mZnjbQt3b7Zxelg/m80l1yPn9WDQzC4rBtjpEreb0yoF9tUMzfcRODzqaXBHl6b
 0e5E9yx4NssZ7ad4oX9nPypFuB7I4C/YMsJkZrR1SufZYDlwiIcaGvATFShPRp9R30k8
 PTvlHUHbepwRBkOuauh9sIMktUESSz4I45y53jzyYu//1+quJmFX80hapVgrGGpy6LVA
 9zh2AyPH2SetHiI6XRrrB7DnXDkfpLpEM6fES7ASVl1ENZilrR5sdPcvG5iXjqOaaW4q
 hf5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1iiEG0Om6gEx/UmI23wMxb8gzDEvYWdCS3ANrkyd9+Qg0y0IkEjaiFbYTXjx2rZeadU7ojTw=@lists.denx.de
X-Gm-Message-State: AOJu0YwFQoWhnJLL/W60FPb2GU12n0tYWj/tH3g13ymK972kPvPhQ5/t
 0qokpmCgSr1k9495ylfd2QF4p9RdLxrFdrBSBcSrnfqeEjwg+UbbCdayLsdXQRk913w48THn7ri
 0FqXfiI1ZDX9/YzILOniwaHMjLKYS64w=
X-Gm-Gg: ASbGncsbVqjgmVUmjXr6bSMLalmWoNJqCzTIlCMbxPY3WGmhGXRfW2wx59icIEHYg9A
 mLDw6UdU+PPq696VhQ/cOZespW1ySmJUWYNoKdzjH2mnC/9Z5AsRBsBE0XtdlWTJe/H2MZxg42M
 T4bo5Elm8B6LTSU2inu0fA0rsG/CLOAKj0VGYNpcPJJXpLCD5wCvAsPSekfZ50lHCucrp5asved
 ZkKbgj9
X-Google-Smtp-Source: AGHT+IHqqtva6N4Nokjc2CIf+R7AfMvdMHYOAhdg07MSdjQwTKgTRNBcfK+lxVPmAoiPai8wO7kYi2rshj7ysxTzwyQ=
X-Received: by 2002:a05:600c:1d0c:b0:456:1bae:5470 with SMTP id
 5b1f17b1804b1-458b69dddedmr11663705e9.8.1754111352938; Fri, 01 Aug 2025
 22:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250731194731.287715-1-ion@agorria.com>
 <20250731194731.287715-2-ion@agorria.com>
In-Reply-To: <20250731194731.287715-2-ion@agorria.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 2 Aug 2025 08:09:01 +0300
X-Gm-Features: Ac12FXxBNMuE-0tGdYIzjpwT8kxPeoT0zkdpZXjTc4PVtHh6hFkTzs4Ecyj-4jA
Message-ID: <CAPVz0n35dWLjNozRJRH17AHvGXGhxNqEf5=nSTDyMdT5GZUCnQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] board: samsung: add Samsung Galaxy R (GT-I9103)
 and Captivate Glide (SGH-i927) support
To: Ion Agorria <ion@agorria.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

=D1=87=D1=82, 31 =D0=BB=D0=B8=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 22:47 Ion =
Agorria <ion@agorria.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The Galaxy R (GT-I9103) and Captivate Glide (SGH-i927) are both Tegra 2
> based Samsung smartphones released in 2011. They both feature 1 GB of RAM
> and 8 GB of expandable flash memory. The key difference is that the
> Captivate Glide has an OLED panel (contrary to LCD in Galaxy R) and a
> QWERTY keyboard in form factor of a slider.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> ---
>  arch/arm/dts/Makefile                       |   2 +
>  arch/arm/dts/tegra20-samsung-bose.dts       | 119 ++++++
>  arch/arm/dts/tegra20-samsung-n1-common.dtsi | 428 ++++++++++++++++++++
>  arch/arm/dts/tegra20-samsung-n1.dts         | 184 +++++++++
>  arch/arm/mach-tegra/tegra20/Kconfig         |   5 +
>  board/samsung/n1/Kconfig                    |  13 +
>  board/samsung/n1/MAINTAINERS                |   9 +
>  board/samsung/n1/bose.config                |   6 +
>  board/samsung/n1/n1.env                     |  16 +
>  configs/n1_defconfig                        |  92 +++++
>  doc/board/samsung/index.rst                 |   1 +
>  doc/board/samsung/n1.rst                    |  51 +++
>  12 files changed, 926 insertions(+)
>  create mode 100644 arch/arm/dts/tegra20-samsung-bose.dts
>  create mode 100644 arch/arm/dts/tegra20-samsung-n1-common.dtsi
>  create mode 100644 arch/arm/dts/tegra20-samsung-n1.dts
>  create mode 100644 board/samsung/n1/Kconfig
>  create mode 100644 board/samsung/n1/MAINTAINERS
>  create mode 100644 board/samsung/n1/bose.config
>  create mode 100644 board/samsung/n1/n1.env
>  create mode 100644 configs/n1_defconfig
>  create mode 100644 doc/board/samsung/n1.rst
>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>

Applied to u-boot-tegra/staging, thank you!
