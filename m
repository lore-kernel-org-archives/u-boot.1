Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB52DCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57B548376C;
	Wed,  1 Oct 2025 22:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G1Ye09N2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7587183741; Wed,  1 Oct 2025 22:31:02 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43E67836EE
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-355102ff142so124152fac.0
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350659; x=1759955459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pGae9EzlHpA0wMkjysYm3QiCl1wBR/K6Q3r8axhpHUI=;
 b=G1Ye09N2ylM0Yw00GsEJaIx4AF9X8hzwJ9VcL+1Xw3P8LJoOm2tiO136U1jDGZxbAi
 UFNrxqAYhsCj+tSyusvRTgVitvUTT5jHSA1z1wdE37BrTqHtXcGuaIVsPdgoO5oWb31U
 NCN8r1PPpK6Kflpq3tyEKcV1L8zPnsR9IRjm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350659; x=1759955459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pGae9EzlHpA0wMkjysYm3QiCl1wBR/K6Q3r8axhpHUI=;
 b=HUmsNLysyDvtgqZKQatFQpau4FtThV6H7G9TD8h3WveM23VXEytsGVwTNDjVbrE932
 6F8p74H/ZIR8pKVsXtdI/Y98+t4HZcyXm6wc13LDnK9MLjg1k+p7afJvDFglBQY6yPwn
 q5PnwOMyTnai5n9OQ4+YlAYSsNr6MTUOTnB/h4eeUSoOQzaib2sLdzwCItVGapQvG7wf
 u2XNkhktTkEcJneCHw2sWnmSebqC4clS2OUi4TbJ8femshlLN0gAVqxRbCZKybIGZIxi
 zdXiLhPJiolOEKbGS5UKlImzkYI9C9w6/TKFgk38KmB6tMBl6Twmk81/watQWtD58UM2
 gH9A==
X-Gm-Message-State: AOJu0YwSdRlK8nsl52yuUzcJhBzws6RF/LoZwrzHhaBocAzaHcBCb0sV
 S4sTGOsXPEU0HmUH8yqsrS/EmQa1x9rN3wBqghCnhqw9TMet964/dE770uJL8i/wo4fjj9veLno
 R2DxDyDw=
X-Gm-Gg: ASbGnctUKQ/UUE1hscTU76E6Hj/Avx2p19aSzUsMvzSGqCC+dZMVaqASNS2wUsaWNRx
 ydWNEaG+eHRWc+EXFXBUPyPenUlKddziVYLGD7moldv6zK9q0OOCa3xHg/W9TwLzOHEIzaLnXCJ
 P+a/4r3Ctjgt2Yra7im8rZuzEibmvUsieIu890E+zakg7BIFVA8S2BisfsVZw1Vy7OKHwgE0c2b
 lu24dgHeRna9nVZwgYfkw+EbRJOECYkst9xDICYBD2cR22eQsSQZ7Z1tJAsILTcUQ2r3cOLgHiL
 41VkLsRRssXfBi/pnlRMbuWx3dy/usSeHnEGRfqlNDPcvZH8FRZJXkI2NL3hxp4xJSPlcUROIxR
 pg2Dd/vjDOYrODb5FxNQ+3C7iwUe2jCl0O0KLzD56SD5xFRPSbS0xdICeykZWZIjx40xMj643zV
 5epdTbq3KrV0bt+nqqZQ==
X-Google-Smtp-Source: AGHT+IFRvJMhI8LqJeCg8aJMPhpXHxmAjkQc0P8hFJ0jl4cLnO1fX29mrTa4/XYeNuzu7tvsc/0yfw==
X-Received: by 2002:a05:6870:9114:b0:344:d813:6d4c with SMTP id
 586e51a60fabf-39b91c66d4cmr2655910fac.6.1759350658995; 
 Wed, 01 Oct 2025 13:30:58 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab91e6835bsm215380fac.23.2025.10.01.13.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:30:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Yao Zi <ziyao@disroot.org>, Kongyang Liu <seashell11234455@gmail.com>
Subject: [PATCH] clk: sophgo: Fix a warning about void returns value
Date: Wed,  1 Oct 2025 14:30:57 -0600
Message-ID: <20251001203057.2828531-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The cv1800b_clk_setfield function returns void, but was doing "return
writel(...);" and while seemingly having a void function return a void
function is not a warning, when readl is a macro this problem is shown.
Correct the code to instead simply call writel.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Lukasz Majewski <lukma@denx.de> (maintainer:CLOCK)
Cc: Sean Anderson <seanga2@gmail.com> (maintainer:CLOCK)
Cc: Yao Zi <ziyao@disroot.org>
Cc: Kongyang Liu <seashell11234455@gmail.com>
---
 drivers/clk/sophgo/clk-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sophgo/clk-common.h b/drivers/clk/sophgo/clk-common.h
index a9e83d0d6899..a18673f397c3 100644
--- a/drivers/clk/sophgo/clk-common.h
+++ b/drivers/clk/sophgo/clk-common.h
@@ -70,7 +70,7 @@ cv1800b_clk_setfield(void *base, struct cv1800b_clk_regfield *field, u32 val)
 	u32 new_val = (readl(base + field->offset) & ~mask) |
 		      ((val << field->shift) & mask);
 
-	return writel(new_val, base + field->offset);
+	writel(new_val, base + field->offset);
 }
 
 #endif /* __CLK_SOPHGO_COMMON_H__ */
-- 
2.43.0

