Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905D6CF258C
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C349983EAB;
	Wed, 19 Nov 2025 10:51:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WF2XxwwF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED8BB83A8C; Wed, 19 Nov 2025 06:14:23 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E473083B95
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Takahiro.Kuwano.infineon.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0BEEB4410F;
 Wed, 19 Nov 2025 05:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3DEDC19424;
 Wed, 19 Nov 2025 05:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763529255;
 bh=xWFEYAd+CuR1AG/L5cVxzXgBRAfbS6kHRbxSq08BD9o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=WF2XxwwFvjgVkFwKlD69QUwvFv5r7N5Uiw68GMM16sdES9sTdOZ5fZ0Ujy65DG4pJ
 xxuiBwvs6+TDPOLV4akT6AyEhfDccVrEatTjjGdhj1oD9RHwwyfA7Djq9BYBO+XY8l
 VRl9Sdf5yrHEAAYI//FAv/zXDS/GCmYo3w4bCCIjimPo1XEbiEPD7h04KyYZEX2PBS
 Qrpj77MfVxHJAVypGWE8luXfSAUqmCMna05Tjk+ehZ5K+8VtgX7HB0DSGE/B3yOoUj
 FcnHOLCtzK7P1CPVWIATqO5R9eF6zEBS7P0uiG2zUNTEQkmK//EFosfEgZQYtrnTHg
 tNEzdnNeSUAvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1AACF2582;
 Wed, 19 Nov 2025 05:14:15 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+Takahiro.Kuwano.infineon.com@kernel.org>
Date: Wed, 19 Nov 2025 14:13:00 +0900
Subject: [PATCH 01/11] spi: zynqmp-gqspi: Set priv->is_parallel in
 child_pre_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-amd-cleanup-v1-1-c555bd85e6e4@infineon.com>
References: <20251119-amd-cleanup-v1-0-c555bd85e6e4@infineon.com>
In-Reply-To: <20251119-amd-cleanup-v1-0-c555bd85e6e4@infineon.com>
To: u-boot@lists.denx.de, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, Vignesh R <vigneshr@ti.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Havish Mutya <havish.mutya@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Daassi Bacem <Bacem.Daassi@infineon.com>, 
 Shinsuke Okada <Shinsuke.Okada@infineon.com>, 
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>, 
 Takahiro Kuwano <tkuw584924@gmail.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763529253; l=1838;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=AqEOg4BZ9g/wU8lhyQ1H3eCgVdFedrYMVSatqvFmKYE=;
 b=3+dOvAz4haA1MrUtN8408QBjL1cQXC6KbuSThy5oWdIgUIcQexZIq95tGrWluM0gKQ192R8yE
 VF3xfGP83pmAi3MpE0gp4WcwXmhaVMhM8NgCFmkWfs7DJbvfED0Rs4r
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=
X-Endpoint-Received: by B4 Relay for Takahiro.Kuwano@infineon.com/20250227
 with auth_id=566
X-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
X-Mailman-Approved-At: Wed, 19 Nov 2025 10:51:00 +0100
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
Reply-To: Takahiro.Kuwano@infineon.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

priv->is_parallel should be set at probe instead of at every exec_op().
It can be set in child_pre_probe() by checking the existence of
parallel-memories property.

Also remove GQSPI_SELECT_LOWER/UPPER_CS flags. They are problematic as
they overwrite SPI_XFER_BEGIN/END defined in spi.h.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/spi/zynqmp_gqspi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index 2a095d0c58e..4a25ee0c459 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -89,9 +89,6 @@
 #define SPI_XFER_ON_LOWER		1
 #define SPI_XFER_ON_UPPER		2
 
-#define GQSPI_SELECT_LOWER_CS          BIT(0)
-#define GQSPI_SELECT_UPPER_CS          BIT(1)
-
 #define GQSPI_DMA_ALIGN			0x4
 #define GQSPI_MAX_BAUD_RATE_VAL		7
 #define GQSPI_DFLT_BAUD_RATE_VAL	2
@@ -439,6 +436,13 @@ static int zynqmp_qspi_child_pre_probe(struct udevice *bus)
 	slave->bytemode = SPI_4BYTE_MODE;
 	priv->max_hz = slave->max_hz;
 
+	/*
+	 * The property has values that represent flash sizes but we just need
+	 * to know the existence of the property here.
+	 */
+	priv->is_parallel = ofnode_read_bool(dev_ofnode(bus),
+					     "parallel-memories");
+
 	return 0;
 }
 
@@ -862,10 +866,6 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 	else
 		priv->u_page = 0;
 
-	if ((slave->flags & GQSPI_SELECT_LOWER_CS) &&
-	    (slave->flags & GQSPI_SELECT_UPPER_CS))
-		priv->is_parallel = true;
-
 	priv->stripe = 0;
 	priv->bus = 0;
 
@@ -889,7 +889,6 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 
 	zynqmp_qspi_chipselect(priv, 0);
 
-	priv->is_parallel = false;
 	slave->flags &= ~SPI_XFER_LOWER;
 
 	return ret;

-- 
2.34.1


