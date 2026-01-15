Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA1ED46634
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 23:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CBE883942;
	Fri, 16 Jan 2026 00:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VWtEAFB+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA12983935; Fri, 16 Jan 2026 00:04:14 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2902838BB
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 00:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-661084916c0so725270eaf.2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 15:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768518250; x=1769123050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYil7sAe40SSA1ZN3eBOaNRgc2wjl0zR08iKiUgQRZA=;
 b=VWtEAFB+7OtYsBkzl1vS/CWlzg2JX4oZ8YCfCsVf9LMUpQ0UE3M8vrA9GlaCxV/IUM
 bWd+zHHIFAWMiCjud3wmehqM9KRmmz2BH3tHYpo99mCP67rd0bnIksJkW86nIRTKIQmE
 boqTOjgJRlx8S4HOxT+o87bASIn3FntTvzMyqqkFf27Yzdx2byWfTKwNodIjnTUyY+8a
 crjdPdqsoWygpK/5e7HB9DrtlT/zMIU24tiv9bgwdM4DIsYK6a1D/fx1rQJgya0GTUYn
 LU9S9UlUqJj1T+Y+oiIF9gIGnYaXBEgoW32cytHp4SDeY4A4MRIz6IObdckJnrpaOX7K
 Kmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768518250; x=1769123050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zYil7sAe40SSA1ZN3eBOaNRgc2wjl0zR08iKiUgQRZA=;
 b=epsHpuJR8izY92+6APiNSBVLuvPM8ur+WOOTl4/z7FxbYmfznA86o9hd9KwRyM8WPb
 cxpo7WV9QubDyxammjx0bqkLrChGfFEF1OVvaS/M/CLM08rfyXfC/YWHc0Iqh7grpvt+
 j19os0RhssAbpqDLYQZlx11CqQOIbdmDeQYom0ifbb3ia3ACN/T6RVytjHcngfDU9QSq
 39kZ9bqInew2EM7fELVbT5IXi3PuHml/t8GcxltFPU/cNU7nvAGZGxIQIWcNfYPsY/ig
 KK1S2BtFB7QEM3JinAfyW2QUv8Db8hPJJccY21SZwrYZ0lq9+6kVdjwrzkEeiglaC7+X
 V8Lw==
X-Gm-Message-State: AOJu0Yw/1rwX2jG3bLOqjktbz2xoDqGtjtru0VGzDuWLDEUnfYwW31h4
 ZjLeLa8DkYoIgqsNvJn0cMfbgQeeS8PpPotEBJtny/lp6n3VITzadYqUhOhtUw==
X-Gm-Gg: AY/fxX6dayXz7D1HFPpE0auvENyaz15IHR3pUnjiSh6cpl3+ONOwsLfnLoVo8aONvxZ
 OumbdGjF5KX/a1kDRWrhxkoqdz9ILfrPLh5ghXwZVsc1+tHWHXd1uEvNG9E/jUSt7gKoeAm9921
 yAXLhv+2N9YKbFjxpTpR8GtnMHCnDku4cL+jxnw3hnHOhR++GkJjij6UmKg+CjfxuocgzaJHekm
 J8Ds/cHDB5hoCInNpZUyZE6E6GLBptN7Rb1D80FTJWsoyyiVdAarLSFAosWIzTeCdzJfkagdoKI
 RGvqNvThFWBNgLu29bHSkRV/YznkPuKYHzWyWiAeHDGXtSi3iuyQ4juF6pbZvjJJaXzuXK43RuP
 Wm3vxYn37jJtHipllsN8gGpvMMbMnAwAMHZoIAlOKRQGsT/gsQAojSZ6LNMznz48gApRHGQWsqD
 /y8SsQwUL5c+Hg+y37K4U=
X-Received: by 2002:a05:6820:4587:b0:65f:5296:8558 with SMTP id
 006d021491bc7-6611896db85mr307602eaf.63.1768518250422; 
 Thu, 15 Jan 2026 15:04:10 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-661187a0000sm394787eaf.14.2026.01.15.15.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 15:04:09 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: thinhn@synopsys.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 felipe.balbi@linux.intel.com, mkorpershoek@kernel.org, lukma@denx.de,
 trini@konsulko.com, marex@denx.de, macromorgan@hotmail.com,
 Mian Yousaf Kaukab <yousaf.kaukab@intel.com>
