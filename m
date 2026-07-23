Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F93C531D1
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1E3260A6D;
	Thu, 23 Jul 2026 15:14:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HhE0FQwy1m5O; Thu, 23 Jul 2026 15:14:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E6C4460A7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819647;
	bh=fZmRR1EGf+ZBG9CMmHwJMbSSP3mnLCK4ZPBzbz8iC+o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B0bfrGylP2DzSSxTwQJmqOFGVp3SF8gQLQAfm6UAJhnaHERkC3TxsPtMJrQabH3Cf
	 C1lVTBPuUFloZ7POjTSXHr5v9gNGAI9Z/d443n7pelYp9h28suhUwgLD8leQxvvdz4
	 NcqniRO9W3vMvS8D/FmUZLqFv8yML6Fe72I9g23QI6Cl4XrWRv6i4sTuT67WyMrE4m
	 ONEdw6Qn53Z1gjrNCr2+3JM4dIZFxZu5nd3hoJb4nFq/VPAo1jEZa0FoPnyt2dlzvM
	 iPhWRQ2queRtA+sOvbQKEjUckMDn67U0S6o3/hfRscgxsQ1SnmM7D+T8OpmXPCWnGH
	 xBkbiw7rsbHlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6C4460A7D;
	Thu, 23 Jul 2026 15:14:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F5BC42A
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 41AA281006
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pMkQXulj1fun for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 13:30:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=tan.siewert@9elements.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1897980FF5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1897980FF5
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1897980FF5
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:38 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4954d383e64so4369975e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784813437; x=1785418237;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fZmRR1EGf+ZBG9CMmHwJMbSSP3mnLCK4ZPBzbz8iC+o=;
 b=GY6u3EUUTNr09VleMsDIUDWrVWkUTy7UBFkKRIIn9RSJ1wHydSxiswxWXFQFBxmBb0
 jqJRgq+goF+nX3HbcdJHah1hVVlNZfUVkUmcmws3VLfZuj6N+251QA/NcHcZ/nhI1zto
 SIIY03P1Ok9kF69n4Ub58klo0QNnPemwYgCOa3AnSCM3dDP+54TAji54ERhsGCq1LWn1
 xD2QSHsHfBM3QJ3K5l23TKK0jnnGrjrLvcGmAdomIct8e68qb8YEAz36qUn3bo6ypnWo
 4A9Rl94lYMa/nZmhHonU6sp9E4BcMPAeS1zxZeVI/+0PlWme12rKZhh8yXBqoSj+HL9e
 WyIg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5+Yc91UrOj1vuLIcbdECf/d7QoKIVNVjHW6KsgJJRH75bACbGSeLTcdnjJ179xLzkiOSZ+7E=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YypBrlk/Edt2uVKMGEhqlNWVDrLRYiO0mV6uJC9sYhEnuSyP4SW
 dIan4iPqpnDzdj38RBYAyxQuo6MpSiqxAvCALIizp09CE7CVaHwkbjw426icWIO6Fzc=
X-Gm-Gg: AR+sD11+Nw1AX47dvxG+xgq9wsrqy3zXFOdsQXPlg7oFDX31mWOfBaeWE3dZd74uv6r
 npjV5VamVPyxXYvWOS1Dlh4O11U7wC6PLJ6Tr8Z2z/Nv92VJrvKgXPh8dye5nGRRO6nhbhMFDcv
 aBc8kTLWoXJ+RBn4llVMd25pHsu8xOYNIn12uZoavBCLmZMPAZBuQmqtR5ljAR3CgTTQXQTPjqp
 EtgXfOlw6HE4yW8QIySkmP+cDKJooTdIIDUiG5cqMYnIaFMmM7Vx+yvQ2Gr9LGNwOH1MeEc/Xxq
 nzuc6Flp8GmcBsZnqjC7eKiLPbmcu81I4q26RyaPb9NvkDwX3q8z7YYTu5jcIfTpTb5uCb5rbqM
 ZKwG0YZD7/k7tUdcv5X7m+yUuQwoo7Ih+OZ7yxysN5XVjIrjj6/pw2tmIbes6HEO+IWwWQLbXkK
 RRwt8h1qHPZvQsvDbxCrgC75KXBYZAF8Sp4m4=
X-Received: by 2002:a05:600c:310e:b0:495:46dd:e238 with SMTP id
 5b1f17b1804b1-49573d142abmr37324695e9.30.1784813436667; 
 Thu, 23 Jul 2026 06:30:36 -0700 (PDT)
