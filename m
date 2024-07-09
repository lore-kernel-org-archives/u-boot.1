Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB2DC2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A31F488599;
	Tue,  9 Jul 2024 11:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qXmJmUc9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1E5888609; Tue,  9 Jul 2024 11:34:58 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88A5087EBD
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a77e5929033so351127566b.0
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517696; x=1721122496; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vZK1z1cs1+Yu9U0/zCu4GJlO7Ot0RM0dFVhpVmb1nhc=;
 b=qXmJmUc9bZVPa1+2DFRKCEOE9xU7eeZFt966RFC304BRy+tADcbMZt/nozh9YCiKzG
 0mjLr8EvHaX6QEtT0pjT349dpebhnW/pjzacPLE7hWRZP58UDa9cbKLgCfhzL9OgUdN3
 m422BBSr/48lfFVqNWw05hxhUKnx4rzlEc9nPpzNXodSLI2eZuaAZpGavhDYUkePl797
 IbkUZbZWSIt4t/0DX2EiYY+4vkeSw1OPHj8PR7UfkApJLleiZ4utih2gBD47XWtUf3xq
 eT+ED5ivTkPKM0vEkd/knkaUeQ9SX9swPbXJ7oi9wDBBw3QPHpWHrq80MF9MisS19+tc
 4vRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517696; x=1721122496;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZK1z1cs1+Yu9U0/zCu4GJlO7Ot0RM0dFVhpVmb1nhc=;
 b=E0D06tGVdpsIAk6CKIB5znIhWfGMUXQN6qigXox2hjx1oDUonPQNVsCPzuVsl+E1Nv
 1cKMNiseMjKJK5pilodajGQOENJSO4sOBLD2LpiFOkwwb93dugATL8P6OajgJeqekRHz
 vWcgocGCzkaPbJKwrtKvjhSGVf75+VZVdTrfzs4suhNEQEj97NMpzFOfZBiYsn6e2X75
 Y+tgXumt8ZZ7BaI+CxGQaxt8BIsPQGzm7Br5+0aod9bE3AnhtV2zUkQPOHCD9nKnRFcq
 BmG+UmYpLwqXt3LyNsvVcJ0O+3JUOE849tU9ZRrroKQrRu+dnkThBIdVFfc54UoXF6L+
 sUkw==
X-Gm-Message-State: AOJu0YzvjVWD5jEXQkcRFSovn3bArE43ySL3DKF3oEF8jEMymRYPzQty
 fHQ+KAiE/4+bTf7VCgMyRyOrxZ6Fp9v+VWnE3cdwuGjNfH9p7p56Pu3RmgsBPag=
X-Google-Smtp-Source: AGHT+IGa4ZMi//pK9sE9JOUMzFkzejApbOeP2HRThliJAo8cfwZJVXiKwF2800jOA/+1usaGNA502Q==
X-Received: by 2002:a17:906:d1c7:b0:a77:e2b1:9cb9 with SMTP id
 a640c23a62f3a-a780b881caemr140679466b.48.1720517696021; 
 Tue, 09 Jul 2024 02:34:56 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:34:55 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 11:34:37 +0200
