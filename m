Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D647BF8E4B4
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 07:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E95418421D;
	Fri, 17 Apr 2026 09:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DcJLYE0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7A488425F; Fri, 17 Apr 2026 09:15:54 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C803183FC0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 09:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so4163625e9.0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 00:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776410152; x=1777014952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2zfzSmvVDMa8QMhrfIi1HNCGmkeN5DNIsqWyGAZJ68=;
 b=DcJLYE0aKTrgJW+57R9LG1+H0AKRhFAr6lF0z9/CjFtJnJWcQxGpuFDHKARZK/MFuJ
 MWi1Mn9Mj8S7fx+t4/NvMWcozaZ2oJ7UV+gsJ500LqLpQpWGBuBf/FIxydxITjxQZsWL
 A2awGW5zq8jUKA/7KouFugPpzKCT5EG1be862JSTl5sgVMAOUGZEG2O9qOKJ7ntnlmZ2
 /nNYdmF+88mTJgTmqpfIWXPcDevekyvtg6vUBnWGkadq57QER6oTMC1DQe5ebiJGqcy4
 VMYyGcKHbeddh+RPaUkVLBOAg6M6D653qS+z8VdL8OvEhQqOFLWJc9KQGm+hEOq6fMGN
 wHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776410152; x=1777014952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e2zfzSmvVDMa8QMhrfIi1HNCGmkeN5DNIsqWyGAZJ68=;
 b=iP1uSUMv6P/4le4WCJqMk2NfN8ahmN3Ph1zIvbSfmXLB+LwQfewSu7Wg5UOyn3eE2Q
 idmyHhO8EDrtcG5H4GM3sTK5LbdlEBZ42UZrXCdxiW9VJuosxQvQdfVdwJA/F9m5QEOz
 1w3iYBYyPRHP9NZKVhqnl891CpURKx3cMWPIt4As3+NsUjsrlNKUYr6QcOXRFkzPKh+S
 hTRw03FlLpIQchMtb0SeTlr5MQFXzCMGmebG0K9fVvdVew3Ssx5VUkpZRNNiQuevTJQm
 hUeUBYJUUCy+8NturaxbXbH7jgjSO69PIKv8VVBLoGqdClRC+u+80i4tcRRRNRc3Z2UN
 bZvA==
X-Forwarded-Encrypted: i=1;
 AFNElJ90JP11hFU9w2S7BBMzYr3551FGhFjv9E2dwqhPtCsI3SK8SsZEhRI8QoYQY9rZtljJ7P8wBRE=@lists.denx.de
X-Gm-Message-State: AOJu0YwwMPydS2UKXLxoq4cf+47OLxtuBcvi35Ss3q89RKJIDepzMeer
 EPuQNOjZsk2PO3OE5d/YzTMMl9+HOuT8O9BmsQqX1pfw9dBa9/Wp3Xyh
X-Gm-Gg: AeBDietg2Egi9PQfrIJeR0vwYRF9AXZv0UJXKfx/BiFO/BpxNFPLpL3ww6FG4qlpTbI
 vCVMnLEKiJGHYqhxXncGpiqer4TzxBCmCXi5KfA9B8SL6cjD5y7rTFkbAhMDqWmEdDntX1zSkE3
 jrqpRn8QyrUzpAjXLJPmJPouNfsrDphx8QFjyjweTbVJuvBrc+wQrfinDC+GsFUcbtfdaOqjkSh
 OvOxEEgRXA0DfzYi2Z1VWG/NkzfQXygt5hoNO7Nw4uQ2FaZxmtHdwhWaLhAkG5e06gHm+Vw8rab
 Prf+WwQa8olxKXBy0NnuGSofgNoioVGRC63zODgxJSBKlnDSCSURmGaqqU2ob7f15e9LD8OWa6B
 xm7UJ29mSxPhYjPHm3e/OqNF41K7bJKdeP6Te/FmtJKhrkpyFSzSnp1pEuusa+V4KOQ2Lz/Y7ma
 leCKCzkjcyZUH6wEMOcA+08yEQy/UyEVTPyKHUc9dyiNWihu14XMO9uMS4l9+9qHSsLFjE2FZix
 gQDcJEtEAUfKWouvzf1nC8oBIqF4sAGWhE9lTmovRe0+pnxicq7ikVwD38=
