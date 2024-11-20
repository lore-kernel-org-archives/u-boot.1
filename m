Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C092D60D14
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 09:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67C348967B;
	Wed, 20 Nov 2024 10:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pS2Pufte";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D41DB89691; Wed, 20 Nov 2024 10:22:54 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 153AD89678
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-431688d5127so16038725e9.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 01:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732094571; x=1732699371; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=en7bD2OZRmqCgW5+9CmDQZgDCs/w+MFcT5aUqdMc4C8=;
 b=pS2PufteQ26vKcS02eEvyiDvBvA5kHz7bO46ull+Lgbm6S3MRTTKUmDaZ3Ai16fELc
 OtB3Vfq2PEXbKBdQXDnwOFK8PTafAI1MYa4pD87L+zh1qXPosqmyBGHvOs+ewL0qwgJE
 7nyi0SKO4KpIA9M2ypmfVL9CokshHFYGyUqgTDfyUp1zVsxhEcIeGSNzFvz03F1xNfFD
 RpYnkFtGWcxAa0c0ImXUn+f6J422s5Wry+/7OQYtCB6dvZUGza8nfOLB4Nt9Mj3UlZzf
 8rJlTJ8kluQUq2LF91WbrQHob9PB804kvq0eoaJqLerE8Gv1wIuhOlnabUu2QvZDJXUD
 kyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732094571; x=1732699371;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=en7bD2OZRmqCgW5+9CmDQZgDCs/w+MFcT5aUqdMc4C8=;
 b=eO2cqyHyroJ1OhzYpku4YMesdc0r8FOuKUx/YPbBZWl/KDEC7+13DhXl5cR6+6pRKL
 H6w66HhDgCggd5iRyMBdH4KU+/a+2YPds/VKlVLqi6ClKNMxiJ82xhUD21q58jqx9S56
 hroiOYpDT+/Ax3gFVCBuPja0TlYZVfB6sOr7xQ/L1NWJNXQZufROZhBpn1EZ+BE8Ourq
 Stze63KUyreTYbSOr5RI3cYC1h/JPiqvJSywAhno4V7j3Vdp7/+GnUqszR28TOuNoWfx
 Iuq3/MrTudai4msde9bOoXJ8Z9NANZqfCyaYNyDXWtb/WxLoso3oAWnrOxsRsJeCMtVE
 B6OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5nwIXcgBU3R4hD9k+hDKtFyQtHr+8Y9Jc1BrJIX2gL25301FP813l1YqJBqykRm9201UN7UU=@lists.denx.de
X-Gm-Message-State: AOJu0YwH1FWjzzZLvDS8AYxuy41t82eOl7eRGTw+CLusO+fs1zcH2wPD
 HwDYuONuLfZWsCgSAQ7ZX0C7zdJ+ZQbCTeaB75mubs0Sm6C17sF7pj4KbUhMl5I=
X-Google-Smtp-Source: AGHT+IETgaBvu1iv0k3Y6GwGx1Geo/xee+Qt1AZETjIC0QG0oNzTdw8ooW9zHrSgu/5W5Y3+KvGUXA==
X-Received: by 2002:a05:600c:1ca2:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-4334f026f5cmr15866885e9.29.1732094571589; 
 Wed, 20 Nov 2024 01:22:51 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825490529fsm1557333f8f.4.2024.11.20.01.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 01:22:51 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 20 Nov 2024 10:22:46 +0100
