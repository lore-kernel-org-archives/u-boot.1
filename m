Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FDCC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2783D88747;
	Mon, 15 Jul 2024 12:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="shS0PPy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C8168883F; Mon, 15 Jul 2024 12:08:22 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C4C088747
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-595850e7e11so5050694a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038099; x=1721642899; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MLpnN4uCLS9UTMgH3jmW6XCVAZA1mkabcby0SWjzMys=;
 b=shS0PPy8/myDkBkd9AM2Uovs+FAXclv5KWFFWfbwiOlN7kFPvgHJEz8fXc1rQL0zUb
 suPmfUuL8jEx0GDx5ACrFIPakOuiYJbhWqkwfCL3J1k4vp8/wpkvOyv5nGWSHXJc5sgI
 pBwytRoEhBGuAJ1ybXdVwXwAyTWwCQ8xPDnssAwIVxgLc8cQLvWZQ3AVU6bFn3sRVyik
 9jAGHUV61THX57KNZvI1J7V1BtvBqyV/tmFnB7x1ILDDEynCqQU5ZV1f56y5csXUrVfO
 TMzftsGKEZCtVpEyjxuFV/g0UOyAnmpQxhYjwHf5gNfYbC0FHqWK44ly/ZyrMMEZNK0h
 Z/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038099; x=1721642899;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MLpnN4uCLS9UTMgH3jmW6XCVAZA1mkabcby0SWjzMys=;
 b=qZHeNbjRcMmcdykR2tvR/Lt2igE7Exy7rbbdp3The6SXm+YCv+wmCYT/ylDe9OEXXO
 Y62VAsFSW3XnnfygUJsCGHhwvYEym7bIaQzPjsOBoH6zi6O9TaZJb1l9tI3UHJ6yOUe6
 utoH1Ej4zgIRT5eHL9OvtfZsKEr2mqyhYzum3bDbPsYh5mhrBVh+/YgTuJCKD/NjX2cR
 gF5ETz5nG5LVCT93WnI2paoQ9rVyMqQSjZ316K0o6FXqFdprRn7QE85tXy/Jz6M1h0Pl
 JJLqPdFNUtgBOWuN0t1MSZXHPMcMa4p65SIDg1QxhTk9+RkezWwgmsA0ku9NH7G549Fv
 6AEw==
X-Gm-Message-State: AOJu0YxR7mg+U20EM8J7gO7sWWYliIUakD5TETam3PNl016AFmEiku1x
 q3mSPbNCMmzI9zEx/Z+iuvmudYBazGCZH0waE+pVYOiGHqqEc0qW5/3qsnKxL9k=
X-Google-Smtp-Source: AGHT+IGu6cjr3vpGCBk/8lvb820nSq99T26VgAFnmHlg971oCWiYtoWGZZbZaNmtrKvQzIOxiK816w==
X-Received: by 2002:a17:906:59b:b0:a77:e0ed:8c4 with SMTP id
 a640c23a62f3a-a780b68a3f0mr1153030666b.7.1721038099259; 
 Mon, 15 Jul 2024 03:08:19 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:18 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:07 +0200
Subject: [PATCH v6 08/24] soc: qcom: rpmh-rsc: drop unused multi-threading
 and non-active TCS support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-8-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=21761;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=VwQpJx5J3ndBDeO8ELX1G51IpAqZT+iASYLc8q6fJkk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUFbdMWyiW+ONVRJePuJo5vMQbAItNT+lSBr
 PIlQXfvteqJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BQAKCRAFgzErGV9k
 thQ5D/sEOU34buBkffyOP8hg7iBkdeYH3dZ3h+I94Fb7wTPzKxpUcrfT0JJZ0Nl3aXpfrQWnIfw
 OrePz5N2P/Q7Po0wExtKuZRV/L3GgEyC8teD1MjW1lBOFCzVOQ6MW0CBr9TLeBtOV5YPB1w4VAV
 /tZNKG2Q1/wmzZ93xWE0+67WwuvcvuUfaL8RUDm9M5CogzPX00JA5kDqjeswIZUpvGpUh9g/wQD
 hjNWK2JlovFFrLTMAH075MUfk+BRTKLMRGtN5fT2dPkvSBMk2vsSBkwPx018wZ7tDTQetagdfXO
 iRg6gZar1U1XG5RLu9Xp66P9ru/uTHp27XuB862CMfqBxa/0MyuK+AB6IGPlRZ40IhGsKt9XzHH
 QS9lQQvRNtRdM7/IsYExrxbqJ0tYLj/OjioakkffEOgnIO68xaeKDuefkCRR2p3ycUi0dr8XqGA
 ad7HL88n9UQDqwrxLRu2BNYTkbFc+m/SzSsl+6H8cxJMo7Vn2CuP5TKIIioa41JQoityKRLLyr8
 TXLaj69/pjX1jQRKDzN0GpC0xj/Ykli2UPHIF1DgW2onL86HctSXiKQVaQFLsiAdyc851oN2Ise
 NwoI/FiVzBj+vOX+T26+9FxU9DBKLGuIQgn2duRW8BUkh18gItZMnA2yi9IRZvDcdiKKT9j+TRc
 WlH50cwjxpNXt8g==
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

