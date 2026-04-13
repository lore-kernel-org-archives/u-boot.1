Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8846EBFD38
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 11:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08718839D5;
	Mon, 13 Apr 2026 13:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jueXWVoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF937839D5; Mon, 13 Apr 2026 13:06:20 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45916839DF
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 13:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso50209635e9.3
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 04:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776078377; x=1776683177; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b1Vjln4zIBJ1aJFY21FO3G9o/WkJusZ13m5ZSDh99pI=;
 b=jueXWVoDcQ/M7N+qxbRHo3erDLOwugP2gRCScfYpRv7UNjHOo+qBIyV4FQlVIIUfxy
 AwrCk8rBvHBumpjmiH/z5JjsE1KSuZTMZjzqNEV1NemQS+7RnOAAueJu4rjZesH8omDO
 lZILinRkqW0zHdO/qqS59EWWiR2TM5RSj6RGc5OT3Go2AMtfSzVjHxe9pugcSFom+A9e
 g4D8AulKIpkjHfYR8tpTCHE42ApZqgb3smFRqWWVNen4cQgnIWY2Y0ftOkw7VmWNtnGY
 XnV7ayFeV4sGkkcpqR9C3WebNCnRwTsbvBjPzn225YsVqSc4KTGnPONX8akyGgdSoRSV
 kYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776078377; x=1776683177;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=b1Vjln4zIBJ1aJFY21FO3G9o/WkJusZ13m5ZSDh99pI=;
 b=YXpaoTfpb0mbSpeGvCiW12Gi0keR9xjJFa+a62pGwZbCRnvUUFjK4C2+bvaurJ/YMO
 jOc3oD0aegXJJpdaYkGxKXhetlhUopUGHaEupozD6Zp0RllkzOMR1Myi23AxyFaZevEi
 FrSjFoubNKV1Hk0LyXC0/vVJqPM6BMdNXqkNEPMi4vLxRZsAW8/tMqqVB+knCZVd2JLW
 VXVCR0Wg861TwOC/ybL9yb6e85tmNt22hhCAJkjv3e+TEHXGBB+viyd8Fbefm1O/hos2
 r5vGfcWM4cWuYMrnPZKseQvVL2nEbVRmyZgSPpY/AQk3anSQFzRIJjAEJeVKSJJTgWVK
 a7mw==
X-Forwarded-Encrypted: i=1;
 AFNElJ91pzquE3P280ivPJmoAQ26D62HKmbKgFMUb4yzQxry/EQMKHKC2JjiG+NgZlbJmgnez6dCHjU=@lists.denx.de
X-Gm-Message-State: AOJu0YwkdMl0uVRGS8LzLy3Hne+o0SW3Vvk7vxbCQ+innyAvc7cYqU5U
 XGBnEGK+uQaAcc22Pa0ciVngQ85LldmUqTO/dADZGmmfzPBqp8LhDMp/u2oBY6g2Xbs1+x9J09L
 g9XJdtQA=
X-Gm-Gg: AeBDievH+OtyFipwOkhctWO8MCTw/hRWqF88N3cYrKsd9K6jEvMcVRpig54fe3jl3v0
 GvGuFget04GLrfFCVEf/SMmpO6Mqok6ykwEgPaiCZIFEvGttvEq7u5UwKr4fdqIkPV1+94TL/i8
 K79DapUyzknScTQ3Jw0YCxhykN6vcZdrFnWMf19hm/40m3Rj9YIyUvelqUq7tKo9LjBrULaU08x
 GsgPMxp4lUKr+filpLYMZKDrEIBmzZouVTI9rgmG1QF7rgREHbCjP7oMuhQ8VJ8VHT7fbfy8bTX
 cd3twb8WatnMeUhhFxE5VigfbdMgZP9+ndM2Qwp1TNPh/HfkvxBX6mP7/JzRVafdnk8Tt4Btzxv
 8tdauxYLDIyreCUpGYK2YaI+49XDEejoyLlmhnLE9D3NQoVKLXtnNUosCY4HkvZjUTjgd2db8cK
 zXHMl4Xpwkoyq6x+LW7qwpeTiDcZCWT2k+ARW7bR9u1G87g6b6qXvg7xZaBZ4SWoeI820b
X-Received: by 2002:a05:600c:4215:b0:488:d9ea:3da7 with SMTP id
 5b1f17b1804b1-488d9ea3e0cmr92949785e9.10.1776078377245; 
 Mon, 13 Apr 2026 04:06:17 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5347ea5sm327284945e9.8.2026.04.13.04.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 04:06:16 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 13 Apr 2026 13:06:14 +0200
