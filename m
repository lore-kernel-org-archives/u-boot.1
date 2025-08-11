Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B04C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 13:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB20583323;
	Mon, 11 Aug 2025 15:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="lDUyCtMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30DAB833F1; Mon, 11 Aug 2025 15:12:38 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B9C8331B
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 325F9C975C; Mon, 11 Aug 2025 15:12:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1754917955; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=pDjdtDTNUqXn6SasgvvZwhcYakyfkgXTO/dOvcEWwWQ=;
 b=lDUyCtMqLq+x2co2PARWY9nC1YrIyw2XngVBgL6Gzs4b7BgW9bw17TEHIe53oRc8AQaXZQ
 DNP4syZ3c8Q2GZYprNQSYuhWwGf6JWJa/umngaBVixJqMKW1lm3ce8gEyrz/dGFmnm3obr
 8NSw0rR9aY0xKu6fg0Vr80ObIQvJYrPZENEQlpVyG2/hMwS3jhufP/DBex7zZUDzVASskU
 zzWlXgcEs6TjXGaVgeZDHnVAsXSiQwmGQ2LigYNA2CTbu9oPBH8jFX88BxBpsr88ULRFsi
 CFTmxqmKpu7+lk3UagHIUZZli+0Zk1I0dI7o+BnucvyD8/MBL3wvltOyJEjBAA==
From: Frieder Schrempf <frieder@fris.de>
To: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, Joy Zou <joy.zou@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH 2/6] pmic: pca9450: Fix enable register for LDO5
Date: Mon, 11 Aug 2025 15:11:58 +0200
Message-ID: <20250811131213.211124-3-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811131213.211124-1-frieder@fris.de>
References: <20250811131213.211124-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The LDO5 regulator has two configuration registers, but only
LDO5CTRL_L contains the bits for enabling/disabling the regulator.

This is equivalent to the following change in Linux:

f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5")

Fixes: 326337fb005f ("pmic: pca9450: Add regulator driver")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/power/regulator/pca9450.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/pca9450.c b/drivers/power/regulator/pca9450.c
index a2a34244723..27db55e688d 100644
--- a/drivers/power/regulator/pca9450.c
+++ b/drivers/power/regulator/pca9450.c
@@ -144,7 +144,7 @@ static struct pca9450_plat pca9450_reg_data[] = {
 	PCA_DATA("LDO4", PCA9450_LDO4CTRL, HW_STATE_CONTROL,
 		 PCA9450_LDO4CTRL, PCA9450_LDO34_MASK,
 		 pca9450_ldo34_vranges),
-	PCA_DATA("LDO5", PCA9450_LDO5CTRL_H, HW_STATE_CONTROL,
+	PCA_DATA("LDO5", PCA9450_LDO5CTRL_L, HW_STATE_CONTROL,
 		 PCA9450_LDO5CTRL_H, PCA9450_LDO5_MASK,
 		 pca9450_ldo5_vranges),
 };
-- 
2.50.1

