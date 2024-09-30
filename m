Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0E7CF6499
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 11:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9F1288009;
	Mon, 30 Sep 2024 13:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H2MO/H2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E92E288E3C; Mon, 30 Sep 2024 13:17:17 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05FC088005
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 13:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5398996acbeso3110267e87.1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 04:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727695035; x=1728299835; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4QKKlb+Q1TvNTRHVU/HqklhRTGiU320aqDZUBsFLT8=;
 b=H2MO/H2D/xUm8BDtpKxaOP/LGXzSaZPEGfJ7R22i6y+pAgpki36cavv5MQNgqgFOya
 ZF9A6UKAF3oNo2QSRGmGTCVDrUDVYkC/t5365Hq/9roYU7lSQr7wklBxmnvwvwWYHnjG
 XaRxsXHreMR+mgI7f03EtAtLq9vcGR0ULiEr7NJamkgmf0cRkDtR2qLDZreF2EtX57Pe
 c3At56CBSk9WoSNV89qeoYr50ZMXSjaTQ0YlLlbxycCi7tOofzaXkhRHOl/VdRbuFlzL
 5PCqjqBQHp0eUQGCTD3dIJf6btFnEBrsk5RO50yVhsxEVYccuE2rnsHMX/npX12J2VFw
 mOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727695035; x=1728299835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4QKKlb+Q1TvNTRHVU/HqklhRTGiU320aqDZUBsFLT8=;
 b=Tv30mL3X8gr5wxrJY9gf6MiXAmTpi61lDnkkK/N22WkAN/DgM1Sb54E4EqYz9r7Yh8
 f7VmTDH079Yz4qI4pMV+qa8LDEuorD4pSiyweK40Y0Beku4M5QL7nFps0bZVHlo2vCc7
 tabmEpVfrt6cKUUTdL1gkV1CjP5MekIBfAWUAwuGUdbE7KkolnjHP7Okp3Oc5LLw7Kte
 2CDJHfxrcXonQmtfuEAl9h/1UYD1SfrpJ+8nNpd627mF/8DK9teKLQhoF/csLqpnFaa+
 dafisoMv1A95H55z0Lw5ZeC0RIWqvhcfQupKa08XkC8m6At/U8A1ojQduY+OM97Pfw9Q
 DK7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz1JavobzrJ72I2tgGJkz8/ZclWK0qn7TQKcQS3LqGNttJo/vBtDYz8NU2F5Cmt+tuH6R5Ugw=@lists.denx.de
X-Gm-Message-State: AOJu0YzkgyN82mnN6oxuTNzcFi7OaPfv6ERRQQy3ZndKHJ8++vToFVIp
 rTGkP7kmV7JosP2u9/McBYfWD9K7sy3x9ZTRZH7dq1pOV7LkbnMh/FuE6UfRO327AHdbDKD4cLP
 XZdrLCVdjXN5kO52AUkIKD6nzm+4=
X-Google-Smtp-Source: AGHT+IGaH5/dtJoRqjSKc2q1+EBk8XuMGBFecJSGA1cunGAdGADo7t+zA3CoUgcxpWccUBLS+8cVk3va+ceOWrMOwk0=
X-Received: by 2002:ac2:51ce:0:b0:539:89f7:3187 with SMTP id
 2adb3069b0e04-53989f7343fmr4911068e87.47.1727695034914; Mon, 30 Sep 2024
 04:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240930065041.5554-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240930065041.5554-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 30 Sep 2024 08:17:03 -0300
Message-ID: <CAOMZO5DDL_AkGr1_TZHLwowvypmMnuD1b7DGGjoNdECPL9WHyA@mail.gmail.com>
Subject: Re: [PATCH 1/5] mmc: fsl_esdhc_imx: Enable AHB/IPG clk
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 uboot-imx@nxp.com, Ye Li <ye.li@nxp.com>
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

Hi Peng,

On Mon, Sep 30, 2024 at 2:47=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Only enable PER clk is not enough, also need to enable AHB/IPG clk.

Currently, the driver is working and now extra clocks need to be turned on.

Please provide more details here as to why this is a problem now and
it wasn't before.

>  #if CONFIG_IS_ENABLED(CLK)
>         /* Assigned clock already set clock */
> +       ret =3D clk_get_by_name(dev, "ipg", &priv->ipg_clk);
> +       if (!ret) {
> +               ret =3D clk_enable(&priv->ipg_clk);
> +               if (ret) {
> +                       printf("Failed to enable ipg_clk\n");
> +                       return ret;
> +               }
> +       }
> +
> +       ret =3D clk_get_by_name(dev, "ahb", &priv->ahb_clk);
> +       if (!ret) {
> +               ret =3D clk_enable(&priv->ahb_clk);
> +               if (ret) {
> +                       printf("Failed to enable ahb_clk\n");
> +                       return ret;

In the case of failure, the previously enabled clock must be disabled.

Would it be better to use clk_enable_bulk() here instead?
