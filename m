Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642C2C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23D658865D;
	Tue,  9 Jul 2024 11:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LtZMQ2VP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3442B88630; Tue,  9 Jul 2024 11:34:54 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37905885EE
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7523f0870cso596216766b.3
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517691; x=1721122491; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ysNtmrcmo43hAhCCoz/FE0jfPKDq78wNFUbWN5Xu8ag=;
 b=LtZMQ2VPRStVx4ol1uuLivpsw4mqQjMzv7XsnZlHIC+ZubwW1ZDIq5jOFqpJEeI7lK
 nSmWjphYEDW8LpoUUbzOuGcPnklGn2uY4xetEhhqPcT/PDQ9hLiD61ESaFYCrQYpIpRZ
 buD0dTBIuXmhJ/0ZOgOPSisP1UtLBgcp/CTAdDi4r3ZEr+jwmSmp7OGUAin4/6FCihgv
 fmTHwYfenWYuXcAigGwrQWHdxkZhb3yaBX4KXOaj+MVeRqGDWRQ1k0Af+aGcmU4/7FH2
 fEnupnm1rMGqtcYR3b2nLV66fEOD7P+grBcbFXYVZ7rcCmWIPj3YYl0/4dBq7a0a56q4
 qcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517691; x=1721122491;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ysNtmrcmo43hAhCCoz/FE0jfPKDq78wNFUbWN5Xu8ag=;
 b=ee/Au03EH6c38XiAfMbmGCEucVEmYZRVkpoJG59vCvLuaUku3Jy1QAehVvlOeboIxn
 1w2e85NiBtebzoOVpinGQs9+WpUP/C7eY4b4YBkmqCSDAw0RPwFVX7DHbM4ZAEm9hqhK
 THkxL9JRSTCNzM1KUJgc1u7WVErpWceKInqbdD7iBf/2qZA9jpBFR37YBShMsxhuGXp+
 ssiFM3Ud5ySbcAAJmWB0DT6u2g6elMNxJXAcIlsXn5m0dSpFjHGB9YYhmXwqkHuFcCKX
 9W6WNj+1MB1YzOm5EDe74es9WHvMXvH6IZ0zSfCMsLpTbETiOcb0vicio4JcANjOldb3
 rYvQ==
X-Gm-Message-State: AOJu0Yzici5dWLHzVp5ngB0kHVIhN7jh5Y215tqVzQv2mIN1wJYSzvZ8
 RBGpqp5auVvWN61VpRxjEbi135hcv0eaGtFZ4GrYcuseIsc6q05WUxdm1AlCaDwRhps2DBHUM8e
 U
X-Google-Smtp-Source: AGHT+IE2clFRQRL5o5oJqcv0P0Tt+oeGFWhiEkbFz9Cb3MSXGAEort1uCjHb7pB7U3CSXRrvf2/aYg==
X-Received: by 2002:a17:907:9715:b0:a77:ab40:6d7f with SMTP id
 a640c23a62f3a-a780b6ffdb0mr166786066b.43.1720517690720; 
 Tue, 09 Jul 2024 02:34:50 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:34:50 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 11:34:32 +0200
