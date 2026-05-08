Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7303FCD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1424C84D0C;
	Fri,  8 May 2026 17:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L2SPoG6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4326984CFD; Fri,  8 May 2026 17:30:11 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF9CF84D3C
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c8027e876fcso851520a12.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:30:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254205; cv=none;
 d=google.com; s=arc-20240605;
 b=dEP87QpMsZ7JMCKmQTWwtkddlTQTbxiXAeQYQq2mRL+5bMZVosBvvS/4PZAr8DV/lf
 IHhpxY1UktKxpdZ6ojEjkn66NoXDH3+ZoKW6GD8IJCYhRUGa+HWWL4zr3bS78vyyrsxi
 91wfV82mfDZGoh+k1wj4J9tcjURnZ5fWAio4U+83L9O0xoT6UwwAK4fn+V5sJghjpXQ1
 RhrBS1OS0NG8ySE/wEowkpvuBUdnwgfgcLjVODVg3O5XHNoMH8W91Vjh06TEDxYV9PBe
 uZEy4Mh/+OMKr1nS7M1oGxeh/eDo/VYFhX9QX1OtyR0gTwkOJ99ik/2VWxYh02eDLocd
 zH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vXjQD+COozUBJ2o96Kj84yvjvoPjRPjx8mNFe6ICW0g=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=JYYNQZ8Lb4RAJ0AY238GUx9/5c8AKzhRmUMBE+yYor5PlBqmyfhU8lVdnC4WNkyH+e
 55Okx2Vn5kpZFpcajuS1w2aWxk6PLk/ck+83gLx1Embp5Erf6iCx4Pu8r/mV4ilZp0g6
 ocQWGJ2KEde3LVZB61qB6OC7lRHHt46pCY4KE/Ki0/O8i/OlIhcx7U3xfGOqoDNM27Cw
 g4nL/1+aAXXv9Db1UkfhKDUzBJaMDIQlHocJ+mluDcmrNfVehGOeZedFeYD2XNMPIufs
 Hk90kpW+OzYHXj80A0o6+RJHlpBcMuWgYNFTAAXe3dEfIhlHZpzTZNKdTiWieKiZmMGj
 6Ulw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254205; x=1778859005; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vXjQD+COozUBJ2o96Kj84yvjvoPjRPjx8mNFe6ICW0g=;
 b=L2SPoG6erV2bi9DS5bvuvBDROuoyl+a6j3kOB/w4SndAtY4iHSpOEDxA0xE0NCIqCE
 a6TWzETB4552+Q8RIdmgmArtEv3ixJxaXmmQtK+VMsUrRQq8ae2/hXIfU/+JbvFObWX3
 u6lbw4Ux24vVcH7AuY/X2ZkUTirBxbm+3dULY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254205; x=1778859005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXjQD+COozUBJ2o96Kj84yvjvoPjRPjx8mNFe6ICW0g=;
 b=af4HYcWHR77e0r4Gn1NaN5yVFyzKBMeQQ/h3+wQ8LWY6IpY0h+rn92R/XE6RcE2lMo
 NXQZwZQVF0w7hzWfpFEoFCpgM55bCowHUOGMmqNmDBO526ZoqYAT6m4xwJDlkKWV6eAe
 wipUstUZUXIi5NBzw6C611l1zQqCi2Nonwr0a38YKiYKoPAoKnP6iDy3J/mRM9/Tru2Y
 sU9y5+7PDgbG2rzpWMRgNA1+ut4havMsrqAuM2V7g48xy4EbpUT/i6L+fyt2r/XCg4Oq
 weW19hVqGm86Ej5/0tt0zE8VFIx5jcQLxZM+UbT0ydIWomoe6Us/pp152/2b9vrLHdCL
 pVkg==
X-Gm-Message-State: AOJu0YyZ017qJHyYvxe/rkQ9mF93x3fwGwGWAS046jzrgYg2NbZcJySw
 Dygdlj1IJO1naCg7TSso8Wogmz3EwBpdPkPTIlBSO5PdUmMV0mgDcrsxJLd3a6P2kYxFKZXco+O
 Q+GddMUtbZkh3nM+dBUf8NmKB+gj7PXJWsq9YIg0j
X-Gm-Gg: AeBDiesAxjTJVsTfjenK0hQxIY4gJmc6rpsJpZmZWoDqjTapgqx9qtBWGgLcjN4YR6K
 ysCbiejAMNwuITaG24fp683NuUhUy83o0MLA2mT3OqwCKD1Uftgwy+ruBs62cV3Bi4iQ8ITlwXL
 zaCl66BqaBiaPvUZFEosq2c9rHhVWdT5DXmzBW5Wgqd4NkqXEtt3NHpLHSJrPi1Mx8BE8z3tUXd
 yycCZ1cpvCEE7ZCkSosM1bCDLB4GnefBJA1/R+ZxY14loEIIfx4PIsBVaIOxAsdbq6uvkHZoZKD
 loyuDZ4dYKzE/uUG
X-Received: by 2002:a05:6a20:7fa9:b0:39c:787:f196 with SMTP id
 adf61e73a8af0-3aa5a99f496mr13892336637.16.1778254204917; Fri, 08 May 2026
 08:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-24-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-24-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:28:57 -0600
X-Gm-Features: AVHnY4JSosRqXj9cDm8zo9qua-XXUEcN-VNDuPC1ZeYVkINagl1veuPsrXMo39w
Message-ID: <CAFLszTiAqfWXOZrUvyorgpd4TVrKHCS1g4jWgVtDww-T_0Xq1w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 23/64] usb: dwc3: import from kernel v4.20
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
> usb: dwc3: import from kernel v4.20
>
> Sync Linux kernel dwc3 changes from v4.19 to v4.20.
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
> List of commits: git log --oneline v4.19..v4.20
> Commits imported:
> 38317f5c0f2f Revert "usb: dwc3: gadget: skip Set/Clear Halt when invalid"
> 2fc6d4be35fb usb: dwc3: gadget: fix ISOC TRB type on unaligned transfers
> 7b412b04a0c7 usb: dwc3: Fix NULL pointer exception in dwc3_pci_remove()
> ba3a51ac32eb usb: dwc3: gadget: Properly check last unaligned/zero chain TRB
> 08fd9a82fda8 usb: dwc3: core: Clean up ULPI device
> 6af19fd10595 usb: dwc3: Fix spelling of 'optimizations'
> 87dd96111b0b usb: dwc3: gadget: Check ENBLSLPM before sending ep command
> 3def4031b3e3 usb: dwc3: add EXTCON dependency for qcom
> 4c19cc14064d usb: dwc3: exynos: Add support for Exynos5433 variant with all clocks
> 9f2168367a0a usb: dwc3: exynos: Rework clock handling and prepare for new variants
> 1e041b6f313a usb: dwc3: exynos: Remove dead code
> 755801cb9feb Merge tag 'uvcg-20180925' of git://linuxtv.org/pinchartl/media into testing/next
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c   |  3 ++-
>  drivers/usb/dwc3/gadget.c | 42 +++++++++++++++++++++++-------------------
>  2 files changed, 25 insertions(+), 20 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
