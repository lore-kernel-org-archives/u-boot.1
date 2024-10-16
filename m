Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A136DD2A555
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 20:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36F8388DE6;
	Wed, 16 Oct 2024 22:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="ZrXnUiJi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92A2088DE1; Wed, 16 Oct 2024 22:17:25 +0200 (CEST)
Received: from smtp-out.freemail.hu (fmfe38.freemail.hu [46.107.16.243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FE2088DE6
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 22:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from localhost.localdomain
 (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4XTMhL3HkqzFmx;
 Wed, 16 Oct 2024 22:17:22 +0200 (CEST)
From: egyszeregy@freemail.hu
To: u-boot@lists.denx.de
Cc: sbabic@denx.de, festevam@gmail.com, otavio@ossystems.com.br,
 Ray Chang <ray.chang@technexion.com>,
 =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH v2] pico-imx7d: Increase ODT resistor value
Date: Wed, 16 Oct 2024 22:15:36 +0200
Message-ID: <20241016201536.2032-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1729109842; 
 s=20181004; d=freemail.hu;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 l=1020; bh=+floIsiXm8WS5GMgA6V37Ck26MP8/xz8yx+kSeGBdYM=;
 b=ZrXnUiJi95XJmOz8kb1E6BaSpBj6m4gPyFGfsZetRYqQgEjUwJhmuzoAUXuGKE/V
 Q53N/bjXgx6MDbjfFcIqHNOIEltXYU5gRYEhtYqiVOWw8wwonKaKLmfOczLEUvv7xTC
 cXrrMBArc8UI2s33xSEuCzudkHX4JWzyFYLvp4kD+byECm7fs75NluFoxTtmbQ2+T5X
 ry5VhTRW2kBPsO6hIPGfK00b9jFQbjpudZ3lwNKukEdfPaTBJ0lEPBz3jSPabGrlITW
 f+j1OoEC5t2+cDO+XenLruWH5tGv4mXmR6ZG44YDkSpASeeQqsxYdVcefoob4UhbMMa
 ksFVmTRAhg==
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

From: Ray Chang <ray.chang@technexion.com>

Increase ODT resistor value from 60 to 120 ohm to improve DRAM stability.

Based on the following commit from TechNexion U-Boot:
https://github.com/TechNexion/u-boot-tn-imx/commit/8a00e57b697c6f7d3d3abcfc552550ac7d8cc96d

Signed-off-by: Ray Chang <ray.chang@technexion.com>
Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
---
 board/technexion/pico-imx7d/spl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/board/technexion/pico-imx7d/spl.c b/board/technexion/pico-imx7d/spl.c
index cb60d3be42..fc97c58ae1 100644
--- a/board/technexion/pico-imx7d/spl.c
+++ b/board/technexion/pico-imx7d/spl.c
@@ -89,11 +89,11 @@ static struct ddr_phy ddr_phy_regs_val = {
 static struct mx7_calibration calib_param = {
 	.num_val	= 5,
 	.values		= {
-		0x0E407304,
-		0x0E447304,
-		0x0E447306,
-		0x0E447304,
-		0x0E447304,
+		0x0E207304,
+		0x0E247304,
+		0x0E247306,
+		0x0E247304,
+		0x0E207304,
 	},
 };
 
-- 
2.47.0.windows.1