Subject: [PATCH v4 04/21] soc: qcom: cmd-db: drop unused functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-qcom-rpmh-v4-4-c06d0a26644a@linaro.org>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5730;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=x3kucTvGea2Z87SDsDEQ80m0MUUYqAmW2xPOhE07rN4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQyr63mCDHFXkU4di2QFMCly2ASvWZziDDSz
 12ZubUGoQWJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0EMgAKCRAFgzErGV9k
 tgyMD/9zlnFMzijFzlLetJeKFuU2gAPULaliJaPlaQN6Ws6MpxsaxllplRyGBw8AB1WLVeO2DpY
 tETxjfEXoUCY/CdQGO/uneDQm3lNQhxPJxSDciYSgfBU5amrCiDAU4mxbS8Mth8la0wj4OIcsGn
 pCNQP3334hwlyUg9jJVaK79St382SX2oqR7n7GmxgJD2NbmV36u2isVaxQsL39V8BZUa3OqPVz+
 Ah2St3wdPo3I8YSI1k0qtYd9Ty2HOfVTJMVeC/L1qWI4pxEyxYvyUz+Tkwbun9g1NRM/q6K+tbG
 tFxOy2zTbctuF8DJhcrmQrafSzr7aEhSjAfw7V9PEtVMMyYNw10EPYrEveoywUKndPQHkAgRkdY
 KjgV9jFR54C92xGTYQIdCOYTBZ4aVPZr64B036UyeT6w+T0nYJRQgEbjG1dLTwPfxz31KJx7CnY
 VVKb+zAfl6jG2kya68sReQOfT804TMQDD9bt41bQo0nbWYsVuZ+1FzGQxDMXyGQ3V2XT1tj8Pq1
 PKw7/a/eDohrZSCybRtAs0uF1TV4DgzJNCoD0fHiD8Isv2n2ovhHZoKder8Hj1ds48zL3tHewhG
 56QJxOmaEGbuM1wUfaqaBHvH5zzYzIf68CzbjJwhqXUbRoXLEuiD7qeV79lQpNHk/5MajlwWTBf
 9aSlj3sJvC9MhdQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Due to our simpler rpmh-rsc driver and lack of debugfs, we don't need
quite a few cmd-db functions, just drop them.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/cmd-db.c | 144 ----------------------------------------------
 include/soc/qcom/cmd-db.h |  15 -----
 2 files changed, 159 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 685b6d530136..b6426ac3cafc 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -193,150 +193,8 @@ u32 cmd_db_read_addr(const char *id)
 	return ret < 0 ? 0 : le32_to_cpu(ent->addr);
 }
 EXPORT_SYMBOL_GPL(cmd_db_read_addr);
 
