Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7E5C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E59688877;
	Mon, 15 Jul 2024 12:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eELpGUci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBEE18885C; Mon, 15 Jul 2024 12:08:47 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D6C388842
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52ea929ea56so7561970e87.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038125; x=1721642925; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uG0yeXPjYJbgCl1X/zbvHqsKJshfjohIdYI3Cg6jDpQ=;
 b=eELpGUcinrorB//o/eY87qC/YCQbbgToysjYX6j/V3GkeuXVxrXDfqbrtAaYsP8a9t
 9rFMSBe41ckDdK9cyls+ieiAJ1sMqQFWRFZ3k9OBpYQYHGyki1LLY/+9goJObLzp1J8F
 ngyQdiP2p+Nsv7PJhJu/Zxfd1czGd1KokMokyO6pCDSe39IhafQ+UpFynkTnJthlnQ0k
 5kqcqO5g7gvVUXJyEhEaEXf0vFf+RET0tM10XVs7kz//PixdJjxL7jqqt6LqIPrlVs4g
 7LT61S5RwyxsAVxm8J4+G7Hu3a+ar3GBktR1ppYM9p93QBZWyvUxn5OIwX5SvRcxYX6j
 nW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038125; x=1721642925;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uG0yeXPjYJbgCl1X/zbvHqsKJshfjohIdYI3Cg6jDpQ=;
 b=pchEZQ1mO3kiDtZR5dtN5NDS35i9wk+NwxoU85PvjvnH6GUmkPWFdM3sdVe7GAmCV0
 3+Ttr2g2O5aW0hfUfPhwKoszgR1M/Ko04tKULjrDjpNRG2Jwol1sMS5IfppdobNFOX7Y
 VejtQa3oP3coeTzkdUzyipg7IMnCLUt0ZH9P1eSMzHHCGn+tWFqNcKdrdKL/nmyXs/2e
 zLh3BiQ+8jdtfI9NDkU5hH1KCc24RsL4iGUVVy+hyKAUZmJW2gpY8q+q2GVtiVzIWy1J
 zjF3VNVcg+YXmJn/Sh8dncoMyrtnn8dovA9XO91PfAlr1fj/ZLeZid3lBn1TBhqm4kVH
 0V3w==
X-Gm-Message-State: AOJu0YxEJHVIXx9LfZENhpO6hl96414M5wjeE8zOS4JrfKpIEI1n5RQF
 eqFuyCxk/QMhPXYkqjvwvLkxk20zr2S8OLYf59/U95fV5N8T6EKcPsfYyW/cd4Q=
X-Google-Smtp-Source: AGHT+IExL62EyOKB9/eXhSuhFuhuKyOSyE5gJ1/zOnWZ/g2fzvJkGgOt2NUfrw2KpKEsGeROtqaktg==
X-Received: by 2002:a19:8c05:0:b0:52c:8909:bd35 with SMTP id
 2adb3069b0e04-52eb9991eb3mr13328177e87.10.1721038124925; 
 Mon, 15 Jul 2024 03:08:44 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:44 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:12 +0200
Subject: [PATCH v6 13/24] soc: qcom: rpmh: drop unused functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-13-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12286;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=1RcEbGhTRCvxL78q80ivcA+VWpX0uhznCXCB7s81n00=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUGtdYKzxPBA14rnZCqdFTuRG81IVE8z7Ap/
 h+z1a3Y8TWJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BgAKCRAFgzErGV9k
 tp2ND/4xuBrMkYHg2qcRzEiOqdBWeP9w2QY3gAdGgTu0JduIv++3ZYVJQV/y/WXZnW+UoRbz/KD
 dZ70Wh8bi/z4qtE4ToptH2c9IiW0xCYtePItEnMD+V+zTfB429mVfIr3mFy/0+Yt5TP8iBI14JZ
 t6z9Gnjk5Dq2pJfZJ3x+RoZSZBfGpKiLlpvm9d3iVk+xE5ICItRDwY6+z4KESe/EIx4Vgb+Ex4K
 60o/v0t+OdjQag89fsfN4E3viLFgILpGDXqY7GljZR++uVG0whFvgUkdBMoqYQojCVqrr342XBR
 JEZXU0LzxfWPfPXk9fO5UJCnTCV86WYpVNGIZ/jWXy+zbpdl3NlQ2N8x7bgKNHMoO52SH4SW/Vz
 I/PN2gFkTEmz5iVsj8upnoHx5HvcMZmWGwGyeQG1wtzpqn+vftIe1VpXIAP4jn4n9nm9x/vqTQw
 ZaujeHZ1jUFdzijO6DQndtMKvFv7qpqNfCAkco4XSCAOrrW6tPAdH4gJz70Kl6snz/YzR4v1v4J
 j2rLLvOSKLR3D6vUhZLTKGGfiW9jmk6Ui0skMmC8Wh5nTRE/EpkLJRXsqnE86Q+6hDp8qMPSNcl
 1fNuR5roX/NmR5Vq6aQqjwECnV+C9I3Mnxom081w3k9Je8cBFNr59kVhjvlmw6/8hCLm+0UV74U
 mgXOLake2LYcpxQ==
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

