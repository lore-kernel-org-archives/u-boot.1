Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE913CD128A
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 02:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D2D787FE0;
	Mon,  1 Apr 2024 04:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S8SZYm+F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D8A487E82; Mon,  1 Apr 2024 01:29:13 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 036DA88081
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 01:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6e50e8dcc72so1796353a34.3
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 16:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711927749; x=1712532549; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PsK+fTNp+6qa/vpUn6UFFQut4WghP7IYBUhG9I5aVWA=;
 b=S8SZYm+F9CIhbhMp6AhN8XXCh/SKIY5m4VlheaJx7160DooXCrTJz7LXCz7EaWZV93
 ogeWIVnGAWX0+MQckJW9q4UpnwnSBheAiYt9vdL0TXk/ZvvvLgrnXH5jh3bCyxBj01kV
 mRmKW5Z2fbp1hRU9QhFS1UEsBXgK0f5zc6s852MoPlsrnnpmHwBX68cKYfxDdBEkrBHp
 hVODWP70EHiEUyrtoGD4ZRHCeY5Q84hp0dnzYEH65K5mysAX3KcsUmx4ubLZUvfzKi/t
 NoiLH1ygxkz9HyOmsuOEL5pK9KiTCSYVxSUQZZGTzlB0fgOppT5MI4BHT4zW1qAo/zbq
 BgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711927749; x=1712532549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PsK+fTNp+6qa/vpUn6UFFQut4WghP7IYBUhG9I5aVWA=;
 b=oRzX/aB9/ZNaJMiNrQwPB0HW1+zV2GRFNnKqGOXpnoI/2vIX+QCHv4IYF0LuBkSghG
 oqFcZhL0c73q+MmvpcVY8ZHHOywoZMW7/Bq0GejnUgdZh5TvUn6hssce6D19KNnEwN9U
 S09bnlXgJbZy2Ct1DWuSN2wXvdOHBKkJxvUfQm7OMIv1Zg/tR9i61hL0Tb00gX3aHkyd
 9lO20W6O/f9vYGylSa8LZtdENjnSemG8cJU2+Fk33FpYYdKeU4yeDBehYlCi9vLSN/O8
 o7Ejj7gERrb/wsRiVKOB9dnqelRz98YqpC8lsf/Id7WJi5aiebxiz9keDGba+Jx1oLxE
 1n3w==
X-Gm-Message-State: AOJu0Yw5JsTfUPM3Zpa1UWh/dbTTbii8wkT11arANaUw7G+Dx9flc4Ds
 RNfpXz7pWatj8BkF/lgSKBBkePceSn1rUWDfaqfaNT1/LwJ5jr6KWjbOfPRdYatQ7g==
X-Google-Smtp-Source: AGHT+IHljINt4R4v/JJ1Ha4uEXdIrZ9FVyhKVadDfTC8PYzyziQ+6E5b1juNjXi1z4tiVB8G2QJQYA==
X-Received: by 2002:a05:6870:8182:b0:22a:828b:57ea with SMTP id
 k2-20020a056870818200b0022a828b57eamr8077478oae.53.1711927749230; 
 Sun, 31 Mar 2024 16:29:09 -0700 (PDT)
Received: from james-x399.localdomain (71-218-245-145.hlrn.qwest.net.
 [71.218.245.145]) by smtp.gmail.com with ESMTPSA id
 it37-20020a05663885a500b00476f1daad44sm2295411jab.54.2024.03.31.16.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 16:29:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 1/1] xilinx: zynq: add FDT_FIXUP_PARTITIONS support
Date: Sun, 31 Mar 2024 17:28:59 -0600
Message-Id: <20240331232859.727769-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Apr 2024 04:34:16 +0200
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

There are situations where we may want to let U-Boot modify the FDT
nand partitions for the kernel, such as when supporting multiple
sizes of NAND chips.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - move partition fixups to board/xilinx/common/board.c
---
 board/xilinx/common/board.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 9641ed307b..20a6f00e45 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -12,6 +12,7 @@
 #include <env.h>
 #include <image.h>
 #include <init.h>
+#include <jffs2/load_kernel.h>
 #include <lmb.h>
 #include <log.h>
 #include <asm/global_data.h>
@@ -20,6 +21,7 @@
 #include <i2c.h>
 #include <linux/sizes.h>
 #include <malloc.h>
+#include <mtd_node.h>
 #include "board.h"
 #include <dm.h>
 #include <i2c_eeprom.h>
@@ -693,6 +695,13 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	u8 buf[MAX_RAND_SIZE];
 	int nodeoffset, ret;
 
+	static const struct node_info nodes[] = {
+		{ "arm,pl353-nand-r2p1", MTD_DEV_TYPE_NAND, },
+	};
+
+	if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFIG_NAND_ZYNQ))
+		fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
+
 	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
 		debug("No RNG device\n");
 		return 0;
-- 
2.34.1

