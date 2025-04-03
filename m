Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A11C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 13:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D5582075;
	Thu,  3 Apr 2025 15:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ij5lyxNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F8B782076; Thu,  3 Apr 2025 15:04:14 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 059AB82054
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 15:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224019ad9edso11365905ad.1
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 06:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743685450; x=1744290250; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esacmFRbYY+9lZq7sWJ9hBpsDpdbkKO2wZDYE9lJBhg=;
 b=Ij5lyxNxhUTncrQbXvNujsFlhOcWB1xavKIqsJ5oIAD6z6DdE1dK/+eWF64kDNjR75
 GOYP+ZdRkoSUfuUczukV5lzgCK8CkxyB7EKcsqaAK+qJrCEoc7SibnZ9z6GiwEApWi1U
 Qoj2Wf1bwnyzoEbrhkdOkhMia8D50Zq90F2QpZjBpLcOogbA2zeZYO7hYb8YfxBWEoOV
 1/354pV89F4ZPc/EVhkmEazCdqC1ED3+kP7EIT0AoUilh36dOcAozCbaMf+4q5/OEpj9
 6l9CFjyJafTtXb9yBwONr4qqJu9nOvkSphwR1hlXPPC7pOip6eEe0a7O3aXpgTx3kgsd
 SZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743685450; x=1744290250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=esacmFRbYY+9lZq7sWJ9hBpsDpdbkKO2wZDYE9lJBhg=;
 b=t4isi6QFLDUwCbK0uT8FunnjNDEmJZ9V3+KQ+7FDxiP6JWHQIETuk1RZjXLCQTnB6v
 xq2R/GKG89W11KNMvn+93lxEh9giKC8xpa1h96sZHw566fXc0/3TNwH+PGBYjx9nhZa+
 xrwhpO7rgz01ZHHD+yY4MX/Assi18vFjp8FVG641L91Leo9UZQU8spsATBvLEHfRS7MZ
 3ibHBs3Ixzed+MsyFuW0E28dVWOItyAVfpU6m25kdXBgN4Rr5L95NiIlyw12LVqjPhmw
 QlT/UeKrmdj1izbTFrCD+XNVUKsizYuhJ05Md2nBHyLOXz39XxPDJgyF4ZxxmjbxuJxb
 bQeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI62Mb+FENXYrHoX8mURfcjVWiXUAyxrVhleUNdEvVza9Ix2P9xX5eGB3MQS85LZb4X5kIThc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/FrpfMX7UNc4viScdASnirAixh/+e6r0NzOgyn0CbgyGhgJ0n
 VfFVmcwQ4D67bEItUgIk9CPcDYQIqOigxbtQSbpLzYPJfVB0XLUCE2aVi0yJpl6zjjcsrdjwOlo
 Yy14sVPslNwaPH4BG03NjKPFtiDk=
X-Gm-Gg: ASbGnctU+ib6SAVSRkYDNFq2QEYVHTXUhkhNrzlnBS1uJN89uTKqZnwGCjmBn2jXpbu
 lMAO1AorTl6DcFaByDK8yn3os/WLYonGFSig14YJeOadGx8o/uwWOBPKB7CQgY39DHaVyMKZo3s
 1MfScyMhHM2thimde16Wv3MzzTCgR8QCnLHs/R
X-Google-Smtp-Source: AGHT+IHDeySaF7VRAwEwS02Sa7PtEFNvQO1GGFP+Di57xE7WvVAairbUQ4EgHkKWHRCleXjWlhJ1a+D3mmWHy7jm1sw=
X-Received: by 2002:a17:90b:57e7:b0:305:2d28:c8fd with SMTP id
 98e67ed59e1d1-3056ef0d8f1mr9129301a91.24.1743685450123; Thu, 03 Apr 2025
 06:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-6-478b5e3dd872@bootlin.com>
In-Reply-To: <20250403-ge-mainline-display-support-v6-6-478b5e3dd872@bootlin.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 3 Apr 2025 08:03:58 -0500
X-Gm-Features: AQ5f1JrqScXnh9QwmyLdoHaS-tdW9M-BQCl4k6BOZnwb31BK6CX4Ulq9ZQcg978
Message-ID: <CAHCN7x+9X1Rwd0VKRMD2cha7yL9p2HWK_tf5NyjTcO3svcPj0Q@mail.gmail.com>
Subject: Re: [PATCH v6 06/12] clk: Ensure the parent clocks are enabled while
 reparenting
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Fabio Estevm <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>
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

On Thu, Apr 3, 2025 at 2:39=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> Reparenting a clock C with a new parent P means that C will only
> continue clocking if P is already clocking when the mux is updated. In
> case the parent is currently disabled, failures (stalls) are likely to
> happen.

Marek made some changes to the clock registration to address some
parent-child relationships.  Do you know if this patch is still
needed?

adam
>
> This is exactly what happens on i.MX8 when enabling the video
> pipeline. We tell LCDIF clocks to use the VIDEO PLL as input, while the
> VIDEO PLL is currently off. This all happens as part of the
> assigned-clocks handling procedure, where the reparenting happens before
> the enable() calls. Enabling the parents as part of the reparenting
> procedure seems sane and also matches the logic applied in other parts
> of the CCM.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/clk/clk-uclass.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 90b70529a478d11d907cbd6b64d680d0c1db4d5c..4b3d812f9c6539a6b769990e3=
e11f14f49abb2a9 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -623,14 +623,27 @@ int clk_set_parent(struct clk *clk, struct clk *par=
ent)
>         if (!ops->set_parent)
>                 return -ENOSYS;
>
> -       ret =3D ops->set_parent(clk, parent);
> -       if (ret)
> +       ret =3D clk_enable(parent);
> +       if (ret) {
> +               printf("Cannot enable parent %s\n", parent->dev->name);
>                 return ret;
> +       }
>
> -       if (CONFIG_IS_ENABLED(CLK_CCF))
> +       ret =3D ops->set_parent(clk, parent);
> +       if (ret) {
> +               clk_disable(parent);
> +               return ret;
> +       }
> +
> +       if (CONFIG_IS_ENABLED(CLK_CCF)) {
>                 ret =3D device_reparent(clk->dev, parent->dev);
> +               if (ret) {
> +                       clk_disable(parent);
> +                       return ret;
> +               }
> +       }
>
> -       return ret;
> +       return 0;
>  }
>
>  int clk_enable(struct clk *clk)
>
> --
> 2.48.1
>
