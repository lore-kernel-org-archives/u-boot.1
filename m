Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11B0E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 06:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 476D9895AA;
	Fri,  6 Dec 2024 07:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hz37G120";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82404895AA; Fri,  6 Dec 2024 07:03:54 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4386A89540
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 07:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434a742481aso16438995e9.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 22:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733465032; x=1734069832; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVqfac2N1QYOXThjxWW3c2mmbnEp5+DWlIGczTv9bPY=;
 b=Hz37G120VOhdeGEzJ5tWWi2LPBpkBffWx7unJNP+t2i6XIRbtTiaf8lA+7aLsdc8Vc
 zn7+fQvbfUaIxHjR+OLN2p1lWDmSXStC5veyFsrWyohT/gywQV99QKIgR19jM+0+0jNP
 MttmS1TZqHeJEXhEgeRiqYW8nFOXhLTXzx4rk2hbni2vY5sjueHljHdJG1/wFIrPVRo1
 z45nLJP7KYg532zJTLQkNS4kqjKxRm2U2ncDGNKpU4NfvbtP6gY+3lzwMyAx0H2vKE3I
 A3lbxcW8wTOVYF7KX7JDHyA9LAm/w+qLft9EuG9EHm4bz+Tx6iHmK3pLGyqqa670DKII
 4PeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733465032; x=1734069832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gVqfac2N1QYOXThjxWW3c2mmbnEp5+DWlIGczTv9bPY=;
 b=nk6oSC6Q/p43094Ro+xGv8F0WX0k/Qy4Y63dQdayMQnIOjKQM/mr4LzvOqxrQgbLFW
 T/EiuCF9atil/KwRmk41Hz7AaaGrvWlAD+SgHFhAQ4JsqJM5lrAyzXs0a22+zO7yce8C
 eRiZxRAB4O9Ysrpw4X2pWC6xnW5kibRXNfvkvvvJd3UFa8zLOsZCtGHVuIw+d/vm+4HK
 9jAy8I0NdItHvJWMQAEAQky4arsNiHuFy94OM9TDD+mFBzJcPOI919hXVTgY9WcydEqo
 FeLiYbZIb7bHwu06WN4JVfTrlVkCndVbSe1c0eAKQkPi48+P5En6KBUDdf5TebPHoZ+3
 /h2A==
X-Gm-Message-State: AOJu0YwuUyTtSwqEttPY7qowMdCyaNXyG7UtB9SSMP8xakTod6wJnGUA
 t56sLl6orIaZQSJ6m3o/wT6l3SzOKGjEPQNoyBxdEHm0cgMs075PtzclqOrMUNnLrm6BFHmouEd
 9GKWWkiQLQZdTrcVvuWmy27cVkus=
X-Gm-Gg: ASbGnct2striGwIHEJkkS4aS+wRewyBbA5NUQueX5yTpZJ1OuEq74937praUXei/NKr
 ZD1evWTkrty3wjqfe9AJEzZvKfgC/AWIe
X-Google-Smtp-Source: AGHT+IFkR3W/3ynjWVNFBox93+ZHH81zMi7hRiLq0We2xMIXneVyQxx63pvvh+NDT8swi6U1xmLpGFVHO7YdfFk2Jys=
X-Received: by 2002:a05:6000:4715:b0:385:fb34:d585 with SMTP id
 ffacd0b85a97d-3862b37f1fcmr1313316f8f.34.1733465031501; Thu, 05 Dec 2024
 22:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20241206060115.4346-1-clamor95@gmail.com>
 <20241206060115.4346-2-clamor95@gmail.com>
In-Reply-To: <20241206060115.4346-2-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 6 Dec 2024 08:03:40 +0200
Message-ID: <CAPVz0n1P-Or7226_3nBTY=33R=f-U3kaJ=wEsE8NKFTqEOqVig@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] driver: clk: tegra: init basic clocks on probe
To: Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Thierry Reding <treding@nvidia.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
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

=D0=BF=D1=82, 6 =D0=B3=D1=80=D1=83=D0=B4. 2024=E2=80=AF=D1=80. =D0=BE 08:01=
 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> In case DM drivers probe earlier than board clock setup is done
> init of basic clocks should be done in CAR driver probe as well.
> Add it to avoid possible clock related problems.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/clk/tegra/tegra-car-clk.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/tegra-=
car-clk.c
> index 9078253d100..4f8405328a3 100644
> --- a/drivers/clk/tegra/tegra-car-clk.c
> +++ b/drivers/clk/tegra/tegra-car-clk.c
> @@ -111,6 +111,9 @@ static int tegra_car_clk_probe(struct udevice *dev)
>  {
>         debug("%s(dev=3D%p)\n", __func__, dev);
>
> +       clock_init();
> +       clock_verify();
> +
>         return 0;
>  }
>
> --
> 2.43.0
>

Simon, please test this commit and it it works for you, it can replace
this revert  https://lore.kernel.org/all/20241201164810.GT3600562@bill-the-=
cat/T/#m2b62b471fd37e4c9725c98547e2a919cf11db5e5
