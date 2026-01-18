Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0A9C9832F
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 14:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 741DB8389A;
	Sun, 18 Jan 2026 15:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ar/hp3An";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8BA183956; Sun, 18 Jan 2026 15:56:00 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A45558313B
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 15:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-64baaa754c6so5252426a12.3
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 06:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768748158; x=1769352958;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VVPjRYAdNTUCCylsfyHSbISrRELr4ncnQIVEfeEPAic=;
 b=ar/hp3Andi3ZqxMEB+8Zq6XJIAWobl2x1HNApz26ny0IzryuVODS2AtbSwdM8DuxA4
 oi5JdVXBV5Y7yLcbo5JFqli+AFT83Pp2q/wRnHpOkP6a+3xb5MCuu2XvjZmWoQ4l9sZp
 dzcumOSOZz2PluL8d/V+A6AIejcIUkFM94Nig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768748158; x=1769352958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VVPjRYAdNTUCCylsfyHSbISrRELr4ncnQIVEfeEPAic=;
 b=LNO610SONNJbiW3QFYiXNvO+ioiqHrY4JszPV8FqSv5aySoDc6GCwQeY5K21sZQgwv
 ZNM3h2qxGMPJPZC1955CxwbUn8weJV/jsnuo/mu49skniadq3ss+lBbWDfp2ZE+qHdSv
 dk9PsPrH4YAl1YHsKnuhn45DYczgQWbShJtEKrXDcd3Tto8FnOc7osq2F788G8N/2EbX
 r4QTG+1PeYkgOT93MwPpKNUuYNUfD9jOAK3EiG7Fnlrs3QbDYFh8u0Q1oSXnrORp30B2
 aj9b4+KJPO3sErKxNp2kYr21/BHOaGSCCo9NA5fmEyJSXONnQotQw7p8xk9sv0Fom3j9
 pe0A==
X-Gm-Message-State: AOJu0YwjFrEaFndG57F+NJ8gO8pMfBLJQclNZ2zcr+ajpokGzWagkhyi
 E3Z7ClU/fFLl2QWUlk5unT5nD7ZLpahv3WxRm+Ai41kHWtkqfKalROYK3mI5WUxCQEn/w8Sf071
 1owyv
X-Gm-Gg: AY/fxX4JPesrYcmWzDo2xP1q5rGzNj1VGAyxev5Xvkx29lcD2Am6y+gkbqmfascvxik
 SSSfAKS3DM87wYOukIl+WuxIqMaQJdrYKMI6KmvZcKQKZEhcM0tDS+9M7l8MIZtGvn0rC8XCehT
 IntrDNpUGNV3Mq2K3Ei46P9LOLU9LKY0Qv3oGAAmbxsTOm1aqs4mQlR0NTa48gzExOXO3z31Asq
 zohGAOvlGqc3N+WJzQGD7drYD+yvVxM0p8wdn3VOBui7sRu+6Wq8k0B9CC72z+X/ANvmg4/5f9F
 PO1E/Y1/HhpP+KnJLK9GPAgfONvnoe1345AOQmV0yRuV8r6Cfq2RlawFi9neLZbT2y7unqJS9tB
 cj5g/OCZoOfuKVf6M/ZdJk0opJdON854vNXiK7jBFkTgV/DW2RNpXcCTrZIIhmWyJ84jJoYWoWA
 Yv2xBT6YI+Iq9RUIGYg00c/yEuaV6h0cKYmWfUX29hRmReB4kXNpfqS5i/U4WYTQ8sGDresI0fS
 AtTv7afO5o7up5a7tbC3caFFBF9qRiWfuJ/sZdm1ZxSTFYkSlbLu4vTBnI67pzXOWKE32FGeHQi
 FKmjb4L4Tq4=
X-Received: by 2002:a17:907:3f8a:b0:b87:7e8:e287 with SMTP id
 a640c23a62f3a-b87930086d4mr661659366b.30.1768748157653; 
 Sun, 18 Jan 2026 06:55:57 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795a31322sm854760166b.63.2026.01.18.06.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 06:55:57 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [RESEND PATCH] board: stm32mp2: read boot index from backup register
Date: Sun, 18 Jan 2026 11:48:43 +0100
Message-ID: <20260118104912.1672642-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Following the commit 95b5a7de30f6 (“FWU: STM32MP1: Add support to read
boot index from backup register”), this patch enables reading the boot
index from backup registers on STM32MP2 platforms.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/mach-stm32mp/include/mach/stm32.h |  4 ++++
 board/st/stm32mp2/stm32mp2.c               | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
index 2bf50c755cbd..90f06a052d3f 100644
--- a/arch/arm/mach-stm32mp/include/mach/stm32.h
+++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
@@ -188,8 +188,12 @@ enum forced_boot_mode {
 /* TAMP registers x = 0 to 127 : hardcoded description, waiting NVMEM node in DT */
 #define TAMP_BACKUP_REGISTER(x)		(STM32_TAMP_BASE + 0x100 + 4 * (x))
 
+#define TAMP_FWU_BOOT_INFO_REG		TAMP_BACKUP_REGISTER(48)
 /* TAMP registers zone 3 RIF 1 (RW) at 96*/
 #define TAMP_BOOT_CONTEXT		TAMP_BACKUP_REGISTER(96)
+
+#define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
+#define TAMP_FWU_BOOT_IDX_OFFSET	0
 #endif /* defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
 
 /* offset used for BSEC driver: misc_read and misc_write */
diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
index 7bc7d2a608fd..43bc583378e6 100644
--- a/board/st/stm32mp2/stm32mp2.c
+++ b/board/st/stm32mp2/stm32mp2.c
@@ -188,3 +188,24 @@ void board_quiesce_devices(void)
 {
 	led_boot_off();
 }
+
+#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
+
+#include <fwu.h>
+
+/**
+ * fwu_plat_get_bootidx() - Get the value of the boot index
+ * @boot_idx: Boot index value
+ *
+ * Get the value of the bank(partition) from which the platform
+ * has booted. This value is passed to U-Boot from the earlier
+ * stage bootloader which loads and boots all the relevant
+ * firmware images
+ *
+ */
+void fwu_plat_get_bootidx(uint *boot_idx)
+{
+	*boot_idx = (readl(TAMP_FWU_BOOT_INFO_REG) >>
+		    TAMP_FWU_BOOT_IDX_OFFSET) & TAMP_FWU_BOOT_IDX_MASK;
+}
+#endif /* CONFIG_FWU_MULTI_BANK_UPDATE */
-- 
2.43.0

base-commit: ff498a3c5efb424accc1d825cc45cede2540ca13
branch: stm32mp2-active-index