Subject: [PATCH 5/6] ufs: core: sync unipro.h with Linux v6.12
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-topic-ufs-cleanup-v1-5-a5cef54b1cdc@linaro.org>
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
In-Reply-To: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org, 
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8468;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=bAneN+BP3xzaji1nU2yAgXLWxsUXsur8/mpUZTy/gNY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnPapm4iy9N8hCaRlCdIk60jZdrSwZHrYmUByRGLi5
 uGfJZ2qJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZz2qZgAKCRB33NvayMhJ0aT+D/
 9FtzpC/LEKftsjt20Wc5Zx+dMs66tcDDqPSAPWcEqM4w+V+ZKIEI9d/4ydhcvHgEUtdkktD5BbW/8g
 oehfo128z4wsTTgikgeuhMjI4fz4aVZsrhPdQmuVrgX0V/Z/RTpA+HeeDLseRfJLT+yl20y6T7dYa+
 XxQRx8ZGsGqLhZlSgtT74oekkiQxLbDmvGJ3boqffiXgEGcMW44CiDitB6byvCbuuQU8G73EC07YHS
 XgF+1bSS8Wc/a3oKT8QclHewDSLOijBXPTUoLYcQs4oVYwMMQ5Yhxeob4f3PVShwgXKts5lNN9roIZ
 s6Hov3IxKGGyrXGLRFlvLYx15hT+Xq3RHmplCbVv7ca9Yeax3EmvXY7p/8xXI/eyjNiLB2XT8n2YMX
 FUfsuPaHa5ym4iG0y7Ru68qwHtZ+6jB2btWfU7kx4x5Tg0ZK6S36hi5KDRKXkPKOvV2SjT4LqfiwbA
 oAfHEhFxQRZhFHvtKMSbFUyCigA/fbA8ti6rgOzgei9a7cR9wQsMUCJD8+8yhgTqEtPj4LMeEkjeB3
 Da1CekURaUVLVbWlLQjm3f034Dl0xqBNBhOR2HRUnU8QDWjMg/Pyrimz5T1VV2LXIN4UU2L4vqAJ2f
 /cfYpBJnPfx2Xpcd9q8plnf/k1linaOcg7X2iq1kwae0xG1RpmKQNoZ8Zmig==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Sync unipro.h with the version found in the Linux v6.12
version commit adc218676eef ("Linux 6.12").

It adds new defines, and moves defines to the same place
as the Linux header.

No functional changes intended.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/unipro.h | 124 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 48 deletions(-)

diff --git a/drivers/ufs/unipro.h b/drivers/ufs/unipro.h
index 0aa35ef31dfd263739c0b5c75c26f9191f38e8ec..56833602b77abbfa4abff5f2b57461986fe815dc 100644
--- a/drivers/ufs/unipro.h
+++ b/drivers/ufs/unipro.h
@@ -34,6 +34,18 @@
 /*
  * M-RX Configuration Attributes
  */
+#define RX_HS_G1_SYNC_LENGTH_CAP		0x008B
+#define RX_HS_G1_PREP_LENGTH_CAP		0x008C
+#define RX_MIN_ACTIVATETIME_CAPABILITY		0x008F
+#define RX_HIBERN8TIME_CAPABILITY		0x0092
+#define RX_HS_G2_SYNC_LENGTH_CAP		0x0094
+#define RX_HS_G3_SYNC_LENGTH_CAP		0x0095
+#define RX_HS_G2_PREP_LENGTH_CAP		0x0096
+#define RX_HS_G3_PREP_LENGTH_CAP		0x0097
+#define RX_ADV_GRANULARITY_CAP			0x0098
+#define RX_HIBERN8TIME_CAP			0x0092
+#define RX_ADV_HIBERN8TIME_CAP			0x0099
+#define RX_ADV_MIN_ACTIVATETIME_CAP		0x009A
 #define RX_MODE					0x00A1
 #define RX_HSRATE_SERIES			0x00A2
 #define RX_HSGEAR				0x00A3
@@ -42,24 +54,27 @@
 #define RX_HS_UNTERMINATED_ENABLE		0x00A6
 #define RX_ENTER_HIBERN8			0x00A7
 #define RX_BYPASS_8B10B_ENABLE			0x00A8
