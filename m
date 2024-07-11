Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2185AC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E7F88795;
	Thu, 11 Jul 2024 18:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="egDFIF9h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39733883CE; Thu, 11 Jul 2024 18:47:05 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C23388786
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a77cc73d35fso392971066b.0
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716417; x=1721321217; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dJaGTgWa9/FxJkGCdJJNpQpycUtWvWdlTFBYrGhJ9co=;
 b=egDFIF9hy6UURcfkphvYP4ndGpK08jh73LfeJ/LoFQBh8KssIfxNyyk1cTA/NBLv7r
 BA6VQesnZCT7RqkoDJeaBXtekFk5gQgY7Fu4vt+RYWxUfWVlYxReXWNg8WD5ud4+34Lr
 hFVSLXqFY31W59BOB2eWugw7mQ1o2NFhcwFEwb4cgzIDMFPjPFVcD2WZJ1A9Jgrj6e3v
 4FHFuEl+wtX6VFFzq2C5Z/BIMUc4cHrdVVrYBC5F6Nc3pmCY2n2PdTtFkDS24RJ2WuAq
 +3oHM9ChQBBe+Jj2Depo7uy6YavvYE9+6sOKwsatn/6hYYNs5yDqFVECdDoy7I0jMCDP
 S1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716417; x=1721321217;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJaGTgWa9/FxJkGCdJJNpQpycUtWvWdlTFBYrGhJ9co=;
 b=HxvA4Z9inIRwvP/ad7f6dE7t1pm6iT6pE7Rjct/du0lvxsn6pdD/xa3BLcei6qNFuM
 KvtUFn7jF60iTT2prOQnSyunYGFBT2dO+HSiZLobmZKvnNn8zyRt1NPNzphQJzehgkU8
 4qTfV8HHBtk9I+u3mLF5Tgicj8eZLL0dAqLXoVpze3m04suEqtByVLUsjsYxtNCD5SFl
 OSKOUXPWeCmyz1qHGLg47j6AQFI69WqFe1dvqWSAB2hZrMOVsa9T7evRWkVBWtIbf334
 8ochFYq/irvPozIEjRJBB6jA0rJGQxnzaNfC8UXmCYqIc5aOrr96oPNAP+Uu6V+TWF/A
 oNfA==
X-Gm-Message-State: AOJu0Yy47HFEzTJ/m5y2BwqoK3XW4wYZsLeOEQJHjvY0jU2Ni0ZwqrHe
 6ifxuVJBdf+qFunILTIvdp+ParkdOuOCtIabLFiEPGnQFg19NbK+ZhnY/NEE5ms=
X-Google-Smtp-Source: AGHT+IGiTv8FzhR0JeXg17/NBg75MyUVF+taxs++j0QnkZBGD2V6DC0VRcIHgr9L78tJOtiPMqV1wA==
X-Received: by 2002:a17:906:81cc:b0:a6e:f869:d718 with SMTP id
 a640c23a62f3a-a799d380e3dmr10203566b.21.1720716417503; 
 Thu, 11 Jul 2024 09:46:57 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:46:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 11 Jul 2024 18:46:45 +0200
Subject: [PATCH v5 13/23] soc: qcom: rpmh: U-Boot API changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-qcom-rpmh-v5-13-fbf04ce6a7e8@linaro.org>
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4758;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=camnfp1HM4gJk6LZyxdzL5PXbyXYt46syEdY1LHofyA=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxvv2uU2g/EBwRY2bTRmva7mGPN5hGX8i4T3
 8ISL/j8N9OJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMbwAKCRAFgzErGV9k
 tsQlEACJYQtRM+yzI4UUcs/EfuSp3jdlIROZ0qcCNNoQ4BRTtCoHcTJB0w+ARARbvGFwY0sFPIp
 3gZ0MB6RvgoySP4Il9nhP7iY2aB4Aq5tkmPMG9rWrS1nBvI94xfyR/00F30R4LCxSAFBIUs7p7p
 IKarTX0Dn89Z8mES+/jIoAW1Z18KAKGUXH2/FecSS5dfG2dmXYqV992BDCv9OWp6RTBkyGalyIC
 037ezIn7BgQCc5//Asf0bfix50kEqF+GGyfJ5bx2dhw5B6GsmTDopZgXq6KwW1AGc/FuQT7qaYU
 nClxBE8Kkkp4EGhbwKo73JbhmlM/+GE6Hq4C86DofjEMNsV+/eSICTVpe8YbLoeV9UU2aaThSZM
 Sy41yRZ1LS2bL+udeTGDQsSgn4bIA6Td8FIdmPrrmfin2uKesPpcg45rPIBUtddIwxJC5c1VGCl
 sWesoTZYVfbu+bH3QiHwZI812ijt7v/XcHODBtBgLobLuyXmjz1AhYnVCri7pCteIIJERoFL3X/
 40t+itZGeoz2nTsqzTDHWR5RVY11I2V1cKDeAR/LeqWjp/ul/n8rmXxBdGXohGFohHrVRwMZ4eT
 maDVx3pv6zDY7qHGJdPxdvDGqkD/+rDNJdNgKlvFoD8vQSk+fHqjXGEgwpR+HxG9qxWUtBNaZ5g
 qxGDyoJl7aJPT5w==
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

