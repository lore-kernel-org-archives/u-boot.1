Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2D8C98332
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3BA981095;
	Sun, 27 Sep 2026 15:06:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1hiecS8mw51E; Sun, 27 Sep 2026 15:06:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B014B8106A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521612;
	b=pUhPXmtyDcDWCoqHz6RhW+onvA6Clq6T2d8fewTiQMHPvjfRqPn+b7wC6qMJYnjsgVp5
	 yolCSkixGlOYUVxpsHvFhyIjefIDt4fDLHyPnk0dE7/xyvbwKWMOS1wqw2dW5S04DdzEH
	 tAaq9B0YeWt3J6iPi0Wirr0JUOtr//1sgS8DLtBGB3YwZK2ALTJRAba5KvFzOaYbQqX7r
	 x0I5yP6RVJRZfr3Jr06ieYe5sQGm7n+VB8IfYDvpolT986PiDkeGsjPYW3S9phCtgPlW/
	 W2yhufBahvpaf0jafFFLCo1QXJRHFM49of6ltcyAkzLVlVKaJpWIqpKfYydAfUhNLSg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790521612;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FkhFt6dV0P4QRR2t1UQdXR0HQV5tktDzr0rJfdquw5I=;
	b=qQtGbJItlTuXJ/QfTcPodAJqHI82NR6uHUNpDfaUFkjSJk2nISeQp6ZEBkk2fewIIZQY
	 vtNkuthopCcmKIDGO5hNS3w6/pNoSnZa5P/9TcdqvZ7zzui7sZlunY7BHjwuL0bhJEfQO
	 wzx8ndgHgu+TebMqtXbAfbRWoT8GCgWA6v2sG9djJZNNci1tBS/mubZmGD+tQbdqTQ+rI
	 didLyI0O4xsF/0Bn50S3sBk5leGrwCqBTiVNomt02/3YiLCLBj9bh0USAZMWb10Vevzqu
	 sQWIsx56PW6OCvmQ59JBhSFeMISfAaq/0lmFRBW7OjnQ11KXZV6QcHMuiwLDdvzaxrw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790521612;
	bh=FkhFt6dV0P4QRR2t1UQdXR0HQV5tktDzr0rJfdquw5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gpJ6l9F7i35RqCX3y23Dshj/RDQDHcaCR6J2V0WJp+nq9lQvMO49GhIwut+zot/5/
	 U9/jUMnckRgBPlK3mXNHfqUHPciXwlaAzKIACiHCTgtTLJZ6DFoT5pHwOGFLUWUHMK
	 S5LH/e4Djc2n5BCjLetlWSRxZWzEVHD0RDv1/MFb6gD97DAU/MxQLubyawoU9DfKMt
	 NrdI1QW3Bgnc0MRRw5EJc9GgB6lM0vQJais2mnNpym2fRJ593pLiMW46zq8djqUuFS
	 RbXz6wqFADDnA0sryAEOUXDmqw5kew8y21vWS7uOFFRf5Zg5ArhZmaJ5pHHZAd0MID
	 BMrKozDYSYf4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B014B8106A;
	Sun, 27 Sep 2026 15:06:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 21A494B8
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0753E40797
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:06:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n7YNA50MkyfU for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 15:06:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 01B8340740
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521611;
 b=oDs7oNUiat/ZGLoz2S+PJpXJn8Nw2fiK6JdnC8h8wPYfMw6zddOr792YJ+5FMQ2me30T
 vcXMEU+zXoIeVzW4+2aA6US+xtV0Bgm0e5us6NLKg/URWsKrJP0Mifmfi0DKBxFetFc1r
 g3P0nTXRioyupGLjEE/M4f99eHdZalzcHcratYVAUW27qjU4lr17ETy3/LrQC0LvI9f3q
 SN9ErpUDP5fgC9m4PEYqXlTnqO16doHGs5T0Xf2kiiH8VkM7b/D9qvogSmDl0IadzcDvs
 Ah0I9Ctj69J71PGlQY7JgA+n3d7Y5QUfMy3tTioYBYmHBmYRgaNl4H/IfzX8gYvwj4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790521611;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=FkhFt6dV0P4QRR2t1UQdXR0HQV5tktDzr0rJfdquw5I=;
 b=O9qflTbp0OGyqnsJOIVMuqGPCNYU3RG7nBJnhW0myvH5VO27+P2u2nIXOwZQagTx+yga
 szq7suMRKaQCOYmQOLqlpsWKmMzKDfuD/vuZ11cpFHy7SYBx6rcVzwOFhYG8RsDoRayDV
 ki7e1cO5y6QNyI9Y1p6Ahv5f3gKRoj5Vu41AEzxg2Xdgi9ijfegEOZGmiCUqimYXDtVnK
 VYo13aW0IxqJdV+jsVydYnSRYRtmspUlftUl270gIL9mR5KiRhu5+FlqP6izZ9f0MuJHP
 8sTheJEQxgdcPOhyB2yY9/n7ZAKICuqnrCvgvZ71rYojNkRuX+0A9oxgxftA0jjMGcA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Z1mqnA8H; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Z1mqnA8H
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01B8340740
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:06:50 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aae1f2cedfso2825302a12.3
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 08:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790521609; cv=none;
 d=google.com; s=arc-20260327;
 b=m3qPpj21Dr+BwlAoexIVh7jCphYmbJw/l7krzkKdDiBv5yeaFljeENnkpiHPljKRMq
 0CJq613mbjI3uSj2v8a5qnLbA+bqr+Ar/GTtX7enPLqBSHBWe+Ki+e0nBmMvvrJ7vjXY
 WZpZPwieSY54zMIeCjZxMOpfGwJTEJO2afxK87PucsHHK7UDD+GbWLQ5Hvye7tCsHgss
 pWC0i7oqDEvsjTa71ZuZtDqBT/8wXcFu+9od2TwtyxfYKWBTgt140a2h/Si72TH0phcQ
 f+yW3gHYgjiW6P0QUNxF+YUPQk+fL0NQ/vnT3M9pqm35DMWmTU+yQnddFHxT6mFZtWMz
 kjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FkhFt6dV0P4QRR2t1UQdXR0HQV5tktDzr0rJfdquw5I=;
 fh=E4uoYFbTYvp3SHUHNCCJljfMg/tukB+MVJZ9quBIJCM=;
 b=jX1UvwyJETxbg6GRC/Uygkuc1bUslgGPZ+rZ02o25fYqzUl45ddkvrCzv8rhA2w8hx
 FHqXznYMnsUacgilIdAq7Kn3gGwnvd7Xo/TYgzyxMnXulCrOzbYib4l5ekWilNPkkw/a
 QRG/2s+DJetMYO5+Kw1qjZaWQtc0xwbV6dKC1Kt04pBQl8Qw8lTJLHFaq29taH2qcrw/
 +szs7XvcXY1ci1QWRoV9r/Kyn5F8p6qr6EiqVw04lqk1y7w/w0+G6/h5qzHKPnZz9Uzy
 Ko+8sgvkdsWBM/G/Wq55t7g+gf5zLofzzznaW9QBCGvWLkC3WcPv8ciKuacFMFJJDbqO
 lsqg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790521609; x=1791126409;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FkhFt6dV0P4QRR2t1UQdXR0HQV5tktDzr0rJfdquw5I=;
 b=Z1mqnA8H0W6nzz+fN/Ql3/vY5oDbPhNZ6/I6829s5JXVttQX3LoB0QXrAKeQ9NO8M3
 Od38i6EITRbIKX/7dWuqQp5/c054NkOdqZgC/h5Lgq7AhpmanfU5DwJxFWjTLH7NYoEu
 pt+GhjZ26yv6YCwD7gNKv+pxxwiLDlAqYnYiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790521609; x=1791126409;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FkhFt6dV0P4QRR2t1UQdXR0HQV5tktDzr0rJfdquw5I=;
 b=xgTQlVLPeNCGC9YD8Mn+12dE9Yj30Bfw5XYTo++ji2Jj4kKdXSWykXEcajRYXDYh97
 eiT6h0EAivnvKr77G2T2nZ15QHBA+JjoozPeqOf/6zmQjoAPRiS/wF3l23y3k0e1fh/X
 7kGw9qjcOlzz2d+6cx5d61NId3+G/fagCoXp8Yzbo8daPg2X1zLHYloYEwKEJB01VlzG
 5rirozZEjbKIUNeT0o6iZtCEPxwBurj0rgz1/A518ZzB+yRsQfGjsZxejLrzQfJoQ1aK
 zo49z0MKkuJWHIFVorWoqY9WKyBFBCFAUSPOfwRPfbtwW8310d8TyiWtZcVP01IQHKda
 YHtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEfQ4kslqTV2e5B4DgQr8XwZckl006egYMlXnn+GZTaxnHPFDsJxjDXP88dm1f5wIG42Sa7+A=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIMhPERYDMC/K4XJtuYsBduEGjVfaB4QesvSY0LVo2dW+Yondns
 pgn+UEBJaKlfbBirOHjg05Un9tQo6zA4RfkY7Et5fhYnzq3HNzAgSyEblZRGBw/kJugBYPbY7gj
 w9MH8ij6MiuGmwd7IKnkxD2u7nDwRsnONd1qHHrF9