-#define RX_TERMINATION_FORCE_ENABLE		0x0089
-#define RX_MIN_ACTIVATETIME_CAPABILITY		0x008F
-#define RX_HIBERN8TIME_CAPABILITY		0x0092
+#define RX_TERMINATION_FORCE_ENABLE		0x00A9
+#define RXCALCTRL				0x00B4
+#define RXSQCTRL				0x00B5
+#define CFGRXCDR8				0x00BA
+#define CFGRXOVR8				0x00BD
+#define CFGRXOVR6				0x00BF
+#define RXDIRECTCTRL2				0x00C7
+#define CFGRXOVR4				0x00E9
 #define RX_REFCLKFREQ				0x00EB
 #define	RX_CFGCLKFREQVAL			0x00EC
 #define CFGWIDEINLN				0x00F0
-#define CFGRXCDR8				0x00BA
 #define ENARXDIRECTCFG4				0x00F2
-#define CFGRXOVR8				0x00BD
-#define RXDIRECTCTRL2				0x00C7
 #define ENARXDIRECTCFG3				0x00F3
-#define RXCALCTRL				0x00B4
 #define ENARXDIRECTCFG2				0x00F4
-#define CFGRXOVR4				0x00E9
-#define RXSQCTRL				0x00B5
-#define CFGRXOVR6				0x00BF
 
 #define is_mphy_tx_attr(attr)			((attr) < RX_MODE)
+#define RX_ADV_FINE_GRAN_STEP(x)		((((x) & 0x3) << 1) | 0x1)
+#define SYNC_LEN_FINE(x)			((x) & 0x3F)
+#define SYNC_LEN_COARSE(x)			((1 << 6) | ((x) & 0x3F))
+#define PREP_LEN(x)				((x) & 0xF)
+
 #define RX_MIN_ACTIVATETIME_UNIT_US		100
 #define HIBERN8TIME_UNIT_US			100
 
@@ -80,48 +95,51 @@
 #define UNIPRO_CB_OFFSET(x)			(0x8000 | (x))
 
 /*
- * PHY Adpater attributes
+ * PHY Adapter attributes
  */
-#define PA_ACTIVETXDATALANES	0x1560
-#define PA_ACTIVERXDATALANES	0x1580
-#define PA_TXTRAILINGCLOCKS	0x1564
 #define PA_PHY_TYPE		0x1500
 #define PA_AVAILTXDATALANES	0x1520
-#define PA_AVAILRXDATALANES	0x1540
-#define PA_MINRXTRAILINGCLOCKS	0x1543
-#define PA_TXPWRSTATUS		0x1567
-#define PA_RXPWRSTATUS		0x1582
-#define PA_TXFORCECLOCK		0x1562
-#define PA_TXPWRMODE		0x1563
-#define PA_LEGACYDPHYESCDL	0x1570
 #define PA_MAXTXSPEEDFAST	0x1521
 #define PA_MAXTXSPEEDSLOW	0x1522
 #define PA_MAXRXSPEEDFAST	0x1541
 #define PA_MAXRXSPEEDSLOW	0x1542
 #define PA_TXLINKSTARTUPHS	0x1544
+#define PA_AVAILRXDATALANES	0x1540
+#define PA_MINRXTRAILINGCLOCKS	0x1543
 #define PA_LOCAL_TX_LCC_ENABLE	0x155E
+#define PA_ACTIVETXDATALANES	0x1560
+#define PA_CONNECTEDTXDATALANES	0x1561
+#define PA_TXFORCECLOCK		0x1562
+#define PA_TXPWRMODE		0x1563
+#define PA_TXTRAILINGCLOCKS	0x1564
 #define PA_TXSPEEDFAST		0x1565
 #define PA_TXSPEEDSLOW		0x1566
-#define PA_REMOTEVERINFO	0x15A0
+#define PA_TXPWRSTATUS		0x1567
 #define PA_TXGEAR		0x1568
 #define PA_TXTERMINATION	0x1569
 #define PA_HSSERIES		0x156A
+#define PA_LEGACYDPHYESCDL	0x1570
 #define PA_PWRMODE		0x1571
