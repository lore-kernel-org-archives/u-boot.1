Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51B5D1D493
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9651384301;
	Thu,  8 Jan 2026 21:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PeHCWPr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DA138415D; Thu,  8 Jan 2026 21:29:03 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06D8D842DB
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 21:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b7ffa5d1b80so545021966b.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 12:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767904140; x=1768508940; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qb/d9LuEQQNL2voB8hOz81ZOClPHogCH/S3LKlhzyGE=;
 b=PeHCWPr7RAl2IveXeeO8nxYRgbNBbaVPAZ+/RGPsGW58MsF70df7h5CFsOt0+AOABk
 y36wJCFjroGh5Ts63oVA+fVAIfWWKYS1+ZIINiM+gYBBFND83Q1A8OtHXJ49Yad3mBv9
 vYiftDkt+b2FWwKO6IwRWvm6Mc7DVuBDGLtKMLlr5axc0s3fcPxWGwChX+5lQFmoqRVD
 WXfJlQB6waTLXbfERqCueCMSfEy1zgDrQngAi3Mf/cWAOoqnIONkOCuXvCmYLLqw4gLB
 Bjq9U1zdHUnuQRGncyMMNd5iBzXSxoU19FCJpzJ/LieMXn12O2hnrbdfjZnD8Ks7vp3/
 7GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767904140; x=1768508940;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Qb/d9LuEQQNL2voB8hOz81ZOClPHogCH/S3LKlhzyGE=;
 b=Qr8eYs7vGZV3yhNTfEb0Z7x95y9DhmhcUO2+yG6ckMzStds0EkHgyBsw9aragTGm+E
 GmwyLQinVvvY0EQteri9i5TkAQTUYNKQL3BHGc/DqcWsc/AXHYGkUcGIRvWt4vt0+De1
 4ivAcvINrjmwRRF/KxUzBOdnGVgiM5GxWioq9Q6qrSDK/v0YdqabETL7+Md+2tkeNra7
 +gzMsZ7Wpvr1oUIQflidUKK+3uFj6bwtji/36AEKMdhPRJqaYdVbLyeWW95jZzIUt2GI
 GysboXBnvISCokdhw0oDPrUUynJx/KqbXW4eibul3PrUDmOZSsdAIq/602mPNEd0gJoq
 DGDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6vgeryZZ4xRFtbxXks7hwqxyGbmahgdqHg4XkK0BsNmWIoeX4augLvgHgx+tTV373bZYh098=@lists.denx.de
X-Gm-Message-State: AOJu0YwNP+jrKJvwU2pxuN5HYoDlD9zZakjKBh4BjxY/kd6gp25EhyEZ
 Axx2Bl4Ah+6kAyUbDfRaJPBtTDqQ63OaNWlrWUrwGlZ3i0i2GeIPmX/W63YjK9E2SLg=
X-Gm-Gg: AY/fxX5bxASeG+NkkVNt28EdAMtJFe40mdvMBlYlLmzVNMftwUTjW+/gReifeU0qK9C
 ZvjWRkKIRS3jPDlwMrrwtUOSRwCekKhYeQKgwURZ66Q9DawYzSt+9m6Ewy5WIXyM2vNI7NP0B0U
 9Uus4GXQYQSP/jUrectZC2ukmbiGwn3+MV1C6mFZJoSvVanfQQXkuUpN94rwoO+rJurbq63fJ8y
 cFic8zuGhayfd6yiz3i4GAR26TGjINTXVB/wmbDPU5HvuUxx3lRIpkRj01WDSKh8RRkYA/3Bxpn
 FKhRRQ/W2+YcmnydCwJ4NgNid+YGcU2iqPm45I+WtvbLq/bzU85e5eyzl3VPBNtjaXoEipKO9se
 slKmuNpb7H2yXns6m80w3N30d+vYDpwtoGqNP9bcKMvHt78SvsWyv0MwUzyWCKWZ1CWjLFjkGbJ
 Oe9pT99vicMTRCqJ70aF0xFyh/Ii/v7AkZJWdyYu+VOnd0Tp84uSMATw==
X-Google-Smtp-Source: AGHT+IE8SSIDruS05eGm/A/061NanqVXxjP6G1lCAmV1HrRkg/BaLB2iC60l9TiRzqWS9tjvvaAMig==
X-Received: by 2002:a17:907:9701:b0:b80:3fff:32ea with SMTP id
 a640c23a62f3a-b8445034cd3mr738987566b.57.1767904140257; 
 Thu, 08 Jan 2026 12:29:00 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a564e05sm930264366b.65.2026.01.08.12.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 12:28:59 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 08 Jan 2026 21:28:45 +0100
Subject: [PATCH 3/6] soc/qcom: rpmh: correctly wait for TCS flush
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-rpmh-regulator-fixes-v1-3-d1b5b300b665@linaro.org>
References: <20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org>
In-Reply-To: <20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15-dev-52d38
X-Developer-Signature: v=1; a=openpgp-sha256; l=5161;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=lFOKsgKAHEdMUlrUxiPKGE1Lyb9mw7DtyZNf66+JLv0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswE4XapDQXmOnbaQgGafU/KmSWOqTuJ8T+/sbX7fdrap
 a/Kcsw7SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwESsBBkZWm5OfG76R0BTnU9z
 /pv/Vq38JU/47VZc2q/+NiD8CttlPYbfbIlui3ltpp39mvryq9S/zdrzXi0PDCydPeNK7sOHTBs
 UAgA=
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

