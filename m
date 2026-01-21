Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27495C44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6335883A6A;
	Thu, 22 Jan 2026 00:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rqPoi7UU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E50D83AB0; Wed, 21 Jan 2026 23:38:29 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A49ED839DF
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 23:38:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-45c9f47e1e8so148918b6e.0
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 14:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769035105; x=1769639905;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QOB11+ZfD6nbjBh75YRBJfTnJE8v+O1L+F/kT64cjwg=;
 b=rqPoi7UUg27pJmnlK33SEQIShmuy3p4+x+FqJw9Crqv5zUIZzJ8mncU3SLWtcsAPQZ
 PnH2traY/yp9Gx9nYTb2qvD65xmwsbvam0kNHe/g3lzp70sO/7tZV8DRpn4LaWEUVdkn
 WKfRtI+CoiXyzl0lFMwcTByfT7oQvv/HyQGkRqLElWWhE3kAzg2OJCDhQJYElQY1ACTh
 frn9ZPQabHphLNf/8zIxpg/nZnPSM5UbdCHui58JB06qbkYiqNeq6gB1o4keBAnV+zRm
 GpXHzyFmc63R6Kpi8OR887o1iOWIaZz0eM1/ixf80vItvwNOkSGH8xRIrl03soMZDc60
 vpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769035105; x=1769639905;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QOB11+ZfD6nbjBh75YRBJfTnJE8v+O1L+F/kT64cjwg=;
 b=DFADNU60ksa0W7ahEok1J3P6+obWhg2hAoJHbHl0sNBy1HmBdxuyKVuzDyVV2YXK5w
 gBfdK2HoMJMVnKqbguPOnVRTf7fjLSUe58HDvckjU2B+1Wp3P0Cl+HLaxVjdclqobd+P
 sZoSl2jWxvJlKR5U0ckt3rGj6X10JYV6FaNMtHnQxyFMTdyQG3kJAUDMZ6x20BTdpQpC
 dHQjWQGY6nlhprCI8IUCPAcgAbt5eismJuTwby1JF7DmGPAqtVLDvSuDt+Vuank00oTA
 YKMS871UEZYgrfVWW6oufeYf5oq+WlBSUa/X+2WzgxWekvlR1rmUyIGJnunt20erOz9d
 G3xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeT7nsm5o4JTAFlrTL3PuNI41NkXz5Kpr9FJ2loUZENBPnJuIVeeGD7ojltN20DZFq7cHpadc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxuw1GBPHT8PV6VVuP7w4jTcpNf57HuARgh0tayqnA8nJkpi1B8
 S2RFk+CREJVvqYJWz05jyGUDAluC3IFxmOmCSKvvPBpWSW5C7W/JafvTCGygktx6QQw=
X-Gm-Gg: AZuq6aJnG91FwtGf+LF2TWWvHM6B9nPt1mYsRPjKc6dUmoTpoM8DIeBSd2BgDCMmw3i
 b/61L0YPPLumBLDgOO7zF1uyGsYwRjkUy916i/pddKhc5NGHY+Vk6d0sYm7dm3Bklxc7gL3/VJK
 drQuFvJiS48owmE5T3rh/51R4XTQN7ARY5nIFiDfGUa2dqjmkhe10nx6OlomVLr2TDh4C3UQ/Cv
 MjE0ffOuttUnx/MpydkxlG11j7/jJ4VEhCFR9ujEpttvoS+O18wDrqLmg9Cp3DfBdEXzgN+i2su
 uvfq5/2q9n+PTHpjK97cgAVg150UCtgI5AKEWcxocPn9T6zMF7LCIUGF+UIfMESMmnCKaDIx9K9
 /YsVdayiTb+uvKX/BlIfmYKWtgVSM4SK7e1qDuHbW/E9AsSlVURiaFl/lZgEjIgJrx06cbyw8Lr
 jCBflknAXDoiJP
X-Received: by 2002:a05:6808:3088:b0:450:b947:1d89 with SMTP id
 5614622812f47-45c9bf82fb9mr8273287b6e.14.1769035105313; 
 Wed, 21 Jan 2026 14:38:25 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9a8b:7a9:24fa:a0a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bd150dasm12452458fac.14.2026.01.21.14.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:38:24 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 21 Jan 2026 16:36:24 -0600
Subject: [PATCH 1/3] mmc: mtk-sd: use GENMASK and FIELD macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-mmc-mtk-dma-support-v1-1-3764b487c087@baylibre.com>
References: <20260121-mmc-mtk-dma-support-v1-0-3764b487c087@baylibre.com>
In-Reply-To: <20260121-mmc-mtk-dma-support-v1-0-3764b487c087@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=27374;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=1je2uZl8Yzpno8BzcO1jGMmJSfaJ/gVNWyy4lXYCVQs=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpcVVKGZsaIVhrseXsVY+Z1645kn2MzrnHtCj78
 9Smpn2AvNKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaXFVShYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AFhYH/ib/dRwwmoR6npy6AJETn9PY7WdlDA4vbkmRI4c
 bfyI3KLVUeBg/1/VZnqXpEMfniDLjHh5g+Lw5++7XNHaH7+Lk5UtJe2w16KUd+LPDBclfYZ9ldH
 W0b+X3UxjWqOIhAYjLN2ZkMjYqMGyHyDTtLZZ1R/jz2pYFaYfwzG6pFHeCDeXmQSS042/4vr32T
 nU5Bdq/khbjwo7p511obnzZStK8Lb9fR+LkGr1mkV23KvoOt7RIhTfpyMVvF5P8JZYp9lMt5HFN
 BMfeod98D3fsPA8r2/miV7JJPviXfMQYwgCtPn4O49uCssRKpekxygW+S0AexF/GkJZB6at6BGm
 ZhL8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 22 Jan 2026 00:20:22 +0100
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

Replace separate mask and shift definitions with GENMASK and FIELD_*
macros for better readability and maintainability.

All macros ending in _M have the suffix dropped. The value remains the
same but is now generated with GENMASK. All macros ending in _S are
removed and their uses replaced with FIELD_PREP and FIELD_GET macros.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/mmc/mtk-sd.c | 357 ++++++++++++++++++++++-----------------------------
 1 file changed, 151 insertions(+), 206 deletions(-)

diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index 2bc700b0d05..69f54a342c6 100644
--- a/drivers/mmc/mtk-sd.c
+++ b/drivers/mmc/mtk-sd.c
@@ -16,6 +16,7 @@
 #include <asm/gpio.h>
 #include <dm/device_compat.h>
 #include <dm/pinctrl.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -23,15 +24,11 @@
 
 /* MSDC_CFG */
 #define MSDC_CFG_HS400_CK_MODE_EXT	BIT(22)
-#define MSDC_CFG_CKMOD_EXT_M		0x300000
-#define MSDC_CFG_CKMOD_EXT_S		20
-#define MSDC_CFG_CKDIV_EXT_M		0xfff00
-#define MSDC_CFG_CKDIV_EXT_S		8
+#define MSDC_CFG_CKMOD_EXT		GENMASK(21, 20)
+#define MSDC_CFG_CKDIV_EXT		GENMASK(19, 8)
 #define MSDC_CFG_HS400_CK_MODE		BIT(18)
-#define MSDC_CFG_CKMOD_M		0x30000
-#define MSDC_CFG_CKMOD_S		16
-#define MSDC_CFG_CKDIV_M		0xff00
-#define MSDC_CFG_CKDIV_S		8
+#define MSDC_CFG_CKMOD			GENMASK(17, 16)
+#define MSDC_CFG_CKDIV			GENMASK(15, 8)
 #define MSDC_CFG_CKSTB			BIT(7)
 #define MSDC_CFG_PIO			BIT(3)
 #define MSDC_CFG_RST			BIT(2)
@@ -45,8 +42,7 @@
 
 /* MSDC_PS */
 #define MSDC_PS_DAT0			BIT(16)
-#define MSDC_PS_CDDBCE_M		0xf000
-#define MSDC_PS_CDDBCE_S		12
+#define MSDC_PS_CDDBCE			GENMASK(15, 12)
 #define MSDC_PS_CDSTS			BIT(1)
 #define MSDC_PS_CDEN			BIT(0)
 
@@ -63,30 +59,22 @@
 
 /* MSDC_FIFOCS */
 #define MSDC_FIFOCS_CLR			BIT(31)
-#define MSDC_FIFOCS_TXCNT_M		0xff0000
-#define MSDC_FIFOCS_TXCNT_S		16
-#define MSDC_FIFOCS_RXCNT_M		0xff
-#define MSDC_FIFOCS_RXCNT_S		0
+#define MSDC_FIFOCS_TXCNT		GENMASK(23, 16)
+#define MSDC_FIFOCS_RXCNT		GENMASK(7, 0)
 
 /* #define SDC_CFG */
-#define SDC_CFG_DTOC_M			0xff000000
-#define SDC_CFG_DTOC_S			24
+#define SDC_CFG_DTOC			GENMASK(31, 24)
 #define SDC_CFG_SDIOIDE			BIT(20)
 #define SDC_CFG_SDIO			BIT(19)
-#define SDC_CFG_BUSWIDTH_M		0x30000
-#define SDC_CFG_BUSWIDTH_S		16
+#define SDC_CFG_BUSWIDTH		GENMASK(17, 16)
 
 /* SDC_CMD */
-#define SDC_CMD_BLK_LEN_M		0xfff0000
-#define SDC_CMD_BLK_LEN_S		16
+#define SDC_CMD_BLK_LEN			GENMASK(27, 16)
 #define SDC_CMD_STOP			BIT(14)
 #define SDC_CMD_WR			BIT(13)
-#define SDC_CMD_DTYPE_M			0x1800
-#define SDC_CMD_DTYPE_S			11
-#define SDC_CMD_RSPTYP_M		0x380
-#define SDC_CMD_RSPTYP_S		7
-#define SDC_CMD_CMD_M			0x3f
-#define SDC_CMD_CMD_S			0
+#define SDC_CMD_DTYPE			GENMASK(12, 11)
+#define SDC_CMD_RSPTYP			GENMASK(9, 7)
+#define SDC_CMD_CMD			GENMASK(5, 0)
 
 /* SDC_STS */
 #define SDC_STS_CMDBUSY			BIT(1)
@@ -96,102 +84,73 @@
 #define SDC_RX_ENHANCE_EN		BIT(20)
 
 /* PATCH_BIT0 */
-#define MSDC_INT_DAT_LATCH_CK_SEL_M	0x380
-#define MSDC_INT_DAT_LATCH_CK_SEL_S	7
+#define MSDC_INT_DAT_LATCH_CK_SEL	GENMASK(9, 7)
 
 /* PATCH_BIT1 */
-#define MSDC_PB1_STOP_DLY_M		0xf00
-#define MSDC_PB1_STOP_DLY_S		8
+#define MSDC_PB1_STOP_DLY		GENMASK(11, 8)
 
 /* PATCH_BIT2 */
-#define MSDC_PB2_CRCSTSENSEL_M		0xe0000000
-#define MSDC_PB2_CRCSTSENSEL_S		29
+#define MSDC_PB2_CRCSTSENSEL		GENMASK(31, 29)
 #define MSDC_PB2_CFGCRCSTS		BIT(28)
-#define MSDC_PB2_RESPSTSENSEL_M		0x70000
-#define MSDC_PB2_RESPSTSENSEL_S		16
+#define MSDC_PB2_RESPSTSENSEL		GENMASK(18, 16)
 #define MSDC_PB2_CFGRESP		BIT(15)
-#define MSDC_PB2_RESPWAIT_M		0x0c
-#define MSDC_PB2_RESPWAIT_S		2
+#define MSDC_PB2_RESPWAIT		GENMASK(3, 2)
 
 /* MSDC_PAD_CTRL0 */
-#define MSDC_PAD_CTRL0_CLKRDSEL_M	0xff000000
-#define MSDC_PAD_CTRL0_CLKRDSEL_S	24
+#define MSDC_PAD_CTRL0_CLKRDSEL		GENMASK(31, 24)
 #define MSDC_PAD_CTRL0_CLKTDSEL		BIT(20)
 #define MSDC_PAD_CTRL0_CLKIES		BIT(19)
 #define MSDC_PAD_CTRL0_CLKSMT		BIT(18)
 #define MSDC_PAD_CTRL0_CLKPU		BIT(17)
 #define MSDC_PAD_CTRL0_CLKPD		BIT(16)
 #define MSDC_PAD_CTRL0_CLKSR		BIT(8)
