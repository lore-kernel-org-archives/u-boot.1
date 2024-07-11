Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E161C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0FB78875F;
	Thu, 11 Jul 2024 18:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LE5ikNCP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B299D8875F; Thu, 11 Jul 2024 18:46:56 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92EF2883CE
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-59559ea9cfdso1437703a12.0
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716414; x=1721321214; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gpCQH0xF7r1C45qbWyvMYPCvevH2LoiD4m7Hi5vCVgU=;
 b=LE5ikNCPmTSkyAwHOLkJYYVKshzyR7Jge4AShOPmkdzeCnfLv6qU6xA+F/KGYsPDSE
 5TiqloAMIP0T9wnjXLQaj6f2CKesJ6VF1tqPikBhXpw5QSKiXGl24u9Cq4/e2dUv54qH
 gCEmRd5ZiCB7/ZCTTFUZZWKnG5W0QPafacXW+52bIJ30AWG20vIbQUjnoHyC5PtmCgsG
 p0wdJxh1XV0MaByaJ3MWbJEAjszxO6HOVi8LUgg9UWeoahZEyR7/L9xdrYl8vNIGsAvr
 hDcBbdHBy9azRAOGxI87hbqjMFvmjhB7aa/usDumPIRcPz5nTL6WKKk45AekRycr1FgO
 +J9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716414; x=1721321214;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gpCQH0xF7r1C45qbWyvMYPCvevH2LoiD4m7Hi5vCVgU=;
 b=Tm/3scBMEIHcVaW73F9fO1f//54jXIuVNfF5BuIqF/BlHCETdn7cUf+IHFUaKxPpMD
 4zWiQBe56xGvOem45YWlBOPvVXFtiaSeJ5TXY6gyDLpLfKn91HeaexBrdtgihp2EKME9
 Tzqd4DxxNIdAWoTg/QosBP5lTikog8rLk3US6gp4hnrlqUgimIdOSpexKVv70eLC7pcf
 oWPbCMm7lOQrGEtOlzcbcOa4ZnncVk223bPN9lDy/Y7foTL8DAa/pcepxg8l1vhyEV3D
 JwxzDXLgGMVY/2sDNTuPfVm1fYegZ5jermIE96fq2ObDGIgma9VIae2FRG6MzFJ3bnCZ
 A63Q==
X-Gm-Message-State: AOJu0YwNmfevzTOtkb42CXd8ewNDRm4HiZsDgvgdQYAOca7V26SISjkO
 3EZ+wsT+ywd5HaFWSEF7p1IInl7QDUhb5ZN4BrYlx3Q9oG+cmk3qEBsA/cST8Tw=
X-Google-Smtp-Source: AGHT+IFfN76pPk7dI7+SI5qEgFXticTZ0JJT4QouRiZmDuTNstZjE8H7EEiGLRR5L6O4E8tVxoiv0w==
X-Received: by 2002:a17:906:fcb1:b0:a6f:bf5d:b365 with SMTP id
 a640c23a62f3a-a780b6fe485mr691863366b.33.1720716414054; 
 Thu, 11 Jul 2024 09:46:54 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:46:53 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 11 Jul 2024 18:46:42 +0200
