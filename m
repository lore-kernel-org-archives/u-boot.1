Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E61EE7D241
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 06:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E31B686C32;
	Tue, 26 Sep 2023 08:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kbiyq2+b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2790286C32; Tue, 26 Sep 2023 08:58:18 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D257B86B95
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-690d935dbc2so1879797b3a.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695711494; x=1696316294; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5WXeaDc5fixDobj9hHcc7iI7eRYEh2B18lEtPO1VmOU=;
 b=Kbiyq2+by/O7XdDhen/Gs1UdMQNFOKLTIiKFSa6oBSmXIG0yTVThYAbLbcpxz30ZH5
 LaEMaAZe8huN8xTi2rIVUvLv1e19ULroMWQ9XylvJSkWQFNh97jr0Gp0Xop4xmyaK5o2
 YWHcN3YHrfg9HjlxyKU8vuo6x6HjczJu8G/9L82ZMEiNPxyTpnJdOzNz7oTmG6bCL3GV
 wUSYuHt+Pjx+U4Poq5xloA2QOe/OevV7lCK/3a3aKFsLY/YsxdB/SdnJucNFYFP6McEg
 N3SxEqGjlxnZU53X9wrcQZ13s/nfhME15CoHgl9RKaqC0o3g3FNBe0rvm+Rt1BBEThd2
 6Rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711494; x=1696316294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5WXeaDc5fixDobj9hHcc7iI7eRYEh2B18lEtPO1VmOU=;
 b=KwEmvLUbVoq/S5Ldci6nX7CIQS7/MceqXYy3ltZOMuv7Z5d5e0LXeaT6jgS6Vab0pv
 GPZN4PtVX86VOZCB6CocPWCQaVOBYty2vmmup38s49QoX+gIfhxC1ZrSFpMztKZewU6l
 IlrchSPBcQmWd74XEgD5xxbW5yWmI5gKOffbVp44yFwZ45LJsZtA8rwEpEavgq+gVfmv
 SB0jlZWT9RUk4H3I65cODqStZ9O0DCNjaKfa3JG8wsP28yNxa9Dfi94gEsTrI9aas8B0
 Qa247bq/72Vv7zScrKIeBAVJ83vhv38/j6KW2WSQQEJzNmtuJ45spvRTA7+ATEIDDlFn
 RRbA==
X-Gm-Message-State: AOJu0YzcLxK6kJ6AfeHJc4COqwr4RJJscVqQY0uxbXOjBebeEAxvtmVk
 VrCvYTeeFr7peAyLyj7UULxKwg==
X-Google-Smtp-Source: AGHT+IER59vYv0uYNQ+5oddjd4fh6O3jb9/BCyE2ZvDUcoMdymqUx8kbgdy4bQPoW3hm+7XTn+du6A==
X-Received: by 2002:a05:6a21:6d86:b0:15d:6fd3:8e74 with SMTP id
 wl6-20020a056a216d8600b0015d6fd38e74mr11942934pzb.3.1695711494049; 
 Mon, 25 Sep 2023 23:58:14 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:6585:aea6:5002:a825])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a639242000000b0057825bd3448sm8758874pgn.51.2023.09.25.23.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 23:58:13 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v5 02/16] firmware: scmi: use a protocol's own channel if
 assigned
Date: Tue, 26 Sep 2023 15:57:36 +0900
Message-Id: <20230926065750.734440-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926065750.734440-1-takahiro.akashi@linaro.org>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

SCMI specification allows any protocol to have its own channel for
the transport. While the current SCMI driver may assign its channel
from a device tree, the core function, devm_scmi_process_msg(), doesn't
use a protocol's channel, but always use an agent's channel.

With this commit, devm_scmi_process_msg() tries to find and use
a protocol's channel. If it doesn't exist, use an agent's.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
v5
* new commit (fixing a potential bug)
---
 drivers/firmware/scmi/mailbox_agent.c     | 5 +++--
 drivers/firmware/scmi/optee_agent.c       | 5 +++--
 drivers/firmware/scmi/scmi_agent-uclass.c | 7 ++++---
 drivers/firmware/scmi/smccc_agent.c       | 5 +++--
 include/scmi_agent-uclass.h               | 8 +++++---
 5 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/scmi/mailbox_agent.c b/drivers/firmware/scmi/mailbox_agent.c
