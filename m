Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C0BC54E4A
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA95488008;
	Wed,  6 Mar 2024 14:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5A8A86FB2; Wed,  6 Mar 2024 14:40:15 +0100 (CET)
Received: from esa1.ltts.com (unknown [118.185.121.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF877877B1
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:40:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=ltts.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhargav.r@ltts.com
IronPort-SDR: BBGMi3kDY4rTeI/hCakulDZB0bRiHXt3HiiK2FRvmaDRFGwooLlnLoUVCWzMkDG+SCH0Sky0Wx
 41BMQeJvYbwQ==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
 by esa1.ltts.com with ESMTP; 06 Mar 2024 19:10:01 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: u-boot@lists.denx.de
Cc: jh80.chung@samsung.com, sjg@chromium.org, bhargav.r@ltts.com,
 m.nirmaladevi@ltts.com, trini@konsulko.com, d-gole@ti.com,
 dan.carpenter@linaro.org
Subject: [PATCH v2 2/5] power: pmic: tps65941: Add TI TPS65224 PMIC
Date: Wed,  6 Mar 2024 19:09:44 +0530
Message-Id: <20240306133947.160354-3-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240306133947.160354-1-bhargav.r@ltts.com>
References: <20240306133947.160354-1-bhargav.r@ltts.com>
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

Adds compatible and data field values of TPS65224 driver in
TPS65941 PMIC driver.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 drivers/power/pmic/tps65941.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/pmic/tps65941.c b/drivers/power/pmic/tps65941.c
index 727b42747a..ef63eb733a 100644
--- a/drivers/power/pmic/tps65941.c
+++ b/drivers/power/pmic/tps65941.c
@@ -75,6 +75,7 @@ static const struct udevice_id tps65941_ids[] = {
 	{ .compatible = "ti,tps659412", .data = TPS659411 },
 	{ .compatible = "ti,tps659413", .data = TPS659413 },
 	{ .compatible = "ti,lp876441",  .data =  LP876441 },
+	{ .compatible = "ti,tps65224",  .data =  TPS65224 },
 	{ }
 };
 
-- 
2.25.1

