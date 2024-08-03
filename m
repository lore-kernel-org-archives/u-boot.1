Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945FFC3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C965188C87;
	Sat,  3 Aug 2024 13:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IBGoCJGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F81188BFF; Sat,  3 Aug 2024 13:10:46 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F07A88C3D
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso59838045e9.0
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683444; x=1723288244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5J7osscbwOrN4fHsNHqlnlPMxbcxwq10GBeEsEPYK44=;
 b=IBGoCJGe45Tr3FO9BTXe2WKtmFVCwWGR/f4Hj4SEtpfsIR/VpVhtgCKaKyE/CbICOu
 WEbwN1tePAhnxb6TH81J3h5zQ6wfti7BD6/9AXAY3m4LuYY/2lgpLiVn98m/hmIquQ9E
 prVVy0twQsk7pVRaZzJQ3Wju8xBk7ICfc0go80zOrVnvV6UlVWzd8BFHjhMcK0kMdaF1
 1yab7JkSzM6YTCjRjdJ7Si0myePmw+97Qn/OlN5Xg38BaUtiwO6IuptMh3d+xCwT3VdS
 M4rjsC4LahKwJmpdLjWwYbpviJsOkBAPjT9qr1ZqDAdK56PDpTByfv1KLvuYTQXiegvn
 H/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683444; x=1723288244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5J7osscbwOrN4fHsNHqlnlPMxbcxwq10GBeEsEPYK44=;
 b=mRRl/aSD/tTJUpee6VAWIVeGZdXxAWFEobZm1kpCbBXAbBotQ1UmQl89OdNIn0p5km
 C4vBO54RIFRjP/kmDHGbgUalq3jlutdub0qnCfFoE9JNNhXVrmjHK5OtmNIjlXMTar/6
 tZzzMmaqpE5RT8ZumbVUlVdRp6VafJU2m2lacXtUPhDM2DrTliPybIGpY0qLrT+kprJK
 uu7DjeGCNfVgojTkUIU772ufQEiAABHfYN/LO/W7KB+SxMkc3cc3tmyIwxVc8ZBzv85t
 AToenuKplqZGJN/YH+58W5njURqimYSvUWVJzqhmCoTrYz5o/R4+0N73YWdsmlTJttIY
 7psQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4RjYsrzi/jywABl+cIMaCpucOs64+a5o/VrmZBUscQPFvAxkGn+TnNnDKKIBpipmNR9kpVI9w2BIhn39hBfEZ2TJotQ==
X-Gm-Message-State: AOJu0YyDW/FSXaMdpfm6s70B4rZNFE9fa8/BzwCOdUhi4zTcRbVuJU1y
 jIip49CPzUqZvTzvW/2RJ9YrUr7rw3EUAC/eU2ZUqCh9Rmxrw2oD
X-Google-Smtp-Source: AGHT+IHeBZQ9Wuhy/VRsJrDQGv8+XaYJaUbZetyhvu8xNxkLSwob1ZHgtcgxzoYAPwIjC7HkTqbGrQ==
X-Received: by 2002:a5d:5184:0:b0:368:785f:b790 with SMTP id
 ffacd0b85a97d-36bbc0ce3f1mr3859985f8f.1.1722683443594; 
 Sat, 03 Aug 2024 04:10:43 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dc9asm4085699f8f.15.2024.08.03.04.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:10:43 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 07/15] clk: mediatek: mt7986: fix typo for infra_i2c0_ck
Date: Sat,  3 Aug 2024 10:40:40 +0200
Message-ID: <20240803084050.449-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803084050.449-1-ansuelsmth@gmail.com>
References: <20240803084050.449-1-ansuelsmth@gmail.com>
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

Fix a typo for infra_i2c0_ck where 0 was misspelled as O.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7986.c      | 2 +-
 include/dt-bindings/clock/mt7986-clk.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 5f07de23756..303d959d750 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -452,7 +452,7 @@ static const struct mtk_gate infracfg_ao_gates[] = {
 	GATE_INFRA0_TOP(CK_INFRA_TRNG_CK, "infra_trng", CK_TOP_SYSAXI_SEL, 26),
 	/* INFRA1 */
 	GATE_INFRA1_TOP(CK_INFRA_THERM_CK, "infra_therm", CK_TOP_F26M_SEL, 0),
-	GATE_INFRA1_TOP(CK_INFRA_I2CO_CK, "infra_i2co", CK_TOP_I2C_SEL, 1),
+	GATE_INFRA1_TOP(CK_INFRA_I2C0_CK, "infra_i2co", CK_TOP_I2C_SEL, 1),
 	GATE_INFRA1_INFRA(CK_INFRA_UART0_CK, "infra_uart0", CK_INFRA_UART0_SEL, 2),
 	GATE_INFRA1_INFRA(CK_INFRA_UART1_CK, "infra_uart1", CK_INFRA_UART1_SEL, 3),
 	GATE_INFRA1_INFRA(CK_INFRA_UART2_CK, "infra_uart2", CK_INFRA_UART2_SEL, 4),
diff --git a/include/dt-bindings/clock/mt7986-clk.h b/include/dt-bindings/clock/mt7986-clk.h
index 16faca5fef8..a48d57512d1 100644
--- a/include/dt-bindings/clock/mt7986-clk.h
+++ b/include/dt-bindings/clock/mt7986-clk.h
@@ -142,7 +142,7 @@
 #define CK_INFRA_SEJ_CK			15
 #define CK_INFRA_SEJ_13M_CK		16
 #define CK_INFRA_THERM_CK		17
-#define CK_INFRA_I2CO_CK		18
+#define CK_INFRA_I2C0_CK		18
 #define CK_INFRA_TRNG_CK		19
 #define CK_INFRA_UART0_CK		20
 #define CK_INFRA_UART1_CK		21
-- 
2.45.2

