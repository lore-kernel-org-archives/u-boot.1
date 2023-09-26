Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F64E7D241
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 06:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C4E286C2D;
	Tue, 26 Sep 2023 08:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t8iWSi3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5636086C67; Tue, 26 Sep 2023 08:58:20 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A70986C2D
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-690fe1d9ba1so1882009b3a.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 23:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695711496; x=1696316296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9w6NtVmxhTP8bJl1pLz+4m/B3yXvXCTMKNDuB9SU9KQ=;
 b=t8iWSi3Vb0N1G/im1ig3tBt8jqQewfm0cvyqbphoIjoXEPcXH7zcBLIsrYZt0Ku2UV
 +wovZuRVM7s+lvbxJ0lKm6B/KR5hgsxafF41kiWu+ZuBn/QyjB0gjux/XIKDwDxi4qvg
 aLIJPaiJQtL114lvqj+7hIPKMi67GE/7s0XcZ29kMdxZ+hSn6hURtroZk9Ubsz6WkfEh
 u4MItp3ClrwWjSfQM0HXCV6DLZjtwjLz3ByrUHjjXnCoDdTJV4+1LYvq0Ymp2/HsaMbe
 6ZEVC64g5n14VQLih2NVxYvTroU2dSVtmjF1nwdF0Boe5oIEO32P/IrhBwPMWlWiBz5t
 la2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711496; x=1696316296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9w6NtVmxhTP8bJl1pLz+4m/B3yXvXCTMKNDuB9SU9KQ=;
 b=WBrci5gQ316Um+o4O9Y+aZZzLd4o4YM1n+b2OWrjWWoyvyH0Eqwv6FvEkG91bE77sT
 Nq8cNpVomrCI5GDlpx6iPP0oPUE5tfm90DdjvYknGhNpCF82TO5qqBRKcindTxj+pyXH
 i3Wma1ndXXgIzmnESlW8KGo+ixt/kGjEEgutyiiWoJUVZ1q1COg6ytI7nRtIcVS02S+e
 b4mXa2ufpUGBSAQoZOE6+ljg//j44pMx5i+sgEy5He8HEsQmAqFEVU5hTSO+/yfM7sPv
 d32RudJNgiyDgyKoEkWG+mcKfGMheYGfiuUAW/NTR9lvPG1EU363AGLsdJzRcoN06Ui6
 7Z9w==
X-Gm-Message-State: AOJu0YxsqkltnmxTcgFJPsnT7TPxYnYpMkZ6jE4y1l9PYS9RKA5Q44lZ
 Tswg3swL3EDeR9QWUHz2anbCFA==
X-Google-Smtp-Source: AGHT+IGut1yquD/yyLuZhXURFdXKSkfbk353fkGSB+MPAnoYEk9VrkwlShWESn4Qo4YbjxHycJ135w==
X-Received: by 2002:a05:6a00:d66:b0:68e:3eff:e93a with SMTP id
 n38-20020a056a000d6600b0068e3effe93amr9155829pfv.2.1695711496344; 
 Mon, 25 Sep 2023 23:58:16 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:6585:aea6:5002:a825])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a639242000000b0057825bd3448sm8758874pgn.51.2023.09.25.23.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 23:58:15 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v5 03/16] firmware: scmi: support dummy channels for sandbox
 agent
Date: Tue, 26 Sep 2023 15:57:37 +0900
Message-Id: <20230926065750.734440-4-takahiro.akashi@linaro.org>
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

In sandbox scmi agent, channels are not used at all. But in this patch,
dummy channels are supported in order to test protocol-specific channels.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
v5
* new commit
---
 arch/sandbox/include/asm/scmi_test.h       | 13 ++++
 drivers/firmware/scmi/sandbox-scmi_agent.c | 90 ++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index c72ec1e1cb25..75cb462a5584 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -88,6 +88,14 @@ struct sandbox_scmi_devices {
 };
 
 #ifdef CONFIG_SCMI_FIRMWARE
+/**
+ * sandbox_scmi_channel_id - Get the channel id
+ * @dev:	Reference to the SCMI protocol device
+ *
+ * Return:	Channel id
+ */
+unsigned int sandbox_scmi_channel_id(struct udevice *dev);
+
 /**
  * sandbox_scmi_service_ctx - Get the simulated SCMI services context
  * @return:	Reference to backend simulated resources state
@@ -101,6 +109,11 @@ struct sandbox_scmi_service *sandbox_scmi_service_ctx(void);
  */
 struct sandbox_scmi_devices *sandbox_scmi_devices_ctx(struct udevice *dev);
 #else
