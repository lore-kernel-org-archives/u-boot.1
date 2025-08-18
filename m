Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27D6CA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 13:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 453C7803DF;
	Mon, 18 Aug 2025 15:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="evrHVkso";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A342480548; Mon, 18 Aug 2025 15:20:35 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8657E801BE
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 15:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57IDKPmR3171067;
 Mon, 18 Aug 2025 08:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755523225;
 bh=1IEDpcuyg2wxSHTHD0xAMnBRwGwCoXGOV01YHaRZZUA=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=evrHVkso8Bb50EGTm7qWWPbEqaT+KFG1i7r+1hMwdJ9DrAo/tc2nbIvkX9QmzSadK
 VzKzl62LSuEmHRJ41o/w6lxE+680uHpnp0v2j2+HMrg3ag5ew7GCRmedXZfItFhg/Q
 TykjJWrFy0zsf6rm9HnovrP0HdISgQsTxG341uyo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57IDKPBn3834494
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 18 Aug 2025 08:20:25 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 18
 Aug 2025 08:20:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 18 Aug 2025 08:20:24 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57IDKN5d1072851;
 Mon, 18 Aug 2025 08:20:24 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
Date: Mon, 18 Aug 2025 18:50:18 +0530
Subject: [PATCH v2 1/2] clk: scmi: fix set_parent support when CCF is not
 being used
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250818-b4-scmi-v1-v2-1-e0351c4d839e@ti.com>
References: <20250818-b4-scmi-v1-v2-0-e0351c4d839e@ti.com>
In-Reply-To: <20250818-b4-scmi-v1-v2-0-e0351c4d839e@ti.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom
 Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
CC: <u-boot@lists.denx.de>, Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755523221; l=805;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=yyozV8/oAttMnD863ICAjIa2+dz2mpZLekvsKO+wXh0=;
 b=D83vYse1UPcqUYGs/8GAQibBsbrB0hgFuOJcgziTVdfwuaNuZ/goq1VXrjMBR7jUzEYYRwaCz
 Kvkm3mIfhgsB2nBsenB/cq9UhqIpRPdTBY6KL/rgTYVS+tgXdzL4v7Z
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

When not using Common clock framework(CCF), calls to
scmi_clk_set_parent returns -ENOTSUPP, which should not be the case.
Fix that.

Fixes: 15fdfef6642c ("clk: scmi: check the clock state/parent/rate
control permissions)

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 drivers/clk/clk_scmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 0c9a81cabcc..83ea7bb4286 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -359,7 +359,7 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 	int ret;
 
 	if (!CONFIG_IS_ENABLED(CLK_CCF))
-		return -ENOTSUPP;
+		return __scmi_clk_set_parent(clk, parent);
 
 	ret = clk_get_by_id(clk->id, &c);
 	if (ret)

-- 
2.34.1

