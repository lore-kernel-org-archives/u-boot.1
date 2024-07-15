Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B06C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D24BA88805;
	Mon, 15 Jul 2024 12:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FSDwdlKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43D00887FE; Mon, 15 Jul 2024 12:08:18 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53BDA88815
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a77d85f7fa3so642855666b.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038095; x=1721642895; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EetdYxlnzuo/xnHDci9N39KEjBvIEc/fp8D9uzOBkPE=;
 b=FSDwdlKHQqsT7qifVUo+9sMn3oE7+jAfY+QgE6/tECWsORO5FHbN7US3Z9618JPire
 qlEdKArs6Ba9Ftj9eenAXqiaYMRf/APOULVfHMsqZCfhYT14/L3MeCGwdid7S5R4RKSr
 LPW0iM1gAXvQ+clFr0q7JawdP6EpGCQbOFcX4qTOQqGuqbAhRhaW1DXBJZapsB6G7Zsq
 WbJWmkQ0nZTuYX0ZMt1+FYWPdio+XkrpISKaEDdOBy8Yx2SMaiRNabAsUD0591MW9Oje
 V/LgXkmq7lGADsMynBAx7tWfF0jIRjAs/gF4xneqNlav1L4g5DIxtTk0uMB/8jyjIZZM
 Bt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038095; x=1721642895;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EetdYxlnzuo/xnHDci9N39KEjBvIEc/fp8D9uzOBkPE=;
 b=eIBw0ivdNw8FTzwUhZxK2oXuDHIyhCP/+A9Aw++njEZwoWp3v/YuHHyhYGWq/7RL3g
 gQVU0yufXCH2mnp9l6yR9aGOEdXVl5KIOnwDnVUiDqmt8RdQvw1CoaPeLFfavdqfdN4/
 rUS2ENUugBHzmoUaWpKWwOHVJOu58BvKynENOvWd7ZkiOsyGHu5hrLiNZpjrVBJvY+zk
 r/HxqAw0LKA/+PVYe4fpAPyG34x9aw50cMmjIHfCtEi2Sh+FGF6In3kjbgyrL6grhbgv
 EipbNGr0KqZd5DtrW6r9X6ic3MLaM9j8u7yx9ghRHWaFA+uoInAikZW86YReSPyF3Qe/
 h/YQ==
X-Gm-Message-State: AOJu0Ywv4vRil6Rbi08z3dEWLYMt91QSS8BPyBwqF8VTEo7guIu6sk6B
 0KH+2unTuMz1UWNqYBsbg1rc5KXSwXIxAEI2O+EJxSOwQmz2v+fFgIoPAH7nsSI=
X-Google-Smtp-Source: AGHT+IGbea9nG2MogT8KRVJJyIt2xkh0k6CnnmVm9oHdnAqISxJpDtU9+DGhnchjFYv9s6qvYoaIbA==
X-Received: by 2002:a17:907:7210:b0:a77:ecf0:84e5 with SMTP id
 a640c23a62f3a-a799d339b14mr881523366b.14.1721038094856; 
 Mon, 15 Jul 2024 03:08:14 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:14 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:04 +0200
Subject: [PATCH v6 05/24] soc: qcom: cmd-db: drop unused functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-5-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5776;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=WCVxepS5QQJhuc2cv98lalhlDGnsvsp23vf8bNaYEdc=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUF6wxTVFMSfznc9mZwctdlBnBx2DT7rT0cR
 64q4yoQiUeJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BQAKCRAFgzErGV9k
 ts+sD/4ivU2O7LsmerxTe6Qhsh48RlWsidxOTvwACk5St9RyYSnTgeL60x7hEalLtLvyO1B1vhF
 cdEy0c8iSMAGsmBo2K9j6twNo9IO+D6lcdc2PLm1dQ6LK0sIgnH/OwUL996pNNwb1/l6LCDGPTx
 iLWXRXSSGeO2Nhv/DcV2AMda+xNl7iup2EWeTanA3udYwv3TcecsC8n0VZoPs0zTOrvVbL+UMQV
 /keFIvfLNjk0N369k/Vt+w37Oyc3un8DOcCEbn5NSAK06eCn6ykNSSXg5XtLv8qEWEXlyn5MIf9
 EF/rGMnqiKpvVzprUFEnxWDp8LmCXH0m+mTMecK83x8Y4rx0YASRPTQlMNyGt740T18ZVvRFNLy
 APNdJRgxEbliJpk2JlPJNtJfC4TQZC8wwm2Ua4fj/f3Iy1GN6rjvMnSQeFwrTOCfE4dTJiPSYkT
 dq60n4JqI3r8bi8csoxJPANUEFSX6OwAgzGqh7gS1WrkT54Io0o84brQeNo1/2SE3QK1a+bswpf
 Q8UZvChPHnxCNxlBqRqaAFJpPh73QNQ+AuBNa/MiADB/fChV1HkATsVH4P+8IKGsdebHD3Xitns
 ZQV7BpEfAyP0M5HGz0IRgHrb4amAcpoUM8W+HwUI0u5ThC9Y/6DdTs30vUkwXfSc1/f/A5QR1D0
 O/yUkCdc83j7RyQ==
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

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/cmd-db.c | 144 ----------------------------------------------
 include/soc/qcom/cmd-db.h |  15 -----
 2 files changed, 159 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index b25f3549c18f..4317310d0bcd 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -194,150 +194,8 @@ u32 cmd_db_read_addr(const char *id)
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
@@ -359,10 +217,8 @@ static int cmd_db_dev_probe(struct platform_device *pdev)
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

