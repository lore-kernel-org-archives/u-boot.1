Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9EEC79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6181D40755;
	Wed,  9 Sep 2026 12:46:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1oikdZ9NjmFc; Wed,  9 Sep 2026 12:46:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 000A34073B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957962;
	b=i0c5FgvZbN3R6oYkKo8McHF2h1PwdAXadmwTz2a1/wvMm+WtuuWCweo27QRIC2eMrPx9
	 ULznf2Od130qvWhYVkzPgx7GniwZZccN1F7+4yZYuiMTZoPVSnhHC/hfmCkMbW+GY67wu
	 q1u5SKfTMoSuVDlkiv9Y8lBTiFxQU04N/1wpfFQt8TeGzWeApLLzP1ZJPSSoIRl/1IwHn
	 EBc6R8R1FSVtSfBdxXWk81CSU15M3a6VwuhhKMM2KTuN/ppcO8IcaGrMszdKejylR+Dkl
	 ffiA1oPgG82lUmJiLTN+6XmUXAo4cDzSdkk4wr24yrvhv47gxLDiv0e+3lZ8DErh4tA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957962;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Zu4myBCENGDa39S6adNwIcYjaDG/BKNJ9paH9K5+/3g=;
	b=VTkRaHXFotr/9BG6GBJhhMMTsvLYIKyfKpuIzRARp+Yrra13Jlt7EuS+quNMve1nQTdQ
	 nfMGlPvy0M0fLcGdxDdDJOW0/KSBb+dApiDPuQDmuzMgzptKtw8k3zGXJ0XCrrsQhogw1
	 oPLNJ2z5D3zwGQkSGCehZTglLUbKgQx6XHFHT1Lo/WguMHxLxEe5cq29wGIScNNiLCAqY
	 /dmIrT/RciG08FGRzXf5ev5xoV8AAzsi08y2XumKi08/pvv86Wer9Hq5RY/9De/IzdbNM
	 HiMeVWWzS1ljrbg+kt7A1fuBMkvrfIk2yzo2tkHcAvLCMckgZPqCcmlziCs6f1gbi0w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957962;
	bh=Zu4myBCENGDa39S6adNwIcYjaDG/BKNJ9paH9K5+/3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oo4Ry9BZ3ZNGnYoEcqtRpjySg0rEhlc0jBLto5OKA/huSdvgQzSkneiTWfY1LpWs5
	 UuwV/IVgz/qof68Jx5XMtopkjCCvgMhiv48KbmaDhvX/zX51lE4s/MT8yhuFMAEPPb
	 OCXWjrj+MXMf3mCa4K7SABUN2S8/wYkczNO/L7sAhRlWfZbdIa3dsYxQMTEaaYr7L3
	 11Pl4H6RyaFksimsNU/xlPy5HyxsCCNlpEzAJNDYDTzj0I97/eQ3T9QbUX/JACuyBP
	 gADC0vAO+Gdtyy2SkY8Ju0o0UT7ZXSv9ohedwp+j+hRvlUCnPmw9od9Ncngj73nFnu
	 HEfZ6SbyHbgGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 000A34073B;
	Wed,  9 Sep 2026 12:46:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A70153AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9908E400AA
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id omV5BEdSwDA4 for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:51:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org AEA7C40055
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788943879;
 b=k0OuwZSUnLshK70mf467D0JTa6yymQmET1pGV+vVqekUC254qczecj+iDA3npiPkXN1r
 gQmVEbFl2KTokoSgnkxenLbV++G3u0IOVk5aay3dueCU5iJbOAL4iKruFJXnl3KkqCvAo
 3szs3MnFnj3ePS08vRf0SkytXSiblnYG8HobtWnYMJ3yLvygnsgxODpUWTsduu/zMTJoe
 Y2oR6QWNc7I1IRpuSKxwTwhLReq49zVjnvxh3C33O9ndf+6ldh+/QxXj3PFkSmfJ0U0D/
 yTyUgCvASB6DTshY84XnpggDDrpBJTmJv4RuCL04IO+S4zOTwTP67TBT5A9asHPeWiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788943879;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Zu4myBCENGDa39S6adNwIcYjaDG/BKNJ9paH9K5+/3g=;
 b=BUZkccJSIaCPkr4BzeetIJpaH5u4WGZ8W3J60RdDqprbjBgavj19MJHDO7v7a9VhLaU+
 ObGClJixY1LWwHH/bhdsrquoG54bxkR/S13BpfcAUSBDIF+RLugTm/2vsJqpCVoxb5Nck
 7fmdOfA9YjyXMPMKegwdxd2DktV/oXmrPvsDSJvtIwWofFemUAaw49orS4uy1QCkmueK4
 a133J+KTFnvT3EsOEQ8zhvwL5Tk6BTTRHHX7mE0PbYyZE0oQBMffo4AlP7CUgLki71wqm
 j6S2k0LX67EnU7NZVVjeta3Hm5cSAbFxzds1mvVIc/+FogCxzlEJD6hE4lunuiFZWcA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=JbfNxwXj; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=JbfNxwXj
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AEA7C40055
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:18 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254c50ff6fso68891066b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788943876; x=1789548676;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zu4myBCENGDa39S6adNwIcYjaDG/BKNJ9paH9K5+/3g=;
 b=JbfNxwXjw9yuM0JgTL5auAaaV2NvU5LtEA18pzZtbGndCtY5aMeM780TB0TzEoncOX
 z7QZwByni+Z7lnmw02BAXeADrFOPd2ey1adBrD7zMu+JNDRTZt67ty8dnv9B8ocEMl8W
 76RMbsS3dADeAAUc0NzO9JMdZjoCquoix0OZRgcO3UYe5WqyYDXxmuTTB5HPOyUqyroL
 T4ArB3Y6e00kCClM2viPud7KCiSIAJqepoyUtm7/baJGJaBErIb5HmscFvCuloUr5pxu
 wgNW2+uJu8vaakrf92S8aCfLVFmV+ar31kSdljLUdetD7I6gB45NPdSlzhLqapIFRR9W
 gDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943876; x=1789548676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zu4myBCENGDa39S6adNwIcYjaDG/BKNJ9paH9K5+/3g=;
 b=hrLYm3GvvAEn4PuvVtTjr82qnQiPwb6aF5Xq8GX9PJQSTDq+X7BoB0kdolpxkQYOm/
 5Ff2nqLkA1Q+d8HOcnsYNRHqvNnesXa5NRUndkknqWQYW7DsN2z8H8TDckD+ucsOY+kl
 0ijqPjGd1CiwPWlx9k65pxOi64n8EnTMx6XZFk8lT3/nZ3ztAPK6ErjH6ADjff+Z1SzS
 qYG+wSTZYQq+zAjOOlO0nxbbdonuUSwzUT8lzfP1Ry/L3XJ7H9hKN3bR1cFngvksNlyE
 HoYEXKYGozUMhUYZBpOYyHzw3LsT0gAlBC7fo75fIovrlR+Bu3Jg2vKntKs7eeciPN4r
 KzQg==