-#define MSDC_PAD_CTRL0_CLKDRVP_M	0x70
-#define MSDC_PAD_CTRL0_CLKDRVP_S	4
-#define MSDC_PAD_CTRL0_CLKDRVN_M	0x7
-#define MSDC_PAD_CTRL0_CLKDRVN_S	0
+#define MSDC_PAD_CTRL0_CLKDRVP		GENMASK(6, 4)
+#define MSDC_PAD_CTRL0_CLKDRVN		GENMASK(2, 0)
 
 /* MSDC_PAD_CTRL1 */
-#define MSDC_PAD_CTRL1_CMDRDSEL_M	0xff000000
-#define MSDC_PAD_CTRL1_CMDRDSEL_S	24
+#define MSDC_PAD_CTRL1_CMDRDSEL		GENMASK(31, 24)
 #define MSDC_PAD_CTRL1_CMDTDSEL		BIT(20)
 #define MSDC_PAD_CTRL1_CMDIES		BIT(19)
 #define MSDC_PAD_CTRL1_CMDSMT		BIT(18)
 #define MSDC_PAD_CTRL1_CMDPU		BIT(17)
 #define MSDC_PAD_CTRL1_CMDPD		BIT(16)
 #define MSDC_PAD_CTRL1_CMDSR		BIT(8)
-#define MSDC_PAD_CTRL1_CMDDRVP_M	0x70
-#define MSDC_PAD_CTRL1_CMDDRVP_S	4
-#define MSDC_PAD_CTRL1_CMDDRVN_M	0x7
-#define MSDC_PAD_CTRL1_CMDDRVN_S	0
-
+#define MSDC_PAD_CTRL1_CMDDRVP		GENMASK(6, 4)
+#define MSDC_PAD_CTRL1_CMDDRVN		GENMASK(2, 0)
 /* MSDC_PAD_CTRL2 */
-#define MSDC_PAD_CTRL2_DATRDSEL_M	0xff000000
-#define MSDC_PAD_CTRL2_DATRDSEL_S	24
+#define MSDC_PAD_CTRL2_DATRDSEL		GENMASK(31, 24)
 #define MSDC_PAD_CTRL2_DATTDSEL		BIT(20)
 #define MSDC_PAD_CTRL2_DATIES		BIT(19)
 #define MSDC_PAD_CTRL2_DATSMT		BIT(18)
 #define MSDC_PAD_CTRL2_DATPU		BIT(17)
 #define MSDC_PAD_CTRL2_DATPD		BIT(16)
 #define MSDC_PAD_CTRL2_DATSR		BIT(8)
-#define MSDC_PAD_CTRL2_DATDRVP_M	0x70
-#define MSDC_PAD_CTRL2_DATDRVP_S	4
-#define MSDC_PAD_CTRL2_DATDRVN_M	0x7
-#define MSDC_PAD_CTRL2_DATDRVN_S	0
+#define MSDC_PAD_CTRL2_DATDRVP		GENMASK(6, 4)
+#define MSDC_PAD_CTRL2_DATDRVN		GENMASK(2, 0)
 
 /* PAD_TUNE */
-#define MSDC_PAD_TUNE_CLKTDLY_M		0xf8000000
-#define MSDC_PAD_TUNE_CLKTDLY_S		27
-#define MSDC_PAD_TUNE_CMDRRDLY_M	0x7c00000
-#define MSDC_PAD_TUNE_CMDRRDLY_S	22
+#define MSDC_PAD_TUNE_CLKTDLY		GENMASK(31, 27)
+#define MSDC_PAD_TUNE_CMDRRDLY		GENMASK(26, 22)
 #define MSDC_PAD_TUNE_CMD_SEL		BIT(21)
-#define MSDC_PAD_TUNE_CMDRDLY_M		0x1f0000
-#define MSDC_PAD_TUNE_CMDRDLY_S		16
+#define MSDC_PAD_TUNE_CMDRDLY		GENMASK(20, 16)
 #define MSDC_PAD_TUNE_RXDLYSEL		BIT(15)
 #define MSDC_PAD_TUNE_RD_SEL		BIT(13)
-#define MSDC_PAD_TUNE_DATRRDLY_M	0x1f00
-#define MSDC_PAD_TUNE_DATRRDLY_S	8
-#define MSDC_PAD_TUNE_DATWRDLY_M	0x1f
-#define MSDC_PAD_TUNE_DATWRDLY_S	0
+#define MSDC_PAD_TUNE_DATRRDLY		GENMASK(12, 8)
+#define MSDC_PAD_TUNE_DATWRDLY		GENMASK(4, 0)
 
-#define PAD_CMD_TUNE_RX_DLY3		0x3E
-#define PAD_CMD_TUNE_RX_DLY3_S		1
+#define PAD_CMD_TUNE_RX_DLY3		GENMASK(5, 1)
 
 /* PAD_TUNE0 */
-#define MSDC_PAD_TUNE0_DAT0RDDLY_M	0x1f000000
-#define MSDC_PAD_TUNE0_DAT0RDDLY_S	24
-#define MSDC_PAD_TUNE0_DAT1RDDLY_M	0x1f0000
-#define MSDC_PAD_TUNE0_DAT1RDDLY_S	16
-#define MSDC_PAD_TUNE0_DAT2RDDLY_M	0x1f00
-#define MSDC_PAD_TUNE0_DAT2RDDLY_S	8
-#define MSDC_PAD_TUNE0_DAT3RDDLY_M	0x1f
-#define MSDC_PAD_TUNE0_DAT3RDDLY_S	0
+#define MSDC_PAD_TUNE0_DAT0RDDLY	GENMASK(28, 24)
+#define MSDC_PAD_TUNE0_DAT1RDDLY	GENMASK(20, 16)
+#define MSDC_PAD_TUNE0_DAT2RDDLY	GENMASK(12, 8)
+#define MSDC_PAD_TUNE0_DAT3RDDLY	GENMASK(4, 0)
 
 /* PAD_TUNE1 */
