Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630A8C282C6
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 18:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01C4481276;
	Mon,  3 Mar 2025 19:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a78thYzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 674A3811E0; Mon,  3 Mar 2025 19:16:25 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5BD6811C1
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 19:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eichest@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bc0b8520cso8535545e9.1
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 10:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741025782; x=1741630582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dil0LAo04rMhESMYcVYOKsBBCI3zgIK+Cas1/lAoptc=;
 b=a78thYzIKYTxhJMAmHsIMBzU1vT15JvHMSRkOFwT9DOCa6SYvE8ywr60ng5FjxnQF0
 JG0Y7L/wn9xWKK703AsNpmKyFg8Ew5yXjtViq7DksERaVUoGxriHeKoRLQ5dUTAbJWiG
 f75JOGBH6JDp96XG/Rt4cMObCjy0IKu4jLIAJJbHKeHospKv32QFxCBv0WnhivA0NGm2
 W4VkS1xRXv8IP0qZtWvpL1QPu07MpDXMQiP+4PI6HJknZsWNPg2zD5kglXxGV36WI1vF
 ka88o+CXHJ60/XQzyd96Ov5ucWRJa96jG5ZcnAopNNYslUiAbkmjA6lBKaFSr3kOUw5W
 vvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741025782; x=1741630582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dil0LAo04rMhESMYcVYOKsBBCI3zgIK+Cas1/lAoptc=;
 b=Q0AgP86eFIvhY1tYLP/BJuVocmIwE6wqnAF+nzkxKF5k+nZdUtVkcVCKcLDqSr6/Tc
 XlrDkTOlIth1Llp99nd75p+1by+oOVxWCNIFCneUANvdWiHNDwu1mgL5wDp3cl6Qr3Jr
 s7w1AYvsf8zZG+qCqJgDT3LrL6whzM4Zj5J3FU6aAB2poTb5EBlEeFGyOYCe0dXx2Qt7
 OvRET7BUhbCRmXcaA6SjII+aT1T/M6a5LJfhw+22bRlYqfdOIVucoc1cjiVBcmE1MUDA
 Ccg/SXwGBZV9kGwHsvfvE0RIeDXYaWWHridstPE/5e+ynmlLXBH+L4qzKwhgfNSEpz8I
 X4DQ==
X-Gm-Message-State: AOJu0Yw3pVOrmZJoQv1tU+87sVcY49l6O/zM09tPmEVp4eU2MpXMT/qS
 BH5CxPsPnOOQq9SmdYH8iGBoIPr97PJEpFv/a8ECDiwXss7kiDhL
X-Gm-Gg: ASbGncs6sZjde0dR6jAr8KML0yj41RRUzp70HBS1VCLqRnIEQ0kYnVJOus6MC507F3T
 mTp5xG5TiQ1LNTgrhjrytQq+nQGV4RX7NmL5wWhLLcoZDRLNxPmLoZzRC4ynR7Q4D+VDa+GYqPp
 f8/tGYeElQsmwjxBWXvTfdov9nSahMPl+CwMaZrzj4WH2KcwuwhLp0hM9u6CSor8Nwinfr09XpO
 J/lDXrmU5IsyHbL1w4BPPqln1RCLzxHZf6C6gctMFbJSVzBzWldQl4jYetuIYqfVyBpVzrTwoad
 egKTNemBDAHmdNlnm7cJMCyBb4r8IElxjNDlDvK6gEnwv+ytHZtb/0Nr8Exn
X-Google-Smtp-Source: AGHT+IE+X/8Gy//2Y3od8puoDKuyC227V23DsfBKRNYOuS7/BXifzUG5RUQvR/lWGXw/Jm1DkuftlQ==
X-Received: by 2002:a05:600c:4f0c:b0:439:91dd:cf9c with SMTP id
 5b1f17b1804b1-43ba66e1f3amr122545375e9.10.1741025782047; 
 Mon, 03 Mar 2025 10:16:22 -0800 (PST)
Received: from eichest-laptop.toradex.int
 ([2a02:168:af72:0:4dab:10cc:7f02:7565])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc24a51bfsm43282745e9.10.2025.03.03.10.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 10:16:21 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, trini@konsulko.com, n-francis@ti.com,
 s-k6@ti.com, w.egorov@phytec.de, emanuele.ghidoli@toradex.com
Cc: u-boot@lists.denx.de, Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1] board: verdin-am62: fix missing memory fixup call
Date: Mon,  3 Mar 2025 19:16:03 +0100
Message-ID: <20250303181618.41802-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 03 Mar 2025 19:44:08 +0100
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The commit bc07851897bd ("board: ti: Pull redundant DDR functions to a
common location and Fixup DDR size when ECC is enabled") broke DRAM
support for the Verdin AM62. This was partially fixed with commit
3f866c47b582 ("board: verdin-am62: add dram_init_banksize"). However,
because fixup_memory_node was not called, the Linux kernel was started
with the wrong memory size on modules with less memory available. This
resulted in boot failures. Fix this issue by calling fixup_memory_node
in the board file.

spl_perform_fixups will be called in the SPL and now sets the correct
memory size in the device tree of U-Boot by calling fixup_memory_node.
U-Boot will then adjust the memory sizes of Linux during bootm/booti in
fdt_fixup_memory_banks. This chain ensures that U-Boot and Linux only
use RAM that is actually available.

Fixes: 3f866c47b582 ("board: verdin-am62: add dram_init_banksize")
Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to a common location and Fixup DDR size when ECC is enabled")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 board/toradex/verdin-am62/verdin-am62.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index b80b39b6767..a1c471111a0 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -15,6 +15,7 @@
 #include <init.h>
 #include <k3-ddrss.h>
 #include <spl.h>
+#include <asm/arch/k3-ddr.h>
 
 #include "../common/tdx-cfg-block.h"
 
@@ -43,6 +44,9 @@ int dram_init_banksize(void)
 	if (ret)
 		printf("Error setting up memory banksize. %d\n", ret);
 
+	/* Use the detected RAM size, we only support 1 bank right now. */
+	gd->bd->bi_dram[0].size = gd->ram_size;
+
 	return ret;
 }
 
@@ -108,6 +112,13 @@ int board_late_init(void)
 #define CORE_VOLTAGE			0x80000000
 #define MCU_CTRL_LFXOSC_32K_BYPASS_VAL	BIT(4)
 
+#if IS_ENABLED(CONFIG_XPL_BUILD)
+void spl_perform_fixups(struct spl_image_info *spl_image)
+{
+	fixup_memory_node(spl_image);
+}
+#endif
+
 #ifdef CONFIG_SPL_BOARD_INIT
 void spl_board_init(void)
 {
-- 
2.45.2

