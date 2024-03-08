Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039B8C54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 14:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 251CE87E80;
	Fri,  8 Mar 2024 15:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IxkTsK9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E161A87F22; Fri,  8 Mar 2024 15:18:30 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20FF287E80
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 15:18:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e64cdf08e3so689874b3a.3
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 06:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709907505; x=1710512305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WhDNTgiClpTg+ERxeMjx468uJSHjHh3cHGjyeKOP8HA=;
 b=IxkTsK9rcE+zy14aCmUYHbPZ/WVAUPVEK/mSM/5u4lpQLWjI2OLxbDZZC0TQ6nc8gO
 y+8dF6nTncEvr5hHse+qdArvidBgPhkyM3gAeCgE9evOoi7ulVy+pSB6CHG2KQCHPSDY
 IZRV/IffLdrSnVsDqEIWV4ff57hgLtP8Z2aVDDOf2OI5OJnY76E/JyXic3PMwxY0GZlW
 u+ihnYML7dsuOqHzChGGpBFjQjoR8ul/MwT3DqEFeGkgKCFL85PXj0O1WArr7QkLE0zQ
 72og/GVUThM4g1K4Pub5tjhzTksJuyipNUxAVColX/l16fesLnRdsEdk73cAjVl4BhdR
 XynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709907505; x=1710512305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WhDNTgiClpTg+ERxeMjx468uJSHjHh3cHGjyeKOP8HA=;
 b=SOly0H2p7APVFUjT2pEuaPy8UcSqXq4QIs+hzvMtmesZeeafnIYefJmoLJoPm40VH7
 0f7d2SupxNakLvAjJ8xFr8mH/0USdH/rWFhGzJXVq717bqU2QsK7RqvoozXDHViAnjM8
 hZYzhDQJGOZ7MYVlC+Jm0wpmEogMXIShJ88Q8C8wDavPKpBLX/xVPK71TI+yUCtWTeqD
 8eFo3cJPNdnPsEaIpg4urBWLRjjn3hNpEcdUpJSC7glJ3j2wkSmk/S2G17M3LQIQRS/V
 H3Bi6GCv7sFiDCiT7LRuDpbjQYZh/8MCkOvCU/qHXkbL0XC+XsmFXRJToMybKEZzNA3A
 2zmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVybmaTuAq8EnDc7nFL2DNshHS6uYaMA9Wl81MuG02GcrMwxrqr+ZDt/tvTfWsSSeIeU1P8ugE1crfK2AZzNjZp1l0EGA==
X-Gm-Message-State: AOJu0Yx4qdUZs+DI4JSlj/ssqyxqDc/nig0JqAJZQxW/YnVlVWhnlnTM
 N0b9bzA7Ek+mq1vxF7NCEevv8bIZ5v/Ga2OKzFRfIu0yXM5qW5S1V5Uu9nO6NK0=
X-Google-Smtp-Source: AGHT+IGYBL5Z/xVsSMSKAJN4LYY5ITu6o5QN++LFAMDxzwgB0QFG3Hq3ZWxCVA9641S0rXYzIKVVoQ==
X-Received: by 2002:a05:6a20:9589:b0:1a1:672a:38a9 with SMTP id
 iu9-20020a056a20958900b001a1672a38a9mr8511884pzb.48.1709907504740; 
 Fri, 08 Mar 2024 06:18:24 -0800 (PST)
Received: from joaog-nb.. (201-27-117-221.dsl.telesp.net.br. [201.27.117.221])
 by smtp.gmail.com with ESMTPSA id
 r27-20020aa7845b000000b006e04d2be954sm14158329pfn.187.2024.03.08.06.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 06:18:24 -0800 (PST)
From: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH] toradex: tdx-cfg-block: add 0087 i.mx8m mini product variant
Date: Fri,  8 Mar 2024 11:18:01 -0300
Message-Id: <20240308141801.49081-1-jpaulo.silvagoncalves@gmail.com>
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

Add new product id 0087 Verdin iMX8M Mini Quad 2GB IT.

Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 1 +
 board/toradex/common/tdx-cfg-block.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 4a7de5483d2..dcf00d2b632 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -157,6 +157,7 @@ const struct toradex_som toradex_modules[] = {
 	[84] = { "Apalis iMX6D 1GB IT",                  TARGET_IS_ENABLED(APALIS_IMX6)     },
 	[85] = { "Apalis iMX6Q 2GB IT",                  TARGET_IS_ENABLED(APALIS_IMX6)     },
 	[86] = { "Verdin iMX8M Mini DualLite 2GB IT",    TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
+	[87] = { "Verdin iMX8M Mini Quad 2GB IT",        TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index 021cc21b5e2..183ee0f2dc9 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -112,6 +112,7 @@ enum {
 	APALIS_IMX6D_IT_NOWINCE,
 	APALIS_IMX6Q_IT_NOWINCE, /* 85 */
 	VERDIN_IMX8MMDL_2G_IT,
+	VERDIN_IMX8MMQ_2G_IT_NO_CAN,
 };
 
 enum {
-- 
2.34.1

