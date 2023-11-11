Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B6EC4167B
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 10:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B67B86F3A;
	Sat, 11 Nov 2023 11:46:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DISlnrnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8805986E02; Sat, 11 Nov 2023 11:46:31 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01F386F3A
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 11:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53dd3f169d8so4418637a12.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 02:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699699589; x=1700304389;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CgxVGGOB+3BbwmPrseQAJvzDHTtlNa1mCDW6GYXtv+8=;
 b=DISlnrnzi5diqJnvtAaj122WkKfp1jWDkc65geZlmdVq54e9noUp2hEQc9SQ+5fB/J
 ooDRzkuCFjgi/DAXvMXzTwACPnQsi0fYX/PCZCk5LX8krLtta/4ADjw6FD1gUESFUrQH
 bdlnEt7D2sMCscO0r/E9gl2804P2dQDbK3vKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699699589; x=1700304389;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CgxVGGOB+3BbwmPrseQAJvzDHTtlNa1mCDW6GYXtv+8=;
 b=IotlJQz096qiIO5YYT77Fo/4e1/uL8W3QWboPjDKVLrt2VHVKZ7UE/kLayuOoQhtwC
 qjaEMKXBxTTpqlUjWBp4x/0zq6tq3zhlbLfjhBJwUD5rKFPuCLAgkDdILETY+hbRWqGg
 OrH+Synjs4XZDoRNJBb8Oa5IzcOOBRgMIZuDnkI6UVng79cfE+yJ7juDnfLj87j2mVWr
 J6H0HS6+0uLrG1QRAfVp930M8GeyIFbhuWC4gf/vmTXKuAVFXL/klXYPy5ZdCgv+f7HT
 s3uIdhn59bi7KCsKFv+XwTuZuLH9MssnTKIop4RxIDOy/pZYGCcwKL984SC0+eqQQt7b
 8njg==
X-Gm-Message-State: AOJu0YwyvJQDk6PJ5NGS9h0eNlI5sFczUlNSKIICM4U9L3am3TkGvROW
 tRr8WBg716tHKbhi1TvXbxljPRpINosHlZkQ/E0U+A==
X-Google-Smtp-Source: AGHT+IHV2/8b8l8P66/boov3E28zWcbdSOx4hZNUE0MyXZAYsdfS+HukPMcjGTP0CVRHFvv0zvUgWA==
X-Received: by 2002:aa7:de83:0:b0:52e:1d58:a6ff with SMTP id
 j3-20020aa7de83000000b0052e1d58a6ffmr1027385edv.35.1699699589024; 
 Sat, 11 Nov 2023 02:46:29 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
 by smtp.gmail.com with ESMTPSA id
 c19-20020a50f613000000b00542d3e470f9sm827534edn.10.2023.11.11.02.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 02:46:28 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/2] clk: stm32f: fix setting of division factor for LCD_CLK
Date: Sat, 11 Nov 2023 11:46:18 +0100
Message-ID: <20231111104625.137511-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
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

The value to be written to the register must be appropriately shifted,
as is correctly done in other parts of the code.

Fixes: 5e993508cb25 ("clk: clk_stm32f: Add set_rate for LTDC clock")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/clk/stm32/clk-stm32f.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/stm32/clk-stm32f.c b/drivers/clk/stm32/clk-stm32f.c
index ed7660196ef0..4c1864193357 100644
--- a/drivers/clk/stm32/clk-stm32f.c
+++ b/drivers/clk/stm32/clk-stm32f.c
@@ -530,7 +530,8 @@ static ulong stm32_set_rate(struct clk *clk, ulong rate)
 			/* set pll_saidivr with found value */
 			clrsetbits_le32(&regs->dckcfgr,
 					RCC_DCKCFGR_PLLSAIDIVR_MASK,
-					pllsaidivr_table[i]);
+					pllsaidivr_table[i] <<
+					RCC_DCKCFGR_PLLSAIDIVR_SHIFT);
 			return rate;
 		}
 
-- 
2.42.0

