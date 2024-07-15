Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537A8C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E558188846;
	Mon, 15 Jul 2024 12:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pgIH7o2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5581188853; Mon, 15 Jul 2024 12:08:44 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E620887EB
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a77d9217e6fso481006766b.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038122; x=1721642922; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1hmytS4Unti8N4UWz0So7iJZshWMA6yLHRXiaZMt67I=;
 b=pgIH7o2lYa4DH/yyLq2v52a7OsCx1lLm6fIAfbVy18NapoH0BWBuFcvZy0wyJpB0Cg
 UBQR++ZHNxMjoH/sIh3oiqT5ilv44PmFWqTX3Sfc4l0VWsCQgBiEKZbNWvZdjI07Qk7d
 UQ3fliwxkMFnnjeyqDi6GlDNwq77x5zxFF/O2B5e+SpwmMLIzVVLlgoEmUJZGuCWPvKR
 C3XFhsjo54mqz8sU39FRRuI3Kvps9/dmPWa4HNiFEru0oQengchwFUUJ4MfK+sOKu6cA
 gwteLtX6oJl1R08LP6y4vXdiKK9M2fG49EFcx9KhZ8JXrpwKYPt4RuH103clIL0m0eH7
 QEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038122; x=1721642922;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1hmytS4Unti8N4UWz0So7iJZshWMA6yLHRXiaZMt67I=;
 b=UkPtM/Sk4hqzr/sGT9htrkhNZd2h78WlO2ivtxJTJV5xS9yq5Qzl6RC+UfZIaIgIeL
 vueaJTgMe0RXxzxTZLzUayMIe/Y5xNaMsSlaJwo5s8sZOctfX05BuinLxj19vErj2Ibf
 vLZgszZmfklJzpA7RVkWQrZ1ep3lMDO1+nTXhmlwIe5t0YjPbVRPXfnnMOGVL5NkQfmT
 8+GZcfRBJ54v92ddJARJ4J91IFeUvvWkhOQqOOjdqv/ECyBoSMZmjhyoQGSMmBzHG00A
 WqNSmq14MKUFr74C2byjf3DpaqJkvuXj5/+RfD++z+1tdA5eIdo6jbulntKmHiPJauLa
 mZFg==
X-Gm-Message-State: AOJu0Yx2wv3EAubQCfn+Q7EGmRJUjuxjhZpfHwEiIm+86elbKTJ00nrQ
 oTUNCgHuzNGaVNRwtajWnpXWztGTnOqAfSYksz+HPsmR0abTRcBSlx5Rx7/QSCc=
X-Google-Smtp-Source: AGHT+IETINHKSTraMbmQq+Bdt4vODZSVoJhWoPLQC2GhC1XMIuAdbAzSCBq0+a+dwkGXLWPLg0RfMA==
X-Received: by 2002:a17:907:d8a:b0:a72:7c0d:8fdc with SMTP id
 a640c23a62f3a-a780b68a311mr1502838266b.14.1721038101749; 
 Mon, 15 Jul 2024 03:08:21 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:21 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:09 +0200
Subject: [PATCH v6 10/24] soc: qcom: rpmh-rsc: adjust probe for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-10-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8474;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=4iKCVU52KhaCwwKEXjpNER/MziLXX/Du2ZD98VxXPgU=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUGsKFgU3ccGaJ8lT7Vskh4anmY2sFNIQq8I
 Hceh1k+8dOJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BgAKCRAFgzErGV9k
 tqOlD/9T+s9hMFEtnMKrYsyR+gzIG8GFet38AHcJbRVgFiLAfm4JDFze5OJWgpE5cjd+t5TE1KD
 yfyIb+itC8r+L0brUyw6mwIGZTAc9dSbWefSCE0FjO7RgFpXJZ86DE6Ho81tXTawvnfxG3Lwlxh
 s4lKIk3GT1StxvSkOwxU8Zh4tTNdd2Phf6wDHLrMg3uG7atScJtJRh0VNeqn8zErvZGfLm3Nf+1
 bmjJGzGGPr5vujLnAaJz1tmxVu6WlQsgi5hSgJn1+mLrY6ZZ5ha5T2v7gwDR5UsVuZ1yOSA9GAd
 kpuydTf2xbjT8tH2FugsWxb+dlPKghxuyp2Np0oJkAPWc0UoX+B4aVTPeqK4VCL35WlUT8eAXAU
 3ruawXIo8KbbEQ/jkPFd/TSkdKSSJdXM4zhm//2OONlwBfpiEUrYiKRi8EXzCaIGQiG3uVL2vw5
 UlLF1g0dV+0Iev9W2EpPDR32gvlTMhJPJYrcnZNhtYjDg/a/aFcGQH0Awu73KVgNRrSdFaasBTz
 bI5zOvqULImepS3wDzQFv2Av9IihGnfBnwiGaW2XIZO80LyHrlOVtzOw/j8LmgjqEuc74YUNBvF
 sgECVM+vFHPHN/aK/CUhQN4cTUNwhrU2AnPQJ4wJ4s546Eol6Eq9dTo4KcTzU6YzzVffGjzBP26
 MA4VgwfjgPe/3Qw==
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

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/rpmh-internal.h |  14 ++---
 drivers/soc/qcom/rpmh-rsc.c      | 123 ++++++++++-----------------------------
 2 files changed, 34 insertions(+), 103 deletions(-)

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
index 6b47c8001cac..2afe5005facf 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -385,20 +385,20 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 
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
 
@@ -410,24 +410,15 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev, struct rsc_drv *d
 
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
 
@@ -456,43 +447,28 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev, struct rsc_drv *d
 
 	return 0;
 }
 
-static int rpmh_rsc_probe(struct platform_device *pdev)
+static int rpmh_rsc_probe(struct udevice *dev)
 {
-	struct device_node *dn = pdev->dev.of_node;
+	ofnode dn = dev_ofnode(dev);
 	struct rsc_drv *drv;
 	char drv_id[10] = {0};
-	int ret, irq;
-	u32 solver_config;
+	int ret;
 	u32 rsc_id;
 
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
+	drv = dev_get_priv(dev);
 
-	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
-	if (!drv)
-		return -ENOMEM;
-
-	ret = of_property_read_u32(dn, "qcom,drv-id", &drv->id);
+	ret = ofnode_read_u32(dn, "qcom,drv-id", &drv->id);
 	if (ret)
 		return ret;
 
-	drv->name = of_get_property(dn, "label", NULL);
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
@@ -505,84 +481,45 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
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

