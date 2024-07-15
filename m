Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB26C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E3248881F;
	Mon, 15 Jul 2024 12:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X/DI4Xko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40AA888835; Mon, 15 Jul 2024 12:08:19 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34EC988805
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7527afa23cso487697666b.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038097; x=1721642897; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RHMZ1aGv0AWg6leyUS+oq0I1+1UFtza/U4QEs22fWM8=;
 b=X/DI4Xkokq+dRuGB1jgur1u4qd013KVMTg7McErppAWKOvfa2QvQiaS9PGQjXzT1tw
 uoy6V4GQcrvb4BBX9YAZxm8JWgvgdEuBRgN+oQD7WWmy0rnCgZxi+ih7DC5bSQWYTfGl
 3VxCC7AvA5yA/A3viq7E+lg7jDpxQNCq/SLor0oeN5gSlHYX3r9rISkQXlXpdJqaYI9Q
 TKIXD/AymSWzTNxV7pRxE06TTCVtn8glrGagMKf9ddrsS6heU7QFoZkxxlq6B1oMuU3K
 +CbiteCXB1JCA9xT4i0jhcU8eLbQUWQ/qYjfaFBkpz6KyCJ27Wfs7yy+7vH65n4qWYBn
 8XIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038097; x=1721642897;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RHMZ1aGv0AWg6leyUS+oq0I1+1UFtza/U4QEs22fWM8=;
 b=eJLvmiOnYmuPDDI9tsyl5W+skuH6Rn0ovo7x85Oifqu6+KbYUiC3Jzo1cBd8b9rhcZ
 I979qptQnWQ160U5mB0WjF1vs5E4SroilCO1Yu8uvwoUuGhuZ1WwPAmnVwE9483CKmya
 g8Lg3MbumDHxw7jkjD47bPm0VwLYQU47zaokXfrtkQ/uZRbcXiOt5Bs7igEmZWzdiogb
 V76iVFM/MuvWrZTKdAr+D6DZ2Vk9PUczXV2TtzgTLoZWbUMsBplhWfsSA10KsqMUByYF
 cGXldvf6aZWL8vORCgSBOgSymTMlZONmsBVz0HA744nvxdQYJ2Bqj+zs/mQMI906qE7u
 Lz3g==
X-Gm-Message-State: AOJu0YzjTURDh3bBx4UI9XD2h3gptKkoRKZ0cILSkS2KU8iRwVZp2L1i
 tV118ggPYTOBRLS6pyZ7ZDkqOTq63K73OJn2JgEZ4qQrWdO6aePpABN5WQA6cIc=
X-Google-Smtp-Source: AGHT+IEpt6P+LLt9qzE7fkCYylUV++2PDPSkDidegmo2BuQ2KImbc/lNE6hGS6ftVCyqcjlnLbI8KQ==
X-Received: by 2002:a17:906:d7a2:b0:a6f:af8e:b75d with SMTP id
 a640c23a62f3a-a780b689418mr1373989866b.8.1721038096571; 
 Mon, 15 Jul 2024 03:08:16 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:15 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:05 +0200
Subject: [PATCH v6 06/24] soc: qcom: cmd-db: adjust probe for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-6-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4418;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=M/Dy+drxY6JdtVT4jABYKrj/IbLuNhF6hCcK6DPC5uM=;
 b=owEBbAKT/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUF9gCiqmXpNfh6YwKhXCTs6iLO5NGngPUhO
 IPtVc8xoDCJAjIEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BQAKCRAFgzErGV9k
 tpOHD/j+YzTC2eYhanmq67g7IKXddPGaSicgZHqF46/GVPs8U+bAaEUwMcAw/qjfAblPNZF/cS4
 2uUhJme4nkCaz77x5ofJym3m98jcPptwJMX6MiFIl7VuP+VXtdVkO2p4LVL9Xl3T2BTK3rgpe5j
 1yjGqeTJN8pBCtI1egOfUN4V0vY7638gDeQjcIoJHG0vofQLDlHk3CrLfFxSATEx4jo5kgcP4Pf
 UgqyBvif6jCw4gdG6KquTcJQrvwBEV9GI7wcCf4itx6bJkuTMMoljga8Q4sef6Sf4I17Um3Insx
 JnJE5rLS6j8AP2Yj2INgUTdsSWWHaT0i6mWeK5yeGbT1fvkT421nHJhBlk2EDDNBZ/4jsoWwcAk
 UvHbtx7dLbUeCT/aYAOvDMceQROqnafHMUQM8XtoMor3w37PcSVhUQZZDlgAYHRO7wW5zCQS9yy
 nH1840QC2G9kGOE3sBsYHi6saixMhiECSXLmkV4Ui8TIKQOgd4D8hnnLkiWyL+AO+QxAAmAZJA8
 /7K82WKallnyOHtz+7hZnBt3YxZB9OnN7ggy07iecjfbIofuhxN/5TRnbLEANYXOJWoVgfgacfY
 O3C/efa44wSTyORudHAEli/CJb4aDVMNOU3UNYlHzBZXAPIewk6E6q35h9NXvGEbEjy5CLO48j0
 TLz4vWOxQe/YS
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

Integrate cmd-db into the U-Boot driver model.

