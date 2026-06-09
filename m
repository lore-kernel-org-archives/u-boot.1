Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E906CD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 13:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A928A8495B;
	Tue,  9 Jun 2026 15:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="liRkF00y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F2DA84894; Tue,  9 Jun 2026 15:22:54 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD99684894
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 15:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45ef4223be7so2971710f8f.2
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781011372; x=1781616172; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YK5I0SStrG9YlbYj5q6xxyqcVj6zjfUjQ7dKxTHboI4=;
 b=liRkF00yKhTdhToxeLBX9Dc7kGp2WmDFcZkAH+j5frUBmMOmMAcrfSGE2xHV1/XnDc
 pP80fTpH4j/foqLgRR4IQeqnb06RF69ROjGqDWTF1qKvuggKWiYpKmvxJ86vQqCbae+2
 pMeBxSEwQ92z/YWucmoMg1X6TEfa09lVCIxN24gbbJQbltpUTF2LrhW1A/wIaLVV1YFE
 P4QczwI6v34TO7zq4nBXtdgIFpIzzi7dVyt1LMc06ZQSR8KHpWax65krBYthJmMsZsqu
 w5qoW6S+sFm18+oa7aRZHS15QQW8w2Md+dYOmaPblHjYk8H85tpo3iVzpp98qHCSF4Vv
 90pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781011372; x=1781616172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YK5I0SStrG9YlbYj5q6xxyqcVj6zjfUjQ7dKxTHboI4=;
 b=bXpZIEkNLZCU6kQl2uDYI1d6bUS8xyLHL2JdskAcZqWuUK98lYPr959Iv+PqAUMpSL
 exFKlHSswS4K00t8DZjyBz+CQOzY61eUvrdtickd8yCnd81znVCjSHmiuqNP2cnsYmE4
 qlVUnoze5H4vH5ZNsvYOLcRaBXD4FQd2ToO4ZfMYFUTrU/YW2Sv66jFZlDHnS3w8kaS0
 GIkIcQ4JEPExnMtgArVyUtO5A1EjKqLnQCMLt6FmQARSkt3tKIONYG01Qkd4y/meNEHM
 8nfed+jpAXYagOCBwOYJjAwoHeLYwZ5Loe0rpWfRNRxNnvtwqTMhk0Q2CTuKySbuvsV/
 cQPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/D+mzWrX2b8RlZ1zo5BI2IU/jJyqqfaEHPWs2JbML9e7uCBrfFj65Icn99RfY557Dkyp1BsZc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz15owh6bs0x6v1rfShnAni0tHuaJ9AKUJHsS8JBt7m6CWNqDcP
 u/0K4F0rpXcPs0IF/iAF8hJpAFni4emNNyaqyRNH2XOQNztOaTiXqH/FPdA0L0Spj2w=
X-Gm-Gg: Acq92OGJME/9FedLs5NYKyd0c/0uzDnlq96Z8mgHE+k9Xv6/qI31YnO/mziYsTZvDy8
 5ezejxTOf92MkZhkJOKROs6CpzsBVH7MTvotwrWfpDLsM8by8hw778Ylx+iAGDjhAibk4M8hT7B
 Wn+wHVLlTIit5G9GheIhe1NTrw3nU1Taa6c3q+KNBWI3gkNm4PJ6ycn4ynwoKFHBdNOfuvvoz5i
 W1j8kkVhRLGJSTxVAn00KeT7zAFydEqrqRb8IUCpFbZFluiD3PujrHMcFc0jHWgarhFDJ/1YU1D
 HIURvtXe19how7LGXCqwggW/TParrhdDrJIYKQ00PkNRiiChvJq+1BdPpNoASb5BsB0XihV+o6z
 uQ6ORMZgGHthgXHHHxGsb2NftOQkL/o6uctqC5fzyhLUFnvoLflqHMgf7zuoASyAsUhlqLv/AOK
 Rg2QjTzwLrBxlS1iRvAeZgzLNi4P5/cZbIIcLmdu1OpuTFI/ICWiGocP9dqvTCkkcr6DXkLuraG
 EuWMoTTsXEmNPRs0PIkbMT/4zuStfC8vkcUxynrve4TW834sCSJu7SIGKXvTzVZAFOIo138ZmVl
 1nTPEdw/eBOKO2HO6/zZZVl5R3Ugrmofjb07EkG9mZlQAz2N6oKfaQEuNAD5dCzKY0a/5SO5zZY
 Bsh1fosN14KWmG8zOXeiow8Henvu98hmsz4UhyE+i32QxZ0kmBpt4fRxLx20n9PFVzaY7cX0FNt
 Jc8b91W5xqGZ2GP+vzvDUiSsrGtYRll/TZ9KGjMHMAaeffQTlaW5BFCzgJvCJI0NhhvTdeYCz54
 lTpLkP2EhHHpPbWvsB0xjvQPDjemMiS8jTyK6Y=
X-Received: by 2002:a5d:6f0c:0:b0:441:2aee:d561 with SMTP id
 ffacd0b85a97d-460566bea7dmr3683281f8f.28.1781011370996; 
 Tue, 09 Jun 2026 06:22:50 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3446aesm68477564f8f.24.2026.06.09.06.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 06:22:50 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, christophe.leroy@csgroup.eu,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: [PATCH v6 3/7] common: Clean up setup_dest_addr()
Date: Tue,  9 Jun 2026 16:15:45 +0300
Message-ID: <20260609131611.46399-4-ilias.apalodimas@linaro.org>
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
Tested-by: Michal Simek <michal.simek@amd.com> # Versal Gen 2 Vek385
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 common/board_f.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 150774648b97..d78d680406ad 100644
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
@@ -976,6 +981,7 @@ static void initcall_run_f(void)
 	 *  - board info struct
 	 */
 	INITCALL(setup_ram_base);
+	INITCALL(setup_ram_config);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
     !CONFIG_IS_ENABLED(OF_INITIAL_DTB_READONLY)
-- 
2.43.0

