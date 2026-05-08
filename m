Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC1FCD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B8EF84CFD;
	Fri,  8 May 2026 17:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JF2K9MKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F263984D0C; Fri,  8 May 2026 17:31:51 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05F7084CF2
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ba60d78aff3so273542866b.2
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254309; cv=none;
 d=google.com; s=arc-20240605;
 b=aCCMMJXSkrQqqTX2zkP7iMMq3b8KS06PNszFtzMfrlAJJ3CZzRK+DC42hD9O1YA3jE
 NHwvOxbQgDuY5GjhQTxB4UHQxi9WAUECT3yfvNHdkmAq+IZWwuXK9arBYg2lVlYqt7eM
 lsArWtLd5mtG+iqBmth7Ob8+xITFm2uv1ZC66rm5X+Xaj1gpEvWWIE+R++dH9/6aTZDQ
 OJWDMpZHDQSrLcK4K3EKixTHDuBbug4pF11jzNvQV6IsGOP3IBjFwTpsslvOtiipZ3Mf
 ETxmjLGoiZKEeC1Dis7ASbH6fd3EKx7h+EmcZRBqJeWRSeQs4rD5mVHVpzVvwKpjJmoP
 +qyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kLh0T5nr9P1q84Ineg+8kBGtC8vYhqbN5HdURIAXhng=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=DFXJvjU8q2AHpGYO7oE6gZa3qSyRsiG6k2uYUAsrW8G6Lhdjnchb5Y8uGl2W7Rcc8q
 /8e8uiksXWN5+cEuCBxwqWYX5Q5eqaT4zLec3MURwJqyxGVt/lm5AyGjxVytyv1C6iDh
 hVvx29G0p7aBBVdu2+mUcXe+BvaAuNkWq7wz9490kMsTEGIg5rNuSABapalEmvcwILR2
 8GE9ysn//epXEY0fxlCC4GiCEUeqvxm2gMYnMUAHDZuDC1gLGVYb53q/7rmND5xrXD5G
 2w5V9wNd1LZgnTWlnmZhhu46Ec+ZHitu5tnVQPvSnB+egzW6/FiG9BYOvlpGkUQpP2Br
 6WdA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254309; x=1778859109; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kLh0T5nr9P1q84Ineg+8kBGtC8vYhqbN5HdURIAXhng=;
 b=JF2K9MKiE+vzZpUKY9gvHX4gPJrqfRBLCwbph7HDtNW4NdRl9qWLkywbdnOjI0gLwW
 DOqTEvAaOwV5hnvN0D3KyAZKVmnPf65lHfmrOO0I9j2o5j9ulEamTBuI7MLO4Ct8nbID
 qrxHpGb35RGbYmirsOsIj/txsV27pDBe5/Fo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254309; x=1778859109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kLh0T5nr9P1q84Ineg+8kBGtC8vYhqbN5HdURIAXhng=;
 b=sGKoiYBUtBHqWdk+pOR+QD7Nqi70cjrhkzBSMsOZZ6W+QrIbtGq4CuB7nj23kUXJAp
 8CPma/0OKYOc8eN0316n823tSPmZGN5pBTHkXeI2TjtXEsXfKb/Ewhdd/Ut/x/9f8SFx
 0fiz039OQqfjNjqbt5jr5Xb3I5ftcL19ENfzA6ADPvh/GmrZM4t3iEZzDxD0CrWnmhLu
 pjN8MIXncEWllgpaj3Cxa4TonSLlCK3+Wttu1HlMA1FRiIlVLH7Q0dbIZg3xYSq/jgn+
 X87szjaCbwqT3S+3zAwbvgo9kQAejKU+2RaEEjwskfjsykfO+ZFoLVf5R5rtwsb2NPM7
 iw7A==
X-Gm-Message-State: AOJu0YxOBxE95mxksR1hRGlMKZPvbNu8/zVi0WHaP60Jdh6ITpOSrAzM
 JkgUGYFLqfonYQGFMWWOH74+1YA4eBNXtv//+CiBrbso7M0fltUCNtBqISQgx+D8dSTYf6OZYPR
 dcd4PCxutUScwSolylRJxrbe9vKbfAfkFBfIwsimd
