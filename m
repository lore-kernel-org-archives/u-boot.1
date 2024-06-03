Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47430C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 06:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B392D882AD;
	Mon,  3 Jun 2024 08:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uiX5JE9a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C00882DB; Mon,  3 Jun 2024 08:26:53 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF88187DDF
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 08:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42137366995so15117835e9.3
 for <u-boot@lists.denx.de>; Sun, 02 Jun 2024 23:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717396011; x=1718000811;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9c/Vy6o7m7eNGrPdMNnXJO2wxZpbIL1k/+xGdRlZvGI=;
 b=uiX5JE9acDa3PxLBQ994F/xwQaomH4pSCIdKVIZGMIOXdzTkte0W3WScZom2IChoIr
 BlLWyFvx4z0ZFj2u7hHQuN+MbPtu4mfc/EJLO7n14IoYbLwdTWgt36NXiy5ixwO/delD
 1c0uCfiC5cg8N8XBh8Rdpa2Fn8IXFOVNfv93pddEG1uUTLfgWZaQhHMtZ13ObfTqfke3
 5NV67uni59atpZ9wgKTlWXsDuCI050PlG08LyFTOI1J/FKoqcEsovpnjfdSeguLD3Jpp
 zJjoyfLtHkLmWKrchZJ/aCrrHrR3IrZ9jFBZgXDpwUyFCnPg9/jilQjYhORfoymXWSE7
 bPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717396011; x=1718000811;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9c/Vy6o7m7eNGrPdMNnXJO2wxZpbIL1k/+xGdRlZvGI=;
 b=UI6pGwwxX2X4l7Bilw0Qke+SMG0A3CnTCgb4JiCfKvZsADDYbztu8UaawAY5Udv1MY
 o6H3zSOhkUMSRZIMKynl/ZEwPz7rpluJHC+mkTT9qk/70ywdMdm8yjHJ77C9wDiZRcT2
 0nKQed22frz0TdzsS45VQyy9nGfKzma9dRX5dISTfmjsHj0mw5TeiDzeUlYzaRLJer+b
 DXQDf/xf0iYZpd/P3VG/YzyFW5FZGadXsx+Hi39nuTrzaD/HtymQoFBx00xiuiDq94lM
 8oGX+cIlaWlvM2VALsybfBiHDhUiuKi/0sQMAFhaC0XCZM09XjuU5PeoHAnnjBBtfFTE
 vSFQ==
X-Gm-Message-State: AOJu0YxxDFw1fKvpxP/J476QXBOLfzPsz7iAN6f1Rmor3MtDVyumkT1f
 SkkZS71j+ZAm9n0S70yyms02Mc9NM4pEL0xa4oLezZ8tme4oZBkeXnP5ZFpiZa4=
X-Google-Smtp-Source: AGHT+IE7wVf9smIYr3yAyhxuWcfcowEu60uoKlbWuIx7INbuwSK+JrrMZEjMwZwYWP/7/pxucKz3Xw==
X-Received: by 2002:a05:600c:45d2:b0:421:2429:7e46 with SMTP id
 5b1f17b1804b1-4212e05019amr96242475e9.13.1717396010963; 
 Sun, 02 Jun 2024 23:26:50 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b838b83sm105670965e9.10.2024.06.02.23.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 23:26:50 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jonathan Humphreys <j-humphreys@ti.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian
 Gmeiner <christian.gmeiner@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Simon Glass <sjg@chromium.org>, Nikhil M Jain <n-jain1@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime
 Ripard <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Masahisa Kojima
 <kojima.masahisa@socionext.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Jonathan Humphreys <j-humphreys@ti.com>
Subject: Re: [PATCH v5 02/23] doc: ti: k3: Correct spelling mistakes and
 improve clarity
In-Reply-To: <20240531222118.2618041-3-j-humphreys@ti.com>
References: <20240531222118.2618041-1-j-humphreys@ti.com>
 <20240531222118.2618041-3-j-humphreys@ti.com>
Date: Mon, 03 Jun 2024 08:26:49 +0200
Message-ID: <87sexuilsm.fsf@baylibre.com>
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

Hi Jon,

Thank you for the patch.

On ven., mai 31, 2024 at 17:20, Jonathan Humphreys <j-humphreys@ti.com> wrote:

> Few cosmetic fixes for clarity and spelling mistakes.
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  doc/board/ti/k3.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index a1c01d1cf02..927f3976d34 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -51,14 +51,14 @@ For all K3 SoCs the first core started will be inside the Security
>  Management Subsystem (SMS) which will secure the device and start a core
>  in the wakeup domain to run the ROM code. ROM will then initialize the
>  boot media needed to load the binaries packaged inside `tiboot3.bin`,
> -including a 32bit U-Boot SPL, (called the wakup SPL) that ROM will jump
> +including a 32bit U-Boot SPL, (called the wakeup SPL) that ROM will jump
>  to after it has finished loading everything into internal SRAM.
>  
>  .. image:: img/boot_flow_01.svg
>    :alt: Boot flow up to wakeup domain SPL
>  
>  The wakeup SPL, running on a wakeup domain core, will initialize DDR and
> -any peripherals needed load the larger binaries inside the `tispl.bin`
> +any peripherals needed to load the larger binaries inside the `tispl.bin`
>  into DDR.  Once loaded the wakeup SPL will start one of the 'big'
>  application cores inside the main domain to initialize the main domain,
>  starting with Trusted Firmware-A (TF-A), before moving on to start
> @@ -94,7 +94,7 @@ essentially 4 unique but very similar flows:
>  * Combined binary with a split firmware: (eg: AM62)
>  
>  For devices that utilize the split binary approach, ROM is not capable
> -of loading the firmware into the SoC requiring the wakeup domain's
> +of loading the firmware into the SoC, requiring the wakeup domain's
>  U-Boot SPL to load the firmware.
>  
>  Devices with a split firmware will have two firmwares loaded into the
> @@ -114,8 +114,8 @@ K3 HS-SE (High Security - Security Enforced) devices enforce an
>  authenticated boot flow for secure boot. HS-FS (High Security - Field
>  Securable) is the state of a K3 device before it has been eFused with
>  customer security keys.  In the HS-FS state the authentication still can
> -function as in HS-SE but as there are no customer keys to verify the
> -signatures against the authentication will pass for certificates signed
> +function as in HS-SE, but as there are no customer keys to verify the
> +signatures against, the authentication will pass for certificates signed
>  with any key.
>  
>  Chain of trust
> -- 
> 2.34.1
