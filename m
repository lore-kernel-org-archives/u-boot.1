Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0D1EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FE698647F;
	Tue, 22 Aug 2023 18:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="qZZZayeY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BAA48645B; Tue, 22 Aug 2023 18:10:26 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA30C8647F
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fee51329feso20099825e9.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692720623; x=1693325423; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9lGvyDZtk6OrxLBgBfn5TC1eerCpvtWWQ3bqOUchbtY=;
 b=qZZZayeY4/jPGrxnwB5mfusRFUMZEX62bBcJrJuIPjHMPSZHSLAuoYwOV7URzNxseA
 QieQo96Y32XcW9WtoG7nRXMrEwj17rCVEMzTQeGzsZ31XIfhOdsEbxFKAxa7Mc6rIZMZ
 nJKKDr5RQJuJVRsNHqz97b5mgc7W5GvPkJzacOytroUblpQrPEH4u6cXY7UyQqi6B+R6
 jk18HWwg2yg0aUJdIl+FwF78aHuYmvzEsYmx9GFFqRNrtMzgps+aMLrg3U0jm0d+JMWc
 vxuc72I/BUeZwZcjhI1uNY7h1D2PbuujLP4bc+0eK7n2hxtNlROfeVPkGS8o2Dx5N/FA
 ly5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692720623; x=1693325423;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9lGvyDZtk6OrxLBgBfn5TC1eerCpvtWWQ3bqOUchbtY=;
 b=VFF4339OiW8yGQ3nUZNWWViJ+Pf7JX8Zdgiin4KuGZmQQah7QwjyETqh/00OnnTAJ3
 Gw5dJwlD7pf/2uDV3hy+xaF8FgFuFE4oOlIj6GCJrSsCWrJI+Uwpc0KSy7hql9TNk3Ot
 n+3mJ16XbzPa/K2Ga4g1PIJum0fMJ4On+C9lYAUqUxHpsUgIMzhnbFWFTqm7kZYTIDUs
 7vlIIZdldLlLTzBOX9FN3WqDGYYH4yjahM6v2rvItXzk8iu1aepUob2KM8/OcvLBTtDD
 iv5xx9sM3boyYIJqi0kTVBzUKPQIqNrxN0vudlBddWy4C3UHbHmPIH9Lq8mTRQXV6FyN
 sgQg==
X-Gm-Message-State: AOJu0YwJoAx0SrxBnq/e46fkMeoyzBMionA4nR9ZjmnOwS65XvZTK+t9
 otWY4Xiqzb1hk8Y6P+z6K8V/Zw==
X-Google-Smtp-Source: AGHT+IE1k/G8/Fl0QckUVPVJKVP+ZvrJ1yLtZ/yEdZdMB9mw7Cs1bHZl5CNb2OCV0st7a/olV2yJKw==
X-Received: by 2002:a05:600c:8516:b0:3fe:b7e4:276a with SMTP id
 gw22-20020a05600c851600b003feb7e4276amr7828683wmb.15.1692720623287; 
 Tue, 22 Aug 2023 09:10:23 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 k9-20020adff289000000b003179d5aee67sm14620855wro.94.2023.08.22.09.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 09:10:22 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angus Ainslie <angus@akkea.ca>, Dmitrii
 Merkurev <dimorinny@google.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, Stefan Roese
 <sr@denx.de>, kernel@puri.sm
Subject: Re: [PATCH 03/17] configs: sandbox: Enable DM_USB_GADGET
In-Reply-To: <20230819142407.49632-3-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
 <20230819142407.49632-3-marex@denx.de>
Date: Tue, 22 Aug 2023 18:10:22 +0200
Message-ID: <87h6orrrbl.fsf@baylibre.com>
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

On sam., ao=C3=BBt 19, 2023 at 16:23, Marek Vasut <marex@denx.de> wrote:

