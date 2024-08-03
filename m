Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B44C52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 08:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FC1488C50;
	Sat,  3 Aug 2024 10:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fERwBecY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE75388C56; Sat,  3 Aug 2024 10:33:25 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 159BC88B43
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 10:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-428085a3ad1so61359885e9.1
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 01:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722674003; x=1723278803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g8dLFD+YkoMVbpNvvy3JxioQ9+MQyg5vFHEr6wx62Jo=;
 b=fERwBecYGwkhEHcNlsJXDGS98Fkt5xK+LHp5Q+HieeXYhGZI9/L0ebnAGwym0/6oXv
 ieoOEznnl1e1TLb6Rp4NC8LL/uDvsd6K+H/feWbt3YHKJvoC+DkfPEgYII7FTrh3tmH1
 AwYWtUTRo89BesZ/aWL0DzdSc7Ak8dpV1fNRDIlvUKLHaGQrGjaIvuP4BB14G2WRrGsI
 fhMIz16iEpX2SvrmFmMe7nlLWMue6xHUiu2zug371gL9aIzLiTnowUA++kIzCyR1BHHK
 yY67RTC2Nyt2nh3yB6pC7e+HuCC8RFH3RQsMhZI7yOaAtzu7381AJ0wc1PdxUVM1a3F3
 pfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722674003; x=1723278803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8dLFD+YkoMVbpNvvy3JxioQ9+MQyg5vFHEr6wx62Jo=;
 b=awiaLglYxQtlSFPLF54YpVpY7tA08eK2c+VsIwA579JseMgipVyTWNIhPVnAhldxvu
 p1qwij824Y/hXAl2i8OMb9t0pyj/MUfszgKmtkfZPAdGawqNOTb6NVbzRz4CF2xIZWyX
 SVun/c66ChXCzbtZ7tviWDRqSEjzlGAyR3Q6FeNzsqq4qnLMQowd4nacsUdKjmkV3yxk
 BxFob62yHXOMBaQ4ZxYhpNZDSlcDP9lPVPeKQ/VMYEORVqUy7K7fJJq1gO1dG5Ew+whk
 ywcTVuAYthPx1HnndJ4CBQIcI8PY1av+m7C7ZLDLS9blrScJI7U1wl1EMl+dfunMmsNu
 bCeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/yvpksh634LkzKgyhKBq6Uc0TXCQ3DQ3gCRcRxDYx5P3QugFRe7Ul78S/58PsCIxh86RuBEa4C6tgnX+6rJs+Tf/C3w==
X-Gm-Message-State: AOJu0Yz6IrahiTExI9cR+XC+XPadiTm2QGS3rY/Uk70q26obzV9ALclv
 l+INvWm4eiX+1FOBN8pNR71sOK4fqWV5LtYzyXSRL/LSniU02E/s
X-Google-Smtp-Source: AGHT+IFd7/SgE5qd2lx5LlVqH6zo3l6VoY3OWZ7k96IHfNqLFW4g1UqhWYdNKQmI9s3q0d9DgoRP5Q==
X-Received: by 2002:a05:600c:a43:b0:428:16a0:1c3f with SMTP id
 5b1f17b1804b1-428e6b83288mr44742485e9.32.1722674003028; 
 Sat, 03 Aug 2024 01:33:23 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4282baba5f2sm121248145e9.26.2024.08.03.01.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 01:33:22 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Dong Huang <dong.huang@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH 03/13] clk: mediatek: mt7988: rename
 TOP_CK_NPU_SEL_CM_TOPS_SEL to TOP_NPU_SEL
Date: Sat,  3 Aug 2024 10:32:52 +0200
Message-ID: <20240803083305.30697-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803083305.30697-1-ansuelsmth@gmail.com>
References: <20240803083305.30697-1-ansuelsmth@gmail.com>
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

Upstream kernel linux clock include use TOP_NPU_SEL instead of
TOP_CK_NPU_SEL_CM_TOPS_SEL.
Rename this clock to the upstream kernel in preparation for support of
OF_UPSTREAM.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7988.c      | 2 +-
 include/dt-bindings/clock/mt7988-clk.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index e2324f40084..1ce8c4d8fef 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -420,7 +420,7 @@ static const struct mtk_composite topckgen_mtk_muxes[] = {
 		0x110, 0x114, 0x118, 24, 2, 31, 0x1c8, 9),
 	TOP_MUX(CK_TOP_ETH_MII_SEL, "eth_mii_sel", eth_mii_parents, 0x120,
 		0x124, 0x128, 0, 1, 7, 0x1c8, 10),
-	TOP_MUX(CK_TOP_CK_NPU_SEL_CM_TOPS_SEL, "ck_npu_sel_cm_tops_sel",
+	TOP_MUX(CK_TOP_NPU_SEL, "ck_npu_sel",
 		netsys_2x_parents, 0x120, 0x124, 0x128, 8, 2, 15, 0x1c8, 11),
 };
 
diff --git a/include/dt-bindings/clock/mt7988-clk.h b/include/dt-bindings/clock/mt7988-clk.h
index 841dd419e75..4fd968a12ca 100644
--- a/include/dt-bindings/clock/mt7988-clk.h
+++ b/include/dt-bindings/clock/mt7988-clk.h
@@ -309,7 +309,7 @@
 #define CK_TOP_NETSYS_PPEFB_250M_SEL  135 /* Linux CLK ID (70) */
 #define CK_TOP_NETSYS_WARP_SEL	      136 /* Linux CLK ID (71) */
 #define CK_TOP_ETH_MII_SEL	      137 /* Linux CLK ID (72) */
-#define CK_TOP_CK_NPU_SEL_CM_TOPS_SEL 138 /* Linux CLK ID (73) */
+#define CK_TOP_NPU_SEL		      138 /* Linux CLK ID (73) */
 
 /* APMIXEDSYS */
 /* mtk_pll_data */
-- 
2.45.2

