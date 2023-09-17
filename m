Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E69CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5316E86589;
	Sun, 17 Sep 2023 16:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lZtxIJIZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="L9PFgGS2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 488B486611; Sun, 17 Sep 2023 16:09:12 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A89A5864D9
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RpVCn4Ctdz9sZl
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+uKkp/a84g38WUrjWoCj0Y5Suy4l6tVdM36i0FJcCsc=;
 b=lZtxIJIZRNsnHyvQ48sgPd+dglf24Sh5/hv7zKV09USuzsIxl92PQQaSzX/aV7X9mXjMwp
 WA3kW/QXol+t4mNlZteO3rwl0cbkpS2QljB9Ihx8Lgkst7pPTuciVhttTmANhJkwo8ixzt
 SvO98jIeKfqyLmhNTRp837M1Bp+4MnwWpkMHuTzvPMgMS6FufngXgmrqhzny79iJIC6PHC
 RYEw+sRkkY/zYcXfyDOxniRX0r//GzJxrsWGJIAUxzhVbHD8JM0q7T3vriK6FOUuZldxFk
 JzoSyQ2WDjSns9s8uo97ZS2f2qvmCkX+pBfDrQnyaLbB1+4hV+V0xv0WKxopkw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+uKkp/a84g38WUrjWoCj0Y5Suy4l6tVdM36i0FJcCsc=;
 b=L9PFgGS2jTUYqbA66GAZslQKU0u4QKO+UovIK+3AMn2oeiJI1/msE8HCFjUMm4VBgkFnia
 Ni0GbLALDVOcfuQu2dqn0Q3EN3aoEaDSy+r3mgTlOCIiXvwTaUiwO2NEKTpo4ScyNrEueF
 vIH7XvcFaePsSXyTFDtTdRb1VkDYls2yX2Cxi/AqTOyRwYVDfmD9Hb5KlW25gAmF7zysCE
 lhbyvw22hTuvzBfR6i683Y0NO3ZYZnOykVuvGFWP/H2QwxfP9ZNj9sU+MdHaUX2zZ+14IE
 9zGFeH7T2bM/B8AQnZ0SMO/jAjn+NC03OnDKl+UlyBe5CuUijAXjhCWUuLPsDQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 01/18] pinctrl: renesas: Rename R8A7795 H3 PFC tables file
 name to R8A77951
Date: Sun, 17 Sep 2023 16:08:32 +0200
Message-Id: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8unduporku715zuqqu71auagp56rb7yp
X-MBO-RS-ID: 3d52376c649321302cb
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

Rename pfc-r8a7795.c to pfc-r8a77951.c to match the file name with Linux
and to indicate the PFC driver does not support R8A77950 H3 ES1.* .

No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/Makefile                          | 4 ++--
 drivers/pinctrl/renesas/{pfc-r8a7795.c => pfc-r8a77951.c} | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/pinctrl/renesas/{pfc-r8a7795.c => pfc-r8a77951.c} (100%)

diff --git a/drivers/pinctrl/renesas/Makefile b/drivers/pinctrl/renesas/Makefile
index 1a61c39d847..8e59104ecf1 100644
--- a/drivers/pinctrl/renesas/Makefile
+++ b/drivers/pinctrl/renesas/Makefile
@@ -2,13 +2,13 @@ obj-$(CONFIG_PINCTRL_PFC) += pfc.o
 obj-$(CONFIG_PINCTRL_PFC_R8A774A1) += pfc-r8a7796.o
 obj-$(CONFIG_PINCTRL_PFC_R8A774B1) += pfc-r8a77965.o
 obj-$(CONFIG_PINCTRL_PFC_R8A774C0) += pfc-r8a77990.o
-obj-$(CONFIG_PINCTRL_PFC_R8A774E1) += pfc-r8a7795.o
+obj-$(CONFIG_PINCTRL_PFC_R8A774E1) += pfc-r8a77951.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7790) += pfc-r8a7790.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7791) += pfc-r8a7791.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7792) += pfc-r8a7792.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7793) += pfc-r8a7791.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7794) += pfc-r8a7794.o
-obj-$(CONFIG_PINCTRL_PFC_R8A77951) += pfc-r8a7795.o
+obj-$(CONFIG_PINCTRL_PFC_R8A77951) += pfc-r8a77951.o
 obj-$(CONFIG_PINCTRL_PFC_R8A77960) += pfc-r8a7796.o
 obj-$(CONFIG_PINCTRL_PFC_R8A77961) += pfc-r8a7796.o
 obj-$(CONFIG_PINCTRL_PFC_R8A77965) += pfc-r8a77965.o
diff --git a/drivers/pinctrl/renesas/pfc-r8a7795.c b/drivers/pinctrl/renesas/pfc-r8a77951.c
similarity index 100%
rename from drivers/pinctrl/renesas/pfc-r8a7795.c
rename to drivers/pinctrl/renesas/pfc-r8a77951.c
-- 
2.40.1

