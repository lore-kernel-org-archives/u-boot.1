Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72662CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 21:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE7CA831D3;
	Wed, 27 Aug 2025 23:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RgWhxCQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F867831EA; Wed, 27 Aug 2025 20:51:05 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 566A483106
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 20:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-mcarthur@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57RIox4V1833164;
 Wed, 27 Aug 2025 13:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756320659;
 bh=WfGQpNrDoOpm1FezFUsx8SPG9+TJ6DJPC7HJ0P0i8N4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RgWhxCQuWphfpaGTqhGBzj6b3QPMbxgxv3SUO9gabYLd5fml0+evriOKnM7a0pEsr
 Y705bMzTcAu0d5gt9jhhv/3LviSfCpne5/VbFOzGPR64RJrW263NiDQw/zJ3juAdkI
 6cJ1eRFohv5kk2/e+5hr4cURrc0lU4/J2ciwr/uk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57RIoxFY2905082
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 27 Aug 2025 13:50:59 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 27
 Aug 2025 13:50:58 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 27 Aug 2025 13:50:58 -0500
Received: from localhost (uda0499903.dhcp.ti.com [128.247.81.81])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57RIowpP3538450;
 Wed, 27 Aug 2025 13:50:58 -0500
From: Jared McArthur <j-mcarthur@ti.com>
To: <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Jared McArthur
 <j-mcarthur@ti.com>, Tom Rini <trini@konsulko.com>, Neha Malcom Francis
 <n-francis@ti.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 2/2] ufs: Add bRefClkFreq attribute setting
Date: Wed, 27 Aug 2025 13:50:56 -0500
Message-ID: <20250827185056.954640-3-j-mcarthur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827185056.954640-1-j-mcarthur@ti.com>
References: <20250827185056.954640-1-j-mcarthur@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 27 Aug 2025 23:55:07 +0200
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

A UFS device needs its bRefClkFreq attribute set to the correct value
before switching to high speed. If bRefClkFreq is set to the wrong
value, all transactions after the power mode change will fail.

The bRefClkFreq depends on the host controller and the device.
Query the device's current bRefClkFreq and compare with the ref_clk
specified in the device-tree. If the two differ, set the bRefClkFreq
to the device-tree's ref_clk frequency.

Taken from Linux kernel v6.17 (drivers/ufs/core/ufshcd.c and
include/ufs/ufs.h) and ported to U-Boot.

This patch depends on the previous patch: "ufs: Add support for
sending UFS attribute requests"

Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
---
 drivers/ufs/ufs.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs.h | 10 ++++++
 2 files changed, 99 insertions(+)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 9e67dd86232..4bffbf87749 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -10,6 +10,7 @@
 
 #include <bouncebuf.h>
 #include <charset.h>
+#include <clk.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/device_compat.h>
@@ -1773,6 +1774,92 @@ out:
 	return err;
 }
 
+struct ufs_ref_clk {
+	unsigned long freq_hz;
+	enum ufs_ref_clk_freq val;
+};
+
+static const struct ufs_ref_clk ufs_ref_clk_freqs[] = {
+	{19200000, REF_CLK_FREQ_19_2_MHZ},
+	{26000000, REF_CLK_FREQ_26_MHZ},
+	{38400000, REF_CLK_FREQ_38_4_MHZ},
+	{52000000, REF_CLK_FREQ_52_MHZ},
+	{0, REF_CLK_FREQ_INVAL},
+};
+
+static enum ufs_ref_clk_freq
+ufs_get_bref_clk_from_hz(unsigned long freq)
+{
+	int i;
+
+	for (i = 0; ufs_ref_clk_freqs[i].freq_hz; i++)
+		if (ufs_ref_clk_freqs[i].freq_hz == freq)
+			return ufs_ref_clk_freqs[i].val;
+
+	return REF_CLK_FREQ_INVAL;
+}
+
+void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba, struct clk *refclk)
+{
+	unsigned long freq;
+
+	freq = clk_get_rate(refclk);
+
+	hba->dev_ref_clk_freq =
+		ufs_get_bref_clk_from_hz(freq);
+
+	if (hba->dev_ref_clk_freq == REF_CLK_FREQ_INVAL)
+		dev_err(hba->dev,
+			"invalid ref_clk setting = %ld\n", freq);
+}
+
+static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
+{
+	int err;
+	struct clk *ref_clk;
+	u32 host_ref_clk_freq;
+	u32 dev_ref_clk_freq;
+
+	/* get ref_clk */
+	ref_clk = devm_clk_get(hba->dev, "ref_clk");
+	if (IS_ERR((const void *)ref_clk)) {
+		err = PTR_ERR(ref_clk);
+		goto out;
+	}
+
+	ufshcd_parse_dev_ref_clk_freq(hba, ref_clk);
+	host_ref_clk_freq = hba->dev_ref_clk_freq;
+
+	if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
+		goto out;
+
+	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+				      QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &dev_ref_clk_freq);
+
+	if (err) {
+		dev_err(hba->dev, "failed reading bRefClkFreq. err = %d\n", err);
+		goto out;
+	}
+
+	if (dev_ref_clk_freq == host_ref_clk_freq)
+		goto out; /* nothing to update */
+
+	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+				      QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &host_ref_clk_freq);
+
+	if (err) {
+		dev_err(hba->dev, "bRefClkFreq setting to %lu Hz failed\n",
+			ufs_ref_clk_freqs[host_ref_clk_freq].freq_hz);
+		goto out;
+	}
+
+	dev_dbg(hba->dev, "bRefClkFreq setting to %lu Hz succeeded\n",
+		ufs_ref_clk_freqs[host_ref_clk_freq].freq_hz);
+
+out:
+	return err;
+}
+
 /**
  * ufshcd_get_max_pwr_mode - reads the max power mode negotiated with device
  */
@@ -2000,6 +2087,8 @@ static int ufs_start(struct ufs_hba *hba)
 		return ret;
 	}
 
+	ufshcd_set_dev_ref_clk(hba);
+
 	if (ufshcd_get_max_pwr_mode(hba)) {
 		dev_err(hba->dev,
 			"%s: Failed getting max supported power mode\n",
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 53137fae3a8..def39d4ad24 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -172,6 +172,15 @@ enum query_opcode {
 	UPIU_QUERY_OPCODE_TOGGLE_FLAG	= 0x8,
 };
 
+/* bRefClkFreq attribute values */
+enum ufs_ref_clk_freq {
+	REF_CLK_FREQ_19_2_MHZ	= 0,
+	REF_CLK_FREQ_26_MHZ	= 1,
+	REF_CLK_FREQ_38_4_MHZ	= 2,
+	REF_CLK_FREQ_52_MHZ	= 3,
+	REF_CLK_FREQ_INVAL	= -1,
+};
+
 /* Query response result code */
 enum {
 	QUERY_RESULT_SUCCESS                    = 0x00,
@@ -684,6 +693,7 @@ struct ufs_hba {
 	u32			capabilities;
 	u32			version;
 	u32			intr_mask;
+	enum ufs_ref_clk_freq dev_ref_clk_freq;
 	enum ufshcd_quirks	quirks;
 
 	/* Virtual memory reference */
-- 
2.34.1

