Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6473ECD6E54
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9CDC86E2F;
	Wed, 11 Oct 2023 12:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wKx/vE2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A6C186CFF; Wed, 11 Oct 2023 12:08:15 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 440D286D20
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-351610727adso3352085ab.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 03:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697018875; x=1697623675; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PumAqkPF3JV1thj0tBRnw6UxrxXN5hm1ojA9b+rWeFA=;
 b=wKx/vE2Fu+ZZCzKngJBjy1MlGmNMnprJMpKekZnx22wd5pBU6kZr6hH0lmxVbo0NJV
 ny9+9AV/QpIxgFCHpmYgep+T7NPsN127ZJTN3ozqpBVNI3Zp/q9ZEbxj8sjw9tJvQG4M
 xdRRWtqfypJ2vT1hXU6mg6b8hfq+srd0eueY+KHgvcJG1Np0R+gISgx93MZqc6IXhGh/
 wp8x3JGwFGd3o7Pb9Bvm8/NCzal2Wqip/+j+K8+1xtRb7dpAzq0qydjPKQey1OGlUoaT
 PrDQiWf7VViI7Jg1gNebNtUbnVJkC3xaeTRd5gr2ZkjnnycKPbmQy+Y9lPsKQbHN9zuQ
 bf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697018875; x=1697623675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PumAqkPF3JV1thj0tBRnw6UxrxXN5hm1ojA9b+rWeFA=;
 b=VLlBsZ0fV+nHZeSFaVEmQzwXrPV+aI/dazxPJmIuS3Me+ro3m9Ggkpe1Voq5C81TH1
 bdjldPZdqkZGe738imYzE7CW11dI/dpn2s+TlqmSp3z3YWkXcGuz0VD3zvBwxE4yVePn
 OBN0y922hQxCV5x7W+kdd36jpBGw0/21bt37iRi4SFzM+xuxcbxuRE1AZcGjG2mDXJv6
 d4kUIE2xfehgZ3jzFvQjFJiG6P1glOYdzWn4akv+oZ6vHeeQlsUUp0eIN1m/dgHlh9XD
 t8ZteW/k9bgkWRy8rdF/O57e6gNTvKH8zBaBJdBrux0XqrfsPmgDyZGFAnxnJf/mxGpL
 ipsQ==
X-Gm-Message-State: AOJu0Yw9/6XXhc9l0p5b8Zi4zIeY+e5olU3h0FXFGTgMY8qlyQBoNbYY
 zAcTQ1hQvlnOlz7OKXx/BfyWNA==
X-Google-Smtp-Source: AGHT+IFuffX8s/AMEUmt3cQR//iMXSop92PFnrMSdeVBSdYImM/YU3/XA2ttV/oJ/x46rCD//ESmgQ==
X-Received: by 2002:a05:6602:3a05:b0:792:6be4:3dcb with SMTP id
 by5-20020a0566023a0500b007926be43dcbmr21372237iob.2.1697018875523; 
 Wed, 11 Oct 2023 03:07:55 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:5c6c:b11a:476c:8ebb])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a62ee04000000b006889664aa6csm9663358pfi.5.2023.10.11.03.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:07:55 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v6 14/14] firmware: scmi: add a check against availability of
 protocols
Date: Wed, 11 Oct 2023 19:07:07 +0900
Message-Id: <20231011100707.1007417-15-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
References: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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

