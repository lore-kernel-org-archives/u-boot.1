Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EE2E77188
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 10:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FCFB80655;
	Mon, 30 Dec 2024 11:31:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RRpucXyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85BEA805EA; Mon, 30 Dec 2024 11:31:09 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52ECD80570
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 11:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso7737266f8f.1
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 02:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735554667; x=1736159467; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BVvRFBlrTD2xdj9R7M5s+RXb0V0lCIVlcF8lmZihNeA=;
 b=RRpucXyptDewggTGoeN6o8JR+D+sRsqkhXr0lWVeVNNgnpiB65iLWVCKzHSYcjyYF8
 IGlEjWj4L8AMV6zPlHylUgvERfcg5tcxf3ybJCWEbx+8SmhDsKHHzfUYmwTaRTlqMs7A
 DQpqtADuia7XV+lIYKpm56V+eHkeSbtA8qTx7mCB/AAjUx0GGttpKeDL+S7LAziNo4ny
 UWGgb3Z0C5zzN6xjdvv8cHlbD5euwkRdU3huNpi6jSp97KRciT9d4LrzP3KTetbkMoXL
 iJXj4m4BPvXw+NBNtJAynvwPMIa49di3b+cyg+5iZKQWs6sEfIQCojPHPXZHpqCOxq9d
 /RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735554667; x=1736159467;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BVvRFBlrTD2xdj9R7M5s+RXb0V0lCIVlcF8lmZihNeA=;
 b=j2xhbsKlAxmW+xjZ50+66jaCTTyuhTptm431SMhoonFU3bmqNT09B938HNBGYYUeaz
 yJAUeMSEzIcT1a4elBvvaWlWB9cKvMxJ5gulsy66IDobHkME3H8eIdiVnywCudx+pWzp
 zufIgdl8WaOqvtfCIKeOsD4/KbPjJ9fcGNfNvh808M8UiZuYS2VshxVcmSMzwicS7sbs
 2tpWenPZ96flL2JF9oJlJokGxjUCB/z4NQOpyVyO4orCQKpp1DVYIOJysFigJZ9D3aCX
 dyGDFzEyjPrPsUW+hSR0vsE/kMoZdEf5ZhwNIT9odiObEFjOkIeGp03UdslqrWNRhUNC
 WQRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHIOBkA39o0ZxPMWYZnVxcxQAGszm7RAZTa/YYYdvqKtm912y0aw4i0CpMi/zqnIbS7Sc1tto=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1W/ysWRqXDylR8N4vZCaXH2EpjU9uh3CdUDi3GwlLLHBjL6tO
 x9zBuFUjyHs4RfWj9AuvEjXZUWVvTJWvzlLVEpPFeV/Ig/bVQanJ+a2HEtR4aNg=
X-Gm-Gg: ASbGncso4+zQpl19Q2zD9MMbVZCUx8JyjP92J3sDVPSPrkya7XtdA3g3qH5tPN8IThU
 mM689/L+lI90MN5eXdIhVSZwTz6570oHx8Z/ZLUKhZJh+6cTM2rgO5U3A/5fZdjqY5IJJai08H+
 TD0O7aoX2RYATb3EHQ5GyMFDyv4CC8qvly34X3PiBTCvNE+RzQZVENDlzuIDAQMtvcyvUJ53uGS
 PVTiaP22pABotXfg6vX4ssS75HbmOnkPuwL7NMnHu2LGHbn34P+kQnFcrKQ34mE27JLHIbzcweL
 TA==
X-Google-Smtp-Source: AGHT+IFmkZzmzJ+dJ6ZULYVinPKD5qSj8lo7xG92wWoQyx5mAxPC8+FMQ/HROsrM7fpM96IhH0qPtw==
X-Received: by 2002:adf:ab09:0:b0:38a:4184:1520 with SMTP id
 ffacd0b85a97d-38a418416bdmr12348398f8f.27.1735554666790; 
 Mon, 30 Dec 2024 02:31:06 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e1c0sm30201550f8f.77.2024.12.30.02.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 02:31:06 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 30 Dec 2024 11:30:59 +0100
Subject: [PATCH v2 5/6] ufs: core: sync unipro.h with Linux v6.12
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-topic-ufs-cleanup-v2-5-4c6d7994a45d@linaro.org>
References: <20241230-topic-ufs-cleanup-v2-0-4c6d7994a45d@linaro.org>
In-Reply-To: <20241230-topic-ufs-cleanup-v2-0-4c6d7994a45d@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org, 
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, Love Kumar <love.kumar@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8562;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=BqB/j77VWLz732dNzfVdTKN2U6MFKLyf7gGNEA97/uo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBncnZkfwJSbuYd0F7zefZZwkm1J45Jd4eP+cz0Spgp
 jojTOrWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ3J2ZAAKCRB33NvayMhJ0ZVTEA
 CVfLpqfomHnrDqi7/XcshT9zitFTHs8mtM7xTpJHhBuGT9lJGBtyYlj+usoUw6tJPJCGlSNdkRJ/gJ
 SgeCha4bYGbpfP8qGBXRmM13FjndLjFubXtwJQ6ychFeHXr1nqfuu/fFDpbVMB47Rhuure26Lv6N/V
 /EPC5TqhPYDgwxAYO3st5hhd+LBq/EMgTCLEwzuzeYnSCE/luVyikE1ic8NKINedTt9MFNuDmkYXUB
 Ivw+R/BkD2Og4bVkZrtXk6lwRpHwNFfEgducuaP5tpjvPQkYoNp3z0vfTGvUnCxuadECsbvr77i+OZ
 UBjBuWdj2c/OOuRYzvbrOetva9/Hcel0YWvBsG/oPbhVL67XruQcFZU82aY1uYtT7J4Z6FkEYqvT8v
 DK8NRlsOYa3jScbTuCZvGYBPkd7W2/K6iswB/eqMDuUwjSN1ngaI9uUO7ofNV+7whR423C9I8tOiNH
 qTddd0z6XGYPUoGX9XZQLdFla1yC1xipUfJBZCUgp35PXn06r1mrK8mWbYe+rvaEj/4NV3svWUgIC0
 e0BlSnjVL/igsYXXTfbItNW2f+DPRa1wueMYvjw55l7wsUXvjIpz9bPmPy+eIxAjaVsOj34zuvKQdv
 kDZNiaC32V1sWQhl9i/XvOP9ghGQbyjlVlY2kr4UP30knp4Pcd7uO5hiI9pg==
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

Acked-by: Neha Malcom Francis <n-francis@ti.com>
Tested-by: Love Kumar <love.kumar@amd.com>
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

