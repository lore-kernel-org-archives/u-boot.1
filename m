Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5530EC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 05:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5080828BC;
	Tue,  3 Jun 2025 07:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="snP9ZXD+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE7D80BAE; Tue,  3 Jun 2025 07:06:55 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7569581FFC
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 07:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2426dda6b=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1748927213; x=1780463213;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jNQHfiGjkL1PLVEcuJtLEyq9L8iKhhYc01MrarKTD64=;
 b=snP9ZXD+oMagFjTJb7lLS501/hd8EJ+TmhaN/OsCnfHG4mGwnSAzOATd
 PTvSUd9xLmQG8rHf+MOA0r15ZfGLjmoKBKHDZuETSBdUb6yuSwgOTe6Mb
 KuAPfPITSv4uWAIICiYxvx81oU5oWKs8yMagZ5FrR9BsYG7rU0q/T9mC4
 h6ryhsUr+c3KRR9gRssJxrdEM+FUcIJXBJC0q8eSx+FKl58Ed/zp4sG0+
 WaCcaFqjFm2ApTP1zSpLioJyB8cb6iMQRiZTQRWjDZx+IJP2B9gExG23+
 MOCxtSQDvRyTACCM/2Ct2i+M0dDf1+2n6slshjJYAE0ziG3pP/D4cPSyG g==;
X-CSE-ConnectionGUID: B4IgzVtZSEitk6TmeJ3+kw==
X-CSE-MsgGUID: ooiNuTP2TMCCRhb4lyjbag==
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="273727173"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Jun 2025 22:06:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 2 Jun 2025 22:06:44 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 2 Jun 2025 22:06:37 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sjg@chromium.org>, <Oliver.Gaskell@analog.com>,
 <malysagreg@gmail.com>, <nathan.morrison@timesys.com>,
 <mkorpershoek@kernel.org>, <robert.marko@sartura.hr>,
 <jerome.forissier@linaro.org>, <sebastian.reichel@collabora.com>,
 <duje.mihanovic@skole.hr>, <sumit.garg@kernel.org>,
 <patrice.chotard@foss.st.com>, <nicolas.ferre@microchip.com>,
 <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v6 4/9] clk: at91: clk-main: drop parent_name check when
 registering main_rc oscillator
Date: Tue, 3 Jun 2025 10:35:51 +0530
Message-ID: <20250603050556.80851-5-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603050556.80851-1-manikandan.m@microchip.com>
References: <20250603050556.80851-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The clk_register function logs an error if parent_name is missing from the
Device Tree.On the SAM9X7, the main_rc node is omitted to stay aligned with
the Linux Device Tree.Remove the parent_name check in at91_clk_main_rc()
to allow it to pass NULL when the parent is not specified.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/clk/at91/clk-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index 09daae97676..a5186f885f0 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -110,7 +110,7 @@ struct clk *at91_clk_main_rc(void __iomem *reg, const char *name,
 	struct clk *clk;
 	int ret;
 
-	if (!reg || !name || !parent_name)
+	if (!reg || !name)
 		return ERR_PTR(-EINVAL);
 
 	main_rc = kzalloc(sizeof(*main_rc), GFP_KERNEL);
-- 
2.25.1