Subject: [PATCH V2 4/4] usb: dwc3: core: improve reset sequence
Date: Thu, 15 Jan 2026 17:01:35 -0600
Message-ID: <20260115230135.183158-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115230135.183158-1-macroalpha82@gmail.com>
References: <20260115230135.183158-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Chris Morgan <macromorgan@hotmail.com>

According to Synopsys Databook, we shouldn't be
relying on GCTL.CORESOFTRESET bit as that's only for
debugging purposes. Instead, let's use DCTL.CSFTRST
if we're OTG or PERIPHERAL mode.

Host side block will be reset by XHCI driver if
necessary. Note that this reduces amount of time
spent on dwc3_probe() by a long margin.

We're still gonna wait for reset to finish for a
long time (default to 1ms max), but tests show that
the reset polling loop executed at most 19 times
(modprobe dwc3 && modprobe -r dwc3 executed 1000
times in a row).

Note that this patch was submitted to Linux in 2016 [1], however I can
confirm it is needed to support gadget mode in U-Boot on my device.
While I am referencing this patch from Linux I am in fact taking the
full existing dwc3_core_soft_reset() function from Linux as it exists
in v6.19-rc5, so it may differ slightly from the information in the
2016 patch.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/drivers/usb/dwc3?id=f59dcab176293b646e1358144c93c58c3cda2813

Suggested-by: Mian Yousaf Kaukab <yousaf.kaukab@intel.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/usb/dwc3/core.c | 66 ++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 4827c83e96d..6f22b9232ba 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -59,40 +59,52 @@ static void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 static int dwc3_core_soft_reset(struct dwc3 *dwc)
 {
 	u32		reg;
+	int		retries = 1000;
 
-	/* Before Resetting PHY, put Core in Reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-	reg |= DWC3_GCTL_CORESOFTRESET;
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
-
-	/* Assert USB3 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-	reg |= DWC3_GUSB3PIPECTL_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+	/*
+	 * We're resetting only the device side because, if we're in host mode,
+	 * XHCI driver will reset the host block. If dwc3 was configured for
+	 * host-only mode, then we can return early.
+	 */
+	if (dwc->dr_mode == USB_DR_MODE_HOST)
+		return 0;
 
-	/* Assert USB2 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	reg |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+	reg |= DWC3_DCTL_CSFTRST;
+	reg &= ~DWC3_DCTL_RUN_STOP;
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 
-	mdelay(100);
+	/*
+	 * For DWC_usb31 controller 1.90a and later, the DCTL.CSFRST bit
+	 * is cleared only after all the clocks are synchronized. This can
+	 * take a little more than 50ms. Set the polling rate at 20ms
+	 * for 10 times instead.
+	 */
+	if (DWC3_VER_IS_WITHIN(DWC31, 190A, ANY) || DWC3_IP_IS(DWC32))
+		retries = 10;
 
-	/* Clear USB3 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-	reg &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+	do {
+		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+		if (!(reg & DWC3_DCTL_CSFTRST))
+			goto done;
 
-	/* Clear USB2 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	reg &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+		if (DWC3_VER_IS_WITHIN(DWC31, 190A, ANY) || DWC3_IP_IS(DWC32))
+			mdelay(20);
+		else
+			udelay(1);
+	} while (--retries);
 
-	mdelay(100);
+	dev_warn(dwc->dev, "DWC3 controller soft reset failed.\n");
+	return -ETIMEDOUT;
 
-	/* After PHYs are stable we can take Core out of reset state */
-	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-	reg &= ~DWC3_GCTL_CORESOFTRESET;
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+done:
+	/*
+	 * For DWC_usb31 controller 1.80a and prior, once DCTL.CSFRST bit
+	 * is cleared, we must wait at least 50ms before accessing the PHY
+	 * domain (synchronization delay).
+	 */
+	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
+		mdelay(50);
 
 	return 0;
 }
-- 
2.43.0

