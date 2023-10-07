Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8A2E95A61
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 12:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF6C5868AE;
	Sat,  7 Oct 2023 14:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L0IkZi33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFB9886564; Sat,  7 Oct 2023 14:37:26 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C35586564
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 14:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-27755cfa666so505254a91.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 05:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682242; x=1697287042; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QnGJvVwr2Nd5pdvH8mY3ewF3l6SZ5zPUmzkv2j9SHgM=;
 b=L0IkZi331Om4frCSYNiZuVcNLBsZ0tYOOOBoOXh44P+FB4YBCJpDTNx1U303uiWnLT
 5j8uO6ZVRqQRenryrxG3rFALhFXD7r6CjWCtVt9ruEp0aATGYTFlokGAbuKHUngTJIvE
 X///dOgbJxk6FONU/HXiQBe4viCaRpZzwD9dwQFFrw+ydJEbilaJACLAdZMuYt7vfLRm
 hAH+WemaI1q9ri+SeruNMJIPIenw13rynPKoEkHrEyOA74dPU8wYVdT4Sr+IR3n/IoPO
 GqfHy9orxYp7Srs8w4MR7SAH0iEJsw7gasEw1yHfZ+mPXL0wXA7CHzwtq1IAm1RNXgWT
 Gurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682242; x=1697287042;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QnGJvVwr2Nd5pdvH8mY3ewF3l6SZ5zPUmzkv2j9SHgM=;
 b=etstjhCZ7htc9KYnF8I3IizxinYCzFze66V68RxjJEK8A/0dqN19wTU2Y9W4I7/+TA
 eFQLhpxt8YBVkBArNOocBzoyKhnsGPGW4FYyIUoOwBjwyKcB3aGH3ndnRRjyiRxbqt13
 dnqDIEy47oHJVinaiob8pqPfW3d4baDpRBWDf1n3oD53nWI8NxkAbXKzHOdW/ClzvvU+
 cUWdHLacq8DuVT0YbxfC+saPuyMRkrXOAWTF3ULirQe2MY9zpHH0s/IbLnQDzXDsdITJ
 A2/9p+rrWCQMP8eVy3R+trvwcT6GQiB19utIId7rJVYkCERb0UrqXf4IBfEMsqRQgNZe
 ao5g==
X-Gm-Message-State: AOJu0YxFaGZ+ns/k56stGzSwEMc9yxj1wWWs7MVfdbdzum9T6A90AE89
 q9E+Nazkkkd2VOB5gCn2WsQI0lW4c2SbcE6Nmu4=
X-Google-Smtp-Source: AGHT+IEujtFpy2LqFTIH5dH8ZAGSqUOf+cKsOFGC8qYI/WImfm+4E5K/SG24ryvGk9f14X9f/CtZ+W6palXVBxcxwZg=
X-Received: by 2002:a17:902:e5d2:b0:1c4:1cd3:8062 with SMTP id
 u18-20020a170902e5d200b001c41cd38062mr11950046plf.2.1696682241683; Sat, 07
 Oct 2023 05:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231006213702.1064-1-egyszeregy@freemail.hu>
In-Reply-To: <20231006213702.1064-1-egyszeregy@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 7 Oct 2023 09:37:09 -0300
Message-ID: <CAOMZO5A3mYTaSzEJzZMCZO9v4mfy2bR712fw2u6N5938EokYbA@mail.gmail.com>
Subject: Re: [PATCH 1/1] [u-boot][master][PATCH v5] pico-imx7d: add baseboard
 SD card boot detect
To: egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, otavio@ossystems.com.br
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

On Fri, Oct 6, 2023 at 6:37=E2=80=AFPM <egyszeregy@freemail.hu> wrote:
>
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>
> Take over codes from Techenxion to support

Typo in Technexion.

> mmc autodetect boot for pico-imx7d.

Please explain better in the commit log that you are adding support
for the SD card in variants like the nymph baseboard.

>  int board_mmc_getcd(struct mmc *mmc)
>  {
> -       /* Assume uSDHC3 emmc is always present */
> -       return 1;
> +       struct fsl_esdhc_cfg *cfg =3D (struct fsl_esdhc_cfg *)mmc->priv;
> +       int ret =3D 0;
> +
> +       switch (cfg->esdhc_base) {
> +       case USDHC1_BASE_ADDR:
> +               ret =3D !gpio_get_value(USDHC1_CD_GPIO); /* Assume uSDHC1=
 sd is always present */

Remove the comment as this is no longer true. You are reading a GPIO
to decide that.

> +               break;
> +       case USDHC3_BASE_ADDR:
> +               ret =3D !gpio_get_value(USDHC3_CD_GPIO); /* Assume uSDHC3=
 emmc is always present */

Remove the comment as this is no longer true. You are reading a GPIO
to decide that.

>  int board_mmc_init(struct bd_info *bis)
>  {
> -       imx_iomux_v3_setup_multiple_pads(usdhc3_pads, ARRAY_SIZE(usdhc3_p=
ads));
> -       usdhc_cfg[0].sdhc_clk =3D mxc_get_clock(MXC_ESDHC3_CLK);
> -       return fsl_esdhc_initialize(bis, &usdhc_cfg[0]);
> +       int ret;
> +       u32 index =3D 0;

No need to initialize 'index' with 0.

I tested it here on an imx7d-pico-pi. Prior to your patch, I got:

U-Boot 2023.10-00559-g931b7c36604b (Oct 07 2023 - 09:17:25 -0300)

CPU:   Freescale i.MX7D rev1.2 1000 MHz (running at 792 MHz)
CPU:   Commercial temperature grade (0C to 95C) at 55C
Reset cause: POR
Model: TechNexion PICO-IMX7D Board and PI baseboard
Board: i.MX7D PICOSOM
DRAM:  512 MiB
Core:  75 devices, 16 uclasses, devicetree: separate
PMIC: PFUZE3000 DEV_ID=3D0x30 REV_ID=3D0x11
MMC:   FSL_SDHC: 3, FSL_SDHC: 1, FSL_SDHC: 0
Loading Environment from MMC... OK
In:    serial@30a70000
Out:   serial
Err:   serial
Net:   eth0: ethernet@30be0000
Hit any key to stop autoboot:  0

After your patch:

U-Boot 2023.10-00560-g9bf37c401a1d-dirty (Oct 07 2023 - 09:23:54 -0300)

CPU:   Freescale i.MX7D rev1.2 1000 MHz (running at 792 MHz)
CPU:   Commercial temperature grade (0C to 95C) at 54C
Reset cause: POR
Model: TechNexion PICO-IMX7D Board and PI baseboard
Board: i.MX7D PICOSOM
DRAM:  512 MiB
Core:  72 devices, 16 uclasses, devicetree: separate
PMIC: PFUZE3000 DEV_ID=3D0x30 REV_ID=3D0x11
MMC:   FSL_SDHC: 1, FSL_SDHC: 0
Loading Environment from MMC... OK
In:    serial@30a70000
Out:   serial
Err:   serial
MMC Device 2 not found
no mmc device at slot 2
Net:   eth0: ethernet@30be0000

The messages:

MMC Device 2 not found
no mmc device at slot 2

are a bit annoying as there is no SD card in the imx7d-pico-pi.

I would prefer if these messages were not shown.

Can you try to get rid of it on the  imx7d-pico-pi?

Tested-by: Fabio Estevam <festevam@gmail.com>
