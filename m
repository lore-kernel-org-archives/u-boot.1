Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FECEC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 08:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9895880283;
	Thu, 16 Jan 2025 09:38:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B8uWIIqK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0784F80283; Thu, 16 Jan 2025 09:38:47 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E676480214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 09:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3863494591bso323604f8f.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 00:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737016724; x=1737621524;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qj/fleoYIpP78E2bzIzIkfjJAaursYibbygR531doaE=;
 b=B8uWIIqKPhRTBHxMRIeu/S4iH0aS7kcRtBx7mRfKiWkYV1e+jmy+zX0pwZChX2i0zs
 FEhi3RY64caiw7oDO6SVtyAjh2N4TbnNXqLc1Y2DT/QWlQ9vFflLpXZZ/X8fDj2oRJgJ
 iLS1e29VS6vLSzhI3xVpMAKsqBLpiC6gEZXrnZBCx9w76vpvmHsCUdKw7kPnQmKW7RYZ
 Bfu0d8BNzkqQhktEf9Hx9I95yWzbCpvse81CiqyJmSOoehOqZtRHfQ8yjXaHSXOlvttH
 uyHvyPx3Qc2kUbxjTupC5Y6VJb2j1AIpKbJsF8PdYMAa1SgLIt55f3ZYPOga5JEVuXLj
 cCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737016724; x=1737621524;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qj/fleoYIpP78E2bzIzIkfjJAaursYibbygR531doaE=;
 b=ArKLZkj2q/SDudMqHm61PIaGy+cdUYt36HwMsXDA8XjjB/rhWHh+XBcv5brRPpLr2S
 mntXbVMeqLJqa0ek09V8rKMBrmh7+OFPfHr9HIBJ+gnlGPIUGP7dw6TbzyzE8oyDRJhi
 Bys+ldPW+IecrS00V3lYItQ7OY3BXJuA/A28ib3MgKe3+fjRU1dheviTJHwlpMPekjdj
 PfBE1yt8ciPvdm72QqFuzJhgdAROZeJLOJchRGYi2ZUvCt9Bou+RS19f0/f6C7T4n5yU
 jEWVMPBSiNtMAP/q7kCqYUn3OTnP8hY8WRz1a3WwjmPk0o9gZnf49XuRfoyCGvgNlqcf
 nGXw==
X-Gm-Message-State: AOJu0YzHk3YlLfFdSqK07e/qnntWmRz123zBSoOQBLlIdcI0bkm5qekO
 lfBz/bXf1eEnO4M1l5Zcd6MF++kcZnQG+r3MFzTibsWScTuqPGfm8SP9SwP3MTc=
X-Gm-Gg: ASbGncum9EISOcy62nvFTY2NvxbLPD2a+OrBPv5dzsxoImSiG2WzK7HpzYffVgguCad
 LHF3BddEujyskHL01UExPV0/iEh5erahmuHbu7VqpBmPrXpB+tstYbCAW2uwcJPeNk8uj55dc8/
 40D7pu/2/M8eY0VkYd6n1Xo+ksVSJuw+Ft+NnBaktoEEm8ujjG5HYz9bx//yn+OWf0RZJKQaMTk
 xoxns/7JqgLKpBSnwLRgp4QWdsA5SjFnOXGcVadPumAnUAbscBWr1LbWjsDek6bmA==
X-Google-Smtp-Source: AGHT+IE5tYetfEROqtaPaoUpxft7duMl/bAMdLvWobh77TbhmYAAAFPFMDs6FGdKn0cZlpF/zCj6qg==
X-Received: by 2002:a5d:47c5:0:b0:38b:ed6f:f012 with SMTP id
 ffacd0b85a97d-38bed6ff247mr1324998f8f.9.1737016724380; 
 Thu, 16 Jan 2025 00:38:44 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b81ccsm20093559f8f.65.2025.01.16.00.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 00:38:43 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jonathan Humphreys <j-humphreys@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Jonathan Humphreys <j-humphreys@ti.com>, Martyn Welch
 <martyn.welch@collabora.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Sjoerd Simons <sjoerd@collabora.com>, Tom Rini <trini@konsulko.com>,
 vigneshr@ti.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] configs: am62x_evm_*: Set DFU buffer size to 256k
In-Reply-To: <20241220215334.372542-1-j-humphreys@ti.com>
References: <20241220215334.372542-1-j-humphreys@ti.com>
Date: Thu, 16 Jan 2025 09:38:43 +0100
Message-ID: <87r053886k.fsf@baylibre.com>
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

Hi John,

Thank you for the patch.

On ven., d=C3=A9c. 20, 2024 at 15:53, Jonathan Humphreys <j-humphreys@ti.co=
m> wrote:

> OSPI flash writing was broken on am62x SKs as the OSPI flash device has a
> 256k sector size but was set to 20k. This breaks OSPI flash writes because
> the current implementation of the SF DFU backend requires that the DFU da=
ta
> buffer size be the same as the sector erase size, and the USB DFU config
> fragment (for both A53 and R5) reduced the size of the DFU data buffer,
> presumably so that it can fit into SPL's much smaller heap.
>
> Change the SYS_DFU_DATA_BUF_SIZE to the erase sector size, which still fi=
ts
> within the post-relocation heap size in SPL.
>
> Fixes: dfc2dff5a844 ("configs: am62x_evm_*: Enable USB and DFU support")
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  configs/am62x_a53_usbdfu.config | 2 +-
>  configs/am62x_r5_usbdfu.config  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/configs/am62x_a53_usbdfu.config b/configs/am62x_a53_usbdfu.c=
onfig
> index 0d3c6df1e73..812f99ee70b 100644
> --- a/configs/am62x_a53_usbdfu.config
> +++ b/configs/am62x_a53_usbdfu.config
> @@ -10,7 +10,7 @@ CONFIG_SYSCON=3Dy
>  CONFIG_SPL_SYSCON=3Dy
>  CONFIG_DFU_MMC=3Dy
>  CONFIG_DFU_RAM=3Dy
> -CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x5000
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x40000
>  CONFIG_SYS_DFU_MAX_FILE_SIZE=3D0x800000
>  CONFIG_USB=3Dy
>  CONFIG_DM_USB_GADGET=3Dy
> diff --git a/configs/am62x_r5_usbdfu.config b/configs/am62x_r5_usbdfu.con=
fig
> index 772bb2ab935..efaae504c1a 100644
> --- a/configs/am62x_r5_usbdfu.config
> +++ b/configs/am62x_r5_usbdfu.config
> @@ -1,7 +1,7 @@
>  CONFIG_SPL_ENV_SUPPORT=3Dy
>  CONFIG_SYSCON=3Dy
>  CONFIG_SPL_SYSCON=3Dy
> -CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x5000
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=3D0x40000
>  CONFIG_MISC=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_DM_USB_GADGET=3Dy
> --=20
> 2.34.1
