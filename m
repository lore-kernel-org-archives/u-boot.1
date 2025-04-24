Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C7AC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 08:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E47E819D2;
	Thu, 24 Apr 2025 10:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GTE1WS6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBEAD815D1; Thu, 24 Apr 2025 10:29:18 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE2180F9C
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 10:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso778782f8f.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 01:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745483356; x=1746088156; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mTqSowR7onOzOmm7MikM97FYdP0iPjjpLW96GQIDaNI=;
 b=GTE1WS6r/JzQ4V7rVZxONZYmrLLb2xel6SZij70FvUR5coKS2bJZflxB2T3sm6NxtW
 8t3XuFO8vuY4C5kLAqfgbJQE4OomnTgymAJ2OJDVnTkfvmcmfaP2DrDIy7QbJ87hG0uT
 wCIRhzWHTD2Dz+lO3l/YpePu3RCEqQq0KPFdM1OzE0U86abYv9jyxNNGSAJ+a+GVNx8l
 Qut6H47jk0n6LaP3dG+fRhnZwfKhDiLvonXZ4eUXLrpd+CtB649PG1sbDvwe26Ppk5rV
 wSheKYeiwbYka8GMR+UTbE32RO2txOI87JB9DEAMqLw5v7Oa7bcQ81DnCbe0+jTVRFLT
 +/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745483356; x=1746088156;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mTqSowR7onOzOmm7MikM97FYdP0iPjjpLW96GQIDaNI=;
 b=KnynDPn2svYnFyPZSxtacRbH1VYm1vAsuMO9Scxuw3iSwFA42hJoKU5T/Z0dJFgXct
 ZvWpJH4QaANoID3ATGj2gjG3Og2z7a0u8I7WaWea2gyUim+kbPKgRRy1om+Ut9ZvS80h
 d2G/b62oyb1E43yKnjIcQsoHvdHuKhlL73GKqQrP2ewcUBZJLixMJuUkTswEDLne+dmu
 mn7igi8hvPIH/nggZR+/3yh/bZoDJtH5J8DZ0Npupsi3vb7bQP0y1yJ2PQcy1aagcdSS
 faUvBbndLXWGs3JYgJBdaor++vSjlNiO4szFX7pb4p7EJLIZrLSjCmXOHSMG7cFQuiAa
 BNug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRX+Z+BclmndCk8MdXw+4KbADxGFTczk6y4P2CA2BBehPjUPA8BwGeOnimUwqY2sZhbdCxd/w=@lists.denx.de
X-Gm-Message-State: AOJu0YwyyqR2e+4kwncDZyp/EgtBPohIn35QhQQiIr5kRf4iGLUHIFFy
 FbhYDML1Pqm8jLCfZi6ZN/gsVJ7HG2s87K6iDcxyN4ZAtc7k8HAL
X-Gm-Gg: ASbGncvSu1pF8ikCOxUuIdja3pYlSSZ8BfYWif+DMSInOchtkCwausXzHWg5C23azaS
 xtWFsK7y6Tk3fhoKmyIE1BffG0NCNdW/+VuXznpRLsB4F2CaSoBtTDdrm6mb6p98gqg6EbiXeqF
 Y58OsjFGWr0foq8LAm8WIcbf0qpT1DJ7CPG1s87fHK3UT713nuJuzQDQJZB/83YsSzi4rD9Mr5u
 0asBJEOodqNe3FTnaJf/JduegVkojT53H5IkcSSzSmVEVYvL8K9vVkAlujGVCvCist3fRpYriQn
 Y42t+7oIqp34TBCSCS38tmbUH4NN4cw5FIkY/3ObGdGq85QZWz+YfZuCmnUxjS2XK+GhuFQv/A=
 =
X-Google-Smtp-Source: AGHT+IGjHULPlIDuVagTv2OqJAda9I6MQU8YuOLRbaqy1uzE31LJNJGOb+ic1Ds71RwZ8LJ6wUy8mg==
X-Received: by 2002:a05:6000:1a86:b0:391:20ef:6300 with SMTP id
 ffacd0b85a97d-3a06cfa5b56mr1143673f8f.37.1745483355893; 
 Thu, 24 Apr 2025 01:29:15 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:2679:3538:2c5a:c691])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4a8065sm1297206f8f.12.2025.04.24.01.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 01:29:15 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
Subject: [PATCH v1] toradex: tdx-cfg-block: fix verdin imx95 sku 0089 pid4
Date: Thu, 24 Apr 2025 10:28:59 +0200
Message-ID: <20250424082909.1396771-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The memory size of the 0089 SKU is 8 GB instead of 16 GB.
Fix PID4 0089 Verdin iMX95 definition, in the configuration block.

Fixes: ce53f46f33b4 ("toradex: tdx-cfg-block: add verdin imx95 sku 0089 pid4")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 2 +-
 board/toradex/common/tdx-cfg-block.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 41e3852b8fa2..6c1cea77c8ce 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -157,7 +157,7 @@ const struct toradex_som toradex_modules[] = {
 	{ VERDIN_IMX8MMDL_2G_IT,                 "Verdin iMX8M Mini DualLite 2GB IT",    TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
 	{ VERDIN_IMX8MMQ_2G_IT_NO_CAN,           "Verdin iMX8M Mini Quad 2GB IT",        TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
 	{ AQUILA_AM69O_32G_WIFI_BT_IT,           "Aquila AM69 Octa 32GB WB IT",          TARGET_IS_ENABLED(AQUILA_AM69_A72) },
-	{ VERDIN_IMX95H_16G_WIFI_BT_IT,          "Verdin iMX95 Hexa 16GB WB IT",         TARGET_IS_ENABLED(VERDIN_IMX95)    },
+	{ VERDIN_IMX95H_8G_WIFI_BT_IT,           "Verdin iMX95 Hexa 8GB WB IT",          TARGET_IS_ENABLED(VERDIN_IMX95)    },
 	{ VERDIN_IMX8MMQ_4G_WIFI_BT_ET,          "Verdin iMX8M Mini Quad 4GB WB ET",     TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
 	{ APALIS_IMX8QM_WIFI_BT_IT_1300MHZ,      "Apalis iMX8QM 4GB WB IT",              TARGET_IS_ENABLED(APALIS_IMX8)     },
 	{ APALIS_IMX8QM_IT_1300MHZ,              "Apalis iMX8QM 4GB IT",                 TARGET_IS_ENABLED(APALIS_IMX8)     },
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index 4a29c0bca848..f4dd853306b3 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -115,7 +115,7 @@ enum {
 	VERDIN_IMX8MMDL_2G_IT,
 	VERDIN_IMX8MMQ_2G_IT_NO_CAN,
 	AQUILA_AM69O_32G_WIFI_BT_IT,
-	VERDIN_IMX95H_16G_WIFI_BT_IT,
+	VERDIN_IMX95H_8G_WIFI_BT_IT,
 	VERDIN_IMX8MMQ_4G_WIFI_BT_ET, /* 90 */
 	APALIS_IMX8QM_WIFI_BT_IT_1300MHZ,
 	APALIS_IMX8QM_IT_1300MHZ,
-- 
2.43.0

From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 0/5] board: toradex: Add new Verdin and Aquila SKUs
Date: Tue, 28 May 2024 11:59:36 +0200	[thread overview]
Message-ID: <20240528095941.872693-1-ghidoliemanuele@gmail.com> (raw)
