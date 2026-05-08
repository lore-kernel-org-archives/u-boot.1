Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF75CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB2A484D1B;
	Fri,  8 May 2026 17:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fc1YdB77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D41984D0C; Fri,  8 May 2026 17:29:02 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EFAC84D13
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-67da63ae541so3660071a12.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254139; cv=none;
 d=google.com; s=arc-20240605;
 b=N87JNKwcKcizPUCMGweK2o2VHREEccCYXXmUUxSbJjrzOVqszHBrCrV7syo5usGyV1
 o5qsaVXJWq/nyLv6mzOIwGHqvhEAT2HR0XFd2StkkMqwSXo85GiiMCktyxv/snFXPRLW
 hbCnvFbWDlgZkeLmjtkdenL19Q004TNba/1NPQWbdQzJG/GO+RaeQWxHWwM4PelIj4m/
 c0x7uayfg3hjYUtH27crwFX5CvNhGFOQjwAp9JyW7U3JnomZ2RZniMePs5t7FHaeKVhO
 H6D39Md15JtP8B96WVyOxww3rgfiKaOa5X0eVXLa1enJuZwU7uIM2Ta49yEvjSSd5iRE
 foUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=982yp/OlEzoGlwWvcQDekwGfXmQ6JHSAgXcoYWBZBhU=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=bnqZfgqQsQAyoX091v3EUuLjkEL5lED0qZUjUj9LQtvwIF3lmJdjWe/KUNwYOAjS51
 DIYjqIXB31TWydEWRsZHW1wyUq6rU43Bv56N8Cl+NTPNxGZ7GVdTJXs9Ec+zFUm6HfAN
 gtgZfxVszbl5L832lHmSfgkIou8fDPbcmuS4DYkDMOi2DrjCzBXgc/43aWQz+bBY/SoI
 eo+SlrDkOR1ovIQ3SXzYYfhNGpNrSEgD5L7MFsCCjk/nmEBNhB9D0CP7bK2mdn9J3Qca
 MpCdju5IIh8EFW8YpCVE+N/WHVPnJ6bC6B1sqPeT91YnB3I3esbWWb6VOAkGPQA5/Qh/
 ruyA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254139; x=1778858939; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=982yp/OlEzoGlwWvcQDekwGfXmQ6JHSAgXcoYWBZBhU=;
 b=fc1YdB77wGwYdor9mKfhYxodS9qPLu7gupICIdAg8wjfOhdNkaOgrOIeXDumfpSZ4D
 KsabBj3ZYWga6I8kHfbmw+zOeR5bawGrB8TiXEIgFOcll6/drJ25x4eHixw5n/vaW3nh
 7udiOYFLKlZL8QOX076kVoqbQGYUrm3IYH9uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254139; x=1778858939;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=982yp/OlEzoGlwWvcQDekwGfXmQ6JHSAgXcoYWBZBhU=;
 b=iU5R73juA6Hvaowc6cuXk3QA2DZtP473+8ar7lBkDBR34nBYGWbEsmGKrFEfJbQIr0
 0p6l2q68uIrH3ZOETWB1bzRd9qBE44AV6ByGrd9xT5P19rTCCC+LD3gevMvwmcZlrjr5
 jxpys+G6/o8eWnCwig4ZS9zsDAt0s2f06Ds1xRjLSPhgm2Cusn3FlMNGcax8aQFa1cft
 7iRlcLMrJIXnuyHKgJPbMsL7F06mpnCMRl+QKBhkVpy6hamkkcvG8WgWRlbweAdD1hfq
 Q6yyYRer+OobpAx/kgGvwBDAqP10z4SoxKlYb0l9gCC6d/Kt3YCyROCUPCcbPmT2u4LL
 BL4g==
X-Gm-Message-State: AOJu0YxE4sQ1rGiBo0KJbI7LcwNVokLDVYHw/jMAP7+CjfuZx5ZNAY5S
 R8IEpHJCOWrPJ29riZ8j4xeUeivshrYPuyNN4HVxWBpztctyerIh70Rkj5BfVoIQVsOHq0QPSzR
 tN/YW63/GuUKWPxKibKWafbXlkZ8sNN3QxHDxJFJW
X-Gm-Gg: Acq92OGpm4ORkWhjv7NUSGB67nVHb8uuHWMw7cBK7duMhrHFegFMvfLQiWTtqKchG1T
 7ZFXkUpd6Mf9dZHB6bQeTHBIG7dMiQfL5VIc36voKfDqz4VaJAmytHroBp/xdB85fXplhq48nm6
 5zh7lKcZFkRjaGkIM5jINa6SW0JpfhdA7n/x57XZVBpcjLjCFe9tGvpXqCrBsWMcE623D2SSqIO
 2DP99G8JdJXlqV7blT4c7Od71R167YwmLQ+EhLqu3BhDIMDbyPEBRTpeI6yP9u3N/+03rmbb5qB
 mWOz1w==
X-Received: by 2002:a17:907:d11:b0:bbd:ceba:97b6 with SMTP id
 a640c23a62f3a-bc5679699eamr736681466b.0.1778254139384; Fri, 08 May 2026
 08:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-20-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-20-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:28:44 -0600
X-Gm-Features: AVHnY4KyuSoyMoxJCdjHBaZmLemJfORLuoGmfL6ACZYALEqMnMML7ZUKonpmCTw
Message-ID: <CAFLszTg6qz_2mqyH12PVfSs1HOAV8EkCcD9ThOq-81CH_JLmiQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 19/64] usb: dwc3: import from kernel v4.16
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
> usb: dwc3: import from kernel v4.16
>
> Sync Linux kernel dwc3 changes from v4.15 to v4.16.
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
> List of commits: git log --oneline v4.15..v4.16
> Commits imported:
> 084a804e0120 usb: dwc3: Fix lock-up on ID change during system suspend/resume
> [...]
>
> drivers/usb/dwc3/core.c   | 93 ++++++++++++++++++++++++++++++++++-------
>  drivers/usb/dwc3/core.h   | 26 ++++++++-----
>  drivers/usb/dwc3/debug.h  |  9 +++++
>  drivers/usb/dwc3/ep0.c    | 13 ++++---
>  drivers/usb/dwc3/gadget.c |  8 +++-
>  5 files changed, 106 insertions(+), 43 deletions(-)

> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> @@ -221,6 +222,9 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
>        * for 10 times instead.
>        */
>       if (DWC3_VER_IS_WITHIN(DWC31, 190A, ANY) || DWC3_IP_IS(DWC32))
> +     phy_exit(dwc->usb3_generic_phy);
> +     phy_exit(dwc->usb2_generic_phy);
> +
>               retries = 10;

Kernel commit 00b42170c86f ('usb: dwc3: Undo PHY init if soft reset
fails') puts these phy_exit() calls just before 'return -ETIMEDOUT;'
at the end of the function.

Regards,
Simon
