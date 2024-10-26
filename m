Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AE8D10C03
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 20:20:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2D8989066;
	Sat, 26 Oct 2024 22:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wT9vGvIp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="C3X5Rfd4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB19A89072; Sat, 26 Oct 2024 22:18:56 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F1E8902F
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 22:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XbWF82B5jz9sZL;
 Sat, 26 Oct 2024 22:18:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729973916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4FEhnXIhPI/JH9xsKgCzkmspxmEXj0DmDHFxAY+P/o=;
 b=wT9vGvIpHva6rTAXDkZHSsxxgzXumWmwIrRxChXHdCKMPmw1Yt7lCtnFwdAWBIlfKB1A8Y
 bw2/Y73hIbbN53ZnD2g/HGJ7Kq860PSKYHyUVSdFN/peo1iyMxHp4J9zJJza0v+l/J3Ab4
 tSIdpPE6ny8SSznDASc5srL2WFMOgoU6Os3THOAAYCIjw3/cn99iAuRerTETIGVi/kag51
 q9bOWS3uJr0+97dkFnWXdM0lpYMH8CNBpe+Yb5754Qe99fsp7IQqeln+OAhnrrrY58MgVe
 Ut3bOOYKpdyQlyO5+6e3TYQzbTCJ0NvEriqgA3BjDoD+vu0CWm2bGgJvQTtDoA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729973914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4FEhnXIhPI/JH9xsKgCzkmspxmEXj0DmDHFxAY+P/o=;
 b=C3X5Rfd4medtoL+XmhtIziMvKXIy+Vm1ANwvqX9uwxUcuaeCS3USOxTbm0S3ndnF8jlzg7
 OI/zq2xhBUt1A2gZZY1fKCL0g28ByWiaaquCyONNr/SAcjHKg1rSrydMtAbTPP904EAY1A
 V4ZCxKHvwI1A088XjXqYRxqTJBClwdqegVHMZRpvA6Lp7n7yg4NCZcQspTMTCR2/yjCCIS
 KeyK54OMmdCUhosCu/fETzgjcObxBzLltgcXAwBGBWx3SIJrdWopxWFgh+NF1QHkfMUut+
 bFkXuQBtOAJn1WF0vVgEwNobALYfIKsKwX6NOCz5ITG9XMcHyI9za602NGiNyg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Michael Walle <mwalle@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 7/9] mtd: spi-nor: Rewrite rem_bank_len calculation
Date: Sat, 26 Oct 2024 22:16:24 +0200
Message-ID: <20241026201741.171073-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: q4t9qbixywut7r4ominxct4cg6nj4iwt
X-MBO-RS-ID: 826a55ae4cac62fa71b
X-Rspamd-Queue-Id: 4XbWF82B5jz9sZL
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

Rewrite the code to make it clear exactly where the
SNOR_F_HAS_PARALLEL flag leads to *2 and /2 operation
compared to regular code path. No functional change.

Fixes: 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Pratyush Yadav <p.yadav@ti.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 drivers/mtd/spi/spi-nor-core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index e49b7cad023..c1ee466bcc0 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1593,13 +1593,14 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	}
 
 	while (len) {
-		if (nor->flags & SNOR_F_HAS_PARALLEL) {
-			bank = (u32)from / (SZ_16M << 0x01);
-			rem_bank_len = ((SZ_16M << 0x01) * (bank + 1)) - from;
-		} else {
-			bank = (u32)from / SZ_16M;
-			rem_bank_len = (SZ_16M * (bank + 1)) - from;
-		}
+		bank = (u32)from / SZ_16M;
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			bank /= 2;
+
+		rem_bank_len = SZ_16M * (bank + 1);
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			rem_bank_len *= 2;
+		rem_bank_len -= from;
 
 		offset = from;
 
-- 
2.45.2

