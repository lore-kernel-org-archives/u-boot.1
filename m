Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B31C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C65586458;
	Wed, 23 Aug 2023 20:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lv1F8YVm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EBED86440; Wed, 23 Aug 2023 20:48:02 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9536586427
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-792399277bcso106614239f.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692816479; x=1693421279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4f3Vhn/iihXyOJryotNiesUPHAKBa3qICuoBXTcDW3w=;
 b=lv1F8YVmFPGAZKT1rPlVn2AOCB7gjMH4TkrTxfzitgziwcQ6xz1sZvNvNprJKoM+Ld
 Uv/TFlw7MzjkfWO55lmK1db+sT11ZAEN7Iy3gwdT9fT8xjDHNVOAN5UmCO+h6VJgYUmn
 RZ3wA8jA0eoJ7USdQjHsmcSe0qcwtnCOHmCdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692816479; x=1693421279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4f3Vhn/iihXyOJryotNiesUPHAKBa3qICuoBXTcDW3w=;
 b=eTKyGUmn5zvxZxfPRZmOTjUivJH4R7xXg6v3d7sOaaTJwAL12tVSyvCz/zSxs8sdeZ
 mTEmQ8JptxF73xFmGe/yX1FPMUeTEFdtxBh4ZHVGsPnYVXCpnRwJnaVaCPPmNfu1BCIh
 Md2IQmpIdoc4RcJAYVGMRgA6SURs0Pr6ooY4dPiI0cj1d47s51NTgH07dzAgT/bdsT+B
 qWf1gZIMNY18LhVPT79d1FloN+nCXsnFo8qWUtvMksmgxh9a/TVtLvN50PUSXtKdaxqX
 1sxQQVH3MjCc9ACGRlloBCkUwoLnt9tF8nGv41nN4dLZqFWlhwPpCAVAE83TEIJ5a6xM
 +Lzw==
X-Gm-Message-State: AOJu0Yx7+cVgyapUA4UyJ0SZbv66gWcQU4g+PU2XBpQ+hve/MaG0vh9F
 e/AC7VUQ5LL4y6A2blyD6IS68S1GNByPLh7sJjQ=
X-Google-Smtp-Source: AGHT+IFNFR49nWdYEliYHTUHQ7dIrUrigbcackZbqnGQGH2O1SaoPFLM62FaWSSE395QmF3DQuUfxQ==
X-Received: by 2002:a5e:d915:0:b0:787:822:30f1 with SMTP id
 n21-20020a5ed915000000b00787082230f1mr3529715iop.1.1692816479218; 
 Wed, 23 Aug 2023 11:47:59 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a02c054000000b004182f88c368sm4070929jam.67.2023.08.23.11.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 11:47:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 2/8] x86: Add some log categories
Date: Wed, 23 Aug 2023 12:47:35 -0600
Message-ID: <20230823184746.842091-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823184746.842091-1-sjg@chromium.org>
References: <20230823184746.842091-1-sjg@chromium.org>
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

Add some missing log categories to a few files.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/broadwell/sdram.c | 2 ++
 arch/x86/lib/tpl.c             | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/cpu/broadwell/sdram.c b/arch/x86/cpu/broadwell/sdram.c
index f477d513efc..d30ebee021e 100644
--- a/arch/x86/cpu/broadwell/sdram.c
+++ b/arch/x86/cpu/broadwell/sdram.c
@@ -5,6 +5,8 @@
  * From coreboot src/soc/intel/broadwell/romstage/raminit.c
  */
 
+#define LOG_CATEGORY UCLASS_RAM
+
 #include <common.h>
 #include <dm.h>
 #include <init.h>
diff --git a/arch/x86/lib/tpl.c b/arch/x86/lib/tpl.c
index 18b05b2f672..273e9c8e1ca 100644
--- a/arch/x86/lib/tpl.c
+++ b/arch/x86/lib/tpl.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2018 Google, Inc
  */
 
+#define LOG_CATEGORY	LOGC_BOOT
+
 #include <common.h>
 #include <debug_uart.h>
 #include <dm.h>
-- 
2.42.0.rc1.204.g551eb34607-goog

