Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F013CD6E56
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1385686D0B;
	Wed, 11 Oct 2023 12:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HkxfjMHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD6F886591; Wed, 11 Oct 2023 12:08:05 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9384286591
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3af59a017a5so1172021b6e.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 03:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697018853; x=1697623653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCRhEiNZjXNhx0qdWTCaYuD1CA83EGtZrc+sEunGweE=;
 b=HkxfjMHMDdBLhBlta1fFmf4E0D8NjMvCPKBTVzzkXiFDkUB/DPW6C9mhHTQdtJIhYe
 B2IM4vWB2ND37yk+o++Ie5MR+qjouViPx4Hj4UKEaI0bzgGACw9pCxHv9Xm2T3H1eKkp
 h4r0tN+x1uA7FhlcAdsw502Ce1MXVBG5zulWvTI37GdUoQRiNl5pqTHE5/fvga+uI4Ar
 mrEtJ/4I5AyCtZi016rIKHiYyB6c6S1EKtoOd5lub+GIBc2E3WsJdM1pmWnY+OBN/WcD
 aedzt7JC/NR1mXuAAtph12c8Bp5+wSuytSKwwANZRnN6Eu6Gu0cPmmhR4Va9UHWufecT
 lJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697018853; x=1697623653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pCRhEiNZjXNhx0qdWTCaYuD1CA83EGtZrc+sEunGweE=;
 b=cY4j+hfjQvgY82/bZXXbN/i9SKdDUFP4wbzSjZTZp9rUugqbyWBAMEYHeDH24GgMqk
 l+MFtQg2T0MMg61H/cFUpw6+0OrLDrBIUoKsjFGnVStg2RXrjMpM45BuTGtF8/Ct0BNg
 5iITBs/CVai/RLj3BiPij9szg/QXSGr5cZs1nQf/kPYlW1lvrpwh8wwxH7tUw8zBDCx8
 0k1cJ79My5P/UPwYEL29KiLFJVbc7lGxhHZqP3i5TpEKEhuEGeYmBQt3mHZdfiWfKCsB
 ATrP6i3OYqJrKGAiAQB2nFz/XgFPV8SNd5BiR4rSalokmS6XwmGeKvSLqw7ThbkMLvbp
 BZVw==
X-Gm-Message-State: AOJu0YxnsGBB0HjbQoy1QjcRAggQlkEA7sFMRJG5OjhGt3DhgSgq7kIG
 NtnQHUAWZa7OKqSpZjNhMRAm3g==
X-Google-Smtp-Source: AGHT+IGwhs5qZu24b/P0zHAP0n471Ob6Lr4BXTj+/+c99K/HDwbjxUN971VNYE362yfE4tWA0yP/ZQ==
X-Received: by 2002:a05:6358:e908:b0:147:47f2:2d54 with SMTP id
 gk8-20020a056358e90800b0014747f22d54mr16670058rwb.0.1697018853124; 
 Wed, 11 Oct 2023 03:07:33 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:5c6c:b11a:476c:8ebb])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a62ee04000000b006889664aa6csm9663358pfi.5.2023.10.11.03.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:07:32 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v6 04/14] firmware: scmi: move scmi_bind_protocols() backward
Date: Wed, 11 Oct 2023 19:06:57 +0900
Message-Id: <20231011100707.1007417-5-takahiro.akashi@linaro.org>
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

Move the location of scmi_bind_protocols() backward for changes
in later patches.
There is no change in functionality.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
v4
* remove scmi_bind_protocols() from the original place. See patch#1
* s/depeding/depending/
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 118 +++++++++++-----------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index a28692f39f4d..1fa1e9eef966 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -52,65 +52,6 @@ int scmi_to_linux_errno(s32 scmi_code)
 	return -EPROTO;
 }
 