Since U-Boot is single threaded, we can avoid most of the complexity
that comes with handling more than one in-flight TCS. Drop all the rpmh
code associated with multi-threading as we'll instead wait for a
response on each TCS.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/rpmh-internal.h |   4 -
 drivers/soc/qcom/rpmh-rsc.c      | 562 ---------------------------------------
 2 files changed, 566 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index e3cf1beff803..12c5b8d9cf86 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -139,10 +139,6 @@ struct rsc_drv {
 int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
 int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
 			     const struct tcs_request *msg);
 void rpmh_rsc_invalidate(struct rsc_drv *drv);
-void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv);
-
-void rpmh_tx_done(const struct tcs_request *msg);
-int rpmh_flush(struct rpmh_ctrlr *ctrlr);
 
 #endif /* __RPM_INTERNAL_H__ */
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index de86009ecd91..fc8321bf208f 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -246,49 +246,8 @@ static void write_tcs_reg_sync(const struct rsc_drv *drv, int reg, int tcs_id,
 	pr_err("%s: error writing %#x to %d:%#x\n", drv->name,
 	       data, tcs_id, reg);
 }
 
-/**
- * tcs_invalidate() - Invalidate all TCSes of the given type (sleep or wake).
- * @drv:  The RSC controller.
- * @type: SLEEP_TCS or WAKE_TCS
- *
- * This will clear the "slots" variable of the given tcs_group and also
- * tell the hardware to forget about all entries.
- *
- * The caller must ensure that no other RPMH actions are happening when this
- * function is called, since otherwise the device may immediately become
- * used again even before this function exits.
- */
-static void tcs_invalidate(struct rsc_drv *drv, int type)
-{
-	int m;
-	struct tcs_group *tcs = &drv->tcs[type];
-
-	/* Caller ensures nobody else is running so no lock */
-	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS))
-		return;
-
-	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++)
-		write_tcs_reg_sync(drv, drv->regs[RSC_DRV_CMD_ENABLE], m, 0);
-
-	bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
-}
-
-/**
- * rpmh_rsc_invalidate() - Invalidate sleep and wake TCSes.
- * @drv: The RSC controller.
- *
- * The caller must ensure that no other RPMH actions are happening when this
- * function is called, since otherwise the device may immediately become
- * used again even before this function exits.
- */
-void rpmh_rsc_invalidate(struct rsc_drv *drv)
-{
-	tcs_invalidate(drv, SLEEP_TCS);
-	tcs_invalidate(drv, WAKE_TCS);
-}
-
 /**
  * get_tcs_for_msg() - Get the tcs_group used to send the given message.
  * @drv: The RSC controller.
  * @msg: The message we want to send.
@@ -331,158 +290,8 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 
 	return tcs;
 }
 
-/**
- * get_req_from_tcs() - Get a stashed request that was xfering on the given TCS.
- * @drv:    The RSC controller.
- * @tcs_id: The global ID of this TCS.
- *
- * For ACTIVE_ONLY transfers we want to call back into the client when the
- * transfer finishes. To do this we need the "request" that the client
- * originally provided us. This function grabs the request that we stashed
- * when we started the transfer.
- *
- * This only makes sense for ACTIVE_ONLY transfers since those are the only
- * ones we track sending (the only ones we enable interrupts for and the only
- * ones we call back to the client for).
- *
- * Return: The stashed request.
- */
-static const struct tcs_request *get_req_from_tcs(struct rsc_drv *drv,
-						  int tcs_id)
-{
-	struct tcs_group *tcs;
-	int i;
-
-	for (i = 0; i < TCS_TYPE_NR; i++) {
-		tcs = &drv->tcs[i];
-		if (tcs->mask & BIT(tcs_id))
-			return tcs->req[tcs_id - tcs->offset];
-	}
-
-	return NULL;
-}
-
-/**
- * __tcs_set_trigger() - Start xfer on a TCS or unset trigger on a borrowed TCS
- * @drv:     The controller.
- * @tcs_id:  The global ID of this TCS.
- * @trigger: If true then untrigger/retrigger. If false then just untrigger.
- *
- * In the normal case we only ever call with "trigger=true" to start a
- * transfer. That will un-trigger/disable the TCS from the last transfer
- * then trigger/enable for this transfer.
- *
- * If we borrowed a wake TCS for an active-only transfer we'll also call
- * this function with "trigger=false" to just do the un-trigger/disable
- * before using the TCS for wake purposes again.
- *
- * Note that the AP is only in charge of triggering active-only transfers.
- * The AP never triggers sleep/wake values using this function.
- */
-static void __tcs_set_trigger(struct rsc_drv *drv, int tcs_id, bool trigger)
-{
-	u32 enable;
-	u32 reg = drv->regs[RSC_DRV_CONTROL];
-
-	/*
-	 * HW req: Clear the DRV_CONTROL and enable TCS again
-	 * While clearing ensure that the AMC mode trigger is cleared
-	 * and then the mode enable is cleared.
-	 */
-	enable = read_tcs_reg(drv, reg, tcs_id);
-	enable &= ~TCS_AMC_MODE_TRIGGER;
-	write_tcs_reg_sync(drv, reg, tcs_id, enable);
-	enable &= ~TCS_AMC_MODE_ENABLE;
-	write_tcs_reg_sync(drv, reg, tcs_id, enable);
-
-	if (trigger) {
-		/* Enable the AMC mode on the TCS and then trigger the TCS */
-		enable = TCS_AMC_MODE_ENABLE;
-		write_tcs_reg_sync(drv, reg, tcs_id, enable);
-		enable |= TCS_AMC_MODE_TRIGGER;
-		write_tcs_reg(drv, reg, tcs_id, enable);
-	}
-}
-
-/**
- * enable_tcs_irq() - Enable or disable interrupts on the given TCS.
- * @drv:     The controller.
- * @tcs_id:  The global ID of this TCS.
- * @enable:  If true then enable; if false then disable
- *
- * We only ever call this when we borrow a wake TCS for an active-only
- * transfer. For active-only TCSes interrupts are always left enabled.
- */
-static void enable_tcs_irq(struct rsc_drv *drv, int tcs_id, bool enable)
-{
-	u32 data;
-	u32 reg = drv->regs[RSC_DRV_IRQ_ENABLE];
-
-	data = readl_relaxed(drv->tcs_base + reg);
-	if (enable)
-		data |= BIT(tcs_id);
-	else
-		data &= ~BIT(tcs_id);
-	writel_relaxed(data, drv->tcs_base + reg);
-}
-
-/**
- * tcs_tx_done() - TX Done interrupt handler.
- * @irq: The IRQ number (ignored).
- * @p:   Pointer to "struct rsc_drv".
- *
- * Called for ACTIVE_ONLY transfers (those are the only ones we enable the
- * IRQ for) when a transfer is done.
- *
- * Return: IRQ_HANDLED
- */
-static irqreturn_t tcs_tx_done(int irq, void *p)
-{
-	struct rsc_drv *drv = p;
-	int i;
-	unsigned long irq_status;
-	const struct tcs_request *req;
-
-	irq_status = readl_relaxed(drv->tcs_base + drv->regs[RSC_DRV_IRQ_STATUS]);
-
-	for_each_set_bit(i, &irq_status, BITS_PER_TYPE(u32)) {
-		req = get_req_from_tcs(drv, i);
-		if (WARN_ON(!req))
-			goto skip;
-
-		trace_rpmh_tx_done(drv, i, req);
-
-		/*
-		 * If wake tcs was re-purposed for sending active
-		 * votes, clear AMC trigger & enable modes and
-		 * disable interrupt for this TCS
-		 */
-		if (!drv->tcs[ACTIVE_TCS].num_tcs)
-			__tcs_set_trigger(drv, i, false);
-skip:
-		/* Reclaim the TCS */
-		write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], i, 0);
-		writel_relaxed(BIT(i), drv->tcs_base + drv->regs[RSC_DRV_IRQ_CLEAR]);
-		spin_lock(&drv->lock);
-		clear_bit(i, drv->tcs_in_use);
-		/*
-		 * Disable interrupt for WAKE TCS to avoid being
-		 * spammed with interrupts coming when the solver
-		 * sends its wake votes.
-		 */
-		if (!drv->tcs[ACTIVE_TCS].num_tcs)
-			enable_tcs_irq(drv, i, false);
-		spin_unlock(&drv->lock);
-		wake_up(&drv->tcs_wait);
-		if (req)
-			rpmh_tx_done(req);
-	}
-
-	return IRQ_HANDLED;
-}
-
 /**
  * __tcs_buffer_write() - Write to TCS hardware from a request; don't trigger.
  * @drv:    The controller.
  * @tcs_id: The global ID of this TCS.
@@ -523,104 +332,8 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 	cmd_enable |= read_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id);
 	write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, cmd_enable);
 }
 
-/**
- * check_for_req_inflight() - Look to see if conflicting cmds are in flight.
- * @drv: The controller.
- * @tcs: A pointer to the tcs_group used for ACTIVE_ONLY transfers.
- * @msg: The message we want to send, which will contain several addr/data
- *       pairs to program (but few enough that they all fit in one TCS).
- *
- * This will walk through the TCSes in the group and check if any of them
- * appear to be sending to addresses referenced in the message. If it finds
- * one it'll return -EBUSY.
- *
- * Only for use for active-only transfers.
- *
- * Must be called with the drv->lock held since that protects tcs_in_use.
- *
- * Return: 0 if nothing in flight or -EBUSY if we should try again later.
- *         The caller must re-enable interrupts between tries since that's
- *         the only way tcs_in_use will ever be updated and the only way
- *         RSC_DRV_CMD_ENABLE will ever be cleared.
- */
-static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
-				  const struct tcs_request *msg)
-{
-	unsigned long curr_enabled;
-	u32 addr;
-	int j, k;
-	int i = tcs->offset;
-
-	for_each_set_bit_from(i, drv->tcs_in_use, tcs->offset + tcs->num_tcs) {
-		curr_enabled = read_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], i);
-
-		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
-			addr = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], i, j);
-			for (k = 0; k < msg->num_cmds; k++) {
-				if (cmd_db_match_resource_addr(msg->cmds[k].addr, addr))
-					return -EBUSY;
-			}
-		}
-	}
-
-	return 0;
-}
-
-/**
- * find_free_tcs() - Find free tcs in the given tcs_group; only for active.
- * @tcs: A pointer to the active-only tcs_group (or the wake tcs_group if
- *       we borrowed it because there are zero active-only ones).
- *
- * Must be called with the drv->lock held since that protects tcs_in_use.
- *
- * Return: The first tcs that's free or -EBUSY if all in use.
- */
-static int find_free_tcs(struct tcs_group *tcs)
-{
-	const struct rsc_drv *drv = tcs->drv;
-	unsigned long i;
-	unsigned long max = tcs->offset + tcs->num_tcs;
-
-	i = find_next_zero_bit(drv->tcs_in_use, max, tcs->offset);
-	if (i >= max)
-		return -EBUSY;
-
-	return i;
-}
-
-/**
- * claim_tcs_for_req() - Claim a tcs in the given tcs_group; only for active.
- * @drv: The controller.
- * @tcs: The tcs_group used for ACTIVE_ONLY transfers.
- * @msg: The data to be sent.
- *
- * Claims a tcs in the given tcs_group while making sure that no existing cmd
- * is in flight that would conflict with the one in @msg.
- *
- * Context: Must be called with the drv->lock held since that protects
- * tcs_in_use.
- *
- * Return: The id of the claimed tcs or -EBUSY if a matching msg is in flight
- * or the tcs_group is full.
- */
-static int claim_tcs_for_req(struct rsc_drv *drv, struct tcs_group *tcs,
-			     const struct tcs_request *msg)
-{
-	int ret;
-
-	/*
-	 * The h/w does not like if we send a request to the same address,
-	 * when one is already in-flight or being processed.
-	 */
-	ret = check_for_req_inflight(drv, tcs, msg);
-	if (ret)
-		return ret;
-
-	return find_free_tcs(tcs);
-}
-
 /**
  * rpmh_rsc_send_data() - Write / trigger active-only message.
  * @drv: The controller.
  * @msg: The data to be sent.
@@ -668,9 +381,8 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 		 * repurposed TCS to avoid triggering them. tcs->slots will be
 		 * cleaned from rpmh_flush() by invoking rpmh_rsc_invalidate()
 		 */
 		write_tcs_reg_sync(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, 0);
