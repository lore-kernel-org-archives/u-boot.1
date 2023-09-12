Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDF8CA0EC9
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 06:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E506186E2C;
	Tue, 12 Sep 2023 08:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B/oltpSi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3288086E22; Tue, 12 Sep 2023 08:21:28 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4844D86E20
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c3c4eafe95so2647885ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 23:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694499683; x=1695104483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mDeANqlcGmJwpgmbU2X16rPKMZ2AGafAub5KGnX2sKg=;
 b=B/oltpSiD3vH1wCCyDDp/XdWxJwWuL1TwvfqxDkpSz4SE5m2RVrDlPCOqB8Q/lGHB+
 myQMXDjKZ5a0MtLGAVsWun1+KgooYtn82tZfJkuRx4WtqI40/OdLoPwMigYOMSF0GLyS
 oNvBohM7y+MYwDHQnWS8RQcefmT1eMuRWJ/v2Ufs9W/WmHtSnKuSNORqkWMeoc2PaaFQ
 DIwERYDLj4HBptSf29Cb6U4/gFYmnVUAkxD0Mv80P0fiQpjt04kGkFp7S6IJ9FU7YUYv
 f8HhMFdd8GMyCwhbOsFGKM6dBHg7d4B2Wr11qvvYM3zsHMvkxGHHhL5/GTFTpgFtUBIc
 jT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694499683; x=1695104483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mDeANqlcGmJwpgmbU2X16rPKMZ2AGafAub5KGnX2sKg=;
 b=Bh9gpaAvrmPc5JicR8Z5oJnE3rm5hJ6wr3YEMMR6ClCCIw7i2zLnUseSVlK/h/zR1k
 wHzRYpBo5boF6oW01drrsWBZWYFduHJIU44pawiyEc99DFv3psKlqnVaGe00SYuM044B
 CtpeyMbKGYcWK5LCgWXXmYwi/p/RemIBh6iwK4NJv1N5KjvUbH1Zwczo8n+hTs2WmJ+g
 oxcEf9sAHaf3kYNkJn+dOBL4/7t5PCK1+ZHjN9sldgZXJ8UN6y6AG7l419zRZbcr0cvu
 Qlg+mvwE/N136oos9rjJN4cVNCIw/4rsEjo689QOHTpNrhnpjSgWIrm3MP5vbEf57Cym
 D90Q==
X-Gm-Message-State: AOJu0Yw4+9fYgBu/nLgVCuPLMoD8SZvIKOfHfsJVnNNdP04IbdmLD7E7
 g4JL47s0O/sNJuOOaQnTkzaymfBJEUHjQVbHE2oKew==
X-Google-Smtp-Source: AGHT+IHBh0tKAbOOIyy9g/tlxC6OWOb8w9yAjnys6+fnwynmRm8QJ2rWgqLY8BHVOHhmfjboUvRCIg==
X-Received: by 2002:a17:902:d4c3:b0:1c3:411c:9b98 with SMTP id
 o3-20020a170902d4c300b001c3411c9b98mr13679835plg.3.1694499683618; 
 Mon, 11 Sep 2023 23:21:23 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bf3d:658b:e9f7:3af5])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a170902eccf00b001bc2831e1a8sm7503970plh.80.2023.09.11.23.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:21:23 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v4 03/13] firmware: scmi: move scmi_bind_protocols() backward
Date: Tue, 12 Sep 2023 15:19:52 +0900
Message-Id: <20230912062002.57361-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912062002.57361-1-takahiro.akashi@linaro.org>
References: <20230912062002.57361-1-takahiro.akashi@linaro.org>
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
index 75744cb35d7c..0b97569eb1a0 100644
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
@@ -216,6 +157,65 @@ int devm_scmi_process_msg(struct udevice *dev, struct scmi_msg *msg)
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

