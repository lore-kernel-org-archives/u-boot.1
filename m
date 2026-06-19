Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B8BCD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 12:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C8FF84A12;
	Fri, 19 Jun 2026 14:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WdkSLuQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2967184A1C; Fri, 19 Jun 2026 14:47:04 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86CDC8005D
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 14:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2bf22d29dabso13177255ad.2
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 05:46:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781873216; cv=none;
 d=google.com; s=arc-20240605;
 b=drpbMB72Gy2Nsw0dMMJJLunzEDZxhde+PbTVZWH9wlj1kiS+q4Q4MRmq/ivAMpdhN9
 0ddGmoYUXrGoRasJbbfi+NfEYgOs1J9UI6uQB72LyR+6wrk0i8NiI8qDZpzB4xyz8p27
 LN07sxrijDzhcWrz3SNOgBQ2w2tFDZt+vVSin+PsT1L+yffJLW6WepaQ05zx8wB7Mk21
 xn3icGw73kxiBBeEPTD2q4T0pGWTALPZVJ2yWo0KytsqTqWC9ns9LB+coHkjYmggDdnK
 0m8CuwSqKD0F6jpj3WTJMStgeSRPA/6P1sDVfqV0msrjGMJYbwnEv9NvnRH5/iIBU4vl
 15wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GEycztTv8ukGT/wEDu9Qq+3i5V/m0Hwi7WldIq/BoyU=;
 fh=y7o2TCmmFfsuyzoRhzA8JmBDqQfKr374S1By4hpjEaA=;
 b=UExdU6IWtN4hb+v/xgYh7JACd18oYm2gbIpGP5FyR1jwy5ewIeADPpZ2I3DmVV6iFE
 9XVvEBag5Iqr7OYIXgVF5Exg5jbA97gQ16adengC7RuAaN1Ru5rzRdNLgwr2J06AIgwc
 3czvBi/gP9HQGms/fSIbw3bWvO33XTEIKsI6IBH4Yj+PNrIL3S8zUi1vYoaLBVj0Nr+Y
 fnvvSUOtw82EV7Z2zVywgV0fUm/Z5+QhI1sIsa5yiJkOochJutAyTgOmsGSj+cvpmyYL
 B/xNSSfEzqpNk5zUsbszQ7GTx7lnMpXp3mN8+JOdP99Cwoz79nQmN0k20ysuuAAudd80
 3LLQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781873216; x=1782478016; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GEycztTv8ukGT/wEDu9Qq+3i5V/m0Hwi7WldIq/BoyU=;
 b=WdkSLuQ9klOCIiQO1yerMtgPsGjZrW3q/Uv9HhoqXFX2caUs1An35W/jgmPzdrQVpe
 xE9h4knjI6r+yiyngbuKjRWyWIVe38w6tSRwjvCw6qa1BDRRpFJYe9DrGMLqtEBAt6W6
 oyMC6JdPJk7g46DxZtJqa7eXvRh4dwAmGLYe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781873216; x=1782478016;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GEycztTv8ukGT/wEDu9Qq+3i5V/m0Hwi7WldIq/BoyU=;
 b=SXP8w5ABx3uum8TF+1pERHVG2zedrogys50Te37V5n+YMQlZZqJ97prU8HR95qbzzU
 X4EzSjrVNnMBBFreqs1yJY94hK+ViF7YcthhVSVYbd4KkDvjvqaardSNAHDtIATgvJvg
 9dg2Jdqb5LuN1L92ffIm18cjP4uucbGBVKS0qAzANWS0hE83SWnwbenGYk9qtwEjjr6v
 r9Od32V+3Z/lrlzfU2D+xsx25zgHb9J8VdSuY6bPHbgUwb1HTLSIXXGNDDQtgKdi34hf
 +OaS+1LRuI7bpakFrs5SaQHcZujRDnlrkFKJs6YVoltJl1hxZJW5Xyuvkzl6CebMBFh8
 oGtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eaP7i9wSyngJUQo7Cjy0s3lblfwwz2bUaJBF3zqVxB/xGxkxJL1xtK7ntoZIXAFAIEMh9dsc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+FYl61DLMp/a19+6hxGUPgfka3LrSfsaXeJm+Bye0+laLTeFU
 k6a2KSj+4j4F5RiYx+vJJ8HXORhZvvOEroXbP9RxUGm169DjgweBT/Qwx7Qzg5fiKCLpCWX1Exw
 syYWJfZpiQq1CBNpmWN0CqMKTm62WsCNsj8+BRpsb