X-Gm-Gg: AYBFou1ThOL2Aeo7qPZAAAu0hhCA9jAtqsJpK7nYYkg1U8y5x4dgdR3Ga88YvgVA0Vr
 D98DVrlI4zjjssU6rluE/gwmU6qmi6mcWMsJJ7ZGzovzsuYB2bgSB5Fx1VO4KTEaJg+PAag+sJk
 59RTuZmdsgfq81AtMbZLuxha9xaBB0336x3oAH+1UMGRaZ1DHufv9mI7ZVs+A3qgmH5frnvOFM7
 HLYFzUMs0tCxwKYelIyHdT1PP99QqkO8Yv8M3RobHNxlNvyOpqONac5klS+2dlyJk+Kqq//nUZB
 cCAoWL9M9CjgB5zOsIIYY6FYxv6GIdYuI2tQDrLF0RsE0HBz+1B4mQ==
X-Received: by 2002:a05:6402:52d0:b0:6a9:b549:245e with SMTP id
 4fb4d7f45d1cf-6aac8f40768mr8222672a12.6.1790521608935; Sun, 27 Sep 2026
 08:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260925105432.0F27E68C4E@verein.lst.de>
 <20260925105627.70D9668C4E@verein.lst.de>
In-Reply-To: <20260925105627.70D9668C4E@verein.lst.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 09:06:36 -0600
X-Gm-Features: AclHuK--efYpJvqgjHXJE6-b0_RtuQfGhN2Uzzrr7yAKDrCXozbW6wUmnTI0NQU
Message-ID: <CAFLszTi7ubty_U1QArv399VxO-qj7h4_pQ9M_UW8YG9_-RrZsQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] mfd: add support for RPi5 RP1 chip MFD
To: duwe@lst.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Martin Schwan <m.schwan@phytec.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Anders Roxell <anders.roxell@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>, 
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, u-boot@lists.denx.de, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Torsten,