-/**
- * cmd_db_read_aux_data() - Query command db for aux data.
- *
- *  @id: Resource to retrieve AUX Data on
- *  @len: size of data buffer returned
- *
- *  Return: pointer to data on success, error pointer otherwise
- */
-const void *cmd_db_read_aux_data(const char *id, size_t *len)
-{
-	int ret;
-	const struct entry_header *ent;
-	const struct rsc_hdr *rsc_hdr;
-
-	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
-	if (ret)
-		return ERR_PTR(ret);
-
-	if (len)
-		*len = le16_to_cpu(ent->len);
-
-	return rsc_offset(rsc_hdr, ent);
-}
-EXPORT_SYMBOL_GPL(cmd_db_read_aux_data);
-
-/**
- * cmd_db_match_resource_addr() - Compare if both Resource addresses are same
- *
- * @addr1: Resource address to compare
- * @addr2: Resource address to compare
- *
- * Return: true if two addresses refer to the same resource, false otherwise
- */
-bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
-{
-	/*
-	 * Each RPMh VRM accelerator resource has 3 or 4 contiguous 4-byte
-	 * aligned addresses associated with it. Ignore the offset to check
-	 * for VRM requests.
-	 */
-	if (addr1 == addr2)
-		return true;
-	else if (SLAVE_ID(addr1) == CMD_DB_HW_VRM && VRM_ADDR(addr1) == VRM_ADDR(addr2))
-		return true;
-
-	return false;
-}
-EXPORT_SYMBOL_GPL(cmd_db_match_resource_addr);
-
-/**
- * cmd_db_read_slave_id - Get the slave ID for a given resource address
- *
- * @id: Resource id to query the DB for version
- *
- * Return: cmd_db_hw_type enum on success, CMD_DB_HW_INVALID on error
- */
-enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
-{
-	int ret;
-	const struct entry_header *ent;
-	u32 addr;
-
-	ret = cmd_db_get_header(id, &ent, NULL);
-	if (ret < 0)
-		return CMD_DB_HW_INVALID;
-
-	addr = le32_to_cpu(ent->addr);
-	return (addr >> SLAVE_ID_SHIFT) & SLAVE_ID_MASK;
-}
-EXPORT_SYMBOL_GPL(cmd_db_read_slave_id);
-
-#ifdef CONFIG_DEBUG_FS
-static int cmd_db_debugfs_dump(struct seq_file *seq, void *p)
-{
-	int i, j;
-	const struct rsc_hdr *rsc;
-	const struct entry_header *ent;
-	const char *name;
-	u16 len, version;
-	u8 major, minor;
-
-	seq_puts(seq, "Command DB DUMP\n");
-
-	for (i = 0; i < MAX_SLV_ID; i++) {
-		rsc = &cmd_db_header->header[i];
-		if (!rsc->slv_id)
-			break;
-
-		switch (le16_to_cpu(rsc->slv_id)) {
-		case CMD_DB_HW_ARC:
-			name = "ARC";
-			break;
-		case CMD_DB_HW_VRM:
-			name = "VRM";
-			break;
-		case CMD_DB_HW_BCM:
-			name = "BCM";
-			break;
-		default:
-			name = "Unknown";
-			break;
-		}
-
-		version = le16_to_cpu(rsc->version);
-		major = version >> 8;
-		minor = version;
-
-		seq_printf(seq, "Slave %s (v%u.%u)\n", name, major, minor);
-		seq_puts(seq, "-------------------------\n");
-
-		ent = rsc_to_entry_header(rsc);
-		for (j = 0; j < le16_to_cpu(rsc->cnt); j++, ent++) {
-			seq_printf(seq, "0x%05x: %*pEp", le32_to_cpu(ent->addr),
-				   (int)strnlen(ent->id, sizeof(ent->id)), ent->id);
-
-			len = le16_to_cpu(ent->len);
-			if (len) {
-				seq_printf(seq, " [%*ph]",
-					   len, rsc_offset(rsc, ent));
-			}
-			seq_putc(seq, '\n');
-		}
-	}
-
-	return 0;
-}
-
-static int open_cmd_db_debugfs(struct inode *inode, struct file *file)
-{
-	return single_open(file, cmd_db_debugfs_dump, inode->i_private);
-}
-#endif
-
-static const struct file_operations cmd_db_debugfs_ops = {
-#ifdef CONFIG_DEBUG_FS
-	.open = open_cmd_db_debugfs,
-#endif
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
 static int cmd_db_dev_probe(struct platform_device *pdev)
 {
 	struct reserved_mem *rmem;
 	int ret = 0;
@@ -358,10 +216,8 @@ static int cmd_db_dev_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Invalid Command DB Magic\n");
 		return -EINVAL;
 	}
 
-	debugfs_create_file("cmd-db", 0400, NULL, NULL, &cmd_db_debugfs_ops);
-
 	device_set_pm_not_required(&pdev->dev);
 
 	return 0;
 }
diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
index 47a6cab75e63..753c7923f8e5 100644
--- a/include/soc/qcom/cmd-db.h
+++ b/include/soc/qcom/cmd-db.h
@@ -21,28 +21,13 @@ enum cmd_db_hw_type {
 
 #if IS_ENABLED(CONFIG_QCOM_COMMAND_DB)
 u32 cmd_db_read_addr(const char *resource_id);
 
-const void *cmd_db_read_aux_data(const char *resource_id, size_t *len);
-
-bool cmd_db_match_resource_addr(u32 addr1, u32 addr2);
-
-enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id);
-
 int cmd_db_ready(void);
 #else
 static inline u32 cmd_db_read_addr(const char *resource_id)
 { return 0; }
 
-static inline const void *cmd_db_read_aux_data(const char *resource_id, size_t *len)
-{ return ERR_PTR(-ENODEV); }
-
-static inline bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
-{ return false; }
-
-static inline enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id)
-{ return -ENODEV; }
-
 static inline int cmd_db_ready(void)
 { return -ENODEV; }
 #endif /* CONFIG_QCOM_COMMAND_DB */
 #endif /* __QCOM_COMMAND_DB_H__ */

-- 
2.45.2

