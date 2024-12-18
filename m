Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6E9E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 09:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 759C78027E;
	Wed, 18 Dec 2024 10:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GSz4ur5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C965680288; Wed, 18 Dec 2024 10:43:10 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4459780269
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 10:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so3153191f8f.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 01:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734514988; x=1735119788;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YBMUD3tHxkzUi8je7A3HxWe9uOLlDfXFFhOk9zuFDG8=;
 b=GSz4ur5y7HkpHb+06PV6ByXxq0dEoxQZ6NIfTsnnEUv928bxbfjAEPNFc/o8YTcMxm
 9cWA4596lhGH9q8wQngK4YbJS8wooHJgGcLhxiDpnutHKK2W7ZiFNNWuprVv6Vjxsk+l
 dlh/i3QNIM/KdvCQvOzksS8vsZy7UhN43IOK2rZ44U1Ob6tv7+Ij96li5rGwWYgI/Z3c
 rnBWt9hj/SNp6r/0QlppasLQEcLmamlMMBlAO0wHM4ti4edsxodaBQGs6+aZcCdxzIDL
 eNQR5BWz8uMXSJsPGvSEMX+FZS0HYBu/rjilro0+ECLxtcxRCMW9qmJtDbZV7DQT3bjo
 qBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734514988; x=1735119788;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YBMUD3tHxkzUi8je7A3HxWe9uOLlDfXFFhOk9zuFDG8=;
 b=ZaKXyADyRIfpJ8jatpyKhy7oYtjz8c0ZLDH0nyZLEFsmCFC4JKP8BNlvboudkD27iL
 Vpv7zPc+r4BjctFYqenzx71w6X47yHXc0I2/+cV/keiAaaAabOwgTLwgGxbbFPOoLKyv
 FjsH+yhLDS9eI1rw0Q+QdNxbVG1FVcRQr4dPTlBwLEE3vKWUIiMP7wiC9GEw3+QW0lw4
 yqXzuJ/IJWroHqXsCRIK9MtnN8/EjwcVv3mBksm/zdbiFMNsflTtuQ1RVQUo4H5an3ho
 3t4j97psqp8y9KU25U00LBu5hyq0rwcRnsGHUDso8iYHK3pYsJS96xSePfd1W4cK9mYY
 izvQ==
X-Gm-Message-State: AOJu0Yz39RIczfsgitUik4l9OXVwCLGhSEyZT/WwpNWAYNYqe9LFeztc
 UDXcbw0rouMHDz/DJ+LOQ9oG2KuNbGgLg8MBjyfsAfHwkjO6a6LYNOp/Q7lgXIg=
X-Gm-Gg: ASbGncsQBIKcpYJGjjkj5wacQ3OLhhaYHbTaVcofQk5xA4nHoltkA4xRAVmpexoXaC2
 9UYvqC0kcELUd1XqGMnhor5FXqIm3DBySORls1E13yAvK4YpUT/AkQEP1+Xdasu4dxpDmEs4FxD
 EKd6J/0DPRBSxQUCVlV8sQnCp2pfuaWT9Oj8szSHr2finwJEBVR+p3FW/YajzkG/XRsi0nRvwcz
 iur0pn5vTJdGhocTFigPBv5HzsaYRfOdfKqtVxNQNAPxdXUiBh7xeUMz2BcOVzXug==
X-Google-Smtp-Source: AGHT+IGxjYA2PhV7kakBIMoL149virTwIltYTiwkaoJjv5iormYSh/Tiqm1Z2LS7JH6SfEeQvdfiaQ==
X-Received: by 2002:a05:6000:4a03:b0:385:fc97:9c76 with SMTP id
 ffacd0b85a97d-388e4d4a25cmr2195445f8f.3.1734514987611; 
 Wed, 18 Dec 2024 01:43:07 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801233asm13928504f8f.9.2024.12.18.01.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 01:43:06 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, lukma@denx.de, n-francis@ti.com, afd@ti.com,
 glaroque@baylibre.com, sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 rogerq@kernel.org, nm@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH 0/4] Add support for USB DFU boot on AM62Px