On 2026-09-25T10:54:32, Torsten Duwe <duwe@lst.de> wrote:
> mfd: add support for RPi5 RP1 chip MFD
>
> MFD base driver for the RP1 chip, similar to Linux'
> drivers/misc/rp1/rp1_pci.c
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Co-authored-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
>
> configs/rpi_arm64_defconfig   |   1 +
>  drivers/mfd/Kconfig           |  10 ++
>  drivers/mfd/Makefile          |   1 +
>  drivers/mfd/rp1.c             | 127 ++++++++++++++++++++++
>  include/dt-bindings/mfd/rp1.h | 239 ++++++++++++++++++++++++++++++++++++++++++
>  include/pci_ids.h             |   3 +
>  6 files changed, 381 insertions(+)

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> @@ -2,3 +2,13 @@ config MFD_ATMEL_SMC
> +config MFD_RP1
> +     tristate "RP1 MFD driver"
> +     depends on PCI
> +     help
> +       Support for the RP1 peripheral chip.
> +
> +       This driver provides support for the Raspberry Pi RP1 peripheral chip.
> +       It is responsible for enabling the Device Tree node once the PCIe endpoint
> +       has been configureds.

Please use 'bool' rather than 'tristate' - U-Boot does not build
loadable modules, and the surrounding entries are all bool. Also
'configureds' should be 'configured'.

> diff --git a/drivers/mfd/rp1.c b/drivers/mfd/rp1.c
> @@ -0,0 +1,127 @@
> +#define RP1_B0_CHIP_ID 0x10001927
> +#define RP1_C0_CHIP_ID 0x20001927
> +
> +#define RP1_PLATFORM_ASIC BIT(1)
> +#define RP1_PLATFORM_FPGA BIT(0)
> +
> +#define RP1_DRIVER_NAME "rp1"
> +
> +#define PCI_DEVICE_REV_RP1_C0 2

RP1_B0_CHIP_ID, RP1_PLATFORM_ASIC and PCI_DEVICE_REV_RP1_C0 are all
unused - please drop them, or actually use them (e.g. accept the B0
variant, or check the revision).