Subject: [PATCH v5 10/23] soc: qcom: rpmh-rsc: remaining U-Boot API changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-qcom-rpmh-v5-10-fbf04ce6a7e8@linaro.org>
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5823;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=GhVJ5Qiy7a0vsfphlw+CERSm/D7vS8KmSmDS9bP0sTk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxvOqftuWmuRK6sCn2ZyqjBhabpr9Uyu6zI5
 gLUrT8Pb02JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMbwAKCRAFgzErGV9k
 tlv1D/0aa4KJVzQA+lv2rkBL+LmOqcWFtr5SmkDp8GtjnKzSx4jKbq+67Scq1xz+EnKjR6ahLDl
 YExrh0rkFBuBJwm9pnruVk85fTuFCy954I40msU5W0SX6lU4hXnmjjlaOd9mc6wCGGI+GlVwe2O
 3TQ1n0EWgR/5dUrnBVoEOVSk3VlRIWHso2t7EfSjSphMlMAwtoEmbafHBS+/3U4UlUWN2pcUPr3
 RyYev6V9BOgeuCOticcolgSeLQwYK6mQDZzsQcnZt1uRMA0jKTAvETtLo5fAsushDIMpOnm6gBt
 ACNCXfD8Wt2vkpSoQctw+D2ZBpHScZirKz1LkA+unTVOlsMv4YNMh/iBEtTAg/u1nQX36JFeWMJ
 1s2Yp+RjoDB2RyvZWy59nzQhJDenjsI8N6zKSEz0vxqSBxhb/gmZKf2DqP6fhfEw4irbgOaJtVy
 biUQpZFD6mdOJA9w4ltYlTEkeR3tEpQll78YsRXKVGNLw07AvHr+UVVoSe1FcQZbk/boJBb6Iq/
 xSWh3hlhcVDlzMj1Dz1kNRCQs7wHXZ5DzpXK6t7Go55LcYe/Ly2Nvoqk9V1TuOGEXujOFBLAx8E
 Uf4Kv5+L0WnjAtdw63NMTSnCLxnY+BQF+PnL//d6OtLtL+k9wjkwsDRqG5arD4+H41Y7fqFw/Lj
 PxxXh9iE5GJDINw==
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

Minor adjustments to fix building with U-Boot and work correctly as a
synchronous driver without interrupts. RPMh is fast enough that we can
get away with just firing off requests and assuming they complete.

U-Boot behaviour changes are annotated with a "U-Boot:" comment.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 78 +++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 49 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index d4ef88dda184..566fa16baba9 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -134,16 +134,8 @@ enum {
  *  |                      ......                       |
  *  +---------------------------------------------------+
  */
 
-#define USECS_TO_CYCLES(time_usecs)			\
-	xloops_to_cycles((time_usecs) * 0x10C7UL)
-
-static inline unsigned long xloops_to_cycles(u64 xloops)
-{
-	return (xloops * loops_per_jiffy * HZ) >> 32;
-}
-
 static u32 rpmh_rsc_reg_offset_ver_2_7[] = {
 	[RSC_DRV_TCS_OFFSET]		= 672,
 	[RSC_DRV_CMD_OFFSET]		= 20,
 	[DRV_SOLVER_CONFIG]		= 0x04,
@@ -248,37 +240,18 @@ static void write_tcs_reg_sync(const struct rsc_drv *drv, int reg, int tcs_id,
  */
 static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 					 const struct tcs_request *msg)
 {
-	int type;
-	struct tcs_group *tcs;
-
-	switch (msg->state) {
-	case RPMH_ACTIVE_ONLY_STATE:
-		type = ACTIVE_TCS;
-		break;
-	case RPMH_WAKE_ONLY_STATE:
-		type = WAKE_TCS;
-		break;
-	case RPMH_SLEEP_STATE:
-		type = SLEEP_TCS;
-		break;
-	default:
+	/*
+	 * U-Boot: since we're single threaded and running synchronously we can
+	 * just always used the first active TCS.
+	 */
+	if (msg->state != RPMH_ACTIVE_ONLY_STATE) {
+		log_err("WARN: only ACTIVE_ONLY state supported\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	/*
-	 * If we are making an active request on a RSC that does not have a
-	 * dedicated TCS for active state use, then re-purpose a wake TCS to
-	 * send active votes. This is safe because we ensure any active-only
-	 * transfers have finished before we use it (maybe by running from
-	 * the last CPU in PM code).
-	 */
-	tcs = &drv->tcs[type];
-	if (msg->state == RPMH_ACTIVE_ONLY_STATE && !tcs->num_tcs)
-		tcs = &drv->tcs[WAKE_TCS];
-
-	return tcs;
+	return &drv->tcs[ACTIVE_TCS];
 }
 
 /**
  * __tcs_buffer_write() - Write to TCS hardware from a request; don't trigger.
@@ -298,11 +271,8 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 	u32 cmd_enable = 0;
 	struct tcs_cmd *cmd;
 	int i, j;
 
-	/* Convert all commands to RR when the request has wait_for_compl set */
-	cmd_msgid |= msg->wait_for_compl ? CMD_MSGID_RESP_REQ : 0;
-
 	for (i = 0, j = cmd_id; i < msg->num_cmds; i++, j++) {
 		cmd = &msg->cmds[i];
 		cmd_enable |= BIT(j);
 		msgid = cmd_msgid;
@@ -314,9 +284,11 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_MSGID], tcs_id, j, msgid);
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], tcs_id, j, cmd->addr);
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_DATA], tcs_id, j, cmd->data);
-		trace_rpmh_send_msg(drv, tcs_id, msg->state, j, msgid, cmd);
+		debug("tcs(m): %d [%s] cmd(n): %d msgid: %#x addr: %#x data: %#x complete: %d\n",
+		      tcs_id, msg->state == RPMH_ACTIVE_ONLY_STATE ? "active" : "?", j, msgid,
+		      cmd->addr, cmd->data, cmd->wait);
 	}
 
 	cmd_enable |= read_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id);
 	write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, cmd_enable);