+#define PA_ACTIVERXDATALANES	0x1580
+#define PA_CONNECTEDRXDATALANES	0x1581
+#define PA_RXPWRSTATUS		0x1582
 #define PA_RXGEAR		0x1583
 #define PA_RXTERMINATION	0x1584
 #define PA_MAXRXPWMGEAR		0x1586
 #define PA_MAXRXHSGEAR		0x1587
-#define PA_RXHSUNTERMCAP	0x15A5
-#define PA_RXLSTERMCAP		0x15A6
-#define PA_GRANULARITY		0x15AA
 #define PA_PACPREQTIMEOUT	0x1590
 #define PA_PACPREQEOBTIMEOUT	0x1591
+#define PA_REMOTEVERINFO	0x15A0
+#define PA_LOGICALLANEMAP	0x15A1
+#define PA_SLEEPNOCONFIGTIME	0x15A2
+#define PA_STALLNOCONFIGTIME	0x15A3
+#define PA_SAVECONFIGTIME	0x15A4
+#define PA_RXHSUNTERMCAP	0x15A5
+#define PA_RXLSTERMCAP		0x15A6
 #define PA_HIBERN8TIME		0x15A7
 #define PA_LOCALVERINFO		0x15A9
+#define PA_GRANULARITY		0x15AA
 #define PA_TACTIVATE		0x15A8
-#define PA_PACPFRAMECOUNT	0x15C0
-#define PA_PACPERRORCOUNT	0x15C1
-#define PA_PHYTESTCONTROL	0x15C2
 #define PA_PWRMODEUSERDATA0	0x15B0
 #define PA_PWRMODEUSERDATA1	0x15B1
 #define PA_PWRMODEUSERDATA2	0x15B2
@@ -134,12 +152,9 @@
 #define PA_PWRMODEUSERDATA9	0x15B9
 #define PA_PWRMODEUSERDATA10	0x15BA
 #define PA_PWRMODEUSERDATA11	0x15BB
-#define PA_CONNECTEDTXDATALANES	0x1561
-#define PA_CONNECTEDRXDATALANES	0x1581
-#define PA_LOGICALLANEMAP	0x15A1
-#define PA_SLEEPNOCONFIGTIME	0x15A2
-#define PA_STALLNOCONFIGTIME	0x15A3
-#define PA_SAVECONFIGTIME	0x15A4
+#define PA_PACPFRAMECOUNT	0x15C0
+#define PA_PACPERRORCOUNT	0x15C1
+#define PA_PHYTESTCONTROL	0x15C2
 #define PA_TXHSADAPTTYPE	0x15D4
 
 /* Adapt type for PA_TXHSADAPTTYPE attribute */
@@ -151,9 +166,9 @@
 #define PA_HIBERN8_TIME_UNIT_US		100
 
 /*Other attributes*/
+#define VS_POWERSTATE		0xD083
 #define VS_MPHYCFGUPDT		0xD085
 #define VS_DEBUGOMC		0xD09E
-#define VS_POWERSTATE		0xD083
 #define VS_MPHYDISABLE		0xD0C1
 
 #define PA_GRANULARITY_MIN_VAL	1
@@ -163,7 +178,7 @@
 #define PA_MAXDATALANES	4
 
 /* PA power modes */
