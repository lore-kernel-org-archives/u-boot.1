Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD81EB8FDE
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 02:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133B186A34;
	Fri,  8 Sep 2023 04:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zDx/B85r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8536C86A24; Fri,  8 Sep 2023 04:52:33 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAED3869F6
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 04:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bf11a7cf9fso3029595ad.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 19:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694141549; x=1694746349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Luyf4+jN+xcEEas/3QA6pjJQYTZgtnyDFzxGv25LCKk=;
 b=zDx/B85rgn+FbjPi6G16JlLovn+iuubz5QBixdYxnW0/+c7nOsAUOx3fTVz6FNY2ed
 T/IUr7y5ssUyoGpNXL8AtBqtp0jcLgIbzywTmWx2RVaKOj8RlYDu1eyXLgS/THMBEGF4
 kwnXGPfof5xbePlEPlTTjyC7422ZopaihPxIvvs3M5qGEo2TMBFU6wYg+KXvuIOuBHO3
 CFEdPJDP0VhkWBiYe1J2W4hsBal02dk6UJll+BPjDJAbXlGajzMlSn4OUtjGi6KDWWQ1
 SZgENivoMHiYV2//N2KDPWYyf0IBaZMJPQoifGQRLeN6k49d8hF8q81mlwevExIrIqrm
 2A8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694141549; x=1694746349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Luyf4+jN+xcEEas/3QA6pjJQYTZgtnyDFzxGv25LCKk=;
 b=Rhi/6X3XE5qom6klRLMfWX8PvbT/YrZX8jYUv1JLwDjpMjVwM1d/LQVn73UWd5oNz5
 cKPjsFhuxiclIJtyF1epnGPwbD2X21iL0twR0aU7duGn+Q/vGTdDfyQ/EcYS1nBrNSI4
 q7hHBWjR7G6g9zMVyKVuas6aSqAJIBm8pDL+PIi55aiR40FgP051Y1nEf6GBykYrrv1Q
 72rwmjpsxrDu64by3bwX1qzrmmD6v1D+IPOL1K4FiIhxXYXTEXVTVW8PLq9Mx6g3Jvr6
 HMGoET5clKFd+H106kK8Ab959hkLNzi4RoayD/m27PqigEkBGDxMtBuU51XtyJyPvGvI
 jmYg==
X-Gm-Message-State: AOJu0Yw3htCgxJEQ1x0yJOAZHV8LnbSIa4jyp7aNIHohthKtw8FPoUBo
 Bj2irBNQ8CzIRIa/vyEfS2Ph2w==
X-Google-Smtp-Source: AGHT+IFns9QZQ6qOWBC5AV1BHJYUN7wXztPvEau9y3TgMJpJzOI13cMQmdz8g4PJ8N/v58NF95JTHw==
X-Received: by 2002:a17:902:e5c1:b0:1b3:d8ac:8db3 with SMTP id
 u1-20020a170902e5c100b001b3d8ac8db3mr1439511plf.6.1694141549022; 
 Thu, 07 Sep 2023 19:52:29 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:2d89:7669:ac2d:f09e])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a170902e54900b001c0ce518e98sm417286plf.224.2023.09.07.19.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 19:52:28 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v3 06/13] firmware: scmi: add a check against availability of
 protocols
Date: Fri,  8 Sep 2023 11:51:31 +0900
Message-Id: <20230908025138.44405-7-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908025138.44405-1-takahiro.akashi@linaro.org>
References: <20230908025138.44405-1-takahiro.akashi@linaro.org>
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

Now that we have Base protocol support, we will be able to check if a given
protocol is really supported by the SCMI server (firmware).

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
v3
* new; import this patch from my followup patch set
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 41 +++++++++++++++++++++--
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 87a667d60124..54e17992af00 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -44,6 +44,38 @@ static const struct error_code scmi_linux_errmap[] = {
  */
 struct udevice *scmi_agent;
 
+/**
+ * scmi_protocol_is_supported - check availability of protocol
+ * @dev:	SCMI agent device
+ * @proto_id:	Identifier of protocol
+ *
+ * check if the protocol, @proto_id, is provided by the SCMI agent,
+ * @dev.
+ *
+ * Return:	0 on success, error code otherwise
+ */
+static bool scmi_protocol_is_supported(struct udevice *dev,
+				       enum scmi_std_protocol proto_id)
+{
+	struct scmi_agent_priv *priv;
+	int i;
+
+	if (proto_id == SCMI_PROTOCOL_ID_BASE)
+		return true;
+
+	priv = dev_get_uclass_plat(dev);
+	if (!priv) {
+		dev_err(dev, "No priv data found\n");
+		return false;
+	}
+
+	for (i = 0; i < priv->num_protocols; i++)
+		if (priv->protocols[i] == proto_id)
+			return true;
+
+	return false;
+}
+
 struct udevice *scmi_get_protocol(struct udevice *dev,
 				  enum scmi_std_protocol id)
 {
@@ -380,15 +412,18 @@ static int scmi_bind_protocols(struct udevice *dev)
 		name = ofnode_get_name(node);
 		switch (protocol_id) {
 		case SCMI_PROTOCOL_ID_CLOCK:
-			if (CONFIG_IS_ENABLED(CLK_SCMI))
+			if (CONFIG_IS_ENABLED(CLK_SCMI) &&
+			    scmi_protocol_is_supported(dev, protocol_id))
 				drv = DM_DRIVER_GET(scmi_clock);
 			break;
 		case SCMI_PROTOCOL_ID_RESET_DOMAIN:
-			if (IS_ENABLED(CONFIG_RESET_SCMI))
+			if (IS_ENABLED(CONFIG_RESET_SCMI) &&
+			    scmi_protocol_is_supported(dev, protocol_id))
 				drv = DM_DRIVER_GET(scmi_reset_domain);
 			break;
 		case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
-			if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)) {
+			if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI) &&
+			    scmi_protocol_is_supported(dev, protocol_id)) {
 				node = ofnode_find_subnode(node, "regulators");
 				if (!ofnode_valid(node)) {
 					dev_err(dev, "no regulators node\n");
-- 
2.34.1