@@ -346,34 +318,28 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
  */
 int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 {
 	struct tcs_group *tcs;
-	int tcs_id;
-
-	might_sleep();
+	int tcs_id, i;
+	u32 addr;
 
 	tcs = get_tcs_for_msg(drv, msg);
 	if (IS_ERR(tcs))
 		return PTR_ERR(tcs);
 
-	spin_lock_irq(&drv->lock);
-
-	/* Wait forever for a free tcs. It better be there eventually! */
-	wait_event_lock_irq(drv->tcs_wait,
-			    (tcs_id = claim_tcs_for_req(drv, tcs, msg)) >= 0,
-			    drv->lock);
+	/* u-boot is single-threaded, always use the first TCS as we'll never conflict */
+	tcs_id = tcs->offset;
 
 	tcs->req[tcs_id - tcs->offset] = msg;
-	set_bit(tcs_id, drv->tcs_in_use);
+	generic_set_bit(tcs_id, drv->tcs_in_use);
 	if (msg->state == RPMH_ACTIVE_ONLY_STATE && tcs->type != ACTIVE_TCS) {
 		/*
 		 * Clear previously programmed WAKE commands in selected
 		 * repurposed TCS to avoid triggering them. tcs->slots will be
 		 * cleaned from rpmh_flush() by invoking rpmh_rsc_invalidate()
 		 */
 		write_tcs_reg_sync(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, 0);
 	}
-	spin_unlock_irq(&drv->lock);
 
 	/*
 	 * These two can be done after the lock is released because:
 	 * - We marked "tcs_in_use" under lock.
@@ -383,8 +349,22 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 	 *   of __tcs_set_trigger() below.
 	 */
 	__tcs_buffer_write(drv, tcs_id, 0, msg);
 
+	/* U-Boot: Now wait for the TCS to be cleared, indicating that we're done */
+	for (i = 0; i < USEC_PER_SEC; i++) {
+		addr = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], i, 0);
+		if (addr != msg->cmds[0].addr)
+			break;
+		udelay(1);
+	}
+
+	if (i == USEC_PER_SEC) {
+		log_err("%s: error writing %#x to %d:%#x\n", drv->name,
+			msg->cmds[0].addr, tcs_id, drv->regs[RSC_DRV_CMD_ADDR]);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
 static int rpmh_probe_tcs_config(struct udevice *dev, struct rsc_drv *drv)

-- 
2.45.2