X-Gm-Gg: Acq92OEwyGkrfTwP9ioY5If3pLQkY6PJpI8sIajVaEYPIy0BGIyIdvQJjAlNN3w5gP4
 GoAZmTTaGr7bZeLX9Le7mGhOTLn9QC64U2lsfg3ZBXXUgUZvcvi3NJY7WjOHW8aGOq3thYeGxIm
 SkGLYfCfevM6II5V0qANIj+Y700C66yx3HqJ9aBTqRFoOSnt+EZt94jNHqg0BHrxhXtuoKP3Mql
 fS3h3EPV95I/ujCWmEEYaaVF7DLAsfIPXV/BNnHWpzNIrJEYr/dMUc+7zUnjGPygdS3EnIXtPOp
 8WeK4Q==
X-Received: by 2002:a17:907:3cd6:b0:bb8:fd89:4a74 with SMTP id
 a640c23a62f3a-bc56b12645cmr797058066b.14.1778254309235; Fri, 08 May 2026
 08:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-25-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-25-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:31:34 -0600
X-Gm-Features: AVHnY4LqQZqBS4PvT88TVGH8Vr5JgqB9pPi-MqIUNZKxr7qWvReq71jc0s8qVD4
Message-ID: <CAFLszThaon0Mv_Eq6tHEUciBEc8MaNGTZOU-TUGNbxtbarHgWA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 24/64] usb: dwc3: import from kernel v5.0
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
> usb: dwc3: import from kernel v5.0
>
> Sync Linux kernel dwc3 changes from v4.20 to v5.0.
>
> The following files are preserved accross the import:
> Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
> dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
> dwc3-layerscape.c ti_usb_phy.c
>
> Skipping unused files:
> debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
> dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
> dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c
>
> Note that this is a raw import and doesn't build.
> A fixup commit at the end of the series fixes that.
>
> List of commits: git log --oneline v4.20..v5.0
> Commits imported:
> 512e6fb589bc usb: dwc3: exynos: Fix error handling of clk_prepare_enable
> [...]
>
> drivers/usb/dwc3/core.c   |  19 ++-
>  drivers/usb/dwc3/core.h   |  60 ++++++--
>  drivers/usb/dwc3/debug.h  |  29 ++++
>  drivers/usb/dwc3/gadget.c | 348 ++++++++++++++++++++++++++++++----------------
>  drivers/usb/dwc3/gadget.h |  15 ++
>  5 files changed, 336 insertions(+), 135 deletions(-)

> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> @@ -919,6 +940,7 @@ struct dwc3_scratchpad_array {
>   * @u1u2: only used on revisions <1.83a for workaround
>   * @maximum_speed: maximum speed requested (mainly for testing purposes)
>   * @ip: controller's ID
> + * @version_type: VERSIONTYPE register contents, a sub release of a revision
>   * @revision: revision register contents
>   * @version_type: VERSIONTYPE register contents, a sub release of a revision

There is a duplicate line here.

> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> @@ -1139,6 +1166,17 @@ struct dwc3 {
>  #define DWC3_REVISION_IS_DWC31               0x80000000
>  #define DWC3_USB31_REVISION_110A     (0x3131302a | DWC3_REVISION_IS_DWC31)
>  #define DWC3_USB31_REVISION_120A     (0x3132302a | DWC3_REVISION_IS_DWC31)
> +#define DWC3_USB31_REVISION_160A     (0x3136302a | DWC3_REVISION_IS_DWC31)
> +#define DWC3_USB31_REVISION_170A     (0x3137302a | DWC3_REVISION_IS_DWC31)
> +
> +     u32                     version_type;
> +
> +#define DWC31_VERSIONTYPE_EA01               0x65613031
> +#define DWC31_VERSIONTYPE_EA02               0x65613032
> +#define DWC31_VERSIONTYPE_EA03               0x65613033
> +#define DWC31_VERSIONTYPE_EA04               0x65613034
> +#define DWC31_VERSIONTYPE_EA05               0x65613035
> +#define DWC31_VERSIONTYPE_EA06               0x65613036

> @@ -1098,6 +1124,7 @@ struct dwc3 {
>  #define DWC3_REVISION_300A   0x5533300a
>  #define DWC3_REVISION_310A   0x5533310a
>  #define DWC3_REVISION_220A   0x5533220a
> +#define DWC3_REVISION_330A   0x5533330a

These two chunks seem to result in duplicate symbols.

Regards,
Simon
