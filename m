Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9747CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 21:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 277D48320C;
	Wed, 27 Aug 2025 23:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wmbeCOCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B56283106; Wed, 27 Aug 2025 20:51:07 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64DC2831C2
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 20:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-mcarthur@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57RIoxIW1833160;
 Wed, 27 Aug 2025 13:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756320659;
 bh=aghLHfOHJlhOMSNpAs4eXXd/z88IBXzw6SWejpju/Ec=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=wmbeCOCV2xFj/NSu1Vx5p03Ejo+MWnfmalhtCyt5sbdHe7jmamBWYhsf5bLEnW9p+
 JCw26lnSSiYJ22J6i6kZkdMqEjuCXOJUr8sxlSE7VW6b0prbfivIAXZRJ1f+k4FsaE
 GpMUTJYiI/CHA8mWLj2qpzyCBaK9Umex4NkFbi1M=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57RIowbg2905079
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 27 Aug 2025 13:50:58 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 27
 Aug 2025 13:50:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 27 Aug 2025 13:50:58 -0500
Received: from localhost (uda0499903.dhcp.ti.com [128.247.81.81])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57RIowfP3262716;
 Wed, 27 Aug 2025 13:50:58 -0500
From: Jared McArthur <j-mcarthur@ti.com>
To: <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Jared McArthur
 <j-mcarthur@ti.com>, Tom Rini <trini@konsulko.com>, Neha Malcom Francis
 <n-francis@ti.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 1/2] ufs: Add support for sending UFS attribute requests
Date: Wed, 27 Aug 2025 13:50:55 -0500
Message-ID: <20250827185056.954640-2-j-mcarthur@ti.com>
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

Some UFS attributes must be set before a UFS device is initialized.
Add ufshcd_query_attr and ufshcd_query_attr_retry to send UFS
attribute requests.

Taken from Linux Kernel v6.17 (drivers/ufs/core/ufshcd.c) and ported
to U-Boot.

Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
---
 drivers/ufs/ufs.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 91f6ad3bfef..9e67dd86232 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -1107,6 +1107,101 @@ static int ufshcd_query_flag_retry(struct ufs_hba *hba,
 	return ret;
 }
 
+/**
+ * ufshcd_query_attr - API function for sending attribute requests
+ * @hba: per-adapter instance
+ * @opcode: attribute opcode
+ * @idn: attribute idn to access
+ * @index: index field
+ * @selector: selector field
+ * @attr_val: the attribute value after the query request completes
+ *
+ * Return: 0 for success, non-zero in case of failure.
+ */
+int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
+		      enum attr_idn idn, u8 index, u8 selector, u32 *attr_val)
+{
+	struct ufs_query_req *request = NULL;
+	struct ufs_query_res *response = NULL;
+	int err;
+
+	if (!attr_val) {
+		dev_err(hba->dev,
+			"%s: attribute value required for opcode 0x%x\n",
+			__func__, opcode);
+		return -EINVAL;
+	}
+
+	ufshcd_init_query(hba, &request, &response, opcode, idn, index, selector);
+
+	switch (opcode) {
+	case UPIU_QUERY_OPCODE_WRITE_ATTR:
+		request->query_func = UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST;
+		request->upiu_req.value = cpu_to_be32(*attr_val);
+		break;
+	case UPIU_QUERY_OPCODE_READ_ATTR:
+		request->query_func = UPIU_QUERY_FUNC_STANDARD_READ_REQUEST;
+		break;
+	default:
+		dev_err(hba->dev,
+			"%s: Expected query attr opcode but got = 0x%.2x\n",
+			__func__, opcode);
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = ufshcd_exec_dev_cmd(hba, DEV_CMD_TYPE_QUERY, QUERY_REQ_TIMEOUT);
+
+	if (err) {
+		dev_err(hba->dev,
+			"%s: opcode 0x%.2x for idn %d failed, index %d, err = %d\n",
+			__func__, opcode, idn, index, err);
+		goto out;
+	}
+
+	*attr_val = be32_to_cpu(response->upiu_res.value);
+
+out:
+	return err;
+}
+
+/**
+ * ufshcd_query_attr_retry() - API function for sending query
+ * attribute with retries
+ * @hba: per-adapter instance
+ * @opcode: attribute opcode
+ * @idn: attribute idn to access
+ * @index: index field
+ * @selector: selector field
+ * @attr_val: the attribute value after the query request
+ * completes
+ *
+ * Return: 0 for success, non-zero in case of failure.
+ */
+int ufshcd_query_attr_retry(struct ufs_hba *hba, enum query_opcode opcode,
+			    enum attr_idn idn, u8 index, u8 selector,
+			    u32 *attr_val)
+{
+	int ret = 0;
+	u32 retries;
+
+	for (retries = QUERY_REQ_RETRIES; retries > 0; retries--) {
+		ret = ufshcd_query_attr(hba, opcode, idn, index, selector, attr_val);
+		if (ret)
+			dev_dbg(hba->dev,
+				"%s: failed with error %d, retries %d\n",
+				__func__, ret, retries);
+		else
+			break;
+	}
+
+	if (ret)
+		dev_err(hba->dev,
+			"%s: query attribute, idn %d, failed with error %d after %d retries\n",
+			__func__, idn, ret, QUERY_REQ_RETRIES);
+	return ret;
+}
+
 static int __ufshcd_query_descriptor(struct ufs_hba *hba,
 				     enum query_opcode opcode,
 				     enum desc_idn idn, u8 index, u8 selector,
-- 
2.34.1