-		enable_tcs_irq(drv, tcs_id, true);
 	}
 	spin_unlock_irq(&drv->lock);
 
 	/*
@@ -681,286 +393,12 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 	 * - The interrupt can't go off until we trigger w/ the last line
 	 *   of __tcs_set_trigger() below.
 	 */
 	__tcs_buffer_write(drv, tcs_id, 0, msg);
-	__tcs_set_trigger(drv, tcs_id, true);
 
 	return 0;
 }
 
-/**
- * find_slots() - Find a place to write the given message.
- * @tcs:    The tcs group to search.
- * @msg:    The message we want to find room for.
- * @tcs_id: If we return 0 from the function, we return the global ID of the
- *          TCS to write to here.
- * @cmd_id: If we return 0 from the function, we return the index of
- *          the command array of the returned TCS where the client should
- *          start writing the message.
- *
- * Only for use on sleep/wake TCSes since those are the only ones we maintain
- * tcs->slots for.
- *
- * Return: -ENOMEM if there was no room, else 0.
- */
-static int find_slots(struct tcs_group *tcs, const struct tcs_request *msg,
-		      int *tcs_id, int *cmd_id)
-{
-	int slot, offset;
-	int i = 0;
-
-	/* Do over, until we can fit the full payload in a single TCS */
-	do {
-		slot = bitmap_find_next_zero_area(tcs->slots, MAX_TCS_SLOTS,
-						  i, msg->num_cmds, 0);
-		if (slot >= tcs->num_tcs * tcs->ncpt)
-			return -ENOMEM;
-		i += tcs->ncpt;
-	} while (slot + msg->num_cmds - 1 >= i);
-
-	bitmap_set(tcs->slots, slot, msg->num_cmds);
-
-	offset = slot / tcs->ncpt;
-	*tcs_id = offset + tcs->offset;
-	*cmd_id = slot % tcs->ncpt;
-
-	return 0;
-}
-
-/**
- * rpmh_rsc_write_ctrl_data() - Write request to controller but don't trigger.
- * @drv: The controller.
- * @msg: The data to be written to the controller.
- *
- * This should only be called for sleep/wake state, never active-only
- * state.
- *
- * The caller must ensure that no other RPMH actions are happening and the
- * controller is idle when this function is called since it runs lockless.
- *
- * Return: 0 if no error; else -error.
- */
-int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
-{
-	struct tcs_group *tcs;
-	int tcs_id = 0, cmd_id = 0;
-	int ret;
-
-	tcs = get_tcs_for_msg(drv, msg);
-	if (IS_ERR(tcs))
-		return PTR_ERR(tcs);
-
-	/* find the TCS id and the command in the TCS to write to */
-	ret = find_slots(tcs, msg, &tcs_id, &cmd_id);
-	if (!ret)
-		__tcs_buffer_write(drv, tcs_id, cmd_id, msg);
-
-	return ret;
-}
-
-/**
- * rpmh_rsc_ctrlr_is_busy() - Check if any of the AMCs are busy.
- * @drv: The controller
- *
- * Checks if any of the AMCs are busy in handling ACTIVE sets.
- * This is called from the last cpu powering down before flushing
- * SLEEP and WAKE sets. If AMCs are busy, controller can not enter
- * power collapse, so deny from the last cpu's pm notification.
- *
- * Context: Must be called with the drv->lock held.
- *
- * Return:
- * * False		- AMCs are idle
- * * True		- AMCs are busy
- */
-static bool rpmh_rsc_ctrlr_is_busy(struct rsc_drv *drv)
-{
-	unsigned long set;
-	const struct tcs_group *tcs = &drv->tcs[ACTIVE_TCS];
-	unsigned long max;
-
-	/*
-	 * If we made an active request on a RSC that does not have a
-	 * dedicated TCS for active state use, then re-purposed wake TCSes
-	 * should be checked for not busy, because we used wake TCSes for
-	 * active requests in this case.
-	 */
-	if (!tcs->num_tcs)
-		tcs = &drv->tcs[WAKE_TCS];
-
-	max = tcs->offset + tcs->num_tcs;
-	set = find_next_bit(drv->tcs_in_use, max, tcs->offset);
-
-	return set < max;
-}
-
-/**
- * rpmh_rsc_write_next_wakeup() - Write next wakeup in CONTROL_TCS.
- * @drv: The controller
- *
- * Writes maximum wakeup cycles when called from suspend.
- * Writes earliest hrtimer wakeup when called from idle.
- */
-void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv)
-{
-	ktime_t now, wakeup;
-	u64 wakeup_us, wakeup_cycles = ~0;
-	u32 lo, hi;
-
-	if (!drv->tcs[CONTROL_TCS].num_tcs || !drv->genpd_nb.notifier_call)
-		return;
-
-	/* Set highest time when system (timekeeping) is suspended */
-	if (system_state == SYSTEM_SUSPEND)
-		goto exit;
-
-	/* Find the earliest hrtimer wakeup from online cpus */
-	wakeup = dev_pm_genpd_get_next_hrtimer(drv->dev);
-
-	/* Find the relative wakeup in kernel time scale */
-	now = ktime_get();
-	wakeup = ktime_sub(wakeup, now);
-	wakeup_us = ktime_to_us(wakeup);
-
-	/* Convert the wakeup to arch timer scale */
-	wakeup_cycles = USECS_TO_CYCLES(wakeup_us);
-	wakeup_cycles += arch_timer_read_counter();
-
-exit:
-	lo = wakeup_cycles & RSC_DRV_CTL_TCS_DATA_LO_MASK;
-	hi = wakeup_cycles >> RSC_DRV_CTL_TCS_DATA_SIZE;
-	hi &= RSC_DRV_CTL_TCS_DATA_HI_MASK;
-	hi |= RSC_DRV_CTL_TCS_DATA_HI_VALID;
-
-	writel_relaxed(lo, drv->base + RSC_DRV_CTL_TCS_DATA_LO);
-	writel_relaxed(hi, drv->base + RSC_DRV_CTL_TCS_DATA_HI);
-}
-
-/**
- * rpmh_rsc_cpu_pm_callback() - Check if any of the AMCs are busy.
- * @nfb:    Pointer to the notifier block in struct rsc_drv.
- * @action: CPU_PM_ENTER, CPU_PM_ENTER_FAILED, or CPU_PM_EXIT.
- * @v:      Unused
- *
- * This function is given to cpu_pm_register_notifier so we can be informed
- * about when CPUs go down. When all CPUs go down we know no more active
- * transfers will be started so we write sleep/wake sets. This function gets
- * called from cpuidle code paths and also at system suspend time.
- *
- * If its last CPU going down and AMCs are not busy then writes cached sleep
- * and wake messages to TCSes. The firmware then takes care of triggering
- * them when entering deepest low power modes.
- *
- * Return: See cpu_pm_register_notifier()
- */
-static int rpmh_rsc_cpu_pm_callback(struct notifier_block *nfb,
-				    unsigned long action, void *v)
-{
-	struct rsc_drv *drv = container_of(nfb, struct rsc_drv, rsc_pm);
-	int ret = NOTIFY_OK;
-	int cpus_in_pm;
-
-	switch (action) {
-	case CPU_PM_ENTER:
-		cpus_in_pm = atomic_inc_return(&drv->cpus_in_pm);
-		/*
-		 * NOTE: comments for num_online_cpus() point out that it's
-		 * only a snapshot so we need to be careful. It should be OK
-		 * for us to use, though.  It's important for us not to miss
-		 * if we're the last CPU going down so it would only be a
-		 * problem if a CPU went offline right after we did the check
-		 * AND that CPU was not idle AND that CPU was the last non-idle
-		 * CPU. That can't happen. CPUs would have to come out of idle
-		 * before the CPU could go offline.
-		 */
-		if (cpus_in_pm < num_online_cpus())
-			return NOTIFY_OK;
-		break;
-	case CPU_PM_ENTER_FAILED:
-	case CPU_PM_EXIT:
-		atomic_dec(&drv->cpus_in_pm);
-		return NOTIFY_OK;
-	default:
-		return NOTIFY_DONE;
-	}
-
-	/*
-	 * It's likely we're on the last CPU. Grab the drv->lock and write
-	 * out the sleep/wake commands to RPMH hardware. Grabbing the lock
-	 * means that if we race with another CPU coming up we are still
-	 * guaranteed to be safe. If another CPU came up just after we checked
-	 * and has grabbed the lock or started an active transfer then we'll
-	 * notice we're busy and abort. If another CPU comes up after we start
-	 * flushing it will be blocked from starting an active transfer until
-	 * we're done flushing. If another CPU starts an active transfer after
-	 * we release the lock we're still OK because we're no longer the last
-	 * CPU.
-	 */
-	if (spin_trylock(&drv->lock)) {
-		if (rpmh_rsc_ctrlr_is_busy(drv) || rpmh_flush(&drv->client))
-			ret = NOTIFY_BAD;
-		spin_unlock(&drv->lock);
-	} else {
-		/* Another CPU must be up */
-		return NOTIFY_OK;
-	}
-
-	if (ret == NOTIFY_BAD) {
-		/* Double-check if we're here because someone else is up */
-		if (cpus_in_pm < num_online_cpus())
-			ret = NOTIFY_OK;
-		else
-			/* We won't be called w/ CPU_PM_ENTER_FAILED */
-			atomic_dec(&drv->cpus_in_pm);
-	}
-
-	return ret;
-}
-
-/**
- * rpmh_rsc_pd_callback() - Check if any of the AMCs are busy.
- * @nfb:    Pointer to the genpd notifier block in struct rsc_drv.
- * @action: GENPD_NOTIFY_PRE_OFF, GENPD_NOTIFY_OFF, GENPD_NOTIFY_PRE_ON or GENPD_NOTIFY_ON.
- * @v:      Unused
- *
- * This function is given to dev_pm_genpd_add_notifier() so we can be informed
- * about when cluster-pd is going down. When cluster go down we know no more active
- * transfers will be started so we write sleep/wake sets. This function gets
- * called from cpuidle code paths and also at system suspend time.
- *
- * If AMCs are not busy then writes cached sleep and wake messages to TCSes.
- * The firmware then takes care of triggering them when entering deepest low power modes.
- *
- * Return:
- * * NOTIFY_OK          - success
- * * NOTIFY_BAD         - failure
- */
-static int rpmh_rsc_pd_callback(struct notifier_block *nfb,
-				unsigned long action, void *v)
-{
-	struct rsc_drv *drv = container_of(nfb, struct rsc_drv, genpd_nb);
-
-	/* We don't need to lock as genpd on/off are serialized */
-	if ((action == GENPD_NOTIFY_PRE_OFF) &&
-	    (rpmh_rsc_ctrlr_is_busy(drv) || rpmh_flush(&drv->client)))
-		return NOTIFY_BAD;
-
-	return NOTIFY_OK;
-}
-
-static int rpmh_rsc_pd_attach(struct rsc_drv *drv, struct device *dev)
-{
-	int ret;
-
-	pm_runtime_enable(dev);
-	drv->genpd_nb.notifier_call = rpmh_rsc_pd_callback;
-	ret = dev_pm_genpd_add_notifier(dev, &drv->genpd_nb);
-	if (ret)
-		pm_runtime_disable(dev);
-
-	return ret;
-}
-
 static int rpmh_probe_tcs_config(struct platform_device *pdev, struct rsc_drv *drv)
 {
 	struct tcs_type_config {
 		u32 type;

-- 
2.45.2

