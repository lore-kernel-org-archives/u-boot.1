Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78142D1D492
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6771C842EF;
	Thu,  8 Jan 2026 21:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UJO6dSX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 644B4842EF; Thu,  8 Jan 2026 21:29:09 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 459D1842FC
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 21:29:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b7a6e56193cso605924666b.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 12:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767904142; x=1768508942; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kgYdet5vGYJazU79thTTTP1M0w8EslpMTZ0LS8/hX3s=;
 b=UJO6dSX6EryGxPxhF2sjjNqpkLfENRGn3uLx1kA8h8zaf9OlPV7EbZvVhjFubXFf4l
 lGmv+3D48dKBfi+ivo8q6KUuFNmJov40/T2W7kdHsIaZNnewI2AfzaHuEFuVziOabnBP
 uHs6S9iYA6u0/vTP2VFJ36MJe4tDQhSr18D3bunIMaykKnNeaiQ946pKndcC8qrXF3Is
 +QSZKDXmZwu86Ggtm9FgJABRFGuOEYGHMTayfmnoJ+tIijGLED1dNKQgfffCqTdNFHI2
 oQM1gitbGSGzv9TRplRj63k7Guo2p3cnVFObXRzy+qE7fCrZ109R7S37jFWKEChuzDof
 gLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767904142; x=1768508942;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kgYdet5vGYJazU79thTTTP1M0w8EslpMTZ0LS8/hX3s=;
 b=d5Pw2gtAmHNlFJZFuvjThw78k0elzzINqFb79i/M+t21ISYDA4AtzkXZFslBhgpsq7
 NN7kCmvcUMHmeVFQWVegYewG2lSm8+w8/chwUu7e6PQkW0SOLKeUZJhQy5CTmARzJG6w
 kC8UTLMzYINzXb1SltQ1UsOlIfOij3mEcRrJ6J0fxy25Lb1/njy5OBQU6UnalO4wRtLN
 Ho1G3uwsCpZgzgRX38loKTSAhFOxSwoPth0DLHo8H3F6jHIpXKW6fpcucgt0WCtRNxhJ
 WFncIJJ/WATPaDkCSuwa/mMksTUBqp+Hhb7CfzBbrqwzGNwJ0B+kThN6QBnxmjAmi4am
 R54Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcfF9zCR2nRNGv+IkSw8kHkd4doufxcLcFUiEt0+QNSn1HX6tUnkoVvwraKYRgIS0FQCWtJlQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwEHgdE4lcZ5KyV7itbE8G48emSeylqWg/1hEwLEzAQDVGYtaq9
 EN+/+RCMi1jtAjN6UgwxZfDBU0QmZ7lbrmoIgDubO/zpya+lbnHUqI+7QeS4eRyQ+wU=
X-Gm-Gg: AY/fxX6QH3wMDagsuHELXDZaBK1UPfsEgwlgatpdJtgWMcZc/7GlryH05bQbBUiW//0
 coIP9iJV1ClvTMMLE1RU0MNVj6mcXIJBlvgUSu6mW3q0hsL72Kly5nUokGFN7TfMcU/HSG9Rfi6
 rL5zvnFYC+4eAc5+13QqQoJeY7sjGCZ82/hHhxr512Rfl67aCV7FpAJ4Js2VjEpKvnOpL3MJOFi
 tfcNlpngxPzes3n+3XFKF9hzXpq5NloAoUDp+YotFqfB7uvoKjNBgNol5cqqsm4p5lNW5OmAPtu
 bXkuyqXO814Br0jubYU3uyK+md1ksrlYIcKTTJnwKDXo4gn3qv8PedNkiBk1ie7OSsYBXxTALn3
 IUYkrk+hjw1yXig13xgzBSKt5Ku5SeXgW+KT07akGOh1DyUXUncbMVrp2bunC9WZtHatUn6SDSG
 EXc3+y5owmuXr2EQ8L2KO5g9A/PhHopZQ7hIWEAL9To+kQLDpzzPjMwOZtLvIMGSTp
X-Google-Smtp-Source: AGHT+IHUeM5sjWlKjajbWlOFIR+aedgtbolAlpMzJ0gX4oMjSe/jn8L/7haUKfZS9bmz6lSDlcebzA==
X-Received: by 2002:a17:907:97d0:b0:b84:22ab:a830 with SMTP id
 a640c23a62f3a-b8445233534mr736607466b.18.1767904141537; 
 Thu, 08 Jan 2026 12:29:01 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a564e05sm930264366b.65.2026.01.08.12.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 12:29:00 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 08 Jan 2026 21:28:46 +0100
Subject: [PATCH 4/6] soc/qcom: rpmh: add RPMh read
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-rpmh-regulator-fixes-v1-4-d1b5b300b665@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5801;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Obof6uHlGXsZ5ZYT/u1oG+fk+SCyJLpoiL6cpNwOSmU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswE4fa9hcwej03zln+1CFm2UyXsgf2ujNVyTTejha5Mk
 zc7s+h2RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZiI8FlGhok2pid9wkzPJ72w
 m5Rqtl9vcyb/rhV57/V+Hj0rGju/YjLD//jzZx2zjIyFtpyYMX3uw+0KU7ssn/JXqGyYcm3eL84
 ry6QB
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

