Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0809BCF07B3
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 06:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D8F8918B;
	Thu, 10 Oct 2024 08:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cRrv9y14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE7B6891A1; Thu, 10 Oct 2024 08:35:31 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDE8E890CC
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 08:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2facf48166bso5437761fa.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 23:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1728542129; x=1729146929;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sU1o7NbSCAIm79XghJJJR29YjnlgW3W5LpLWMiK/Ax0=;
 b=cRrv9y14A/3gJ5kv5a62Q5WDCy/GiUsqH7T6bsRE5elaoU2VZimoIyW9FFgGbW9Nub
 BKaSiz6VUNX1naKYk17v4MhOSzYtT9NM2E6Hp5uhgxYC9+O7hhvFy2tt+dp+aoeohMTv
 DuNu3jz+LNr3e0sS9sKEreFMJFHkmICQjyfpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728542129; x=1729146929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sU1o7NbSCAIm79XghJJJR29YjnlgW3W5LpLWMiK/Ax0=;
 b=mcffNzdzp8RJY6Lk/2J1vB2YV7wuC9aT5za2sRkQo3IDdBkr4u25wpuz+4TalF7JMT
 UwtaeAgUmFzZQKS8kwJ0uncTHiDj8r/GSneqauLmmpuacwiT30DNARi+8twKYW91OQr8
 uqBxCO4DEJ3//mwFS/2KLs5xYiEaMFzURckPBCIhtJEa375bRhmtO1zyoslGMLLaMlRZ
 YS4ouU19Ss7+oYO6vkYdG6+PfNIuHvEGW/hHjt1CATmz4r7Ko5SAfE3yc2CMEN7sd2rc
 wv8ZnfcYXYnEFWn3Q7/LmKz3CAA3LqCqMjUJwV4yU7XVJeT1x1L8MgpQVBypO25ayZ4P
 C7Jw==
X-Gm-Message-State: AOJu0Yz9vM+SVCF48fNuvqF/aSbafpbZZRMHhBfVxo+ScAoDR6awfeV9
 YkAHbHimbiTNryR/I5QczYDxGlrwvq12Nh8ZDCz96IugLq1qHTn36OCjg1KUYINl5hswtLo0q1T
 aHXIG2ehQoADV8nlJGiVSPaibhFYkqsiWGmJM2g==
X-Google-Smtp-Source: AGHT+IHYRSdTR/k8hw6PpyfwI1wyXw1h8fldpV5Rz/Iy7+EU4nHl1cCn6m1ContaeICZhsDg5HPpfFCYZqYkot4TWVU=
X-Received: by 2002:a2e:b8c1:0:b0:2fa:d67a:ada7 with SMTP id
 38308e7fff4ca-2fb18738382mr30830781fa.23.1728542129176; Wed, 09 Oct 2024
 23:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1728539755.git.jan.kiszka@siemens.com>
 <b770395ca5c7d41eab30aaaa7ad7e97a48595eec.1728539755.git.jan.kiszka@siemens.com>
In-Reply-To: <b770395ca5c7d41eab30aaaa7ad7e97a48595eec.1728539755.git.jan.kiszka@siemens.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 10 Oct 2024 08:35:16 +0200
Message-ID: <CAOf5uwmCt8WBooeg3NHuUQ_jszRYtkSi=C9MW-rN75z_-hUUYw@mail.gmail.com>
Subject: Re: [PATCH 03/11] board: siemens: iot2050: Control pcie power for all
 variants
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>
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

On Thu, Oct 10, 2024 at 7:56=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> From: Baocheng Su <baocheng.su@siemens.com>
>
> The power control pin of pcie interface not only works for M.2 interface
> but also for miniPCIE, so promote this logic to all variants to
> workaround the module hang issue.
>
> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  board/siemens/iot2050/board.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.=
c
> index e5c7ce58b06..85cb999f17f 100644
> --- a/board/siemens/iot2050/board.c
> +++ b/board/siemens/iot2050/board.c
> @@ -185,6 +185,12 @@ static void remove_mmc1_target(void)
>         free(boot_targets);
>  }
>
> +static void enable_pcie_connector_power(void)
> +{
> +       set_pinvalue("gpio@601000_17", "P3V3_PCIE_CON_EN", 1);
> +       udelay(4 * 100);
> +}
> +
>  void set_board_info_env(void)
>  {
>         struct iot2050_info *info =3D IOT2050_INFO_DATA;
> @@ -288,10 +294,6 @@ static void m2_connector_setup(void)
>         struct m2_config_pins config_pins;
>         unsigned int n;
>
> -       /* enable M.2 connector power */
> -       set_pinvalue("gpio@601000_17", "P3V3_M2_EN", 1);
> -       udelay(4 * 100);
> -
>         if (m2_manual_config < CONNECTOR_MODE_INVALID) {
>                 mode_info =3D " [manual mode]";
>                 connector_mode =3D m2_manual_config;
> @@ -429,6 +431,8 @@ int board_late_init(void)
>         /* change CTRL_MMR register to let serdes0 not output USB3.0 sign=
als. */
>         writel(0x3, SERDES0_LANE_SELECT);
>
> +       enable_pcie_connector_power();
> +
>         if (board_is_m2())
>                 m2_connector_setup();
>
> --
> 2.43.0
>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