X-Gm-Message-State: AFuF++nBpogg3jCVh7bn1C3dY+uyTmvI9g45iGVtS8BULuj41qBWp6mB
 /gM+riOFP8D1bvielXbjxynp7o4c63OSz4FnkrO5aZPpFqyLOSj6r3z9lwhlJXD8J0mSXDH0Zo8
 PPD2f
X-Gm-Gg: AYBFou0AlZiXwyA/qCjrmUNqzqLznQk8+k4JT0OvQHRuapVr1nySakzCm4OZ6rswNmb
 hD5NoWVaT0tw6vQ22YIT0+SygDGUsy8gmfxKPvs1BC4pbtiPgr3coNRLmj3C30/zuzRjkQikb8U
 nAeiqkec37dXgzGz9ApnyIFiCikgvTLcCbEj161QureAzIG8osPDyBK3ikFpU3CSV/5yZqhVS2E
 tIixZzn+PdtQ+CIQW4teaE6Ltg8pstf0YV+Hlj9+vT55LfpoHuHtBdEZ7k2JciI7UEpbtM6Ywjn
 ZaEGU0pDjy4TxLWp7rC1v3EwEfPkfuuTVi5a0YZ4NCZcfc8kmwItTn6S9nLVz5PxNXscNgQepwk
 +Z3OcjFCcKezaohd9BNXBvjW7v62BNqh9l3ZHaUk8qu8Z2Qi/N9oKF3A2W9Dn3KxQLxsJCG00dh
 lMNE7f8kPHNyT8TGEXHUBGbNGphRqdaCQwGSYKVCz95E86O6nMlF5pXAWQ6Ih6U/Ai3kvH6maaR
 75HL0mKsh0zsyL4rVCDkXoqr+15wbXRGmh+x4Z4rsQ=
X-Received: by 2002:a17:907:c1b:b0:c15:ccda:26d5 with SMTP id
 a640c23a62f3a-c2612b8e83fmr1437797366b.4.1788943876536; 
 Wed, 09 Sep 2026 01:51:16 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c292c14c6a8sm90988566b.47.2026.09.09.01.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:51:16 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v8 06/25] usb: dwc3: bring back the samsung usb phy driver
Date: Wed,  9 Sep 2026 10:49:56 +0200
Message-ID: <20260909085015.2480097-7-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909085015.2480097-1-anders.roxell@linaro.org>
References: <20260909085015.2480097-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 12:45:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The restore commit at the start of this series deletes samsung_usb_phy.c,
because the file was not part of the original v3.19-rc1 import. It never
came from the kernel, it is u-boot code added later.

