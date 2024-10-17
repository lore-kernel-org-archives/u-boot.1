Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B2BD2F7EF
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 06:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9625788F14;
	Thu, 17 Oct 2024 08:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kI5o4U8h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01D6D88ED2; Thu, 17 Oct 2024 08:37:43 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E69388ECE
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 08:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49H6bcKJ025597;
 Thu, 17 Oct 2024 01:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729147058;
 bh=r9RE5QrpkbWniXlZ+AteA0ouB9HztXn4rBYTrzXU6g0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=kI5o4U8hWiOsafjRcGCR90Ph6kVAJ+0oeR1lIu9rn8i1tbepTDd+fgdqpi0Qo3ErZ
 mT9nDqm5zOa0hIOM1LpvnU+JIIfq4JRpAjwQATNNKVSljH2eFW8huPQOVCJV133p1p
 limbut27ZKiRAFsSqC7DVl2CnbiC349jSAQqD/3c=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49H6bctV095285;
 Thu, 17 Oct 2024 01:37:38 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Oct 2024 01:37:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Oct 2024 01:37:38 -0500
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49H6bFOW090460;
 Thu, 17 Oct 2024 01:37:36 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH 3/6] misc: k3_avs: Add k3_check_opp function
Date: Thu, 17 Oct 2024 11:59:10 +0530
Message-ID: <20241017062911.2241167-4-a-limaye@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017062911.2241167-1-a-limaye@ti.com>
References: <20241017062911.2241167-1-a-limaye@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

From: Reid Tonking <reidt@ti.com>

Useful when trying to check if an opp efuse is burned in or not.

k3_avs driver checks opp_ids when probing and overwrites the voltage
values in vd_data for the respective board. This can be called to check
that data and returns 0 if valid.

Signed-off-by: Reid Tonking <reidt@ti.com>
Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 drivers/misc/k3_avs.c | 25 +++++++++++++++++++++++++
 include/k3-avs.h      |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index 9d950d034a5..90cd9dfe7f9 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -192,6 +192,31 @@ static int match_opp(struct vd_data *vd, u32 freq)
 	return -EINVAL;
 }
 
+/**
+ * k3_check_opp: Check for presence of opp efuse
+ * @opp_id: opp id to check if voltage is present
+ *
+ * Checks to see if an opp has voltage. k3_avs probe will populate
+ * votlage data if efuse is present. Returns 0 if data is valid.
+ */
+int k3_check_opp(struct udevice *dev, int vdd_id, int opp_id)
+{
+	struct k3_avs_privdata *priv = dev_get_priv(dev);
+	struct vd_data *vd;
+	int volt;
+
+	vd = get_vd(priv, vdd_id);
+	if (!vd)
+		return -EINVAL;
+
+	volt = vd->opps[opp_id].volt;
+	if (volt)
+		return 0;
+
+	printf("No efuse found for opp_%d\n", opp_id);
+	return -EINVAL;
+}
+
 /**
  * k3_avs_notify_freq: Notify clock rate change towards AVS subsystem
  * @dev_id: Device ID for the clock to be changed
diff --git a/include/k3-avs.h b/include/k3-avs.h
index f6f1031c9cc..41a1da36356 100644
--- a/include/k3-avs.h
+++ b/include/k3-avs.h
@@ -27,5 +27,6 @@
 
 int k3_avs_set_opp(struct udevice *dev, int vdd_id, int opp_id);
 int k3_avs_notify_freq(int dev_id, int clk_id, u32 freq);
+int k3_check_opp(struct udevice *dev, int vdd_id, int opp_id);
 
 #endif
-- 
2.34.1

