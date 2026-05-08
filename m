Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C43BCD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC8A384CFD;
	Fri,  8 May 2026 17:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LM54gw0Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C75F84CF2; Fri,  8 May 2026 17:28:24 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2416E84D32
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso367724866b.2
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254101; cv=none;
 d=google.com; s=arc-20240605;
 b=dn9a0wx5a9DPJktJOPN2o1rN5K9rPPciOyugWOYSPcBV3mU6PD6vj0z8KdMpgsodFG
 n+2SLgtJZiih78U7RRRNniN5CmTwZbgAcN7ip7XhKQOnrvJPNzZdIUvODNVVEv77Zwj/
 s8lN9tz+QQkjFWmnIvgtVmpVjQF/VLKMyP/PBsKDDPCPUJ2YMxLSbaRa3rEywCAi1nO4
 kA/aVgzfWYb9yjfwfQC2+g1xp0pKwJ8vLRZphuV5YDJIlHCQ/Z+dDINHTpjpojBNEGIX
 KZYXz8drQ+J+Wrp7FKYECIx8f2XLZ329l2URRkpBcnwN+2kwex1McvYv2+LkuOvvj2V8
 1rEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dY2K+R44g8hnH2MkL+7+5thGJXNRwUAKj4B5wBSalDY=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=NCNYePS1Anr4x55KmE8+012x0iTYOsShwMK1v6YkITC/hfrLqxtVpsqCrOR1wTdf9C
 nclEdA1ihar5edcfIQ9yfhR71/HqQ9Mrn55seR7qlolqc1YbKmgb6CSQ3srvh8xuWbGl
 PwLJwelVv+W1QPD9hjgPgPbgs0D0sS9mruMG1DqXOLVMjhkL1Gi1+cJM1Y4TObpkCpQt
 SdFSQmeSQasGu3c+jsYlABaXkv5EW2Mg/9BoIdec8RHlM0dF/gnj6+B86GC5nJB/LlLi
 H4WiP03K+KTGCW/dEBKYzc72lyvuYn5pv3GAQyynpxpmTJd+j3kb7gkXZ7tZee4S7bHM
 3esg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254101; x=1778858901; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dY2K+R44g8hnH2MkL+7+5thGJXNRwUAKj4B5wBSalDY=;
 b=LM54gw0QyV56bllp2wY6+vGjBjXpOKVuORnRgz5eUDGd/1Sn9RQ57778CA17oS1Anh
 MJE7AaAe3OgHC7JbMEe2C9OcYWsdyATEyp54A8AgjfnEj3Ik0KXexFnX7xiePvw5g+9v
 WrfmZ00YNUqNFNa2srke4tfduqlna1Ck9AEbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254101; x=1778858901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dY2K+R44g8hnH2MkL+7+5thGJXNRwUAKj4B5wBSalDY=;
 b=ZU3Q0eAfWo2Q/7SR8gqupqJ90ZrP/6hoTCsQ6HFmxHq81HYNHBs8C3BTeaYyMKQXbO
 R1KK2+J7edk6KdU5j60Bsw/HNqYwGyT6zS+k4nZVT9nq80zDGAbWSI9YHj64yrXO/GLY
 G225hP1VPUhoonWxJ3TsDm0XhLZBlsXUxMEHxfK+L2MxFTe1d5n0Q1KLr4oycvlsU8zn
 GaXpOw59g5wdXbD8wSqrZV5v7kfIP/atm7hrWVryq0kRB9frLoeU7rLy6Chc0zhcyj2d
 Sb40sfRG7+9niIZAEh9RHkAQNfNj8Mu1YGTAa3tbyuBujyOPgZ81aLbbM19cREe4JOav
 08rg==
X-Gm-Message-State: AOJu0YztxI+AhTrR0XJnoRjGXPPkgvktJkQVGOr/sxhcESOOGTsCRgsN
 B95b0E1Z7TW6wCQmLjRE7/fusl5W5EWZC02/WORp8HuWQMSRyuqg74mpJFp1HzgcbRRnfgkacyr
 NQjyTqEtFUTXMSXGIKQglAsA5rsS2qLqN5M1BXM+T