X-Gm-Gg: AfdE7cnRPuOqByxEgA/AL7X06c94MbGoWMv9yLyxfXUMl4WjJuWrXS6muAgM23zjgph
 zkeqc1lX9+ttcrc1O0Rv1Ql6T+mMhhH/gQ8gTa06WlRQ2D1mZh6hbAC/nO6BLw7lkujAZL0Yxt1
 vx8iilMNafIy+5STPmFh4zSREC494+xnLDGhMWEx3k10Vc4m6u4EKFG+qn1PxFXYXAEiqm+mwuw
 yAB85l2wylFmbudAZesK7cpojeRnqpeFmvyM+sRgSsvqQQuqHCK1/oVhUCULLclnCRZGt1TkQ==
X-Received: by 2002:a17:902:ec84:b0:2bf:372a:830c with SMTP id
 d9443c01a7336-2c718f34407mr37871435ad.11.1781873215840; Fri, 19 Jun 2026
 05:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260616191845.6182-1-ansuelsmth@gmail.com>
 <20260616191845.6182-7-ansuelsmth@gmail.com>
In-Reply-To: <20260616191845.6182-7-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jun 2026 13:46:24 +0100
X-Gm-Features: AVVi8CfZAGu_PsFTyj3R-7qGmIjZH1U81QNVTPxZanEcFbL8iLrstWgfULn8UIU
Message-ID: <CAFLszThQkPNuZwgVoNfz60nJ2jqpN7_0NK3OnZ3ocDoxPfGVAQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] doc: dtbinding: Update documentation for Generic
 Firmware loader
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Martin Schwan <m.schwan@phytec.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Weijie Gao <weijie.gao@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
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

On 2026-06-16T19:18:35, Christian Marangi <ansuelsmth@gmail.com> wrote:
> doc: dtbinding: Update documentation for Generic Firmware loader
>
> Update documentation for Generic Firmware loader, generalize it from FS
> specific and add new property and example for FIP loader.
>
> Also add details on the usage of 'phandlepart', 'mtdpart' and 'ubivol'
> property.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
> .../misc/{fs_loader.txt => fw_loader.txt}          | 33 ++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 3 deletions(-)

> diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fw_loader.txt
> @@ -46,3 +56,20 @@ ubi in device tree source as shown in below:
> +     Example for FIP from eMMC:
> +     fs_loader4: fip-loader@4 {
> +             bootph-all;
> +             compatible = 'u-boot,fip-loader';
> +             phandlepart = <&mmc0 0>;
> +             partoffset = <0x100>;
> +     };
> +
> +     Example for FIP from ubi:
> +     fs_loader4: fip-loader@4 {
> +             bootph-all;
> +             compatible = 'u-boot,fip-loader';
> +             mtdpart = 'ubi',
> +             ubivol = 'bl31';
> +     };

Two issues. First, both nodes reuse the same label and unit address
(fs_loader4: fip-loader@4) - please bump the second to fs_loader5:
fip-loader@5

Second, mtdpart = 'ubi', terminates the property with a comma but
should be a semicolon.

> diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fw_loader.txt
> @@ -1,17 +1,27 @@
> +- partoffset: valid ONLY for 'u-boot,fip-loader'. Offset of the partition to
> +           parse the FIP partition from.

Wording is confusing - partition appears twice with different
meanings. I suggest "byte offset within the selected partition where
the FIP header is located". Also worth stating the units (bytes) and
whether the offset must be block-aligned.

> diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fw_loader.txt
> @@ -1,17 +1,27 @@
> -- compatible: should contain 'u-boot,fs-loader'
> +- compatible: should contain 'u-boot,fs-loader' or 'u-boot,fip-loader'
> +
> +Optional properties:
> +--------------------
> +
>  - phandlepart: which block storage device and partition the image loading from,

Just to check - phandlepart/mtdpart move from required to optional,
but at least one must be present in practice. Please spell it out,
e.g. "exactly one of phandlepart or mtdpart must be provided".

> diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fw_loader.txt
> @@ -1,17 +1,27 @@
> -* File system firmware loader
> +* Generic Firmware loader

BTW new bindings in U-Boot are expected to be YAML schemas (or
upstreamed to dt-schema), not free-form .txt. Since you are
effectively rewriting this binding for a new compatible, it would be a
good opportunity to convert. What do you think?

Regards,
Simon
