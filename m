Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19AFC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DB1988C9B;
	Wed,  1 May 2024 04:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cvR7RrlT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58A5988C87; Wed,  1 May 2024 04:45:43 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B22C788C95
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6a04bae513cso27822736d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531539; x=1715136339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JsJhtgGMbVFv6gVUjBpeu63bSSOq+weA5oo54z7yywU=;
 b=cvR7RrlTiPLGmf0To8vksQYIV+XtmD3y5o1uQEGY326jGrwPB6tCXBaDnp9PkBkykj
 gRUsUz/+vomr5++2rXbsig5hLz5lgi+VESGzZpAuuRexRVUwmbb2YMs0SvF6iEw0rwVx
 vFOg5KW4BzBhSGOZHhYq1Am+6vJoJ+IBlseHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531539; x=1715136339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JsJhtgGMbVFv6gVUjBpeu63bSSOq+weA5oo54z7yywU=;
 b=ctue2zNCtX5dUyf0kKzRKpign4DvneT/IEAIlK157Z8dfESutNlv0XAxhn81BFVtU6
 ZD+FSoFpV3pTruutcHQ50iQrPv9Mila+/gjKdC6kYba9cMSOgHusUQqFfGJNgIjmpZC8
 maaCm26cGL/hp3e5qqi9+092j6iZoZaBv50p/tyt2arxxUZh17QQ2B9MV+kwDLWkv66b
 BRjtwqLuj3HQeV4l02MZBWQ6IcC04hummCRXRwFNbNzZEi5y8GRaczU+ac9ybzgKGlGD
 Dd+3J/WU8PkDNux34NoUtG7HfHRbfJcK51qeUVY3ifLQ4QgsLEMd4R5wIT52SH5/pIu8
 9l3A==
X-Gm-Message-State: AOJu0YylOpeLiNCnZh22nZruc5rfOWcu9jeqyJ+PgFRR2clRPZZRjfQd
 m9XWKkLwVwxbzFNw5eoXxPgSrSpzPdvb3B42Vrhr/JzgR58h0WJD/VD+bao2AKPjON95Szr+Gnr
 jduUY0J+T
X-Google-Smtp-Source: AGHT+IH3sK1gcQp2lzEi0Xq5BrjsM2Xdz0o7oNnNbuD1X1HthKAuA4frSkbysBs7vN1vs3U2fAkH3Q==
X-Received: by 2002:ad4:5dcf:0:b0:6a0:b705:2800 with SMTP id
 m15-20020ad45dcf000000b006a0b7052800mr1207371qvh.23.1714531539475; 
 Tue, 30 Apr 2024 19:45:39 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Fabio Estevam <festevam@gmail.com>, Josua Mayer <josua@solid-run.com>
Subject: [PATCH 123/149] board: solidrun: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:50 -0600
Message-Id: <20240501024316.1767971-123-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Roese <sr@denx.de>
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Josua Mayer <josua@solid-run.com>
---
 board/solidrun/clearfog/clearfog.c   | 2 +-
 board/solidrun/common/tlv_data.c     | 2 +-
 board/solidrun/mx6cuboxi/mx6cuboxi.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/solidrun/clearfog/clearfog.c b/board/solidrun/clearfog/clearfog.c
index 6977db0a9e28..2dbd071abd9f 100644
--- a/board/solidrun/clearfog/clearfog.c
+++ b/board/solidrun/clearfog/clearfog.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2015 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <i2c.h>
 #include <init.h>
diff --git a/board/solidrun/common/tlv_data.c b/board/solidrun/common/tlv_data.c
index cf5824886c37..b8086605c3ae 100644
--- a/board/solidrun/common/tlv_data.c
+++ b/board/solidrun/common/tlv_data.c
@@ -3,9 +3,9 @@
  * Copyright 2020 SolidRun
  */
 
-#include <common.h>
 #include <compiler.h>
 #include <tlv_eeprom.h>
+#include <linux/kernel.h>
 #include "tlv_data.h"
 
 #define SR_TLV_CODE_RAM_SIZE	0x81
diff --git a/board/solidrun/mx6cuboxi/mx6cuboxi.c b/board/solidrun/mx6cuboxi/mx6cuboxi.c
index 7f4811d88794..3406ba8616e0 100644
--- a/board/solidrun/mx6cuboxi/mx6cuboxi.c
+++ b/board/solidrun/mx6cuboxi/mx6cuboxi.c
@@ -15,7 +15,7 @@
  * Ported to SolidRun microSOM by Rabeeh Khoury <rabeeh@solid-run.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <image.h>
 #include <init.h>
 #include <log.h>
-- 
2.34.1

