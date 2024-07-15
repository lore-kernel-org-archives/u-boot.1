Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85163C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DA0C88845;
	Mon, 15 Jul 2024 12:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JenKtg7k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D8788842; Mon, 15 Jul 2024 12:08:45 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 456F088845
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-58f9874aeb4so5194174a12.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038123; x=1721642923; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ho62e0Tm9bGB47FP/3QVxl2QmsI4RW2Ee7v1Gczir1c=;
 b=JenKtg7kuTawStRshQZF/IHsAWmxEi5upE99wK6uzpQ2oD9NzTLNq7vR/4wKe5eU9/
 Fvm/VhmLRmx6zmQbOlGAXxtNB9MwPFD8YPZXB9COWK8V1or5Z0G3IWffHCi3ZkOUZ/Ek
 Ml5RapAT7C+2H68s+pP9wd1eQwskMI0a0FotctfthitSl1EbwtnA0JHKb8qqdI6yC0wo
 j2CilBGuiu6I6eMheP+GSdcA5kDSVz0Fc9DNL/xAdMFfBtjyVanBFP7xsKRXNXUyONMq
 eZM+pYV5vzBMELOKPMof30RGMNXDUGYBnj1ILu7UOFCFzG8K4t/kZVCEXTbZO349JL2e
 TKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038123; x=1721642923;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ho62e0Tm9bGB47FP/3QVxl2QmsI4RW2Ee7v1Gczir1c=;
 b=jOElzRHDEOYyVk4ct2HGvKVHqVJfXUiQcqHry0PKnF74q8pIl2d1CyODX6GFS6Xz2j
 vw2sxmxKFBx5L2kNtCUm/5BEkc4K4sTz7raex4iajKUwaP6I76p0A7LY4mRk5ANOuiFp
 SMHNQfdQTPv6kz7UgQ1lmAFbzbGHjCosH9oya9D0/tYI2NPJ+ycBfeRsz/kw5oLvZyqD
 TAoHlm+XWk5/ZbcUVcQdkDd3IGwMdRA+eiObpqwRTTvxdlY280t3uiOrOyeptBuWVZNw
 oCp62/KsO3gXduoZo+nGOFQE2wEAYJcTcLzpKcpUHKQ3u8Y6oGHzobEzzrMWBEKC8VIn
 2aqw==
X-Gm-Message-State: AOJu0YxTS8cnj5kpnf2FQTyXTI3y8AJbX17rxvL/R77v7QuiXwpfiWCj
 yjDChMSJ+9tOUb9+NOpD7PQKDrd31BCj0eZH0aEpvwd3VAvkL4EjnOIxms7Ryj8=
X-Google-Smtp-Source: AGHT+IH7UGI0+QnsphgkiSfj1KAbQurVQs/M19xNSlaWvg/wKfVtgBDtL/pgRpWpfEwb0ccg5FRQtw==
X-Received: by 2002:a17:906:66c9:b0:a77:cf9d:f497 with SMTP id
 a640c23a62f3a-a780b70513emr1205003666b.40.1721038122807; 
 Mon, 15 Jul 2024 03:08:42 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:42 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:10 +0200
Subject: [PATCH v6 11/24] soc: qcom: rpmh-rsc: remaining U-Boot API changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-11-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5823;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ceejJWEJy6z1xebitvHMIbJYyb9bWOSzAlEpUwbMOdI=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUG4hFlFvnDbPBYZ6KjHfDvMZ5VozVfOcYaq
 Ad+FoC6NZSJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BgAKCRAFgzErGV9k
 trczEACmlQ4ljhgpxOVcN/eRNVax0hJlLefUF21BRyYqEQdY47Rpjlmq46nimi+7wAZ9hUInz/n
 7VCIL5ccebJC4F4FEV3+f0URW6hJ2e/IO86G9PSJc6rJOKt0b8a7zZwDcVe3pCQvo4sTszB6uSN
 e62VV4hZf5JP80ndeBNlWqCTQpubrgw7BcUJRY2UT22QsEZwr9ogRiIaDJ9oug5/Km0glbPBwXF
 XJcmQEogPDykgLN+W1i5LDZNlsfxG5iDu1ah4tH+XCTG2cXAmwAaIwLcqhH6ZkQ2UmSwzlUIMsQ
 J4+blGZ8UvBZfMLUwBZy0FEO99wa87eKOyy5QrXfG5UCYnVj3FCRa36n5SR17+/QS5JiitqtWma
 4e25DNNUeNXs8e4cb/KAQmQsn3briK5WVjAnLeUzCX0lbTjNpS4Am7GKxhHf+sr3lluUTpKdU+S
 YGOCCCqIOigbGyqSfNKAqJFfsRMjzoq1FLOjaEJf7rosuvL5sc1T1Rff6ZdClGuyz9rK+sRXenA
 5JS8lBbKgfloP2jPYEgeakbkZ0pVf1AyYkgL9cdrV3cYVuQqm0FWeVgtoATyq8bS865bH5d4ly0
 mg/4KQup3IWiRurBdilIJRurZgALiCIYNn9sKElN1Ny4SjIRNqoiPYVRY54IXtnoybzHghrE33F
 Y2p+z9tqQWavHYw==
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
index 2afe5005facf..61fb2e695587 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -133,16 +133,8 @@ enum {
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
@@ -247,37 +239,18 @@ static void write_tcs_reg_sync(const struct rsc_drv *drv, int reg, int tcs_id,
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
@@ -297,11 +270,8 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
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
@@ -313,9 +283,11 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 
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
@@ -345,34 +317,28 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
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
@@ -382,8 +348,22 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
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

