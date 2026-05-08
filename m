Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621F1CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EA0784D42;
	Fri,  8 May 2026 17:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PZwtUNBN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6CDE84CF2; Fri,  8 May 2026 17:32:02 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED3CA84D41
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bcb0eb7ba03so91882766b.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:31:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254319; cv=none;
 d=google.com; s=arc-20240605;
 b=fAfJu1mnuY3FfpUsPDSUYgqptS2DbXQnnwdQ+QwNPvySIZdq99HhS/avZAXNs7CowO
 WDfezcsCLZilQ0cq+D/9pv3sJYJR2hRA7SGX4HAj2HQ2AbsYPwxCFyg71964gQbt86ln
 DyxVghblMSUKGY0Cw5r+7ePnu4D5/gM64k4LCzKOOASMMqqP3A+knPnoO93pcdjALPdw
 6IM06Uh8MkRuAxLP6uBANBU+SVjTdDaKI2PZ2PVoWm3U7OLUvS4MTD14Fk+uF8CORljK
 GOublRcd6uYDj076+ODdQbEbs0YAxkb6KnUa8Bk3ucYBBzb6cuvFXEPqImNl5R6aGFTy
 OpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YZki/AqN9HCAOuuYNp6/7acJ2mUlhTnr7AbL7eCTrMY=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=iZ/vrCGgyAwX7QjD2oHiYAPKbWzMnzktQ9pvpaeNTWqQZh1+wl65H4XNYlo0AupMDo
 3rQbgm9MJE7dwNHW7vYLCpXvn+bJHi5t9gGaT5PZgXtsCueLCKRhv/VUq1Bit7jn6QnA
 wPK8xS3GofRyeKXlxoexuV1U10w7klUWrOweOR5lPBgTOcN1RAiRPgXVluzM9NVyxOdG
 r2WZ718pLJhbJCBXB5Y3D6kjuW4HQ04mOD+M7DPuTJogg2HcE8ch767TGV3r6ZRW88zn
 mTtUIcrTKUOZNrQRHQefXfjLuI36XBaZa0rff90lu12xnTX2arikf2KrdJkXvYQ5NTCP
 LZkg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254319; x=1778859119; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YZki/AqN9HCAOuuYNp6/7acJ2mUlhTnr7AbL7eCTrMY=;
 b=PZwtUNBNDiSDYdYli/WCkS6E/8l8HEQ9a3V2qUsaG5PRSrb9KAnr/I9W5L48ezRlUd
 1Y+MKIpi87KDdUWSFWMcixAXqivSF4U2rh9iqd0fTuFD7zHtuiEByjk1EY/qpiwBRT/4
 +ywEpgWaNJ2N/SYNLX/zbDkkmq032nrQtAGmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254319; x=1778859119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZki/AqN9HCAOuuYNp6/7acJ2mUlhTnr7AbL7eCTrMY=;
 b=A9ysL2Jn/wiQVQbIONdSqfMWgiLhfe6zm38QMnzKeWRv1xuJorjdCs6vn13cmQ2fmL
 X0aF/J8ie3RNrd5VettKWCdyOms9Y3bWpdUg5iWNOVesoER6738EgY4febpzUj0R57gG
 GmLZervfOiORZGI6AJn3x46MzCg7Wo9LGHSlePUP/S+T3CwA9g6sxDzQsOew8YDC0+OS
 rJNEkGiXcfa1Qs8Yf0iLqPpJ+bL/nCmcFC0umCRiZLD74A6JQyc4dZAiK8Br5N8BXvh7
 WLdwzjjuAl8CtSzMf/4adgR8eQG191ER7LJ+zT5t4xe/LymNz3GBapg8Oj4q24yMbUZw
 C40w==
X-Gm-Message-State: AOJu0YxM4faIjG8sMM8MHZlg2XW8X0Wo9rm5yQmkmOjM2Ncvj7KEX0IU
 vyaIf692H+K+WIjL19dlZIaGMqzLu0xhOnCpq7GOk3HSVpd6z5X5vg78j1HR2pcjeQCM5rRiAx0
 JhJYJubjV6pKhDV+dZ4T67OZLHpY4s6/2ahe3L/fH
X-Gm-Gg: Acq92OFfmkQdA5BLsXHck8G/BVw8hAWGVFQBZCXIymoAIybIeTJR6lDtBCpcw/Wf7e1
 QoITITUhbi3erEYihLbtfidnVj3d4MZVN7MUomZuJoKtG//hHKAC6ZK50gOYNwirZEbC9IJUXBB
 Pkuj7AQilLo7nnOFhOTCd4nOGQyOYlmu2B277hOBj6Xz3WFzVMNZ8b2icNcZcr6LyXe/WMMk8Q7
 BCHlA7/b8VttUq2NTYIr8ZJQ553aBlV+42QV0BjLP450iSwAouvibKM3N/YL925PPMLr5VTGKM5
 n/8bAA==
X-Received: by 2002:a17:907:d08d:b0:bc6:d873:fd5d with SMTP id
 a640c23a62f3a-bc6d87406c2mr615268666b.44.1778254319271; Fri, 08 May 2026
 08:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-27-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-27-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:31:41 -0600
X-Gm-Features: AVHnY4JYk0NpxVSfT2RZwAhkaI75x1aMDLnOxCTT8biz2Dg38Q9jnfGYNBcVE-A
Message-ID: <CAFLszTiZ47o5PLGQ+T_Y9qbQr0nKgw2Zp+vN8gi00a1-a-C23w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 26/64] usb: dwc3: import from kernel v5.2
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
> usb: dwc3: import from kernel v5.2
>
> Sync Linux kernel dwc3 changes from v5.1 to v5.2.
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
> List of commits: git log --oneline v5.1..v5.2
> Commits imported:
> a2d635decbfa Merge tag 'drm-next-2019-05-09' of git://anongit.freedesktop.org/drm/drm
> 2e487d280525 usb: dwc3: Rename DWC3_DCTL_LPM_ERRATA
> 8d791929b2fb usb: dwc3: Fix default lpm_nyet_threshold value
> dd24f9b604d3 usb: dwc3: debug: Print GET_STATUS(device) tracepoint
> b873e2d0ea1e usb: dwc3: Do core validation early on probe
> c729969b2b69 usb: dwc3: gadget: Set lpm_capable
> 41a91c606e7d usb: dwc3: move synchronize_irq() out of the spinlock protected block
> 75ecb9dd56a7 usb: dwc3: Free resource immediately after use
> c0c61471ef86 usb: dwc3: of-simple: Convert to bulk clk API
> c99993376f72 usb: dwc3: Add Amlogic G12A DWC3 glue
> 67130830ce42 usb: dwc3: Allow building USB_DWC3_QCOM without EXTCON
> 6e865c723014 Merge tag 'drm/tegra/for-5.2-rc1' of git://anongit.freedesktop.org/tegra/linux into drm-next
> f06ddb53096b BackMerge v5.1-rc5 into drm-next
> f31d5c24fb2e reset: Add acquired flag to of_reset_control_array_get()
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c   | 18 +++++++++++-------
>  drivers/usb/dwc3/core.h   |  3 +--
>  drivers/usb/dwc3/debug.h  |  3 +++
>  drivers/usb/dwc3/gadget.c |  5 ++---
>  4 files changed, 17 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