Received: from [10.12.249.172] ([2a01:599:841:3b94:b6c8:2fa:40db:8ecf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b043727sm97075405e9.4.2026.07.23.06.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 06:30:36 -0700 (PDT)
From: Tan Siewert <tan.siewert@9elements.com>
Date: Thu, 23 Jul 2026 15:30:06 +0200
Subject: [PATCH 5/8] board: hpe: gxp: dynamic dtb configuration based on
 server id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-9e-gxp-v1-5-f86e5cea239f@9elements.com>
References: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
In-Reply-To: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
To: u-boot@lists.denx.de, Jean-Marie Verdun <verdun@hpe.com>, 
 Nick Hawkins <nick.hawkins@hpe.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Tan Siewert <tan.siewert@9elements.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784813429; l=2965;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=DH4YGFxBwvZjifUOQyC+J8goRZsNoUGDvhVwrlzaB9k=;
 b=wRAUSstEHJ7bcsP3VQouToQAgbDq8SQvAXyIPZU/GriBsPRNpWB0G3cG9wZLZF3gtJtDblAV3
 KklmA81Qyc/DUYlRY/c+TO66tkHuCB4S3scGzxNPa4hRJtBbAKI8829
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=
X-Mailman-Approved-At: Thu, 23 Jul 2026 15:13:57 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1784813437; x=1785418237;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fZmRR1EGf+ZBG9CMmHwJMbSSP3mnLCK4ZPBzbz8iC+o=;
 b=RoT01UK5XVOtlSDzv2d/3NIkab9c/pooZ+xOXXNoyQPLzckEHV0Z+nZRu6Do1Lzeap
 LmBKGsRTEe0WKSNCOVAZfJ79hUFfhI8SCPHQX/bUTwPMQDgV2dMcw27sjDdHYN1Up+6K
 /EDfBCyR+y2Pi+a0dTXxlOKCggPP7j8aiC/eRxdjhPrd1xAwFXQ9UQTq3qe24AH6hsZE
 D120YlDRhESddpSHmnkLmSIOb9Vvnvpvx0bHh5GF2BDIB8/JaXYGOG+mHUdSwU/csCBW
 n50oNHvdLwoilCK0A1cz/KDgXstBK6mmgv2yYGdg8pM/BvGaMVCRKzLN7PHo2xzIhUoq
 4s6A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=9elements.com header.i=@9elements.com
 header.a=rsa-sha256 header.s=google header.b=RoT01UK5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Marcello Sylvester Bauer <marcello.bauer@9elements.com>

Add board_fit_config_name_match() for runtime FIT configuration
selection based on server ID register.
Add ft_board_setup() to populate device tree with board properties.

Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Signed-off-by: Tan Siewert <tan.siewert@9elements.com>
---
 board/hpe/gxp/gxp_board.c | 61 ++++++++++++++++++++++++++++++++++++++++++++---
 configs/gxp_defconfig     |  1 +
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/board/hpe/gxp/gxp_board.c b/board/hpe/gxp/gxp_board.c
index d94d9b8a19e..b37725761af 100644
--- a/board/hpe/gxp/gxp_board.c
+++ b/board/hpe/gxp/gxp_board.c
@@ -1,22 +1,78 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * GXP timer driver
+ * GXP board support
  *
  * (C) Copyright 2022 Hewlett Packard Enterprise Development LP.
  * Author: Nick Hawkins <nick.hawkins@hpe.com>
  * Author: Jean-Marie Verdun <verdun@hpe.com>
+ *
+ * Copyright (C) 2026 9elements GmbH
  */
 
+#include <linux/bitfield.h>
 #include <linux/sizes.h>
 #include <asm/io.h>
 #include <dm.h>
 #include <dm/uclass.h>
-#include <ram.h>
+#include <fdt_support.h>
+#include <init.h>
+#include <sysinfo.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
 #define ECHI_CMD 0xcefe0010
 
+#define GXP_XREG_BASE		0xd1000000
+#define GXP_XREG_SERVER_ID	GENMASK(23, 8)
+
+static u16 gxp_get_server_id(void)
+{
+	return FIELD_GET(GXP_XREG_SERVER_ID, readl(GXP_XREG_BASE));
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	char expected[16];
+	u16 server_id;
+
+	server_id = gxp_get_server_id();
+	snprintf(expected, sizeof(expected), "gxp-0x%04x", server_id);
+
+	if (strstr(name, expected))
+		return 0;
+
+	return -1;
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	struct udevice *dev;
+	char str[64];
+	int ret;
+
+	ret = sysinfo_get(&dev);
+	if (ret)
+		return 0;
+
+	ret = sysinfo_detect(dev);
+	if (ret)
+		return 0;
+
+	ret = sysinfo_get_str(dev, SYSID_BOARD_MANUFACTURER, sizeof(str), str);
+	if (!ret)
+		fdt_setprop_string(blob, 0, "manufacturer", str);
+
+	ret = sysinfo_get_str(dev, SYSID_SM_SYSTEM_SERIAL, sizeof(str), str);
+	if (!ret)
+		fdt_setprop_string(blob, 0, "serial-number", str);
+
+	ret = sysinfo_get_str(dev, SYSID_SM_BASEBOARD_PRODUCT, sizeof(str), str);
+	if (!ret)
+		fdt_setprop_string(blob, 0, "part-number", str);
+
+	return 0;
+}
+
 int board_init(void)
 {
 	writel(0x00080002, ECHI_CMD);
@@ -72,4 +128,3 @@ int dram_init(void)
 
 	return 0;
 }
-
diff --git a/configs/gxp_defconfig b/configs/gxp_defconfig
index 5501f9aefae..fd59fc8e50e 100644
--- a/configs/gxp_defconfig
+++ b/configs/gxp_defconfig
@@ -28,6 +28,7 @@ CONFIG_BOOTCOMMAND="run spiboot"
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_SYSINFO=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="gxp# "
 # CONFIG_BOOTM_PLAN9 is not set

-- 
2.53.0