Subject: [PATCH v4 09/21] soc: qcom: rpmh-rsc: adjust probe for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-qcom-rpmh-v4-9-c06d0a26644a@linaro.org>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8664;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=xX8SyHmxYvc7yjJFYBz1VA/I22/3xtnBUf9dipAglnA=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQzJJz+BTsoTjSXNw7UM4kN/DpdJJgzSvJ9l
 7WawtGaf96JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0EMwAKCRAFgzErGV9k
 tmqmD/9I34QOcjxeoizzzg6bRtOgDNpLhKiu3uyQAPOXxWexdHC37JkMiQIgv41X7UF7PRt0OW1
 +zP6IT6p4J38keO1rUgkDD9xffJwj40tNvf3gZPJ+9QtjrDpQuq9vaYhJxbdtAY6OECvTiACJzh
 5IVRJQ2v6a9rWYUVYib0QHMBhOGHDQLN3MWZzynjrMzBfyBWMpB5s8ftrgRb8fNaW/YF0BRQgZZ
 oRI2HopI000LqbLjKWvtC4UEd4oQciyhDYOtOW8RX09f9cb36/PFm35ut/yXrAcmQF0vwUMRL9n
 VrMg7d3tuJ4TYDiSHUvw5L5fhpFp0mmGRCZ09JNn/05bJkVgGXwIL865NU/2yUWBiT9vh0E0aiP
 bW0p5P/e5csFAFuKKEIJ0RltG50hHOve72Y78JBqKtRRhAkDneKhJ1l3JFrdExymTsdQ53Zrif+
 IWXOKmUA7NjZ+tJR/c8SgrH6DCJ9/1T1nz3SV9RUbKnHpAoNLwWgSaUY+xKADugPaK0/35Xg7i9
 0PcIEsbkin1nbzLBRlH1ZD6E06Yhve0VfCn4a82bKHVdZk8XLiSIn07vdPzX7oZvTaEkUXVZSCF
 E9BcudEQiUk2bgAEYK3iiCBUlW3y/Pr+bSdrx9F03Ogp/oUCcLyTFF3+kMCtusE73IUJlXwDbgt
 YwRQIbnDkLfdytA==
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

Rework the rpmh-rsc initialization to use U-Boot's driver model and
initialize cmd-db.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/rpmh-internal.h |  14 ++--
 drivers/soc/qcom/rpmh-rsc.c      | 143 +++++++++++++--------------------------
 2 files changed, 50 insertions(+), 107 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 12c5b8d9cf86..ac8f6c35a7a4 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -7,17 +7,18 @@
 #ifndef __RPM_INTERNAL_H__
 #define __RPM_INTERNAL_H__
 
 #include <linux/bitmap.h>
-#include <linux/wait.h>
 #include <soc/qcom/tcs.h>
 
 #define TCS_TYPE_NR			4
 #define MAX_CMDS_PER_TCS		16
 #define MAX_TCS_PER_TYPE		3
 #define MAX_TCS_NR			(MAX_TCS_PER_TYPE * TCS_TYPE_NR)
 #define MAX_TCS_SLOTS			(MAX_CMDS_PER_TCS * MAX_TCS_PER_TYPE)
 
+#define USEC_PER_SEC			1000000UL
+
 struct rsc_drv;
 
 /**
  * struct tcs_group: group of Trigger Command Sets (TCS) to send state requests
@@ -63,10 +64,9 @@ struct tcs_group {
  */
 struct rpmh_request {
 	struct tcs_request msg;
 	struct tcs_cmd cmd[MAX_RPMH_PAYLOAD];
-	struct completion *completion;
-	const struct device *dev;
+	const struct udevice *dev;
 	bool needs_free;
 };
 
 /**
@@ -78,9 +78,8 @@ struct rpmh_request {
  * @batch_cache: Cache sleep and wake requests sent as batch
  */
 struct rpmh_ctrlr {
 	struct list_head cache;
-	spinlock_t cache_lock;
 	bool dirty;
 	struct list_head batch_cache;
 };
 
@@ -122,17 +121,12 @@ struct rsc_drv {
 	void __iomem *base;
 	void __iomem *tcs_base;
 	int id;
 	int num_tcs;
-	struct notifier_block rsc_pm;
-	struct notifier_block genpd_nb;
-	atomic_t cpus_in_pm;
 	struct tcs_group tcs[TCS_TYPE_NR];
 	DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
-	spinlock_t lock;
-	wait_queue_head_t tcs_wait;
 	struct rpmh_ctrlr client;
-	struct device *dev;
+	struct udevice *dev;
 	struct rsc_ver ver;
 	u32 *regs;
 };
 
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index c09214552cfb..d4ef88dda184 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -386,20 +386,20 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 
 	return 0;
 }
 
