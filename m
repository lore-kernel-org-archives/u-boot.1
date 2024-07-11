Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F059AC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1FDE88667;
	Thu, 11 Jul 2024 18:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cy/0cBJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0118B88619; Thu, 11 Jul 2024 18:46:50 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA27B88354
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38027so1276443a12.1
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716407; x=1721321207; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pYwfKN5NE2aQuk9mn1zcl9+5XXOioL0ec6hfCEIU3OI=;
 b=Cy/0cBJ6cwPkxjPZ2uNA7mkyLFbzdUem/YqZM6WkMXPIXH+XCh49geSYJfLAm0B9Wf
 cr7vS1UvJM8oeHB66uXvND345NYke0Yx5ge6luykZNruTo33Ani0xFF5pfqWNvKG9b5O
 Jp2pz4a2SvpRs7/c13DxA2KoS4bhCIc4hE8j5OX4twqy2Gz4AA0P2UQTdXBlge1A8OZV
 KblOrnISPMtjTnfBr4M1YEmmuW2TZ7IoX4g9qSWlcusQ6qC8nkblshr4b9IoYyoBUXaI
 V4aVBOuX+5TLT2m+ntO7H/ArvyUrEkZcrFimoGx61Nzg29xmn2zuPjMKKmvO7xRUeMTt
 RpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716407; x=1721321207;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pYwfKN5NE2aQuk9mn1zcl9+5XXOioL0ec6hfCEIU3OI=;
 b=sXyJmI+QTjTI5uLY/rFxBjfpopqPS2xQqb5QAfKEuySwChgRq4f0PAXrn3zG5dQg0n
 HqSJAlkHKyVfNS4dj6IfTZMV3A4G72dTh4bFweqnGhzvzCXUUI/bB2eBNK5VU1P53x42
 XNvV8R+wARyUeefpHusjUtFW1vrE6YFsrFAWk5mnt7bOYKDeuUPn84hvMLbEaOh7Zl/K
 zj7/PdwrWiLmfydXKyOmnm7T1ZbqJGQZGkbvi+pgpJDCwd0iOGqS+MHc3D/N7DnjsTqK
 +X0WOTvF0nLUpCEPihSdy8bN0WAxrTdGDHKM4epan3H01mYRP2aILZufPQzWGxqWRh+D
 pFGg==
X-Gm-Message-State: AOJu0YwUYw5eYFVdIBiz48qSyLwrjlWGgGmyfLIJ8yLOV/6g3Cr7Vzcz
 2SA4gzN4ctg2OUSH3qku4pjcvNiztZ3TOO5q1FMExY57gX2/IuFVWiHFkA9FBzI=
X-Google-Smtp-Source: AGHT+IHcQEKJJEofCXIEQZlWhK7bibdBHFaeFu81oE07Ki0HknADiJJZrxodH4FfHwgzo7dEDjQuBA==
X-Received: by 2002:a17:906:33c7:b0:a72:af8e:15af with SMTP id
 a640c23a62f3a-a780b8827b2mr616039466b.49.1720716407441; 
 Thu, 11 Jul 2024 09:46:47 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:46:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 11 Jul 2024 18:46:36 +0200
Subject: [PATCH v5 04/23] soc: qcom: cmd-db: drop unused functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-qcom-rpmh-v5-4-fbf04ce6a7e8@linaro.org>
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5776;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Bn9oSjF8oLyGJZ1nQj1givKWJikm2awrQSU6rlXtLR0=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxuzQCoZZA0Roez1QABIfvVNukqMQ0IjPrqP
 JxVA2Um9M6JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMbgAKCRAFgzErGV9k
 tgdcD/4juvq4PpZHnXlxWmBxTP2aWgMjxHvjW0fdzxWi/2UqOai+D2BQ2MK++bs8YR8B5ZvPwug
 t1dyZDBxl7Jzoy6n+5iXbtplUrY7rmk+CMOJgpMjrBASQU6kiApRi0e8tsVxN0MpXELLE8eSYeA
 agkMG3KuHsPkBhXaHZFKUdvniP73ocpbwsL2gvMXWcLkhnlx7o0aUJEGHsbEIClONWb+bf3YQcD
 zzVbvlaL9eA6nSgwz5026/9bEwpXIRwfRJvh4qli55+rzPjyl9Gh9XmCq7NiIj0G8PUzHIZ3NWT
 5MPRr2219abvgc5hKQpBk9K/CZI4QDHgZMAMawsMX/xjpDMPgdwNdyr0XiEwbTQop67Mja4BD7f
 QsONDUf4m4Babr/eSLWnw8XHMFzLv1KawHQCSa527ynvqVwKUojhLvV0Xn8X2wKncSDcA1Kly8O
 9+eAi3ZY9YhS0n62JWBGXE+Gnj3L4f3U5sv/0+XdLp/xWyKKDYNvptilpvELSGITjmLDJK9ZKxQ
 /kiOMGd2yk9w3S1eWm8+xdkAXeUEEFHd0ey/W0wozW7XAprPfMVAYyWGjys7WE8INx96fXI07/g
 KyhVJCRT2zhYc3VoHZEzHQi9jwim6v+WIFYzBCAjpcRii8+pZDvSgZRVCv3L+QnolxYMpirkUcD
 Ps3WeLelUnUXXkQ==
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