-#define MSDC_PAD_TUNE1_DAT4RDDLY_M	0x1f000000
-#define MSDC_PAD_TUNE1_DAT4RDDLY_S	24
-#define MSDC_PAD_TUNE1_DAT5RDDLY_M	0x1f0000
-#define MSDC_PAD_TUNE1_DAT5RDDLY_S	16
-#define MSDC_PAD_TUNE1_DAT6RDDLY_M	0x1f00
-#define MSDC_PAD_TUNE1_DAT6RDDLY_S	8
-#define MSDC_PAD_TUNE1_DAT7RDDLY_M	0x1f
-#define MSDC_PAD_TUNE1_DAT7RDDLY_S	0
+#define MSDC_PAD_TUNE1_DAT4RDDLY	GENMASK(28, 24)
+#define MSDC_PAD_TUNE1_DAT5RDDLY	GENMASK(20, 16)
+#define MSDC_PAD_TUNE1_DAT6RDDLY	GENMASK(12, 8)
+#define MSDC_PAD_TUNE1_DAT7RDDLY	GENMASK(4, 0)
 
 /* EMMC50_CFG0 */
 #define EMMC50_CFG_CFCSTS_SEL		BIT(4)
@@ -203,21 +162,19 @@
 /* EMMC_TOP_CONTROL mask */
 #define PAD_RXDLY_SEL			BIT(0)
 #define DELAY_EN			BIT(1)
-#define PAD_DAT_RD_RXDLY2		(0x1f << 2)
-#define PAD_DAT_RD_RXDLY		(0x1f << 7)
-#define PAD_DAT_RD_RXDLY_S		7
+#define PAD_DAT_RD_RXDLY2		GENMASK(6, 2)
+#define PAD_DAT_RD_RXDLY		GENMASK(11, 7)
 #define PAD_DAT_RD_RXDLY2_SEL		BIT(12)
 #define PAD_DAT_RD_RXDLY_SEL		BIT(13)
 #define DATA_K_VALUE_SEL		BIT(14)
 #define SDC_RX_ENH_EN			BIT(15)
 
 /* EMMC_TOP_CMD mask */
-#define PAD_CMD_RXDLY2			(0x1f << 0)
-#define PAD_CMD_RXDLY			(0x1f << 5)
-#define PAD_CMD_RXDLY_S			5
+#define PAD_CMD_RXDLY2			GENMASK(4, 0)
+#define PAD_CMD_RXDLY			GENMASK(9, 5)
 #define PAD_CMD_RD_RXDLY2_SEL		BIT(10)
 #define PAD_CMD_RD_RXDLY_SEL		BIT(11)
-#define PAD_CMD_TX_DLY			(0x1f << 12)
+#define PAD_CMD_TX_DLY			GENMASK(16, 12)
 
 /* SDC_CFG_BUSWIDTH */
 #define MSDC_BUS_1BITS			0x0
@@ -428,14 +385,12 @@ static void msdc_fifo_clr(struct msdc_host *host)
 
 static u32 msdc_fifo_rx_bytes(struct msdc_host *host)
 {
-	return (readl(&host->base->msdc_fifocs) &
-		MSDC_FIFOCS_RXCNT_M) >> MSDC_FIFOCS_RXCNT_S;
+	return FIELD_GET(MSDC_FIFOCS_RXCNT, readl(&host->base->msdc_fifocs));
 }
 
 static u32 msdc_fifo_tx_bytes(struct msdc_host *host)
 {
-	return (readl(&host->base->msdc_fifocs) &
-		MSDC_FIFOCS_TXCNT_M) >> MSDC_FIFOCS_TXCNT_S;
+	return FIELD_GET(MSDC_FIFOCS_TXCNT, readl(&host->base->msdc_fifocs));
 }
 
 static u32 msdc_cmd_find_resp(struct msdc_host *host, struct mmc_cmd *cmd)
@@ -504,10 +459,10 @@ static u32 msdc_cmd_prepare_raw_cmd(struct msdc_host *host,
 		blocksize = data->blocksize;
 	}
 
-	rawcmd |= ((opcode << SDC_CMD_CMD_S) & SDC_CMD_CMD_M) |
-		((resp_type << SDC_CMD_RSPTYP_S) & SDC_CMD_RSPTYP_M) |
-		((blocksize << SDC_CMD_BLK_LEN_S) & SDC_CMD_BLK_LEN_M) |
-		((dtype << SDC_CMD_DTYPE_S) & SDC_CMD_DTYPE_M);
+	rawcmd |= FIELD_PREP(SDC_CMD_CMD, opcode) |
+		  FIELD_PREP(SDC_CMD_RSPTYP, resp_type) |
+		  FIELD_PREP(SDC_CMD_BLK_LEN, blocksize) |
+		  FIELD_PREP(SDC_CMD_DTYPE, dtype);
 
 	if (opcode == MMC_CMD_STOP_TRANSMISSION)
 		rawcmd |= SDC_CMD_STOP;
