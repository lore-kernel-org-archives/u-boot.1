Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90EFE7F14E
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 13:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E170F86E05;
	Wed, 27 Sep 2023 15:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ovD3Jnlw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28DF986D5A; Wed, 27 Sep 2023 15:10:22 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEB9286E03
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 15:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38RDAHrC054698;
 Wed, 27 Sep 2023 08:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695820217;
 bh=RNp+d/8y3HJGwEb3byLGmMqti9UjzQ8oLWd8m0l5LpQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ovD3JnlwtrmxsvbqPwbwVZnpgk7tzRqfhi6a9kFIfOdLzpy1iC1KWfWhJ7ZeMk3Pf
 J1pvQbKYB9RUqRtcHkRZbZOXV+N/xrdfwSniVKy2RMijTVbU3Q5o6WGhFgshONiItl
 RWm0hm5LzrWm+Vs3beXjwuDNKs7LA6ymriiVkbHM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38RDAH8p077302
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Sep 2023 08:10:17 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 08:10:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 08:10:16 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38RD9uKd025731;
 Wed, 27 Sep 2023 08:10:12 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <sinthu.raja@ti.com>, <gadiyar@ti.com>, <a-nandan@ti.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>, <b-kapoor@ti.com>,
 <bb@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 3/6] drivers: firmware: ti_sci: Get SCI revision only if
 TIFS/SYSFW is up
Date: Wed, 27 Sep 2023 18:39:53 +0530
Message-ID: <20230927130956.910988-4-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927130956.910988-1-n-francis@ti.com>
References: <20230927130956.910988-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

When setting up boot media to load the TIFS binary in legacy boot flow
(followed by J721E), get_timer() is called which calls dm_timer_init()
which then gets the tick-timer: mcu_timer0. mcu_timer0 uses k3_clks
(clock controller) and k3_pds (power controller) from the dmsc node that
forces probe of the ti_sci driver of TIFS that hasn't been loaded yet!
Running ti_sci_cmd_get_revision from the probe leads to panic since no
TIFS and board config binaries have been loaded yet. Resolve this by
moving ti_sci_cmd_get_revision to ti_sci_get_handle_from_sysfw as a
common point of invocation for both legacy and combined boot flows.

Before doing this, it is important to go through whether any sync points
exist where revision is needed before ti_sci_get_handle_from_sysfw is
invoked. Going through the code along with boot tests on both flows
ensures that there are none.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Boot logs for affected boot flows (AM65x, AM64x, J721E, J7200, J721S2,
AM62x):
https://gist.github.com/nehamalcom/dcaa32bb9f7f28bf1bb449d153e7b566

 drivers/firmware/ti_sci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 72f572d824..166bd78ca5 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2690,6 +2690,8 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 const
 struct ti_sci_handle *ti_sci_get_handle_from_sysfw(struct udevice *sci_dev)
 {
+	int ret;
+
 	if (!sci_dev)
 		return ERR_PTR(-EINVAL);
 
@@ -2703,6 +2705,11 @@ struct ti_sci_handle *ti_sci_get_handle_from_sysfw(struct udevice *sci_dev)
 	if (!handle)
 		return ERR_PTR(-EINVAL);
 
+	ret = ti_sci_cmd_get_revision(handle);
+
+	if (ret)
+		return ERR_PTR(-EINVAL);
+
 	return handle;
 }
 
@@ -2825,11 +2832,9 @@ static int ti_sci_probe(struct udevice *dev)
 	list_add_tail(&info->list, &ti_sci_list);
 	ti_sci_setup_ops(info);
 
-	ret = ti_sci_cmd_get_revision(&info->handle);
-
 	INIT_LIST_HEAD(&info->dev_list);
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.34.1

