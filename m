Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1419CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CA8E84D55;
	Fri,  8 May 2026 17:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a54P+OqR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7313484CF2; Fri,  8 May 2026 17:32:34 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D23184D52
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c70c112cb61so1548307a12.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254351; cv=none;
 d=google.com; s=arc-20240605;
 b=G3vJOE7rrtNoJJFwye0E+/V/hKi632YH0+zNEmrb5xBjEON6McJwzNtnqriR3RMU7V
 ufeSMzsqkzEi/bPsIRBQgDWP0fwRqcAlOzl07NRdqIjBHuUeigO1SzVOG5brQ+vxzNJ3
 QrFEjQYztmBmn2NZNbsBi5tJYp45JHljGQfrc61EErUsSFHktJdJJ2ADqTYmdX5rJ4Bi
 SC+3+/3Ww+OBIWljrUnHZsDfiD54ZchQTAT8DIWcYOhj2drvDVmYPBCm2YXC/T/XXLbC
 TJTwXhgl4pLyCjPwKUOQgFX8iTxUMyCbMFC3VZKwHCoRCl986fc5LleAyEzilnxIv5Go
 2P8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PHj7uXXFKfMSH1BEycyUlLF4Na0RGFheOmBoSY5xJYg=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=PxzItKuBruzpxVem0kuCjlqv+go/0tIlOX1QcSSiwwxTm2GUN2CUAg8i2URy+8kX+Z
 YpYild2yb11iZjX15Ppktd5B1kZ69hr0Po2wtEEK9F6oXxpqJ0vMTNJsrtIpQrcNtj56
 aPaHZ1BnlkrBI7mzYY6sgYkxcyOHg6pBLFB0VbnBLEtuOBCI5VaW1iUKWxyz3QfcnSIw
 AySNqKxeoUFZ+oCS0liRJ6MSn8VqCaQjWrRewEkNB7SVf557O5mYLBMrGjTinr/NvXuv
 FYtLT1vugAyK85lum2gRhf5vIycql5iIX+dkKQLtvGOcrtZW4g99k6Oi72qh81Q+9Frn
 LNwA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254351; x=1778859151; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PHj7uXXFKfMSH1BEycyUlLF4Na0RGFheOmBoSY5xJYg=;
 b=a54P+OqRmWml4OXQMFtNMI4Qwl8Z96i0vWulU6jMps9jacj5UZgGekQ86MrD05RVJV
 dV32lRjnYWG2d2gebpHIXnR2CPMfO1oXucQ27aYDx+wYrJas684n+WMekWfST58PaNwJ
 ctr0IMbvUDqedoHnHJeGV13P24rehGq0yXNlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254351; x=1778859151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PHj7uXXFKfMSH1BEycyUlLF4Na0RGFheOmBoSY5xJYg=;
 b=M/Zmj1W1WX27YGttrRoIhvWkOqYCT17Gqk/ETcvxmbLbE5uDdGSuIaw0LuOWO6HCiV
 yXJU+5E+aUQzAUeMpRf2hTPa3njDnoXY5sY6msBhXjwTrw8kct1dV4BildjGrsmgHn57
 q2bcsAwHb38O/VVdhVTBu2mEQUei/r5Fhns6b+/kZf0h4URFpENQAl0u2NDvNKBhCDDq
 F0KKqadawmOAUrKBQD03XXtXyw31mxwfF27M+eKLfM4CX0k9+iYRk0CMezABYMwfDWhK
 ZmqATb4Ru1hXYVr+c4qzfIcdlbknZRjRSe3bwz6TO/DgdNBTSImVQ5scr5zslbmMeXUk
 VQzw==
X-Gm-Message-State: AOJu0Yyalc/6MKHuN6lgJh5oQy6y7ZA8/1Th3uWPtAFxjahntGS3iUwo
 +/tQ6T43fW+sqyxLTIGY4sCcrbXOrEH22+CxBWHEvA+RL+bb0KorR+4dK31z5eZe2koEm3bdEzm
 wP8IAcqiqDdcCC0BfeFqV3gtf0zezirxdpUroxk/J
X-Gm-Gg: AeBDiesJIq6s5wS/0FtkFRQ08bXQDulzEJ4wvNOf2jdwOGUDQJYnkr+sis+BKTXyAHM
 EpqYqn+kQnDWclqez9zu/vongShcURE68EzmefjH47Gh/5f03UQeI/YTEd6POAAPBmLZuXTV3WA
 WOnovQZXfSFkq3oUJjJErLQgVARJlnSiw2hrYW9yyVowGNuj8v8TUQoQY/Ec8UFJ8L+U3IRNGmc
 Q/ZAZT298r6ep0uJVBtDDeTfIVgO0DkzsiCFtXFAs6uThO7fjtZCetbrgeSlEgN1anFCZHkGQKi
 sDgpnw==
X-Received: by 2002:a05:6a20:7485:b0:3a1:90ef:7e37 with SMTP id
 adf61e73a8af0-3aa5aadd00fmr15504696637.33.1778254350703; Fri, 08 May 2026
 08:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-28-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-28-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:31:44 -0600
X-Gm-Features: AVHnY4JE1osMJS78IHmFIm2_uqyrk6S4gTnOrSJVCcaV_5MB69Ca_WedVdZCHfs
Message-ID: <CAFLszThB+yap_H2evkUiyydBAjuXFa_mgaz0s+PRuAggpfndrA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 27/64] usb: dwc3: import from kernel v5.3
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

On 2026-05-07T09:27:07, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> usb: dwc3: import from kernel v5.3
>
> Sync Linux kernel dwc3 changes from v5.2 to v5.3.
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
> List of commits: git log --oneline v5.2..v5.3
> Commits imported:
> 332694f8a4f7 Revert "usb:gadget Separated decoding functions from dwc3 driver."
> 3db1b636c07e usb:gadget Separated decoding functions from dwc3 driver.
> b3649dee5fbb usb: dwc3: pci: add support for TigerLake Devices
> aa23ce847dda usb: dwc3: remove unused @lock member of dwc3_ep struct
> dbb0569de852 usb: dwc3: pci: Add Support for Intel Elkhart Lake Devices
> 729dcffd1ed3 usb: dwc3: gadget: Add support for disabling U1 and U2 entries
> 4d20a6107050 usb: dwc3: qcom: Use of_clk_get_parent_count()
> dc1b5d9aed17 usb: dwc3: Fix core validation in probe, move after clocks are enabled
> 7f5d6a469617 usb: dwc3: qcom: Improve error handling
> a6e456209d08 usb: dwc3: qcom: Start USB in 'host mode' on the SDM845
> 2bc02355f8ba usb: dwc3: qcom: Add support for booting with ACPI
> f90db10779ad usb: dwc3: meson-g12a: Add support for IRQ based OTG switching
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c   | 16 +++++++++++-----
>  drivers/usb/dwc3/core.h   |  6 ++++--
>  drivers/usb/dwc3/ep0.c    |  9 ++++++++-
>  drivers/usb/dwc3/gadget.c | 22 ++++++++++++++++++++--
>  drivers/usb/dwc3/gadget.h |  6 ++++++
>  5 files changed, 49 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
