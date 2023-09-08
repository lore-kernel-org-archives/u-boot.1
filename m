Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCF4EB8FDE
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 02:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1448C8676C;
	Fri,  8 Sep 2023 04:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J7NHdeqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14EDE868D7; Fri,  8 Sep 2023 04:52:28 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE8AD86995
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 04:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-26fa19322b5so414889a91.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 19:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694141543; x=1694746343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUShx2iTkUy1YqhRliZ2KHnTEDC/P7z8JupwczPNw/U=;
 b=J7NHdeqZcNpxfsSFH1XJdg1Pj/SSoFmo9JShtLwnalaehEdl+blEMY2dELIr/WClHr
 Kelr2S2Fi/teGjbLk/QfcR97yZ5ZFvdCjVOyDW8EyiL6BIKfr0aQVpmb65ph8Q18xgc5
 StnljYuMO1MBiswHhTezMX+wbMRDbtvkUdSz8gi+kvaSbyMScMQyjNtJMz4Y+vwWLAt4
 9/vNG/IBhKp8fZ2a2UfDYg7bF0rcnnwVDz8BmZLBe6mRq53qyJcQ7XZqngOk2PHFkAaX
 aJ4N2YwqGfV0erLY5UTri3xUeuT7dDD3/fv6UK2w60AGa3rVsgX2FFvQ8TLKRYAQEYzn
 1KUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694141543; x=1694746343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUShx2iTkUy1YqhRliZ2KHnTEDC/P7z8JupwczPNw/U=;
 b=PYjmFobueM92P0nN8Yup5zXtC8M5P8XaYgO493UoGfQ2e2vcwEv15/GBC3Yl9sDO2i
 WQRRRH/jGJrDohuXXeLdAol8Ght998NMNsBtdn5RUJRNaEG+IVhgW+3Y4HjRxYGZoWgS
 0hpxUfoyQlaKdODQDUi+1b7mAEp5cg3Q8IeAzZgweShxKZb93t0W8fLvvCzcMdz0UmhA
 CtJtup+KIZB6F/77tBb8/YC6bq1Ek6/jYczp7+QkbR9E8qXsomPfGt0Dpct9BAbxEqqW
 3UiV5Cw8VTdYfZq+x8njjE94/HwzCTUxtmQoxwsphx3KJj05u75j5dxjXFILmDYWLnrs
 F4IA==
X-Gm-Message-State: AOJu0YxdDMbSGmOBLDAZjy7JswxyGFGvzutyjee7b5h9bO6liMIwaxB/
 bySR+ORGKOXhueUJRkxArhe36Q==
X-Google-Smtp-Source: AGHT+IE578v0HCUF6wUycp2Ss7XEYHUFMnWf1F8G3R1Hd9jlS0KE4blka+LM4m8nJSxIkNELH6/5FQ==
X-Received: by 2002:a17:902:ec8b:b0:1c0:cbaf:6939 with SMTP id
 x11-20020a170902ec8b00b001c0cbaf6939mr1444481plg.3.1694141543014; 
 Thu, 07 Sep 2023 19:52:23 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:2d89:7669:ac2d:f09e])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a170902e54900b001c0ce518e98sm417286plf.224.2023.09.07.19.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 19:52:22 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v3 03/13] firmware: scmi: move scmi_bind_protocols() backward
Date: Fri,  8 Sep 2023 11:51:28 +0900
Message-Id: <20230908025138.44405-4-takahiro.akashi@linaro.org>
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

Move the location of scmi_bind_protocols() backward for changes
in later patches.
There is no change in functionality.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 59 +++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index feb31809e715..94e54eeb066b 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -157,6 +157,65 @@ int devm_scmi_process_msg(struct udevice *dev, struct scmi_msg *msg)
 	return scmi_process_msg(protocol->parent, priv->channel, msg);
 }
 
+/*
+ * SCMI agent devices binds devices of various uclasses depeding on
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