Subject: [PATCH 1/3] soc/qcom: rpmh: properly fix synchronous requests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-casey-qcom-geni-rpmh-fixes-v1-1-2a83a67ac0f1@linaro.org>
References: <20260413-casey-qcom-geni-rpmh-fixes-v1-0-2a83a67ac0f1@linaro.org>
In-Reply-To: <20260413-casey-qcom-geni-rpmh-fixes-v1-0-2a83a67ac0f1@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=7252;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=1kD/9o8ilNvnjXAiRilyTKcZatQVc2MxVZsGbSJ6HfQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw759RE32b4VJZcM6x5LiBxcNGEc6L+QiHXvvmahIqt/
 eBUN+drRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIj9+MDPO/eesdXl5xaquI
 9uZVLsUvLh4umJ3HbFQ8cY1N3JZHSzgZ/qmfm9do0HllzpaQ1XP0IlX/Trf48GL9ilVB6kr1/1c
 usa0CAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

We only ever use a single TCS group and it's always AMC. Disabling AMC
immediately after triggering the TCS group might be contributing to some
of the issues we hit, so let's just defer cleaning things up until just
before we boot the OS. The CMD_ENABLE register is cleared for every rpmh
transation to only select the appropriate commands, and it seems like we
don't need to unset the trigger bit for an AMC either.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 70 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 0b821cc6f9d8..5bf54429e793 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -293,9 +293,9 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 
 	if (msg->wait_for_compl)
 		cmd_msgid |= CMD_MSGID_RESP_REQ;
 
-	cmd_complete = read_tcs_reg(drv, drv->regs[RSC_DRV_CMD_WAIT_FOR_CMPL], tcs_id);
+	cmd_complete = 0; //read_tcs_reg(drv, drv->regs[RSC_DRV_CMD_WAIT_FOR_CMPL], tcs_id);
 
 	for (i = 0, j = cmd_id; i < msg->num_cmds; i++, j++) {
 		cmd = &msg->cmds[i];
 		cmd_enable |= BIT(j);
@@ -306,17 +306,20 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_MSGID], tcs_id, j, msgid);
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], tcs_id, j, cmd->addr);
 		if (!msg->is_read)
 			write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_DATA], tcs_id, j, cmd->data);
-		debug("tcs(%d): [%s] cmd_id: %d: msgid: %#x addr: %#x data: %#x complete: %#x\n",
+		debug("tcs(%d): [%s] cmd_id: %d: msgid: %#x addr: %#x data: %#x read: %d\n",
 		      tcs_id, msg->state == RPMH_ACTIVE_ONLY_STATE ? "active" : "?", j, msgid,
-		      cmd->addr, cmd->data, cmd_complete);
+		      cmd->addr, cmd->data, msg->is_read);
 	}
 
-	cmd_enable |= read_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id);
 	write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, cmd_enable);
 	/* U-Boot: Tell the DRV to wait for completion (?) so we can poll on DRV_STATUS */
 	/* This register applies to the entire TCS group not per command */
+	/*
+	 * FIXME: this seems to rather be a way to impose ordering on commands when multiple are
+	 * sent in a single TCS request, needs more testing.
+	 */
 	write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_WAIT_FOR_CMPL], tcs_id, cmd_complete);
 }
 
 /**
@@ -343,15 +346,14 @@ static void __tcs_set_trigger(struct rsc_drv *drv, int tcs_id, bool trigger)
 
 	/*
 	 * HW req: Clear the DRV_CONTROL and enable TCS again
 	 * While clearing ensure that the AMC mode trigger is cleared
-	 * and then the mode enable is cleared.
+	 * U-Boot: keep AMC_MODE_ENABLE flag since clearing it might be
+	 * interrupting in-flight commands.
 	 */
 	enable = read_tcs_reg(drv, reg, tcs_id);
 	enable &= ~TCS_AMC_MODE_TRIGGER;
 	write_tcs_reg_sync(drv, reg, tcs_id, enable);
