Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B235C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 17:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CA3487B5D;
	Wed, 31 Jan 2024 18:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kbGhkvQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9327987BDF; Wed, 31 Jan 2024 18:32:29 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366DC879F0
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 18:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d932f6ccfaso24595ad.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 09:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706722345; x=1707327145; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W9UUEiB2ixmC33CkG/+4QtuxUm89RvBl2uccUOLtOhE=;
 b=kbGhkvQP8LJvViOSESBA8KH/i0tWd2Oy9l27hVSJswJ6SVYOeBhfKXtRg4a0Lf//9L
 L5ST50rsojViaETOLqViaPrLHDp8+3gPT1oCR+IktabqL/W4fYdTOQf/QN75wyKkuBUN
 wZugDKZWI9KCumyKz1WsOy9Ea1TEsn9scKjQ6v8LBjvnju6bBtQcb22ZWLIc6YNY198r
 rElOw/+E4FFN6cRy9NaUlAWzbiiMyJgpfbWdNsmgTCfc9YyQCGxVGo5SDyeWSrROJs76
 ddWMcoC51BkeBW1rxJEbOXXF1K1EEoqygs9T3fqzyjvBPZIJv8Fe80KT1y2zN30ev3TZ
 5DQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706722345; x=1707327145;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W9UUEiB2ixmC33CkG/+4QtuxUm89RvBl2uccUOLtOhE=;
 b=kB5qdUQnBb+DYbBta9xAHpI/sMNNcDeWWCqZ4EqKQztqU3yrg/M0RW0UnKVfqBC1o9
 va2nkbEvXC3EEl/yyqtaopNb4K9CgRbc/FaoANdE2WBR0xZK1MY/PzOJ90X81hStJA76
 7oa8vXIHTnVZmA7KRoc9vihYcpKL7cMyUhqA1cVTXHmtLOCnCBBHNpYJZ9Sd46sA9vVB
 KE9VkQiTxkNNP2mnG7uKi4lPaakPPXUwp1dwgEEnxw6x7BNWnQxr4td0J2OweGualeh1
 4UDKXBvE75XEIC98o80q05xaRMq+OqGPiSSjMm+n0x23+7IukQ9Jjwy0zZa+32/VUt/L
 7XdQ==
X-Gm-Message-State: AOJu0YzE0DJHE1Bw3ajrfmv3jdYOwqrFMLC9VbuEN3sjveMyIXN196uK
 ovIMVe0VBpiwdo1CFDMrQ+2U40kODKHCchbuoN2zzNRP+d+YeoIf
X-Google-Smtp-Source: AGHT+IErT7pjXw1ze9ZuUkRJfhhMqXv/HSqq23K8NsGapDMbtF7Qb/if03yctuN2ZHUhQmpWiUxg2A==
X-Received: by 2002:a17:902:ec8f:b0:1d4:14a0:bf66 with SMTP id
 x15-20020a170902ec8f00b001d414a0bf66mr2774146plg.23.1706722345296; 
 Wed, 31 Jan 2024 09:32:25 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWNwF5tCl/8+qvurH5sI0ZMoAae3xkuMq3TmsuYeeOjFDc5KffH3bvyM51fOb2gkvLTk2d9+Op1dWXE8KEP7unAW/AAWg==
Received: from joaog-nb.corp.toradex.com ([201.82.41.210])
 by smtp.gmail.com with ESMTPSA id
 jx11-20020a170903138b00b001d8faede8b0sm4438256plb.22.2024.01.31.09.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 09:32:24 -0800 (PST)
From: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH] toradex: tdx-cfg-block: add 0086 i.mx8m mini sku
Date: Wed, 31 Jan 2024 14:32:04 -0300
Message-Id: <20240131173204.100407-1-jpaulo.silvagoncalves@gmail.com>
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

Add new product id 0086 Verdin iMX8M Mini DualLite 2GB IT.

Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
---

Hello,

The change was based on u-boot-imx/master-next because of [1].

[1] https://lore.kernel.org/u-boot/20240122200930.673447-1-jpaulo.silvagoncalves@gmail.com/

Best Regards,
Joao Paulo Goncalves

 board/toradex/common/tdx-cfg-block.c | 1 +
 board/toradex/common/tdx-cfg-block.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 3f2f6b94391..4a7de5483d2 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -156,6 +156,7 @@ const struct toradex_som toradex_modules[] = {
 	[83] = { "Apalis iMX6Q 1GB",                     TARGET_IS_ENABLED(APALIS_IMX6)     },
 	[84] = { "Apalis iMX6D 1GB IT",                  TARGET_IS_ENABLED(APALIS_IMX6)     },
 	[85] = { "Apalis iMX6Q 2GB IT",                  TARGET_IS_ENABLED(APALIS_IMX6)     },
+	[86] = { "Verdin iMX8M Mini DualLite 2GB IT",    TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
 };

 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index b783537ce76..021cc21b5e2 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -111,6 +111,7 @@ enum {
 	APALIS_IMX6Q_NOWINCE,
 	APALIS_IMX6D_IT_NOWINCE,
 	APALIS_IMX6Q_IT_NOWINCE, /* 85 */
+	VERDIN_IMX8MMDL_2G_IT,
 };

 enum {
--
2.34.1