-static int rpmh_probe_tcs_config(struct platform_device *pdev, struct rsc_drv *drv)
+static int rpmh_probe_tcs_config(struct udevice *dev, struct rsc_drv *drv)
 {
 	struct tcs_type_config {
 		u32 type;
 		u32 n;
 	} tcs_cfg[TCS_TYPE_NR] = { { 0 } };
-	struct device_node *dn = pdev->dev.of_node;
+	ofnode dn = dev_ofnode(dev);
 	u32 config, max_tcs, ncpt, offset;
 	int i, ret, n, st = 0;
 	struct tcs_group *tcs;
 
-	ret = of_property_read_u32(dn, "qcom,tcs-offset", &offset);
+	ret = ofnode_read_u32(dn, "qcom,tcs-offset", &offset);
 	if (ret)
 		return ret;
 	drv->tcs_base = drv->base + offset;
 
@@ -411,24 +411,15 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev, struct rsc_drv *d
 
 	ncpt = config & (DRV_NCPT_MASK << DRV_NCPT_SHIFT);
 	ncpt = ncpt >> DRV_NCPT_SHIFT;
 
-	n = of_property_count_u32_elems(dn, "qcom,tcs-config");
-	if (n != 2 * TCS_TYPE_NR)
-		return -EINVAL;
+	n = ofnode_read_u32_array(dn, "qcom,tcs-config", (u32 *)tcs_cfg, 2 * TCS_TYPE_NR);
+	if (n < 0) {
+		log_err("RPMh: %s: error reading qcom,tcs-config %d\n", dev->name, n);
+		return n;
+	}
 
 	for (i = 0; i < TCS_TYPE_NR; i++) {
-		ret = of_property_read_u32_index(dn, "qcom,tcs-config",
-						 i * 2, &tcs_cfg[i].type);
-		if (ret)
-			return ret;
-		if (tcs_cfg[i].type >= TCS_TYPE_NR)
-			return -EINVAL;
-
-		ret = of_property_read_u32_index(dn, "qcom,tcs-config",
-						 i * 2 + 1, &tcs_cfg[i].n);
-		if (ret)
-			return ret;
 		if (tcs_cfg[i].n > MAX_TCS_PER_TYPE)
 			return -EINVAL;
 	}
 
@@ -457,43 +448,39 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev, struct rsc_drv *d
 
 	return 0;
 }
 
-static int rpmh_rsc_probe(struct platform_device *pdev)
+static int rpmh_rsc_bind(struct udevice *dev)
 {
-	struct device_node *dn = pdev->dev.of_node;
-	struct rsc_drv *drv;
-	char drv_id[10] = {0};
-	int ret, irq;
-	u32 solver_config;
-	u32 rsc_id;
+	int ret;
 
-	/*
-	 * Even though RPMh doesn't directly use cmd-db, all of its children
-	 * do. To avoid adding this check to our children we'll do it now.
-	 */
-	ret = cmd_db_ready();
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Command DB not available (%d)\n",
-									ret);
-		return ret;
-	}
-
-	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
-	if (!drv)
-		return -ENOMEM;
-
-	ret = of_property_read_u32(dn, "qcom,drv-id", &drv->id);
+	ret = cmd_db_init();
 	if (ret)
 		return ret;
 
