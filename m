Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54A1C52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41E9C88CC0;
	Sat,  3 Aug 2024 13:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UmOq+HnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1FF188C6D; Sat,  3 Aug 2024 13:13:07 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5EC088C74
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so18689695e9.1
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683585; x=1723288385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bXrki54RVcmmjktEkchfr8DNQEZvOA5hURHgspdveNc=;
 b=UmOq+HnSm2envsQWli2ECtMgzKv7yk383pFclkPgtMZs96uJOrmtb+Mdt4rCkGyK0e
 wo6vG8Mf5hKrMdcXnuj2dL8DD1u3zKHPDk43SUACPqqzBgndQw/87mcsxVCyVaNwKszY
 vZ5I7hw+hxkd7mvvWNwQL3ed6h2GsX4pvqqFLRKT+9VgGrq0ibiq/0Ky//BpLVsO12Dl
 LO4DGwso1HzQ1t2CItqqqz5xLJ6SJxqukRwB1Muqqtiz0iWzej+79rOGceZCjoyATHfx
 A4vJqeDNguu/fm9vZE8nCLz8j8hk06SEze5TmsWNZOuhxBeFumS0nFX9Wixhw3pgnYql
 PXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683585; x=1723288385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bXrki54RVcmmjktEkchfr8DNQEZvOA5hURHgspdveNc=;
 b=eSpOxnb/pLUGCxcb5+qjXCdwtxzkhD29NMyr9QlzaPIt7E+URE33qnyCyV1ZS7sEeb
 PQDUKc84T5ucVKrUunDkkwD83puwaAxzU/uOAhix61cw44ww2rfsnPf+ac3vUvIshhIL
 cXok5YB6ItJMXumKmvdcmbCic8PMPmkpmtCCcbY4HqdTEVosQMMO9HoBLn3HMLVTXomk
 uBfCli7dDnNv53RubQMOxOJqKBDO27EZjyhWWz/OK64RKzi1i6TUOloBx4tt6F6+Xwo/
 b5iOjRooGVIw1sV2r6fhrdO6m3lOiKm1korLbetmqQnht7HOF9tSC2iJzBgcx0tlBozS
 GDUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5OL4iYumql2036KTLMl3AI4uPf0ou9+Ow8if5FUwAPwX7mill6EAMs3fDi1ige/rj7PAr/9GE4DmFSp60XV4txzPwCw==
X-Gm-Message-State: AOJu0YyNd89mSyM5BjsLppKeWch/+R04LGnRRVdRTivYv/ECQes75Rgc
 9sR+LBdEck0WMca20cXGFL5pnNy90S5NEqeBrAvxe9q3zbhxKXiR
X-Google-Smtp-Source: AGHT+IHUvK+cmgHBq15K0imERxgQS60PZnPuuVjixzMXwNQT1L7WDHP6tIn0awV118khfyFA9VCiQA==
X-Received: by 2002:a05:600c:4e90:b0:428:314:f08e with SMTP id
 5b1f17b1804b1-428e6af4c75mr33191945e9.5.1722683584873; 
 Sat, 03 Aug 2024 04:13:04 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6d648a0sm63835655e9.10.2024.08.03.04.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:13:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 3/8] clk: mediatek: mt7622: move INFRA_TRNG to the bottom
Date: Sat,  3 Aug 2024 10:43:21 +0200
Message-ID: <20240803084329.1688-4-ansuelsmth@gmail.com>
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

Move INFRA_TRNG clock to the bottom of the clk ID to match upstream
linux order. This is in preparation of OF_UPSTREAM.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7622.c      |  2 +-
 include/dt-bindings/clock/mt7622-clk.h | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 4a7c5faff1a..8f173b79453 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -382,11 +382,11 @@ static const struct mtk_gate_regs infra_cg_regs = {
 
 static const struct mtk_gate infra_cgs[] = {
 	GATE_INFRA(CLK_INFRA_DBGCLK_PD, CLK_TOP_AXI_SEL, 0),
-	GATE_INFRA(CLK_INFRA_TRNG, CLK_TOP_AXI_SEL, 2),
 	GATE_INFRA(CLK_INFRA_AUDIO_PD, CLK_TOP_AUD_INTBUS_SEL, 5),
 	GATE_INFRA(CLK_INFRA_IRRX_PD, CLK_TOP_IRRX_SEL, 16),
 	GATE_INFRA(CLK_INFRA_APXGPT_PD, CLK_TOP_F10M_REF_SEL, 18),
 	GATE_INFRA(CLK_INFRA_PMIC_PD, CLK_TOP_PMICSPI_SEL, 22),
+	GATE_INFRA(CLK_INFRA_TRNG, CLK_TOP_AXI_SEL, 2),
 };
 
 /* pericfg */
diff --git a/include/dt-bindings/clock/mt7622-clk.h b/include/dt-bindings/clock/mt7622-clk.h
index 78804f40307..2f36abcf8ae 100644
--- a/include/dt-bindings/clock/mt7622-clk.h
+++ b/include/dt-bindings/clock/mt7622-clk.h
@@ -121,11 +121,11 @@
 /* INFRACFG */
 
 #define CLK_INFRA_DBGCLK_PD		0
-#define CLK_INFRA_TRNG			1
-#define CLK_INFRA_AUDIO_PD		2
-#define CLK_INFRA_IRRX_PD		3
-#define CLK_INFRA_APXGPT_PD		4
-#define CLK_INFRA_PMIC_PD		5
+#define CLK_INFRA_AUDIO_PD		1
+#define CLK_INFRA_IRRX_PD		2
+#define CLK_INFRA_APXGPT_PD		3
+#define CLK_INFRA_PMIC_PD		4
+#define CLK_INFRA_TRNG			5
 
 /* PERICFG */
 
-- 
2.45.2