Implement support for RPMh reads, these allow reading out the
current votes for RPMh controlled resources such as regulators and
interconnects.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 14 ++++++++++++--
 drivers/soc/qcom/rpmh.c     | 37 +++++++++++++++++++++++++++++++++++--
 include/soc/qcom/rpmh.h     |  4 +++-
 include/soc/qcom/tcs.h      |  1 +
 4 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 05fff174f832..dce61f262292 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -281,14 +281,17 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 			       const struct tcs_request *msg)
 {
 	u32 msgid;
-	u32 cmd_msgid = CMD_MSGID_LEN | CMD_MSGID_WRITE;
+	u32 cmd_msgid = CMD_MSGID_LEN;
 	u32 cmd_enable = 0;
 	u32 cmd_complete = 0;
 	struct tcs_cmd *cmd;
 	int i, j;
 
+	if (!msg->is_read)
+		cmd_msgid |= CMD_MSGID_WRITE;
+
 	if (msg->wait_for_compl)
 		cmd_msgid |= CMD_MSGID_RESP_REQ;
 
 	cmd_complete = read_tcs_reg(drv, drv->regs[RSC_DRV_CMD_WAIT_FOR_CMPL], tcs_id);
@@ -301,9 +304,10 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 		msgid = cmd_msgid;
 
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_MSGID], tcs_id, j, msgid);
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], tcs_id, j, cmd->addr);
-		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_DATA], tcs_id, j, cmd->data);
+		if (!msg->is_read)
+			write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_DATA], tcs_id, j, cmd->data);
 		debug("tcs(%d): [%s] cmd_id: %d: msgid: %#x addr: %#x data: %#x complete: %#x\n",
 		      tcs_id, msg->state == RPMH_ACTIVE_ONLY_STATE ? "active" : "?", j, msgid,
 		      cmd->addr, cmd->data, cmd_complete);
 	}
@@ -417,8 +421,14 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 			break;
 		udelay(1);
 	}
 
+	/* U-Boot: read the response now we know it's available */
+	if (msg->is_read) {
+		msg->cmds[0].data = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_RESP_DATA], tcs_id, 0);
+		log_debug("data response: %#x\n", msg->cmds[0].data);
+	}
+
 	__tcs_set_trigger(drv, tcs_id, false);
 
 	/* Reclaim the TCS */
 	write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, 0);
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 91b90626af36..8c222324c66d 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -67,9 +67,9 @@ static int __rpmh_write(const struct udevice *dev, enum rpmh_state state,
 	return rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
 }
 
 static int __fill_rpmh_msg(struct rpmh_request *req, enum rpmh_state state,
-			   const struct tcs_cmd *cmd, u32 n)
+			   const struct tcs_cmd *cmd, u32 n, bool is_read)
 {
 	if (!cmd || !n || n > MAX_RPMH_PAYLOAD)
 		return -EINVAL;
 
@@ -77,14 +77,47 @@ static int __fill_rpmh_msg(struct rpmh_request *req, enum rpmh_state state,
 
 	req->msg.state = state;
 	req->msg.cmds = req->cmd;
 	req->msg.num_cmds = n;
+	req->msg.is_read = is_read;
 
 	debug("rpmh_msg: %d, %d cmds [first %#x/%#x]\n", state, n, cmd->addr, cmd->data);
 
 	return 0;
 }
 
+/**
+ * rpmh_read: Read a resource value
+ *
+ * @dev: The device making the request
+ * @cmd: The payload having address of resource to read
+ *
+ * Reads the value for the resource address given in tcs_cmd->addr
+ * and returns the tcs_cmd->data filled with same.
+ *
+ * May sleep. Do not call from atomic contexts.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int rpmh_read(const struct udevice *dev, enum rpmh_state state, struct tcs_cmd *cmd)
+{
+	DEFINE_RPMH_MSG_ONSTACK(dev, state, rpm_msg);
+	int ret;
+
+	ret = __fill_rpmh_msg(&rpm_msg, state, cmd, 1, true);
+	if (ret)
+		return ret;
+
+	ret = __rpmh_write(dev, state, &rpm_msg);
+	if (ret)
+		return ret;
+
+	/* Read back the response into the cmd data structure */
+	cmd->data = rpm_msg.cmd[0].data;
+
+	return (ret > 0) ? 0 : ret;
+}
+
 /**
  * rpmh_write: Write a set of RPMH commands and block until response
  *
  * @dev: The device making the request
@@ -99,9 +132,9 @@ int rpmh_write(const struct udevice *dev, enum rpmh_state state,
 {
 	DEFINE_RPMH_MSG_ONSTACK(dev, state, rpm_msg);
 	int ret;
 
-	ret = __fill_rpmh_msg(&rpm_msg, state, cmd, n);
+	ret = __fill_rpmh_msg(&rpm_msg, state, cmd, n, false);
 	if (ret)
 		return ret;
 
 	ret = __rpmh_write(dev, state, &rpm_msg);
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index 3421fbf1ee3e..40812a315bc1 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -12,14 +12,16 @@
 
 #if IS_ENABLED(CONFIG_QCOM_RPMH)
 int rpmh_write(const struct udevice *dev, enum rpmh_state state,
 	       const struct tcs_cmd *cmd, u32 n);
-
+int rpmh_read(const struct udevice *dev, enum rpmh_state state, struct tcs_cmd *cmd);
 #else
 
 static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
 			     const struct tcs_cmd *cmd, u32 n)
 { return -ENODEV; }
+static inline int rpmh_read(const struct udevice *dev, struct tcs_cmd *cmd)
+{ return -ENODEV; }
 
 #endif /* CONFIG_QCOM_RPMH */
 
 /* u-boot: no multithreading */
diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
index 3acca067c72b..22bafe2598a0 100644
--- a/include/soc/qcom/tcs.h
+++ b/include/soc/qcom/tcs.h
@@ -54,8 +54,9 @@ struct tcs_cmd {
  * @cmds:           an array of tcs_cmds
  */
 struct tcs_request {
 	enum rpmh_state state;
+	bool is_read;
 	u32 wait_for_compl;
 	u32 num_cmds;
 	struct tcs_cmd *cmds;
 };

-- 
2.51.0

