Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0432ECD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5743584CF2;
	Fri,  8 May 2026 17:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FyIhOO7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033E884CF7; Fri,  8 May 2026 17:26:34 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC10384CF1
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6746d0b2b4aso3264435a12.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778253990; cv=none;
 d=google.com; s=arc-20240605;
 b=FjUc5GztJjjMPCUOvAVhTFVhupM4EwzMBe9b4BOPIHftRDEKNz2004ypTHPyzVFXNQ
 2+aF139kDhV0RwVIO9DT6wk9tZ9TMVvm2HWhd/H3UZ/Ra4fAwDvb+n/9YLSsGP8ae9ca
 FsDcgauTpJSolE0IYYf6IlRo36c9aRH5Tvn/EY/1d784cldMk/dPZpfaqSkwefmFzytX
 7Zh8uaxGaE9KigjbWm7yxnEacbsBRilosR7+3xvjPbjRg1gBh3yDky7A0QjL2YoLvdQw
 DU21Cpet9xhKkHpbm7+Pwrv/4XDc7l0GIt6HJn9qGAJVdPNh9u2U9AVArT0DBdvUGexI
 Eq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ry93jIGqvYAfvCPFssiMKeyvUy+sei1X+5X5CXLX5xY=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=Y/p0nKRQ1nHu4vzuLoQh8Np/EoJa7lIJjYcpxa19N0G4cJSfFYSqqzMNe6WUlnW6dR
 OHN3ZOYhZ0yH1kB48Wl+V40GrLLzzA0eHE/emEpVxCD6gSW830kMwv7yNdVi16B3MPGx
 mJ99s22IhfS9qV/8+KvvLZ7NoO4TXQetEGvjmkUKLz1ySAZja1xV6mb+uM2qLfqHUQPO
 yyxKQJQx3DqD/T6s0JGn2B7+M6REvLwfsqlTmHRRp/A7h5SyATCEZqjvHzcANDtQ8/PJ
 Oe24OZr8Qb+lRCoFiuBzWRUnx0Fb3gpKoYx7rx9yP9xEOkirepjAHdpa2evpbmGeq/v0
 L6Mg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778253990; x=1778858790; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ry93jIGqvYAfvCPFssiMKeyvUy+sei1X+5X5CXLX5xY=;
 b=FyIhOO7x+t65rMt1XPMs5dOfhqtSzH6ZS2qffsfOxRrjJEk7cEFSPgkhp/9FjkhsiB
 7yJc6f/ffBkrdVC1eJ8x9z78CkLxnKY1d8sUVqwScTACOFzBcKulyaa4rsbavjoa/Xsi
 mlPO0pv9kwvIosv+etra1BoMjTs2LMZjRsyaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253990; x=1778858790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ry93jIGqvYAfvCPFssiMKeyvUy+sei1X+5X5CXLX5xY=;
 b=L1Db2U7w0X/A0GXmMc1B7Udq9R99cud1BE24OtTh+Wxu8OyFoI87UySxFy9LFIkYMT
 Su5ilWCZVXDHiL9KVPUB0d7eM2fDRJHxnyde+xGW/MMu0h9oPLFNOHGwDPSC4/tN168D
 RVz/zZIwWrDAWj7MqYUXCn2qUwjcmMl8u4Z4J/fAWkgcw5wpsCHGfx7NeG45BIBkk0Qp
 IJxuUgjpxQ1e1GpE0QTakk/XbIHXIAWy0RtspTfUbuNI7A5fLdvn87G5RcDqq2hgCPao
 C2U5Q7MQWDNWsqJac0iWOUPQtg0zxFbG9XeJyMKw/fDeH7r2rD/iQZtIkQOoohhMshMn
 jkHg==
X-Gm-Message-State: AOJu0Yzgt0V3Qi2o7cVDtZZUOL+1j1lbAIQ2++9RYjSTlS7gyu+CupL9
 TMs4jQDehH3tYDTayuTvtWC/RrQG34Ftfzzk2pcYzcWnX3z7luo25COLTUDCivxwd3l1srF+0zc
 4bYBLBo9gamsuWmh/sRA5Z4fJqbn2zBWkFsW1ZG/m
