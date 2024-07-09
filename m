Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DC2C3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82C7788675;
	Tue,  9 Jul 2024 11:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s5aw174s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 540FD88630; Tue,  9 Jul 2024 11:34:54 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E0E388579
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a689ad8d1f6so528598166b.2
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517692; x=1721122492; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CrxeCjkjgyHaZ2lK+4zk+U0APfr/k5pkrqSoYcfYXLE=;
 b=s5aw174sgJN836dTPojgwrIGouj14rX1+bXrAly8w+XxUS7BCypFRjs48lxjNst5rQ
 U2SzTfIDIOOqZ/d7zAYyJilQQggbDdigWMgUXybJNaZuCVR4XndDbmfVPQUg/8cwkbdA
 l5DXXe2YAcbcezdzls/SHho5uQ1CBrQehWFgPwYqRta5g0X3ScR3I2ejcMgbAqIHjbd2
 cyT9A3v9Wk8axNqR2KSAKv/DH2IyVV5MoSaKVHnOS4sr9kTSb4tquQ+spDyGEQYF4FDz
 ottq6Uk7+qsTDwtCOIAYPTPJ8oojHJKw53HeK2LLCpYEKjt3dPWQ5h2Ldg8sbb2Y5mza
 CARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517692; x=1721122492;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CrxeCjkjgyHaZ2lK+4zk+U0APfr/k5pkrqSoYcfYXLE=;
 b=avl9VEpRLSP+XVgSmkUDqh4BifnXeEor0QtOK2DYnd4AjF0I4nET+uvyvwLM/RpoNH
 pqUH2PYn7IbUp+Y/RzxJnwZOVXwqmbH0KvrMXqMKXBmBDoIuxpqOUhzHGLrvo+nlG22C
 5LfA/6Xvfwk17ZQNXJi67p+7mOcnp/dJgwBr+b+S1zp3J2mDy45tdvCdRuweL5sezUg6
 cloC6pVOpAYYilx+4Ora8VmC/OYwZPC1Ag/lEJb/TrTZHeoju+gf+A6ymfWh5+9PEdRk
 qtsdvbDiuXqJURMLXeyykXm7KTLevP9BHwssya4gHjiUZaFaMTahbnArN5B4Xk6iapWj
 u11g==
X-Gm-Message-State: AOJu0YyP70yA/Pfd26ZHbDd/m1PTsc2ZV+GarkLu3p0Azo6a7eC3mU3N
 YS0m+aOEW/4+1XEATOhyySrsxiWaElcJOfWPHvKZ/YeixS1Xxi0lWTqUsxp7AQo=
X-Google-Smtp-Source: AGHT+IGBP1JKRc8uyfjfT2Tv3kF5LvpwZL5PPl4x8qlkNz3fMtB5KwhmBzSaXkcCPbs5zxsCTfH63A==
X-Received: by 2002:a17:906:48b:b0:a72:8fc7:ef7f with SMTP id
 a640c23a62f3a-a780b89a12fmr124033166b.65.1720517691797; 
 Tue, 09 Jul 2024 02:34:51 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:34:51 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 11:34:33 +0200
Subject: [PATCH v4 05/21] soc: qcom: cmd-db: replace cmd_db_ready() with
 cmd_db_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-qcom-rpmh-v4-5-c06d0a26644a@linaro.org>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4011;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=cwgA6JzUqkrAfMEbe6VI5KqN39FWdUei7f2HYPftqp0=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQzUf1sGRkOCDRoOk7vhavwYYbOdELObv8Za
 ejKOuSm6BuJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0EMwAKCRAFgzErGV9k
 tptDD/4+nXStQzRMBtH8kl0pni8KQrvKFikde7GzPMn/4F6eCB2XZu229aWk/izKTjYL33vdqsY
 fCCMWHWddKxXfhsX7lPOf3V9rAp5ZdpdpKemB0UWYhkUfR7Ai9tK1vE5ungbs3X1Y780T0477iV
 i3R5D5AG448kGH4OKlSfIo896oUrgpE32YQAaRBhdj779kTGHQYyYrY+bTYlXllJghBoGCVIpCy
 Il+r2t3MjRmpZ+xhToEws6n0dZHP2I4x1kthFkm+vSaFGtZKl6XEJk/3a/aCFTZBVP6uBSe5ekT
 HN69bygSSvif6JiHwJpKsFBRPH0d6Rmq1VcwyePCD69rtw2hNFhOlxiDaxo1IHOH3ZOVbw3WRpD
 mYuok8eMlGS4om3AISexX3rmLqZB50pnbT0BQsEIxO7ZjEmc0A7zlynmkBhWBhBFeWqWGvyQzQ7
 E4GJQRFUTkjuj/BetzyWVh5n/8B2R2Y+8Ef1RqpcL35hg/Ts7gHgLRYIBXTKVSSi08fh6OHbg9m
 ejTuCP+vtZHtCU+50wWj/s4j6rvmsrD8jYkZ10zau9RBfZYe7Csfyw5bKwC+2qa4vOkFPhjYqCY
 sHvQFtk8RqSTvjkl2eTsHLI92FEANpVwrjz+HGWosfzHUUO/7lqg3heUL8r9BUj1xW7pG9364Hk
 FG8sDevnf8I7yzA==
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