-	enable &= ~TCS_AMC_MODE_ENABLE;
-	write_tcs_reg_sync(drv, reg, tcs_id, enable);
 
 	if (trigger) {
 		/* Enable the AMC mode on the TCS and then trigger the TCS */
 		enable = TCS_AMC_MODE_ENABLE;
@@ -387,12 +389,13 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 {
 	struct tcs_group *tcs;
 	int tcs_id, i = 0;
 	u32 val;
+	u32 addr;
 
 	tcs = get_tcs_for_msg(drv, msg);
-	if (IS_ERR_OR_NULL(tcs))
-		return 0;
+	if (IS_ERR(tcs))
+		return PTR_ERR(tcs);
 
 	/* U-Boot is single-threaded, always use the first TCS as we'll never conflict */
 	tcs_id = tcs->offset;
 	if (!read_tcs_reg(drv, drv->regs[RSC_DRV_STATUS], tcs_id)) {
@@ -400,9 +403,8 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 		return -EBUSY;
 	}
 
 	tcs->req[tcs_id - tcs->offset] = msg;
-	generic_set_bit(tcs_id, drv->tcs_in_use);
 
 	/*
 	 * These two can be done after the lock is released because:
 	 * - We marked "tcs_in_use" under lock.
@@ -413,28 +415,35 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 	 */
 	__tcs_buffer_write(drv, tcs_id, 0, msg);
 	__tcs_set_trigger(drv, tcs_id, true);
 
-	/* U-Boot: Now wait for the TCS to be cleared, indicating that we're done. */
+	/*
+	 * U-Boot: Now wait for the status done flag and for the TCS to be cleared.
+	 * Just waiting for one of these isn't always enough. On reads we have to wait for
+	 * the status register to indicate that the response data is ready.
+	 */
+	for (i = 0; i < USEC_PER_SEC; i++) {
+		addr = readl_relaxed(drv->tcs_base + drv->regs[RSC_DRV_IRQ_STATUS]);
+		if (addr & BIT(tcs_id))
+			break;
+		udelay(1);
+	}
+
 	for (i = 0; i < USEC_PER_SEC; i++) {
 		val = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_STATUS], tcs_id, 0);
 		if (val & CMD_STATUS_COMPL)
 			break;
 		udelay(1);
 	}
 
-	/* U-Boot: read the response now we know it's available */
+	/* U-Boot: read the response when it becomes available */
 	if (msg->is_read) {
 		msg->cmds[0].data = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_RESP_DATA], tcs_id, 0);
 		log_debug("data response: %#x\n", msg->cmds[0].data);
 	}
 
 	__tcs_set_trigger(drv, tcs_id, false);
-
-	/* Reclaim the TCS */
-	write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, 0);
 	writel_relaxed(BIT(tcs_id), drv->tcs_base + drv->regs[RSC_DRV_IRQ_CLEAR]);
-	generic_clear_bit(tcs_id, drv->tcs_in_use);
 
 	if (i == USEC_PER_SEC) {
 		log_err("%s: error writing %#x to %d:%#x\n", drv->name,
 			msg->cmds[0].addr, tcs_id, drv->regs[RSC_DRV_CMD_ADDR]);
@@ -563,8 +572,34 @@ static int rpmh_rsc_probe(struct udevice *dev)
 
 	return ret;
 }
 
+static int rpmh_rsc_remove(struct udevice *dev)
+{
+	struct rsc_drv *drv = dev_get_priv(dev);
+	struct tcs_group *tcs = &drv->tcs[ACTIVE_TCS];
+	u32 tcs_id = tcs->offset;
+
+	for (int i = 0; i < 10 && !read_tcs_reg(drv, drv->regs[RSC_DRV_STATUS], tcs_id); i++) {
+		if (i == 0)
+			printf("Waiting for TCS %d to be free...\n", tcs_id);
+		udelay(100);
+	}
+
+	/* Clean up for the OS! */
+	write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_WAIT_FOR_CMPL], tcs_id, 0);
+
+	/* Clear the AMC enable bit for all TCS commands we used */
+	write_tcs_reg_sync(drv, drv->regs[RSC_DRV_CONTROL], tcs_id, 0);
+	/* Disable all commands for the single AMC we used */
+	write_tcs_reg_sync(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, 0);
+
+	/* Make sure IRQs are all clear too */
+	writel_relaxed(tcs->mask, drv->tcs_base + drv->regs[RSC_DRV_IRQ_CLEAR]);
+
+	return 0;
+}
+
 static const struct udevice_id qcom_rpmh_ids[] = {
 	{ .compatible = "qcom,rpmh-rsc" },
 	{ }
 };
@@ -573,11 +608,12 @@ U_BOOT_DRIVER(qcom_rpmh_rsc) = {
 	.name		= "qcom_rpmh_rsc",
 	.id		= UCLASS_MISC,
 	.priv_auto	= sizeof(struct rsc_drv),
 	.probe		= rpmh_rsc_probe,
+	.remove		= rpmh_rsc_remove,
 	.of_match	= qcom_rpmh_ids,
 	/* rpmh is under CLUSTER_PD which we don't support, so skip trying to enable PDs */
-	.flags		= DM_FLAG_DEFAULT_PD_CTRL_OFF,
+	.flags		= DM_FLAG_DEFAULT_PD_CTRL_OFF | DM_FLAG_OS_PREPARE,
 };
 
 MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPMh Driver");
 MODULE_LICENSE("GPL v2");

-- 
2.51.0

