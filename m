Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF2DCD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 11:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3343849A4;
	Thu, 18 Jun 2026 13:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MLn4vKyX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E952849AF; Thu, 18 Jun 2026 13:57:04 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E96849A4
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 13:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4624c1409c9so639914f8f.3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 04:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781783822; x=1782388622; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ALU/f8apVnZvFaoIAretE/7dIW6od9lOZW9H7Huxt5Y=;
 b=MLn4vKyXNSx2EJheUHqL+z0PpBGiss9bWBtFkvNBjVqSRelMORW5PsJVFE8yghkdHo
 8GkzkLRFYhB1sgS6xX5RVX97eXfKz9ts/xEdVmRj8DqRNLmoL4P67k+dR87BSV9arnWI
 Bg3ioY+Welx4mswAnnXHjejgg0+TMoO/DTK1Md2u/467vMQCCTq9pOvXfN+r4OppIJXT
 iMSXkcAqDJqDVoYNUNZS+PVV16kwuyCTbAAMosnhdizZFJUcbPUojEzc1Gx/GnbJiLBz
 xMm6rZiL0WerWYSz8I2/rnucgG6O9L+Lhpb5wNbYkGnIxY89nGYTV+E/PQ84n9n/CKAq
 VU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781783822; x=1782388622;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ALU/f8apVnZvFaoIAretE/7dIW6od9lOZW9H7Huxt5Y=;
 b=RyHg4pzHbXgQ9Tho4u30kWNFZ9xUMfXwVrMawkIXkLWEUAIl4wnrmigwxB1rwBvPtK
 aqkZeuOjH0QFoJv3h3QuNWQULd/zLFJlEpf3MVDPgoYOwgHl5gbAfOR8lg4OCm1xPZs4
 SLbB7gFluq4alnQcw5VM2nXMlxmEXSyKuGwTTcqt3US12EkHxZkIg4qRrrFTEG5QCcR+
 kR2+y96o95zL0gN8nnXQE7b9iBGTvSc5UvjgGVcqfxEFvMammxTLpCotLP7xCzpMbwmd
 6EiuEDAu9KStgnQrR6s37+LfyMUkTiA7aSnIgclYXHqa9mwGSlnt1wSQJL6JtlXGSszi
 5p2Q==
X-Gm-Message-State: AOJu0YywljLxbU45z0KwLuHZS2ZxYOpN89nRv8o1gR+8APQe6fw7LCoL
 ofUJHmdekIRNwWX+i8DSCN8cx3bSFoN/etjjYdgwgg3leADKpuWRyVW875teAH0/HnY=
X-Gm-Gg: AfdE7clkk3hpqdW/vvcZOhR3GY6+nb0zSvXBaroXCTY0K5kAjNN/wq6cibjSBDrvSck
 zLjyEuYNCQ2LREzMUEWlgGaS0sql8GLcX/XQb3hvPDgFAWf8ST8tP75QjjrCfOuvogOY1OxjXPe
 0ufAmju8J/rDmHyDIWZ2omDLHSSK0KqCsQXfWQ8q6ALgrjxVd/MN2aSb23Wk9wpK9eRrY0W/p4o
 kxfnXTKU+Sr1arvKJPVFwwyIUfORLkDAN14HH7Eau1iL2nsW8caU1Ads0vHw41vZehDoHY4oDey
 fW824hBMvOgTUI242gwFpT2/GvbkleWH/sqoVAzmII1Pdo81xfJXvg5tPeKyvCdHRqVLifBwHun
 MQZxzmUMY2oY3wAJ6XtJtFcO2IGlqDLuIcBnTfPpUIzFGsTwa9TR8roOVLdEejq10EmZrnv88HO
 tIEXjC1RqXNBphYU65GTWB8q97PL/1z3zF81lGLuCyVi7clhaKLxKsNWI=
X-Received: by 2002:a05:6000:184d:b0:460:18cb:8f9e with SMTP id
 ffacd0b85a97d-4640d8eefe6mr3711969f8f.12.1781783821898; 
 Thu, 18 Jun 2026 04:57:01 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46289c3b3a3sm14448355f8f.30.2026.06.18.04.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:57:00 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 18 Jun 2026 13:56:51 +0200
Subject: [PATCH v3 03/15] Revert "test: smem: add basic smem test"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-modernise-smem-v3-3-472391477988@linaro.org>
References: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
In-Reply-To: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1612;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=SIQuFrrKr0VO+F8PGgzLqc7Y+HzKLgPazgX1e55N1oc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizjuyyMUTkda4P0JZ8vF9ovGWjTOP1RbczPuctzJlSVV
 G6Xii3tKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABMxnMfIsDz/+LWLbn06KxXM
 q/f6lq6rSNS+F/tpjcPCRoUq83fnUxn+O/z6cX3O8qs+uWFrNz1yFNTUWlC4tDlAYWLRtMOvtc3
 7bAA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 test/dm/Makefile |  1 -
 test/dm/smem.c   | 26 --------------------------
 2 files changed, 27 deletions(-)

diff --git a/test/dm/Makefile b/test/dm/Makefile
index d69b0e08d66a..68cd0dac8a73 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -112,9 +112,8 @@ obj-$(CONFIG_SCSI) += scsi.o
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
2.53.0