A lot of the features in here are only relevant when running
multi-threaded with interrupts. Drop everything except what we need to
run single-threaded with a single TCS (which is all the rpmh-rsc
framework in U-Boot supports).

Keep rpmh_write_async() for simplicity and make it wrap the regular
rpmh_write().

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/rpmh.c | 371 ------------------------------------------------
 include/soc/qcom/rpmh.h |  25 +---
 2 files changed, 3 insertions(+), 393 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 03ef4106c9a6..22605e0291a1 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -31,124 +31,15 @@
 	}
 
 #define ctrlr_to_drv(ctrlr) container_of(ctrlr, struct rsc_drv, client)
 
-/**
- * struct cache_req: the request object for caching
- *
- * @addr: the address of the resource
- * @sleep_val: the sleep vote
- * @wake_val: the wake vote
- * @list: linked list obj
- */
-struct cache_req {
-	u32 addr;
-	u32 sleep_val;
-	u32 wake_val;
-	struct list_head list;
-};
-
-/**
- * struct batch_cache_req - An entry in our batch catch
- *
- * @list: linked list obj
- * @count: number of messages
- * @rpm_msgs: the messages
- */
-
-struct batch_cache_req {
-	struct list_head list;
-	int count;
-	struct rpmh_request rpm_msgs[];
-};
-
 static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
 {
 	struct rsc_drv *drv = dev_get_drvdata(dev->parent);
 
 	return &drv->client;
 }
 
