Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85303CD11DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 22:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C0B87ABC;
	Tue, 26 Mar 2024 23:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U5KBk0gw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0925D87ABC; Tue, 26 Mar 2024 23:14:13 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16D1480EED
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 23:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5cfcf509fbdso1104370a12.1
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 15:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711491248; x=1712096048; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dj7uXol22fgjTfeIu36aHTOTXgcziZc4mFJj2F+Eb3A=;
 b=U5KBk0gwbcYsAz1zlvofwHsA9C50AP6vBtcmsabIEnbJZFhnTXse/YbPjaiMXGp5I9
 fMZmyV3nKytEoSNXiDcVfNFsFaF5mxACYipgDlqOtZV1U68wJGKeoxItY4anTkGmCFP4
 wSJmoUI/cPpkKMzKapJxQ0X0Z2jD3BXpl/S+NysHOm91yXidJ7vLHYz/YHN8NJYtRGK/
 U10HizqctGMpangFYGhAkINxl0hUruX5PTqi9ctXdJn8POMWhNrBw9pg2iq7jihgp+Nz
 R3LwYmHABBb8RYSAgPl6sSlzPr1tev7RRyX3XbngiddHZRL5O+NXJ1tzoGJW5/Uk83Nz
 knBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711491248; x=1712096048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dj7uXol22fgjTfeIu36aHTOTXgcziZc4mFJj2F+Eb3A=;
 b=OPGNDKrFOmewpVBi5wvT/wBcgsZZ+n0BMSTznBiBBMCmdy/FLa+eB/nxhBXI0ja/Ml
 HCFbXAGKqvnLJT18oPUnblYfAlbQR3Z1zl4Lve7t3JWYqw4D+pWZo15OyoDzBLPSPxRr
 3bOD6QsqV93kDyJLqSD3Y8x4EEiuQsp/7wmriPyGpQt2zw6kAFYorLkAyptFGe8PMcwu
 EKnWezZmLXYZfQoAh7jfA4JJsV25lwA5M0tlz31NoyE9ZlGajF8VUCcYa40Bn1V+OeHm
 UUeD809jKZ7YU128vmwEM2DkUj0OELsb6oYbgWDsEYsGJ6J1K+kgISXGUBviPjBUdDUl
 0eYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcw8KXVCExrgtP1fjIRdsgd5kSKeInWNTS5YmlGZWlebEw9pO4NnXIKQb8YJcAE7NLaDsCOH5DwsvspNH+UrDhPrGltA==
X-Gm-Message-State: AOJu0YxnNu3qxSFAd13/zIOyICUJDdlioZ5qGN6GLLLgNwa9pjkzjVdj
 1oG441mg/iqEWl7I0bqbuvJJ5POPnLJrSlsKu+aVYvR+wyGGrSQQSXdUdIj2ypfTHnh21M6S2qC
 reLoiIGYIurzPoK0qpobj5lDToos=
X-Google-Smtp-Source: AGHT+IEnXwN3APQhrAaAkcdQDaKN1LQ6q+VCQuvNAPiBif/dGNObh3gCLLFlyB3P6ZBcpjb5ZdIpFRU32sz8s6VEURM=
X-Received: by 2002:a17:90a:ba98:b0:29c:7487:43b8 with SMTP id
 t24-20020a17090aba9800b0029c748743b8mr9913749pjr.1.1711491248497; Tue, 26 Mar
 2024 15:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240326033801.228419-1-joy.zou@nxp.com>
 <20240326033801.228419-3-joy.zou@nxp.com>
In-Reply-To: <20240326033801.228419-3-joy.zou@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Mar 2024 19:13:57 -0300
Message-ID: <CAOMZO5AaEwu_VnmuXiT_pUiM9ftJZb3gpCSKwqVjdbKoUOb8Lw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] imx: imx93_evk: add rtc pcf2131
To: Joy Zou <joy.zou@nxp.com>
Cc: peng.fan@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, sbabic@denx.de, 
 sjg@chromium.org, saproj@gmail.com, judge.packham@gmail.com, 
 uboot-imx@nxp.com, u-boot@lists.denx.de
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

On Tue, Mar 26, 2024 at 12:30=E2=80=AFAM Joy Zou <joy.zou@nxp.com> wrote:

> +&lpi2c3 {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       clock-frequency =3D <400000>;
> +       pinctrl-names =3D "default", "sleep";
> +       pinctrl-0 =3D <&pinctrl_lpi2c3>;
> +       pinctrl-1 =3D <&pinctrl_lpi2c3>;
> +       status =3D "okay";
> +
> +       pcf2131: rtc@53 {
> +               compatible =3D "nxp,pcf2131";
> +               reg =3D <0x53>;
> +               interrupt-parent =3D <&pcal6524>;
> +               interrupts =3D <1 IRQ_TYPE_LEVEL_LOW>;
> +               status =3D "okay";

Please submit the RTC support to Linux first, then you can sync the
devicetree with Linux in U-Boot.

In the meantime, you can add the RTC support to the -u-boot.dtsi.

Please consider using OF_UPSTREAM available in the U-Boot next branch.
