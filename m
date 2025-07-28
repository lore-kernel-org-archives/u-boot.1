Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D1BC83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 11:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 824B982C87;
	Mon, 28 Jul 2025 13:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DWvrV5uT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3DDC82F14; Mon, 28 Jul 2025 13:25:33 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D71F281E14
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 13:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b7746135acso1953445f8f.2
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 04:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753701930; x=1754306730; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R1UWrQMCjr4/4aOvtmFNgbbeYasvnYjKIXn6jSKhQSk=;
 b=DWvrV5uTtyq+XBXdGHX/Y0+yO3oWnvNSlEkdx2vjLJGnbJP42lQ7mS2wKsMvOp5S+7
 paAj/ZB9fxnHwjhOQNf/Cac9mJqh635ZAdrCqicgTP9NNff3KdWyNXKCD/zQwwIVtLV7
 62tXygncNb0yluEz3jutIE76I+pxdfbLGnu/GS17ZOfyY1jihOrhpdjC80n3gpH7KNWC
 hr13VEOBDZgnfKJCaL6JBbmgAD09uB8e0gSYOU/b+Zb46U26v2WgoKVWddvSEmuMtTUY
 nxtl6VPcgK2BQv0YdJX79tZARRhwW/OfrFv6SY4vwn1vsYC062etaOxImOTvEto97U0b
 caWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753701930; x=1754306730;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R1UWrQMCjr4/4aOvtmFNgbbeYasvnYjKIXn6jSKhQSk=;
 b=RtUxZMDWvxQVpD6QXF9h+8K2hCTTFvTqPub7RKNUw/fxlcb0OU/vnmcQJQxL2imoZD
 0feoTXtDlt+UYRsfB2a8UNsXFtwP23EGtq1d1AjwjMSHMHk4TofgSp346AS+ciihKApn
 AmFVSzPWqZ1+CQqTCa6wW9rBYs5fQL7M1S4d7oR9ppGCULZdqsY+9J75Xj5RYCBD+9+b
 8KYEaAYQaFY/bPsFkiKKFmPrM+jmJUyBeTUKfFCaW6PvYLi3dlkFTvuIDApEuEwZ656L
 eDT8sQv6pIshSvIDLkIZFDVHpCe1/sEOCezP8lL+GtqTghr9YDnCR2p8RMmZNMbPQvK4
 gdIQ==
X-Gm-Message-State: AOJu0Yyvs0IpsSlt9zq83cPIJ/iZf08moQ//dcuY4C2lYwSY4imeExfd
 qhzkd9n5CQEYq/VMAdqS1uoEDsaPO8pKZSw9TYvvRpGZfyANut3lY7YCqITsvd51xOQ=
X-Gm-Gg: ASbGncuzV/4+i0d0CluabQaTabayJsA11xjQ1YLEpTjIkALEjtFBv6mX7FWReuWdZTR
 DpX8tj8f5GH2x8NjK7dgYKMlAjzGOgfcfBDXXGnR3BetMV3SCruhcixiNS+jvPh8GwKW5dAViAg
 WNe7O9Sx29gWRVdch6RU/HNzdHsazOrMJokVyFyvtZMdcv9bkGLhY+ljTPbiLuRvQVrlRqQwoBU
 dHFR04hcmIHWFMi0HXu8ZG3Zpv92wSaCkeGrfkIKUtzZQVUdhtQaJdFfLpzoFZk5YHb8wm2o3er
 kZUB451s44IEU6lZ3MFk6U4xeMwrHNEXiMibzRDRp97x+JPknvxB/7k9Ezgc3kUu+nIrdXfMek6
 dS6c67jlF2FzDMqCBfV1g0HV36Yb8ex+JsssNbIAU7nDH4jGAZdCHFvj6bb43I+AXuByj9tA=
X-Google-Smtp-Source: AGHT+IEmIOvd6E8n9r4yhyNAlJLIlc/H4vr769qlLjDQI51Znzo/x5y9o+Xzm6dcQCU+XwQoHO1RuA==
X-Received: by 2002:a5d:5d88:0:b0:3b6:938:86b7 with SMTP id
 ffacd0b85a97d-3b77663f6ccmr8515975f8f.35.1753701930477; 
 Mon, 28 Jul 2025 04:25:30 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:2df:19e4:8abd:eea3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778eb2aa0sm8643932f8f.8.2025.07.28.04.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 04:25:29 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 28 Jul 2025 12:25:29 +0100
Subject: [PATCH] arm: socfpga: Remove unnecessary for loop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-socfpga_gen5-v1-1-1cf2e209f374@linaro.org>
X-B4-Tracking: v=1; b=H4sIACheh2gC/x2N0QqDMAwAf0XyvIINduJ+ZQyJXax5sEoiIoj/v
 rrH4zjuBGMVNnhVJyjvYrLkAv5RQZwoJ3byLQxYY6hbDM6WOK6J+sQ5uA6Zgo/Ns0MPJRnI2A1
 KOU53NJNtrLdYlUc5/p/357p+d45YWncAAAA=
To: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The for loop in fpgamgr_program_poll_cd will always terminate after a
single pass and so is not necessary. Remove it and all related code and
leave only the code that is effective.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/fpga/socfpga_gen5.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/fpga/socfpga_gen5.c b/drivers/fpga/socfpga_gen5.c
index 9473f057328..964a5cc8789 100644
--- a/drivers/fpga/socfpga_gen5.c
+++ b/drivers/fpga/socfpga_gen5.c
@@ -119,27 +119,14 @@ static int fpgamgr_program_poll_cd(void)
 {
 	const uint32_t mask = FPGAMGRREGS_MON_GPIO_EXT_PORTA_NS_MASK |
 			      FPGAMGRREGS_MON_GPIO_EXT_PORTA_CD_MASK;
-	unsigned long reg, i;
+	unsigned long reg;
 
-	/* (3) wait until full config done */
-	for (i = 0; i < FPGA_TIMEOUT_CNT; i++) {
-		reg = readl(&fpgamgr_regs->gpio_ext_porta);
-
-		/* Config error */
-		if (!(reg & mask)) {
-			printf("FPGA: Configuration error.\n");
-			return -3;
-		}
-
-		/* Config done without error */
-		if (reg & mask)
-			break;
-	}
+	reg = readl(&fpgamgr_regs->gpio_ext_porta);
 
-	/* Timeout happened, return error */
-	if (i == FPGA_TIMEOUT_CNT) {
-		printf("FPGA: Timeout waiting for program.\n");
-		return -4;
+	/* Config error */
+	if (!(reg & mask)) {
+		printf("FPGA: Configuration error.\n");
+		return -3;
 	}
 
 	/* Disable AXI configuration */

---
base-commit: 021783860f7e628f7c4e0c101707cd4250e6d61f
change-id: 20250725-socfpga_gen5-92ea51c46921

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

