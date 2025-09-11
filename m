Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B07CAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 19:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DFD0833D1;
	Thu, 11 Sep 2025 21:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NwJpc0XG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19B7A833EB; Thu, 11 Sep 2025 21:43:24 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2144F833C0
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 21:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-33730e1cda7so10951961fa.3
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757619801; x=1758224601; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mBz/oWvEfMWVLiZ1KflnIXbf54XDlZytEJkxhNNnoE=;
 b=NwJpc0XGhlYlcq5i4/qG44H1/2YqSMgAJfHwQM+a8avJfvpzKnVilHU4yVQTmbYLOh
 WK3VDaFn2yNvPX6zkEDCQqtUHXcxmPnseCP+DJlJtFupGePuTrgT65+RXFdaT3bFSXGs
 AHA41tWIUhz+8ev8ZYh89eqF07GM5XWmpir7UEFvr2cbmG4VKP86OuFdNMKJLU6vMc4H
 2MCDl64YcyU40X4Xt9dVV0PP/RsqtW0gbDLseA2glxdrm8p4pYz8A5n2e2mABKjs4Fdh
 ebZS298E4HdfhPulXwawjwpDto3YFixCY9QlQLbsKbsMcmTrP2kR1FAzf2WK+ADeqp9d
 JN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757619801; x=1758224601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6mBz/oWvEfMWVLiZ1KflnIXbf54XDlZytEJkxhNNnoE=;
 b=Mwjhw5g8RuT03nZ0rkyLL2zmiBlKErz1MjfjOST0IZXddPvCQ/weGgUM+EcCsFdb4z
 zLrEl1gTyuCr8Tj1BUHKShxEdE1g2ICLD+6HGx624zSjhk7Hu/+5+SyvMQOLm03CDw9Q
 D8zchkupNIuVE7esCpjhRLo1gkQg1ngw9XTcCZ/QRzIKgzibeZpASQ73ymOdelCwdFSw
 bViw1umPGZQyvHh1QsmtvqF6U4Xu6GBAdm2qk0sjiBpfv5pQyK0AmzZZVqEsQzNv9Izs
 X89dpmGf7fjqv/eOp47VMZ63uq9loglXijN2PyEQaA8DzxAnU0b7F26VN//rC7ulSHrI
 TyMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJJU9hI+T5PojHP9CUAJ19byCpS2cdxj7Vy2V1jOwFk8/x8dnpNcVbdSsqOxtcprtepu65l0I=@lists.denx.de
X-Gm-Message-State: AOJu0YyKVbwZrUZiZfcIjIB8bcOVV6/FWr3HIzMjqB1i3uoPkxMPJPpM
 VC0vsQ1lFKjmOOMIiQTGEGpzUo1vlrCcA9sPf+67YhmusY+V/X68cquw5LpUObSdKRb5mf6cEuB
 ruA7ipVHjTemdFRAOztSTFoE6Cx1oXaxN1zQA
X-Gm-Gg: ASbGncvjqlSGjRQDSvZQ2PJABIFxpMqVyuXz+a6FNmuQef8Q64ndfVxTJCjIWc+HNhg
 82vUi/xiNcBDnhoAT5m0W6bap0s5SMuNCB7g4Fnhhct5cEAupNgoSrkCLsmI7Aw9xQ85/si6Tq9
 f66HpHkSMT/OzYswfY8RTAtl6qsBEpaAICiNXESRT2M+UthXZqKRQy64B8ySkmtKWhDJ83HBAZz
 Dcjsw2fXpqJnyNwSpm7xeGni3cMfZTaFYnCU2k1cg==
X-Google-Smtp-Source: AGHT+IG9zr7Xp9roVPp1PAdRJs/+Gjotzzr+bCCHQ8PnN3EZxrTHXRFjwA52B+Hn0ZpEC14mXrEn93nwLxFCyJGhrmg=
X-Received: by 2002:a05:651c:220f:b0:336:ae5b:8a12 with SMTP id
 38308e7fff4ca-35138cfb7d6mr1097691fa.3.1757619801022; Thu, 11 Sep 2025
 12:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250911-mathieu-frdm_imx93_fastboot-v1-1-c629d8b7c8cc@bootlin.com>
In-Reply-To: <20250911-mathieu-frdm_imx93_fastboot-v1-1-c629d8b7c8cc@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 11 Sep 2025 16:43:09 -0300
X-Gm-Features: Ac12FXxECBy34y-Io-A52HMVUaAzCZmEow8OSfjXEUg2xQ6aqFIhSMJ2baJELrc
Message-ID: <CAOMZO5BeSWeUa7Ek=E0gAo0e4wzooseBsjKnkGSYZpMCx5fWgA@mail.gmail.com>
Subject: Re: [PATCH] imx93_frdm: Add support for flashing board with UUU
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
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

Hi Mathieu,

Thanks for your patch.

On Thu, Sep 11, 2025 at 10:35=E2=80=AFAM Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:

> +       if (get_boot_device() =3D=3D USB_BOOT) {
> +               printf("Detect USB boot. Will enter fastboot mode!\n");

Nitpick: printf("USB boot detected. Will enter fasboot mode\n");

> +fastboot_partition_alias_all=3D0:0
> +fastboot_partition_alias_bootloader=3D0.1
> +emmc_dev=3D0
> +sd_dev=3D0

emmc_dev and sd_dev are both 0. Is this expected?

> +CONFIG_USB_GADGET_VENDOR_NUM=3D0x1fc9
> +CONFIG_USB_GADGET_PRODUCT_NUM=3D0x0152

To keep consistency with other i.MX development boards, please use:

CONFIG_USB_GADGET_MANUFACTURER=3D"FSL"
CONFIG_USB_GADGET_VENDOR_NUM=3D0x0525

As done in configs/imx8mp_evk_defconfig, for example.
