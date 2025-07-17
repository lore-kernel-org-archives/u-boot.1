Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3482BC83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 13:24:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFB76833F1;
	Thu, 17 Jul 2025 15:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k0Cw3JS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8DF1833C0; Thu, 17 Jul 2025 13:02:16 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C476283242
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 13:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45629703011so6016435e9.0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 04:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752750134; x=1753354934; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ADSi54w2MgdvdPzq/dwFt0+54A+JA/UeoxLVEdV/VFg=;
 b=k0Cw3JS3wmCU+GufByObrR43Z+naOB0N+5JEk4WVZ4fKDhJdqI4/Pt3nqL4bpANJ5z
 DPJKebBvTqAvs7UL1+QGY24wbgjx56W3nRx9NZXC6SaPHmRTt5oL5kvtiW4lGJl4/aYw
 +V8TCw1vmG2Wo43S1Mw+bh6iwxcOkcEE3+c5fWpI4L1aLpEbQHyZHZMWoXm97efrxz7Y
 65mz1It7p6RuX7JGmF1akG17QXUmx95tcRXUozD1UK7FBXIvGJtEN2AVN+iCcVJRsMQf
 9MRIRWakehqr+SfJg0JR9SwoJ7nZ5RV0lUQp5y8nSxUVlz9gar/u+0PnlbHxQPrzZKJB
 qasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752750134; x=1753354934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ADSi54w2MgdvdPzq/dwFt0+54A+JA/UeoxLVEdV/VFg=;
 b=q051EErC3P70n+5RuBfro7uoORwFsAZf/XcgJ5u2AYyRj/KNgeUwM69YrPHu7Pdzdd
 JkXRVgLTO6o+UDC5r6z0M+iWj4fuKI6XrcFPzTaaLA/h29Mmx8nFr63l7iZN8tSvSjzh
 P1q9lTs0FBBRfivkOX9WkBz4wnx1NyPwf5+JKVNqMsNr4puVf7aTknYFxuAQ7cy/LDsG
 dmgnqYGkAHxdv09cSu8pNtp6chyuwSeKuRSJnvyZDGStTwYGW4Ec28mbly9ItY9bq/j0
 xXzG87SnkIa7kAfNZX8xxyWCsC7+A3ECxJTIlaIYuP2eEjz5ZTJ1/oOw4dIqXU0vNFfe
 KBfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2szm9eFQsWQE3a4a+kuM6FYqn4Y1tomhQzPd3vdnn+q71nnvBY2YWXE/BIkSUto+9IlH5/gQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxRwR4KJ+9xW04u24LeHcoI8eMGpOs24S6Mj0BJt2ngC4ryz2gd
 +LaNRJN4J9tt7ZRETDlodzYtY5ExpIoh4vpeb3Tp1clAfhCizZzX+mvb
X-Gm-Gg: ASbGnctabw/dUETsDbvY9jhV10m89Tb6+z5WyrCMMeXKVr6qFoiUbd71NLoMO0niX+7
 E4Tb1m01f2eZZomBs5K2hvVYEgZyY7fQGOfx2UCeUb1LZ2/4FX9WDqigVykYcaZkbXZQqbFrc5a
 U7sh4rTDJf3IK8zJhtPNFo9RUA4oCzuOKSn4HGuKAWdQcFvGRhKoJu1jzwFWu/dP3X6ZNqiIsh/
 PLCOoTg3wrBmFD7uXaIE7P4Npx8Q9Nd65iyrmLUZv2l8ZtGiFqbbTqI+vF9sr1WTi7/U0kjruQx
 0h5Jm8bOWcs0VAnmxh0qm3XH56o33L44XCymqsGX2PuHEWGjzZf96bf7qX6PJl893LtytzdrmD9
 2EclfXgt0d8QFXz/dOHFL19w52/vJMoL5+BvM
X-Google-Smtp-Source: AGHT+IEKEm35R1bZ7h7p/UtGMJOV7MeSAplc/oO6qkwHSSCryMYZjan+BPxeIkZckfXrw6xd6FugPg==
X-Received: by 2002:a05:6000:4b0c:b0:3a4:ed10:c14 with SMTP id
 ffacd0b85a97d-3b60dd6a911mr5498978f8f.14.1752750133888; 
 Thu, 17 Jul 2025 04:02:13 -0700 (PDT)
Received: from vitor-nb (bl21-87-120.dsl.telepac.pt. [2.82.87.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45634f5ea01sm18689695e9.14.2025.07.17.04.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 04:02:13 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de,
 ivitro@gmail.com
Subject: [PATCH v1] toradex: tdx-cfg-block: add verdin i.mx8m mini 0216 pid4
Date: Thu, 17 Jul 2025 12:02:08 +0100
Message-ID: <20250717110210.443381-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Jul 2025 15:24:12 +0200
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

From: Vitor Soares <vitor.soares@toradex.com>

Add PID4 0216 Verdin iMX8M Mini Quad 2GB WB IT to config block handling.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c        | 1 +
 board/toradex/common/tdx-cfg-block.h        | 1 +
 board/toradex/verdin-imx8mm/verdin-imx8mm.c | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index a89c5bf2c19c..869656eee7a7 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -183,6 +183,7 @@ const struct toradex_som toradex_modules[] = {
 	{ AQUILA_AM69O_16GB_IT,                  "Aquila AM69 Octa 16GB IT",             TARGET_IS_ENABLED(AQUILA_AM69_A72)      },
 	{ AQUILA_AM69O_8GB_WB_IT,                "Aquila AM69 Octa 8GB WB IT",           TARGET_IS_ENABLED(AQUILA_AM69_A72)      },
 	{ AQUILA_AM69O_8GB_IT,                   "Aquila AM69 Octa 8GB IT",              TARGET_IS_ENABLED(AQUILA_AM69_A72)      },
+	{ VERDIN_IMX8MMQ_WB_IT_64G,              "Verdin iMX8M Mini Quad 2GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MM)        },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index db612811c5c5..d002b969bdfe 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -141,6 +141,7 @@ enum {
 	AQUILA_AM69O_16GB_IT,
 	AQUILA_AM69O_8GB_WB_IT,
 	AQUILA_AM69O_8GB_IT, /* 215 */
+	VERDIN_IMX8MMQ_WB_IT_64G,
 };
 
 enum {
diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
index 066e8db678fb..cf4a0e37af3e 100644
--- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
+++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
@@ -85,7 +85,8 @@ static void select_dt_from_module_version(void)
 		is_wifi = (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WIFI_BT_IT) ||
 			  (tdx_hw_tag.prodid == VERDIN_IMX8MMDL_WIFI_BT_IT) ||
 			  (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WIFI_BT_IT_NO_CAN) ||
-			  (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_4G_WIFI_BT_ET);
+			  (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_4G_WIFI_BT_ET) ||
+			  (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WB_IT_64G);
 	}
 
 	switch (get_pcb_revision()) {
-- 
2.50.1

