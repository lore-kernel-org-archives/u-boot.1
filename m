Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3587DE668BC
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A18E58976E;
	Sun, 24 Nov 2024 20:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ngDVMWBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D9D38956D; Sun, 24 Nov 2024 20:17:52 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 526C489574
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa52edbcb63so256095766b.1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732475870; x=1733080670; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VTBN0T0NznHzWnwiBTAiquqo2zKIhRnGeV9ZDwdMjZQ=;
 b=ngDVMWBrr5vmfJPMhp8AMfD79b3f6g9pstuUaGYWOFW7WivWh2aEUYyuUatsOOKk5H
 5PVtO0yVC16z6cnINZC8B82JXA8cX1F1BsS+6q+Xuj9TKJ4aGzlMksDZ+BzFw/3wQ6EM
 259lL7LbpH/efwvx/McJtodW7qyofn8T151wusbqHaJ+jvumkZ1nreQN+UboE9Rl33Yy
 wMqP19SSHxAvGXN/tLfOeb3CBtTGnF9TWR22aYfJklYBh8wrwzOHrCOL0/wgfZ+hO7ql
 Nk2n4avik+FLx6cxV2etEV909BVGx+13Di2shOlI2Q56smHo2ReFWVq03Pi7UkX+Bw7t
 Qpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475870; x=1733080670;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTBN0T0NznHzWnwiBTAiquqo2zKIhRnGeV9ZDwdMjZQ=;
 b=hm3qXqnXcjp5tqRA/dnYIsrj5Jd+zc/dwmTOWQtiNxkcpXVZiYtVlUlt/o68cc9Ta9
 Kc1y/Cg4nUXrOjM3UN/C2o7FPS6AXiarpLfzOoTTUsHichu3JEwmENhCfeGaR9TuwnFo
 LU+53HmdX9Vei+T02jcNHXG/HYe5q/Du5OhV7Ttf7QwJtMvsHQ9UecjxSvQLyRSFKM5e
 YudXzQn3cPKN8SyHjMS4cVsN7AngW6VYvWYo9N9Cp55HcF83+1/U/hccK3MagulmNO5x
 COE2IhZyscLggtv0fBbTjpMVZYvuS43uJaP0GmES1lrt8q+Id9N46uDOIkLLOi86Z076
 FZ+g==
X-Gm-Message-State: AOJu0Yy5oB/T7lFBzX3aK4f9v7mVwb36TYs32fHyXSvQNVDR0gmMW+jT
 iRw5lw0IXUPXOHEU2u06cPyf/F/fdF/PNgY8mnr48flINSHt2FGWAJdJ00hQTdw=
X-Gm-Gg: ASbGncvbJTAtl1nvl4uszknRpGFCI+HiN//yRb2zyaBv5k49AjWQd3LZulEbvWK9HUc
 c/F/syLrJQGxa7WrTksr9pIW2pzEGNAjD388L5niaEWERZw9z2/5UVTUqLvXe7a4k7lRq/eKsCJ
 bvFlwCAwumWYOiIExqyzcg1Yh+m5AGIT/9SBdGzH3uPFnQvmqyNM6HlTQHm4XodtzNGjAUtQHPm
 Z6eaxjpVwgKwOcNIQJcQd0l8fo0DmPrHTmUn+tUabXcvWYFdlzoc4XjqRIesaCwl6pc
X-Google-Smtp-Source: AGHT+IGQp0gWx+oEoT8J7e/qVja/TBKnvz7auszZ1+dRmGTP9fJQ6llyeeYvhwQROqcDKgu8ga6Ktg==
X-Received: by 2002:a17:906:3194:b0:aa5:27da:104a with SMTP id
 a640c23a62f3a-aa527da111amr904411466b.15.1732475869629; 
 Sun, 24 Nov 2024 11:17:49 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28f848sm371874566b.36.2024.11.24.11.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:17:49 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 20:17:45 +0100
Subject: [PATCH 03/15] Revert "test: smem: add basic smem test"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-modernise-smem-v1-3-b7852c11b67c@linaro.org>
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ScIrVBolsK+rc+s+hhVdbr0CQ2XjXUgWo4F27F8iFlg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTn6hs3SwRnBq+de+2Y21FRkUpFidYptTyfP7zc8X72l
 Ofxz1l/dJSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJNC5hZNhaKsz25nPtgVy7
 jZu9ec3yFS9z/1GNtXj0dqHXSX+Nv28Y/pnWBq+5vWOuW+nqy4dXCzrr1/g2lB0PfR7oUZWkLrv
 uaB0A
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This reverts commit 20e7705764c4e5ea924f1ea54bb36ebbbeffffe7.
---
 test/dm/Makefile |  1 -
 test/dm/smem.c   | 26 --------------------------
 2 files changed, 27 deletions(-)

diff --git a/test/dm/Makefile b/test/dm/Makefile
index bcb52ef1067b..c7511d072716 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -111,9 +111,8 @@ obj-$(CONFIG_SCSI) += scsi.o
 obj-$(CONFIG_DM_SERIAL) += serial.o
 obj-$(CONFIG_DM_SPI_FLASH) += sf.o
 obj-$(CONFIG_SIMPLE_BUS) += simple-bus.o
 obj-$(CONFIG_SIMPLE_PM_BUS) += simple-pm-bus.o
-obj-$(CONFIG_SMEM) += smem.o
 obj-$(CONFIG_SOC_DEVICE) += soc.o
 obj-$(CONFIG_SOUND) += sound.o
 obj-$(CONFIG_DM_SPI) += spi.o
 obj-$(CONFIG_SPMI) += spmi.o
diff --git a/test/dm/smem.c b/test/dm/smem.c
deleted file mode 100644
index 89e74cccc574..000000000000
--- a/test/dm/smem.c
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2018 Ramon Fried <ramon.fried@gmail.com>
- */
-
-#include <dm.h>
-#include <smem.h>
-#include <dm/test.h>
-#include <test/test.h>
-#include <test/ut.h>
-
-/* Basic test of the smem uclass */
-static int dm_test_smem_base(struct unit_test_state *uts)
-{
-	struct udevice *dev;
-	size_t size;
-
-	ut_assertok(uclass_get_device(UCLASS_SMEM, 0, &dev));
-	ut_assertnonnull(dev);
-	ut_assertok(smem_alloc(dev, -1, 0, 16));
-	ut_asserteq(0, smem_get_free_space(dev, -1));
-	ut_assertnull(smem_get(dev, -1, 0, &size));
-
-	return 0;
-}
-DM_TEST(dm_test_smem_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);

-- 
2.47.0

