Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF962F46C4E
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 17:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33414840ED;
	Mon,  6 Apr 2026 19:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ifYIcH4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E483283C2B; Mon,  6 Apr 2026 19:15:12 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA2568406D
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 19:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9b1ffbb9f5so467778866b.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 10:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775495710; cv=none;
 d=google.com; s=arc-20240605;
 b=Y/PD5D7mIlKQcXWiImdqDHN7Bfy/gCWfNjWImsGEkeoYIaMLGhWzdbjpQx9hE2CNSi
 mIULr2LKRNImYMMfTC2GxJG/50CX3DqTgy0EBF5oCOAS2SfWaiLQAnPTUD3gr055zBOn
 wte04utSi9/z9i3pdWlnfS0gIoemHvYBX6GdLHebRlY8OmsNjSL9K4/xrq9+lykoEl/R
 XBFpsYA/nQ++mX3SlNZl2XQqzGVBz+p3+foInzsvWg+n1Yq1kWmufSX4W/Vf6Q9w3v2Q
 F1wPYc0Ya8Pdlj/+jxRTlrSjKf0q/i7qFWOR5xaeTCugec2yyghCt8cqsrAqBYLmM/Eg
 nsqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uX8YXThYXM1ITzbl+ts/b1htryaW0fMgQIyruHIJGzM=;
 fh=ZqGy2reu3NCAtE35jrnoOTbkHg6uMbjpGsVHUHiZ6Dw=;
 b=MQAIUt3I12KWUKeWAgeMNJGXkqXn31AOb0jhb5xo2iMMRuhn2XGItWcqVK7iWCmz2K
 Cwbs7yJu/U5EtytvE7HIXJ0/B4DrgSb3BJWLaIslH4/RCEtLfRpcPkDgvnBnz3cYMpMu
 cUIMsuar4s5oq5UiuO7mhUg/9tS9bbr+eQDWFvu0/Ru2ddJoCJVHPyUC4T2G6LGkYZfg
 07HeRau3QkEBgcjt9hUpBJn90D2jkPMYifJyJ0SVNgNV7Mur4ffirgp8yXsVA0ppVBdt
 RKUKP0OZ5W8Kmh7JOEKgSnyGeKDF1R59QbgADvXGA5v7qIWVeM0sIu0tRKO3j2jyXXtX
 10Yw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775495710; x=1776100510; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uX8YXThYXM1ITzbl+ts/b1htryaW0fMgQIyruHIJGzM=;
 b=ifYIcH4alXk8D5HS94gT+74BJ1XtrYvzF4Sz5v5OcnwH8CtbFpLZ2+n8PWXxnSyGb6
 PZrjZXkG/NAzx7/D2eix4hgeFh3e+KpHJFiVYHQ4545PhCqbOSb3xCQ0i81D6y5UW5Nc
 Y6u5Sy7d04UHAhYZwFHqXJPJJDdY1IFsiNBYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775495710; x=1776100510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uX8YXThYXM1ITzbl+ts/b1htryaW0fMgQIyruHIJGzM=;
 b=aFD32SC4d4WhU8CF2YYKrW519TCcNugRlN4FjGsd3aRJn528v+7Xo7yQJ521nUzui5
 vK7BTPygbf95/+GmQ5J2S2C3BAFnl9d3A94l/Nlic1b9R0j9rte1asbu2pF8vQe4uBXU
 wgZR+P2nZgWZvS6jYBCKs75jZ8FRzjEFRQihJiVAPeQirm+vqmfSSUq/7q1G6v3S+apO
 Yfj6TECxa8g16I3suOLqi9YkHNy95xtqevssorWDg9LUBkY+38cBRbqPNPSzRplMa6Xr
 yh2okPCnrjYZNoLoEhxJqjtT3rZyHIfZaDY2grQp32f3XvefnedstvKOGJfJgL3PVm5z
 qu8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUTmraZ1FokhYcqluWcMPsJryvPanMmCH2BZ0S5djwt9fn7J/eIio+gqNfCDHSFwqllhcpH24=@lists.denx.de
