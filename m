Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81DFC3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60E55886BB;
	Tue,  9 Jul 2024 11:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jr17UDzw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDBE7886A8; Tue,  9 Jul 2024 11:35:02 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5FD788651
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a77baa87743so528988566b.3
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517700; x=1721122500; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dfO6x+ebnvspCoQpGUnrINvP3J5Kv4kl/j5zD+fgWQs=;
 b=Jr17UDzwwBW4Bk+lO8yaUSVCZNHwXpbin65viRRVizVQ8sWoRfRC9wO4/8RUaZaAWX
 FxrqnPen1gy/iJ7cz/5f7G1y7wxQRSlN74+BIOR3hJG2Iie32cnBL+4qku7HPiw7UE0l
 hdVM3mHxgVW0Ssz0X9sFoe3k8Km+zKANn5VTjjXjsl0LWcYWPKnAJDgAQcJkqrrAlrKt
 mLE1GLnJLGYMWjtjKC48E3r04WJtCh+BdDjl3dkQpgwoCwpPO4t7QObdIVpQ+J0bVxkx
 iKduuPK4akhxJD1TL44KjXOOQKpPzdfj8DP9KZ08r+TC/ybCeyW7PGF7Fpim+tb2ZLoy
 apeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517700; x=1721122500;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfO6x+ebnvspCoQpGUnrINvP3J5Kv4kl/j5zD+fgWQs=;
 b=DRipGayeNSan3K2T89l9/MqQkxKdU25ZDCyYNkLdcKo/UlcKVgP/lJBBBuN7SLeuj3
 BnKcA6yixKFPJRfK9dJsR+jbK9NEh5d34J7UomEHnWzAY1WajSPhfIxl+WBke6RMZ+IO
 PMCg95YI4pxAhq9L/RTfKCvur4ga89X10siWQJH+Gje64tXKWYCX4GJ9LvPMs6m8KFZL
 JlXS+JDuex2fWecUbbZqBSBqEhDYsOHFMaS/Pi8own9IDP7+IczQCSTg6NEpyy6+/0to
 dIT2OQgPTF2HmfztlR6yc/sQ3EqO39OiegvVcnivfoIa7qTkMEx9Jkz9tCWop/il8bPg
 IVmg==
X-Gm-Message-State: AOJu0YzDYRD2yRq4zM4lxi4nRyf/IyPzuzVswC7vjWb2wSwzB+rkCMcj
 MhOglIxuxAOha+9nxfjrm2fIppavJt2XlWuJzPWVbb91dMakZJw8M8eyTCCkFUE=
X-Google-Smtp-Source: AGHT+IH6tFtaaJ9/HN4JztthjbU5+tJn+AHvxt2L8xF4AYVKvaovUGKu7d675c4JSuI2Xq5g6dB/zw==
X-Received: by 2002:a17:906:32cc:b0:a77:de2a:aeee with SMTP id
 a640c23a62f3a-a780b7053damr185144466b.43.1720517700039; 
 Tue, 09 Jul 2024 02:35:00 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:34:59 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 11:34:41 +0200
Subject: [PATCH v4 13/21] soc: qcom: rpmh: U-Boot API changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-qcom-rpmh-v4-13-c06d0a26644a@linaro.org>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4712;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=VkMIn3vLTUW9CCP7wfX35uzujU51n/saoSC5hc9LK1A=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQ06CHS9sxcG5U7ERI+1jQnm9QgCc2XHxI9V
 wK0Lhv3OkiJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0ENAAKCRAFgzErGV9k
 tq+MD/4z/ilmypzxADonJ0PJnOoeHT4W+px1oPGWUojrd8nBxR47X56n6m6VjHR/UyLI6IRSfcZ
 lUgFNwBvEiDQR3ZZmfZeoB0OPBvnWZPBo6hFD1oS7GsV+jX7m12quLsChAdW50I/YlqlsqtloVK
 rzABPUHRHD6AJ3i9BBhSD20kz6XJL4/74bGFmejH2rK/7v3fU1U07g5mWX1J58Dq/3SKUc4uZmM
 ilgP55LfplVd9a1lrNUePhh/IRkpQvNYa5RvX/L26KgvQcZPrlljvu3TgzYN7v5m6vPxgwdzExU
 fncxaf0hWIfnD2A3XRYEj0GChdR+fBVo1YBZcb6WjAaookgfLEeWybm5XTZ5QP+Z7MzC0P234j8
 +jR38L7qtKMg0ILAZmTVOjWa15wwYMPHspiA6gJ+8+/maAuVNtWkjsZaATBK7iaYkUoVOWO2XrP
 CX8tdTBoPK2Hamb0sTq120dauzUaudi6wjmvYVKYWbv0ACYlhvEOy/PSDR2o1B9ReWORkXR2pDW
 i5Cuf7gaJQb86FCC+DpeIXEkg1uHTo1QctJoW0F2j7P5Lcelo7F9jl6cjHVyqJjJ2fhcBVDk9k2
 Dxq5Nn5cClRPvlAjM8gqXDDYf6g3+Uknm//0woq4Gl0SIopeJwV1OwQyzUpdj2tdL4C2h7skMyu
 VqD5q3zIh6y2PDQ==
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