-enum {
+enum ufs_pa_pwr_mode {
 	FAST_MODE	= 1,
 	SLOW_MODE	= 2,
 	FASTAUTO_MODE	= 4,
@@ -171,8 +186,11 @@ enum {
 	UNCHANGED	= 7,
 };
 
+#define PWRMODE_MASK		0xF
+#define PWRMODE_RX_OFFSET	4
+
 /* PA TX/RX Frequency Series */
-enum {
+enum ufs_hs_gear_rate {
 	PA_HS_MODE_A	= 1,
 	PA_HS_MODE_B	= 2,
 };
@@ -193,14 +211,24 @@ enum ufs_hs_gear_tag {
 	UFS_HS_G1,		/* HS Gear 1 (default for reset) */
 	UFS_HS_G2,		/* HS Gear 2 */
 	UFS_HS_G3,		/* HS Gear 3 */
+	UFS_HS_G4,		/* HS Gear 4 */
+	UFS_HS_G5		/* HS Gear 5 */
+};
+
+enum ufs_lanes {
+	UFS_LANE_DONT_CHANGE,	/* Don't change Lane */
+	UFS_LANE_1,		/* Lane 1 (default for reset) */
+	UFS_LANE_2,		/* Lane 2 */
 };
 
 enum ufs_unipro_ver {
 	UFS_UNIPRO_VER_RESERVED = 0,
 	UFS_UNIPRO_VER_1_40 = 1, /* UniPro version 1.40 */
 	UFS_UNIPRO_VER_1_41 = 2, /* UniPro version 1.41 */
-	UFS_UNIPRO_VER_1_6 = 3,  /* UniPro version 1.6 */
-	UFS_UNIPRO_VER_MAX = 4,  /* UniPro unsupported version */
+	UFS_UNIPRO_VER_1_6  = 3, /* UniPro version 1.6 */
+	UFS_UNIPRO_VER_1_61 = 4, /* UniPro version 1.61 */
+	UFS_UNIPRO_VER_1_8  = 5, /* UniPro version 1.8 */
+	UFS_UNIPRO_VER_MAX  = 6, /* UniPro unsupported version */
 	/* UniPro version field mask in PA_LOCALVERINFO */
 	UFS_UNIPRO_VER_MASK = 0xF,
 };
@@ -208,27 +236,27 @@ enum ufs_unipro_ver {
 /*
  * Data Link Layer Attributes
  */
+#define DL_TXPREEMPTIONCAP	0x2000
+#define DL_TC0TXMAXSDUSIZE	0x2001
+#define DL_TC0RXINITCREDITVAL	0x2002
+#define DL_TC1TXMAXSDUSIZE	0x2003
+#define DL_TC1RXINITCREDITVAL	0x2004
+#define DL_TC0TXBUFFERSIZE	0x2005
+#define DL_TC1TXBUFFERSIZE	0x2006
 #define DL_TC0TXFCTHRESHOLD	0x2040
 #define DL_FC0PROTTIMEOUTVAL	0x2041
 #define DL_TC0REPLAYTIMEOUTVAL	0x2042
 #define DL_AFC0REQTIMEOUTVAL	0x2043
 #define DL_AFC0CREDITTHRESHOLD	0x2044
 #define DL_TC0OUTACKTHRESHOLD	0x2045
+#define DL_PEERTC0PRESENT	0x2046
+#define DL_PEERTC0RXINITCREVAL	0x2047
 #define DL_TC1TXFCTHRESHOLD	0x2060
 #define DL_FC1PROTTIMEOUTVAL	0x2061
 #define DL_TC1REPLAYTIMEOUTVAL	0x2062
 #define DL_AFC1REQTIMEOUTVAL	0x2063
 #define DL_AFC1CREDITTHRESHOLD	0x2064
 #define DL_TC1OUTACKTHRESHOLD	0x2065
-#define DL_TXPREEMPTIONCAP	0x2000
-#define DL_TC0TXMAXSDUSIZE	0x2001
-#define DL_TC0RXINITCREDITVAL	0x2002
-#define DL_TC0TXBUFFERSIZE	0x2005
-#define DL_PEERTC0PRESENT	0x2046
-#define DL_PEERTC0RXINITCREVAL	0x2047
-#define DL_TC1TXMAXSDUSIZE	0x2003
-#define DL_TC1RXINITCREDITVAL	0x2004
-#define DL_TC1TXBUFFERSIZE	0x2006
 #define DL_PEERTC1PRESENT	0x2066
 #define DL_PEERTC1RXINITCREVAL	0x2067
 

-- 
2.34.1