@@ -590,10 +545,8 @@ static int msdc_start_command(struct msdc_host *host, struct mmc_cmd *cmd,
 	if (!msdc_cmd_is_ready(host))
 		return -EIO;
 
-	if ((readl(&host->base->msdc_fifocs) &
-	    MSDC_FIFOCS_TXCNT_M) >> MSDC_FIFOCS_TXCNT_S ||
-	    (readl(&host->base->msdc_fifocs) &
-	    MSDC_FIFOCS_RXCNT_M) >> MSDC_FIFOCS_RXCNT_S) {
+	if (FIELD_GET(MSDC_FIFOCS_TXCNT, readl(&host->base->msdc_fifocs)) ||
+	    FIELD_GET(MSDC_FIFOCS_RXCNT, readl(&host->base->msdc_fifocs))) {
 		pr_err("TX/RX FIFO non-empty before start of IO. Reset\n");
 		msdc_reset_hw(host);
 	}
@@ -814,37 +767,35 @@ static void msdc_set_timeout(struct msdc_host *host, u32 ns, u32 clks)
 		/* unit is 1048576 sclk cycles */
 		timeout = (timeout + (0x1 << shift) - 1) >> shift;
 		if (host->dev_comp->clk_div_bits == 8)
-			mode = (readl(&host->base->msdc_cfg) &
-				MSDC_CFG_CKMOD_M) >> MSDC_CFG_CKMOD_S;
+			mode = FIELD_GET(MSDC_CFG_CKMOD, readl(&host->base->msdc_cfg));
 		else
-			mode = (readl(&host->base->msdc_cfg) &
-				MSDC_CFG_CKMOD_EXT_M) >> MSDC_CFG_CKMOD_EXT_S;
+			mode = FIELD_GET(MSDC_CFG_CKMOD_EXT, readl(&host->base->msdc_cfg));
 		/* DDR mode will double the clk cycles for data timeout */
 		timeout = mode >= 2 ? timeout * 2 : timeout;
 		timeout = timeout > 1 ? timeout - 1 : 0;
 		timeout = timeout > 255 ? 255 : timeout;
 	}
 
-	clrsetbits_le32(&host->base->sdc_cfg, SDC_CFG_DTOC_M,
-			timeout << SDC_CFG_DTOC_S);
+	clrsetbits_le32(&host->base->sdc_cfg, SDC_CFG_DTOC,
+			FIELD_PREP(SDC_CFG_DTOC, timeout));
 }
 
 static void msdc_set_buswidth(struct msdc_host *host, u32 width)
 {
 	u32 val = readl(&host->base->sdc_cfg);
 
-	val &= ~SDC_CFG_BUSWIDTH_M;
+	val &= ~SDC_CFG_BUSWIDTH;
 
 	switch (width) {
 	default:
 	case 1:
-		val |= (MSDC_BUS_1BITS << SDC_CFG_BUSWIDTH_S);
+		val |= FIELD_PREP(SDC_CFG_BUSWIDTH, MSDC_BUS_1BITS);
 		break;
 	case 4:
-		val |= (MSDC_BUS_4BITS << SDC_CFG_BUSWIDTH_S);
+		val |= FIELD_PREP(SDC_CFG_BUSWIDTH, MSDC_BUS_4BITS);
 		break;
 	case 8:
-		val |= (MSDC_BUS_8BITS << SDC_CFG_BUSWIDTH_S);
+		val |= FIELD_PREP(SDC_CFG_BUSWIDTH, MSDC_BUS_8BITS);
 		break;
 	}
 
@@ -918,18 +869,17 @@ static void msdc_set_mclk(struct udevice *dev,
 	clrbits_le32(&host->base->msdc_cfg, MSDC_CFG_CKPDN);
 
 	if (host->dev_comp->clk_div_bits == 8) {
-		div = min(div, (u32)(MSDC_CFG_CKDIV_M >> MSDC_CFG_CKDIV_S));
+		div = min(div, (u32)FIELD_MAX(MSDC_CFG_CKDIV));
 		clrsetbits_le32(&host->base->msdc_cfg,
-				MSDC_CFG_CKMOD_M | MSDC_CFG_CKDIV_M,
-				(mode << MSDC_CFG_CKMOD_S) |
-				(div << MSDC_CFG_CKDIV_S));
+				MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
+				FIELD_PREP(MSDC_CFG_CKMOD, mode) |
+				FIELD_PREP(MSDC_CFG_CKDIV, div));
 	} else {
-		div = min(div, (u32)(MSDC_CFG_CKDIV_EXT_M >>
-				      MSDC_CFG_CKDIV_EXT_S));
+		div = min(div, (u32)FIELD_MAX(MSDC_CFG_CKDIV_EXT));
 		clrsetbits_le32(&host->base->msdc_cfg,
-				MSDC_CFG_CKMOD_EXT_M | MSDC_CFG_CKDIV_EXT_M,
-				(mode << MSDC_CFG_CKMOD_EXT_S) |
-				(div << MSDC_CFG_CKDIV_EXT_S));
+				MSDC_CFG_CKMOD_EXT | MSDC_CFG_CKDIV_EXT,
+				FIELD_PREP(MSDC_CFG_CKMOD_EXT, mode) |
+				FIELD_PREP(MSDC_CFG_CKDIV_EXT, div));
 	}
 
 	readl_poll_timeout(&host->base->msdc_cfg, reg,
@@ -1085,10 +1035,10 @@ static inline void msdc_set_cmd_delay(struct msdc_host *host, u32 value)
 
 	if (host->top_base)
 		clrsetbits_le32(&host->top_base->emmc_top_cmd, PAD_CMD_RXDLY,
-				value << PAD_CMD_RXDLY_S);
+				FIELD_PREP(PAD_CMD_RXDLY, value));
 	else
-		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRDLY_M,
-				value << MSDC_PAD_TUNE_CMDRDLY_S);
+		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRDLY,
+				FIELD_PREP(MSDC_PAD_TUNE_CMDRDLY, value));
 }
 
 static inline void msdc_set_data_delay(struct msdc_host *host, u32 value)
@@ -1100,10 +1050,10 @@ static inline void msdc_set_data_delay(struct msdc_host *host, u32 value)
 
 	if (host->top_base)
 		clrsetbits_le32(&host->top_base->emmc_top_control,
-				PAD_DAT_RD_RXDLY, value << PAD_DAT_RD_RXDLY_S);
+				PAD_DAT_RD_RXDLY, FIELD_PREP(PAD_DAT_RD_RXDLY, value));
 	else
-		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATRRDLY_M,
-				value << MSDC_PAD_TUNE_DATRRDLY_S);
+		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATRRDLY,
+				FIELD_PREP(MSDC_PAD_TUNE_DATRRDLY, value));
 }
 
 static int hs400_tune_response(struct udevice *dev, u32 opcode)
@@ -1122,9 +1072,9 @@ static int hs400_tune_response(struct udevice *dev, u32 opcode)
 
 	if (mmc->selected_mode == MMC_HS_200 ||
 	    mmc->selected_mode == UHS_SDR104)
-		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRRDLY_M,
-				host->hs200_cmd_int_delay <<
-				MSDC_PAD_TUNE_CMDRRDLY_S);
+		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRRDLY,
+				FIELD_PREP(MSDC_PAD_TUNE_CMDRRDLY,
+					   host->hs200_cmd_int_delay));
 
 	if (host->r_smpl)
 		clrbits_le32(&host->base->msdc_iocon, MSDC_IOCON_RSPL);
