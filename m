Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC499C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 06:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00E2187F51;
	Mon,  4 Mar 2024 07:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="alhKavBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E17187F6E; Mon,  4 Mar 2024 07:33:20 +0100 (CET)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5BD5879F6
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 07:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-47282752fc7so1036500137.2
 for <u-boot@lists.denx.de>; Sun, 03 Mar 2024 22:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709533996; x=1710138796; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MQGQpJ6SA5n/kZj4J7EqXgFoTMXKflJKLi8xaPUwCv0=;
 b=alhKavBYlFvaufBoYO2dy295tPO9dNjb8rY32/qBTIQf5QnmUkMUbHeiljqmpK95AP
 ewHjB3ulJ4Bcjoeb7dDE8TbQ5vAQToyq3dGhI8dGAziwZbspPhru7KOyongBUNMwKz+X
 anEIZWqUGaFZfw0gPEdl+NMGGKRhi/TTd32qPow4VshiC7ZuMzc12eXxqPyjk4elZ7c8
 Zs4vX4L0Z+vKvKWe6ZFqc3hNOAMcYveExhSdjToSCzDwVLT3eWZGkTcAmTX6lpN4WOzH
 5WDL39D5oxqYaBB2Vszxhqk5TbJt3YqpKgq92OdfGdpEg89ZQiDHv2s+fkCywgJyo5v6
 jVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709533996; x=1710138796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQGQpJ6SA5n/kZj4J7EqXgFoTMXKflJKLi8xaPUwCv0=;
 b=CJO3FfMQoKo0Szuv7eUBYUIRLTQDRl4GFFQrC8QQZsCzWrb8Zi3GXR49jA0wCm55T9
 mYwO2ZlIsA5MeYSMqq9g2OXfmdTx3zDXvZSBlPTeu5ALC1EvZNSmVVZsRizq5Xm+v9pz
 +JLxz4Erb5etKtA0dO1jM7tC8co5yhfKvt+MyamGqNLbykl7SIYouORHVZAx4oDhrHg0
 ltNE8EMThBywaUCVRx9jd3I8xVKz7gbGc84XKK4bAROkd7x3VWSoFC9+ttITnwiNyHyf
 AQv35JLNZyU584jnGeqHM/eXJ5QvzBEFoZv4QoU7cNY1WV3xm3EgC/6nw2xMy4FLx5Bj
 NHxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYNXS6rEeo7xRLfRz8nCRaLrRe4zSPn726qc8e6aMwGCg2eo+2qTNedFqis+Hr3Dnzh3wfuwYjm72l0Xom7lYU2c7CTg==
X-Gm-Message-State: AOJu0Yz/PpsZKbFFgz7rCBzqtoxVKjZfFO1Hm0ACrBurV6tZlHQx13zs
 eab3RJMQRSowhXksyyGmLpVplSW7++MbYvGFZxFfaJ/kfVEX461S97qMKDjWyKSQDdA9aZSgdJ+
 lx962XKMeXw9nxMl3fCQbl3M0I9CqYxFzWaBDSw==
X-Google-Smtp-Source: AGHT+IF3eVy6F7nq9uBSYGA9mlTq8G9O6ifVMlwRb7FfW8hFMzZANKsP190g6SUawPYKWmklRUi+WD0g+jgR9CIjQWA=
X-Received: by 2002:a67:ee52:0:b0:472:78bc:35b4 with SMTP id
 g18-20020a67ee52000000b0047278bc35b4mr4857907vsp.0.1709533996098; Sun, 03 Mar
 2024 22:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
 <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
 <CAOMZO5CjeUhFfLBs3FRt4Hbk0ULXrRoOZaZqvSRzWbNySdsOhQ@mail.gmail.com>
In-Reply-To: <CAOMZO5CjeUhFfLBs3FRt4Hbk0ULXrRoOZaZqvSRzWbNySdsOhQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 4 Mar 2024 12:03:04 +0530
Message-ID: <CAFA6WYMf7Z-sW8pSHzYUJ_O9fqfunBEhyigJj3BW-DYuujxDbw@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, peng.fan@nxp.com, 
 marex@denx.de, Bryan Brattlof <bb@ti.com>
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

Hi Fabio,

On Fri, 1 Mar 2024 at 22:20, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Sumit,
>
> On Fri, Mar 1, 2024 at 9:57=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Thu, 22 Feb 2024 15:05:56 +0530, Sumit Garg wrote:
> >
> > > Changes in v6:
> > > --------------
> > > - v6_dt: https://github.com/b49020/u-boot/tree/v6_dt
> > > - Patch #3: Incorporate fix for sandbox CI failure.
> > > - Patch #6: Incorporate shell script comments from Marek.
> > > - Patch #8: Incorporate documentation review comments from Paul.
> > >
> > > [...]
> >
> > Applied to u-boot/next, thanks!
>
> I am trying to use OF_UPSTREAM with imx8mp_evk_defconfig:
>
> diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kc=
onfig
> index 328c3e388051..29d0c5ce6485 100644
> --- a/arch/arm/mach-imx/imx8m/Kconfig
> +++ b/arch/arm/mach-imx/imx8m/Kconfig
> @@ -8,6 +8,7 @@ config IMX8M
>         select LTO
>         select ROM_UNIFIED_SECTIONS
>         select ARMV8_CRYPTO
> +       imply OF_UPSTREAM
>
>  config IMX8MQ
>         bool
> diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
> index 2350d2f409b7..cdf840c683c0 100644
> --- a/configs/imx8mp_evk_defconfig
> +++ b/configs/imx8mp_evk_defconfig
> @@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
>  CONFIG_ENV_SIZE=3D0x1000
>  CONFIG_ENV_OFFSET=3D0x400000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"imx8mp-evk"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"freescale/imx8mp-evk"
>  CONFIG_SPL_TEXT_BASE=3D0x920000
>  CONFIG_TARGET_IMX8MP_EVK=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D524288
>
> I ran "./dts/update-dts-subtree.sh pull v6.8-rc6-dts".
>
> make mrproper
> make imx8mp_evk_defconfig
> make
>
> The dtb is built: dts/upstream/src/arm64/freescale/imx8mp-evk.dtb
>
> but mkimage still looks for the old path:
>
>  MKIMAGE u-boot.img
> ./tools/mkimage: Can't open arch/arm/dts/freescale/imx8mp-evk.dtb: No
> such file or directory
> ./tools/mkimage: failed to build FIT
>
> Any suggestions?

I think you also need Bryan's patch [1] to be incorporated as well.
Give it a try and let me know if you still see any further issues.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240205-am62px-wip-re=
basing-v3-11-04cbb42eaa6f@ti.com/

-Sumit

>
> Thanks
