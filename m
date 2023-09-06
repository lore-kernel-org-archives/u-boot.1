Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9CFEB8FAD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 02:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D85108667A;
	Wed,  6 Sep 2023 04:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KlVdTSS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1CD286667; Wed,  6 Sep 2023 04:41:03 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1034586591
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 04:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68cc1b70e05so607869b3a.1
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 19:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693968059; x=1694572859; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efrPIYuVGbqbaZHIcWjhNXthVhwrIIYknB2a7MQG9ew=;
 b=KlVdTSS1wD7AfajaGrPHv6eEtFUZOqEbv3hHQfbCSlHzbt/a2dV+WQlywAaL5AYgtG
 JS17RT4XgJhpsUBNXRCc1dniuL4EGnXrqVp+/bnEkuFlsNqj1ZDFxBjkU/kWKJ8AHojv
 cm+F/DhuS653DJ+vloetcsrTaTuqv7NPnVICe1061xg0WNVZdpTmhXpnv60tCXnL+jX5
 NSGCsyZCTF1U6W3x47Lsq0tYaFNku2ZMslAbZ9gt9srG+t4WCleoPRm7Dae6X4+iWOhI
 D3lhlrecFs8BtVX3+99GOaqaZrrI8cSrpLyyJduI7ixynQ9UsB1PMD1DTHJS8yRrsDAi
 DJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693968059; x=1694572859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=efrPIYuVGbqbaZHIcWjhNXthVhwrIIYknB2a7MQG9ew=;
 b=BPLDg+kvdlXOeD9iDU4lUURgzaJowUffq53UBKyeCfHo1zD0OWdEpDzqFY+7h+SZUq
 mqRxraTo3J5GNFX//dEHtnHjE+5868hgNarPeHUmBTGrMlPfjaKXkPwO0jMKpXSm66WJ
 /YtLih5dYPS79CEY4xt2JF6FSVCojqEnsvs+ZSay7RpwDv4Ix0HLfQfUUvb5XdFCnU9u
 FACmOLBpb4w7HJegEWQ5w6H5yQGVW7NfXoNH6T9AFNjyEFvVT5A4C6UIva3kxGAhfE8Z
 1jowlKRh091kpJSo7QFdn6cltpJvi1QCOVeCRZBfwLgZgkjEg7nzVXkpo/EjFZsHsNdC
 Hcrw==
X-Gm-Message-State: AOJu0Yw6a/UI/0QLi9s+iVwtK2aZ5DtZyq04LKl5rVeDIIHgQlp2fQBs
 kcRfyPp/pbWKy6JNLBCAe/7bNZ3YWeMzhf/+YG9+vg==
X-Google-Smtp-Source: AGHT+IExkvbfiXn8jnNW7qF4h7E6TsAnPKNaMykUXsDaXH6yXaAqKk/nO9ICKVL1UquLxfh2TNrfaQ==
X-Received: by 2002:a05:6a20:8f15:b0:13d:7aa3:aa6c with SMTP id
 b21-20020a056a208f1500b0013d7aa3aa6cmr19774235pzk.0.1693968059271; 
 Tue, 05 Sep 2023 19:40:59 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:8294:a07d:b7e9:4033])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a6566c5000000b0056428865aadsm9145378pgw.82.2023.09.05.19.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 19:40:58 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: u-boot@lists.denx.de
Cc: etienne.carriere@st.com, michal.simek@amd.com, sjg@chromium.org,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 1/6] firmware: scmi: fix protocol enumeration logic
Date: Wed,  6 Sep 2023 11:40:06 +0900
Message-Id: <20230906024011.17488-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906024011.17488-1-takahiro.akashi@linaro.org>
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
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

The original logic in enumerating all the protocols accidentally
modifies a *loop* variable, node, at Voltage domain protocol.
So subsequent protocol nodes in a device tree won't be detected.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 46a2933d51a4..79584c00a066 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -422,8 +422,11 @@ static int scmi_bind_protocols(struct udevice *dev)
 		case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 			if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI) &&
 			    scmi_protocol_is_supported(dev, protocol_id)) {
-				node = ofnode_find_subnode(node, "regulators");
-				if (!ofnode_valid(node)) {
+				ofnode sub_node;
+
+				sub_node = ofnode_find_subnode(node,
+							       "regulators");
+				if (!ofnode_valid(sub_node)) {
 					dev_err(dev, "no regulators node\n");
 					return -ENXIO;
 				}
-- 
2.34.1

