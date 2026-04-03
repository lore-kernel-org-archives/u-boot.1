Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533CFE7E34C
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 09:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 335FE840F5;
	Fri,  3 Apr 2026 11:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OxcUz7fn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 462A1840F5; Fri,  3 Apr 2026 11:01:28 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD127840B0
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 11:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so13590785e9.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775206885; x=1775811685; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMpeK4MtNTzXJjiMZfUHV/B/PGxsObuqPd+AqE1fhy8=;
 b=OxcUz7fnVgy4Z9yjamXUpYun1psXUX2GqJVpC3wqCLtJQj20VF4d1K7fc2Eu3RuN9B
 I/TwNuM3OafERtEWokNnrSrqubAaX6grVdg/HNW+82jejXWNX6ip3fPQfAZXzOgRUyyW
 Fo93yH5d+1fwFyuoBAJsToxl0ZJ3oq1+nY5d7nQRt/SuZwyJul+Dhpb9tyG6wF8X3bH5
 oND1SwtW6vC56CKeqMkYcq6goMOL5LaJ0N+VF2+id5QXx89mt/A1nInEcYkI0VRyHO0F
 S6m3ExNO9hLUepxdx4o8j/UvGOPLzkBMA89vpOZuDCMZ/VnEt7MQW0VzoKl44MRCs1KT
 WNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775206885; x=1775811685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HMpeK4MtNTzXJjiMZfUHV/B/PGxsObuqPd+AqE1fhy8=;
 b=WMfbB6nsfRY3DV8ZJlQ+LID5MJSSVAMX0g6cwbfZseQ6Rw/20AJ6tZXdR5sFBaGjai
 eeiH3r0JiTuslFFy6sp0Tdl+siVZ0gmnDPucKEYGTHAKJ8RMzHZlCu46EKn69UsjRfxR
 mK0cSbalNGk1H53Tth9QIzwsuA9IUstdHpRhAnnvceGmooRkQHKuxGlEGtdzuxUULkhR
 PTlU7C/QAbJ4QzFNH8bHBOUgx1mfRNgFoXtFKGhDc1VH3wm7sf+YUUs95y84aZV3uELe
 qdfDsIY70bF+iPQKT/U448RsnvpgZ52ijqXdAsNnR3hyhHK/xQU4EpSGE65lAynqUExb
 5h2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAwfXY1qXi5+oTLU6/IVUiOtZA/Up1GaaXJB46ZQSmL/PL9i9wGAAvZip11A1E7q8Yilvrpy4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/2NDYZ7rF3Kd38JVxx9kiDYylPjb/5cOvifF6BRxuZ5MqHk2M
 ZrtqkNUrHcTQWqD/KoxOgYaThXmMBHAMbmZoPHsiEY4UjGsjbPu8bSEh8xghjSxzpGU=
X-Gm-Gg: ATEYQzyrskJaasR81L/xW6QCI8vDxt6PwPV0K+4aCBngkBG6A0z36mkbj0Ml+YYzZJ0
 Fub3bvpiMJF7DUR8KCm1vhXOCbYtUf7hT0QC55TFEWjZyS+AR2+5CNfVzAGlrepwktJ2FROfrI9
 NQtlTIq6Z/4useaVvRXrL+l0eATFt8Yx60q8UvYJ9xaVCUTx9PcerOMOXD8cZLV/wRWht5JTtlm
 zz3L3nhOQMYriY8SqqBE915+JIN8+pMjPaV8YBy9RIj4GTewo7eBpO+9YhuO9vjYSQlURPsofxW
 RuQ3IcJAyo75gasEe7YzJQEmNL0IJDGQNhPgD77EeFCrFIzyhG5lD9EOsoYCljM/8J5MX4HSsoM
 z3+L/DGfgFBITCBaRQXwIp3Cwoj7mR6qMep5pRoLuMO43R1gtqtFBsrO87UZc53vOHqkT6/3GrT
 dKaC3W9Fgs6ann1sqknqzMaDjvuhJ4hVh5aMBeyvnerwwdOXenslaz46UlEzI5gRxfXACkfS/0X
 Ec8UA286kNxGOO5csz6BQInnw4tTvXgo7eaHpy0PttepeAqgevYyaAMxoWmloOOo6le5NJ37cmB
 c+E9ffJkTUa3TpUylQb3XpBPZuAITjAB0fU9ekxAFnUtq/wAEN/FuuCJ2ITK8hDrXyheGkGfTBl
 KkegL05GYV8sy6iORXanMTlUmCD/THBPmQTgKyt4VSwKe9AiDFEDBe/4uiW6erhVUBH+C0swWhY
 7qQ1JVzaEq55k9Tqk/43sfRCTjPrwjTNaVqBwyG0/aGq71HrYZLuKHgf+IvBsu
X-Received: by 2002:a05:600c:4593:b0:488:9696:488a with SMTP id
 5b1f17b1804b1-488997e7dc7mr36672755e9.30.1775206884976; 
 Fri, 03 Apr 2026 02:01:24 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e967badsm332528545e9.14.2026.04.03.02.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 02:01:24 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v1 2/4] common: move ram_base calculation to independent
 INITCALL()
Date: Fri,  3 Apr 2026 12:01:04 +0300
Message-ID: <20260403090109.3564638-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
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

Currently, ram_base is calculated within setup_dest_addr().
However, upcoming patches that enable U-Boot relocation to the highest
DRAM bank require ram_base to be initialized earlier.

The default dram_init_banksize() definition relies on ram_base
to calculate the start of the first bank. But following patches
will move that function to execute immediately before setup_dest_addr().

So let's split the ram_base initialization in its own INITCALL.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 common/board_f.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 91c569da9682..7df92281c35a 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -329,6 +329,14 @@ __weak int arch_setup_dest_addr(void)
 	return 0;
 }
 
+static int setup_ram_base(void)
+{
+#ifdef CFG_SYS_SDRAM_BASE
+	gd->ram_base = CFG_SYS_SDRAM_BASE;
+#endif
+	return 0;
+}
+
 static int setup_dest_addr(void)
 {
 	debug("Monitor len: %08x\n", gd->mon_len);
@@ -348,9 +356,6 @@ static int setup_dest_addr(void)
 	 * get fixed.
 	 */
 	gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
-#endif
-#ifdef CFG_SYS_SDRAM_BASE
-	gd->ram_base = CFG_SYS_SDRAM_BASE;
 #endif
 	gd->ram_top = gd->ram_base + get_effective_memsize();
 	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
@@ -960,6 +965,7 @@ static void initcall_run_f(void)
 	 *  - monitor code
 	 *  - board info struct
 	 */
+	INITCALL(setup_ram_base);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
     !CONFIG_IS_ENABLED(OF_INITIAL_DTB_READONLY)
-- 
2.53.0

