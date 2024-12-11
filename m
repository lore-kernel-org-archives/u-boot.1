Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3153E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 12:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1061F8027D;
	Wed, 11 Dec 2024 13:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ko71hDS9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FEA580217; Wed, 11 Dec 2024 13:20:51 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1C018020B
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 13:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eichest@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa6332dde13so955478866b.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 04:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733919649; x=1734524449; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTQOzUW1D0/dwTvvbPWjBzXzkOTLEA2N2il8OF/dKDw=;
 b=Ko71hDS9/ucFbnY6NcAsWRSiYW1Im5klGuCHE5cge+YyXMWVA3dJHMMPnFflLuc/Pw
 C+DXuUf0yrgjxlUNP6/eG+FPBCDLGWaxooPyYL7nwkEW79P9Pdmow3uQWkknwMF+Wlbc
 EAspPu0jmuLKv/5bW9VkRj8eM45jfgZRU6XY7LyfChR83PCMFmGl96vz58qRhaf/8wZ5
 9TDKtC+uCQWLmyZG49BA7z43NnQVku9To/NdvaTA1WKEHiU+qZpeuYXBbzZe7Ao7zq61
 Cd6SVjzl4R/SGNiKv++RGbTXFrRUXY5v88FogXcfFYW1jmXMkKkrx8vg7ndbbaabm4nf
 aVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733919649; x=1734524449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LTQOzUW1D0/dwTvvbPWjBzXzkOTLEA2N2il8OF/dKDw=;
 b=duw/jc7fQEpAdYPspLHxyL4kZ9rVXyR40IugfGmZX7bgxfcf28zAbUTdVEwag5XCwR
 E9oXfpiyxE257nzgEvlb0OzqNx0KDLnW4+ffZGsOi3L1tTxYT2GWwjnkZfw6VnNO6dTJ
 oi/tNQTGgc3X/paqw3njpfJvt+qtc0/9zEsebirq3A7nACya5wucdb85CFiovQ/kuUuZ
 VrmraBqig1fOTmQToRoh4oS5AXZ0C2GgOxkBwiqBjrVBobstRg6b56C3fcPzRtqroRbD
 6zeTBL4OZyatjIRjPs852GVWzDUYU7S9cvTve/l5vSlPOrfVaK8QDPHbhiXTRRm4KpNd
 lc5w==
X-Gm-Message-State: AOJu0Yxo6SGrVdMYK9jwzdt2JOM2Pkupx2rEZnoEt/iTrr0YdSFFBq6e
 sqvdoWbUxlMIWLS9F25/bKfMXrpLdFyvH5pmdwqawOwlM81bI2qR
X-Gm-Gg: ASbGncv/qzuf8eCpN+mhf13lLkSb2WkPfElpTdsUoygcf0Hqnd0MKPRdvpLY/bw5sf0
 qnXiuC6SjdP5vfvWaNIDtU8m67PYLCjeHcAM9Vmgfy0EBrzJoTio3Z4YPp0jhSgh7xoDUCacZuK
 uL2AxfHsdgGfjI3651cgUQjRL7+hj5PfqKqz48fPwuFY20XRlFGagFr1YFD9si8wivNoZirAQpi
 yjDzZrDEPX5rmBXCFZSGvESnyPbVMTM4cudMI88wqqd47mTfxx+HB4ahqY90mZhofx149FF+0it
 auBqP8eVwQM/ieFSpepXU908hYG3
X-Google-Smtp-Source: AGHT+IGuA0+Vx05WaDdlg8iUwd7tlQEXmjFiIpc0Ko98cHeP780ERwrMmvi4Q5zqIjyldSNolOOT2g==
X-Received: by 2002:a17:907:7710:b0:aa6:7cae:dba7 with SMTP id
 a640c23a62f3a-aa6b1141793mr218471266b.4.1733919648979; 
 Wed, 11 Dec 2024 04:20:48 -0800 (PST)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa6a23ad9c1sm256530266b.48.2024.12.11.04.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 04:20:48 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com, trini@konsulko.com,
 francesco.dolcini@toradex.com, stefan.eichenberger@toradex.com,
 peng.fan@nxp.com, emanuele.ghidoli@toradex.com, joao.goncalves@toradex.com,
 vitor.soares@toradex.com, igor.opaniuk@foundries.io
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/5] toradex: tdx-cfg-block: add new apalis imx8 pids
Date: Wed, 11 Dec 2024 13:18:53 +0100
Message-ID: <20241211122036.103383-4-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211122036.103383-1-eichest@gmail.com>
References: <20241211122036.103383-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Dec 2024 13:50:55 +0100
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add new PIDs for the Apalis iMX8 modules featuring the industrial
variant of the SoC, which supports a maximum CPU frequency of 1300 MHz.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 board/toradex/apalis-imx8/apalis-imx8.c | 5 +++++
 board/toradex/common/tdx-cfg-block.c    | 5 +++++
 board/toradex/common/tdx-cfg-block.h    | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/board/toradex/apalis-imx8/apalis-imx8.c b/board/toradex/apalis-imx8/apalis-imx8.c