+inline unsigned int sandbox_scmi_channel_id(struct udevice *dev);
+{
+	return 0;
+}
+
 static inline struct sandbox_scmi_service *sandbox_scmi_service_ctx(void)
 {
 	return NULL;
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 031882998dfa..394df043918f 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -33,6 +33,26 @@
  * various uclass devices, as clocks and reset controllers.
  */
 
+/**
+ * struct sandbox_channel - Description of sandbox transport
+ * @channel_id:		Channel identifier
+ *
+ * Dummy channel. This will be used to test if a protocol-specific
+ * channel is properly used.
+ * Id 0 means a channel for the sandbox agent.
+ */
+struct sandbox_channel {
+	unsigned int channel_id;
+};
+
+/**
+ * struct scmi_channel - Channel instance referenced in SCMI drivers
+ * @ref: Reference to local channel instance
+ **/
+struct scmi_channel {
+	struct sandbox_channel ref;
+};
+
 static struct sandbox_scmi_clk scmi_clk[] = {
 	{ .rate = 333 },
 	{ .rate = 200 },
@@ -470,6 +490,73 @@ static int sandbox_scmi_voltd_level_get(struct udevice *dev,
 	return 0;
 }
 
+/**
+ * sandbox_scmi_of_get_channel - assigne a channel
+ * @dev:	SCMI agent device
+ * @protocol:	SCMI protocol device
+ * @channel:	Pointer to channel info
+ *
+ * Assign a channel for the protocol, @protocol, in @channel,
+ * based on a device tree's property.
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int sandbox_scmi_of_get_channel(struct udevice *dev,
+				       struct udevice *protocol,
+				       struct scmi_channel **channel)
+{
+	struct sandbox_channel *agent_chan = dev_get_plat(dev);
+	struct sandbox_channel *chan;
+	u32 channel_id;
+
+	if (dev_read_u32(protocol, "linaro,sandbox-channel-id", &channel_id)) {
+		/* Uses agent channel */
+		*channel = container_of(agent_chan, struct scmi_channel, ref);
+
+		return 0;
+	}
+
+	/* Setup a dedicated channel */
+	chan = calloc(1, sizeof(*chan));
+	if (!chan)
+		return -ENOMEM;
+
+	chan->channel_id = channel_id;
+
+	*channel = container_of(chan, struct scmi_channel, ref);
+
+	return 0;
+}
+
+/**
+ * sandbox_scmi_of_to_plat - assigne a channel to agent
+ * @dev:	SCMI agent device
+ *
+ * Assign a channel for the agent, @protocol.
+ *
+ * Return: always 0
+ */
+static int sandbox_scmi_of_to_plat(struct udevice *dev)
+{
+	struct sandbox_channel *chan = dev_get_plat(dev);
+
+	/* The channel for agent is always 0 */
+	chan->channel_id = 0;
+
+	return 0;
+}
+
+unsigned int sandbox_scmi_channel_id(struct udevice *dev)
+{
+	struct scmi_agent_proto_priv *priv;
+	struct sandbox_channel *chan;
+
+	priv = dev_get_parent_priv(dev);
+	chan = (struct sandbox_channel *)&priv->channel->ref;
+
+	return chan->channel_id;
+}
+
 static int sandbox_scmi_test_process_msg(struct udevice *dev,
 					 struct scmi_channel *channel,
 					 struct scmi_msg *msg)
@@ -584,6 +671,7 @@ static const struct udevice_id sandbox_scmi_test_ids[] = {
 };
 
 struct scmi_agent_ops sandbox_scmi_test_ops = {
+	.of_get_channel = sandbox_scmi_of_get_channel,
 	.process_msg = sandbox_scmi_test_process_msg,
 };
 
@@ -592,6 +680,8 @@ U_BOOT_DRIVER(sandbox_scmi_agent) = {
 	.id = UCLASS_SCMI_AGENT,
 	.of_match = sandbox_scmi_test_ids,
 	.priv_auto	= sizeof(struct sandbox_scmi_agent),
+	.plat_auto	= sizeof(struct sandbox_channel),
+	.of_to_plat	= sandbox_scmi_of_to_plat,
 	.probe = sandbox_scmi_test_probe,
 	.remove = sandbox_scmi_test_remove,
 	.ops = &sandbox_scmi_test_ops,
-- 
2.34.1

