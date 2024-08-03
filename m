Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FB4C52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7528588CD0;
	Sat,  3 Aug 2024 13:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DQnM2DQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 863B488C86; Sat,  3 Aug 2024 13:13:11 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AD7188C9D
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so18689985e9.1
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683589; x=1723288389; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tnTo+hdD4tBsawHFt8O2ho//PArMPoaxDVt+kUP4aTQ=;
 b=DQnM2DQrNIuDvSLSMzLEyoTa3aimSFt8SRDIWQgyGQxb+VZyQKbqVZw541yvknWt09
 T8sOSOmnCB+ZS3bPfpLJ2VDhW59Sta8MEJM2uikRh1XeZJ9p51RvQvsAVVBRMfo2EVVr
 QvoSTxnJ3vX+0+skliBrwubZKV4I6sIqN8Dn6ldvLNER40gMJ5DqoVYz5PntcyNN089j
 ywdXEPVCC6z3NFaXkOObXR6dG3dTVqKCdqJ3kPKkV2CMmKpugwN4V3aD1dp+3hK+LhWW
 RC7iWyJYn8XgSho17JNC8x619PLtmEwcrGVE+Uz5Zxdo2Cp05hbtVB6iSd3tmeDwTOnl
 YmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683589; x=1723288389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnTo+hdD4tBsawHFt8O2ho//PArMPoaxDVt+kUP4aTQ=;
 b=sxHd8lISxVCJM2Jj8zeL2MEZ2RXr3c/oCKgs+PS4t3Ip7vMiyIWi0R7JYFYoy224O6
 gMGqPOpgA8dSIMuVkTQMZ2O6Ir6AFk+z6viZG3QTW98TywsM/HSf1QnSrH2ANZdWUUxb
 azCL7CuEumD7xgsuSu70kFkiwn3Mjb2uewrwlLQzsCoYfuLxAkY/ZCEYPQRTacCmMJY8
 dxvwlUcqf4jBjRMaH4G6vwmRBPe9mBeIJ4fYn9nB2C9W94qXki1m6+J1izxoMaGjT6kf
 +r0hBOmkbPY8aBsL81Q0bzLVgL2lCsyBYTb+DJ6MgjrKMAW9kINe6x6S6ryiOnSLncGo
 hV6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9o8ffQ6qj8g5LHvKpG1zvGN8rGMz6Q2qMvDyE9WuMArQJD84RGguWA+JQjzIocqdW2nQ49UZ3RvGfVThYvGkLEv9RlA==
X-Gm-Message-State: AOJu0YzjkNQkReSwQynWZrjyFWIMg8ywhyfQSymUxxiU1Y+EqWvFxzsd
 XCO1ygcUGS5lvOQNKxplpT7pAVWdFN0jfvk4h8i0FDQSY83c9mX+
X-Google-Smtp-Source: AGHT+IHuhG4PRSgG9qf1fxlR2KNq3pQFLQNp7FInU9hLCF+FhQGS2CzymNcSt+oFwGwVQyknkTe8yw==
X-Received: by 2002:a05:600c:458c:b0:426:62c6:4341 with SMTP id
 5b1f17b1804b1-428e6b30e41mr42485855e9.20.1722683588708; 
 Sat, 03 Aug 2024 04:13:08 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6d648a0sm63835655e9.10.2024.08.03.04.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:13:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 6/8] clk: mediatek: mt7622: add missing clock PERI_UART4_PD
Date: Sat,  3 Aug 2024 10:43:24 +0200
Message-ID: <20240803084329.1688-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803084329.1688-1-ansuelsmth@gmail.com>
References: <20240803084329.1688-1-ansuelsmth@gmail.com>
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

Add missing clock PERI_UART4_PD for peri clock gates. This is needed to
match upstream linux clk ID in preparation for OF_UPSTREAM.
Also convert infracfg to mux + gate implementation as now we have mux on
top of gates.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7622.c      |  1 +
 include/dt-bindings/clock/mt7622-clk.h | 25 +++++++++++++------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 0da7a848163..5df62e64c9a 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -472,6 +472,7 @@ static const struct mtk_gate peri_cgs[] = {
 	GATE_PERI0(CLK_PERI_UART1_PD, CLK_TOP_AXI_SEL, 18),
 	GATE_PERI0(CLK_PERI_UART2_PD, CLK_TOP_AXI_SEL, 19),
 	GATE_PERI0(CLK_PERI_UART3_PD, CLK_TOP_AXI_SEL, 20),
+	GATE_PERI0(CLK_PERI_UART4_PD, CLK_TOP_AXI_SEL, 21),
 	GATE_PERI0(CLK_PERI_BTIF_PD, CLK_TOP_AXI_SEL, 22),
 	GATE_PERI0(CLK_PERI_I2C0_PD, CLK_TOP_AXI_SEL, 23),
 	GATE_PERI0(CLK_PERI_I2C1_PD, CLK_TOP_AXI_SEL, 24),
diff --git a/include/dt-bindings/clock/mt7622-clk.h b/include/dt-bindings/clock/mt7622-clk.h
index 0820fab0a22..4b6501c1020 100644
--- a/include/dt-bindings/clock/mt7622-clk.h
+++ b/include/dt-bindings/clock/mt7622-clk.h
@@ -146,18 +146,19 @@
 #define CLK_PERI_UART1_PD		13
 #define CLK_PERI_UART2_PD		14
 #define CLK_PERI_UART3_PD		15
-#define CLK_PERI_BTIF_PD		16
-#define CLK_PERI_I2C0_PD		17
-#define CLK_PERI_I2C1_PD		18
-#define CLK_PERI_I2C2_PD		19
-#define CLK_PERI_SPI1_PD		20
-#define CLK_PERI_AUXADC_PD		21
-#define CLK_PERI_SPI0_PD		22
-#define CLK_PERI_SNFI_PD		23
-#define CLK_PERI_NFI_PD			24
-#define CLK_PERI_NFIECC_PD		25
-#define CLK_PERI_FLASH_PD		26
-#define CLK_PERI_IRTX_PD		27
+#define CLK_PERI_UART4_PD		16
+#define CLK_PERI_BTIF_PD		17
+#define CLK_PERI_I2C0_PD		18
+#define CLK_PERI_I2C1_PD		19
+#define CLK_PERI_I2C2_PD		20
+#define CLK_PERI_SPI1_PD		21
+#define CLK_PERI_AUXADC_PD		22
+#define CLK_PERI_SPI0_PD		23
+#define CLK_PERI_SNFI_PD		24
+#define CLK_PERI_NFI_PD			25
+#define CLK_PERI_NFIECC_PD		26
+#define CLK_PERI_FLASH_PD		27
+#define CLK_PERI_IRTX_PD		28
 
 /* APMIXEDSYS */
 
-- 
2.45.2