X-Gm-Message-State: AOJu0YxHJ8nxWnIWN7Os9fMxlrojiP46vW9vLmuLryFj9mJ6H410HYce
 iLsJogBU1DMswWiskYYMqVQIzAlQYPv82vEB+/uxt/8tYwEHIXjJXZfzH7/9tSfYIONQBGuqhik
 YpunpqKcdU1v+GU2T+lE3oVOCcYVCPcidyW9zV/Ej
X-Gm-Gg: AeBDietB4+44Y0EhCWkpK6NihJUyhhRokibaXXszyyczHqwmT0oj26AejMO2yDH+DW4
 in8ZF0+WOY0iT3ev/QI5SMBIxBLRQtq9hm/QETCAAzjo0JSq52siFhEUB16ZmEtxkmeMXBdCbdD
 iCNkaM/AL+2TlUyqg/Nz85stCAOG05mLTVn83CO0r8juVqRYF1h11a+MJpy5CP1QfBnK2Taz45S
 6GbQUVGOYXiBv3211YS+x4UhDSeljgzDddav7te0+ajkL5DqWI0QOgMAHMiaCQdu5mUvZ75w3hc
 g9qN6g==
X-Received: by 2002:a17:907:c8c4:b0:b9c:648f:7d3c with SMTP id
 a640c23a62f3a-b9c679adca8mr692442866b.40.1775495710199; Mon, 06 Apr 2026
 10:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260403135205.26979-1-ansuelsmth@gmail.com>
 <20260403135205.26979-7-ansuelsmth@gmail.com>
In-Reply-To: <20260403135205.26979-7-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Apr 2026 11:14:58 -0600
X-Gm-Features: AQROBzDXkLD1liG2LdOzcr28X9U6pR6FXhAImlan9YtHDbwkCoJRg32DJ6jnuOY
Message-ID: <CAFLszThzN_d9_558hd4LymGAYSd+sk=2jUq4ypN0G_2+DJR8DQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] doc: dtbinding: Update documentation for Generic
 Firmware loader
To: ansuelsmth@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peng Fan <peng.fan@nxp.com>, Justin Klaassen <justin@tidylabs.net>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Harsha Vardhan V M <h-vm@ti.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Christian,

On 2026-04-03T13:51:57, Christian Marangi <ansuelsmth@gmail.com> wrote:
> doc: dtbinding: Update documentation for Generic Firmware loader
>
> Update documentation for Generic Firmware loader, generalize it from FS
> specific and add new property and example for FIP loader.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

> diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fw_loader.txt
> @@ -7,6 +7,8 @@ Required properties:
> +- mdtpart: which partition of ubi the image loading from, this property is
> +        required for ubi and mounting.

mtdpart

> diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fw_loader.txt
> @@ -12,6 +12,8 @@ Required properties:
> +- partoffset: valid ONLY for "u-boot,fip-loader". Offset of the partition to
> +           parse the FIP parition from.

partition

> diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fw_loader.txt
> @@ -1,9 +1,9 @@
>  Required properties:
>  --------------------
>
> -- compatible: should contain "u-boot,fs-loader"
> +- compatible: should contain "u-boot,fs-loader" or "u-boot,fip-loader"
> +- phandlepart: which block storage device and partition the image loading from,

The section says 'Required properties' but phandlepart, mtdpart and
ubivol are alternatives; only one set is required depending on the
storage type. Please can you clarify this.

> diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fw_loader.txt
> @@ -46,3 +48,12 @@ ubi in device tree source as shown in below:
> +     Example for FIP from eMMC:
> +     fs_loader4: fip-loader@4 {
> +             bootph-all;
> +             compatible = "u-boot,fip-loader";
> +             phandlepart = <&mmc0 0>;
> +             partoffset = <0x100>;
> +     };

Since the FIP loader supports UBI storage as well, it would be good to
add an example for FIP on UBI too.

Regards,
Simon
