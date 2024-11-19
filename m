Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D95DD60D00
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 00:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D365F894AD;
	Tue, 19 Nov 2024 01:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IWJMZWPw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3882894B1; Tue, 19 Nov 2024 01:36:40 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0327A894AC
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 01:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ0aaeO001232;
 Mon, 18 Nov 2024 18:36:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731976596;
 bh=4qeaLLUlkt0WGf1zlg/Q9iX1fy7nf23t0DAQyOk7A0E=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=IWJMZWPwj9wQmu1a2xkhU5KvFihBEKK2WTTgsOYZGzmztVuPf7s8shJGXgyWsmsAq
 CmVSKfPjE5f5pwq5xHZBtcehdAqcrrpWInTgf0GRcj+4ZAd88GVqdKcmuXPg+F2mCa
 zSAN2TkV2vPhLGGEH04vK7+qs9LBy0HghMET9hzc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ0aa2s021943
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Nov 2024 18:36:36 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 18:36:36 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 18:36:35 -0600
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ0aPMW114132;
 Mon, 18 Nov 2024 18:36:33 -0600
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v4 3/5] misc: k3_avs: Check validity of efuse voltage data
Date: Tue, 19 Nov 2024 06:02:57 +0530
Message-ID: <20241119003617.1871183-4-a-limaye@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119003617.1871183-1-a-limaye@ti.com>
References: <20241119003617.1871183-1-a-limaye@ti.com>
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

k3_avs driver checks opp_ids when probing and overwrites the voltage
values in vd_data for the respective board. The new k3_avs_check_opp()
can be called from board files to check the efuse data and returns 0 if
valid.

Also add the same check in k3_avs_program_voltage() to error out if
the efuse data was not valid.

Signed-off-by: Reid Tonking <reidt@ti.com>
Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---

v4:
- Update function name to k3_avs_check_opp and update description
- Link to v3: https://lore.kernel.org/u-boot/20241116071615.839623-4-a-limaye@ti.com/

v3:
- Fix voltage spelling in k3_check_opp() function description. No
  functional change
- Link to v2: https://lore.kernel.org/u-boot/20241023130033.1826413-4-a-limaye@ti.com/

v2:
- Update to also handle invalid efuse voltage reading in
  k3_avs_program_voltage() and reflect the same change in commit msg.
- Link to v1: https://lore.kernel.org/u-boot/20241017062911.2241167-4-a-limaye@ti.com/
---
 drivers/misc/k3_avs.c | 32 ++++++++++++++++++++++++++++++++
 include/k3-avs.h      |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index 9d950d034a5..0774e0a4c9e 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -121,6 +121,11 @@ static int k3_avs_program_voltage(struct k3_avs_privdata *priv,
 	if (!vd->supply)
 		return -ENODEV;
 
+	if (!volt) {
+		dev_err(priv->dev, "No efuse found for opp_%d\n", opp_id);
+		return -EINVAL;
+	}
+
 	vd->opp = opp_id;
 	vd->flags |= VD_FLAG_INIT_DONE;
 
@@ -192,6 +197,33 @@ static int match_opp(struct vd_data *vd, u32 freq)
 	return -EINVAL;
 }
 
+/**
+ * k3_check_opp: Check for presence of opp efuse
+ * @dev: AVS device
+ * @vdd_id: voltage domain ID
+ * @opp_id: opp id to check if voltage is present
+ *
+ * Checks to see if an opp has voltage. k3_avs probe will populate
+ * voltage data if efuse is present. Returns 0 if data is valid.
+ */
+int k3_avs_check_opp(struct udevice *dev, int vdd_id, int opp_id)
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
index f6f1031c9cc..5a973e4ed45 100644
--- a/include/k3-avs.h
+++ b/include/k3-avs.h
@@ -27,5 +27,6 @@
 
 int k3_avs_set_opp(struct udevice *dev, int vdd_id, int opp_id);
 int k3_avs_notify_freq(int dev_id, int clk_id, u32 freq);
+int k3_avs_check_opp(struct udevice *dev, int vdd_id, int opp_id);
 
 #endif
-- 
2.47.0