X-Received: by 2002:a05:600c:530e:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-488fb768db3mr22392535e9.19.1776410152153; 
 Fri, 17 Apr 2026 00:15:52 -0700 (PDT)
Received: from emanueleg-nb.homenet.telecomitalia.it
 (host-87-2-163-213.retail.telecomitalia.it. [87.2.163.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb6dfa33sm15573955e9.0.2026.04.17.00.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 00:15:51 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Alice Guo" <alice.guo@nxp.com>,
 "Sumit Garg" <sumit.garg@oss.qualcomm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 3/3] toradex: tdx-cfg-block: add verdin imx95 0226,
 0227 and 0228 pid4
Date: Fri, 17 Apr 2026 09:13:33 +0200
Message-ID: <20260417071546.1610330-4-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417071546.1610330-1-ghidoliemanuele@gmail.com>
References: <20260417071546.1610330-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Add these new PID4 to config block handling:
 - 0226 Verdin iMX95 Hexa 4GB WB IT
 - 0227 Verdin iMX95 Hexa 4GB ET
 - 0228 Verdin iMX95 Hexa 16GB IT

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c      | 3 +++
 board/toradex/common/tdx-cfg-block.h      | 3 +++
 board/toradex/verdin-imx95/verdin-imx95.c | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index c8c10742103b..896a0d3bd126 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -187,6 +187,9 @@ const struct toradex_som toradex_modules[] = {
 	{ OSM_IMX91S_2GB_IT,                     "OSM iMX91 Solo 2GB IT",                TARGET_IS_ENABLED(TORADEX_OSM_IMX91)    },
 	{ VERDIN_AM62D_1G_ET_GPU_NODSI,          "Verdin AM62 Dual 1GB ET",              TARGET_IS_ENABLED(VERDIN_AM62_A53)      },
 	{ AQUILA_TDA4O_16GB_IT,                  "Aquila TDA4 Octa 16GB IT",             TARGET_IS_ENABLED(AQUILA_AM69_A72)      },
+	{ VERDIN_IMX95H_4G_WB_IT,                "Verdin iMX95 Hexa 4GB WB IT",          TARGET_IS_ENABLED(VERDIN_IMX95)         },
+	{ VERDIN_IMX95H_4G_ET,                   "Verdin iMX95 Hexa 4GB ET",             TARGET_IS_ENABLED(VERDIN_IMX95)         },
+	{ VERDIN_IMX95H_16G_IT,                  "Verdin iMX95 Hexa 16GB IT",            TARGET_IS_ENABLED(VERDIN_IMX95)         },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index 3022ef615ad8..9a96bddfbe17 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -150,6 +150,9 @@ enum {
 	OSM_IMX91S_2GB_IT, /* 220 */
 	VERDIN_AM62D_1G_ET_GPU_NODSI,
 	AQUILA_TDA4O_16GB_IT = 223,
+	VERDIN_IMX95H_4G_WB_IT = 226,
+	VERDIN_IMX95H_4G_ET,
+	VERDIN_IMX95H_16G_IT,
 };
 
 enum {
diff --git a/board/toradex/verdin-imx95/verdin-imx95.c b/board/toradex/verdin-imx95/verdin-imx95.c
index 36e41ec3ad4a..60c1dbb5e294 100644
--- a/board/toradex/verdin-imx95/verdin-imx95.c
+++ b/board/toradex/verdin-imx95/verdin-imx95.c
@@ -27,7 +27,8 @@ static void select_dt_from_module_version(void)
 		 * module with Wi-Fi/Bluetooth make sure we use the -wifi
 		 * device tree.
 		 */
-		is_wifi = (tdx_hw_tag.prodid == VERDIN_IMX95H_8G_WIFI_BT_IT);
+		is_wifi = (tdx_hw_tag.prodid == VERDIN_IMX95H_8G_WIFI_BT_IT) ||
+			  (tdx_hw_tag.prodid == VERDIN_IMX95H_4G_WB_IT);
 	}
 
 	if (is_wifi)
-- 
2.43.0

