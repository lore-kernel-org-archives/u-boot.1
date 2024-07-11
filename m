Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB55C3DA45
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 981F788381;
	Thu, 11 Jul 2024 18:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ORR5X+Ec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B0687E50; Thu, 11 Jul 2024 18:46:51 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDCE28831F
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38028so1548985a12.0
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716408; x=1721321208; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5qeJ8BysI0/Pahn1Uw5BhR2zz7tA0LWqvnOZim52mjo=;
 b=ORR5X+Ecs8sMNq4uPXu+4vpg4qGvfeC+p42+lgr56XTHE3ZhnAGD4yBRXIIObcPSSp
 6E63+anS9PqKRqyts0BwVroXZvoq+u6nJzF8ClO/c3APrsSre0V/AuDK1uhXYudTC8ls
 WL6CzDH9hxnblVzMpbNBrxAMfw6FZeKFTPzEM29qfnQqvuv4D35RcyJf6GmwKBkcNxCT
 dm9Tfwh7UBn3KnD+BA7Cc+z7VR2u2LtNhf+ICD2KT2E0m7WfxnDvLW/a8gBE4Kx4gitl
 NplHllaTjBh2KY2y1obRFmjEgMdhXqIcbUDcnfwbGHkbJ/F3ER90UcsJylKIFqfmtTBe
 5hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716408; x=1721321208;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5qeJ8BysI0/Pahn1Uw5BhR2zz7tA0LWqvnOZim52mjo=;
 b=TwunuzxsBgWc0THuTlEf6pkZzki3umVUmMaYOpY+cHqnUvGPImB+2gm/vDkuv1PjhJ
 OjxpMvfN5bNOqbjeC/p6rLKYrFgs+XsktgWYfHXcF6ejsnOf/HPjI9rQVmHH7I4CE0mm
 cnxjao7KsDIgYiaHt8bEo8OHUEwtCsOtUFcNr52+45qVQ0u/TCLukOSt4AynDP/EgG+z
 3nqJc5mWUVtreZELdGH3JsTK8SpNVXMltYzgR2fjdGkLGdSkdWfeKYy8/wHohLptDS7F
 mT4FmNg4mKPb6QQY4o8m9TRr59+XRxQjDPTg5Rb4IdbgTH4I8rMr2qf0pFOP+NUaYHUA
 LlvQ==
X-Gm-Message-State: AOJu0Yxze1C4cFQQnl2FlNCtgGj0XpsZLs27/b4T9R2X/YQfNblbnCfq
 cWtKC14HTwi8ejHgPp+1Zus01OkasbT+c7VhrsvadezXoP9ZHWe03eLnWtKiwVo=
X-Google-Smtp-Source: AGHT+IGgZ+I5kAu7HVD/uK2cF5ojhQGtFGeQkE3xXWIcPwyio+xQxlVe6mfyAKsxNBMg1YK37d7MTg==
X-Received: by 2002:a17:906:3506:b0:a77:abe8:88d3 with SMTP id
 a640c23a62f3a-a780b6b2fb8mr534134766b.30.1720716408442; 
 Thu, 11 Jul 2024 09:46:48 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:46:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 11 Jul 2024 18:46:37 +0200
Subject: [PATCH v5 05/23] soc: qcom: cmd-db: replace cmd_db_ready() with
 cmd_db_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-qcom-rpmh-v5-5-fbf04ce6a7e8@linaro.org>
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4057;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=YFspOhizl3v+cxK3yKrC0FAQKKJd57kSSBmJYy8ACYY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxuAzNucaiXm5dTVgcoyKDcy9P3uSOq5yyJt
 PMJjGe+7tKJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMbgAKCRAFgzErGV9k
 tme3EACZtM+o4810hQU5sKuM8Dx0KqOouiIM8vgfg08bSLhJ0WdpqUzmTuomGrmc+7gGqAnIED0
 PFe4VQ1tTt/fX9FhvMMi1Gn2pE/8TLVomJ2aZdoCNDONuN/K5u8bPglo+730icUn5t7ou7EwAGv
 /UV5KyzzwGIZwkaNrYwBem+CbJ7uAfvH5COSyw5z0uEEUwj7FGEtpuLoamfoxmuyAp1UyHACWFa
 x/V8DhPtW4Sv2lZ01rRhZCVV3Pkqh8MGMXVmQn9JOQ84yHuEDPXApC6Ks2/x+heVlt4hvGKrICF
 5VsvjwkNRsl7JU/Siq7JJG9/3PVnnwOJ9TOWhg77FIPE+XqFLUqWOWD8qYOd6kR1x6M2xjdVf55
 45ViIGJD89u4DONAYSOqgy4EytyFhBg8wnEpEO2k5zgISkpEKAEoPzOiJJc6E/xarnFUvlibEy+
 Ute0uC36CVlM9FgKAQuu5lb1iGkH71/XDbwOCsphM+9h2UrIFY8in7i/XPriGIQKYsRZu2V0qhG
 OA+d57RWlc6Ab8CmIROkloKhIdl6cTp9P7y6ysA5UGeeBO7HuK+AcMaUMrPwCSGDDFCrvm1u2bm
 VDKk+Qt/vGAg+hY9GfNwX5TaU+9sbU9p18rjprVhzFUdtBity1WgcOcJulwoydXGWQ8vvHXxZuU
 aU6LCStN11cIAQw==
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