-/*
- * SCMI agent devices binds devices of various uclasses depeding on
- * the FDT description. scmi_bind_protocol() is a generic bind sequence
- * called by the uclass at bind stage, that is uclass post_bind.
- */
-static int scmi_bind_protocols(struct udevice *dev)
-{
-	int ret = 0;
-	ofnode node;
-	const char *name;
-
-	dev_for_each_subnode(node, dev) {
-		struct driver *drv = NULL;
-		u32 protocol_id;
-
-		if (!ofnode_is_enabled(node))
-			continue;
-
-		if (ofnode_read_u32(node, "reg", &protocol_id))
-			continue;
-
-		name = ofnode_get_name(node);
-		switch (protocol_id) {
-		case SCMI_PROTOCOL_ID_CLOCK:
-			if (CONFIG_IS_ENABLED(CLK_SCMI))
-				drv = DM_DRIVER_GET(scmi_clock);
-			break;
-		case SCMI_PROTOCOL_ID_RESET_DOMAIN:
-			if (IS_ENABLED(CONFIG_RESET_SCMI))
-				drv = DM_DRIVER_GET(scmi_reset_domain);
-			break;
-		case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
-			if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)) {
-				node = ofnode_find_subnode(node, "regulators");
-				if (!ofnode_valid(node)) {
-					dev_err(dev, "no regulators node\n");
-					return -ENXIO;
-				}
-				drv = DM_DRIVER_GET(scmi_voltage_domain);
-			}
-			break;
-		default:
-			break;
-		}
-
-		if (!drv) {
-			dev_dbg(dev, "Ignore unsupported SCMI protocol %#x\n",
-				protocol_id);
-			continue;
-		}
-
-		ret = device_bind(dev, drv, name, NULL, node, NULL);
-		if (ret)
-			break;
-	}
-
-	return ret;
-}
-
 static struct udevice *find_scmi_protocol_device(struct udevice *dev)
 {
 	struct udevice *parent = NULL, *protocol;
@@ -217,6 +158,65 @@ int devm_scmi_process_msg(struct udevice *dev, struct scmi_msg *msg)
 	return scmi_process_msg(protocol->parent, priv->channel, msg);
 }
 
+/*
+ * SCMI agent devices binds devices of various uclasses depending on
+ * the FDT description. scmi_bind_protocol() is a generic bind sequence
+ * called by the uclass at bind stage, that is uclass post_bind.
+ */
+static int scmi_bind_protocols(struct udevice *dev)
+{
+	int ret = 0;
+	ofnode node;
+	const char *name;
+
+	dev_for_each_subnode(node, dev) {
+		struct driver *drv = NULL;
+		u32 protocol_id;
+
+		if (!ofnode_is_enabled(node))
+			continue;
+
+		if (ofnode_read_u32(node, "reg", &protocol_id))
+			continue;
+
+		name = ofnode_get_name(node);
+		switch (protocol_id) {
+		case SCMI_PROTOCOL_ID_CLOCK:
+			if (CONFIG_IS_ENABLED(CLK_SCMI))
+				drv = DM_DRIVER_GET(scmi_clock);
+			break;
+		case SCMI_PROTOCOL_ID_RESET_DOMAIN:
+			if (IS_ENABLED(CONFIG_RESET_SCMI))
+				drv = DM_DRIVER_GET(scmi_reset_domain);
+			break;
+		case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
+			if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)) {
+				node = ofnode_find_subnode(node, "regulators");
+				if (!ofnode_valid(node)) {
+					dev_err(dev, "no regulators node\n");
+					return -ENXIO;
+				}
+				drv = DM_DRIVER_GET(scmi_voltage_domain);
+			}
+			break;
+		default:
+			break;
+		}
+
+		if (!drv) {
+			dev_dbg(dev, "Ignore unsupported SCMI protocol %#x\n",
+				protocol_id);
+			continue;
+		}
+
+		ret = device_bind(dev, drv, name, NULL, node, NULL);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 UCLASS_DRIVER(scmi_agent) = {
 	.id		= UCLASS_SCMI_AGENT,
 	.name		= "scmi_agent",
-- 
2.34.1

