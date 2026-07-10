Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79456C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E6684B9D;
	Fri, 10 Jul 2026 20:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kUT8Fbzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E671484AF6; Fri, 10 Jul 2026 16:33:24 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1275584B07
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so6844555e9.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783694002; x=1784298802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Au+hSCsgdvG79tQMADZp4nw2zDB+oyYhm91Q/kvUiL4=;
 b=kUT8FbzzZJhLy9MOvwuSOpGJBAX5EFDYXk0PlgTCaak4M7LN0p7800d91MbxA1xMN+
 r3b+zzzXTle6HeRLv9Zvu02sEQdtA5KJ/AmVF7c/ulSJezEXZ6IhGrqzY2XUzS8SUdsD
 do1R3BoYcNqBjjZuRQRYISmqFJmNvssfPsAL0uLGBB2QLO5QBCzRzaxCS0/WWkIImer9
 1FwPNpxqCUPuNMXu2r79y7W1eBu6eG3I5FgAmajdmc7E0kMSefxgJassJPzWfImdHNwm
 +wDL5IV548fhgvfhabySWH2KvTUUf/sskkbthz+Mv+lAatYrYmh05ruv6Zh9y2FMPJZ5
 IpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783694002; x=1784298802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Au+hSCsgdvG79tQMADZp4nw2zDB+oyYhm91Q/kvUiL4=;
 b=JTmPQ2nuVo0qocH1s4pu352dPh9cbEw59nm9YAG+VzFdj9INg/REorwWyxdevRK9XN
 7fYOeW9bwGxEaWY+rGY0koIAy3wCSd3h2vvTcXC8fUlagzJNn5ekLT+3RPwas8NXS5v3
 Tq71aySEoRuPmY1gDFq5HVMUdUaJQp5/HZ3FTsrOrone4QrTmnqIApIjO6k0dw+aGOzF
 jOcA6SVTk36LhfSkMmce5t5M/WGjZEVdy3nIbE34m+Zil1k9ZTZZSjKv0DWxETRn9JnV
 v7/HvHbDOPZBRR4VkmOu958aK8UPNBj3y+6G6lNuaMW0yvalxeQTAsp2/gAMS5G6fU23
 ddVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqO6qIVBFumH02T5ton+dLlklP6/XECx5V5nwhVr8mZRvZypJOWkrd8m3Ks/gqyCueQzIeCkIU=@lists.denx.de
X-Gm-Message-State: AOJu0YyT2HBLmcvcsyZBANmC1mHch/hwjuF3E/Y3K7Yv+KWnyug/4MFP
 tWTR8+Qzj4haDJVwI3e48onS+yYSOmc4GWA2zRPDYXH47a97/zVIJwMh
X-Gm-Gg: AfdE7cnu4xz7vA/2Xu/rtiEJQ6ErexIDLhUwcDptPn4Yrw5xvn/VmXYyjr/VAJukyhv
 jVjxUwb7BlrE+YRbqtTIVWJs14i7rjevXLiqV2m0g1bJ8qy8zpkwOvDUeNywlXov0YkC4VYsKvZ
 b6Pl2zbEFAELMRSUZGqbovNqSB1gm5LHXaT0hCpaBf6H+2W+rTCcmcIkqicV7hRJ3qaemuljT+J
 UahdE4ps/z6Q+xpGLH0Crzbe2iq+Gyj+9fKp2yRhQXr7LCANo2WFX6U+CI48mPrwXorG6SCaRxd
 +rmfF4C+9JYZL3MTlO8+wcsKs+mvfrGBVLLVKW/zmnxtgri80CBRw2e4vUBLfqQ3Bpf6KADFmZF
 7hk76L0lTXvHj9qUmuBz3kFBxMrlSFpBFHjTigYvLmGl/NIyVn3Gqa7gi9aERy1wKofBRnhmi4h
 HDECC7/Cg89wv8I5I=
X-Received: by 2002:a05:600c:5307:b0:493:f442:3de9 with SMTP id
 5b1f17b1804b1-493f442425emr34472485e9.27.1783694002331; 
 Fri, 10 Jul 2026 07:33:22 -0700 (PDT)
Received: from vitor-nb ([2001:8a0:c4c6:f00:3cb5:ed02:715f:532b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm60549688f8f.13.2026.07.10.07.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:33:21 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 7/7] toradex: tdx-cfg-block: Add verdin am62 0242 pid4
Date: Fri, 10 Jul 2026 15:33:05 +0100
Message-ID: <20260710143258.285091-16-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710143258.285091-9-ivitro@gmail.com>
References: <20260710143258.285091-9-ivitro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Jul 2026 20:11:20 +0200
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

Add the new 0242 PID4 to config block handling:

- 0242 Verdin AM62 Dual 1GB WB ET

Update the board-specific variant selection to use the Wi-Fi variant
for the new WB SKU.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c    | 1 +
 board/toradex/common/tdx-cfg-block.h    | 1 +
 board/toradex/verdin-am62/verdin-am62.c | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 465254ac2bf5..1998411ebde4 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -200,6 +200,7 @@ const struct toradex_som toradex_modules[] = {
 	{ VERDIN_IMX8MPQ_8GB_WIFI_BT_IT_64G,     "Verdin iMX8M Plus Quad 8GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MP)        },
 	{ VERDIN_IMX8MMQ_2G_WIFI_BT_IT_64G,      "Verdin iMX8M Mini Quad 2GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MM)        },
 	{ SMARC_IMX8MPQ_4GB_WB_IT_64G,           "SMARC iMX8M Plus Quad 4GB WB IT",      TARGET_IS_ENABLED(TORADEX_SMARC_IMX8MP) },
+	{ VERDIN_AM62D_1G_WIFI_BT_ET,            "Verdin AM62 Dual 1GB WB ET",           TARGET_IS_ENABLED(VERDIN_AM62_A53)      },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index 2d038a67a1b9..bf6a08613780 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -163,6 +163,7 @@ enum {
 	VERDIN_IMX8MPQ_8GB_WIFI_BT_IT_64G,
 	VERDIN_IMX8MMQ_2G_WIFI_BT_IT_64G,
 	SMARC_IMX8MPQ_4GB_WB_IT_64G, /* 240 */
+	VERDIN_AM62D_1G_WIFI_BT_ET = 242,
 };
 
 enum {
diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index 26af1af2069f..6d1b79aa5ab1 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -85,7 +85,8 @@ static void select_dt_from_module_version(void)
 		is_wifi = (tdx_hw_tag.prodid == VERDIN_AM62Q_WIFI_BT_IT) ||
 			  (tdx_hw_tag.prodid == VERDIN_AM62S_512MB_WIFI_BT_IT) ||
 			  (tdx_hw_tag.prodid == VERDIN_AM62D_1G_WIFI_BT_IT) ||
-			  (tdx_hw_tag.prodid == VERDIN_AM62Q_2G_WIFI_BT_IT);
+			  (tdx_hw_tag.prodid == VERDIN_AM62Q_2G_WIFI_BT_IT) ||
+			  (tdx_hw_tag.prodid == VERDIN_AM62D_1G_WIFI_BT_ET);
 	}
 
 	if (is_wifi)
-- 
2.54.0

