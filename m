Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E528C47DD3
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 20:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66476879B2;
	Mon, 22 Jan 2024 21:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MGA83nAJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0781879BD; Mon, 22 Jan 2024 21:10:00 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 862CD8792D
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 21:09:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-290c8c9d84eso229377a91.2
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705954197; x=1706558997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ALAlnZ3OyaNdVlwU+SPjhwYF4NkxlC86hFtmAw6SnS8=;
 b=MGA83nAJVjGcm4DaZcmz2jbomHYtOg6JtTwn2VJY3XGhp7/rR05oohS4LmPtJDmObW
 mZd9XLC4ctAg3hVGd20YmMiVfgKpSYlwwmpkV/pGw8gzI3cU3dmoEUGgMhmY4jJr2Akp
 1dAnzVf41fB+gGiI1SK6hQdwFNkZ8zFKz6awUPF2u+uMhHKNdKiRuKCqDahXsSH4O1p7
 l9GtnW5rKix1erjwbQqb8OY+G+OhXFz+YXGgRVYkfiWpUAX30USGOl5VoCORoaQsLTcy
 Va88u7xBGjIxHawGEZRiKz6MjNROUUAs62vbTNPVWhMPF0ZIGO+2YabMdPxStE08SxMt
 3PXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705954197; x=1706558997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ALAlnZ3OyaNdVlwU+SPjhwYF4NkxlC86hFtmAw6SnS8=;
 b=kUBGs3Xa2ggJ1KdeLZ5FzCypkLWqqmm9VN/oRT0HhyV5+5Rt9flyi9ZvEypgPNmeGE
 qeCDnqHEBWR+ydndZfap7JPxlIxWvzic5b6Dv9qjY3ayo7cykR9+n/GhoTby/cm8/C3h
 +TxOtH16NuEeSc602FzFZgXubIMlL3bAG3RCeJMQS+oNsVHxD7bqnDhfVnFJo29tYA9o
 jEFcx1sTH+3Zk3l6rNQy2Lko1lFl7zZOXG9V9zbdifdJs0Nyg9JtrsSqRIblPqRGUBsa
 X+RBIiXFsg2VVH1BpMCcNIahF233UXXrDHpxwGp+9J3wLik4FQarCXOIRCTrRh3I8gZA
 CaMQ==
X-Gm-Message-State: AOJu0YwYfG3/NCbTUd9LkP8gRuYfI0lQZNMtDkRQVWNSY/Lv2FLvc6vC
 vaFlIDZHrtqs//iHx6M1h/27ISyqwjq0K3TxbDXBggxjsUFaRJmI
X-Google-Smtp-Source: AGHT+IF2tVtGeRzilkRZG8mjYTrbh52RYZYEmc4bQmV/Z/h9TJfOmpbkBVQJx9gglXL7T3K6V3K0Zw==
X-Received: by 2002:a17:90a:c286:b0:290:727:edf3 with SMTP id
 f6-20020a17090ac28600b002900727edf3mr1816357pjt.28.1705954196663; 
 Mon, 22 Jan 2024 12:09:56 -0800 (PST)
Received: from joaog-nb.. (201-13-139-147.dial-up.telesp.net.br.
 [201.13.139.147]) by smtp.gmail.com with ESMTPSA id
 r5-20020a17090ad40500b0029004b9df9fsm10150361pju.36.2024.01.22.12.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 12:09:56 -0800 (PST)
From: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH] toradex: tdx-cfg-block: Add new apalis and colibri pid
Date: Mon, 22 Jan 2024 17:09:30 -0300
Message-Id: <20240122200930.673447-1-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

Add new apalis imx6 and colibri imx6/imx7 products IDs.

Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 9 +++++++++
 board/toradex/common/tdx-cfg-block.h | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 7187e1ba377..7affc290395 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -147,6 +147,15 @@ const struct toradex_som toradex_modules[] = {
 	[74] = { "Verdin AM62 Dual 1GB IT",              TARGET_IS_ENABLED(VERDIN_AM62_A53) },
 	[75] = { "Verdin AM62 Dual 1GB WB IT",           TARGET_IS_ENABLED(VERDIN_AM62_A53) },
 	[76] = { "Verdin AM62 Quad 2GB WB IT",           TARGET_IS_ENABLED(VERDIN_AM62_A53) },
+	[77] = { "Colibri iMX6S 256MB",                  TARGET_IS_ENABLED(COLIBRI_IMX6)    },
+	[78] = { "Colibri iMX6S 256MB IT",               TARGET_IS_ENABLED(COLIBRI_IMX6)    },
+	[79] = { "Colibri iMX6DL 512MB",                 TARGET_IS_ENABLED(COLIBRI_IMX6)    },	
+	[80] = { "Colibri iMX6DL 512MB IT",              TARGET_IS_ENABLED(COLIBRI_IMX6)    },
+	[81] = { "Colibri iMX7D 512MB",                  TARGET_IS_ENABLED(COLIBRI_IMX7)    },
+	[82] = { "Apalis iMX6D 512MB",                   TARGET_IS_ENABLED(APALIS_IMX6)     },
+	[83] = { "Apalis iMX6Q 1GB",                     TARGET_IS_ENABLED(APALIS_IMX6)     },
+	[84] = { "Apalis iMX6D 1GB IT",                  TARGET_IS_ENABLED(APALIS_IMX6)     },
+	[85] = { "Apalis iMX6Q 2GB IT",                  TARGET_IS_ENABLED(APALIS_IMX6)     },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index ea58bd43b17..b783537ce76 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -102,6 +102,15 @@ enum {
 	VERDIN_AM62D_1G_IT,
 	VERDIN_AM62D_1G_WIFI_BT_IT, /* 75 */
 	VERDIN_AM62Q_2G_WIFI_BT_IT,
+	COLIBRI_IMX6S_NOWINCE,
+	COLIBRI_IMX6S_IT_NOWINCE,
+	COLIBRI_IMX6DL_NOWINCE,
+	COLIBRI_IMX6DL_IT_NOWINCE, /* 80 */
+	COLIBRI_IMX7D_NOWINCE,
+	APALIS_IMX6D_NOWINCE,
+	APALIS_IMX6Q_NOWINCE,
+	APALIS_IMX6D_IT_NOWINCE,
+	APALIS_IMX6Q_IT_NOWINCE, /* 85 */
 };
 
 enum {
-- 
2.34.1