@@ -1133,7 +1083,7 @@ static int hs400_tune_response(struct udevice *dev, u32 opcode)
 
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
 		clrsetbits_le32(tune_reg, PAD_CMD_TUNE_RX_DLY3,
-				i << PAD_CMD_TUNE_RX_DLY3_S);
+				FIELD_PREP(PAD_CMD_TUNE_RX_DLY3, i));
 
 		for (j = 0; j < 3; j++) {
 			cmd_err = mmc_send_tuning(mmc, opcode);
@@ -1148,8 +1098,7 @@ static int hs400_tune_response(struct udevice *dev, u32 opcode)
 
 	final_cmd_delay = get_best_delay(dev, host, cmd_delay);
 	clrsetbits_le32(tune_reg, PAD_CMD_TUNE_RX_DLY3,
-			final_cmd_delay.final_phase <<
-			PAD_CMD_TUNE_RX_DLY3_S);
+			FIELD_PREP(PAD_CMD_TUNE_RX_DLY3, final_cmd_delay.final_phase));
 	final_delay = final_cmd_delay.final_phase;
 
 	dev_info(dev, "Final cmd pad delay: %x\n", final_delay);
@@ -1175,15 +1124,15 @@ static int msdc_tune_response(struct udevice *dev, u32 opcode)
 
 	if (mmc->selected_mode == MMC_HS_200 ||
 	    mmc->selected_mode == UHS_SDR104)
-		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRRDLY_M,
-				host->hs200_cmd_int_delay <<
-				MSDC_PAD_TUNE_CMDRRDLY_S);
+		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRRDLY,
+				FIELD_PREP(MSDC_PAD_TUNE_CMDRRDLY,
+					   host->hs200_cmd_int_delay));
 
 	clrbits_le32(&host->base->msdc_iocon, MSDC_IOCON_RSPL);
 
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
-		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRDLY_M,
-				i << MSDC_PAD_TUNE_CMDRDLY_S);
+		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRDLY,
+				FIELD_PREP(MSDC_PAD_TUNE_CMDRDLY, i));
 
 		for (j = 0; j < 3; j++) {
 			cmd_err = mmc_send_tuning(mmc, opcode);
@@ -1204,8 +1153,8 @@ static int msdc_tune_response(struct udevice *dev, u32 opcode)
 
 	setbits_le32(&host->base->msdc_iocon, MSDC_IOCON_RSPL);
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
-		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRDLY_M,
-				i << MSDC_PAD_TUNE_CMDRDLY_S);
+		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRDLY,
+				FIELD_PREP(MSDC_PAD_TUNE_CMDRDLY, i));
 
 		for (j = 0; j < 3; j++) {
 			cmd_err = mmc_send_tuning(mmc, opcode);
@@ -1224,15 +1173,13 @@ skip_fall:
 	final_maxlen = max(final_rise_delay.maxlen, final_fall_delay.maxlen);
 	if (final_maxlen == final_rise_delay.maxlen) {
 		clrbits_le32(&host->base->msdc_iocon, MSDC_IOCON_RSPL);
-		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRDLY_M,
-				final_rise_delay.final_phase <<
-				MSDC_PAD_TUNE_CMDRDLY_S);
+		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRDLY,
+				FIELD_PREP(MSDC_PAD_TUNE_CMDRDLY, final_rise_delay.final_phase));
 		final_delay = final_rise_delay.final_phase;
 	} else {
 		setbits_le32(&host->base->msdc_iocon, MSDC_IOCON_RSPL);
-		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRDLY_M,
-				final_fall_delay.final_phase <<
-				MSDC_PAD_TUNE_CMDRDLY_S);
+		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRDLY,
+				FIELD_PREP(MSDC_PAD_TUNE_CMDRDLY, final_fall_delay.final_phase));
 		final_delay = final_fall_delay.final_phase;
 	}
 
@@ -1240,9 +1187,8 @@ skip_fall:
 		goto skip_internal;
 
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
-		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRRDLY_M,
-				i << MSDC_PAD_TUNE_CMDRRDLY_S);
-
+		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRRDLY,
+				FIELD_PREP(MSDC_PAD_TUNE_CMDRRDLY, i));
 		cmd_err = mmc_send_tuning(mmc, opcode);
 		if (!cmd_err)
 			internal_delay |= (1 << i);
@@ -1251,9 +1197,9 @@ skip_fall:
 	dev_dbg(dev, "Final internal delay: 0x%x\n", internal_delay);
 
 	internal_delay_phase = get_best_delay(dev, host, internal_delay);
-	clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRRDLY_M,
-			internal_delay_phase.final_phase <<
-			MSDC_PAD_TUNE_CMDRRDLY_S);
+	clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRRDLY,
+			FIELD_PREP(MSDC_PAD_TUNE_CMDRRDLY,
+				   internal_delay_phase.final_phase));
 
 skip_internal:
 	dev_dbg(dev, "Final cmd pad delay: %x\n", final_delay);