-	drv->name = of_get_property(dn, "label", NULL);
+	return 0;
+}
+
+static int rpmh_rsc_probe(struct udevice *dev)
+{
+	ofnode dn = dev_ofnode(dev);
+	struct rsc_drv *drv;
+	char drv_id[10] = {0};
+	int ret;
+	u32 rsc_id;
+
+	drv = dev_get_priv(dev);
+
+	ret = ofnode_read_u32(dn, "qcom,drv-id", &drv->id);
+	if (ret)
+		return ret;
+
+	drv->name = ofnode_get_property(dn, "label", NULL);
 	if (!drv->name)
-		drv->name = dev_name(&pdev->dev);
+		drv->name = dev->name;
 
 	snprintf(drv_id, ARRAY_SIZE(drv_id), "drv-%d", drv->id);
-	drv->base = devm_platform_ioremap_resource_byname(pdev, drv_id);
+	drv->base = (void __iomem *)dev_read_addr_name(dev, drv_id);
 	if (IS_ERR(drv->base))
 		return PTR_ERR(drv->base);
 
 	rsc_id = readl_relaxed(drv->base + RSC_DRV_ID);
@@ -506,84 +493,46 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 		drv->regs = rpmh_rsc_reg_offset_ver_3_0;
 	else
 		drv->regs = rpmh_rsc_reg_offset_ver_2_7;
 
-	ret = rpmh_probe_tcs_config(pdev, drv);
+	ret = rpmh_probe_tcs_config(dev, drv);
 	if (ret)
 		return ret;
 
 	spin_lock_init(&drv->lock);
 	init_waitqueue_head(&drv->tcs_wait);
 	bitmap_zero(drv->tcs_in_use, MAX_TCS_NR);
 
-	irq = platform_get_irq(pdev, drv->id);
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_irq(&pdev->dev, irq, tcs_tx_done,
-			       IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND,
-			       drv->name, drv);
-	if (ret)
-		return ret;
-
-	/*
-	 * CPU PM/genpd notification are not required for controllers that support
-	 * 'HW solver' mode where they can be in autonomous mode executing low
-	 * power mode to power down.
-	 */
-	solver_config = readl_relaxed(drv->base + drv->regs[DRV_SOLVER_CONFIG]);
-	solver_config &= DRV_HW_SOLVER_MASK << DRV_HW_SOLVER_SHIFT;
-	solver_config = solver_config >> DRV_HW_SOLVER_SHIFT;
-	if (!solver_config) {
-		if (pdev->dev.pm_domain) {
-			ret = rpmh_rsc_pd_attach(drv, &pdev->dev);
-			if (ret)
-				return ret;
-		} else {
-			drv->rsc_pm.notifier_call = rpmh_rsc_cpu_pm_callback;
-			cpu_pm_register_notifier(&drv->rsc_pm);
-		}
-	}
-
 	/* Enable the active TCS to send requests immediately */
 	writel_relaxed(drv->tcs[ACTIVE_TCS].mask,
 		       drv->tcs_base + drv->regs[RSC_DRV_IRQ_ENABLE]);
 
 	spin_lock_init(&drv->client.cache_lock);
 	INIT_LIST_HEAD(&drv->client.cache);
 	INIT_LIST_HEAD(&drv->client.batch_cache);
 
-	dev_set_drvdata(&pdev->dev, drv);
-	drv->dev = &pdev->dev;
+	dev_set_drvdata(dev, drv);
+	drv->dev = dev;
 
-	ret = devm_of_platform_populate(&pdev->dev);
-	if (ret && pdev->dev.pm_domain) {
-		dev_pm_genpd_remove_notifier(&pdev->dev);
-		pm_runtime_disable(&pdev->dev);
-	}
+	log_debug("RPMh: %s: v%d.%d\n", dev->name, drv->ver.major, drv->ver.minor);
 
 	return ret;
 }
 
-static const struct of_device_id rpmh_drv_match[] = {
-	{ .compatible = "qcom,rpmh-rsc", },
+static const struct udevice_id qcom_rpmh_ids[] = {
+	{ .compatible = "qcom,rpmh-rsc" },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, rpmh_drv_match);
 
-static struct platform_driver rpmh_driver = {
-	.probe = rpmh_rsc_probe,
-	.driver = {
-		  .name = "rpmh",
-		  .of_match_table = rpmh_drv_match,
-		  .suppress_bind_attrs = true,
-	},
+U_BOOT_DRIVER(qcom_rpmh_rsc) = {
+	.name		= "qcom_rpmh_rsc",
+	.id		= UCLASS_MISC,
+	.priv_auto	= sizeof(struct rsc_drv),
+	.probe		= rpmh_rsc_probe,
+	.bind		= rpmh_rsc_bind,
+	.of_match	= qcom_rpmh_ids,
+	/* rpmh is under CLUSTER_PD which we don't support, so skip trying to enable PDs */
+	.flags		= DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
-static int __init rpmh_driver_init(void)
-{
-	return platform_driver_register(&rpmh_driver);
-}
-core_initcall(rpmh_driver_init);
-
 MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPMh Driver");
 MODULE_LICENSE("GPL v2");

-- 
2.45.2

