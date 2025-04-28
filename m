Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956FEC369D9
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 05:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE3A1820E1;
	Mon, 28 Apr 2025 07:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745818159;
	bh=O+4H50o44wgq/LVY6zW2RevZ6yONZJugaw/zAZVDdIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kGawIpDvsiJtWhmjdNLtZ2NyLRz+S+XwetWRPwtOZjsyrVyKH300K8GwNgKxNvAQp
	 eu0jl37bZhXc+WfnW4iSQfMz/70B045U2oNpQ0c8eGLwQtt1D/TPkPnI/vZ/P0q/rW
	 VMQC0PnLFCIhgSE8+7nRv4b+MvmY5uVtIImkuZ0Eeu1Ay2igN1L/2Ddb5fMm6ER6Ix
	 umhGQXS4KviBMQWHUKuPvJMpOLi/WBtc46qE5J2m1p9oYtLk1njatAYNdVaMlP61Wp
	 bZYp/PNtvBhklEHwPj4H/Q5/kGLysL02TsaKklfiHvh34TYS1cBOk5vDJgTUUcNkmG
	 RocwYRxRYhyNw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9345580BAD; Mon, 28 Apr 2025 07:29:13 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99EEE8210E
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 07:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="YyiU5w7K"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DAD5710293381; 
 Mon, 28 Apr 2025 07:29:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745818150; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=O+4H50o44wgq/LVY6zW2RevZ6yONZJugaw/zAZVDdIY=;
 b=YyiU5w7KBjYcpoGWjQuxdgAAF3XrqAg7tE8FNaZgRJVsl/OTCKF1xkSUEssN20SQhPcqNg
 fuzB8M8MYYYz0Vehsqrt3FdmM5rNs7ctOEbDVZfjqSxqczb6VdEYdI0Cn/2Euvw3d3g442
 1r89GkktF2gm3VjcUMaeGe7W9Bzvl3F7wtCJ6ExPKMWzmc8XTwbvHWn5IbjI33P3UZle0D
 ENog6QCmrpqnKAI3lmv3SSJyfYICYKmrEn3UIHiFOK30RwJ5nj6QTGNP0u1YoedoK52QMW
 KZk07A9qlvWFnO8inwzXWZdvLZbf3S+UXnXpHi8Pwc+dam4hh9rEqeSwS2fAdg==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@denx.de>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/5] siemens: imx8qxp: remove unused config file
Date: Mon, 28 Apr 2025 07:28:57 +0200
Message-Id: <20250428052858.100083-6-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250428052858.100083-1-hs@denx.de>
References: <20250428052858.100083-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

include/configs/giedi.h is not longer used after siemens imx8qxp
cleanup series, so remove it.

Signed-off-by: Heiko Schocher <hs@denx.de>

---

Changes in v2:
- patch siemens: imx8qxp: remove unused config file
  new in v2

 include/configs/giedi.h | 16 ----------------
 1 file changed, 16 deletions(-)
 delete mode 100644 include/configs/giedi.h

diff --git a/include/configs/giedi.h b/include/configs/giedi.h
deleted file mode 100644
index 19a795bcf86..00000000000
--- a/include/configs/giedi.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2019 Siemens AG
- *
- */
-
-#ifndef __GIEDI_H
-#define __GIEDI_H
-
-#include "capricorn-common.h"
-
-/* DDR3 board total DDR is 1 GB */
-#undef PHYS_SDRAM_1_SIZE
-#define PHYS_SDRAM_1_SIZE		0x40000000	/* 1 GB */
-
-#endif /* __GIEDI_H */
-- 
2.20.1