@@ -1278,8 +1224,8 @@ static int msdc_tune_data(struct udevice *dev, u32 opcode)
 	clrbits_le32(&host->base->msdc_iocon, MSDC_IOCON_W_DSPL);
 
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
-		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATRRDLY_M,
-				i << MSDC_PAD_TUNE_DATRRDLY_S);
+		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATRRDLY,
+				FIELD_PREP(MSDC_PAD_TUNE_DATRRDLY, i));
 
 		ret = mmc_send_tuning(mmc, opcode);
 		if (!ret) {
@@ -1301,8 +1247,8 @@ static int msdc_tune_data(struct udevice *dev, u32 opcode)
 	setbits_le32(&host->base->msdc_iocon, MSDC_IOCON_W_DSPL);
 
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
-		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATRRDLY_M,
-				i << MSDC_PAD_TUNE_DATRRDLY_S);
+		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATRRDLY,
+				FIELD_PREP(MSDC_PAD_TUNE_DATRRDLY, i));
 
 		ret = mmc_send_tuning(mmc, opcode);
 		if (!ret) {
@@ -1322,24 +1268,24 @@ skip_fall:
 	if (final_maxlen == final_rise_delay.maxlen) {
 		clrbits_le32(&host->base->msdc_iocon, MSDC_IOCON_DSPL);
 		clrbits_le32(&host->base->msdc_iocon, MSDC_IOCON_W_DSPL);
-		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATRRDLY_M,
-				final_rise_delay.final_phase <<
-				MSDC_PAD_TUNE_DATRRDLY_S);
+		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATRRDLY,
+				FIELD_PREP(MSDC_PAD_TUNE_DATRRDLY,
+					   final_rise_delay.final_phase));
 		final_delay = final_rise_delay.final_phase;
 	} else {
 		setbits_le32(&host->base->msdc_iocon, MSDC_IOCON_DSPL);
 		setbits_le32(&host->base->msdc_iocon, MSDC_IOCON_W_DSPL);
-		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATRRDLY_M,
-				final_fall_delay.final_phase <<
-				MSDC_PAD_TUNE_DATRRDLY_S);
+		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATRRDLY,
+				FIELD_PREP(MSDC_PAD_TUNE_DATRRDLY,
+					   final_fall_delay.final_phase));
 		final_delay = final_fall_delay.final_phase;
 	}
 
 	if (mmc->selected_mode == MMC_HS_200 ||
 	    mmc->selected_mode == UHS_SDR104)
-		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATWRDLY_M,
-				host->hs200_write_int_delay <<
-				MSDC_PAD_TUNE_DATWRDLY_S);
+		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATWRDLY,
+				FIELD_PREP(MSDC_PAD_TUNE_DATWRDLY,
+					   host->hs200_write_int_delay));
 
 	dev_dbg(dev, "Final data pad delay: %x\n", final_delay);
 
@@ -1426,7 +1372,7 @@ static int msdc_execute_tuning(struct udevice *dev, uint opcode)
 			clrbits_le32(&host->base->msdc_iocon,
 				     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
 			clrsetbits_le32(&host->base->pad_tune,
-					MSDC_PAD_TUNE_DATRRDLY_M, 0);
+					MSDC_PAD_TUNE_DATRRDLY, 0);
 
 			writel(host->hs400_ds_delay, &host->base->pad_ds_tune);
 			/* for hs400 mode it must be set to 0 */
@@ -1488,8 +1434,8 @@ static void msdc_init_hw(struct msdc_host *host)
 	/* Enable/disable hw card detection according to fdt option */
 	if (host->builtin_cd)
 		clrsetbits_le32(&host->base->msdc_ps,
-			MSDC_PS_CDDBCE_M,
-			(DEFAULT_CD_DEBOUNCE << MSDC_PS_CDDBCE_S) |
+			MSDC_PS_CDDBCE,
+			FIELD_PREP(MSDC_PS_CDDBCE, DEFAULT_CD_DEBOUNCE) |
 			MSDC_PS_CDEN);
 	else
 		clrbits_le32(&host->base->msdc_ps, MSDC_PS_CDEN);
@@ -1518,8 +1464,8 @@ static void msdc_init_hw(struct msdc_host *host)
 	writel(0xffff4089, &host->base->patch_bit1);
 
 	if (host->dev_comp->stop_clk_fix) {
-		clrsetbits_le32(&host->base->patch_bit1, MSDC_PB1_STOP_DLY_M,
-				3 << MSDC_PB1_STOP_DLY_S);
+		clrsetbits_le32(&host->base->patch_bit1, MSDC_PB1_STOP_DLY,
+				FIELD_PREP(MSDC_PB1_STOP_DLY, 3));
 		clrbits_le32(&host->base->sdc_fifo_cfg,
 			     SDC_FIFO_CFG_WRVALIDSEL);
 		clrbits_le32(&host->base->sdc_fifo_cfg,
@@ -1532,8 +1478,8 @@ static void msdc_init_hw(struct msdc_host *host)
 	setbits_le32(&host->base->emmc50_cfg0, EMMC50_CFG_CFCSTS_SEL);
 
 	if (host->dev_comp->async_fifo) {
-		clrsetbits_le32(&host->base->patch_bit2, MSDC_PB2_RESPWAIT_M,
-				3 << MSDC_PB2_RESPWAIT_S);
+		clrsetbits_le32(&host->base->patch_bit2, MSDC_PB2_RESPWAIT,
+				FIELD_PREP(MSDC_PB2_RESPWAIT, 3));
 
 		if (host->dev_comp->enhance_rx) {
 			if (host->top_base)
@@ -1544,11 +1490,11 @@ static void msdc_init_hw(struct msdc_host *host)
 					     SDC_RX_ENHANCE_EN);
 		} else {
 			clrsetbits_le32(&host->base->patch_bit2,
-					MSDC_PB2_RESPSTSENSEL_M,
-					2 << MSDC_PB2_RESPSTSENSEL_S);
+					MSDC_PB2_RESPSTSENSEL,
+					FIELD_PREP(MSDC_PB2_RESPSTSENSEL, 2));
 			clrsetbits_le32(&host->base->patch_bit2,
-					MSDC_PB2_CRCSTSENSEL_M,
-					2 << MSDC_PB2_CRCSTSENSEL_S);
+					MSDC_PB2_CRCSTSENSEL,
+					FIELD_PREP(MSDC_PB2_CRCSTSENSEL, 2));
 		}
 
 		/* use async fifo to avoid tune internal delay */
