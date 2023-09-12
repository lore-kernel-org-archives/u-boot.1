Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B2DCA0EC9
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 06:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 990F886E52;
	Tue, 12 Sep 2023 08:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ue2RS7kl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22F8786E47; Tue, 12 Sep 2023 08:21:38 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4392486E45
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c3c4eafe95so2648175ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 23:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694499693; x=1695104493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uOTPtjDHaxMMIH1M0rWFgNfGU24g7rDWYSO2jB2NRIY=;
 b=Ue2RS7klhqRAxnGP0Kqou0x6Ian1M9Ffi2npWW8kbXuv03b8NQh4L8gJWvEWX+3BYx
 Vlc0H6yYjI/zJ3JKE9ws7oatAOc16R5eKXyvDka5cJWtylMH9/q+q5gn7sfqCXwTX6xf
 BGrWESGPRxdBWcfhi8YpUxL6/8cGnW4gJO9BOOXtmTihTGm6N/eoyRclOY6swEw+v75i
 VJvdTBNTBeMhOONPCoYJLwmtRuf9whTMWshTG+/GA+kX482NymnW9DgENQbyO0j5m/pE
 VZvf/z8RrDbgrV+VSF1G+q66W4n/l/oN9+gPKL4lglJH3UHUcbQrh5ihf8XB7zlwq292
 50JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694499693; x=1695104493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uOTPtjDHaxMMIH1M0rWFgNfGU24g7rDWYSO2jB2NRIY=;
 b=DW6R/ZFwVEdyqgWNK1KiM+5ItOOEFAWhcsJwk2NcfLhoUr6h7PGmmmE+6qK9+a+Ep5
 GHgAJqdkO6o0wP04CHWQun1Cph9Fi0RDHdvTZq/N5E9s+2Y3bUK17HWhlik/Xyrk1eAJ
 dmQba8pCydYIcHAcmJcr6Kki2Sy/ji+uInbX/aJjZPzYe8dRT26nBd/j9dl8iaxEOuvz
 POvYO7HhzXIM5l7YTT11tO04JcRRokYBzhJZRc0KIWAS1lwW3EPcX7okKj0z6mIzaklM
 LY+k0hk6gusArITH7yjTm5ONWgzRY+ns2CTwksvGHtEgQ5XYT091xlW5FYYEe+QYOJjm
 TqAQ==
X-Gm-Message-State: AOJu0YzHsKJ6zAaZJQzur+8BN8nl082cOoYSUTaQmH210gRYQZvY+b0P
 wBzF4uaNLi/iqPUY1hVMBeTTdQ==
X-Google-Smtp-Source: AGHT+IEdCkJCuBDLJ5CGQCIJvrXiSU7Fqb7sz2/TRAvjrgJHefPssgoI6bE1LinwersssARWO7RQ/g==
X-Received: by 2002:a17:903:2843:b0:1c3:a4f2:7cc1 with SMTP id
 kq3-20020a170903284300b001c3a4f27cc1mr7883022plb.5.1694499693496; 
 Mon, 11 Sep 2023 23:21:33 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bf3d:658b:e9f7:3af5])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a170902eccf00b001bc2831e1a8sm7503970plh.80.2023.09.11.23.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:21:33 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v4 08/13] firmware: scmi: add a check against availability of
 protocols
Date: Tue, 12 Sep 2023 15:19:57 +0900
Message-Id: <20230912062002.57361-9-takahiro.akashi@linaro.org>
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
index cd72345b8e54..b83cb0f5d0bc 100644
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
@@ -373,15 +405,18 @@ static int scmi_bind_protocols(struct udevice *dev)
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