X-Gm-Gg: AeBDietRsweFbs49ck/6eRdGf403MJ0OfWNR7HzaI18rSsceXkszDlg/0EPs68ciYX5
 /WzrFL5SuUuDwGW7ghm6sSyzE8GEDJC97+WoWDKNZEOtfbfCNVbT1/tvrEgacVJz73oo78LzyjM
 l/qsgdqOK3qJBa/u6oZyuyJvJOt5eRuVYzHf/BUHHi51+mZq3n/uXb8Mu8RO5sm3q8AvwiH8NBM
 AxQHIYkwpwlG+asJyrY8nHwkXrgqWb6CsoFNgCfz2bvo5E/sE4CwEm5VknpahUCdReTTGAaUHmz
 v67M/qFXmBR0G1rp
X-Received: by 2002:a17:907:6e89:b0:bc1:6ec9:453f with SMTP id
 a640c23a62f3a-bcaa9f60f8amr186329366b.8.1778254101477; Fri, 08 May 2026
 08:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-19-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-19-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:27:06 -0600
X-Gm-Features: AVHnY4L6XCjNUpr-pqACAUzBWOu3i0q8q6ngyN9-9k9YlaULAymkc0uEU_HOWiQ
Message-ID: <CAFLszTjkbsdrifhGFnkzNLcr6bd9L7GnDoG=Ms1KCn7ApMgxjg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 18/64] usb: dwc3: import from kernel v4.15
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
> usb: dwc3: import from kernel v4.15
>
> Sync Linux kernel dwc3 changes from v4.14 to v4.15.
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
> List of commits: git log --oneline v4.14..v4.15
> Commits imported:
> ec5bb87e4e2a usb: dwc3: gadget: Fix PCM1 for ISOC EP with ep->mult less than 3
> a0d8c4cfdf31 usb: dwc3: of-simple: set dev_pm_ops
> ded600ea9fb5 usb: dwc3: of-simple: fix missing clk_disable_unprepare
> 8722e095f5a4 usb: dwc3: gadget: Wait longer for controller to end command processing
> 894025f24bd0 Merge tag 'usb-4.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> b5ea47570b5e USB: dwc3: Remove redundant license text
> 5fd54ace4721 USB: add SPDX identifiers to all remaining files in drivers/usb/
> 644cbbc3ab4d usb: dwc3: core: Notify current USB mode to USB3 PHY as well
> 8eed00b237a2 usb: dwc3: pci: Runtime resume child device from wq
> 689bf72c6e0d usb: dwc3: Don't reinitialize core during host bus-suspend/resume
> 06c47e6286d5 usb: dwc3: of-simple: Add support to get resets for the device
> d6d9c2a3eac2 usb: dwc3: of-simple: Re-order resource handling in remove
> 86763723eee8 usb: dwc3: ep0: Clean up unused variables
> 7fdca766499b usb: dwc3: gadget: simplify __dwc3_gadget_kick_transfer() prototype
> 502a37b98a7b usb: dwc3: gadget: cache frame number in struct dwc3_ep
> 64e010802997 usb: dwc3: gadget: simplify __dwc3_gadget_ep_queue()
> ccb94ebf9e65 usb: dwc3: gadget: check for lack of TRBs a bit earlier
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c   | 74 ++++++++++++++++++---------------------------
>  drivers/usb/dwc3/core.h   | 12 ++------
>  drivers/usb/dwc3/debug.h  | 10 +------
>  drivers/usb/dwc3/ep0.c    | 30 +------------------
>  drivers/usb/dwc3/gadget.c | 76 ++++++++++++++---------------------------------
>  drivers/usb/dwc3/gadget.h | 10 +------
>  drivers/usb/dwc3/io.h     | 10 +------
>  7 files changed, 59 insertions(+), 163 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