@@ -1574,9 +1520,9 @@ static void msdc_init_hw(struct msdc_host *host)
 			setbits_le32(tune_reg,
 				     MSDC_PAD_TUNE_RD_SEL | MSDC_PAD_TUNE_CMD_SEL);
 			clrsetbits_le32(&host->base->patch_bit0,
-					MSDC_INT_DAT_LATCH_CK_SEL_M,
-					host->latch_ck <<
-					MSDC_INT_DAT_LATCH_CK_SEL_S);
+					MSDC_INT_DAT_LATCH_CK_SEL,
+					FIELD_PREP(MSDC_INT_DAT_LATCH_CK_SEL,
+						   host->latch_ck));
 		}
 	} else {
 		/* choose clock tune */
@@ -1590,39 +1536,38 @@ static void msdc_init_hw(struct msdc_host *host)
 	if (host->dev_comp->builtin_pad_ctrl) {
 		/* Set pins driving strength */
 		writel(MSDC_PAD_CTRL0_CLKPD | MSDC_PAD_CTRL0_CLKSMT |
-		       MSDC_PAD_CTRL0_CLKIES | (4 << MSDC_PAD_CTRL0_CLKDRVN_S) |
-		       (4 << MSDC_PAD_CTRL0_CLKDRVP_S), &host->base->pad_ctrl0);
+		       MSDC_PAD_CTRL0_CLKIES | FIELD_PREP(MSDC_PAD_CTRL0_CLKDRVN, 4) |
+		       FIELD_PREP(MSDC_PAD_CTRL0_CLKDRVP, 4), &host->base->pad_ctrl0);
 		writel(MSDC_PAD_CTRL1_CMDPU | MSDC_PAD_CTRL1_CMDSMT |
-		       MSDC_PAD_CTRL1_CMDIES | (4 << MSDC_PAD_CTRL1_CMDDRVN_S) |
-		       (4 << MSDC_PAD_CTRL1_CMDDRVP_S), &host->base->pad_ctrl1);
+		       MSDC_PAD_CTRL1_CMDIES | FIELD_PREP(MSDC_PAD_CTRL1_CMDDRVN, 4) |
+		       FIELD_PREP(MSDC_PAD_CTRL1_CMDDRVP, 4), &host->base->pad_ctrl1);
 		writel(MSDC_PAD_CTRL2_DATPU | MSDC_PAD_CTRL2_DATSMT |
-		       MSDC_PAD_CTRL2_DATIES | (4 << MSDC_PAD_CTRL2_DATDRVN_S) |
-		       (4 << MSDC_PAD_CTRL2_DATDRVP_S), &host->base->pad_ctrl2);
+		       MSDC_PAD_CTRL2_DATIES | FIELD_PREP(MSDC_PAD_CTRL2_DATDRVN, 4) |
+		       FIELD_PREP(MSDC_PAD_CTRL2_DATDRVP, 4), &host->base->pad_ctrl2);
 	}
 
 	if (host->dev_comp->default_pad_dly) {
 		/* Default pad delay may be needed if tuning not enabled */
-		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CLKTDLY_M |
-				MSDC_PAD_TUNE_CMDRRDLY_M |
-				MSDC_PAD_TUNE_CMDRDLY_M |
-				MSDC_PAD_TUNE_DATRRDLY_M |
-				MSDC_PAD_TUNE_DATWRDLY_M,
-				(0x10 << MSDC_PAD_TUNE_CLKTDLY_S) |
-				(0x10 << MSDC_PAD_TUNE_CMDRRDLY_S) |
-				(0x10 << MSDC_PAD_TUNE_CMDRDLY_S) |
-				(0x10 << MSDC_PAD_TUNE_DATRRDLY_S) |
-				(0x10 << MSDC_PAD_TUNE_DATWRDLY_S));
-
-		writel((0x10 << MSDC_PAD_TUNE0_DAT0RDDLY_S) |
-		       (0x10 << MSDC_PAD_TUNE0_DAT1RDDLY_S) |
-		       (0x10 << MSDC_PAD_TUNE0_DAT2RDDLY_S) |
-		       (0x10 << MSDC_PAD_TUNE0_DAT3RDDLY_S),
+		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CLKTDLY |
+				MSDC_PAD_TUNE_CMDRRDLY |
+				MSDC_PAD_TUNE_CMDRDLY |
+				MSDC_PAD_TUNE_DATRRDLY |
+				MSDC_PAD_TUNE_DATWRDLY,
+				FIELD_PREP(MSDC_PAD_TUNE_CLKTDLY, 0x10) |
+				FIELD_PREP(MSDC_PAD_TUNE_CMDRRDLY, 0x10) |
+				FIELD_PREP(MSDC_PAD_TUNE_CMDRDLY, 0x10) |
+				FIELD_PREP(MSDC_PAD_TUNE_DATRRDLY, 0x10) |
+				FIELD_PREP(MSDC_PAD_TUNE_DATWRDLY, 0x10));
+		writel(FIELD_PREP(MSDC_PAD_TUNE0_DAT0RDDLY, 0x10) |
+		       FIELD_PREP(MSDC_PAD_TUNE0_DAT1RDDLY, 0x10) |
+		       FIELD_PREP(MSDC_PAD_TUNE0_DAT2RDDLY, 0x10) |
+		       FIELD_PREP(MSDC_PAD_TUNE0_DAT3RDDLY, 0x10),
 		       rd_dly0_reg);
 
-		writel((0x10 << MSDC_PAD_TUNE1_DAT4RDDLY_S) |
-		       (0x10 << MSDC_PAD_TUNE1_DAT5RDDLY_S) |
-		       (0x10 << MSDC_PAD_TUNE1_DAT6RDDLY_S) |
-		       (0x10 << MSDC_PAD_TUNE1_DAT7RDDLY_S),
+		writel(FIELD_PREP(MSDC_PAD_TUNE1_DAT4RDDLY, 0x10) |
+		       FIELD_PREP(MSDC_PAD_TUNE1_DAT5RDDLY, 0x10) |
+		       FIELD_PREP(MSDC_PAD_TUNE1_DAT6RDDLY, 0x10) |
+		       FIELD_PREP(MSDC_PAD_TUNE1_DAT7RDDLY, 0x10),
 		       rd_dly1_reg);
 	}
 
@@ -1633,8 +1578,8 @@ static void msdc_init_hw(struct msdc_host *host)
 	clrbits_le32(&host->base->sdc_cfg, SDC_CFG_SDIOIDE);
 
 	/* Configure to default data timeout */
-	clrsetbits_le32(&host->base->sdc_cfg, SDC_CFG_DTOC_M,
-			3 << SDC_CFG_DTOC_S);
+	clrsetbits_le32(&host->base->sdc_cfg, SDC_CFG_DTOC,
+			FIELD_PREP(SDC_CFG_DTOC, 3));
 
 	host->def_tune_para.iocon = readl(&host->base->msdc_iocon);
 	host->def_tune_para.pad_tune = readl(&host->base->pad_tune);

-- 
2.43.0

