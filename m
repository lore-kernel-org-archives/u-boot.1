Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3128BC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 762878887D;
	Mon, 15 Jul 2024 12:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PHLmL9I0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 985B78885E; Mon, 15 Jul 2024 12:08:48 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94802887EB
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a77c7d3e8bcso514701666b.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038126; x=1721642926; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dJaGTgWa9/FxJkGCdJJNpQpycUtWvWdlTFBYrGhJ9co=;
 b=PHLmL9I0Wmxk4jLXLYsgV9nOyGoWiKklruo3nJ1ZFPttXRsv1XinEqMCN3A1alUp4A
 v3vPBnuaXi19zXZWEJSm5bVSTapQ/HGsz4S/PqypsVv5Ji8CeeZHJT4bgee4qZBoDV/6
 MGC0GcmA1934yT/uB0quPBr1HXYY7JC963pj7D2+55ZEVGTV4rzFBp0vbZowybGIsqYf
 mVDUF8NZLyOrOq72jOmGShzUqfD1/2BpIVkbmXzTdsZzVmqM2RStjoSqhIvz+7mRuas+
 0hd8zt67nbTxwhd284FmMk4nfCn6Motj4w7Bi/vSVnPPAah3fhM69v2iAyGdh6ZQ7KQX
 wtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038126; x=1721642926;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJaGTgWa9/FxJkGCdJJNpQpycUtWvWdlTFBYrGhJ9co=;
 b=TwjcTW1LilWCO/duIJF7ODERVwNXE15iZa45RFv1HPubNM9kuw8hiesE9WCGiakspN
 gLyU8Ims6PXkVMP5IBYR+QRGCHmdCceEAMbLlVre14w1c+UHGxu3wqEiSgyA5OUcdGdv
 4bWP6OTevpX1H96MgnH8hYWUafuy2eBZzkCb2409PdCce6ZzVvaDSkp1RgH89jMMxoH7
 SoQF+dN2LDD0C1SqGGf4K2DgmCB0quGXWdcwZTeW4TtjXI6hOFbvLDkzFGqyiXRn9Mj8
 7hlJuAQ3WPmQ34tDyTEzDrC1dkZGDYFTu+z3I70uB5QCwVpCJaULEc+/8X4J0mvTfMEi
 FpiQ==
X-Gm-Message-State: AOJu0YxRoIGHTkKUtcdrbx5s8OjhryhCI1Kd3TetYtSinVx7Z+a6FFPD
 jXRlhm0XxBzNMkiwGZ9hZPRnp5lL9hToazH+Af8kzyHCW6xua1rK+Ink43/gVkP4WvgvCFUPmYS
 mYmI=
X-Google-Smtp-Source: AGHT+IF4GIpzWkKMq7S4dp00ZPGLFYvnIYqD2Y/hAxx1MV/96iLB/1fQuZLjG66HXdQ1hnbC8URayA==
X-Received: by 2002:a17:906:31c1:b0:a77:cc6f:e791 with SMTP id
 a640c23a62f3a-a780b705299mr1059446266b.38.1721038126041; 
 Mon, 15 Jul 2024 03:08:46 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:45 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:13 +0200
Subject: [PATCH v6 14/24] soc: qcom: rpmh: U-Boot API changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-14-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4758;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=camnfp1HM4gJk6LZyxdzL5PXbyXYt46syEdY1LHofyA=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUGF/TeruIzt/PDlt+bz9nxQ0QPXD8YGNV/Q
 fYctBLTjDGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BgAKCRAFgzErGV9k
 tlJED/0X29eKQSO0K3+35bhR68VMD8sQFtchFgwUjrjZN/74J/4Mxcfg0ES7eO+gqGMLikDzoky
 Yrj2xgzYg7UbUNHg3t8/bGQm2wSiDm0Hj1h1leYv1A4BZAVLMNxLtaex9GcUqDgm+PCWduYaJ/6
 tAmIp9QPQsWxaWmJjB/0bTfuTxzJ03odPI+SIs5tFCa35Rwk9I6zA45zyyEpUhyypPylGduhgXm
 ik7ghqgIAZYej9cUrRWxS+fGhq5s2LafbZg5GXt4LsNFxTkmOE6r9X2dijzLwaOTuqlER/DSoPY
 8nmwn4WFWnU+MLvovu7nukjJB+RytFBMkWe4AI1zPhbXzu5rNTfzdWUGOLhJkQ11AE+EsgtdpGl
 PC4mSMmtLIIkNdLqa7z7KfUpLjuA5JqPV4bxCO8gsDMf0uHFkmnCpWyn+oXyZJ+y4HgeO4eUEC3
 rvLFGGqr/sCMAMBfy6rLlPqJonHrcz5TR1qmfA+SiSvhdDLWK4jVtLZTvwh1t8hVeDN2l/G86Eg
 mGBO7ylXg1zddFD3KbBeECEDNZskwmVbKMZM8UDpJV9i4l+AxSPCaNygrsy8fEMY+9CnuS7MinI
 EQyU/5ovEriDurflJmUuMJECMw+haikasZ97jy7hNM7RJ3NGdlAq3D3UNsexLvPYkLM6tuZKBrS
 AACOK/GVPn5YDTQ==
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

