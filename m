Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F37CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27D6684D5A;
	Fri,  8 May 2026 17:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gJdHLXxU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 254AE84D60; Fri,  8 May 2026 17:40:29 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA85E84D2F
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bb91b426e40so367270566b.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:40:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254826; cv=none;
 d=google.com; s=arc-20240605;
 b=kx/nQLe9Ug6/ZOqwuzqYPv55r7h+fpkSUwJrfDQkK5lfXDPW+kjy3QA/RhiKfDES4o
 T4Da2OINSzLFd+eGcqR4UKfPKEvZGnH17Fxy2vwU13mkwVThxW3GWsSBaWG2bOiAd1rU
 m+LZjhz68h5A9XWl8EeVOz4VlUcY1eC8ctT2sjNpe3gaea5AdYMylB9Zse58kt1e0SfZ
 ob5uwojatD5mND1G72lhpPJ9eo3/TQrWNORqmxBZXg82SR6G6Q5vZjH+LmFMstnepF7j
 qpdPKutVUD3vUlXZJdUjbchsbgfVgYLHo28LfkjHW3FGq9nKAyZXo3tkzZLHYWAxBT/b
 +4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fSY87zYENTyV74z7DqjXhWckpar506QIIGGO3D+8mu8=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=JsKQOHxEltTUeiTAMpvqZA/oxJaY0uiNgmD7qItgBBa8clhMl9KY9gf4hFYUnJ38Zs
 ajnnrs47ICMfTTGc7D0u3JRFdIpgr+5YgBEh9n+/FuXtUbRaQuR+2JJXWyG4R4DVpPyN
 NgxYoZsKwUU7AWLRImyVuVUSvdsQI8raZAb9Ozkj/zHO0flwvpIup+fzPcY/Ep9FN6Vk
 wQfWZxeBWpJGVvihRBEiSWo25tZ6y9CNJEdwm+KXv8gx/vItVIk/4wAIpLAQPw8bged2
 18c4Szgtr15Nn4g+MU+xBcbqfXUEAaXRp/HsrbvlsFqAWq4drq+kpWu1GLVtbejq6obm
 k7rA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254826; x=1778859626; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fSY87zYENTyV74z7DqjXhWckpar506QIIGGO3D+8mu8=;
 b=gJdHLXxU9hVt65Xy9PN2RtAxCfIX3uSNkvAKGg6R1CxeGHBOrMwaahHJOLtZQESTfM
 AGrpYKsvUgT9IPftOn8jgpwUDMM2b++3wN53kzdmjztBT1Ux/VfGK+wM37H2mE8xCFzl
 ljy04p9rJwfYFWv5Afqj199EmRRkNWxi7+80w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254826; x=1778859626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSY87zYENTyV74z7DqjXhWckpar506QIIGGO3D+8mu8=;
 b=DFh65PRnMJjWdlZgdkJ/Kj7Ym5dMZ2uXEmoWT9F+hZdjDQxMrnRcrKTCrHHjIjksjP
 /r4y1dm49Tx0c2EvA5NukTcGUsn219JSdxyapj2W7s+hbXL4zxaPetlSumJ7I0r3/Fcy
 qjnvuERYjqCHj5eZvi6Isi4+vWgX6fiMN9eNPMf1ahKjQSf5MjqVsy30sVDaRBv69aMJ
 pIs/l2rzkbZbOmP2nBYzaztxbfZnnigV/vMznD+Kx6CZybhd3llNlX3j7CFrudDAKKtR
 +faNzocXovJyZuaDUs30qfYU4FAtqdfp2B9XS4FM+IRrCn9RtKYowssyJbEcf9oIc5ld
 tqzg==
X-Gm-Message-State: AOJu0YxygqZ12mOvFNgcIMKHrd+ehB/7U3fdoxskoLu6qKzegj2HLxRq
 R1cikFi0KTrqBayw0Io3l1tHh221hnMZRfHDoDkZGHSbRKeHFvG2Se3J2+Sf5YnhFthE5I6CM1I
 X6iE+iw31mUCHnHr8ye0H0s/8TNcBOiwT/zkXPHSX
X-Gm-Gg: AeBDietpw5NG6gUTbgj10IqJOjOgDu+9T0Hek27fVLEMCM4WLtSAMtjfiQd50VuMTq+
 wGvamb5PjoHQy/Iy9lxfM4EY0GYkpgbcuSpS/Y+H4yMXgxPq+PyvsWVpnzoquMpNVey8T6uMQ/O
 tvyD5yFF01a6LI764fC2QsHJcla1KRDtjMcfTA32Z76AGauTmfAwuIZZV3QSMRwhaUxivOz8JIy
 t7F0rFsQ7hQmRsgQjwzW49xL1hrSLTmozC2nHPqun24bS0fhsjllshSuMK3Pvh/AHPPudnUATtA
 goyCPQ==
X-Received: by 2002:a17:907:3c86:b0:bc4:b9d3:1013 with SMTP id
 a640c23a62f3a-bc56ae28594mr829594166b.15.1778254815583; Fri, 08 May 2026
 08:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-2-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-2-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:40:03 -0600
X-Gm-Features: AVHnY4INTX6huDEKGx--D2mWrIF9YZgdCOm64jzrnrX7AiUq9iNQjbW8yCkmK5Y
Message-ID: <CAFLszTjJX0ewW3CUwuu-9-K62A7AmiusJiB=3T-EfO2ZO7guug@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/64] usb: dwc3: restore to original v3.19-rc1
 kernel import
To: jens.wiklander@linaro.org
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Ryder Lee <ryder.lee@mediatek.com>, Simon Glass <sjg@chromium.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
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

Hi Jens,

On 2026-05-07T09:27:07, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> usb: dwc3: restore to original v3.19-rc1 kernel import
>
> Restore the dwc3 source files to the state of the original import in
> commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel to
> u-boot").
>
> The following files are preserved accross the import:
> Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
> dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
> dwc3-layerscape.c ti_usb_phy.c
>
> Note that this is a raw import and doesn't build.
> A fixup commit at the end of the series fixes that.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c            | 1004 ++++++++++++++++--------------------
>  drivers/usb/dwc3/core.h            |  171 ++----
>  drivers/usb/dwc3/debug.c           |   32 ++
>  drivers/usb/dwc3/debug.h           |  228 ++++++++
>  drivers/usb/dwc3/dwc3-am62.c       |  125 -----
>  drivers/usb/dwc3/ep0.c             |  217 ++++----
>  drivers/usb/dwc3/gadget.c          |  482 +++++++++--------
>  drivers/usb/dwc3/gadget.h          |   16 +-
>  drivers/usb/dwc3/io.h              |   54 +-
>  drivers/usb/dwc3/linux-compat.h    |   16 -
>  drivers/usb/dwc3/platform_data.h   |   47 ++
>  drivers/usb/dwc3/samsung_usb_phy.c |   77 ---
>  12 files changed, 1214 insertions(+), 1255 deletions(-)

> diff --git a/drivers/usb/dwc3/samsung_usb_phy.c b/drivers/usb/dwc3/samsung_usb_phy.c
> deleted file mode 100644
> index 3563070cb85..00000000000
> --- a/drivers/usb/dwc3/samsung_usb_phy.c
> +++ /dev/null
> @@ -1,77 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/**
> - * samsung_usb_phy.c - DesignWare USB3 (DWC3) PHY handling file

Doesn't this mean that odroid-xu3's USB is removed?
(CONFIG_USB_DWC3_PHY_SAMSUNG). Does it come back later?

Regards,
Simon