> diff --git a/drivers/mfd/rp1.c b/drivers/mfd/rp1.c
> @@ -0,0 +1,127 @@
> +static u32 rp1_reg_read(struct rp1_dev *rp1, unsigned int base_addr, u32 offset)
> +{
> +     resource_size_t phys = rp1_io_to_phys(rp1, base_addr);
> +     void __iomem *regblock = ioremap(phys, 0x1000);
> +     u32 value = readl(regblock + offset);
> +
> +     iounmap(regblock);
> +     return value;
> +}

Please map the BAR once in probe (store the virtual address in struct
rp1_dev) and just do readl() here. ioremap()/iounmap() around every
register access is unnecessary, and there is no check that ioremap()
succeeded before the readl().

> diff --git a/drivers/mfd/rp1.c b/drivers/mfd/rp1.c
> @@ -0,0 +1,127 @@
> +static int rp1_get_bar_region(struct udevice *dev, phys_addr_t *bar_start)
> +{
> +     *bar_start = (phys_addr_t)dm_pci_map_bar(dev, PCI_BASE_ADDRESS_1, 0, 0,
> +                     PCI_REGION_TYPE, PCI_REGION_MEM);
> +     return 0;
> +}

This wrapper adds nothing and always returns 0 without checking
whether dm_pci_map_bar() succeeded. Either fold it into rp1_probe()
and check the result, or make it return an actual error when the map
fails.

> diff --git a/drivers/mfd/rp1.c b/drivers/mfd/rp1.c
> @@ -0,0 +1,127 @@
> +     /*
> +      * HACK: Set bar address in the correct order.
> +      * Required for correct U-Boot operation.
> +      */
> +     dm_pci_write_config32(dev, PCI_BASE_ADDRESS_1, 0);
> +     dm_pci_write_config32(dev, PCI_BASE_ADDRESS_0, 0x40000);

A driver shouldn't need to poke BARs by hand - the PCI core is meant
to assign them. Please explain in the comment (and in the commit
message) why auto-assignment does the wrong thing here, and whether
the underlying issue in the PCI core / RC driver can be fixed instead
of open-coding it. 'HACK' with no reference to the root cause makes it
hard for something to understand / fix this later.

> diff --git a/drivers/mfd/rp1.c b/drivers/mfd/rp1.c
> @@ -0,0 +1,127 @@
> +static int rp1_pcie_read_config(const struct udevice *bus, pci_dev_t bdf,
> +                             uint offset, ulong *valuep, enum pci_size_t size)
> +{
> +     /*
> +      * Leaving this call because pci subsystem calls for read_config
> +      * and produces error then this callback is not set.
> +      * Just return 0 here.s
> +      */
> +     *valuep = 0;
> +     return 0;
> +}

A leaf UCLASS_PCI_GENERIC device shouldn't need dm_pci_ops at all -
those are for PCI controllers. If the core is complaining, that looks
like a real bug in the PCI uclass rather than something to paper over
with a stub that silently returns 0 for every config read. Please
investigate and fix the root cause. Also: typo 'here.s', and 'then'
should be 'when'.

> diff --git a/drivers/mfd/rp1.c b/drivers/mfd/rp1.c
> @@ -0,0 +1,127 @@
> +static int rp1_bind(struct udevice *dev)
> +{
> +     device_set_name(dev, RP1_DRIVER_NAME);
> +     return 0;
> +}

Is renaming the device really needed? The bound name normally comes
from the driver / DT node, and having every RP1 instance use the fixed
string 'rp1' will collide if more than one is ever probed. If this is
only cosmetic, please drop the bind hook.

> diff --git a/include/dt-bindings/mfd/rp1.h b/include/dt-bindings/mfd/rp1.h
> @@ -0,0 +1,239 @@
> +/*
> + * This header provides constants for the PY MFD.
> + *
> + * Copyright (c) 2024 EPAM Systems
> + *
> + * Derived from linux rp1.h.
> + */

How about 'RP1 MFD' instead of 'PY MFD' ?

> diff --git a/include/pci_ids.h b/include/pci_ids.h
> @@ -2555,6 +2555,9 @@
> +#define PCI_VENDOR_ID_RPI            0x1de4
> +#define PCI_DEVICE_ID_RPI_RP1_C0             0x0001

The extra tab on PCI_DEVICE_ID_RPI_RP1_C0 misaligns it with the
surrounding block - please drop it.

Tested-by: Simon Glass <sjg@chromium.org>  # rpi5

Regards,
Simon
