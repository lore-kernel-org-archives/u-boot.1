Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F240CD8CA4
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 13:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 255D8848F0;
	Tue,  9 Jun 2026 15:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vXVmRsrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22E60846D3; Tue,  9 Jun 2026 15:22:50 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3381F848F0
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 15:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490d1e54b3bso18515065e9.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 06:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781011368; x=1781616168; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crmt8UycU857l92b8rdJNCdTC7cBRHJfG/jSNOQRsJo=;
 b=vXVmRsrvGnhJAYQi6VroUbzuEWfbtrMUyLiw+S/P9gp9FcoUAIL2Ylk7k/jEHixqKz
 uSf5mY9LwARvRo7fmfuX5fyMV57Ef+HXO1jfGexUH0XCT/b3oliMab+fVet53vIG4R+N
 jbt5Ms39cDqFQtcCpdqag2+cs3apZ2YZTxkzvIdGAEBx6afHW1WTO5N20Aov6kJbUODn
 QvRMcWvVGEnw8x+V/fjSb/h8qPMModrfySd041Bw4+RPJPGCFLLTsPAs4VRvgNqzWns4
 PNsVHgYrMtOMWXF7JBhdM9G+jlJBIzVH1na8UAfttXticeVOgvsOls/uMhg8gBrm64R7
 lG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781011368; x=1781616168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=crmt8UycU857l92b8rdJNCdTC7cBRHJfG/jSNOQRsJo=;
 b=KlHsuypTiuQYm6HZmNauTA51jU9k1AslZ6M+NMqEMi4V1ig5Z44clg19pWSafS3EDR
 nx28rCFTkRasb/B5v/E/xjM62Z0XfwvbBsWE5OREh5w1xGQ3lEoGqp9dE/E808X3IfDE
 vR7lRZHZlJuFbqZoxLZXabdBb9fZ3b4atDJnybW3R+ujkgIx0ldJVWGdsAiw9RO9mwfV
 8m0DkwvlUFXRwvz4k73qBf3QNGDpBuK/+fe2uelym8Qmd2BT1kY2cAU4loK3lWGDwRHq
 zV5I9tNUZFqmB5Klb79WAOL4NLAm8o5oRiRt8qz/P+M7x+EWJ9KfpI3EQHTR745ubpKJ
 r11A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kUlnjLQEecN/w5hg3WSDTrewmSFZSCAkDg2LZ47fUXMpd8dNmmxyGdQT0FJcFRzNUA0QzCu8=@lists.denx.de
X-Gm-Message-State: AOJu0YyeIM2B7yg7fLqfLGA4cGKhS37peDDK8ElkL+B3CckWi9i2zS2j
 UHj2bHeqXhukEDgBgicMLb7nXI982mWrpvNRfti7FNZntjcVQ2WFeFmFqUHRcG0y2iY=
X-Gm-Gg: Acq92OGi7AVLzNMi/SnUtP5yXEcxVJGvMpFBeG3RKKrrcfMV0TVyH4zWSXMBP3jra+B
 YnmACTLAAPVAvpbIUwpjqqCFgLcjSi386sc5E7BMgevJWcwhrrlCRgOhVkG4COHZow6qA4HtFLJ
 6qCztf2yGGovcux0/4+E4AT3fpBTsUwFk8o5KCLzM5T1dlTHTADrnyDUSohFuDokfm/s0YrHJK9
 tGyOcaR2fbROvfzcsRP8uVVXCxhWAlKa1kEOqokNn5KtdmsMk1+4EuOGElOyw0crCgGERvQHt7U
 h1mVX/JUg3zEB+YjlI0nBJDDxmcbgxZnVuxKjds4nq2bmiM6CyHh709yhHJq0G7lLmJ9qTizxtR
 ZJ47beOuOAOAxpjoXsJTupsNraidkuCjZ00T4CyjJlenDnFObt2dkSgrv9eUj8+OeUzThgbR7s9
 UWYPBxOOcYwXhSIp2/QePagqi2UAh1VhvKqFGhBAB7N5BUa/PAwlHYMbC9XMy4yi6Bilcb+Uc/m
 Z2kW2eVs394l4ptwsSpBafmDiBMnwjc+ZOob6CkSSN8XhKYkAtcAVK5KsBrVstNV6+txI8CQnsM
 PQqXzSYDjM9UeB1Zf96YO3XCgbdTqYvafZVddaRNpPBa/68S5OQVQ4f0Be1OaX+5M1bcpP6hdcs
 M7dt7AcOudyc3C9kCirxq+hpCpD7m7aDsAVzxhQON7ocSuaducN4oweF0LY4j+zPO+ddtbwjaoi
 g7ph17aPM4/pThMegtyqeYAtFn1b7hmQcSNDKSb9fxMNT5ei2zMdsevP3G7UOVcGxfEqj8MlJgQ
 bjmF60VJQ+rZoo+APKKizVrvc22sC8u1wF92t0=
X-Received: by 2002:a05:600c:8183:b0:490:958c:46dc with SMTP id
 5b1f17b1804b1-490c25b0a60mr301764265e9.17.1781011367372; 
 Tue, 09 Jun 2026 06:22:47 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3446aesm68477564f8f.24.2026.06.09.06.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 06:22:46 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, christophe.leroy@csgroup.eu,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: [PATCH v6 2/7] common: move ram_base calculation to independent
 INITCALL()
Date: Tue,  9 Jun 2026 16:15:44 +0300
Message-ID: <20260609131611.46399-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609131611.46399-1-ilias.apalodimas@linaro.org>
References: <20260609131611.46399-1-ilias.apalodimas@linaro.org>
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Michal Simek <michal.simek@amd.com> # Versal Gen 2 Vek385
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 common/board_f.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index ccf9e27a7e53..150774648b97 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -328,6 +328,14 @@ __weak int arch_setup_dest_addr(void)
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
@@ -347,9 +355,6 @@ static int setup_dest_addr(void)
 	 * get fixed.
 	 */
 	gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
-#endif
-#ifdef CFG_SYS_SDRAM_BASE
-	gd->ram_base = CFG_SYS_SDRAM_BASE;
 #endif
 	gd->ram_top = gd->ram_base + get_effective_memsize();
 	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
@@ -970,6 +975,7 @@ static void initcall_run_f(void)
 	 *  - monitor code
 	 *  - board info struct
 	 */
+	INITCALL(setup_ram_base);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
     !CONFIG_IS_ENABLED(OF_INITIAL_DTB_READONLY)
-- 
2.43.0

