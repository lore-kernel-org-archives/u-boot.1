Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3186DE7D241
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A858186D56;
	Tue, 26 Sep 2023 08:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MyYf8Ibm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D59B86D56; Tue, 26 Sep 2023 08:58:39 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E658286C00
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1dd22266f51so362830fac.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 23:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695711515; x=1696316315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXcB1ML+GNN0PvOeGj9YekhiQKMztwG+L5FTsmlR42k=;
 b=MyYf8IbmcMj4tBd0lVHJnyWtpkiQn9F+H66ajdKdlKxGOd6+F2+wfmi15HNJxkvXQU
 tX4n2Co2zEePxXu3C0qQxkhHZFvz4wWgpAs1x67KHc3Nf6yL9/JMmsULVJ1PHY+t5Rse
 6JFMQVIKKtS3w6g3mqWFch5EoM2jRwKjMt9bmCqrOhuJuvPYs++LaDdlY/c9XgaVICHF
 Z+F747oAnls7eCkIeVgH5arA/OoYwGrlXd88MuQQw+7k4TZGvUBVcTYpU5QKHT+X0QhT
 vC6NzVsum8+Nkp3oe89K3t2L3QnrdxuwzLSGDbC1uMZlnNiiKpGicpIufmgvhKx4wDCD
 Sjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711515; x=1696316315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vXcB1ML+GNN0PvOeGj9YekhiQKMztwG+L5FTsmlR42k=;
 b=irTW5ZammWLa4AJtLsVwfu0/pk9wMADEe5mJ+y/cf9VpcF+6wppnbD/2dLGKH3YgK+
 +KG9G1kTwJ30OIzX5ZJQ2WjGZMgCacGzlr9krfqFi7nzbiVqVNoHlp6SsU8zDczb84hy
 Xol3V1eBTCItSRRFuTOB5UxDcxjXDLLBIc3jV0T2NxqmhkKE+jU26K8shzXPgLxHXO9I
 o8EKXOv4/xCVTLDPbytnw+/lsHvC02QT3FGgtWYeEqS4Rn9zColOwakKMvmTKNcJOzPX
 Zweq+1C37nYyP/fRqTTH1UKbVGvioV/ZTJ7tzpMOIGdG9zO9PwWFRha9pmG+pcG632SE
 CwVg==
X-Gm-Message-State: AOJu0YzAwkCDEEBALJYiob7LMNInM2jZjB8/l/WP8PhrRp9KonzwJ2Xs
 efMljHJOaDw9zzziz/3Lb1Gn9g==
X-Google-Smtp-Source: AGHT+IGq3RTL26DnbnJj0o92nln1M1kNdiRr9nbmXaeE5AanvN1Oxt+RzEUTYli7Zz9BR+TJsku0lg==
X-Received: by 2002:a05:6358:c12a:b0:142:d40a:82a9 with SMTP id
 fh42-20020a056358c12a00b00142d40a82a9mr6903848rwb.2.1695711515366; 
 Mon, 25 Sep 2023 23:58:35 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:6585:aea6:5002:a825])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a639242000000b0057825bd3448sm8758874pgn.51.2023.09.25.23.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 23:58:34 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v5 11/16] firmware: scmi: add a check against availability of
 protocols
Date: Tue, 26 Sep 2023 15:57:45 +0900
Message-Id: <20230926065750.734440-12-takahiro.akashi@linaro.org>
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
index b1a9c36310c1..6f585b96f740 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -38,6 +38,38 @@ static const struct error_code scmi_linux_errmap[] = {
 	{ .scmi = SCMI_PROTOCOL_ERROR, .errno = -EPROTO, },
 };
 
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
@@ -374,15 +406,18 @@ static int scmi_bind_protocols(struct udevice *dev)
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