Nothing added it back, but CONFIG_USB_DWC3_PHY_SAMSUNG is still in
Kconfig and odroid-xu3_defconfig still selects it. exynos5-dt.c calls
exynos5_usb3_phy_init() from this file, so that board would lose its USB
3.0 phy setup.

Bring the file back unchanged and add it to the Makefile again.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/Makefile          |  1 +
 drivers/usb/dwc3/samsung_usb_phy.c | 77 ++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 drivers/usb/dwc3/samsung_usb_phy.c

diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 63c7c6063002..a5775c4bea04 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
 obj-$(CONFIG_USB_DWC3_STI)		+= dwc3-generic-sti.o
 obj-$(CONFIG_USB_DWC3_UNIPHIER)		+= dwc3-uniphier.o
 obj-$(CONFIG_USB_DWC3_PHY_OMAP)		+= ti_usb_phy.o
+obj-$(CONFIG_USB_DWC3_PHY_SAMSUNG)	+= samsung_usb_phy.o
diff --git a/drivers/usb/dwc3/samsung_usb_phy.c b/drivers/usb/dwc3/samsung_usb_phy.c
new file mode 100644
index 000000000000..3563070cb85d
--- /dev/null
+++ b/drivers/usb/dwc3/samsung_usb_phy.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * samsung_usb_phy.c - DesignWare USB3 (DWC3) PHY handling file
+ *
+ * Copyright (C) 2015 Samsung Electronics
+ *
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ */
+
+#include <asm/io.h>
+#include <asm/arch/power.h>
+#include <asm/arch/xhci-exynos.h>
+#include <linux/delay.h>
+
+void exynos5_usb3_phy_init(struct exynos_usb3_phy *phy)
+{
+	u32 reg;
+
+	/* Reset USB 3.0 PHY */
+	writel(0x0, &phy->phy_reg0);
+
+	clrbits_le32(&phy->phy_param0,
+			/* Select PHY CLK source */
+			PHYPARAM0_REF_USE_PAD |
+			/* Set Loss-of-Signal Detector sensitivity */
+			PHYPARAM0_REF_LOSLEVEL_MASK);
+	setbits_le32(&phy->phy_param0, PHYPARAM0_REF_LOSLEVEL);
+
+	writel(0x0, &phy->phy_resume);
+
+	/*
+	 * Setting the Frame length Adj value[6:1] to default 0x20
+	 * See xHCI 1.0 spec, 5.2.4
+	 */
+	setbits_le32(&phy->link_system,
+			LINKSYSTEM_XHCI_VERSION_CONTROL |
+			LINKSYSTEM_FLADJ(0x20));
+
+	/* Set Tx De-Emphasis level */
+	clrbits_le32(&phy->phy_param1, PHYPARAM1_PCS_TXDEEMPH_MASK);
+	setbits_le32(&phy->phy_param1, PHYPARAM1_PCS_TXDEEMPH);
+
+	setbits_le32(&phy->phy_batchg, PHYBATCHG_UTMI_CLKSEL);
+
+	/* PHYTEST POWERDOWN Control */
+	clrbits_le32(&phy->phy_test,
+			PHYTEST_POWERDOWN_SSP |
+			PHYTEST_POWERDOWN_HSP);
+
+	/* UTMI Power Control */
+	writel(PHYUTMI_OTGDISABLE, &phy->phy_utmi);
+
+		/* Use core clock from main PLL */
+	reg = PHYCLKRST_REFCLKSEL_EXT_REFCLK |
+		/* Default 24Mhz crystal clock */
+		PHYCLKRST_FSEL(FSEL_CLKSEL_24M) |
+		PHYCLKRST_MPLL_MULTIPLIER_24MHZ_REF |
+		PHYCLKRST_SSC_REFCLKSEL(0) |
+		/* Force PortReset of PHY */
+		PHYCLKRST_PORTRESET |
+		/* Digital power supply in normal operating mode */
+		PHYCLKRST_RETENABLEN |
+		/* Enable ref clock for SS function */
+		PHYCLKRST_REF_SSP_EN |
+		/* Enable spread spectrum */
+		PHYCLKRST_SSC_EN |
+		/* Power down HS Bias and PLL blocks in suspend mode */
+		PHYCLKRST_COMMONONN;
+
+	writel(reg, &phy->phy_clk_rst);
+
+	/* giving time to Phy clock to settle before resetting */
+	udelay(10);
+
+	reg &= ~PHYCLKRST_PORTRESET;
+	writel(reg, &phy->phy_clk_rst);
+}
-- 
2.53.0

