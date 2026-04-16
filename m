Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278B8F8A148
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 08:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30A67841F2;
	Thu, 16 Apr 2026 10:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MS0X0cEs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C81684214; Thu, 16 Apr 2026 10:47:26 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D254841D5
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 10:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso2079825f8f.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776329243; x=1776934043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BbZeYI3IIp4ZaLDzYHqOXJahwEOJ4/rJdMzIteM20sk=;
 b=MS0X0cEsP0TM7KpgaoTn93eHlwujsnc4VeKvm5psotsCGbu7gS/VDfOr5pptypU9xv
 1CEPjY5nX53Pru1xSIL5BPJd9GDAOvBPH9zchVNS9hAOLkNvIzmxMJmwY/fiWIwbBV6/
 QGG8vzGBX5ubrMunH3PYkV7mKUlMN3hTVBKknXeHc7TwAjPoR0btNE1sfHStLDXec+9G
 PdeBn7ATxq73R3eCixlF3leOrYZYtyqloZuDX440aBmvSLsLe7wUDs9W6/x6o4bSRxUJ
 n+Ubego5rAWDrR3rsLVODl5ST0yyz5TIReuo24i3MFaml3Lh9XRcyr01t9gk70zbvYfc
 6WUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776329243; x=1776934043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BbZeYI3IIp4ZaLDzYHqOXJahwEOJ4/rJdMzIteM20sk=;
 b=axzIQAc91LN4FISQBeR+dGkug3G8Ni4nuDz5hRg0xGUsBkxY/oi5HXBf8RS0TiA8Wx
 HHh1S6dZyobLrrPfupMqARliLt3dtna9qRcOUnSQwDb8I9kB4TzzTcq6k/Oq1fgZcW3n
 uqWnv3AeumN5yxyQw583ZsPBRk5bVBozhmBYynFWS6Y7CNsdH/ghbaL/43kxhrtuuk3M
 fecMFYdvRtaWddgQ4XZiJhIX5LZzW9UlPToqqqEUKiFHtvs5vIt4TUcqkBHOLTGYd9Ex
 b07yNaegd2av2MJy1wEA0FUwctUFScSD72Kh5gxhMvVtxjCuqMBahXc39uZDvHw3NEyq
 fR/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Ic6m+EMD7LKK/6ZIQ0l54NAkHAwLGy0ShpYwN/49conUiMrTJR/q+3afT9T0gF+1XiAHdHYE=@lists.denx.de
X-Gm-Message-State: AOJu0YyAb08Fm2OyS595KMvh6tvkbfORhlh+V25VYpTLYJvTTU3pdnoV
 PxVCD7g3Zwnbot/BfNyJwgZ5+0ku21PVeJzWXf2FhrFHeK5nzqf/XiaH
X-Gm-Gg: AeBDiesh8LwIeK1DUbVwJrZBvJW67oRWd5pJF9Y7SUiP3DxXuRSPNd9qV6Lb9sfWQbt
 zubn4FIbwN2lr5nOURc3Yibfb7HugTQGe+vvMi/4J8bVmKKdah8h0sNo/WnA8vzCq7Ib89oyUhj
 pV2tIPFRbQNwLQ+5j2IhMhJ0d8cHPr7a3dEkOTbjCdSgY5qyab2sZzf3P42TUD8/bL4+YY93Ghe
 bDY7m6QP9UfPNnTAxVg1kaG+92yeBdKe1INjU665Nn+llnHYrWEUQB+/KqA/VGCvrS3MvYmNoNp
 AelSxYm20CqSYPoti+ftso2uxl3ul/HxQVfnr6gjTQrM3Tq0ce7q1tzVjjQGoWeiVXWaPcz4Cqg
 0YegwDD2mN9HtNwssuQGP0BXmZajYWqkzWyw1IvigHg+zYeaQWNwyUA5YnZ0FoPk92NjaNBoA6a
 zwYU4LlFAPuVeNaqYYM4Kkt84/P3FQnObuLaMbtEc9GuYvRMV7pMQFx43fz/RV6S8AHgopO8H8g
 haraLhjB9tIgkeI1rA0IcMGoCQcmKxL3obBH9SzaHoE9NZ+
X-Received: by 2002:a5d:5f46:0:b0:43c:f8b4:e58 with SMTP id
 ffacd0b85a97d-43d642c088fmr36767656f8f.41.1776329243215; 
 Thu, 16 Apr 2026 01:47:23 -0700 (PDT)
Received: from emanueleg-nb.homenet.telecomitalia.it
 (host-87-2-163-213.retail.telecomitalia.it. [87.2.163.213])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3564d8sm13391674f8f.10.2026.04.16.01.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 01:47:22 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Alice Guo" <alice.guo@nxp.com>,
 "Sumit Garg" <sumit.garg@oss.qualcomm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH v1 3/3] toradex: tdx-cfg-block: add verdin imx95 0226,
 0227 and 0228 pid4
Date: Thu, 16 Apr 2026 10:45:25 +0200
Message-ID: <20260416084535.1490476-4-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416084535.1490476-1-ghidoliemanuele@gmail.com>
References: <20260416084535.1490476-1-ghidoliemanuele@gmail.com>
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
index 8f7ada7a8215..00e11943a807 100644
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