> Switch sandbox to DM_USB_GADGET, DM is the future.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Angus Ainslie <angus@akkea.ca>
> Cc: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Eddie Cai <eddie.cai.linux@gmail.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: kernel@puri.sm
> ---
>  configs/sandbox64_defconfig        | 1 +
>  configs/sandbox_defconfig          | 1 +
>  configs/sandbox_flattree_defconfig | 1 +
>  configs/sandbox_noinst_defconfig   | 1 +
>  configs/sandbox_spl_defconfig      | 1 +
>  configs/sandbox_vpl_defconfig      | 1 +
>  6 files changed, 6 insertions(+)

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
> index 69e5efe8748..72452695cdc 100644
> --- a/configs/sandbox64_defconfig
> +++ b/configs/sandbox64_defconfig
> @@ -230,6 +230,7 @@ CONFIG_TIMER=3Dy
>  CONFIG_TIMER_EARLY=3Dy
>  CONFIG_SANDBOX_TIMER=3Dy
>  CONFIG_USB=3Dy
> +CONFIG_DM_USB_GADGET=3Dy
>  CONFIG_USB_EMUL=3Dy
>  CONFIG_USB_KEYBOARD=3Dy
>  CONFIG_VIDEO=3Dy
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 1cd1c2ed7cd..9f8b81f5fe6 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -298,6 +298,7 @@ CONFIG_TIMER=3Dy
>  CONFIG_TIMER_EARLY=3Dy
>  CONFIG_SANDBOX_TIMER=3Dy
>  CONFIG_USB=3Dy
> +CONFIG_DM_USB_GADGET=3Dy
>  CONFIG_USB_EMUL=3Dy
>  CONFIG_USB_KEYBOARD=3Dy
>  CONFIG_USB_GADGET=3Dy
> diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattre=
e_defconfig
> index 8aa295686dc..cedae60d3cf 100644
> --- a/configs/sandbox_flattree_defconfig
> +++ b/configs/sandbox_flattree_defconfig
> @@ -204,6 +204,7 @@ CONFIG_TIMER=3Dy
>  CONFIG_TIMER_EARLY=3Dy
>  CONFIG_SANDBOX_TIMER=3Dy
>  CONFIG_USB=3Dy
> +CONFIG_DM_USB_GADGET=3Dy
>  CONFIG_USB_EMUL=3Dy
>  CONFIG_USB_KEYBOARD=3Dy
>  CONFIG_VIDEO=3Dy
> diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_de=
fconfig
> index 2c6aab6c859..360686b9682 100644
> --- a/configs/sandbox_noinst_defconfig
> +++ b/configs/sandbox_noinst_defconfig
> @@ -218,6 +218,7 @@ CONFIG_TIMER=3Dy
>  CONFIG_TIMER_EARLY=3Dy
>  CONFIG_SANDBOX_TIMER=3Dy
>  CONFIG_USB=3Dy
> +CONFIG_DM_USB_GADGET=3Dy
>  CONFIG_USB_EMUL=3Dy
>  CONFIG_USB_KEYBOARD=3Dy
>  CONFIG_VIDEO=3Dy
> diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
> index 8d50162b274..bc79adfcd8f 100644
> --- a/configs/sandbox_spl_defconfig
> +++ b/configs/sandbox_spl_defconfig
> @@ -224,6 +224,7 @@ CONFIG_TIMER=3Dy
>  CONFIG_TIMER_EARLY=3Dy
>  CONFIG_SANDBOX_TIMER=3Dy
>  CONFIG_USB=3Dy
> +CONFIG_DM_USB_GADGET=3Dy
>  CONFIG_USB_EMUL=3Dy
>  CONFIG_USB_KEYBOARD=3Dy
>  CONFIG_VIDEO=3Dy
> diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
> index f3a0fd19a96..2c817b3847d 100644
> --- a/configs/sandbox_vpl_defconfig
> +++ b/configs/sandbox_vpl_defconfig
> @@ -237,6 +237,7 @@ CONFIG_VPL_TIMER=3Dy
>  CONFIG_TIMER_EARLY=3Dy
>  CONFIG_SANDBOX_TIMER=3Dy
>  CONFIG_USB=3Dy
> +CONFIG_DM_USB_GADGET=3Dy
>  CONFIG_USB_EMUL=3Dy
>  CONFIG_USB_KEYBOARD=3Dy
>  CONFIG_VIDEO=3Dy
> --=20
> 2.40.1