Fix build errors, add some debug logging.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/rpmh.c | 53 +++++++++++++++++++------------------------------
 include/soc/qcom/rpmh.h |  4 ++--
 2 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 22605e0291a1..96f14a9afdf2 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -15,27 +15,30 @@
 #include "rpmh-internal.h"
 
 #define RPMH_TIMEOUT_MS			msecs_to_jiffies(10000)
 
-#define DEFINE_RPMH_MSG_ONSTACK(device, s, q, name)	\
+#define DEFINE_RPMH_MSG_ONSTACK(device, s, name)	\
 	struct rpmh_request name = {			\
 		.msg = {				\
 			.state = s,			\
 			.cmds = name.cmd,		\
 			.num_cmds = 0,			\
-			.wait_for_compl = true,		\
 		},					\
 		.cmd = { { 0 } },			\
-		.completion = q,			\
 		.dev = device,				\
-		.needs_free = false,				\
+		.needs_free = false,			\
 	}
 
 #define ctrlr_to_drv(ctrlr) container_of(ctrlr, struct rsc_drv, client)
 
-static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
+static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct udevice *dev)
 {
-	struct rsc_drv *drv = dev_get_drvdata(dev->parent);
+	struct rsc_drv *drv = (struct rsc_drv *)dev_get_priv(dev->parent);
+
+	if (!drv) {
+		log_err("BUG: no RPMh driver for %s (parent %s)\n", dev->name, dev->parent->name);
+		BUG();
+	}
 
 	return &drv->client;
 }
 
@@ -49,36 +52,23 @@ static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
  * Cache the RPMH request and send if the state is ACTIVE_ONLY.
  * SLEEP/WAKE_ONLY requests are not sent to the controller at
  * this time. Use rpmh_flush() to send them to the controller.
  */
-static int __rpmh_write(const struct device *dev, enum rpmh_state state,
+static int __rpmh_write(const struct udevice *dev, enum rpmh_state state,
 			struct rpmh_request *rpm_msg)
 {
 	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
-	int ret = -EINVAL;
-	struct cache_req *req;
-	int i;
 
-	/* Cache the request in our store and link the payload */
-	for (i = 0; i < rpm_msg->msg.num_cmds; i++) {
-		req = cache_rpm_request(ctrlr, state, &rpm_msg->msg.cmds[i]);
-		if (IS_ERR(req))
-			return PTR_ERR(req);
+	if (state != RPMH_ACTIVE_ONLY_STATE) {
+		log_err("only ACTIVE_ONLY state supported\n");
+		return -EINVAL;
 	}
 
-	if (state == RPMH_ACTIVE_ONLY_STATE) {
-		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
-	} else {
-		/* Clean up our call by spoofing tx_done */
-		ret = 0;
-		rpmh_tx_done(&rpm_msg->msg);
-	}
-
-	return ret;
+	return rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
 }
 
 static int __fill_rpmh_msg(struct rpmh_request *req, enum rpmh_state state,
-		const struct tcs_cmd *cmd, u32 n)
+			   const struct tcs_cmd *cmd, u32 n)
 {
 	if (!cmd || !n || n > MAX_RPMH_PAYLOAD)
 		return -EINVAL;
 
@@ -87,8 +77,10 @@ static int __fill_rpmh_msg(struct rpmh_request *req, enum rpmh_state state,
 	req->msg.state = state;
 	req->msg.cmds = req->cmd;
 	req->msg.num_cmds = n;
 
+	debug("rpmh_msg: %d, %d cmds [first %#x/%#x]\n", state, n, cmd->addr, cmd->data);
+
 	return 0;
 }
 
 /**
@@ -100,24 +92,19 @@ static int __fill_rpmh_msg(struct rpmh_request *req, enum rpmh_state state,
  * @n: The number of elements in @cmd
  *
  * May sleep. Do not call from atomic contexts.
  */
-int rpmh_write(const struct device *dev, enum rpmh_state state,
+int rpmh_write(const struct udevice *dev, enum rpmh_state state,
 	       const struct tcs_cmd *cmd, u32 n)
 {
-	DECLARE_COMPLETION_ONSTACK(compl);
-	DEFINE_RPMH_MSG_ONSTACK(dev, state, &compl, rpm_msg);
+	DEFINE_RPMH_MSG_ONSTACK(dev, state, rpm_msg);
 	int ret;
 
 	ret = __fill_rpmh_msg(&rpm_msg, state, cmd, n);
 	if (ret)
 		return ret;
 
 	ret = __rpmh_write(dev, state, &rpm_msg);
-	if (ret)
-		return ret;
 
-	ret = wait_for_completion_timeout(&compl, RPMH_TIMEOUT_MS);
-	WARN_ON(!ret);
-	return (ret > 0) ? 0 : -ETIMEDOUT;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(rpmh_write);
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index 9a5c5d992e04..3421fbf1ee3e 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -5,14 +5,14 @@
 
 #ifndef __SOC_QCOM_RPMH_H__
 #define __SOC_QCOM_RPMH_H__
 
+#include <dm/device-internal.h>
 #include <soc/qcom/tcs.h>
-#include <linux/platform_device.h>
 
 
 #if IS_ENABLED(CONFIG_QCOM_RPMH)
-int rpmh_write(const struct device *dev, enum rpmh_state state,
+int rpmh_write(const struct udevice *dev, enum rpmh_state state,
 	       const struct tcs_cmd *cmd, u32 n);
 
 #else
 

-- 
2.45.2