In-Reply-To: <20241217131658.2920799-1-s-vadapalli@ti.com>
References: <20241217131658.2920799-1-s-vadapalli@ti.com>
Date: Wed, 18 Dec 2024 10:43:05 +0100
Message-ID: <871py5xr6e.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Siddharth,

Thank you for the series.

On mar., d=C3=A9c. 17, 2024 at 18:46, Siddharth Vadapalli <s-vadapalli@ti.c=
om> wrote:

> Hello,
>
> This series add support for USB DFU boot on TI's AM62Px SoC which has
> two instances of USB Controllers, of which the USB0 instance of USB
> which is a DWC3 USB Controller is used for USB DFU Boot:
> ROM =3D> tiboot3.bin =3D> tispl.bin =3D> u-boot.img
>
> The first patch of this series is based on the suggestion of
> Jonathan Humphreys <j-humpreys@ti.com>
> at:
> https://patchwork.ozlabs.org/project/uboot/cover/20241124070828.617558-1-=
s-vadapalli@ti.com/#3419733
> which prevents overwriting the "dfu_alt_info" environment variable which
> is set by "spl_dfu_cmd()" for USB DFU boot.
>
> The second patch adds USB DFU environment for AM62Px.
>
> The third patch extends "am62x_r5_usbdfu.config" config fragment for
> being re-used by AM62Px SoC by dropping configs which aren't required
> for USB DFU boot. This is necessary to reduce the size of R5 SPL
> (tiboot3.bin) built for USB DFU boot.
>
> The fourth patch enables USB device-tree nodes for USB DFU functionality
> on AM62Px. Since CONFIG_OF_UPSTREAM is not yet supported for AM62Px, the
> changes are being made in arch/arm/dts/k3-am62p5-sk-u-boot.dtsi at the
> moment, with the intent of making the same changes in the Linux
> device-tree and eventually enabling CONFIG_OF_UPSTREAM to drop the
> changes made in "k3-am62p5-sk-u-boot.dtsi".
>
> Series is based on commit
> 3b3c7280b82 smbios: address build warning
> of the next branch of U-Boot.
>
> The USB DFU config fragments for AM62x are to be re-used for enabling
> USB DFU boot on AM62Px as follows:
> R5  =3D> am62px_evm_r5_defconfig + am62x_r5_usbdfu.config
> A53 =3D> am62px_evm_a53_defconfig + am62x_a53_usbdfu.config
>
> Series has been tested on AM62P5-SK. Logs validating USB DFU boot on
> AM62P5-SK with this series:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/50198ee3348c2db73e0dbd3=
a14cb0f8b
>
> Series has also been validated on AM625-SK to ensure that the changes
> made to "am62x_r5_usbdfu.config" config fragment being used by AM625-SK
> for USB DFU boot do not cause a regression on AM625-SK w.r.t. USB DFU
> boot. Logs validating USB DFU Boot on AM625-SK with this series:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/85a7579ed2c95330ac71ee3=
a832cadfb
>
> Regards,
> Siddharth.
>
> Jonathan Humphreys (1):
>   dfu: do not overwrite "dfu_alt_info"
>
> Siddharth Vadapalli (3):
>   board: ti: am62px: env: include environment for DFU Boot
>   configs: am62x_r5_usbdfu: extend for AM62Px
>   arm: dts: k3-am62p5-sk-u-boot: enable USB0 for USB DFU boot

Boot tested this on AM62Px SK EVM using snagrecover:

Boot logs are here: https://paste.debian.net/1340377/

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
>  arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 10 ++++++++++
>  board/ti/am62px/am62px.env            |  5 +++--
>  configs/am62x_r5_usbdfu.config        |  3 +++
>  drivers/dfu/dfu.c                     |  7 +++++--
>  4 files changed, 21 insertions(+), 4 deletions(-)
>
> --=20
> 2.43.0