X-Gm-Gg: Acq92OG3Po28GCq3trSj8YDK8ccZSUo1uq5zWJEr6LKC7nZM693q9xP21c+qig7by96
 9v78DpWDNiz9boEigxL7MtofUmT0fbwWOJp74UVyPRckFdiUoEZq0yhGBxi7PHfgnFsj4uz4sLz
 46dkiYrC17Ir7Aq74F4Wa9+EeFdchw4Ul41E6hb4knOzMnHVygmbi8Xt7IiFrY50BSHsr13ZP6G
 DzbtTknQ8b2y/eINiAE576jnMO6zN+mm2lmojsN0STGdr2Kw/Dcztxuz27LDmd0rSvOm3ebRDpF
 ZuJdEpwiEyXsmCBa
X-Received: by 2002:a17:907:70a:b0:b8e:796a:fd5d with SMTP id
 a640c23a62f3a-bc56f303d16mr881437066b.39.1778253990435; Fri, 08 May 2026
 08:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-7-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-7-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:26:10 -0600
X-Gm-Features: AVHnY4LXypwz-NfATqYorFzvoou1N2w6aM2aycUP9VzvLfe-PSAWZRh8J2H744k
Message-ID: <CAFLszTg9E7b+nyHfULivEHBMZHYbTjGasr2X8b=0R1cUAvfRSA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 06/64] usb: dwc3: import from kernel v4.3
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
> usb: dwc3: import from kernel v4.3
>
> Sync Linux kernel dwc3 changes from v4.2 to v4.3.
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
> List of commits: git log --oneline v4.2..v4.3
> Commits imported:
> a66c275b3d5d usb: dwc3: gadget: Fix BUG in RT config
> e2ae0692bf6f usb: dwc3: omap: enable irqs lately
> a474d3b73ba7 usb: dwc3: gadget: add ep capabilities support
> c0bd5456a470 usb: dwc3: ep0: handle non maxpacket aligned transfers > 512
> 2abd9d5fa60f usb: dwc3: ep0: Add chained TRB support
> 368ca113ca0a usb: dwc3; ep0: Modify _dwc3_ep0_start_trans_ API to take 'chain' parameter
> 8a3442205630 usb: dwc3: ep0: preparation for handling non maxpacket aligned transfers > 512
> 2e5464da4e7d usb: dwc3: ep0: use _roundup_ to calculate the transfer size
> b2fb5b1a0f50 usb: dwc3: ep0: Fix mem corruption on OUT transfers of more than 512 bytes
> aa7399744dd0 usb: dwc3: gadget: defer endpoint name change
> 7eaeac5c0e44 usb: dwc3: gadget: add a trace when disabling EPs
> d9972f470bcb usb: dwc3: core: remove unnecessary dev_warn()
> 2df033ca39b5 usb: dwc3: pci: make better use of gpiod API
> 5960387a2fb8 usb: dwc3: omap: Replace deprecated API of extcon
> 9fcfa463e17a usb: dwc3: drop CONFIG_USB_DWC3_DEBUG
> e746b06cc76a usb: dwc3: st: remove two unnecessary messages
> 2babd0d148a3 usb: dwc3: qcom: switch dev_dbg() to dev_info()
> 42f69a02e7ab usb: dwc3: exynos: switch dev_dbg() to dev_info()
> 9ff0fdca3b62 usb: dwc3: keystone: convert dev_dbg() to dev_err()
> e4f756675467 usb: dwc3: omap: drop dev_dbg() usage
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c   |  2 --
>  drivers/usb/dwc3/ep0.c    | 92 +++++++++++++++++++++++++++++++++--------------
>  drivers/usb/dwc3/gadget.c | 61 +++++++++++++++++--------------
>  3 files changed, 101 insertions(+), 54 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
