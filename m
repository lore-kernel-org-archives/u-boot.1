Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB25F419BA
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 06:01:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4CE384258;
	Thu, 16 Apr 2026 08:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rTqVnigY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F099484207; Thu, 16 Apr 2026 08:00:20 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7651083C2B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b150559bso59607585e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 23:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776319217; x=1776924017; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Io2eImeVvihuhyYgC4XeZMs5oWUR/VFYxatL/tS/5mk=;
 b=rTqVnigYf0dQqEigyIcAjn9ETpwpmwtwC9Na+wkSuLlEss+dvq0BNHUoM4O30NiY5/
 9Af14a27dCUVqaBvO6/P6VlsVGFWw60Sz6U27DGi006GJrRPeBp76i4ZAzMil/IJovpW
 S8R588WHzhlyimZToe4vO4jbrK3+jSIZz4dzqMVXNe8egN0GkdMmD/Di4jbwYy3nxI/k
 ZxiY0S/9kq4xAx0YEnAlRPCsM4jfrPqg9yRGiyUwaJoJnAmij/l6WstW0UABLmzB6Lrn
 bWIbYevU/MxBZuvmMHTo+IuKjMkPCXciZaXscv06Ko6lrbhgDWFycKnloRu7FBSe36kG
 hhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776319217; x=1776924017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Io2eImeVvihuhyYgC4XeZMs5oWUR/VFYxatL/tS/5mk=;
 b=L/Vd7auhnTUWFafm2nIW+udfIpJ6lAEPnpd/KVr6Ly8jl65glq0/h4ikSxMfO2Auu2
 50JR9LEOXRkwx/WrTVSd1DNL22QbUzoFwDo8Mg2R2co1KShF67S9nkeMi48Ye0c2G9PN
 u7luXoDbBgzntgW9Mh9elfO/im7Y2Uiv7VQKGFQdm2YHKe/8jM9yaoh742xqfSOiWO3A
 nJ5Z5aOdDLLjDx1OcML8JXStmEJn10wY/NoChzyWtrsPVNh87iClH5IvlUSLRumxg61S
 Ry27+fLNj6aztKExqwBJFnmdjtiVONeOuRv3CJsgul+5Y8uZZekq2hapRP6E6hn+KjZl
 2pHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/R4iBvUBZ8D7elamJRcSip3f23RFjeLttKbvBZCjeuxMqOkWvS+Y2ISYrsSNdgkSo2leNuKeI=@lists.denx.de
X-Gm-Message-State: AOJu0YzJsFqph+E5nINxs1ytD6V9pu+kN7hT/a2TlqN2byPJ/mvbgexy
 gWPDbvdR/StxIs3VIY7pvsIDi9KR40N9znl4xhtci8mUgRBvsUvLvulfIxNNUxOrlqw=
X-Gm-Gg: AeBDies2Ltp/ZEBakLlcRJ/Y2vktG5J7QKfGKNIu8tFia4tQD1MQqui0nUbjTxeTk63
 HKoY+DmN8VvjPwWnHt/5JIHlTgu1fnnHtpehlSE/HhQQIm6vbRVrL8E+97vJUqRbrkCsA8x1hqc
 93BHH6cbS7eOTDJctgsDJOXk4mBaT6qjGICDfHW1qu5FvqHlqSrcMYhJxWMrBJT3jg2aQaogtPO
 T7SrRuZqBC/8qCJy/ayjao4WYNk39FnUehrbGfIIv7bxl/9ZaPgROPpFubRfHXjt4xPD0q6CSxI
 xcJ0/7NeQ8Ql5rURdTgtNQlLRi19BlBfQBwRptwx3X5FCJ6n3iFjiqWq9RvPh/NUEKX63U6H+yh
 fQ8afLKHPEkeT/KjWrcR99dv/MmX3Pg+Q3GbRecHDOW935pkHhYGtb33bVQsEupYzjb/GnD4FFd
 F/OQFOayraNAXbtTuuvy/VqAV/9nXU/nutAqlSRwCBuCb/1i1DREmy9AKi64Gaau6SNYR6pC5rF
 m2nAtENOMFURem3I5T7rkSRMSuJzmpJj07cAKhacuUCKwpmR7e53+2zv+hnjjDJ3B6SZisdSfey
 qpYm06JPMM0yM0ckTqw+Hb+lrB23MGajqLWQaOCeQcOCJjJ1rEjniFZMHyOWdg22Es+LH9Gbgq3
 kAszSVWW2H9DWFyQdcZuyXNCXVO/Cb2gMhqDYWpIdcljLHOqV11ukMXuswHAa6/DFwmRGXTQ00V
 ph/+0QHeoVIXlh1fiFWQdwnjOzo6lBhFqu2wgrkJmH226wFhJys9hQQuClmKk2G6vT1obrV1U=
X-Received: by 2002:a05:600c:681:b0:488:e192:6fbd with SMTP id
 5b1f17b1804b1-488e192710cmr149134795e9.30.1776319216587; 
 Wed, 15 Apr 2026 23:00:16 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0e9a770sm36379755e9.19.2026.04.15.23.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 23:00:15 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 5/6] common: Clean up setup_dest_addr()
Date: Thu, 16 Apr 2026 08:59:41 +0300
Message-ID: <20260416055948.130041-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
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

Right now the function does
- Re-adjust the ram_size based on Kconfig options
- Set ram_top
- Set the relocation address

It also does not set the ram_size in case ram_top grew
from it's initial value. But ram_top and ram_size should
always be changed together.

So let's make things a bit cleaner and move the ram calculations
in their own INITCALL

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 common/board_f.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index d1e7d0d2f046..4ac22dca9e7c 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -336,13 +336,9 @@ static int setup_ram_base(void)
 	return 0;
 }
 
-static int setup_dest_addr(void)
+static int setup_ram_config(void)
 {
 	debug("Monitor len: %08x\n", gd->mon_len);
-	/*
-	 * Ram is setup, size stored in gd !!
-	 */
-	debug("Ram size: %08llX\n", (unsigned long long)gd->ram_size);
 #if CONFIG_VAL(SYS_MEM_TOP_HIDE)
 	/*
 	 * Subtract specified amount of memory to hide so that it won't
@@ -358,8 +354,17 @@ static int setup_dest_addr(void)
 #endif
 	gd->ram_top = gd->ram_base + get_effective_memsize();
 	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
+
+	debug("Ram top: %08llx\n", (unsigned long long)gd->ram_top);
+	debug("Ram size: %08llx\n", (unsigned long long)gd->ram_size);
+
+	return 0;
+}
+
+static int setup_dest_addr(void)
+{
 	gd->relocaddr = gd->ram_top;
-	debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
+	debug("Reloc addr: %08llX\n", (unsigned long long)gd->relocaddr);
 
 	return arch_setup_dest_addr();
 }
@@ -965,6 +970,7 @@ static void initcall_run_f(void)
 	 *  - board info struct
 	 */
 	INITCALL(setup_ram_base);
+	INITCALL(setup_ram_config);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
     !CONFIG_IS_ENABLED(OF_INITIAL_DTB_READONLY)
-- 
2.53.0