-void rpmh_tx_done(const struct tcs_request *msg)
-{
-	struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
-						    msg);
-	struct completion *compl = rpm_msg->completion;
-	bool free = rpm_msg->needs_free;
-
-	if (!compl)
-		goto exit;
-
-	/* Signal the blocking thread we are done */
-	complete(compl);
-
-exit:
-	if (free)
-		kfree(rpm_msg);
-}
-
-static struct cache_req *__find_req(struct rpmh_ctrlr *ctrlr, u32 addr)
-{
-	struct cache_req *p, *req = NULL;
-
-	list_for_each_entry(p, &ctrlr->cache, list) {
-		if (p->addr == addr) {
-			req = p;
-			break;
-		}
-	}
-
-	return req;
-}
-
-static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
-					   enum rpmh_state state,
-					   struct tcs_cmd *cmd)
-{
-	struct cache_req *req;
-	unsigned long flags;
-	u32 old_sleep_val, old_wake_val;
-
-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
-	req = __find_req(ctrlr, cmd->addr);
-	if (req)
-		goto existing;
-
-	req = kzalloc(sizeof(*req), GFP_ATOMIC);
-	if (!req) {
-		req = ERR_PTR(-ENOMEM);
-		goto unlock;
-	}
-
-	req->addr = cmd->addr;
-	req->sleep_val = req->wake_val = UINT_MAX;
-	list_add_tail(&req->list, &ctrlr->cache);
-
-existing:
-	old_sleep_val = req->sleep_val;
-	old_wake_val = req->wake_val;
-
-	switch (state) {
-	case RPMH_ACTIVE_ONLY_STATE:
-	case RPMH_WAKE_ONLY_STATE:
-		req->wake_val = cmd->data;
-		break;
-	case RPMH_SLEEP_STATE:
-		req->sleep_val = cmd->data;
-		break;
-	}
-
-	ctrlr->dirty |= (req->sleep_val != old_sleep_val ||
-			 req->wake_val != old_wake_val) &&
-			 req->sleep_val != UINT_MAX &&
-			 req->wake_val != UINT_MAX;
-
-unlock:
-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
-
-	return req;
-}
-
 /**
  * __rpmh_write: Cache and send the RPMH request
  *
  * @dev: The device making the request
@@ -199,40 +90,8 @@ static int __fill_rpmh_msg(struct rpmh_request *req, enum rpmh_state state,
 
 	return 0;
 }
 
-/**
- * rpmh_write_async: Write a set of RPMH commands
- *
- * @dev: The device making the request
- * @state: Active/sleep set
- * @cmd: The payload data
- * @n: The number of elements in payload
- *
- * Write a set of RPMH commands, the order of commands is maintained
- * and will be sent as a single shot.
- */
-int rpmh_write_async(const struct device *dev, enum rpmh_state state,
-		     const struct tcs_cmd *cmd, u32 n)
-{
-	struct rpmh_request *rpm_msg;
-	int ret;
-
-	rpm_msg = kzalloc(sizeof(*rpm_msg), GFP_ATOMIC);
-	if (!rpm_msg)
-		return -ENOMEM;
-	rpm_msg->needs_free = true;
-
-	ret = __fill_rpmh_msg(rpm_msg, state, cmd, n);
-	if (ret) {
-		kfree(rpm_msg);
-		return ret;
-	}
-
-	return __rpmh_write(dev, state, rpm_msg);
-}
-EXPORT_SYMBOL_GPL(rpmh_write_async);
-
 /**
  * rpmh_write: Write a set of RPMH commands and block until response
  *
  * @dev: The device making the request
@@ -261,234 +120,4 @@ int rpmh_write(const struct device *dev, enum rpmh_state state,
 	WARN_ON(!ret);
 	return (ret > 0) ? 0 : -ETIMEDOUT;
 }
 EXPORT_SYMBOL_GPL(rpmh_write);
-
-static void cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
-	list_add_tail(&req->list, &ctrlr->batch_cache);
-	ctrlr->dirty = true;
-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
-}
-
-static int flush_batch(struct rpmh_ctrlr *ctrlr)
-{
-	struct batch_cache_req *req;
-	const struct rpmh_request *rpm_msg;
-	int ret = 0;
-	int i;
-
-	/* Send Sleep/Wake requests to the controller, expect no response */
-	list_for_each_entry(req, &ctrlr->batch_cache, list) {
-		for (i = 0; i < req->count; i++) {
-			rpm_msg = req->rpm_msgs + i;
-			ret = rpmh_rsc_write_ctrl_data(ctrlr_to_drv(ctrlr),
-						       &rpm_msg->msg);
-			if (ret)
-				break;
-		}
-	}
-
-	return ret;
-}
-
-/**
- * rpmh_write_batch: Write multiple sets of RPMH commands and wait for the
- * batch to finish.
- *
- * @dev: the device making the request
- * @state: Active/sleep set
- * @cmd: The payload data
- * @n: The array of count of elements in each batch, 0 terminated.
- *
- * Write a request to the RSC controller without caching. If the request
- * state is ACTIVE, then the requests are treated as completion request
- * and sent to the controller immediately. The function waits until all the
- * commands are complete. If the request was to SLEEP or WAKE_ONLY, then the
- * request is sent as fire-n-forget and no ack is expected.
- *
- * May sleep. Do not call from atomic contexts for ACTIVE_ONLY requests.
- */
-int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
-		     const struct tcs_cmd *cmd, u32 *n)
-{
-	struct batch_cache_req *req;
-	struct rpmh_request *rpm_msgs;
-	struct completion *compls;
-	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
-	unsigned long time_left;
-	int count = 0;
-	int ret, i;
-	void *ptr;
-
-	if (!cmd || !n)
-		return -EINVAL;
-
-	while (n[count] > 0)
-		count++;
-	if (!count)
-		return -EINVAL;
-
-	ptr = kzalloc(sizeof(*req) +
-		      count * (sizeof(req->rpm_msgs[0]) + sizeof(*compls)),
-		      GFP_ATOMIC);
-	if (!ptr)
-		return -ENOMEM;
-
-	req = ptr;
-	compls = ptr + sizeof(*req) + count * sizeof(*rpm_msgs);
-
-	req->count = count;
-	rpm_msgs = req->rpm_msgs;
-
-	for (i = 0; i < count; i++) {
-		__fill_rpmh_msg(rpm_msgs + i, state, cmd, n[i]);
-		cmd += n[i];
-	}
-
-	if (state != RPMH_ACTIVE_ONLY_STATE) {
-		cache_batch(ctrlr, req);
-		return 0;
-	}
-
-	for (i = 0; i < count; i++) {
-		struct completion *compl = &compls[i];
-
-		init_completion(compl);
-		rpm_msgs[i].completion = compl;
-		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msgs[i].msg);
-		if (ret) {
-			pr_err("Error(%d) sending RPMH message addr=%#x\n",
-			       ret, rpm_msgs[i].msg.cmds[0].addr);
-			break;
-		}
-	}
-
-	time_left = RPMH_TIMEOUT_MS;
-	while (i--) {
-		time_left = wait_for_completion_timeout(&compls[i], time_left);
-		if (!time_left) {
-			/*
-			 * Better hope they never finish because they'll signal
-			 * the completion that we're going to free once
-			 * we've returned from this function.
-			 */
-			WARN_ON(1);
-			ret = -ETIMEDOUT;
-			goto exit;
-		}
-	}
-
-exit:
-	kfree(ptr);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(rpmh_write_batch);
-
-static int is_req_valid(struct cache_req *req)
-{
-	return (req->sleep_val != UINT_MAX &&
-		req->wake_val != UINT_MAX &&
-		req->sleep_val != req->wake_val);
-}
-
-static int send_single(struct rpmh_ctrlr *ctrlr, enum rpmh_state state,
-		       u32 addr, u32 data)
-{
-	DEFINE_RPMH_MSG_ONSTACK(NULL, state, NULL, rpm_msg);
-
-	/* Wake sets are always complete and sleep sets are not */
-	rpm_msg.msg.wait_for_compl = (state == RPMH_WAKE_ONLY_STATE);
-	rpm_msg.cmd[0].addr = addr;
-	rpm_msg.cmd[0].data = data;
-	rpm_msg.msg.num_cmds = 1;
-
-	return rpmh_rsc_write_ctrl_data(ctrlr_to_drv(ctrlr), &rpm_msg.msg);
-}
-
-/**
- * rpmh_flush() - Flushes the buffered sleep and wake sets to TCSes
- *
- * @ctrlr: Controller making request to flush cached data
- *
- * Return:
- * * 0          - Success
- * * Error code - Otherwise
- */
-int rpmh_flush(struct rpmh_ctrlr *ctrlr)
-{
-	struct cache_req *p;
-	int ret = 0;
-
-	lockdep_assert_irqs_disabled();
-
-	/*
-	 * Currently rpmh_flush() is only called when we think we're running
-	 * on the last processor.  If the lock is busy it means another
-	 * processor is up and it's better to abort than spin.
-	 */
-	if (!spin_trylock(&ctrlr->cache_lock))
-		return -EBUSY;
-
-	if (!ctrlr->dirty) {
-		pr_debug("Skipping flush, TCS has latest data.\n");
-		goto write_next_wakeup;
-	}
-
-	/* Invalidate the TCSes first to avoid stale data */
-	rpmh_rsc_invalidate(ctrlr_to_drv(ctrlr));
-
-	/* First flush the cached batch requests */
-	ret = flush_batch(ctrlr);
-	if (ret)
-		goto exit;
-
-	list_for_each_entry(p, &ctrlr->cache, list) {
-		if (!is_req_valid(p)) {
-			pr_debug("%s: skipping RPMH req: a:%#x s:%#x w:%#x",
-				 __func__, p->addr, p->sleep_val, p->wake_val);
-			continue;
-		}
-		ret = send_single(ctrlr, RPMH_SLEEP_STATE, p->addr,
-				  p->sleep_val);
-		if (ret)
-			goto exit;
-		ret = send_single(ctrlr, RPMH_WAKE_ONLY_STATE, p->addr,
-				  p->wake_val);
-		if (ret)
-			goto exit;
-	}
-
-	ctrlr->dirty = false;
-
-write_next_wakeup:
-	rpmh_rsc_write_next_wakeup(ctrlr_to_drv(ctrlr));
-exit:
-	spin_unlock(&ctrlr->cache_lock);
-	return ret;
-}
-
-/**
- * rpmh_invalidate: Invalidate sleep and wake sets in batch_cache
- *
- * @dev: The device making the request
- *
- * Invalidate the sleep and wake values in batch_cache.
- */
-void rpmh_invalidate(const struct device *dev)
-{
-	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
-	struct batch_cache_req *req, *tmp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
-	list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
-		kfree(req);
-	INIT_LIST_HEAD(&ctrlr->batch_cache);
-	ctrlr->dirty = true;
-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
-}
-EXPORT_SYMBOL_GPL(rpmh_invalidate);
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index bdbee1a97d36..9a5c5d992e04 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -13,35 +13,16 @@
 #if IS_ENABLED(CONFIG_QCOM_RPMH)
 int rpmh_write(const struct device *dev, enum rpmh_state state,
 	       const struct tcs_cmd *cmd, u32 n);
 
-int rpmh_write_async(const struct device *dev, enum rpmh_state state,
-		     const struct tcs_cmd *cmd, u32 n);
-
-int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
-		     const struct tcs_cmd *cmd, u32 *n);
-
-void rpmh_invalidate(const struct device *dev);
-
 #else
 
 static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
 			     const struct tcs_cmd *cmd, u32 n)
 { return -ENODEV; }
 
-static inline int rpmh_write_async(const struct device *dev,
-				   enum rpmh_state state,
-				   const struct tcs_cmd *cmd, u32 n)
-{ return -ENODEV; }
-
-static inline int rpmh_write_batch(const struct device *dev,
-				   enum rpmh_state state,
-				   const struct tcs_cmd *cmd, u32 *n)
-{ return -ENODEV; }
-
-static inline void rpmh_invalidate(const struct device *dev)
-{
-}
-
 #endif /* CONFIG_QCOM_RPMH */
 
+/* u-boot: no multithreading */
+#define rpmh_write_async(dev, state, cmd, n) rpmh_write(dev, state, cmd, n)
+
 #endif /* __SOC_QCOM_RPMH_H__ */

-- 
2.45.2

