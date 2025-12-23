Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B521E748FC
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 23:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F14B88419D;
	Wed, 24 Dec 2025 00:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LN1fndBe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84E3C84189; Wed, 24 Dec 2025 00:15:49 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C947D8418A
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 00:15:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c7613db390so3115144a34.2
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 15:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766531745; x=1767136545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KzIQEDUCf2PR1eS1EgN8uTlMSImlFHNc9Vj9B/c1CFw=;
 b=LN1fndBe9/wo6LSd7ZmHwgojxGu/QwwO0CLCmsLaEiEFLoObrC2i4s5TW1MKroAfpP
 IJs75PWSiRdlhWWNjKVDGtQw4f0GA8cIpXs3MtkgTeLHNCdAdXt4mpB31uqioijGKvme
 nOkz5lH0FBNG5fY24j0QbnK5eBHuH/iWsXfzjqWDXk7bpKpjJ2wwJlJQCcLU8OLFZtuQ
 OY7w4F3v56EVlpzfZdef3QZjDpNwCxNNv1db8sinr0DSM4Yo+yQ7LALTGNh46cxC6JDD
 8kTA27j2BwUFB1LIrguocFh79TaAD1V3ZfF4MC/x2H93FqmcIQ+ILjDs6yvAhXUiAJr+
 E69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766531745; x=1767136545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KzIQEDUCf2PR1eS1EgN8uTlMSImlFHNc9Vj9B/c1CFw=;
 b=mZ7/v6x7RoelmCDeetcR3/kzHjdFOqq6wYgHmU+jwGcoxuHL3SgGbJ1xHjiPUCJ4Hq
 wNzuu00O26rcjBV6ugz2rAuEAYhP7QJsf4WO3yxK1cymUVAc11u4t450t0mNsZq1OEt6
 YP7as9Nrx287Y8YfcnagF82knwFuSAS7fJ1tUhTo0dLRqgOjumgrPts3ncFIFp/eaWit
 VYO6BEYYYbqiwvMJRSUQtddWHGGwnli7/3RzOQdQhYFnfkRzC5GVa2+7b55iWL9DqYHx
 WIzoYkJUwK1yG64ibN2ScmedIsdN/E1XELlqDkiQG28u8OB3E64Xxg/O6L8x6Koxso24
 RK5w==
X-Gm-Message-State: AOJu0YxOpc9A49FzuXYofyFQjd3knGctg81IgB2WYZFExpFXL0ZMMGx+
 fIL9dAy4prZ5Ud095y+2tEMH8v5BfUI4tc1fyDaA2Pn7wlJCaAzOuZvm2R4N0kA6
X-Gm-Gg: AY/fxX79m2sVDRcGVnqI2vb7lt3eDUXPCzVRFgnw4m2dPZhzWtb1wdtDzTxYTDF5rz0
 bIJbK/9ByZImLLrOwVtgt7N22fLO/j0vM6tX13Dull1tpM2yqTclIv48JUTj6cQkB7AWtRsZdR1
 bptwpZPeO+hU9LTpzPqB3+tNErvK4fZKRCCS/z5A6Za0+B4zKQthsPJDxsAuJPgJGNErRDKXN79
 WugjZiCnR939NySpLeD2BXEeBpe146inwpFwZxFVoLP9CRzWR8r8OpSiCgmrV8DQbd543Qw7ocA
 wj6sVLDSx3VWEeJ3F5fIpybrJZe/vWP6DpM4GgU01eRsG+8H/7G5XfMzIEmTtUwtwZEQ0U7D/2v
 mNGveD6j6zheEmns62tbVzzAukMMRnHHya2+pjCEwzkKftRRb3PtY3d/47kluYJ9eK5zsQIfMQq
 HHrl0z/yz9
X-Google-Smtp-Source: AGHT+IGRkJlngFqgi3BGW00aW11Kzy/loRwIpoflnYrienYb+vnAmBia88SdogiQPlvvUTHXMC0sBQ==
X-Received: by 2002:a05:6830:2b21:b0:7c7:2c64:941c with SMTP id
 46e09a7af769-7cc668ba523mr11056209a34.12.1766531745056; 
 Tue, 23 Dec 2025 15:15:45 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667d4f62sm10352037a34.19.2025.12.23.15.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 15:15:44 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: thinhn@synopsys.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 felipe.balbi@linux.intel.com, mkorpershoek@kernel.org, lukma@denx.de,
 trini@konsulko.com, marex@denx.de, Chris Morgan <macromorgan@hotmail.com>,
 Mian Yousaf Kaukab <yousaf.kaukab@intel.com>
Subject: [PATCH 2/2] usb: dwc3: core: improve reset sequence
Date: Tue, 23 Dec 2025 17:13:11 -0600
Message-ID: <20251223231311.1983423-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223231311.1983423-1-macroalpha82@gmail.com>
References: <20251223231311.1983423-1-macroalpha82@gmail.com>
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

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/drivers/usb/dwc3?id=f59dcab176293b646e1358144c93c58c3cda2813

Suggested-by: Mian Yousaf Kaukab <yousaf.kaukab@intel.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/usb/dwc3/core.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 847fa1f82c3..b4de2e95a0d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -59,11 +59,20 @@ static void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 static int dwc3_core_soft_reset(struct dwc3 *dwc)
 {
 	u32		reg;
+	int		retries = 1000;
 
-	/* Before Resetting PHY, put Core in Reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-	reg |= DWC3_GCTL_CORESOFTRESET;
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+	/*
+	 * We're resetting only the device side because, if we're in host mode,
+	 * XHCI driver will reset the host block. If dwc3 was configured for
+	 * host-only mode, then we can return early.
+	 */
+	if (dwc->dr_mode == USB_DR_MODE_HOST)
+		return 0;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+	reg |= DWC3_DCTL_CSFTRST;
+	reg &= ~DWC3_DCTL_RUN_STOP;
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	/* Assert USB3 PHY reset */
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
@@ -87,12 +96,14 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	reg &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 
-	mdelay(100);
+	do {
+		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+		if (!(reg & DWC3_DCTL_CSFTRST))
+			return 0;
+		udelay(1);
+	} while (--retries);
 
-	/* After PHYs are stable we can take Core out of reset state */
-	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-	reg &= ~DWC3_GCTL_CORESOFTRESET;
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+	return -ETIMEDOUT;
 
 	return 0;
 }
@@ -137,7 +148,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 
 	if (dwc->ref_clk) {
 		rate = clk_get_rate(dwc->ref_clk);
-		if (!rate)
+		if (!rate || (long)rate < 0)
 			return;
 		period = NSEC_PER_SEC / rate;
 	} else {
-- 
2.43.0

