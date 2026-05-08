Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8010CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B69084D11;
	Fri,  8 May 2026 17:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kJrp7w/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B275A84D1A; Fri,  8 May 2026 17:29:27 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8120184CF2
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c7358a7a8d1so1489464a12.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254164; cv=none;
 d=google.com; s=arc-20240605;
 b=Za2jyxkcNkOxe8/wc08LWlz+OXejqBSnPqK/J7AG+SxPhBMqzHYbhKQR+FUftCgccN
 YYGPd2NURmRP+F1xtJnvBf8uU2FljkFuuiOXfsqz5vrld0QZnxXBoBS2ZV2r0YySmmmG
 liLk15kiHcDiA/mluJNcBR+EIh7bZTf7990MSW7QYX9e1fJzT9tcMMDFdYrs1TqwKOvr
 Cav2XqijMj3IT/yMOOrTjZhJskhQhxq8aRxF407Td/AFEB4ESGg82AeifV7i4t6wOnmE
 S9JkfdLfPZiA0SzFtFBHz1m0rMMd2GE9/XvJzv/Ur34nNl3yE6TZ+DsuVKBlZxrld5df
 ORIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OXh0kQ0HTZQzyjlGwL1a5EXpy2J+usm2EUjFjcMc00c=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=Tp5jqQu63peSDvybKYrIuqk9tkcFlM8oxBin+rIExNgt0aO0SGw/3HM/bj0nRPzdQD
 aQB3EQJzi7sMI57Qr41jmLN5Trogse0sWtDsWzGZa6BHLYMYp2EQteh3GqJkQcKWrETL
 j74CTUEkfJw26MIgLbhVZjFva3YsPyA5H4viVcCeHnR4huFc53LQcmsPIM2EWoWghJ3f
 VMtWA+8ax52IwUxWcHYXty3PByxjttKZYrBXGUo06EF+iQAXva+jdzelnPkzurrEk8k3
 uw1+suVVSK0KPaa1fWOh+CdHWLd+WOFpH1D9b4n7rzZ6QM2k1yWqRR+9d/DfU2O8Mqtg
 G32A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254164; x=1778858964; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OXh0kQ0HTZQzyjlGwL1a5EXpy2J+usm2EUjFjcMc00c=;
 b=kJrp7w/lSMygvf+ddMiM6Kp9/R15r283hJwD6DsxE21bU54ZWaklJyAmFD/AVAthyk
 JKpQILxIqkK53RntkCcmBgQ/UGbKaK3G3i29o3nKMp+auy581lJOx8ocnyxTd3rH6qxt
 K7cfDkAudNj5JngrThfqLjGO4Y54R9kkoYW8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254164; x=1778858964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OXh0kQ0HTZQzyjlGwL1a5EXpy2J+usm2EUjFjcMc00c=;
 b=mfMsXfA4nEwDjo4+EkDUyoFRrq4dPcf41P1Eekjxaawrb8ozowtVsIFUPsGDK1Qvug
 a1Xawn/YEMLkzu3hL7vuHs3cIohtKoxc+0SNHE4pv5jab3NqVv5iMJpDrXnAmnMNI4b2
 Lv7Gbp3YmtFlCUCKWOONSYRl/OQ6atbnyzjwZGfpOIs2hKUiHGavN3xv4+E5KOHY8t7E
 v/gb8YWYVwPnqGNM/e4pR+wXEBF4rJ7KR6a9qFZK2j8o4dXyNYGh2QtwCxJXea50/FTT
 MTMM0Afl9J6HY96TsbPGNCTvOmrIte5jwWfP46yuw3az2s9GAgu0HloLIV6TjfNEHXMh
 pVHg==
X-Gm-Message-State: AOJu0YyPYZBfHxiTM2KL33+iNAEerHdCNtWofyDL+fKDiw1+Ht69JdDj
 e1/4h//VgO5WKlG4tq148EGs8yAtLTgQrgkYXZEFTh59olFCRhBaMMRuSFhG6xzzE/ce9q7AT8l
 vmurf9M/vjneMMYMkv+Qt2m/Wr4Svozvx6fg6pUCL
