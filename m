Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F93CCD37A7
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9EF284D42;
	Fri,  8 May 2026 17:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KD7jR13e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21F7C84D56; Fri,  8 May 2026 17:32:37 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01C4484CF2
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c8028fa6039so1312209a12.2
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254353; cv=none;
 d=google.com; s=arc-20240605;
 b=iI418u/P2zr+I+USACDwB0JNJTcabuDzu9g6HRNXtRjjjRhD5mO6f6DhlmWrr4xNQN
 A+WgjkG2+NEnnhToTANJIUe3y0kyOKrFvR429I1eA80dkM86ZbEB7AWFiRCNeM8CCpjd
 43zhp3fIQVafjWWH7N9Wo4Kcx7DP68BiCzj98SkGHBp7K8C2T5YH/bK+4BFGH9SD4FHX
 jfrzE3WUGnpxlhYqbg/6Z6GEsIGt413vWtQhUhnjHD1FamkYuAOPJIkk2DsqlDby60iu
 wD7rd1ZOnkylVfDvlqDAOcV06EbYADRepHfwmxi0Eg47R0FD9/UjQW92s4mawGK8R05n
 kJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y7p+Vo2MAZHO9bgFQIpn5Lg3bsEP0zQjCLxw11F1jqY=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=jiOyVSCTzay1ZjDO+q9N2QEJZL08TTg/YdOePkSaf1UWsbh6M2PmnZLRNayxoiknfM
 sVdN1RcUfZRwZahCBWHF6D+iD3Xzdoy1Bcjcwe1FQh5DKxpg404F54TDwRecYZsP3DTr
 dWUGDGL5Oj5ip8kyh+Q9lR/xmpFQmIpxd2n11Y5B00teIfEqEJcG4iyHbPgr3Um52PY7
 AJ8XPDfvsHUc8Isx8J4E+QsdCauDhaEY6P+YcuCBsOvyRQvqlUEuHFPx4xWmibuE5EIE
 FVO/8cX+BaYou+39e1dBt73gkbLk+unXqDbP+x4ZxBhBsiYSjkmPoaFDVJZ7I8erKbaK
 dD/w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254353; x=1778859153; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y7p+Vo2MAZHO9bgFQIpn5Lg3bsEP0zQjCLxw11F1jqY=;
 b=KD7jR13eLa0zOnYYAiM5/tMfjChb9UWVaDrZev88j6VkFopxw8UVJnCP2W/kIbtazI
 PuDntDLja7GAFRUefitEWMLQBnKEsGbTW96QRaNU1+6+kX7qIF+XlEGWJlXK+iwzRsNK
 y5u+036C3M8KbCR1P2vBiFhqiB5Fwhvs1XYe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254353; x=1778859153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7p+Vo2MAZHO9bgFQIpn5Lg3bsEP0zQjCLxw11F1jqY=;
 b=F/fpf0V6Tj4eM7NJHP72ZewBiXcBDDdXUEGZiLPGY+SmSfM7vfpWxaK11n5ljffiVR
 dzydOzmu0N+a+ZcJO/mtLUJ7n4d+u7/KlxgbLJLUVzdgVv4CptE1x/E1+tS3Rn06brl0
 P0dE9m5YXiFStqr9r32ZxSDq7W3vsyu5tpT7zh1tLH0Qy4BikbYbLZmcVNYgPbZVl4M0
 +N/6JJRtJmBu7c9gV/5Bc5JnNUI0P4ocn9GgdhEd2vDhBcnq1uUyc6IvHeTYYTWLz+J4
 azd/8QA//lzO02OIW7NBzOwG5G80j5fWr38QOvN34wcD10BacRa5Vr2ptP92hMIaH9PS
 09UQ==
X-Gm-Message-State: AOJu0YytkO9qpyF3d4ont/WTrOz8Qss9nMs4pc37N7zHq1LfQ09q2Kgp
 Vt9BEas1PEm3JPnhseNrGuUFrj2sIfYhRRV9w3nt7VH2Uw/qbxp5YN4/oB3wWI18XY4Vqpznfi3
 L9p3Pt+G2u884+GNXA5/HkFiESgJd1NMfs5J+klkj
X-Gm-Gg: AeBDievnh0mrbNU94kJc6rkNT5IGKVvUQ+es+JZeElm20eznQJdO2vxR08IlGwu6LpN
 ZHFp6LXw9+Ea+zBzKBhx9VQNCtSyEsoauHgzk4dV1AygpwRN+m8al4oBP6f3ke/skDmWUrf7sc/
 6VrX4k54+ZUVlYWfN98VtMN2Xq0FYZIRWai0nqlEH325cXxXR4bPcuPWD32oTrNTuvavT3M3aUl
 HxOBHUz/Zq3wcYvMjfA/dWRUM2Ho3hEhHtT4hgFJRe6DvbXBcNKL1gxG6xW88Fj2WncmWK7a2pT
 eMMgX7CIGoBFmYnY
X-Received: by 2002:a05:6a20:6a13:b0:3a3:327:c5c9 with SMTP id
 adf61e73a8af0-3aa5aae76fbmr13958143637.26.1778254353354; Fri, 08 May 2026
 08:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-30-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-30-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:31:51 -0600
X-Gm-Features: AVHnY4IFc66htMdK-PWcUbzAO3POcpOBYVMWmBFaJjsLsQOBCJ-XhHtjgpC77w8
Message-ID: <CAFLszTiVtMK5aCoS6ULES3wG7W0__U3WqTcZYerzGcn_-LvwmA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 29/64] usb: dwc3: import from kernel v5.5
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
> usb: dwc3: import from kernel v5.5
>
> Sync Linux kernel dwc3 changes from v5.4 to v5.5.
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
> List of commits: git log --oneline v5.4..v5.5
> Commits imported:
> ea0d762775e2 usb: dwc3: gadget: Fix request complete check
> 3c3caae4cd6e usb: dwc3: pci: add ID for the Intel Comet Lake -H variant
> 2d7b78f59e02 usb: dwc3: ep0: Clear started flag on completion
> d3abda5a98a1 usb: dwc3: gadget: Clear started flag for non-IOC
> 8c7d4b7b3d43 usb: dwc3: gadget: Fix logical condition
> c3afa2224345 usb: dwc3: Fix Kconfig indentation
> 7170d1a4cc4d Merge tag 'usb-for-v5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
> dcf5a2c390a3 usb: dwc3: create debugfs directory under usb root
> 16c8373ecf7b Merge 5.4-rc6 into usb-next
> 726b4fba94be usb: dwc3: of-simple: add a shutdown
> 038761ce68c2 usb: dwc3: debug: Remove newline printout
> 9ba3aca8fe82 usb: dwc3: Disable phy suspend after power-on reset
> bf7c1d95af67 Merge 5.4-rc3 into usb-next
> c2c1c66b5d43 usb: Fix Kconfig indentation
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c   | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc3/debug.h  |  4 ++--
>  drivers/usb/dwc3/ep0.c    |  8 ++++++++
>  drivers/usb/dwc3/gadget.c | 12 +++++++++++-
>  4 files changed, 58 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