Using the driver model for cmd-db is fine, but it's unnecessary
complexity which we can just avoid in U-Boot. Instead let's just have a
function to initialize it and call said function when initializing rpmh.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/cmd-db.c | 74 ++++++++++++++---------------------------------
 include/soc/qcom/cmd-db.h |  4 +--
 2 files changed, 24 insertions(+), 54 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index b6426ac3cafc..4d3fd4db8852 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -122,24 +122,8 @@ rsc_offset(const struct rsc_hdr *hdr, const struct entry_header *ent)
 
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
@@ -193,55 +177,41 @@ u32 cmd_db_read_addr(const char *id)
 	return ret < 0 ? 0 : le32_to_cpu(ent->addr);
 }
 EXPORT_SYMBOL_GPL(cmd_db_read_addr);
 
-static int cmd_db_dev_probe(struct platform_device *pdev)
+int cmd_db_init(void)
 {
-	struct reserved_mem *rmem;
-	int ret = 0;
+	void __iomem *base;
+	ofnode rmem, node;
 
-	rmem = of_reserved_mem_lookup(pdev->dev.of_node);
-	if (!rmem) {
-		dev_err(&pdev->dev, "failed to acquire memory region\n");
-		return -EINVAL;
+	if (cmd_db_header)
+		return 0;
+
+	rmem = ofnode_path("/reserved-memory");
+	ofnode_for_each_subnode(node, rmem) {
+		if (ofnode_device_is_compatible(node, "qcom,cmd-db"))
+			goto found;
 	}
 
-	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WB);
-	if (!cmd_db_header) {
-		ret = -ENOMEM;
-		cmd_db_header = NULL;
-		return ret;
+	log_err("%s: Failed to find cmd-db node\n", __func__);
+	return -ENOENT;
+found:
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
-
-static const struct of_device_id cmd_db_match_table[] = {
-	{ .compatible = "qcom,cmd-db" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, cmd_db_match_table);
-
-static struct platform_driver cmd_db_dev_driver = {
-	.probe  = cmd_db_dev_probe,
-	.driver = {
-		   .name = "cmd-db",
-		   .of_match_table = cmd_db_match_table,
-		   .suppress_bind_attrs = true,
-	},
-};
-
-static int __init cmd_db_device_init(void)
-{
-	return platform_driver_register(&cmd_db_dev_driver);
-}
-core_initcall(cmd_db_device_init);
+EXPORT_SYMBOL(cmd_db_init);
 
 MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Command DB Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
index 753c7923f8e5..535164cc7fb0 100644
--- a/include/soc/qcom/cmd-db.h
+++ b/include/soc/qcom/cmd-db.h
@@ -21,13 +21,13 @@ enum cmd_db_hw_type {
 
 #if IS_ENABLED(CONFIG_QCOM_COMMAND_DB)
 u32 cmd_db_read_addr(const char *resource_id);
 
-int cmd_db_ready(void);
+int cmd_db_init(void);
 #else
 static inline u32 cmd_db_read_addr(const char *resource_id)
 { return 0; }
 
-static inline int cmd_db_ready(void)
+static inline int cmd_db_init(void)
 { return -ENODEV; }
 #endif /* CONFIG_QCOM_COMMAND_DB */
 #endif /* __QCOM_COMMAND_DB_H__ */

-- 
2.45.2