index 570bf2a27d4..1dc9483f022 100644
--- a/board/toradex/apalis-imx8/apalis-imx8.c
+++ b/board/toradex/apalis-imx8/apalis-imx8.c
@@ -251,12 +251,17 @@ static void select_dt_from_module_version(void)
 	case APALIS_IMX8QM_IT:
 	case APALIS_IMX8QM_WIFI_BT_IT:
 	case APALIS_IMX8QM_8GB_WIFI_BT_IT:
+	case APALIS_IMX8QM_IT_1300MHZ:
+	case APALIS_IMX8QM_WIFI_BT_IT_1300MHZ:
+	case APALIS_IMX8QM_8GB_WIFI_BT_IT_1300MHZ:
 		if (get_pcb_revision() == PCB_VERSION_1_0)
 			env_set("variant", "");
 		break;
 	/* Select Apalis iMX8QP device trees */
 	case APALIS_IMX8QP_WIFI_BT:
 	case APALIS_IMX8QP:
+	case APALIS_IMX8QP_WIFI_BT_1300MHZ:
+	case APALIS_IMX8QP_1300MHZ:
 		env_set("soc", "imx8qp");
 		break;
 	default:
diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 6508fe8108a..3855e15b83b 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -159,6 +159,11 @@ const struct toradex_som toradex_modules[] = {
 	{ AQUILA_AM69O_32G_WIFI_BT_IT,           "Aquila AM69 Octa 32GB WB IT",          TARGET_IS_ENABLED(AQUILA_AM69_A72) },
 	{ VERDIN_IMX95H_16G_WIFI_BT_IT,          "Verdin iMX95 Hexa 16GB WB IT",         TARGET_IS_ENABLED(VERDIN_IMX95)    },
 	{ VERDIN_IMX8MMQ_4G_WIFI_BT_ET,          "Verdin iMX8M Mini Quad 4GB WB ET",     TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
+	{ APALIS_IMX8QM_WIFI_BT_IT_1300MHZ,      "Apalis iMX8QM 4GB WB IT",              TARGET_IS_ENABLED(APALIS_IMX8)     },
+	{ APALIS_IMX8QM_IT_1300MHZ,              "Apalis iMX8QM 4GB IT",                 TARGET_IS_ENABLED(APALIS_IMX8)     },
+	{ APALIS_IMX8QP_WIFI_BT_1300MHZ,         "Apalis iMX8QP 2GB WB",                 TARGET_IS_ENABLED(APALIS_IMX8)     },
+	{ APALIS_IMX8QP_1300MHZ,                 "Apalis iMX8QP 2GB",                    TARGET_IS_ENABLED(APALIS_IMX8)     },
+	{ APALIS_IMX8QM_8GB_WIFI_BT_IT_1300MHZ,  "Apalis iMX8QM 8GB WB IT",              TARGET_IS_ENABLED(APALIS_IMX8)     },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index 937e84c3199..eaa52ed24f7 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -117,6 +117,11 @@ enum {
 	AQUILA_AM69O_32G_WIFI_BT_IT,
 	VERDIN_IMX95H_16G_WIFI_BT_IT,
 	VERDIN_IMX8MMQ_4G_WIFI_BT_ET, /* 90 */
+	APALIS_IMX8QM_WIFI_BT_IT_1300MHZ,
+	APALIS_IMX8QM_IT_1300MHZ,
+	APALIS_IMX8QP_WIFI_BT_1300MHZ,
+	APALIS_IMX8QP_1300MHZ,
+	APALIS_IMX8QM_8GB_WIFI_BT_IT_1300MHZ, /* 95 */
 };
 
 enum {
-- 
2.45.2

