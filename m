Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CFAC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 10:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B5887885;
	Tue,  5 Dec 2023 11:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BuF7dVr8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21F4086F26; Tue,  5 Dec 2023 11:39:29 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 918B487885
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 11:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40c0fc1cf3dso9823955e9.0
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 02:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701772766; x=1702377566;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mrl1xUq1dGHGOMTdzELPLYQWY0njVjwL7aVzgw0xmU4=;
 b=BuF7dVr8ADQ7AmYDheFGd1Y8jjcnyjU4XWgtALAMx/4LJr9bwK+bvHohHKFkPTrDia
 WptzhCgcgMlSF4nAF55ao4L5xPktArfNqItVds4iH4J+GgJxdqNoc/VeI+NDE4MT/Kub
 3gzsupuJNAvyMzTxVBAEV8ZdwOWlmZAnZo3WQBCL4BGdKoJ+qKY/Z7rSjaFQ7m0cNSLv
 +OBuTmnCLCPnJyX2sF76uQmTWi/J60ziqBVxkPGFnEHO6jXQRHlfRGK65qDr+4nUHEt3
 jVYgDTZ3LdvY4kZnPMoq4B2iYuUgIaZgVu4dFb9Cq5DSqWZ/PoHAtK6CEGq0D7lKsEf1
 CzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701772766; x=1702377566;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrl1xUq1dGHGOMTdzELPLYQWY0njVjwL7aVzgw0xmU4=;
 b=OmL23hBJspAp4OjJ/A1SNWLC5/s+jyP3gKYJIrtC79YAX0ObqYgOoya8SzT/hv/FYi
 azY0XiN4RQHX2/sGMFT38P4Xwbyxx/VEUZTG8YVlNp4NbWpqqV2fQTIf2fTA67VDnBnN
 olBQKv9E3nxk6a2/J0Dhr9VfaOaIvHB4tJFwhae4knk40TGYxoKhFypjhLJP1Em/YIgO
 Fw60iXc+2cr4iGLcPKJGyvGsfcrhy5GTujMkR3XtSeIbKR/9tE6UOyFoxdU2d7+2rsZ9
 sIurtPpl+RdrelEVIA80BAJhaT2HQzmls3oHGQI92zDlXc11CmW7nxVcjgqscjaOnBX7
 +HfA==
X-Gm-Message-State: AOJu0YzcQuJ11a4/RlidneEoiMK5eaCtwdA8l96UknFCLosGJ+IPkwBJ
 /fVraWduc3I81TOdTHNWnV9V5g==
X-Google-Smtp-Source: AGHT+IEJck/3+eUMY1fnwRBQ//Hycm5w5d4dkueDfgdOdW0uhr5MkvNvIYDkgxJHhQ3bdzmsNh4/jA==
X-Received: by 2002:a05:600c:33aa:b0:40c:d1d:781c with SMTP id
 o42-20020a05600c33aa00b0040c0d1d781cmr345535wmp.138.1701772766052; 
 Tue, 05 Dec 2023 02:39:26 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 d7-20020a05600c3ac700b0040b632f31d2sm13227023wms.5.2023.12.05.02.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 02:39:25 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Chunfeng
 Yun <chunfeng.yun@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Sean Anderson <seanga2@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Vitor Sato Eschholz <vsatoes@baylibre.com>
Subject: Re: [PATCH 3/6] dt-bindings: power: add power-domain header for
 MediaTek MT8365 SoC
In-Reply-To: <87leaa450q.fsf@baylibre.com>
References: <87plzm450u.fsf@baylibre.com> <87leaa450q.fsf@baylibre.com>
Date: Tue, 05 Dec 2023 11:39:24 +0100
Message-ID: <87cyvlylur.fsf@baylibre.com>
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

Hi Julien,

Thank you for your patch.

On lun., d=C3=A9c. 04, 2023 at 11:48, Julien Masson <jmasson@baylibre.com> =
wrote:

> Add power-domain header for MediaTek MT8365 SoC copied from Linux
> source code tag v6.7-rc2.
> (commit a1571f1f333c2fced076f0d54ed771d1838d827f)
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  MAINTAINERS                                   |  1 +
>  .../dt-bindings/power/mediatek,mt8365-power.h | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ec5311c8a2..3b13f26e76 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -412,6 +412,7 @@ F:	drivers/net/mtk_eth.c
>  F:	drivers/net/mtk_eth.h
>  F:	drivers/reset/reset-mediatek.c
>  F:	include/dt-bindings/clock/mediatek,*
> +F:	include/dt-bindings/power/mediatek,*
>  F:	tools/mtk_image.c
>  F:	tools/mtk_image.h
>  F:	tools/mtk_nand_headers.c
> diff --git a/include/dt-bindings/power/mediatek,mt8365-power.h b/include/=
dt-bindings/power/mediatek,mt8365-power.h
> new file mode 100644
> index 0000000000..e6cfd0ec78
> --- /dev/null
> +++ b/include/dt-bindings/power/mediatek,mt8365-power.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_MT8365_POWER_H
> +#define _DT_BINDINGS_POWER_MT8365_POWER_H
> +
> +#define MT8365_POWER_DOMAIN_MM		0
> +#define MT8365_POWER_DOMAIN_CONN	1
> +#define MT8365_POWER_DOMAIN_MFG		2
> +#define MT8365_POWER_DOMAIN_AUDIO	3
> +#define MT8365_POWER_DOMAIN_CAM		4
> +#define MT8365_POWER_DOMAIN_DSP		5
> +#define MT8365_POWER_DOMAIN_VDEC	6
> +#define MT8365_POWER_DOMAIN_VENC	7
> +#define MT8365_POWER_DOMAIN_APU		8
> +
> +#endif /* _DT_BINDINGS_POWER_MT8365_POWER_H */
> --=20
> 2.43.0
