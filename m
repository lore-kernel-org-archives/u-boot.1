Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A598C4706C
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 11:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4E11876E5;
	Tue, 16 Jan 2024 12:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AuIIWUQ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 186DC87707; Tue, 16 Jan 2024 12:12:55 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32652870D9
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 12:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-337b38d6568so610414f8f.1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 03:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705403571; x=1706008371;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=arV9puaBkWPaPjVbrKuo9lnsIccy5p5sRcZNIWta12g=;
 b=AuIIWUQ3NCey3k2kC9Nsl5gT1KApU0vqTdts5TEAprDYwj9YEVlOrzVXc9LimxmHPK
 bPSoOmxRPWiTFEEBoJ0GrttNFGa9/LFN1mkbxWe+StXi3KGjWD6xn4+nSJqkdiT7HxFk
 51iTKQMZvlzYmlTZBqA640PLs7r5fRWoTJ7biWd1MdRD9X9dseWz8Qbt0n/VaRDNvXC7
 Xyai07umuSUBT022quU8jWB/U1GcPcTwHnt5mXP0UhAIEW/MIJ4x3UPLTkPe1rizN5iR
 69oQY/KTUl+bqnq1retDXTfZH95yqTCB756UAv1C/hyRbrEnW0K4X+tre3GaaMtDy5ja
 L8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705403571; x=1706008371;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=arV9puaBkWPaPjVbrKuo9lnsIccy5p5sRcZNIWta12g=;
 b=VG9vBm+T/1lLTFdSvqM8bVMCTt1u1UfnFUI5dc5pftMrZDfB0SVQLxMhhDfju/shJ8
 Uimyu5OMcROjjnMmcgLf2aUXf6JcDuZq6JkjNnADlKDos2GMNiXBg9dNsBZTe6fp4Ayn
 5NEv0sSqrjEIzgwOGqB2voa73XOIWKBZwEl9fgwBGZhPpJengNIT8XXGsFeawXQcdZOl
 De2FI9dqvLHN1NXzXWMqnqc3BM4roUXnu533Gi+4rOSOXWXzP5HCNYl/ybd+2AhqxKQq
 ttNsUGLpBmARFGdvxhlruMHYDEY7ezM8ce2R2CwNEixYSm/f05DALRGkQWBsuVBl07Yu
 LO4w==
X-Gm-Message-State: AOJu0YzpB2+5Rv+6AF2vTI56sd8XaY6fRbWKJCbDFjhQHkzLCIE8DkH8
 jCRx6MAv5usDNz0LN5FZs+cLh7o/L+wgvg==
X-Google-Smtp-Source: AGHT+IF2TOf4fLRMf3Qf+I6aAcO13p85okWNskpHscw+UZ6g9/3f3fXd95xFE9Joi9hbil3cVEzy9Q==
X-Received: by 2002:a05:6000:224:b0:337:bcdf:7615 with SMTP id
 l4-20020a056000022400b00337bcdf7615mr278993wrz.82.1705403571596; 
 Tue, 16 Jan 2024 03:12:51 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 o3-20020a5d4083000000b00333359b522dsm14321206wrp.77.2024.01.16.03.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 03:12:51 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sjoerd Simons <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>, Roger Quadros
 <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>, Bryan Brattlof
 <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez
 <jm@ti.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Neha Malcom
 Francis <n-francis@ti.com>, Nikhil M Jain <n-jain1@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>
Subject: Re: [PATCH v4 7/7] doc: board: Add document for DFU boot on am62x SoCs
In-Reply-To: <20240112085317.1866449-8-sjoerd@collabora.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-8-sjoerd@collabora.com>
Date: Tue, 16 Jan 2024 12:12:50 +0100
Message-ID: <87edeh4jm5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Sjoerd,

Thank you for the patch.

On ven., janv. 12, 2024 at 09:52, Sjoerd Simons <sjoerd@collabora.com> wrote:

> Both AM62 SK and beagleplay support DFU boot in a similar way now;
> Document how to actually run DFU boot for both boards
>
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

>
> ---
>
> Changes in v4:
> - New patch
>
>  doc/board/beagle/am62x_beagleplay.rst | 12 +++++++++
>  doc/board/ti/am62x_sk.rst             | 37 +++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am62x_beagleplay.rst
> index 7784e62b0b7..4c8b0845845 100644
> --- a/doc/board/beagle/am62x_beagleplay.rst
> +++ b/doc/board/beagle/am62x_beagleplay.rst
> @@ -270,6 +270,18 @@ for details.
>  To switch to SD card boot mode, hold the USR button while powering on
>  with Type-C power supply, then release when power LED lights up.
>  
> +DFU based boot
> +--------------
> +
> +To boot the board over DFU, ensure there is no SD card inserted with a
> +bootloader. Hold the USR switch while plugging into the Type C to boot into DFU
> +mode. After power-on the build artifacts needs to be uploaded one by one with a
> +tool like dfu-util.
> +
> +.. include::  ../ti/am62x_sk.rst
> +    :start-after: .. am62x_evm_rst_include_start_dfu_boot
> +    :end-before: .. am62x_evm_rst_include_end_dfu_boot
> +
>  Debugging U-Boot
>  ----------------
>  
> diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
> index b12dc85f06b..904a54cd5ff 100644
> --- a/doc/board/ti/am62x_sk.rst
> +++ b/doc/board/ti/am62x_sk.rst
> @@ -105,6 +105,20 @@ Set the variables corresponding to this platform:
>  
>  * 3.1 R5:
>  
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_spl_r5
> +    :end-before: .. k3_rst_include_end_build_steps_spl_r5
> +
> +* 3.1.1 Alternatively build R5 for DFU boot:
> +
> +As the SPL size can get to big when building with support for booting both from

s/to/too

> +local storage *and* DFU an extra config fragment should be used to enable DFU
> +support (and disable storage support)
> +
> +.. prompt:: bash $
> +
> +  export UBOOT_CFG_CORTEXR=${UBOOT_CFG_CORTEXR} am62x_r5_usbdfu.config
> +
>  .. include::  ../ti/k3.rst
>      :start-after: .. k3_rst_include_start_build_steps_spl_r5
>      :end-before: .. k3_rst_include_end_build_steps_spl_r5
> @@ -251,6 +265,29 @@ https://www.ti.com/lit/pdf/spruiv7 under the `Boot Mode Pins` section.
>  
>  For SW2 and SW1, the switch state in the "ON" position = 1.
>  
> +DFU based boot
> +--------------
> +
> +To boot the board over DFU, set the switches to DFU mode and connect to the
> +USB Type C DRD Port on the board. After power-on the build artifacts needs to be

s/Type/type
s/Port/port

> +uploaded one by one with a tool like dfu-util.
> +
> +.. am62x_evm_rst_include_start_dfu_boot
> +
> +The initial ROM will have a DFU alt named `bootloader` for the initial R5 spl
> +upload. The next stages as exposed by u-boot have target alts matching the name

s/u-boot/U-Boot

> +of the artifacts, for these a USB reset has to be done after each upload.
> +
> +When using dfu-util the following commands can be used to boot to a u-boot shell:

s/u-boot/U-Boot

With all above typos addressed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>


> +
> +.. prompt:: bash $
> +
> +  dfu-util -a bootloader -D tiboot3.bin
> +  dfu-util -R -a tispl -D tispl.bin
> +  dfu-util -R -a u-boot.img -D u-boot.img
> +
> +.. am62x_evm_rst_include_end_dfu_boot
> +
>  Debugging U-Boot
>  ----------------
>  
> -- 
> 2.43.0