Several bugs were discovered in the rpmh-rsc driver which collectively
meant we were never actually waiting for the TCS to flush, these were
likely missed because U-Boot runs single threaded and the RPMh had
typically processed the single command we sent by the time we went
to send the next one. However a future patch will implement rpmh read
support which requires us to properly wait for the RPMh command response
so we can return the value.

Fix these issues so we correctly ensure the TCS is done before
returning.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 44 +++++++++++++++++++++++---------------------
 drivers/soc/qcom/rpmh.c     |  1 +
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index f51ef0b4af9c..05fff174f832 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -283,31 +283,37 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 {
 	u32 msgid;
 	u32 cmd_msgid = CMD_MSGID_LEN | CMD_MSGID_WRITE;
 	u32 cmd_enable = 0;
+	u32 cmd_complete = 0;
 	struct tcs_cmd *cmd;
 	int i, j;
 
+	if (msg->wait_for_compl)
+		cmd_msgid |= CMD_MSGID_RESP_REQ;
+
+	cmd_complete = read_tcs_reg(drv, drv->regs[RSC_DRV_CMD_WAIT_FOR_CMPL], tcs_id);
+
 	for (i = 0, j = cmd_id; i < msg->num_cmds; i++, j++) {
 		cmd = &msg->cmds[i];
 		cmd_enable |= BIT(j);
+		/* U-Boot: always wait for completion */
+		cmd_complete |= (!!msg->wait_for_compl) << j;
 		msgid = cmd_msgid;
-		/*
-		 * Additionally, if the cmd->wait is set, make the command
-		 * response reqd even if the overall request was fire-n-forget.
-		 */
-		msgid |= cmd->wait ? CMD_MSGID_RESP_REQ : 0;
 
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_MSGID], tcs_id, j, msgid);
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], tcs_id, j, cmd->addr);
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_DATA], tcs_id, j, cmd->data);
-		debug("tcs(m): %d [%s] cmd(n): %d msgid: %#x addr: %#x data: %#x complete: %d\n",
+		debug("tcs(%d): [%s] cmd_id: %d: msgid: %#x addr: %#x data: %#x complete: %#x\n",
 		      tcs_id, msg->state == RPMH_ACTIVE_ONLY_STATE ? "active" : "?", j, msgid,
-		      cmd->addr, cmd->data, cmd->wait);
+		      cmd->addr, cmd->data, cmd_complete);
 	}
 
 	cmd_enable |= read_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id);
 	write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, cmd_enable);
+	/* U-Boot: Tell the DRV to wait for completion (?) so we can poll on DRV_STATUS */
+	/* This register applies to the entire TCS group not per command */
+	write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_WAIT_FOR_CMPL], tcs_id, cmd_complete);
 }
 
 /**
  * __tcs_set_trigger() - Start xfer on a TCS or unset trigger on a borrowed TCS
@@ -375,28 +381,24 @@ static void __tcs_set_trigger(struct rsc_drv *drv, int tcs_id, bool trigger)
  */
 int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 {
 	struct tcs_group *tcs;
-	int tcs_id, i;
-	u32 addr;
+	int tcs_id, i = 0;
+	u32 val;
 
 	tcs = get_tcs_for_msg(drv, msg);
 	if (IS_ERR(tcs))
 		return PTR_ERR(tcs);
 
-	/* u-boot is single-threaded, always use the first TCS as we'll never conflict */
+	/* U-Boot is single-threaded, always use the first TCS as we'll never conflict */
 	tcs_id = tcs->offset;
+	if (!read_tcs_reg(drv, drv->regs[RSC_DRV_STATUS], tcs_id)) {
+		pr_err("%s: TCS %d is busy!\n", __func__, tcs_id);
+		return -EBUSY;
+	}
 
 	tcs->req[tcs_id - tcs->offset] = msg;
 	generic_set_bit(tcs_id, drv->tcs_in_use);
-	if (msg->state == RPMH_ACTIVE_ONLY_STATE && tcs->type != ACTIVE_TCS) {
-		/*
-		 * Clear previously programmed WAKE commands in selected
-		 * repurposed TCS to avoid triggering them. tcs->slots will be
-		 * cleaned from rpmh_flush() by invoking rpmh_rsc_invalidate()
-		 */
-		write_tcs_reg_sync(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, 0);
-	}
 
 	/*
 	 * These two can be done after the lock is released because:
 	 * - We marked "tcs_in_use" under lock.
@@ -407,12 +409,12 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 	 */
 	__tcs_buffer_write(drv, tcs_id, 0, msg);
 	__tcs_set_trigger(drv, tcs_id, true);
 
-	/* U-Boot: Now wait for the TCS to be cleared, indicating that we're done */
+	/* U-Boot: Now wait for the TCS to be cleared, indicating that we're done. */
 	for (i = 0; i < USEC_PER_SEC; i++) {
-		addr = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], i, 0);
-		if (addr != msg->cmds[0].addr)
+		val = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_STATUS], tcs_id, 0);
+		if (val & CMD_STATUS_COMPL)
 			break;
 		udelay(1);
 	}
 
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 96f14a9afdf2..91b90626af36 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -21,8 +21,9 @@
 		.msg = {				\
 			.state = s,			\
 			.cmds = name.cmd,		\
 			.num_cmds = 0,			\
+			.wait_for_compl = true		\
 		},					\
 		.cmd = { { 0 } },			\
 		.dev = device,				\
 		.needs_free = false,			\

-- 
2.51.0