X-Gm-Gg: AeBDieusVeHu5NgXjX9LIkEPywkBzh84JXXFUbrxWcOGa/BW6WyfOZE1tz5hEL1HNTl
 +feQjMpdWlLmmedshL26rtCAqv8hNLrmL1oGUt5iBcs6k0r8Rz2cLzZw9aBq7MBVjXH5g7BVdlV
 jKTNtwKTMeZYyllPjY1LxRuTtE2QmVue8srqOpgOIiXlFW461nbuYOFl3fb3OSBTfMNIAtlYGsd
 1sQuGpTGGqZWZbFldRXMH5aoGHx8sMwZl8P2gKMb760VGzNCPZ0walHxeVdjvTlusVhdCCZvurr
 s8n2CW7vyZwRJzQx
X-Received: by 2002:a05:6a20:158e:b0:3a0:adc5:52c1 with SMTP id
 adf61e73a8af0-3aa5a830acfmr15884749637.11.1778254164032; Fri, 08 May 2026
 08:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-23-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-23-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:28:54 -0600
X-Gm-Features: AVHnY4I3b3AGJtksSBDXypPGw04zhjdOeFZlxpBo9E_uSjkKUNVvknFZe1JxtFI
Message-ID: <CAFLszTi1jEscnGy-Rkwv0yvZQK-GHdggZurQoqvYyGogVXN02A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 22/64] usb: dwc3: import from kernel v4.19
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
> usb: dwc3: import from kernel v4.19
>
> Sync Linux kernel dwc3 changes from v4.18 to v4.19.
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
> List of commits: git log --oneline v4.18..v4.19
> Commits imported:
> bfa150f37f80 Merge tag 'fixes-for-v4.19-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-linus
> 4e3121abcf53 usb/dwc3/gadget: fix kernel-doc parameter warning
> b497fff6f59e usb: dwc3: pci: Fix return value check in dwc3_byt_enable_ulpi_refclock()
> 66174b6998a6 usb: dwc3: of-simple: avoid unused function warnings
> 45dd7af410b7 Merge tag 'usb-for-v4.19' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
> 4ea438da76f4 usb: dwc3: gadget: Check MaxPacketSize from descriptor
> b138e23d3dff usb: dwc3: core: Enable AutoRetry feature in the controller
> a77004681148 usb: dwc3: Set default mode for dwc_usb31
> c31d983beaf0 usb: dwc3: pci: Intel Merrifield can be host
> 1a7b12f69a94 usb: dwc3: pci: Supply device properties via driver data
> d9612c2f0449 usb: dwc3: Enable undefined length INCR burst type
> d635db5508b0 usb: dwc3: add global soc bus configuration reg0
> 87d852de94d6 usb: dwc3: Describe 'wakeup_work' field of struct dwc3_pci
> 9a7faac36502 usb: dwc3: change stream event enable bit back to 13
> 76251db86561 usb: dwc3: of-simple: reset host controller at suspend/resume
> 211f658b7b40 usb: dwc3: pci: Use devm functions to get the phy GPIOs
> 7740d04d901d usb: dwc3: pci: Enable ULPI Refclk on platforms where the firmware does not
> 5741022cbdf3 usb: dwc3: pci: Add GPIO lookup table on platforms without ACPI GPIO resources
> 3fe314ca8c97 usb: dwc3: Add a glue driver for Synopsys HAPS platform
> db9fc500e85a usb: dwc3: gadget: remove redundant variable maxpacket
> 714c95ce8bad Merge 4.18-rc3 into usb-next
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c   | 118 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc3/core.h   |  17 +++++++
>  drivers/usb/dwc3/gadget.c |   3 +-
>  drivers/usb/dwc3/gadget.h |   2 +-
>  4 files changed, 137 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
