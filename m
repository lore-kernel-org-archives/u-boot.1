Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83386C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 764EA88B96;
	Wed,  1 May 2024 04:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jKeMAAgs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22AE188B7A; Wed,  1 May 2024 04:44:38 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE5DF88B87
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7926564c111so36961085a.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531475; x=1715136275; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TvB843mzN9T8aYZGxNrJyHWLW0VWSgou7AILFWnQbxo=;
 b=jKeMAAgsLeWX2ZuOWSIy3TKMjhbPbQJi02hvEOMcwsXlp36976Ghey5RfVK/ULXka6
 IBnUmWo+Ml6MdabbFNQ/bm+bwQWLgoNCw1sxb4toRKh16wPs5XcBRZCKow3sFEdqNqAX
 9scaBF52YiO2MRpLJ0ORpaUsVdzoXIf9y0/4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531475; x=1715136275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TvB843mzN9T8aYZGxNrJyHWLW0VWSgou7AILFWnQbxo=;
 b=TDQZREfl+VH5nDAFLnrBbL2nePaFLf7zs/Pbgol6EKvk13XqHSsnSl8e19GNQP39ik
 GM/2L+0BDwPmUK0oYBjDNCCh0UPom97PZ59ik9Th5ALdlaTvwTxsYnmRCaDeJ56AwXBZ
 ReqTAWhRuISM7SaSDKEGOaiAyZK4jYWb9XfqxC33jkPBbqSpE/2AqnJn8tWsM3PFxBgu
 7hNjjaxQIRlAvo0AnyOlhF3soCsilbbcTKT6rt2wpkm71rkojbH5Xcnb1JJbyhxgbWZF
 nXubTZZqh42Twxn7MHLcTPp0dQxI4esZaPbLoNot3Dq3z8H3hH40nYbvqULaUDJIPUwK
 FFUA==
X-Gm-Message-State: AOJu0Yyh9hN18SMjz/USJFPKaoODVhMXrDuuuanzfLXaICHzav0xaBgt
 sxGX05OMCePebc8A9F5bXxkgTCNY6rYjuebiZzuAnU4MCfi/TMT4X4ei1h9ow0ywg/iybHWRRiV
 fUChtaA==
X-Google-Smtp-Source: AGHT+IE5qEh0luo58O4F5BYA7d9OysRUxmINxnUJjK7gcsIoA1YaZazywFsElQ+GLox3UMxfN+SruQ==
X-Received: by 2002:a05:6214:f21:b0:6a0:ada7:200a with SMTP id
 iw1-20020a0562140f2100b006a0ada7200amr1341499qvb.18.1714531474681; 
 Tue, 30 Apr 2024 19:44:34 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 064/149] board: gateworks: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:51 -0600
Message-Id: <20240501024316.1767971-64-trini@konsulko.com>
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
Cc: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/gw_ventana/common.c           | 1 -
 board/gateworks/gw_ventana/eeprom.c           | 1 -
 board/gateworks/gw_ventana/gw_ventana.c       | 1 -
 board/gateworks/gw_ventana/gw_ventana_spl.c   | 2 +-
 board/gateworks/venice/eeprom.c               | 1 -
 board/gateworks/venice/lpddr4_timing_imx8mm.c | 1 -
 board/gateworks/venice/spl.c                  | 1 -
 7 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/board/gateworks/gw_ventana/common.c b/board/gateworks/gw_ventana/common.c
index 74328b2e1b31..891d1b5ddcaa 100644
--- a/board/gateworks/gw_ventana/common.c
+++ b/board/gateworks/gw_ventana/common.c
@@ -5,7 +5,6 @@
  * Author: Tim Harvey <tharvey@gateworks.com>
  */
 
-#include <common.h>
 #include <env.h>
 #include <fsl_esdhc_imx.h>
 #include <hwconfig.h>
diff --git a/board/gateworks/gw_ventana/eeprom.c b/board/gateworks/gw_ventana/eeprom.c
index e622a9ba9e4d..b37f19722491 100644
--- a/board/gateworks/gw_ventana/eeprom.c
+++ b/board/gateworks/gw_ventana/eeprom.c
@@ -5,7 +5,6 @@
  */
 
 #include <command.h>
-#include <common.h>
 #include <gsc.h>
 #include <hexdump.h>
 #include <i2c.h>
diff --git a/board/gateworks/gw_ventana/gw_ventana.c b/board/gateworks/gw_ventana/gw_ventana.c
index 683def7e9f71..21a908c20dd5 100644
--- a/board/gateworks/gw_ventana/gw_ventana.c
+++ b/board/gateworks/gw_ventana/gw_ventana.c
@@ -6,7 +6,6 @@
  */
 
 #include <command.h>
-#include <common.h>
 #include <fdt_support.h>
 #include <gsc.h>
 #include <hwconfig.h>
diff --git a/board/gateworks/gw_ventana/gw_ventana_spl.c b/board/gateworks/gw_ventana/gw_ventana_spl.c
index 2f046c9c0b3e..3de4727b2edf 100644
--- a/board/gateworks/gw_ventana/gw_ventana_spl.c
+++ b/board/gateworks/gw_ventana/gw_ventana_spl.c
@@ -4,7 +4,7 @@
  * Author: Tim Harvey <tharvey@gateworks.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <gsc.h>
 #include <hang.h>
diff --git a/board/gateworks/venice/eeprom.c b/board/gateworks/venice/eeprom.c
index 241be4ee630b..afaabf348793 100644
--- a/board/gateworks/venice/eeprom.c
+++ b/board/gateworks/venice/eeprom.c
@@ -3,7 +3,6 @@
  * Copyright 2021 Gateworks Corporation
  */
 
-#include <common.h>
 #include <gsc.h>
 #include <hexdump.h>
 #include <i2c.h>
diff --git a/board/gateworks/venice/lpddr4_timing_imx8mm.c b/board/gateworks/venice/lpddr4_timing_imx8mm.c
index 78b431dc2844..3f2c090a94fc 100644
--- a/board/gateworks/venice/lpddr4_timing_imx8mm.c
+++ b/board/gateworks/venice/lpddr4_timing_imx8mm.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/kernel.h>
-#include <common.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
index b0a315ba9531..f10d310a46d4 100644
--- a/board/gateworks/venice/spl.c
+++ b/board/gateworks/venice/spl.c
@@ -3,7 +3,6 @@
  * Copyright 2021 Gateworks Corporation
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <hang.h>
 #include <i2c.h>
-- 
2.34.1