This is just a wrapper around an in-memory database, so we just need to
get the address and validate that cmd-db is there.

Since cmd_db_header will be stored in the .data section we can skip
bind if it's already set.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
To: Simon Glass <sjg@chromium.org>
---
 drivers/soc/qcom/cmd-db.c | 72 +++++++++++++++--------------------------------
 include/soc/qcom/cmd-db.h |  3 --
 2 files changed, 23 insertions(+), 52 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 4317310d0bcd..f707aed59adf 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -105,9 +105,9 @@ static bool cmd_db_magic_matches(const struct cmd_db_header *header)
 
 	return memcmp(magic, CMD_DB_MAGIC, ARRAY_SIZE(CMD_DB_MAGIC)) == 0;
 }
 
-static struct cmd_db_header *cmd_db_header;
+static struct cmd_db_header *cmd_db_header __section(".data") = NULL;
 
 static inline const void *rsc_to_entry_header(const struct rsc_hdr *hdr)
 {
 	u16 offset = le16_to_cpu(hdr->header_offset);
@@ -123,24 +123,8 @@ rsc_offset(const struct rsc_hdr *hdr, const struct entry_header *ent)
 
 	return cmd_db_header->data + offset + loffset;
 }
 
-/**
- * cmd_db_ready - Indicates if command DB is available
- *
- * Return: 0 on success, errno otherwise
- */
-int cmd_db_ready(void)
-{
-	if (cmd_db_header == NULL)
-		return -EPROBE_DEFER;
-	else if (!cmd_db_magic_matches(cmd_db_header))
-		return -EINVAL;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(cmd_db_ready);
-
 static int cmd_db_get_header(const char *id, const struct entry_header **eh,
 			     const struct rsc_hdr **rh)
 {
 	const struct rsc_hdr *rsc_hdr;
@@ -194,55 +178,45 @@ u32 cmd_db_read_addr(const char *id)
 	return ret < 0 ? 0 : le32_to_cpu(ent->addr);
 }
 EXPORT_SYMBOL_GPL(cmd_db_read_addr);
 
-static int cmd_db_dev_probe(struct platform_device *pdev)
+int cmd_db_bind(struct udevice *dev)
 {
-	struct reserved_mem *rmem;
-	int ret = 0;
+	void __iomem *base;
+	ofnode node;
 
-	rmem = of_reserved_mem_lookup(pdev->dev.of_node);
-	if (!rmem) {
-		dev_err(&pdev->dev, "failed to acquire memory region\n");
-		return -EINVAL;
-	}
-
-	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WB);
-	if (!cmd_db_header) {
-		ret = -ENOMEM;
-		cmd_db_header = NULL;
-		return ret;
+	if (cmd_db_header)
+		return 0;
+
+	node = dev_ofnode(dev);
+
+	debug("%s(%s)\n", __func__, ofnode_get_name(node));
+
+	base = (void __iomem *)ofnode_get_addr(node);
+	if ((fdt_addr_t)base == FDT_ADDR_T_NONE) {
+		log_err("%s: Failed to read base address\n", __func__);
+		return -ENOENT;
 	}
 
+	cmd_db_header = base;
 	if (!cmd_db_magic_matches(cmd_db_header)) {
-		dev_err(&pdev->dev, "Invalid Command DB Magic\n");
+		log_err("%s: Invalid Command DB Magic\n", __func__);
 		return -EINVAL;
 	}
 
-	device_set_pm_not_required(&pdev->dev);
-
 	return 0;
 }
 
-static const struct of_device_id cmd_db_match_table[] = {
+static const struct udevice_id cmd_db_ids[] = {
 	{ .compatible = "qcom,cmd-db" },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, cmd_db_match_table);
 
-static struct platform_driver cmd_db_dev_driver = {
-	.probe  = cmd_db_dev_probe,
-	.driver = {
-		   .name = "cmd-db",
-		   .of_match_table = cmd_db_match_table,
-		   .suppress_bind_attrs = true,
-	},
+U_BOOT_DRIVER(qcom_cmd_db) = {
+	.name		= "qcom_cmd_db",
+	.id		= UCLASS_MISC,
+	.probe		= cmd_db_bind,
+	.of_match	= cmd_db_ids,
 };
 
-static int __init cmd_db_device_init(void)
-{
-	return platform_driver_register(&cmd_db_dev_driver);
-}
-core_initcall(cmd_db_device_init);
-
 MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Command DB Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
index 753c7923f8e5..1190f2c22cab 100644
--- a/include/soc/qcom/cmd-db.h
+++ b/include/soc/qcom/cmd-db.h
@@ -21,13 +21,10 @@ enum cmd_db_hw_type {
 
 #if IS_ENABLED(CONFIG_QCOM_COMMAND_DB)
 u32 cmd_db_read_addr(const char *resource_id);
 
-int cmd_db_ready(void);
 #else
 static inline u32 cmd_db_read_addr(const char *resource_id)
 { return 0; }
 
-static inline int cmd_db_ready(void)
-{ return -ENODEV; }
 #endif /* CONFIG_QCOM_COMMAND_DB */
 #endif /* __QCOM_COMMAND_DB_H__ */

-- 
2.45.2