index 8277c1860606..7ad3e8da9f08 100644
--- a/drivers/firmware/scmi/mailbox_agent.c
+++ b/drivers/firmware/scmi/mailbox_agent.c
@@ -94,13 +94,14 @@ static int setup_channel(struct udevice *dev, struct scmi_mbox_channel *chan)
 }
 
 static int scmi_mbox_get_channel(struct udevice *dev,
+				 struct udevice *protocol,
 				 struct scmi_channel **channel)
 {
 	struct scmi_mbox_channel *base_chan = dev_get_plat(dev);
 	struct scmi_mbox_channel *chan;
 	int ret;
 
-	if (!dev_read_prop(dev, "shmem", NULL)) {
+	if (!dev_read_prop(protocol, "shmem", NULL)) {
 		/* Uses agent base channel */
 		*channel = container_of(base_chan, struct scmi_channel, ref);
 
@@ -112,7 +113,7 @@ static int scmi_mbox_get_channel(struct udevice *dev,
 		return -ENOMEM;
 
 	/* Setup a dedicated channel for the protocol */
-	ret = setup_channel(dev, chan);
+	ret = setup_channel(protocol, chan);
 	if (ret) {
 		free(chan);
 		return ret;
diff --git a/drivers/firmware/scmi/optee_agent.c b/drivers/firmware/scmi/optee_agent.c
index db927fb21405..e3e462774045 100644
--- a/drivers/firmware/scmi/optee_agent.c
+++ b/drivers/firmware/scmi/optee_agent.c
@@ -324,6 +324,7 @@ static int setup_channel(struct udevice *dev, struct scmi_optee_channel *chan)
 }
 
 static int scmi_optee_get_channel(struct udevice *dev,
+				  struct udevice *protocol,
 				  struct scmi_channel **channel)
 {
 	struct scmi_optee_channel *base_chan = dev_get_plat(dev);
@@ -331,7 +332,7 @@ static int scmi_optee_get_channel(struct udevice *dev,
 	u32 channel_id;
 	int ret;
 
-	if (dev_read_u32(dev, "linaro,optee-channel-id", &channel_id)) {
+	if (dev_read_u32(protocol, "linaro,optee-channel-id", &channel_id)) {
 		/* Uses agent base channel */
 		*channel = container_of(base_chan, struct scmi_channel, ref);
 
@@ -343,7 +344,7 @@ static int scmi_optee_get_channel(struct udevice *dev,
 	if (!chan)
 		return -ENOMEM;
 
-	ret = setup_channel(dev, chan);
+	ret = setup_channel(protocol, chan);
 	if (ret) {
 		free(chan);
 		return ret;
diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index ec58ccd2bc5d..a28692f39f4d 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -144,13 +144,14 @@ static const struct scmi_agent_ops *transport_dev_ops(struct udevice *dev)
  * On return, @channel will be set.
  * Return	0 on success and a negative errno on failure
  */
-static int scmi_of_get_channel(struct udevice *dev, struct scmi_channel **channel)
+static int scmi_of_get_channel(struct udevice *dev, struct udevice *protocol,
+			       struct scmi_channel **channel)
 {
 	const struct scmi_agent_ops *ops;
 
 	ops = transport_dev_ops(dev);
 	if (ops->of_get_channel)
-		return ops->of_get_channel(dev, channel);
+		return ops->of_get_channel(dev, protocol, channel);
 	else
 		return -EPROTONOSUPPORT;
 }
@@ -166,7 +167,7 @@ int devm_scmi_of_get_channel(struct udevice *dev)
 		return -ENODEV;
 
 	priv = dev_get_parent_priv(protocol);
-	ret = scmi_of_get_channel(protocol->parent, &priv->channel);
+	ret = scmi_of_get_channel(protocol->parent, protocol, &priv->channel);
 	if (ret == -EPROTONOSUPPORT) {
 		/* Drivers without a get_channel operator don't need a channel ref */
 		priv->channel = NULL;
diff --git a/drivers/firmware/scmi/smccc_agent.c b/drivers/firmware/scmi/smccc_agent.c
index 6a52cd75d67b..972c6addde21 100644
--- a/drivers/firmware/scmi/smccc_agent.c
+++ b/drivers/firmware/scmi/smccc_agent.c
@@ -81,6 +81,7 @@ static int setup_channel(struct udevice *dev, struct scmi_smccc_channel *chan)
 }
 
 static int scmi_smccc_get_channel(struct udevice *dev,
+				  struct udevice *protocol,
 				  struct scmi_channel **channel)
 {
 	struct scmi_smccc_channel *base_chan = dev_get_plat(dev);
@@ -88,7 +89,7 @@ static int scmi_smccc_get_channel(struct udevice *dev,
 	u32 func_id;
 	int ret;
 
-	if (dev_read_u32(dev, "arm,smc-id", &func_id)) {
+	if (dev_read_u32(protocol, "arm,smc-id", &func_id)) {
 		/* Uses agent base channel */
 		*channel = container_of(base_chan, struct scmi_channel, ref);
 
@@ -100,7 +101,7 @@ static int scmi_smccc_get_channel(struct udevice *dev,
 	if (!chan)
 		return -ENOMEM;
 
-	ret = setup_channel(dev, chan);
+	ret = setup_channel(protocol, chan);
 	if (ret) {
 		free(chan);
 		return ret;
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index b1c93532c0ea..eee46c880a56 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -16,16 +16,18 @@ struct scmi_agent_ops {
 	/*
 	 * of_get_channel - Get SCMI channel from SCMI agent device tree node
 	 *
-	 * @dev:		SCMI protocol device using the transport
+	 * @dev:		SCMI agent device using the transport
+	 * @protocol:		SCMI protocol device using the transport
 	 * @channel:		Output reference to SCMI channel upon success
 	 * Return 0 upon success and a negative errno on failure
 	 */
-	int (*of_get_channel)(struct udevice *dev, struct scmi_channel **channel);
+	int (*of_get_channel)(struct udevice *dev, struct udevice *protocol,
+			      struct scmi_channel **channel);
 
 	/*
 	 * process_msg - Request transport to get the SCMI message processed
 	 *
-	 * @dev:		SCMI protocol device using the transport
+	 * @dev:		SCMI agent device using the transport
 	 * @msg:		SCMI message to be transmitted
 	 */
 	int (*process_msg)(struct udevice *dev, struct scmi_channel *channel,
-- 
2.34.1

